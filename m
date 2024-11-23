Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE5D75E5D
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 18:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEv0w-0002IT-P1; Sat, 23 Nov 2024 13:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1tEv0u-0002I7-6R
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 13:37:48 -0500
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1tEv0p-0007Bm-U3
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 13:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=LE57E
 pe0vfXYb8a2OouQK4wIBbdUURp1yQC6DMZFaX4=; b=IuUvCqY+/n3RLX4104UCG
 LlhUPiNBARcx3TLiHhdrrVt3NFYj2eaEf/JGSgUR7nW+8+dz2iva/VGT9XEuG8vN
 BlG5Td240GmAXoblvlijkqv8TOYSK29rRKVXB7PAkrPl3316rffns6F/W0d9E21y
 1FVL8B7CXKz/X68niRfseI=
Received: from ulan.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgDH71JsIEJnfr8zAw--.10278S2;
 Sun, 24 Nov 2024 02:35:26 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: chao.liu@yeah.net
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, palmer@dabbelt.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [RFC PATCH v1 0/1] Add helper_print functions for printing
 intermediate results of complex instructions in RISC-V target
Date: Sun, 24 Nov 2024 02:35:24 +0800
Message-ID: <20241123183524.16316-1-chao.liu@yeah.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <b516765922b56fcfd5a16ceaf46428dbdfe0e41f.1732376265.git.chao.liu@yeah.net>
References: <b516765922b56fcfd5a16ceaf46428dbdfe0e41f.1732376265.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgDH71JsIEJnfr8zAw--.10278S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3xwIUUUUU
X-Originating-IP: [39.144.154.56]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEgqgKGdB+I4zUgABsg
Received-SPF: pass client-ip=220.197.32.17; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

For example:

    static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
    {
        TCGv src1;

        decode_save_opc(ctx, 0);
        src1 = get_address(ctx, a->rs1, 0);
        gen_helper_print("src1 %x\n", src1);
        ...
        return true;
    }

When the TCG executes instructions containing this function, the terminal will print:

    src1 0x...

However, currently the parameter type for `helper_print` is uniformly set to `tl`,
so when passing parameters of other types, they need to be cast to the `TCGv` type.


