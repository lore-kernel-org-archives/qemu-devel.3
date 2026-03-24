Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0E0F532D0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ttD-0001wC-7w; Tue, 24 Mar 2026 01:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4tt9-0001vu-2i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:01:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4tt6-0004jl-SB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:01:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so1069166f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 22:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774328467; x=1774933267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qf24kPvtfF2FeuNfcRqvJ0/FPzqobMnJksOBjxjq+0=;
 b=l3mcgZLs4Q0Y9GB2ud2a0HzjaNVuALmC9Pgc8sOgBOYzkVw9Va0DK3fvTwsVFcC5xN
 FiRVmFITln0gPoY0dupRGwStwSeREoBFMYSlFRchUAWIbC+5FUZOMz6Dh923C/bG7GQ+
 CYA0bK57nBuiAgwiF3+XXvuJ2KxjlAtq02+VKK8/85nhasXz0SCBbdTfYN5NYwmkxIR1
 3DLUMBNXC/bSujL0Pr87Tp/q52pvY74f/JT7OfvtK2/gJJkdzevKzzcNXQEZqwrWcrfZ
 sNzrMp8DBUft7PZqAZce4wQJ7CAb7jI9HlIHq51xu7fUL5in3INDMEPVH7tqpYGF5Wkp
 1ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774328467; x=1774933267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qf24kPvtfF2FeuNfcRqvJ0/FPzqobMnJksOBjxjq+0=;
 b=XXHXj5RaDflVfEegMK6hqKuUNSfZs8+jtXCt7vyvH+ageJBqwMmX2TtTR3/0EUjf7a
 rYOUBbBy5xtQhqWYqvNsn2Q6dhjN3tf6bBO677qsgBwLtVdh+5uvcPL221qLg0XMhyKV
 2U9UAsRvVt922e5K3Qbf+tUJ9mz0UDBTn9gkeXqmqtv/qOqAKknST/OCqzh4pTlNl57i
 LPL6pXDP/hWURR+Zt7M5kABRIoI8CmzxOvWJEV04HWCHhL0/ICZ5AU/+zUKsF5hHYt0V
 LQ0CXwaSa3WHOV9AhR3zgLQArLEmBuYyqWdwrVPVpCFPcFJvamCXNLgroa8p7zFK6zxi
 BLXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxlfZCU2S8ocNu2WDAq8EGiAo3PVH2E4rN2dB0vv/RnZp71v5gQl3dRaADZJeGedZb15yfQ3mvf9Wj@nongnu.org
X-Gm-Message-State: AOJu0YyOaTATDx8jIGAphif36RazutV10KXqbCczJkXJzmhhxtGrM0MB
 gt2UMvzLFTVClMR0j/5GWx2pi3vzMqTu7nDLLnCqGNnLYPkuslR9KBP6ohBaJZs88fIdtnSsPjv
 tNYB/E7o=
X-Gm-Gg: ATEYQzxcVKrm5KgaeVFomHWnS6g0nX9a9hP8IILlOLoNw2nkUfdSDIevsVVichGStmX
 7qPlRPGZYDGneaVi098md6IwuM5S5siBaIaBdi+PaUgjJyH/YDvta0QdEmJz4LzgrZoKV/BTPDH
 yklMDHZDALSTrN2KaLaa5pYkgf0YNkOZBSfB2dF09WAZqE848ra1JdDY1YbjPdjkuVfGCBTxjiw
 sMg9Fri6YfuRUTLu9NmQsopkxzMKqNEYzUPSojtIauHnGmNf213jj9JxpbK4vYFwUfJDK0ZlhhA
 8mfHyVGR5+J0SS67UXL8vUHSt7HWeMht6f1t70GIZZLiG53dRsxxBvmB3GgZzVfS/TA/0lT5OTV
 TG89QU49jtXgGfpjJuNZMor31C6XXekNejdnUipElkKHVYTn+kCyfunEbAD75uD2pTISUi5q3AM
 GfpFB6VvSwmFZGrdeySdO8/FqEvCKRMmZi5dN2ewHBsawCGmR2z4nqAD9YG8l0j4R5OQ==
X-Received: by 2002:a05:600c:35c4:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-486fee31e63mr228349915e9.28.1774328467260; 
 Mon, 23 Mar 2026 22:01:07 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487113c4eb3sm25591515e9.0.2026.03.23.22.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 22:01:06 -0700 (PDT)
Message-ID: <c935883f-66d1-42fd-bb19-9c0b59c9493e@linaro.org>
Date: Tue, 24 Mar 2026 06:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] qapi: Remove deprecated
 SchemaInfoEnumMember::values field
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>
References: <20260323152124.93051-1-philmd@linaro.org>
 <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/3/26 04:19, Pierrick Bouvier wrote:
> On 3/23/26 8:21 AM, Philippe Mathieu-Daudé wrote:
>> SchemaInfoEnumMember::values field has been deprecated for
>> more than 5 years (see commit 75ecee72625 "qapi: Enable enum
>> member introspection to show more than name"), it should be
>> safe enough to remove.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst       |  6 ------
>>   docs/about/removed-features.rst |  7 +++++++
>>   qapi/introspect.json            | 12 +-----------
>>   scripts/qapi/introspect.py      |  3 +--
>>   4 files changed, 9 insertions(+), 19 deletions(-)
>>
> 
> By curiosity, is this patch goal is simply to remove a deprecated 
> feature/code, or does it unlock something beyond it?
> No judgment here, that's a genuine question, and both are valid reasons!

In a previous thread Daniel said past deprecation period, feature
must be removed, otherwise undeprecated and re-introduced. I'm just
trying to be consistent with the deprecation process, removing what
doesn't seem worth to re-introduce (for the code I'm able to figure
out at least).

Maybe we should clarify the deprecation process, clarifying that,
and mentioning that maintainers sending pull request to commit
patches with deprecations are also a commitment to remove code
when the proper released is out.

> Looks good to me, to the limit of my qapi knowledge :).
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

