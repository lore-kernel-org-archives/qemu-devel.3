Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456A2CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGir1-0003M4-Fc; Tue, 13 Oct 2026 16:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=739d2b42f=Charles.Perry@microchip.com>)
 id 1xGgyx-0005lD-HG; Tue, 13 Oct 2026 14:12:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=739d2b42f=Charles.Perry@microchip.com>)
 id 1xGgyv-0000Tm-Hi; Tue, 13 Oct 2026 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791915129; x=1823451129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DE209nhUwT7O02U+siMfkxdoZGtgi0vamOdURx+Havs=;
 b=hwGGzIfYDNTQQ8A/FSUn5w3QkZcXy5GRpMPyN6ursHYSF+iW2ax8/MAk
 +mPlITTE/LZOeYAkn9LINV7SECDOeDSbZT7wh783VhfzhXVUwyKrx8KiA
 3XKFD9Ng6rAsEQfxB8sNhnybPNHeliPjszvQzr5xwBFRYjYjBuv0KSSvw
 3HjfhZkl/a8Ho+Wf1aDw44gpXovxLD6b7MM5EjeEl88oqs7IeC1qU8woi
 VCX5EPwhjv0DlrB00IChTHqOpUvF8Kx1sBYG/KP2mxggWIZJfyJLsJP4H
 tU7HlxW/dXL6tW/bNYpod36hxWTNZ4Iy6Cy8MLLJ2XZmZa2k+ZIDFcvL+ A==;
X-CSE-ConnectionGUID: Q3qy/vD6QvKLPKCE46FH2A==
X-CSE-MsgGUID: 2b/cbv9SSKyWjmn28lIBEg==
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; d="scan'208";a="232068083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Oct 2026 11:12:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 11:12:05 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 11:12:04 -0700
Date: Tue, 13 Oct 2026 14:12:03 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu
 <chao.liu@processmission.com>, <charles.perry@microchip.com>
Subject: Re: [PATCH v11 03/10] hw/riscv: add RPMI FDT helpers
Message-ID: <as50cyb5yWynlBVc@MON-LT-C78453.mchp-main.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260917052250.1041262-4-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917052250.1041262-4-subrahmanya.lingappa@oss.qualcomm.com>
Received-SPF: pass client-ip=68.232.154.123;
 envelope-from=prvs=739d2b42f=Charles.Perry@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:11:46 -0400
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

On Thu, Sep 17, 2026 at 10:52:42AM +0530, Subrahmanya Lingappa wrote:
> Add helper routines for describing RPMI shared-memory mailbox transports
> and service child nodes in the RISC-V virt device tree.
> 
> The helpers keep RPMI node construction in one place so the virt machine
> can add service groups without open-coding compatible strings, channel
> IDs, interrupts, and shared-memory references at each call site.
> 

Hello Subrahmanya,

I'm wondering if the services should be siblings of the mailbox nodes
rather than child. i.e., should we use:

```
	rpmi: mailbox@10200000 {
		reg = <0x00 0x10200000 0x00 0x400 0x00 0x10200400 0x00 0x400 0x00 0x10230000 0x00 0x1000>;
		reg-names = "a2p-req", "p2a-ack", "a2p-doorbell";
		#mbox-cells = <0x01>;
		riscv,slot-size = <0x40>;
		compatible = "riscv,rpmi-shmem-mbox";
	};

	suspend {
		mboxes = <&rpmi 0x04>;
		compatible = "riscv,rpmi-system-suspend";
	};
```

instead of what is currently done in this series:

```
	rpmi: mailbox@10200000 {
		reg = <0x00 0x10200000 0x00 0x400 0x00 0x10200400 0x00 0x400 0x00 0x10230000 0x00 0x1000>;
		reg-names = "a2p-req", "p2a-ack", "a2p-doorbell";
		#mbox-cells = <0x01>;
		riscv,slot-size = <0x40>;
		compatible = "riscv,rpmi-shmem-mbox";

		suspend {
			mboxes = <&rpmi 0x04>;
			compatible = "riscv,rpmi-system-suspend";
		};
	};
```

It's not clear to me what the correct way of doing this is. I've noted that
`make CHECK_DTBS=1` yields one more error when the services are child than
when they are siblings:

virt.dtb: mailbox@10200000 (riscv,rpmi-shmem-mbox): 'hsm', 'suspend', 'sysreset' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mailbox/riscv,rpmi-shmem-mbox.yaml

Thanks,
Charles


