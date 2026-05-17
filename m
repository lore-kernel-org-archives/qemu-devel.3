Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF65CD37AC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdLJ-0005Le-OE; Sun, 17 May 2026 11:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdLI-0005LP-EG
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:23:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdLG-0003Ii-TD
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:23:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso15751355e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779031424; x=1779636224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y0ECnosEbYhBwaaVLNgvV5TGqGaj4v0AoZRbi0Qw3XM=;
 b=QTDEHUizUMpM6P0G34TpaaV0PtOj2BEkYORLhgTPba1Gxa8IHKvI7Mm1WDnIQhGdqk
 lTOln4IdYAJYg+XaNYFQf8I8GZmaWEGnGZxZMafw8MTSHh5t/m5yEDx1RJRIxvMEmbDU
 vqWTzBKWzHLgJf5GvBgMBQSnpQcNunoIcgpqvueFOyI6+TRjs2k3kspx+smmXsniPYoX
 YJ57cbcDATcljJCYgtNJAWK9dgiaw9ZZmFEmCq/dFxYzXsHzErYEpgSFXoOH3MCtL/w+
 48aL/bEZFlT3yhcz2mNfKwxLJvoHumevjR9Qy3Dos5OlJfN48kLQEPsCkz3iYGOYqBJ0
 UbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779031424; x=1779636224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y0ECnosEbYhBwaaVLNgvV5TGqGaj4v0AoZRbi0Qw3XM=;
 b=fqhp1HYughBxXT9CMEMMGSt94slM9EkXrEUQ6zE4zPlzi3Xw75Mb+HDe/zAW8zaLpH
 ms4EZg3Us5HcMg5Az2il3yBt8vqg7cHLx5NlFnIEe12rHWVWg7DaXRNpwiIA8nWALcZj
 4QKQJI43hhBUnidLfWXk4K/7B72IK6lIVUCJ0zNmBDyn4EQOl1d2AYnKqUJ62DExT8D0
 4KrNmJDPA/OHONRWnx+7E1NdtzgUvlkeKw10DFlvFATh/2IOY0zT1Yap+sWN69QbLlVJ
 WaH3hjo4BeQi46IbpLse4r85nA9tZFp1yJizLQ3cAtxWrf+ydOuzH+7FETg3UaxYjlD9
 rn6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m0blhpKhwg9DvRQl5M+lcEy6Fc+QRNUaG43ia10gOb2/4za4L9DiTMKg2KwxwbSTG51iA4GbSkdt0@nongnu.org
X-Gm-Message-State: AOJu0YwUS4fVRGY+42P+mzWm5pgOr1i4OLAgFHoHM5mZ4xaLCmvWv0v6
 sGj9JqRvq6Ymyz/4iDBBQqQCx+w+J8ugxja6JpKo9i44GU44bY3876OGTK+qb1ydh9k=
X-Gm-Gg: Acq92OEyxEWi+p8zumoAxA6H44qlTTwfJhHSJyaSJGOWpnk2z0peN6jHFomSxMUh08V
 WGm9qWK3Ong8gtsG64h0kYhioxr6MVG4nt28G/tzYmJLja2qkRCfStJD95Iy2FlopSR4o3zBClu
 TiZB6u4WwCeNhARjWmXWk6eSlBFNxiTdjayro/GqKH7+yDM15PM48/TiH2l6o7JNGJ3HlWVK/Pi
 f/U+KzWxshgCLz/R0IafoU1hdlnE4ILMPTu4XfRZkBSj7iIJcdkZwlu4VTj69iEzgtEzXQg7OB0
 O0flhfQtz+iwhND8f2bZUVAhpDXd+IxS/0RINTPoDrUDzLkOU1r367oI7mJG3Ro0i2vAckgSCuB
 JmVd14xm817ZtPu2Cm03pQ8zfM/MBMay99cLMlgZqWzr+jektoPd1cB3BeU1FEHX0FDWWSgvM5R
 IFHBMwte7G5lGqaGOpqajg5FOx4jHuuIjuPFyAigBor9Lwz2gAAg2hXcH9a7w1b5fAVg==
X-Received: by 2002:a05:600c:8b13:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48fe6513492mr191743705e9.26.1779031423852; 
 Sun, 17 May 2026 08:23:43 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c834besm199782345e9.3.2026.05.17.08.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:23:42 -0700 (PDT)
Message-ID: <676290f6-b1fc-4b65-bbe9-67ae13aa9e83@linaro.org>
Date: Sun, 17 May 2026 17:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/27] target/riscv: Fix size of vector CSRs
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-3-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515180437.23620-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 15/5/26 20:04, Anton Johansson wrote:
> According to version 20250508 of the unprivileged specification:
> - vtype: bits 0..7 used, bit XLEN-1 illegal, rest reserved
>    => fix to 64-bits.
> 
> - vxsat: bit 0 used, vxrm which would occupy bits 1..2 is stored
>    separately, and bits 3..31 are set to 0
>    => fix to 8-bits.
> 
> - vxrm: 2 lowest bits are used for rounding mode, rest set to 0
>    => fix to 8-bits.
> 
> - vstart: maximum value of VLMAX-1, where VLMAX is at most 2^16
>    => fix to 32-bits as vstart is mapped to a TCG global.
> 
> - vl: maximum value of VLEN which is at most 2^16
>    => fix to 32-bits as vl is mapped to a TCG global.
> 
> Fields are shuffled for reduced padding.
> 
> Note, the cpu/vector VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h                      |  12 +--
>   target/riscv/machine.c                  |  14 +--
>   target/riscv/translate.c                |  12 ++-
>   target/riscv/vector_helper.c            | 125 ++++++++++++++----------
>   target/riscv/insn_trans/trans_rvv.c.inc |  22 ++---
>   5 files changed, 103 insertions(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

