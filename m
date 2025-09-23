Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC87CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v128s-0000bN-Cc; Tue, 23 Sep 2025 08:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v128p-0000aY-6Q
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:29:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v128f-00085w-2K
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:29:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46cbdf513d7so24104775e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758630533; x=1759235333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=STLl0QoS2orKXheanvNH4rYgtB+yKeSPZb6VPqqtcXA=;
 b=mKEnsXjphbsg7D0srec+Zal55kf/PgVcaQUKaVGJSS5rU2dvndSB15Awttl+ohEwvz
 3C5UN72QQiHLruIwcMXILHpd2Jdpk8jb7wm9mXrCCJY3kXSv2wgYAnKeytRUegsCeGOc
 40poJQQHshDSDM8cyur5U9XAdjkGiILzHdwhUJ8cyMWVg4VselB/48NAhep6BfL9IAG1
 wGmUFsxg3N1wHUrVsr3+Hb+5iH5cj5DOaPpDlB1/USTQuLBJ7pC0Gr0Flhx4jMYcNY6l
 FMOL+0Domg0UDSHnCIwFUETBX9OXsdxo1/pWhcb/Eo20k7wZQYutIVIQpgQiLSoHWiI9
 jYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758630533; x=1759235333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STLl0QoS2orKXheanvNH4rYgtB+yKeSPZb6VPqqtcXA=;
 b=JN/MYdt+ZI7anNQboJ1cVgIqOkLok3LJEvRnXPSGI44nURW3Z8QnTAVuAglbC/6O46
 JU0trDvfHUQPp1VTPMjycLh+W6hxLICxjJGHo5vuwru4yjmB4iB6nsWdSk9PfUqMV7ca
 h0ouPLtEdEkKFQfhsuIeAmKq+SQSMdCKvN1l0rPWQ1DON2L0MHGZy1zvll8iwLxIUIbr
 rGSW48L2b+2UVMf7B3dW2sEm2Ophi+OWSmS2u99TRFphbFeY/ogdwJ1eN0WG+eBZZdKS
 uChaBBdxww2rRZKgwtmFOgid+6RfYCTdQSQ1n1h/yU/yw1z/yLwLiOAc+e4Objd664EA
 9W7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTWtsm7ZAP4Vtx28lRxjQAXcgymOGBbpSXpYszMRlP4ub6tcU0BOh4Epa1LVKrNegqFykEPgUu+Ja7@nongnu.org
X-Gm-Message-State: AOJu0YzBDDkoceC935KYrXpUanyPOOgILAWii3z51tzXlMDvQrdWwSmN
 fHJqLdKphdhcMfg7w4Qer+O6nAw6DNOerG8RcGtaalnDLA/r8OjuV9ozW98EOWZUico=
X-Gm-Gg: ASbGnctvI2mHn/xtQMf1YhaIzJ+Jx49+wZ+d47fbN3hvTDnNUpSerfsmo1SDv7dHbfX
 F4Q0wiyCGQbSKgndTX9fZJiA2/LQSiBKuIjhr09I/hWMAaexO3OPtCd9t6joPG03RjErpWpVQqi
 MQJYSNBz/fRJgFmqOsC+zVqXyFDFiqCafF5Al3rYiZHg4oXM/36/B3mrbnKPgHuovPM3D+wqjEh
 H+/iP2oXIsw7KXg9NOhRt+ngVR2oCKfareZe0VYtwOvMde2gTDp1Q4ggMmZ2hw7KMmiUj6n3rig
 atCTXmYm6e6fxBakFRjl0khbM5M0MyhdFD/+yUPxY8gOgk7njJtQ+8KWg1miNWjguesYq8xDcl6
 8f4ukYFPr0x2kswI5fl7p6N16opiYXOPppYCAb1owxppG1x5Mc1np89Jt2ATLl5TgxQ==
X-Google-Smtp-Source: AGHT+IEGhmhfLm/rl1ZSuQfSMaiXDFyWTlYYNlaJhlXBlefwtfamgMjWVRMTsw+k9Kg30VTcOEfS5g==
X-Received: by 2002:a05:600c:3593:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-46e1dacf638mr27580625e9.36.1758630532964; 
 Tue, 23 Sep 2025 05:28:52 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2275ae9csm6747225e9.3.2025.09.23.05.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:28:52 -0700 (PDT)
Message-ID: <957c9174-aae1-4f76-a528-87016d49e30d@linaro.org>
Date: Tue, 23 Sep 2025 14:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/hppa: Add a CD-ROM boot test for
 qemu-system-hppa
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20250918122447.105861-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250918122447.105861-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 18/9/25 14:24, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Add a test which boots a HP-UX firmware upgrade CD-ROM. It exercise
> the PCI LSI53C895A SCSI controller. The ISO image comes from:
> https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/kernels/712/PF_C7120023
> The test is very quick, less than 3s.
> 
> Based on an old patch from Philippe that has been posted here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg651012.html
> 
> Suggested-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> [thuth: Adjusted the patch to the functional framework,
>          and adjusted the commit message]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                          |  2 +-
>   tests/functional/hppa/meson.build    |  4 +++
>   tests/functional/hppa/test_cdboot.py | 38 ++++++++++++++++++++++++++++
>   3 files changed, 43 insertions(+), 1 deletion(-)
>   create mode 100755 tests/functional/hppa/test_cdboot.py

Thank you for caring to respin!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


