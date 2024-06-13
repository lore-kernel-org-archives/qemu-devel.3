Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA14C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHi49-00015k-Tw; Thu, 13 Jun 2024 06:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHi47-00015L-Uv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:52:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHi46-00058s-EI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:52:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f2266edd8so691493f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718275940; x=1718880740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fBtChbogusztsM0icl49lYDXuhamJgoufifuTk5HSko=;
 b=J2nLABK78/RUdKxADFlMN7vdmG0/Fj10XcWVuNrtoydE30vFjykEEu2eCQxEsQUQUB
 lWGMv1TQRKEYQZ7DTv4Yp6CWbq+xqG/qSc82mSUuToSPnQCy4GPFECljFRs+qLQ83b6Z
 lnR2v9gBTQH29eTc6zcKBapzyIW24BHPZddbmyhAZ4YgVAVAfLSG/Gze4RFjcsagT/VF
 mfRJMSHI1eM80bK81xZvI5+p4xYO7qlpzmwZM0d6tIgeH4cPW/PWtUd0gn/IsOXILUmh
 srz9FOy3zKGaHfUcqcQe+VlABiUbYddCHJUeI+ZxM707gf/dtBsn24k6Lzvbl74u+iQ0
 71aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718275940; x=1718880740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fBtChbogusztsM0icl49lYDXuhamJgoufifuTk5HSko=;
 b=fIrGxWKtFIVwdjVR5UUNffuK9h6s/oKmSBE+jUzfIkCC3HIM5O59DcsU98FlOqk84K
 muV4QOfaOXWvNpi4D52smQTuJP2JXao/OrEfmV5cSi1dTbc/j22jEx6zxN2XRiduTXa4
 2aigojtbTLdRNpJtK8Fw6vWL04rIUjjAG5VErCKGP78JVdlCl8GmzBz5HDhoUQ6zfkbb
 herT5HagJhyqzZXJFrJOPXxbrehGFztWR0LyYvAnL+6chWvw50LAk78yRmbJeUKuidMc
 yd6WG35JwfpesDsLOfOTfbbHe5hyNyQwuBtsRgHWHD2bsj3Mem6hJVJNh7Gjgfsr5hDA
 knSg==
X-Gm-Message-State: AOJu0YyU8ScIRww7gdRBORWv//k9e8tAN+kcGaPqRcMcBdjSlKhcjp57
 h0O31hOH58U57y/q2tIdWdGUXNm4FmlFhZQAOmOJC9J2MDs4TWOiLQXrNODytoW25x9QsKgOn6B
 u
X-Google-Smtp-Source: AGHT+IEWZU2bUggOyM7Sa6Izt/vUX7udZbM5pYpZ2EzkTRWY/ucgr5zh0b7Rz4dYpR/+Qxg9GgXFcA==
X-Received: by 2002:a5d:4bc1:0:b0:35f:2247:b5bb with SMTP id
 ffacd0b85a97d-35fe88cb15cmr3065800f8f.39.1718275939785; 
 Thu, 13 Jun 2024 03:52:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509353csm1360669f8f.22.2024.06.13.03.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 03:52:19 -0700 (PDT)
Message-ID: <28fd8bda-708f-47eb-8336-3fd26d0d8657@linaro.org>
Date: Thu, 13 Jun 2024 12:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] plugins: Few debugging cleanups
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240606124010.2460-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606124010.2460-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Ping? (series reviewed)

On 6/6/24 14:40, Philippe Mathieu-Daudé wrote:
> - Assert cpu_index is assigned in INIT/EXIT hooks
> - Free cpu->plugin_state
> - Restrict qemu_plugin_vcpu_init__async() to plugins/
> 
> Philippe Mathieu-Daudé (3):
>    plugins: Ensure vCPU index is assigned in init/exit hooks
>    plugins: Free CPUPluginState before destroying vCPU state
>    accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/



