Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE33C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seryF-0000gL-DF; Fri, 16 Aug 2024 04:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seryA-0000eH-6Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:05:58 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sery8-0001eD-4w
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:05:57 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7bcf8077742so1373547a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723795554; x=1724400354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rw9ePaDya0qyymeJo9ZI/98ZBpOr+jOE9XpSLIiFpP4=;
 b=fchioTRkk653oBR9KbnuBa3aOrSh969vkRdHB/op1/ZGt0O/g6aKn1XHS3s+lJWcJn
 BeRMqQAETo5reOKngRZGJx7TDxOh4jZpnacEd0PurN+FPSxoRPNYUirANjimaFw9uMUs
 ej482mxax1jkW+6XJje1L742z7qsayo1fNXE/W//D1vxbs988XXpQOIoIul3UwHZInl2
 vMTewwx2tyOde5q5Q/bBZ0iaq6kqK9Gsemd6ay9PDHMpk8nnksJPp6TNlBTIzYBR6hdQ
 f5T31hjfsiAyQbHzCOLwDkykhQ+uiR409Vt+UJlsmVw5KtNcC5Mmf/pxFx9aYwp0PI5C
 3eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795554; x=1724400354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rw9ePaDya0qyymeJo9ZI/98ZBpOr+jOE9XpSLIiFpP4=;
 b=Rgdaw+xDYcSxR/J0/2BMU5TCwaniyA2TzgzyYFZItjXboQH9mTXC2rMoqWjxDhQRCI
 igVbeJH0pnAAHrYKErtrxCfckMgfeFrFNyGU5v714TAgY+3qA4DI96agpLREvoKn7r1f
 Y8JKIECg4R/w7rysXZPJVI5WjBlWYBTTe/tLKnlo7FOiRNU/vlJWYkRw1PVVJyGg8ELB
 QDNpTkcbpnJrwSPuQSOo+UdLFd2orxdeWE/mHzjSTXJHRdAZdkmf+0UJZyGRGH8VNVwS
 8kI3J3UIThsy8HKJp4yhaktbYXcw2Mm4ceOpgdz8K4QOTyQHX4u/8BL8Cnoxej1gvIEz
 KRDQ==
X-Gm-Message-State: AOJu0Yw6yS8uPx9uYBEjCZfmlW+d+Mq966XCPl0r6aB2CeN5zKCG4VF/
 kSCqSOGMdjcfd3zRS4iW6+wdSHIuiD1nNzciz6L536Qt9IFkaOL8p8Ec3awlY2F/h49XbtPuiTT
 1v9I=
X-Google-Smtp-Source: AGHT+IHo4Djn9K9McGNgLtrproull4l1StasibBu19yVAzuVzI5FiCybJyzksgO43tEtrS/OkZ78cw==
X-Received: by 2002:a17:90a:c718:b0:2d3:b357:7859 with SMTP id
 98e67ed59e1d1-2d3dffc5ccbmr2548406a91.13.1723795553973; 
 Fri, 16 Aug 2024 01:05:53 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm1188816a91.4.2024.08.16.01.05.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:05:53 -0700 (PDT)
Message-ID: <9c457043-7de0-4c92-8ca1-fca5fa9addd7@linaro.org>
Date: Fri, 16 Aug 2024 18:05:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: qemu-devel@nongnu.org
References: <20240816-function-v3-1-32ff225e550e@daynix.com>
 <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
 <337e647e-3edf-475c-8e37-de3d28b30340@daynix.com>
 <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/16/24 17:27, Thomas Huth wrote:
> On 16/08/2024 09.12, Akihiko Odaki wrote:
>> On 2024/08/16 16:03, Thomas Huth wrote:
>>> On 16/08/2024 08.22, Akihiko Odaki wrote:
>>>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>>>> -fno-sanitize=function in the clang-system job") adds
>>>> -fno-sanitize=function for the CI but doesn't add the flag in the
>>>> other context. Add it to meson.build for such. It is not removed from
>>>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
>>>> does not affect --extra-cflags due to argument ordering.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>> Changes in v3:
>>>> - I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
>>>>    but only updated the message. v3 fixes this. (Thomas Huth)
>>>> - Link to v2: https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com
>>>>
>>>> Changes in v2:
>>>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>>>> - Link to v1: https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
>>>> ---
>>>>   meson.build | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 5613b62a4f42..a4169c572ba9 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>>>   endif
>>>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>>>> +qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
>>>
>>> As I mentioned in my last mail: I think it would make sense to move this at the end of 
>>> the "if get_option('tsan')" block in meson.build, since this apparently only fixes the 
>>> use of "--enable-sanitizers", and cannot fix the "--extra-cflags" that a user might 
>>> have specified?
>>
>> Sorry, I missed it. It cannot fix --extra-cflags, but it should be able to fix compiler 
>> flags specified by compiler distributor.
> 
> Oh, you mean that there are distros that enable -fsanitize=function by default? Can you 
> name one? If so, I think that information should go into the patch description...?

AFAICS, -fsanitize=function is enabled by -fsanitize=undefined.

Anyway, see also

https://lore.kernel.org/qemu-devel/20240813095216.306555-1-richard.henderson@linaro.org/


r~

