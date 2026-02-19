Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D509C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBKQ-0001ib-2C; Thu, 19 Feb 2026 16:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBKE-0001fZ-J4
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBK8-0004Tm-LC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:41 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a929245b6aso13372595ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535555; x=1772140355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PaIUUWTAHAZMltH81P4Bep3u4CRKXq37ZPvEGCzzpFc=;
 b=xqBzBwKOgHgpiqvdVAg6NmYsWELe9xaaMB/DlnzysE847ulDJSz2DBgCLWO3JV3tZi
 KGJvDlIeelA452I4EbX3wJkqsFC0Xo7I63lX5aaKm5ydQAs94ply+XPwAp44SGlO+huS
 YK835BYWYSs8Pj7YnEVWtg0BZSBycysPZY3ypS4VmxKLsQTgPmABhkXlaRDVFpSoALGm
 MtrBePgc4HQ8sLOZFbR8hSy2fVPPlBCx/kRbQ//eZny2d9QfhTfGwUYU6ixP/+2d3dMJ
 snjvFKnw9XiQRTAAownbw3BbbE1ejRw59O7O78WMZwLxS9bZ+i+cUyafNiRNX64sl/QV
 BJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535555; x=1772140355;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PaIUUWTAHAZMltH81P4Bep3u4CRKXq37ZPvEGCzzpFc=;
 b=NB/a2U5euHTRbelJrTLysPOFh2ncx8f3MILH76Rjl2e4LVVe2j/znIn9LyjNUYAwtA
 xTImTvDPyA5lgx+LdAEPGxwGcv8R5yUyduuB2jUhMgXqGSdpPX7W1nPx/yiO14gd4CpS
 cZwc+uDXM0zT0zSPYFZQ5EMRGz6X4oWPe3XZ1ANA4aqy7XGXQfFiqBYFw/TQA2XghFJ8
 UMAPXb9BOgyMw3NJk0UdL3s3NKKbswcwejNEyrczb/STQH5mG7fyGU28zC4ECrCkCHE1
 O7qvInDLy3w2vlhyQmJwigeoEWrGK8wSEK9ucSU51Xczle4LPZS8I2V12sepL80hqz8F
 +AxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpvtA0nmTpeD12KD0SvV/mDQgDLjaGY7nKFq60+XPWjZ/iBwcRnoVpHKUrAYCYzzmOOIVRKUqBMUkL@nongnu.org
X-Gm-Message-State: AOJu0Ywb4UpvdESGqLwZ1uaVwRyDc7ucVdiniP9/qdQ+FJ9V6wfyoy7V
 bIs7LCRV1MoiotmD3RAvshV5GnitCod2DqucaJKZ7OrBnTBtZqJwJjvmsseF6Y4cs8E2tx2MJ2C
 cMCGl
X-Gm-Gg: AZuq6aJjGY+KLCEu8wynIw9+vT8zgQn+gJzsq7hpKKFrv7syK2+SE0ny1SII0C2Za87
 pFNmi1vUa5skBw7UJ3xiVbnYhor0EHxmEF9SaNdugNBsnOiTLd83Vz6e+00tvrYxKXHS7QKPcqG
 OoYg3SmTI7d0S0Fx3sss21QNLultOWycjXQzLkVp9LXnalmz9Ar0CKT1F3saKUI2LF/uWghv3em
 uBXcJiTQRVzOmmv7qW+VNAd8d5lYUgpG435Q1ywSA3XXV3mMQjAeURslqa7Y+MhgY2ab09XM/b8
 978EJ397+Rdo7CI/woXKLlTnsDlCMpYlBUrY4Fu3fjnn+9hYl1IBtgtPKqDssJmZqXScmBhE03d
 eVdZudinzM1QA+Qh42/3c9LBrVrZOHaLKGgry+wN6qC0clRZq3IfNR78azfuiQToF/pnlxhkIfy
 7mW9DyDvylhKbPAViLKLv0pCcpUuHrKkW2nKMGDRvw7evBI/lVBNE2mZG6N3Iir2VKo/5s
X-Received: by 2002:a17:902:da89:b0:2aa:d6a1:e18b with SMTP id
 d9443c01a7336-2ad174781cdmr197917525ad.18.1771535555298; 
 Thu, 19 Feb 2026 13:12:35 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa31asm175135725ad.4.2026.02.19.13.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:12:34 -0800 (PST)
Message-ID: <2739490e-33fd-4dac-9f6f-927585ba54bf@linaro.org>
Date: Thu, 19 Feb 2026 13:12:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/50] target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x641.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Restore gdb-xml/sparc64-cpu.xml from mainstream binutils, tag
> 'binutils-2_46', found in the gdb/features/sparc/folder [*].
> 
> [*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/sparc64-linux-user.mak        | 2 +-
>   configs/targets/sparc64-softmmu.mak           | 2 +-
>   target/sparc/cpu.c                            | 2 +-
>   gdb-xml/{sparc64-core.xml => sparc64-cpu.xml} | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
>   rename gdb-xml/{sparc64-core.xml => sparc64-cpu.xml} (95%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

