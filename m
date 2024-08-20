Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCB1C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgHVn-0004CU-NL; Tue, 20 Aug 2024 01:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHVl-0004Bw-6S
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:34:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHVj-0002rw-H5
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:34:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2021c08b95cso18172145ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724132066; x=1724736866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GXYSM9Zyra/rSqnGBi2z2UQWFSueUDyVdF7SYYWDy0I=;
 b=Y5f1Ge1BeIMjOaABhdQ7clnEz6muniwLPmfnnxrpHyW8/tlmbIPONhmZxzLGzUQAl5
 LOG0iWuMeJKqf0iCXx59aZHqq19G1vdWuWnnfxS2CFIBgWIt8nLdr3L1KqNHHpxFH0Ms
 K1x7KV+7PezSGyj4EWIF3nMj4xv20kU9A/dIHZ9lD26HLdXXQePKMeix1IUMHHOAqpN9
 0rCXHR8Q4BvNt8wO/F2KzaPpjiCl2OCanbREgQQaAz1dmrNM4A2rMhxmCjKmLo5bQCQZ
 8byDN+d7AA+ffe9gyoYauMuSwXDPZ2CI0CgS4JWOzYHv32CY+eShJR45xI1IxppyqT1s
 7Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724132066; x=1724736866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXYSM9Zyra/rSqnGBi2z2UQWFSueUDyVdF7SYYWDy0I=;
 b=jo39XTcCWkghClncnfGZr6KwjQJduO6YIWj3f5SnWzr7Ew8LnFxS8/LaYoJhkbXOEf
 oHbJRQ0fyoiHuf4ChcyyWE4K0KfDT4BWUsszT3tafqHe9GdPW5L1hz1TRUniBOTmRVPL
 pdxNoEjfcsvpyC0E2YpxSzogbo0qzbbDoLVA3aGWYIkkvCdXkZpm90MRVpKAOwa4tdXp
 Eq9hy6qjdx18V+/imf+hSlcqHz74dNLyvbAid9hFoW7sF76NhP0t5EC0Rv4XVPXE9ccW
 BSNczen24CSHoNNE9LHdYkEqZQhmti0W0xGMbgRigSNekEHLVcaNgJjRWMRVIUysmg+R
 vHtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkwPI3wArZwY9Fp91cIhBhi8C3vxeiYMBoEpTQov/+P2asjJu/RLOalJ6+dB8HmhXpJmKQWAeyFu5Jv/Gzniwmt8IDfNU=
X-Gm-Message-State: AOJu0YwNGmh0rmm7UwRVKPUPdFjZb6bWbKShiMUuB5VBqj5QGPoCjgD2
 AWxCRwppEc4Yc40EHkXRZkmopma2lQ5WxQvbCRNAoU6z5GzWj2VLVLuGSW3lLVA=
X-Google-Smtp-Source: AGHT+IFRZPA7WOiQrHgCmKlqgGl49JEekNkGiynEbmVvoOzSeY2z2Uz3Gfin8gHu4lhuKKrrVDLdVA==
X-Received: by 2002:a17:902:e54d:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-2025f1bc0f2mr31035735ad.28.1724132065413; 
 Mon, 19 Aug 2024 22:34:25 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02faa2dsm70649945ad.36.2024.08.19.22.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 22:34:25 -0700 (PDT)
Message-ID: <4eb1f14c-bef8-4d99-a625-17d20a9a233b@linaro.org>
Date: Tue, 20 Aug 2024 15:34:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] target/riscv: introduce ssp and enabling
 controls for zicfiss
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-10-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240820000129.3522346-10-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/20/24 10:01, Deepak Gupta wrote:
> +    /* shadow stack register for zicfiss extension */
> +    target_ulong ssp;

This will also require migration.


r~

