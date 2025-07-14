Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E458C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIgo-00016k-6n; Mon, 14 Jul 2025 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubHzM-00043C-Nn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:09:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubHzG-0004gU-U3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:08:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so29025055e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494927; x=1753099727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxrWno1eHQAu5+VZNvtjOsOGqZx2AzE9+PGcb5JTtu4=;
 b=PLRSC/8I88R0QPMPUZ0BHI0hac+MZfNUNxZMXJmV9w4nh13Uyo9omBe759yL1bWvWI
 KaDBAAOpnVbkF+4jrsl5FQ/j76BbQS+ESgV02u80kyiRWN4kv4SagsgKhMLko+eOEowF
 xIKkuEp+ax1/1567Jlkj5QrtiI4Gd8l5zLS7EgDG4GIO9+nZxvJmNN0prPUkU2FPWzRs
 vH+NODXDiTwRj5IuZ5Pn+J46UHSnDXX4rqTpyRowgUnStWTThzFs6yTWV0GnUb8Cda9z
 iYsrOVtbnlhrSwnfrkEQ4R6BklDxzp8MAxBXKW/obF5tCHKNa+rt9Q3jmXB/P0g/ztNP
 UVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494927; x=1753099727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxrWno1eHQAu5+VZNvtjOsOGqZx2AzE9+PGcb5JTtu4=;
 b=hrfyMv+qWQXA0VFTD6oCKRloe4D5ode/dDBuGctazxtahCKWEMZy9v6fqER8+N859M
 YxE5cbf5cPdmCaGME9X9q+AT1YXRhiZh4oSDdPBpVyMih7mU38uZ8b3Jvw86CjMcjKb3
 pn3pSWw33PDzCvdbkdE2eXfEJrxgMJF+Ids+FJFelQ0m/oHBB5bDiBADc/QRqVAK6BYy
 81BrH1dlBUTrT2a7M0uQCjAU3ZOD3FIgccfQ6OGKh0HdINibO1hlMLNpfIOWHFwrFO7w
 F11KFRS5jKNa1Oy0EAr6LW88hH1PJKsOGFZ7SdtvrvtZ7rC5rvz0gQPe0e4AfwE3ZSr3
 ppXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyFBWZaK+kAyqoUwbLwJkl7reEk71CAjkXxjTkzH89j2zwLrODLDuttAiqmTe8r7Z0Vlq5R1W8nueU@nongnu.org
X-Gm-Message-State: AOJu0YyTOo+2cH/oiZgk1clFKebWNouZm4C9/zUtncjrkpkWqY6Y0DfX
 McPhh0vr/vT9cGHAXlUt3UgjLS+x+dpt/zyyUXdVB25dWyLEix8nGUSsSyzlYLG2sUA=
X-Gm-Gg: ASbGncuoR6MiF9oi3xbpmT2W37VjMMnH0A1kw6Exq40Bpw0TZOhFLHHjAH3Z7ic3DER
 /GMZU3t2vpUvweHnkcBd30kwP9brFuxdVP57lYHzteWKF1uaCKZFHP1SichnbePuWqqvDms8ygI
 UQBG6RsHQ1MP2PUokuEmaDb6IwTOOt+aPjArMSOsdgDhlopZib1PkNqVVHmvVrnlQ9jjB5Z0KGD
 94Y4t/KtRADWRhAlEhqJXUcgbUmKodwZ8Jcv5AuPFlRTxM55Z6T6efiDmwh6A64sHR+azR2vLJ3
 w976BRPO/i3p8HqGd/K70Ldisgo96avGP7jUkMDzx0Wn2VyQfV98Pi9LFVtNGpdXm0WwKez/fAC
 dgUJJtvK3XHwDM9sO6VBsHJMBkYZIPv9rtHZ7YmWfnOKIsDxc3yOa0KyCO01OXV1ucHHxAkA=
X-Google-Smtp-Source: AGHT+IGYPBaHlqRoZacInu5T8a8CR2coo1sI9IJzBvKLfGWOasm3KOGpxe52GBQAX8BxRFCeK2cuEQ==
X-Received: by 2002:a05:6000:1acb:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3b5f2dfe068mr10293307f8f.38.1752494926721; 
 Mon, 14 Jul 2025 05:08:46 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f7bsm12435050f8f.95.2025.07.14.05.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 05:08:46 -0700 (PDT)
Message-ID: <8b2b7e8e-8d6b-46bb-8703-41999eb267bc@linaro.org>
Date: Mon, 14 Jul 2025 14:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] esp.c: only allow ESP commands permitted in the
 current mode
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/7/25 22:46, Mark Cave-Ayland wrote:
> This series contains a few minor tidy-ups along with an implementation of the
> logic to only allow ESP commands permitted in the current mode. The motivation
> is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
> boot.
> 
> Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 6 adds
> a new asc_mode variable to indicate the current ESP mode, whilst patch 7 implements
> the feature which fixes GitLab issue #2464.

Indeed, thanks for working on this!

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Note: this series is being reposted as both the SeaBIOS and SeaBIOS hppa binaries
> currently distributed with QEMU have now been fixed so that they do not use an
> illegal ESP command sequence.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


