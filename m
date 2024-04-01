Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F164CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrH0r-0004II-9U; Mon, 01 Apr 2024 08:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangcheng.work@foxmail.com>)
 id 1rrD1I-000888-JY; Mon, 01 Apr 2024 04:27:56 -0400
Received: from ec2-54-164-151-162.compute-1.amazonaws.com ([54.164.151.162]
 helo=qq.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangcheng.work@foxmail.com>)
 id 1rrD1G-0000nX-QD; Mon, 01 Apr 2024 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1711960070;
 bh=zxltDTD3xd6OWrA5aJVV2SK0MBNTV1w8I4bp6Ra9o1c=;
 h=From:To:Cc:Subject:Date;
 b=d9pIGWdSSiBV2VVgg0h2vPLufcgRfvLnwh0mHj+ZtbM/C8TyDHtJ8d6zCeCv5syv6
 wfMs14tNO165mtsXspbwYsI23+x1UjRgrH8Mk/98t4Tga1XcxtnQbLkETXDEhYdVlB
 ZyxnFt4yyhPiZD9KOgNTiDM9pZ/b/fsSElAJE9j8=
Received: from yc-home.taila82bd.ts.net
 ([2409:8a62:e78:44c0:8392:94b9:dc09:930])
 by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
 id CF81B6E0; Mon, 01 Apr 2024 15:51:56 +0800
X-QQ-mid: xmsmtpt1711957916tumjy7rhs
Message-ID: <tencent_A4482251DD0890F312758FA6B33F60815609@qq.com>
X-QQ-XMAILINFO: MKpxBSZQ33DDyFfeiiHm0vTGG9fNqyxcJZjtZVxOZJV86DeM/BXqp0YDKZL7p2
 tgjWyf3Ypr1hrX9TT6LUr3TeD95aB+Ls846PQUShxuqLLKvVOA+yB5dUU0wlcMisJHZaHe+fuKbp
 uSdFJmY6+s1Pz5PpAXedeJxwhIi+ebwNQ4m6zAYjBamueqjoS9iXmb+P9CZh40rmsDWONKgOq+HU
 LngnD9+7JGkuTZVBjySulzaamYmz18A+Ap1tEe+W6YBKigomoxvluS7ofLRRIbqudn9gl8dQGXfH
 uqjRRYhwyAflA2Jtyp3xWALjM6cv2Z8souwZzF3ddQIp2y1Tg2y7jq7b+hgnA7/yO39z2Oj6XsuX
 etHLjWkQ8+87VN9Nuvit5N5If8LDMDDC0zI3QQSlf6TFQfSmBEqrjA3y1tMTqGWwgMxGeMlfckKw
 wVRzdrxo+FiWU14XUtmHtgCd7Sm14buGF278CJsepPRPZ5eYeyIsvdrkm6U1KRPqAalTUTAayFZw
 CbC3LHbwunAA9fDI0CQgpODHn5dFU+dPf9HxWHG3/eOl4sCZZ+hDbCCX2ZZn258pZuoFGObNBlxg
 JLUZ4A24zcLCH/1Bl5ZG7k9VCNye55VRgb6wpZG3tBBYpknV2OJf4wiLRhaUyfMNgW1Me1s77dpF
 2xQzfCRRqtwqnTqjE6DRVMozZdrJiqyGTVlMC/fugQawG7gAZHw90ssZMFEFjC3sQiH/J3X6SVtb
 wFnYWfVmSLiO6NDqiH7z7sIjqyQVEeYPeW/Sj8I+MYVVIwT///tFgDj0sTU7elmLqdvs/8rFYUG9
 XIQHMyB4vK5iV7Vg2EeQt6JDqImJi0H0m5TraFAMO9v+hsFAlf67N40g/kefR/kTZMZUFqPY69tg
 NaY5xODhu9PSXlGmeJX9CHwGhmQuflUpKUm0LWAaSMxzqdYSvqOG+sBPJBrYBQ5YIlhd4Tqshf29
 TlKG72zxk5Dn76RAWcdVgCqg9zQFtrRx+6M4GU912NQZuh/fMQIm1sNYr2sQi8Xfp0I0V5QRbN96
 ymbNeSf0eB7VaYCv1LUoWvaTrps0+Fjml84iDyf9p4ozK+w6Fr
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Cheng Yang <yangcheng.work@foxmail.com>
To: qemu-riscv@nongnu.org
Cc: Cheng Yang <yangcheng.work@foxmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v1 1/1] hw/riscv/boot.c: Support 64-bit address for initrd
Date: Mon,  1 Apr 2024 15:51:22 +0800
X-OQ-MSGID: <20240401075121.3460231-1-yangcheng.work@foxmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=54.164.151.162;
 envelope-from=yangcheng.work@foxmail.com; helo=qq.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Apr 2024 08:43:42 -0400
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

Use qemu_fdt_setprop_u64() instead of qemu_fdt_setprop_cell()
to set the address of initrd in FDT to support 64-bit address.

Signed-off-by: Cheng Yang <yangcheng.work@foxmail.com>
---
 hw/riscv/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 09878e722c..47281ca853 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -209,8 +209,8 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", start);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
     }
 }
 
-- 
2.34.1


