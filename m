Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BE6C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJBBE-0004B2-Re; Mon, 17 Jun 2024 08:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1sJBB9-0004Ad-S9; Mon, 17 Jun 2024 08:09:44 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1sJBB7-00032C-BJ; Mon, 17 Jun 2024 08:09:43 -0400
Received: from [192.168.178.59] (pd9ec3da0.dip0.t-ipconnect.de
 [217.236.61.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 2825FDA0D63;
 Mon, 17 Jun 2024 14:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim;
 t=1718626175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fz7Gk/Q/VEwClSUAo+9VCSy+gxVGwQSiLH8xhZwWzGE=;
 b=r5tAJlv4epCtjvKV6NNvJH9B0ZJgtLecjsBcTVxjkRkkR+Gwxn8L2YWTVYERtRidzQE1fx
 iEzekMN+wq011Agp9L3R7eHH1mqzAwpBjf5IOHBHfrcK6kj2An1cstt+ODBIaIGM8KqKBB
 cI2tOlzIJOpFcqKZfFhVNBRRAkulocWRDN+N96pN8s46kycx9Wwru438YQSfWYXb5Fmezt
 sHedQyX7/JsO/s3hfVMKUeG6KMn1NEC3Flx2QaCjBqJ6B9GngW4Zcm0EdfBoCP1iHC13rX
 6lRmiBWDGQhNsT5/i8wSeSzkPPllF/MyJkde9mX4Oo0/I4RLiuZTvPkUQB8JDA==
Message-ID: <8def1779-6fc8-4e53-9542-20fe83651c0b@weilnetz.de>
Date: Mon, 17 Jun 2024 14:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] hw/misc/riscv_iopmp: Add RISC-V IOPMP device
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
References: <20240612031706.2927602-1-ethan84@andestech.com>
 <20240612031706.2927602-2-ethan84@andestech.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <20240612031706.2927602-2-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 12.06.24 um 05:17 schrieb Ethan Chen via:
> Support basic functions of IOPMP specification v0.9.1 rapid-k model.
> The specification url:
> https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1
> 
> IOPMP check memory access from device is valid or not. This implementation uses
> IOMMU to change address space that device access. There are three possible
> results of an access: valid, blocked, and stalled(stall is not supported in this
>   patch).
> 
> If an access is valid, target address space is downstream_as.
> If an access is blocked, it will go to blocked_io_as. The operation of
> blocked_io_as could be a bus error, or it can respond a success with fabricated
> data depending on IOPMP ERR_CFG register value.
> 
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>   hw/misc/Kconfig               |    3 +
>   hw/misc/meson.build           |    1 +
>   hw/misc/riscv_iopmp.c         | 1002 +++++++++++++++++++++++++++++++++
>   hw/misc/trace-events          |    4 +
>   include/hw/misc/riscv_iopmp.h |  152 +++++
>   5 files changed, 1162 insertions(+)
>   create mode 100644 hw/misc/riscv_iopmp.c
>   create mode 100644 include/hw/misc/riscv_iopmp.h

Should both new files have SPDX license identifiers?

Regards,
Stefan W.

