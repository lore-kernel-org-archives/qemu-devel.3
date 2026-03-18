Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90821FCD0BA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2juV-0006K1-5P; Wed, 18 Mar 2026 01:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2juT-0006Jb-6S
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:57:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2juR-00064N-Ks
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:57:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso1023538f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773813454; x=1774418254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbAIpPa3wmxM5B4eAlPohCBrDuHqCSTFHyZ3pYhs8FQ=;
 b=xZm8QZ+dCbfvRA1/musER7CRmSI7Nv1JeyZ77h6dNQvmAwzby9BeZZApF/SUgDTTJE
 jjdaSQa48lpVaupV3gWbxKbSBkumC6ahLVEsPyFy06e6Yk/4ASmW+chjeQzUnoCWx5TG
 VOcoHFnKfuH3v/sC6pePOJGIb0g3U5udouwvW7VDUkdcDRbfTxBGcqeLOWPICpbMge7J
 Fz+QrmSdEe/ImirOmLTqfn3rVuQ0b95P/w9kTenANyNRMsH06GcJXtnBk8PArM/qef82
 dLsIbSLuhJ5KO3PYO6nevttGJyQu65y9ljYtKla6JVPDVw2PY5kyBTLlSrwWqmdOlMR0
 6D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773813454; x=1774418254;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JbAIpPa3wmxM5B4eAlPohCBrDuHqCSTFHyZ3pYhs8FQ=;
 b=TjwLbZwyBW04tXPO8naRTUaqsVxbGr30Rh/jCxIEUDYj7nazNXhDNSutOwi3uLw6u0
 MbyX2ymJcD+C4h5KxlzndHg0viJJS4DR8cIlkEWbq/PWJ8Esbw99L1VQbAYDALFD+KQP
 mmRhSTA2lFvsQ+YMEyiflBNVs/ixxL3yJba/CPP2Gwh884zG26vZyFhVJk/nrK8S4Pf3
 f+7GkTT66u2lILQ4ojeiGbr0OzLr6KdgpQXF+FHw+2tFfQ7JmmOGxRAgUGhNhjrNlUkE
 U1fnN+d2Dae/6LNVbzSO8hM/rh3OlsndcqgNetgsBXzO3d5P4od3hPa6ya7Z7zq6pCzZ
 WLPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeWVza8MkncD3ebIker1bCMwPirhs4mFm5Uv8CFLoVyOaid9ro8k7Ic8+fqqDp0KfAywz6eDX8x5kD@nongnu.org
X-Gm-Message-State: AOJu0Yxu8xaNyiizBzwVM2hTmhs/Au4uYHEZdzRX2FG1braYU3onISeO
 fI/B5EsM1d9E2HcNZV2rsmSB+6Gmqx1nkZGWdjpOPuUQeNLF35hXqeccJJ/1UlN1uv8=
X-Gm-Gg: ATEYQzwEXCBogaV2ltEPmamAzT8/0exSYwkuFSnzcYZA0sBibiQ/caU6GV1GxvYWnIH
 Ju3IIW1QMMtuXPqhQJ29Sns0pMShyEHT/eZVTAxf6Am2fLqRzEoUinjbpqCaqAmvPmud3Vto/NI
 TwUS+KUpaS1VGwWLkd/ZtCS2VRiQS4+RamveOX59Awgq/Lef4l3zGLJpsAp+aJ5YWGMwBiIr5lo
 BDtpcMb2XoUgO4siP97Cxv+WKqyx3bk1GUNJ6UxzDl83in38crh4ogq3U7nd/xkbvlXKOhSY+qX
 WXt/0fqcUTTsKQIl/e1lB598CTcjzaEHZ2sI911hlPX/VN4lVXU8HN77Lay1yaZPDvIfnW1Cxpq
 ZfUJk6KDSgaeCR779FTPhqc18qkyLPD4UtQ+7BQQb0/D71isBqbwMO1ep32+yT7iQwHeMURPaQ+
 otpIcMV0wojGKIcRijlcmXdEbG2xuhQs+3wLOuFnCeTBLSErI28BBUjrBfKtXHOPDA7A==
X-Received: by 2002:a05:6000:2285:b0:43b:3bed:154b with SMTP id
 ffacd0b85a97d-43b527c9e9amr2975452f8f.40.1773813453731; 
 Tue, 17 Mar 2026 22:57:33 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51849636sm5183529f8f.8.2026.03.17.22.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 22:57:32 -0700 (PDT)
Message-ID: <517be5bb-d6c8-4220-b585-3adbe4826056@linaro.org>
Date: Wed, 18 Mar 2026 06:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] hw/vfio: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/3/26 20:42, Pierrick Bouvier wrote:

> Pierrick Bouvier (8):
>    hw/vfio/listener.c: remove CONFIG_KVM
>    hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>    hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>    hw/vfio: eradicate CONFIG_IOMMU from sources
>    hw/vfio/pci.c: eradicate CONFIG_KVM
>    hw/vfio/ap.c: use full path for target specific header
>    hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>      hw/vfio/kvm-spapr.c
>    hw/vfio: all vfio files can now be common files

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


