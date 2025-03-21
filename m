Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23DC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveoS-0001eh-1Z; Fri, 21 Mar 2025 12:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvena-0001Ho-1G
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:00:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvenW-0004hC-Bh
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:00:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so1409072f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572835; x=1743177635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=roCABu7g7MFaosfKrNrJTjbqx1/jQHl5LKKqHjZkU/I=;
 b=qb84qLV+9CHG2WyeZr/OPZWQidVkGWsi/+tBaK2EXo/IMrwza+borxAtJAQLPqwuKS
 JK86YZPwHg4tB3pmu/o0QRkVUSZJKSWaS1H4AvhaZOQaVJZeNGKoY9KV54Fw30GP2FL0
 4O6QiAazifXnU5f+iZjpHPVthEEfEa/5d72ccKX7vOxA6XD5EJFkJCpISGMCXn4PFK0F
 bCmcFVbvScs0g5x6o7TTKWQNpWpr9vMkOxvJ0EKV2zDz7F9y+obF1g6OY4AE7F4ztmYO
 lJZ0u1l5xTAFeK3utVkxl7vg5rrpJYxEA5Gbt7gfEfAqU4mEanA1gsBpuXB+TOgUuuoX
 tHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572835; x=1743177635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=roCABu7g7MFaosfKrNrJTjbqx1/jQHl5LKKqHjZkU/I=;
 b=UQUVtsqUxHM3aV9/j09k++UOetvU3L7v9nkfNgvVfk2JD/lt/ckMfOsMUQL3eQTJ8W
 mT5EuyNP8OQsyj3thMiUIA8VliuPr8Rl7CKqnbiybz6IXDvzr+c2X/NFTatbxoOgLfUX
 ulutN7Wo2emojcFIkn5F9WlyVEzhu6+ET4nem2Nf1EUAvSHQxd2O+3x7kPtbh16UFmug
 wCuhTW83ORHVoi9AbF0w9Cwykpnt23pe722EqUVdiYLG/IdlOY/shOAsSNwxNW6HJ4ym
 tnQgXB/9093Zc7/BENi7hkokk2k9GITdb8HYuoMrLqa3rbZffQEzCy5FrfMTyAK1cwZ6
 qc/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi0XdgPCr0aiKtCU1RvZmG0aEO7I6uciKEcvn3BmI4Q+LFRHqkExv2qit7/3eu8m8i++OgPWFM0GaG@nongnu.org
X-Gm-Message-State: AOJu0YxsL/iChiY97w8W4C/xgFD+tHh8cRVhRj5Orzi850sRft4OgBP6
 dhh7keKFgsnqiaEGoiHfDwFp+xEMlW4SgrfwcNUWEF4N77AVcDQxqcPord/IpZM=
X-Gm-Gg: ASbGncun2nYF4pcbh4OZRxhQLWEGQ32fqbEOf/bCM9X95prm1PsUcSVH+/zCwfnNtOE
 tKfWiYM0u99lakiLdWn76SuB6ZcWJwoNzSjFNVOl1BLHBCo/W2KVoVlmHy+SQaz28GTvzqYmZsM
 Dq5IlPafUA1xEdKUpTCueMzBirFNP2eiDcyo7Cic5mKqHQl1iQiUbdi7E0QqRa5+dCOrRbE6fPz
 T26bSL5CFU0hDp/FfBhgO4j0Rp9aQh9LykQaVzvjc2ppxvYGe0CFycudfziY585Czw35ll/J3Zt
 +/OtatfoMtIj5h/4kG5ClUNiLMiy6x1gjpRJAYzxTOjGQHbF0+Q1JEkHpMW96umTR8g4BcMFnuv
 4KOxfxPqFy8Wg
X-Google-Smtp-Source: AGHT+IE/vtY4oMRETm74OgPNhG+oGLJk97P8bmmz+26P/XLEOaaWuE5w31QamONo7cAw7YPy6j6HXA==
X-Received: by 2002:a5d:47cb:0:b0:391:3bdb:af5d with SMTP id
 ffacd0b85a97d-3997f9254b5mr4488297f8f.28.1742572834901; 
 Fri, 21 Mar 2025 09:00:34 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995a05sm2690047f8f.8.2025.03.21.09.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:00:34 -0700 (PDT)
Message-ID: <a5a8f83f-50b8-483b-988d-7456889cf38f@linaro.org>
Date: Fri, 21 Mar 2025 17:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250321155925.96626-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

(forgot to Cc Alex!)

On 21/3/25 16:59, Philippe Mathieu-Daudé wrote:
> In this series we replace the TARGET_SUPPORTS_MTTCG (Makefile)
> definition by a 'mttcg_supported' field in TCGCPUOps.
> 
> Based-on: <20250321125737.72839-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (4):
>    target/riscv: Restrict RV128 MTTCG check on system emulation
>    tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
>    tcg: Convert TCGState::mttcg_enabled to TriState
>    tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field
> 
>   docs/devel/multi-thread-tcg.rst          |  2 +-


