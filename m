Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CCC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDP7-0002wA-M5; Tue, 06 May 2025 04:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDP6-0002vo-1w
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:11:52 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDP4-0002Ma-2N
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:11:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso840722766b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519108; x=1747123908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2mQ1cwRA8SyoG1wDqXR79JDRyq1Q99n6dkyg+uEfsw=;
 b=vBT9mFGuR5z6jqf8CeFwUyrjfCHvAPI4oCgabtqyOtQjYJ4awJTbOQIldZNGlI6iwd
 e1nmdfSd55dhPRhgssaIXJxOOkcYQPpZx2nWkYoWQuWuNR4KdM/Y7cm+u/cpLDsavBq8
 iVtAtktUFqKf8Kcf7DBSkYWbCRSvgLRaAUxvd6eZjilr6xCay65VBhFD+Ks7LayrF0DN
 LVD/9RkKIa5d6A6GLFrbzjoVs7R3Ww1BpMehDYlozZgmIJRpv4z/e8X/PsiHRhDgxPE8
 Pu1JmQtsOltr1qiY6ikFOqyks13pThIG7Cb38rcjspw+WW8i+3rgFYchWtoIEgELeTh8
 yrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519108; x=1747123908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2mQ1cwRA8SyoG1wDqXR79JDRyq1Q99n6dkyg+uEfsw=;
 b=PzwY93eEuckExbWNh5unLorU7QXebeG6QpB4SICjtTCCYA08bMQKXQJwcPbhMtYbcj
 VKlu99/JY0OOvzvlGL76y5dynUtYZR3S1IDLpPQvAP2jJeR56A+hBQj0HeVuz0JCugZc
 YRdf2Dz/iCu/I6Y/SuUtZZvLlB5qUxxzO18xAGgAEY1Kwc25ed+ZpR9+rQVzC+x9vnlF
 80qHv+IwOZ1fjZrRTwJ8fdRqEYrwDl5fEHtlfsN3LGB3MD00Chese3GjOK1HPGn4Mf1b
 UcALMNCyZkFLHdW0lUPtbZg0+twsQ0QXeYYlSDLbLUIxSip2OA2j2dYa0THUgSXgKpS0
 6nGw==
X-Gm-Message-State: AOJu0YyU6s0/d8BrjArboEhNbCCjsmmX17Lww8A64VyGkvBxBaE0zbl2
 4jLMp5z/Lo/b+rHmxzPTUSltoKUELVU5KqxBYiKqr/johvQNk2X4rRpuxC/ixlhL7GpYyB6J/vc
 goWU=
X-Gm-Gg: ASbGncsdIfL8pZS77p08CUy0YB1LJbxLK6gh6pvbjTlToAyC56moqKkfexpw4gcMwKt
 nDCbGE91Y48AWmMSxtg7z3OOSXrH6N2MMd6NshZuPM+JLfeaAN999GubXPriNvUHPUd/bIViIwg
 6ur2x81T4cxZE86lgDyhBDh20Ltgy8n2pENmHKELUZHKA6uGTX7o7M0TaTU7yhVmgH82akJ6Hjd
 c8ZI/3jom5NVAL2LJN8nxGp0SkrWp3JKzvvIhDMs3DB5GxTUAQ6uEP41VeEcNU/bFqIe+vLqV0J
 3Kw8b5QRDMJHYTvA8HHJISnLy1UjrWhMVLMihm/luFS5hDF2/3mXLMnTRDi+PX1UZf1eI3JbP7y
 Nca0=
X-Google-Smtp-Source: AGHT+IGVRrUfIy7XysX9Pw1ZxCJfnJhYU5NJvN360QA5krj8dsUihmsCM7pvk3ISKqWBlB72mTvyxw==
X-Received: by 2002:a17:907:7f8b:b0:acb:63a4:e8e5 with SMTP id
 a640c23a62f3a-ad1a48bc622mr983215966b.6.1746519108283; 
 Tue, 06 May 2025 01:11:48 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77b8fba2sm7238629a12.56.2025.05.06.01.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:11:47 -0700 (PDT)
Message-ID: <8850f0a0-3be9-4909-aa47-5932193ac1d1@linaro.org>
Date: Tue, 6 May 2025 10:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 2.11 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-2.11 machine is older than 6 years, so according
> to our machine support policy, it can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 25 -------------------------
>   1 file changed, 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


