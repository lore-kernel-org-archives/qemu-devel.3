Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37408CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSh14-0000Oj-Ms; Thu, 28 May 2026 16:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSh12-0000Nq-JC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:07:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSh10-000688-Uw
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:07:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso7979759f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998857; x=1780603657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Uz+8CZ/iT5Ihn09Fq2+YPM68NPvOTLdQvf3rxAK89I=;
 b=INBSMOks7hAfqL/67RmOrk56ViOQ0KHtYabQeeVQrxCrGUdUWUJ3F05RSHNEUdxU14
 Xr7R7Bkvi00/IsXXR5JYkQMwJ152C3r2bz5Z8lgBzYgplIkRRTgaO5WH3ydY5Rw/hdV0
 YXD2hPu24SGyAKKTUZirW6dvfCtU6HpKIxmW7MBjuEghnLzoY+fMn43KsDrx1QHbnULw
 +vHAnkMbHdtjCra09YzGrFJGaL6xZYNdgovYgiNHesUxhT2eqm9xI8JWBG3khs88BDYi
 u6ojNg6NpzlCWf5m7H2zgTZ5zAdxnqjeCUQHxXdmFs1gMnf4Ly9nV5JAzbydGmDHxhMX
 zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998857; x=1780603657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Uz+8CZ/iT5Ihn09Fq2+YPM68NPvOTLdQvf3rxAK89I=;
 b=bbPZuPAwDJkqS/OzdXcMFy+YSHhyYBl455cs44DsyyIYfM9pqzsgmg5c0grlI105nG
 acxzWSdIHj9YAYv7GlKz0Trv4t0s2cbe2kaG48AvIEDuo261O+q1b7RSYtBsy126Lr18
 W8jiiZq4WrLIWWyYBDSxl2sJdQz8Yx5DgJxf/P6hA7zLHsZJIzAegXPBnhK3Q2ser63c
 L5Vx64dcs60udvoopW8xhUAbPzbUh5WofC3DGG9MiTtuHTPuV4uB67kEnB7yokayWJ7f
 M1xrpCbMamA9ahk9zxHlLNuHfD3lR6EdacNuUwLnutlrjpLeRzA3A4WD7dsDHFO5vrbZ
 xHYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MewaNajPOiJiFUpEbL3UJgL+Y3EJkhwvpUcQWQfSZ1o/W/aboyGmTBpXYTqxf7MEldk3+HOy65pMR@nongnu.org
X-Gm-Message-State: AOJu0YxwFEJBqSePLOsfZMYTuMSNQZkRLc5ryx4owhqw+ScMd/3L5PFp
 Fua/dC98/s0lZVgUW1JDacAEay9O0Qbkte0NTTVawmZo1zVeBaEEyvWAdQbt9paN5KM=
X-Gm-Gg: Acq92OHJTG19LLyqVhaNshp5+bRtTRwF9gQvpkZhoXvjCuz0YLo7PvbyWURbNqP4Nm5
 ftFrM5vMKaWxrkHBLxOy/A41N9BK5z1xz26LW33cO90EObHCp9MA1WpFelYjXzVcsvqX8JUgUfg
 NGJXVW4h8t3Sp8GYRN/JqROq+ykVg4OWJOCiQW7pozkyt38Sv3H1+YmBkXS8+f3lAjrWID8NFom
 oaJm47qwRDIaQbVAcf7VvgCVNoZK9cZQtUZokhTZqgyUGd+fksU782ADIFUPOMsC4Trjio/YRQa
 hHNEMxm26JyMJaAuNYLp5/zChl7O4mjxJaD70XPa+v/CJMnJOHaNDBw8WMGLQdq/Lb8mkh6kb7Q
 u10+Z9kwSQznfYCOejxl1tPK+Q2l8IctgxeFHOwluF3E9ipMnO2C3BB6PaeJlwzAsxOQssoackF
 RU6dDD8x/ZgPc8pxztLoy+u7CbyeLYXHpk7yt+YUI52fPphtetGeJ2NZy+fTogJPUov+veaLccB
 8rm
X-Received: by 2002:a5d:6946:0:b0:45e:739c:f187 with SMTP id
 ffacd0b85a97d-45ef05e2054mr726089f8f.22.1779998857370; 
 Thu, 28 May 2026 13:07:37 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm15553600f8f.26.2026.05.28.13.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:07:36 -0700 (PDT)
Message-ID: <b58a8c8d-79bb-47cc-8c5b-764e4675a34d@linaro.org>
Date: Thu, 28 May 2026 22:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/12] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Anton Johansson <anjo@rev.ng>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-3-philmd@linaro.org>
 <09c45039-110e-4fe5-b799-f4c33d545c3e@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <09c45039-110e-4fe5-b799-f4c33d545c3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 28/5/26 21:18, Pierrick Bouvier wrote:
> On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
>> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
>>
>> Make data accesses honour the MSTATUS MBE/SBE/UBE endianness bits
>> instead of being hardcoded to little-endian. Update mo_endian_env()
>> to pick the bit corresponding to the current privilege level (MBE
>> for M, SBE for S, UBE for U). Remove the now unused mo_endian()
>> helper.
>>
>> Note, TB_FLAGS has no free bits, so the data endianness is carried
>> in the extended RISC-V TB flags stored in cs_base. It uses
>> EXT_TB_FLAGS.BIG_ENDIAN at bit 33, leaving bit 32 for
>> EXT_TB_FLAGS.ALTFMT. This keys TBs correctly on the current data
>> endianness.
>>
>> Instruction fetches remain MO_LE unconditionally; RISC-V instructions
>> are always little-endian per the ISA specification. Update the
>> disassembler comment to clarify that BFD_ENDIAN_LITTLE is correct.
>>
>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>> Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/cpu.h         |  1 +
>>   target/riscv/internals.h   | 29 +++++++++++++++++++++--------
>>   target/riscv/cpu.c         |  7 ++-----
>>   target/riscv/tcg/tcg-cpu.c |  2 ++
>>   target/riscv/translate.c   | 15 ++-------------
>>   5 files changed, 28 insertions(+), 26 deletions(-)
>>
> 
> Patch 1 makes more sense with this one, but order is not too important.

I can reword the previous patch, amending something like "This will
allow next commit to change mo_endian() in a single place".

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


