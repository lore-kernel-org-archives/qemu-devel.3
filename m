Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB940C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaB2N-00056e-VN; Fri, 11 Jul 2025 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaB2M-00054u-Ow
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:31:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaB2K-0005VC-Lm
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:31:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1111554f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229881; x=1752834681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C1Z7EpQ03VjvO9kvsktGSJv6yXbrBXhvwHDJoTwCanE=;
 b=y1y/PsxBAWOD2RkMZTWIiR/twjfz6DWRQddor2GTFj5un2PMDF7/VtAupgu3D82QY4
 wwFbdC7P8kdFq4VeITON5I2V6HomTUKIhsJ5PdtKZvsNwQUV6RNJBt6Awr7OA1pLSr8X
 Z2rRnzMypxwQy1bKqFIBNq0ttBJBPl7IqP1qyUc6IeLDMYWE7HJS1De9WVZjkuefZ/5C
 CwMpX45wtB/wlctQgKmw8aS/urYiqvhuDAQ2KJjU7hvhlxHEu2ZMkL81uUdY7ObIGIxW
 Xa4XarSpr/BKfXVP5Xf9ZYgUo6KsT09xkNJS9Va6VctaNl0vkpQFWDgXg3XPCnXRfy/Z
 jUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229881; x=1752834681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Z7EpQ03VjvO9kvsktGSJv6yXbrBXhvwHDJoTwCanE=;
 b=ZwBsP5IA8nUxEKXXAfy1b/FecA5eMqVrBMmYX3Rn/YMQ2qoMGd5CsKChprpOd0Upau
 m3ClUae/kGas60iHR3m3XKaZi3nOh+kHRVR7uNcOxusqPV5OtIYfRhfSw458sVtC5zUZ
 SI376g27Hb8DAvUOi98KLWRAphBhlTWVxZRBIKNXRlG/8Kz8epGm6rtIuRHuGIaXpqyk
 GXXSxBe+CGEazMeAZWaB8rd+X7fzLljrjRY098LI3rNPesivWJG88cCwJ2F/p5wBvKQy
 4SFz/ECsL5JYlMynKvxdhZneoq7n5gHH0RXpX4BmbyNHWUGlN/Rut9yLzULk2iYLz2NJ
 +dxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFj7AxFx3Gw+Jdxkwo6S+6y9/O05GkIevTklUY7J3b2K3fjMjFSeA716LOCDsP6kriYWsOZz+JjM4/@nongnu.org
X-Gm-Message-State: AOJu0YzWcbgXma85nJKER2pFai0am9N1N8vdeyLIXtoA6SkFPSIfEvlk
 2eJHoe9+RZSYkWaHMJ6I3S/M7P68dS4k2jUwfDJsnC6YmjZK3Fs1qGaOBqDnP9A7bGQ=
X-Gm-Gg: ASbGncuLqJLvUv7Nn8c16sMgcsQ4o2AUc2IScUsbSw2OpyMejOniU/iIl50PJVR6Wcd
 S643me02WwaVyFm1shaonC5NFYcPXrkttgJPM6gjZWA3IuCWHsbLDAJFag7rKton48zlENBjH8J
 Jw6rY8mKzY2TWgmWabng8Z+HdsLH0idM/fkelc1vrVaCrT4xaIKC/x0Mu5hrgeT99LYntSXLK/9
 ++QBJL9OmVwLrtrghSt4g4hAYnmMH0AV/9i80ZvLGdj+5+Dow7u+5bMeci15FNnCOHry2/W2mbw
 1yJTuXk0w7sokU97s5PG1OdTQuAJUSusejVY+TyIfg39a5xfMLjBJd4zc4o+n63LSj66Xq3A6HE
 WTkJ+/qhzsXt9CD41ct15eeXk0O1xG+12AXhBNh4heUm+uSYkAFPS0Z1ZKRs7M/Nqg80AkQ==
X-Google-Smtp-Source: AGHT+IFLc86d1MD3DUlHHWjO47T0nAW09FCUdyZBg8+h1/8jiYrM3tqPnkUQQdtwgFEuj/aUV7JQ8w==
X-Received: by 2002:a05:6000:240e:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3b5f2dfd79dmr1571212f8f.27.1752229880677; 
 Fri, 11 Jul 2025 03:31:20 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5053725sm84337835e9.16.2025.07.11.03.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:31:20 -0700 (PDT)
Message-ID: <4c6ba00b-a90f-42a4-b4ce-1efdc87b7e03@linaro.org>
Date: Fri, 11 Jul 2025 12:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci()
 into pc_xen_hvm_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-4-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711095812.543857-4-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 11/7/25 11:57, Mark Cave-Ayland wrote:
> This helps to simplify the initialisation of the Xen hvm machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

or S-o-b per 
https://lore.kernel.org/qemu-devel/3ebf1793-6d55-4e07-a2b6-cb738d8634fb@linaro.org/ 
;) I don't mind.

> ---
>   hw/i386/pc_piix.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)


