Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55F0C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyHh-0004IN-EM; Wed, 19 Mar 2025 14:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuyHf-0004Fh-HD
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:36:55 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuyHc-0003SA-SG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:36:55 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-476964b2c1dso60014371cf.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742409411; x=1743014211; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F+wdgFR2lyJBz+be5VZCFuKNaezmyDjlKGbxvVD7ZSg=;
 b=T7+W9BwXq7RsNIZX7WnlpJWZClCMZK/qskei18OcYEEph4EMmWKcMX9qcEBJHkvAy5
 GviKkIZbJoeyjnWrkxcsEBG2VY9KWpLjlk/b10VmfCSavaAaDzV7Ln48v6QkqE3aAIhL
 9oJ2zTjqDuo41UwQbxapmLjh7aNerZakJ2NXbNaFDFKbdLPJBgm92hODYpG4fwG7UKPQ
 S4hhq8CES6kQ4t8jJcK0hd1XoAVJ8i465dD0dnidxWQ773RStXLlbD/w1A+OJVrsjdpy
 B+tg6IGH+WVzjfR8c/dpVK3ZltLfqNmLKEjbnvlVUBTbaEbpni+rutpN7xAqb/Eth+Ao
 2+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742409411; x=1743014211;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+wdgFR2lyJBz+be5VZCFuKNaezmyDjlKGbxvVD7ZSg=;
 b=Z4cuTvEevucX1gcuYy53bijo16np3oisf/uYVrMCywiLUV1B0PQfDOCcJCa4jUjYZ8
 EQL9K3WbJVOUPER7a4jYzq3P6OUyJe+iIO7xva4xhLcai1x7J7SP2j71np4/OwAhEwSA
 oKqjV6mPK7F4qfA0Q7xqtZnhnJfjSm1cAPLRd+HepT0kD31rbGOMEBTJja2vplkZxDtQ
 NHuOEr2p79lVZ0imYL9TuExlPH0huSHxvYQExeV9528GXRU4rIUALjEfWHNCmqYVygfA
 Rph0BI7SmvvnpTCAH4Azpk3b9s4I9zEQqt/wpN4erU5eRV2eyROD0c9/gZy+2VlI9tu7
 oZ4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnFba9IJ04y8jcffFdy3fLpgjw3g3nTKPH6UlKIjIjXBqM9cCSET1ok5qzi4+5x8d9kjXy505c62fq@nongnu.org
X-Gm-Message-State: AOJu0YxLeb+cx9gtsOudLd4AXQfx5FBjCcDBSi1/ueDUYg9ynPxeB6VR
 kaSm6F9Ws1lbImPUmR+c36fKyANP1ERhux+41Loo5c6GbLV2qCqB
X-Gm-Gg: ASbGnctoudOsSsjuD9ebUSez6e4dlUqPoSya0SpSdgHwWQm/zVHYvnmxNZFbCNryEl+
 QGjTm6PVTmUBCluDBgqZzvP+F+B1T0aaGitN2T815lL85/hw9T7Hy43agc6OFkMmZt4KGZKhq0L
 VeV0w3wE02ic2ncyt5ibBBh2BVGK9H2YDeAiq6PPkSEgIkOxgPEJnbBpFynmrjk58WOuoDKBTjP
 4LPSoyryaf0JOcSO1fWLgKMGtJtZjNuHjQNjDEI2EbOWQH2l4SeqLMeP0vdvOM1+iz3Lz/Ot5kk
 TNB6AkvAhZ0tZBLb7RqO0Nyt8rBctF7SsaOm5bDAXXJO4TasKYZCqvB0k1ZtYA==
X-Google-Smtp-Source: AGHT+IHA2MzzKNBBHJE/jhoH6NFwSfshWd5PUZSMxPUQ9gkifouQd2kMztZj8f88F8bRL9jGbd2XqA==
X-Received: by 2002:a05:622a:1ccc:b0:476:a7f2:2736 with SMTP id
 d75a77b69052e-477084399bcmr71573781cf.44.1742409410990; 
 Wed, 19 Mar 2025 11:36:50 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4a9csm82882561cf.58.2025.03.19.11.36.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 11:36:49 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-39-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-39-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 38/39] target/hexagon: Add guest reg reading functionality
Date: Wed, 19 Mar 2025 13:36:48 -0500
Message-ID: <02cb01db98fd$e067d2d0$a1377870$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQEe7aUlsvxasbA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH 38/39] target/hexagon: Add guest reg reading functionality
> 
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/cpu.c       | 19 ++++++++++++++++++-
>  target/hexagon/op_helper.c | 19 +++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 3c4776232e..80f5e23794 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -739,7 +739,24 @@ static void hexagon_cpu_class_init(ObjectClass *c,
> void *data)  #ifndef CONFIG_USER_ONLY  uint32_t
> hexagon_greg_read(CPUHexagonState *env, uint32_t reg)  {
> -    g_assert_not_reached();
> +    target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
> +    int ssr_ce = GET_SSR_FIELD(SSR_CE, ssr);

Consider moving this check into hexagon_get_sys_pcycle_count*

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



