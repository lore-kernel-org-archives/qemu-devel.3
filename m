Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF708C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 10:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbeAp-0002u7-9S; Sun, 18 Feb 2024 05:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbeAm-0002tq-DK
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:13:24 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbeAj-000748-Th
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:13:23 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2997a9f4d61so309368a91.3
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708251199; x=1708855999;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6hE+N3DPJ/o3BHTZA8TO1I0uJia26LDm3iMBm6whyA=;
 b=V3eu+hMEOWd8yzfU5bHhfy9eyZ2k5sr6IO/wWa/jOzaFCWiH42VydtAwJ1qIxMk3Cc
 IUPL06lvDXHqz3/vO16iavQZTIX31OXO3MO5LKYsO5X9/x2ryqyGnP1CiRznM9i2z7Ak
 xKQKcbdU8hk36vlaByzrr4L25xAFIXp47B+pYqARgmfT4nS/r51inurxjPPz4Zr6wCET
 dBo2p2W77qqmf922h9wEmNzTQPQrQbNsrcXwdvn60krIopcRzSTMBUfk8TnT7Uhej+f/
 uzR3nOMFJCoQUq6byk0uWT+moPzXC6+YfTIuEDQf6pdEE/b2LzZNIIboeZAyIrIKYf9a
 OeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708251199; x=1708855999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6hE+N3DPJ/o3BHTZA8TO1I0uJia26LDm3iMBm6whyA=;
 b=rQ91kkpYynlVEkL1TyD9Bg/aw8l+OZpDySaC3kI56o+qPZsx6GOz1HOOIxqTPmTJHD
 EO6zPeh94pWwmECqZrFvKO11RyLHpS2z+f4A2lapN2ybA7SXaqFMadSH2Qv8pj7ZdV8f
 dlcOEW+8JIcoeBS4l9MsTWxh7BLM/RBOPVI0JdulBsZssf/WwgYK1OHnSHg4dqlgdnMg
 +NLY9ITWe5VJns+lEkpbab069BfzUTilUTeTYW7BrfFhbHsxAfbAZY7COVbCFM5L6xbs
 SnJsF5KXQZwjHRkVCsG6nhB9GmTA/kvHLR9AE0TqpXjzfoTP5tEaPh7QmsbhlxairEz+
 t7PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrHymMhG7Y54HBEGEWjpe76Wo4/omJH2qMAvQVJ4xHmZXFJg/EuQnYuX0VOgTioHbXHGlv0yqVaF2IbQnIug2Q+5lUkf0=
X-Gm-Message-State: AOJu0YyZgyK0EwKqo/dJu40UQZver3arKXRoQCs+UmkpEB0u3PS5OXJA
 Nz0+3cR4U/NP4E3L2vPefq3wf7mf4zN2IRg23cckbZAHss4L/MH4+Y2aRXi5ucI=
X-Google-Smtp-Source: AGHT+IHGdrOoIjVw5tybXRBqlGOqSIf5MJBNZtT7XVKe7uu7CNncmwcJPIcTABSAvyRLfcVEvFVyqg==
X-Received: by 2002:a17:90a:8008:b0:299:4fa7:71a7 with SMTP id
 b8-20020a17090a800800b002994fa771a7mr2484793pjn.24.1708251199245; 
 Sun, 18 Feb 2024 02:13:19 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a17090ad59700b00299305fc9c8sm3017692pju.49.2024.02.18.02.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Feb 2024 02:13:18 -0800 (PST)
Message-ID: <29c1269b-1b7b-4154-ac26-c087f83e21fd@daynix.com>
Date: Sun, 18 Feb 2024 19:13:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vl: Print display options for -display help
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231216-help-v3-1-d51db92740d0@daynix.com>
 <4e007fd4-294e-4969-80a3-2508a518cea8@daynix.com>
 <8d9692b5-b0b3-c98e-0681-9043ad7d533e@eik.bme.hu>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8d9692b5-b0b3-c98e-0681-9043ad7d533e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/18 19:11, BALATON Zoltan wrote:
> On Sun, 18 Feb 2024, Akihiko Odaki wrote:
>> Hi Marc-André, Paolo,
>>
>> This patch has Reviewed-by: and Tested-by: but not pulled yet. Can 
>> either of you pull this?
> 
> I think we dropped this because it's not consistent with the other help 
> options such as -cpu help -device help that print the available options. 
> What we need instead is e.g. -display cocoa,help to print help about the 
> specific ui backend which isn't what this patch does so it's not the 
> right way. To do that however we probably need an expert on options and 
> QOM because it does not seem easy to add such option. Therefore I don't 
> ask you to do that instead but this patch is also not what I wanted.

I see. Please dismiss this patch.

Regards,
Akihiko Odaki

> 
> Regards.
> BALATON Zoltan
> 
>> Regards,
>> Akihiko Odaki
>>
>> On 2023/12/16 17:03, Akihiko Odaki wrote:
>>> -display lists display backends, but does not tell their options.
>>> Use the help messages from qemu-options.def, which include the list of
>>> options.
>>>
>>> Note that this change also has an unfortunate side effect that it will
>>> no longer tell what UI modules are actually available.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Changes in v3:
>>> - Dropped qapi/qapi-commands-ui.h inclusion. (Philippe Mathieu-Daudé)
>>> - Link to v2: 
>>> https://lore.kernel.org/r/20231215-help-v2-1-3d39b58af520@daynix.com
>>>
>>> Changes in v2:
>>> - Noted that it no longer tells the availability of UI modules.
>>>    (Marc-André Lureau)
>>> - Link to v1: 
>>> https://lore.kernel.org/r/20231214-help-v1-1-23823ac5a023@daynix.com
>>> ---
>>>   include/ui/console.h |  1 -
>>>   system/vl.c          | 11 ++++++-----
>>>   ui/console.c         | 21 ---------------------
>>>   3 files changed, 6 insertions(+), 27 deletions(-)

