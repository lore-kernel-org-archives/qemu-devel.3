Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C73DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 06:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzUgj-0007mp-3S; Fri, 19 Sep 2025 02:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzUgg-0007mL-5s
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 02:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzUgZ-000092-U1
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 02:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758263611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cP+HMX+waH6JJSIV1cm25cTmWGrP+cpXZi/vENVzDYc=;
 b=HGMBDjEEfq5GejRVuZzY0v6h1OpzwxaflpDcVcDtRNJPjl/gBXYcWaf3OixQPlMmCOU+4d
 2JiRPR1mtCdaXIoldeR8ihNEXALzl8tyeeQem151TKx3rbMk5ZqIo7CjzgnHS1yMYT8fSo
 O6uKnScYXlbKeZKEYH+KcimAG8VIsSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-qv81A_yFNaKrPAlkSGDdwA-1; Fri, 19 Sep 2025 02:33:29 -0400
X-MC-Unique: qv81A_yFNaKrPAlkSGDdwA-1
X-Mimecast-MFC-AGG-ID: qv81A_yFNaKrPAlkSGDdwA_1758263608
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd66e1971so15380165e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 23:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758263608; x=1758868408;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cP+HMX+waH6JJSIV1cm25cTmWGrP+cpXZi/vENVzDYc=;
 b=AqGVbjzH2qbUVble10vKOrp1Lq+Yq9Fh0OO73K4xxKAy6jGXG8SauLv+O+lJ/XnZ7G
 yxsT8VeDzT13JvGoMj2jOKEwZZfBHdfpF76QJwcCycD9JacUABnbC0VTHRqmNi98WIFy
 3al8YYSFkt8OsXdbHeblg7E/oIDED8LpNU+WhVATsojF0j1hil11v2We5Zfvk5Oa/UAV
 KDJ0m6csUijU4br7ailB8CXuN4pIENAudfU5jgTS4iQCRfLXVnOR4vLrwcetsiJ4EV7l
 GGdLMU99J9c8Ce6eALvjk7Y2VxhjsGrNc7bGNFnzoEmQcHA1lRuLgWpU0ubAQZwjMhfn
 R+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62z2hbjiSiCN7G7six6ryhj7vtBTNLTzoCUsk7Sm1Apk740uwcYkmq2jvpFAitJmW09viu2RYSEob@nongnu.org
X-Gm-Message-State: AOJu0Yx9PxKndQbaowIqm0iIBN7OMBOoqO6KmwAvqD9LRC70feHs0m+d
 UQUW3qN3YRWByTsDpW3AdNHUJ584SSHV839sgEIF4mIkaO9JBjDROXm5HZRwSbUMYT4/m86IUKv
 Hy2YSwDP2/UOw7+Ekvb+Dwjhm4uRjY2Pwo/eMV7/CDhCPIODvOS4YCkRo
X-Gm-Gg: ASbGncvE4uIJezCCtwpl3aEvLJi02o7wUig+WInLm2HCj3EDj5VVBlYNh00Q8T9fbWc
 MaNs0inrn/ZRmjbKIHeMPhA7quvA6X9+DSsgQJJxhbwu3BFcmu8suWSgBzfDd/Q0vwbhtISmuNy
 OydBa1tUMoZ35B3szBXlCyuia2D8EzBfpNRJkec/UQ0ga9Z4/zqsuvVgnrJXRbj1GHulLFvPLVR
 dZ6HpxTGSAofdUkAiLKGoWDpdGJT0ZhzTkyeewLx2XrnHGZ1zwufde2PIzJn6I+9lulZobG/sun
 PNHOPAcSe3U5DTcuA61dYefEq31orVq0p4ltL/z4SKClmPjdW3U6S3RtbUyg71pujgozivfnLh7
 7ydc7MA==
X-Received: by 2002:a05:600c:a47:b0:45d:d86b:9e64 with SMTP id
 5b1f17b1804b1-467e78caa3emr14319865e9.15.1758263608108; 
 Thu, 18 Sep 2025 23:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9n22R4dSlL4hKyo98T3dP2ek7jVYsCni14Lb6s0+m8QBHdOAxCSjy/cimgFRYfxCvd5GrJw==
X-Received: by 2002:a05:600c:a47:b0:45d:d86b:9e64 with SMTP id
 5b1f17b1804b1-467e78caa3emr14319515e9.15.1758263607650; 
 Thu, 18 Sep 2025 23:33:27 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0aac439sm81179175e9.5.2025.09.18.23.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 23:33:27 -0700 (PDT)
Message-ID: <639603b9-6fa7-4316-a7c9-50fb29bdeb99@redhat.com>
Date: Fri, 19 Sep 2025 08:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/sdl2: fix reset scaling binding to be consistent with
 gtk
To: Nir Lichtman <nir@lichtman.org>, qemu-devel@nongnu.org, kraxel@redhat.com
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com
References: <20250910114929.GA1783677@lichtman.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250910114929.GA1783677@lichtman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/09/2025 13.49, Nir Lichtman wrote:
> Problem: Currently the reset scaling hotkey is inconsistent between SDL
> and GTK graphics modes.
> 
> Solution: Fix SDL to use MOD+0 instead of MOD+u which is in line with
> GTK and generally more consistent with other apps.
> 
> This is also related to my previously sent patch fixing the docs.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>   ui/sdl2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index b00e421..032dc14 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -421,7 +421,7 @@ static void handle_keydown(SDL_Event *ev)
>                   sdl_grab_end(scon);
>               }
>               break;
> -        case SDL_SCANCODE_U:
> +        case SDL_SCANCODE_0:
>               sdl2_window_resize(scon);
>               if (!scon->opengl) {
>                   /* re-create scon->texture */

Reviewed-by: Thomas Huth <thuth@redhat.com>


