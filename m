Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C0E65D18
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 19:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEvV4-0000LK-Sn; Sat, 23 Nov 2024 14:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1tEvV2-0000Kt-NU
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 14:08:56 -0500
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1tEvUz-0003J0-BK
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 14:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=cZ/yR
 KGi8ElueBb08IbglQTeOAV/liBtLU81OJaERLY=; b=VfvIQYRAY9XRDB4qN3NaR
 UGxVIK5eMzue2+QY2B09BmYlBEinzdKB1gZKYSvSRuUBKm0UW1e6eQoaEYWY4y+S
 E1lQJ6Z3mei5xjSzd2uIBouffbit54JH1GpLgquzH5+nZAvpiFD8WSIafr+KXGCT
 dyETqU8fvbSPuUSsrSQYb0=
Received: from ulan.. (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnbzQxKEJn8ENBAw--.3265S2;
 Sun, 24 Nov 2024 03:08:35 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: chao.liu@yeah.net
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, palmer@dabbelt.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: Re: [RFC PATCH v1 0/1] Add helper_print functions for printing
 intermediate results of complex instructions in RISC-V target
Date: Sun, 24 Nov 2024 03:08:32 +0800
Message-ID: <20241123190832.26155-1-chao.liu@yeah.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123183524.16316-1-chao.liu@yeah.net>
References: <20241123183524.16316-1-chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgDnbzQxKEJn8ENBAw--.3265S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVuc_UUUUU
X-Originating-IP: [39.144.154.56]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCwqgKGdBtFbxXQAAsh
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
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

Currently, the v1-patch is not yet capable of achieving the desired effect.
It still requires passing the number of variable arguments to the helper_print()
function:

     static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
     {
         TCGv src1;
 
         decode_save_opc(ctx, 0);
         src1 = get_address(ctx, a->rs1, 0);
         gen_helper_print(2, "src1 %x\n", src1);
         ...
         return true;
     }

Regards,
Chao


