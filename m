Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DF0D637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfeM-0006q8-1C; Tue, 16 Dec 2025 19:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfeL-0006nY-6N
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:44:17 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfeJ-0000rT-JV
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:44:16 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bbf2c3eccc9so30511a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932254; x=1766537054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3XbcuFdvJcr5BSH55kv1O15IoS/XQMOYnKycOUuZCQ=;
 b=naM2o+6Gc/Tm1keaiRp/F9Mat72NGBn8l27n4qxu/g1wNhkslgz/lJfSoSHHI8DqLj
 3Ur9vObsd68RGqgvGvEl/mk+Kn1ik5JEUD91ItNhOLnAaDqbpSlD1LobEIfbvzUHp2fs
 8yuMNLsdDj8RCdg3yvbX11yeLL+oFIkztweqwvRiyfCoeRI4TfOBzBCMTLKdw+Q1C/vJ
 Qsg+GtMLXQ8hs1lN3oDtcJExnOoNOf/ntvCTIBOCjqttKk5b5KgWh8CF+93ZTo/0qqUU
 0kbrdwBC8O1gDUSLNUECU8pRMoTAaRKFrzNKxKpjJEJws7L1mtilnH+ZXOT3U5a4vQwQ
 FliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932254; x=1766537054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3XbcuFdvJcr5BSH55kv1O15IoS/XQMOYnKycOUuZCQ=;
 b=pouTuzmagUwQ2/pLobC6kXGlv8WOHY6EEi6CWlpAOCopbmaQyYzbvvp/bYVBXGsW3X
 riRa7PDhSKX7zZLmKMBf02UNl5xKc/pQjIV6NhPJEY6aWC/05g+ds6sMB+oORLqgpc15
 oEt8Bd2Z4hoPHWkRgShOC38J1wLzT4RHeltZLT9FjtmBSEwLBPIiXN4YxChA1MLu5WOD
 kmkCT22+2dGuHzl8oV1L8qbkNpJ/NRYvmGTILS9rBP/8RfbiFNOwwiwilENsIxW4QSSW
 LTQFhwW7r+2IGmQyxlc4JW+b8CepKrgEuLLqusJeuqvUfcmEs1FEQtnnKtEwW2r1hjMv
 J/DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHS+W0XJj3RpUZHocEIeIKptCrsAkjCTs9BUPS/pnG7ZJOtGpUXU/HBo5jh2Fna4TPb5PDYnP/Xz8H@nongnu.org
X-Gm-Message-State: AOJu0YwAb3R2X8+Kh1+ZacDS795n57No482ib1dOn/I2WzLgVE5xmQgb
 AOEhwaJ+gwwTKDh4I6yPNhsJB70P9BzrAsi5Xfqi09ffxh+5CisffNW/Xbg8RZQYDBoKmcNAbso
 IGZuJchIYVA==
X-Gm-Gg: AY/fxX4xolFCZycqtnCHFFHcrPHoQUNXbvZrKN5lS0hmJlemt1W4MBD2RnT122W2QZQ
 +CVty7G1IpazNdR/nX/F8hG4FbSs+LSisYzbJMS771U8a7zOfyxlbsHRshhdZprcvrSPm83Or/7
 fRSlM6DBq8dmfXWWrfodRwpe9AoLLllAeAZxade/P79WctIWS8FlW+rC4d24+vnucntoksyvbeu
 o9FQPevOj4PTKIdI/t3KN8NpFX6rYd8cazqmS3W9krf7/RGDj7M7F1FykMf/l7+PGsXBIomykb8
 RdMMdfK+5IYTsan22GBruuvHrw+qLOWP+ZJ7sZU71VhWrzUuXw/jzlwFPITqv4jJ/glRQ8uIGax
 2bmoSLE0SFe7jduXGrziBhuOM/jkr76q20m7NzlA4Ke72A3EhBRbKHHZpSbCrxJlOSGfi/0ZWap
 NH9xomd1S1+zsyvH0ow/pzl5M4kCX6GFEt+NdFU2N19oe60E823xhkD+0=
X-Google-Smtp-Source: AGHT+IGLCgLVmPUQ6c92iVPK0N8Scty309FdHJFgKsOSI8RRKZH69mQ5Q5Va5+DFqas8w8R7it9F1A==
X-Received: by 2002:a17:90b:554b:b0:34c:9cec:3898 with SMTP id
 98e67ed59e1d1-34c9cec3986mr8128945a91.13.1765932253624; 
 Tue, 16 Dec 2025 16:44:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34cfd7036e7sm625936a91.1.2025.12.16.16.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:44:13 -0800 (PST)
Message-ID: <7e69c3ac-e79b-4662-8e76-366848f65dd1@linaro.org>
Date: Tue, 16 Dec 2025 16:44:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/riscv: Replace TARGET_LONG_BITS in header
 exposed to common code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-9-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-9-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Macro is used in hw/intc/riscv_imsic.c.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu_bits.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


