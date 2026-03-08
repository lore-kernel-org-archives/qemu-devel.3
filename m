Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29303EA8534
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 16:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzH1l-0007zL-C9; Sun, 08 Mar 2026 12:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH1W-0007xy-8T; Sun, 08 Mar 2026 12:30:37 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH1U-0005SK-Kw; Sun, 08 Mar 2026 12:30:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 68E78401A2;
 Sun,  8 Mar 2026 16:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BFBC116C6;
 Sun,  8 Mar 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772987427;
 bh=rAXQ4qXmr8ldMMd1OEW/oKpHo6XN1tVics906PmakEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j3GtujUI7Fj/qC3tnaQf0WVLXMMi8VqaltFplLt3WXiCRHFYKGflnZ0MFS2y49rKI
 R2RAi9E5GtIfnCSmAWGoFDxmkwdWQiivKcMqw2e/J6bi54cZu9iTafXiJbYNmws+/i
 xxpJqRnQSjAYpvz4VrCTtCSSkllJqc5jHmU6SucrBAIIX1fIpAxjjKJpKhN4MvpMiO
 14t1yJ8pptEo2pGfLqXmLQ9meBfdKa8yJRhD8B3kiehVd1u3TI4Qhl7zOuNyqYlaI+
 ehGyItcNs0/pUcfEPKkFaglJZD72fgNp0PGN0rv1T9FZtUXyjy6QBGD6p5iiBrSpA0
 uNOM7GeCpTVtQ==
Date: Sun, 8 Mar 2026 09:30:25 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim Krcmar <rkrcmar@qti.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 "rkrcmar@ventanamicro.com" <rkrcmar@ventanamicro.com>,
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>,
 "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
 "liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v5 2/6] hw/riscv: define capabilities of CBQRI controllers
Message-ID: <aa2kIVk1B2Fm28Xs@x1>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-2-273ea4a21703@kernel.org>
 <DGSI3PC0N9OO.NV1W4DTKW4C2@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGSI3PC0N9OO.NV1W4DTKW4C2@qti.qualcomm.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 06:17:14PM +0000, Radim Krcmar wrote:
> 2026-02-01T15:58:08-08:00, Drew Fustini <fustini@kernel.org>:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Define structs to represent the hardware capabilities of capacity and
> > bandwidth controllers according to the RISC-V Capacity and Bandwidth QoS
> > Register Interface (CBQRI).
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
> >[...]
> > +#define RISCV_CBQRI_VERSION_MAJOR   0
> > +#define RISCV_CBQRI_VERSION_MINOR   1
> 
> I the series actually implements 1.0, instead of 0.1.

Thanks, I'll fix that.

