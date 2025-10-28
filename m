Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40727CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDerf-0000J9-LB; Tue, 28 Oct 2025 04:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDerS-0000Hg-KG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:15:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDerO-0002Ie-49
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:15:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so56423155e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639312; x=1762244112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gUZ1SQrBBCxBz4nA+mLQlqgoUza4T4kePX+Yxoa1A4s=;
 b=ZBMuChtAmb9Z9IlH+xStFnWPeGSFBXDx6RlibJDNcu+Z5azpAInYnAS1CZOXEBmXm5
 xJ5G7l+qpqW+k5vyMK5+96/xQe2kE1XeKyDdPFm73puPrWiZtGvN6IEBAZxU4O2u/Vxw
 93q0i0WFm425Doz6wsxtxtadSCq2dFEBe0t/5vSV/zv2mC93C5K02dCAI6PPoUVLvvk2
 g+0CAb5Z5UPZVFf73XMecFQu7myho+xPqJZsA76vxujlzPkp9Iw7Q22h/xBgPExoG1z3
 Gzk1kemLJZZmH8FlvBXpPwysVRKoARo3blq9YwlK+lDnKZk9q3WEgp72i7QoxmA0jL4l
 Mp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639312; x=1762244112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gUZ1SQrBBCxBz4nA+mLQlqgoUza4T4kePX+Yxoa1A4s=;
 b=fssw17FzYGwsFRgvGdOG8ZWdrTVVU3p4gU1NXrAfMRRvxEC2+tzrr2PZjvDzwAlyFE
 BEiUqUij5o4m4Wqylb1q+DTEp8nNc1h1pB260R6YoiDW+93c3fxKhSqXzqKeI0IfgcC5
 13PpxrX7kaiQzw8y5WmXFIks7Ags0LbXdAn4hpa5lKg5dnmo7UU0YUKkeIaZtBLJDTzr
 GSBVV5E2rTiKOxSmanQTxof5ACUy4YnJs4pePyqSkt57kJwjh21ugGUJq1HtSWYPkeSR
 TUcfq8iF/xmL+Ne3xRKqyUoGGDP0QKWaWqrxEB7bCqpbLRbTzl7Bj79ZaPFJqXFB4PT8
 P5/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlI0fiR2lYQH4tB9LKkOr/EdxZ/aoijSbbXY30d6YvUzGgrLXG6vhqZJhhYzANSKxXMMhXAWhk8WBd@nongnu.org
X-Gm-Message-State: AOJu0Yx4HwQE2MsPz+h656+dID3N2722xlBuyOsiziWtQUux0SpxmPoB
 BOIgyiAhfL+J/jH+J3YaoayfqoX1cp4jwo0vi+3QL0DA1+ue7oge/WypB1OQv4uUmgo=
X-Gm-Gg: ASbGncsypCjR5Sg9J8Oya/Fa3LsgMriuRkmbgaYhde1AYoEpEEZmtZBGD0gD/Fybrr3
 IAWWbYJmLcqhuL6zDshjOoOIhlvUaZ5k/uetpuGLyvHhktqrH/oNF9fWCAcjmvndrJh09hUv9l2
 WLawaUO7jzKd4SxOF0eBSLEh4ptBAs/8Lc9ecRh9UsxMnCes+Hn1Y5m76nSv13NJmBPdLILmGL4
 KbNbPbzswakRH2EVzj54fIPq0BtSUE6hvYYstxQ9jfcMGE4OETwzhqygWR+gZjyzp2p3KbXqAo5
 S7FxcrjuBNkusjAzXMbcTlP2RIbWP/z5R4kUVkcs4qRFFYZuH3fx461MgnT2VOx+Q/qedY8SaXr
 Rrp+BaDo+K592y/n0Rg91u7WVDXbAZ5G7JFOzcT0/69xPiF/mMxheFqBpGaX+ajSODBl219VRGR
 K0pTTNN4wuwfgA9eKgdGur894UI/ZaRKr2X6O4UCU+i8Gcz5/sqS6QcmgwJFxg146cNw==
X-Google-Smtp-Source: AGHT+IHbNnTz/wy9hGAV9c9cZsyAqP8PR1DbYo303tFXbGRZUOru10z9UHlsWTRJ8DN5CTfEgs9uoQ==
X-Received: by 2002:a05:600c:4e8f:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-47717e41a42mr18394555e9.22.1761639312469; 
 Tue, 28 Oct 2025 01:15:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd47794asm202179625e9.1.2025.10.28.01.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:15:12 -0700 (PDT)
Message-ID: <a5f8bf29-662b-4ae0-be9e-711621616e35@linaro.org>
Date: Tue, 28 Oct 2025 09:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/33] target/riscv: Fix size of gpr and gprh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-10-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251027181831.27016-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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

On 2025-10-27 19:18, Anton Johansson wrote:
> gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
> fixing their size to 64 bits makes sense.
> 
> gpr is also fixed to 64 bits since all direct uses of env->gpr
> correctly zero extend/truncate to/from target_ulong, meaning
> !TARGET_RISCV64 will behave as expected.
> 
> We do however need to be a bit careful when mapping 64-bit fields to
> 32-bit TCGv globals on big endian hosts.
> 
> Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h            |  4 ++--
>   target/riscv/cpu.c            |  2 +-
>   target/riscv/machine.c        |  8 ++++----
>   target/riscv/riscv-qmp-cmds.c |  2 +-
>   target/riscv/translate.c      | 17 +++++++++++++++--
>   5 files changed, 23 insertions(+), 10 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


