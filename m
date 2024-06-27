Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A24C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwe-00050e-Ol; Thu, 27 Jun 2024 06:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwc-0004zt-SN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwZ-0001dF-J5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70685ab8fb1so3516344b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482489; x=1720087289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDqAmBS4P/7Jqnzeh6wlGENLL0Hv6eaUHFS63phjrpQ=;
 b=NwGhQWC+aEeafpnCFumjA4mAAtu1xoWHHBKYHxbSGwm/63/Bwh+06y/H6XNJkMQwgV
 l+WjletZaU5aoncMqnosAaAxioTrFCwaKjgOqizLRay5BvlL8V3Rk0fMiKtUlfDxiILw
 VXGxkpsQKMSfsAtnufsqIB1TgogO8Mtl+q7lhijtfYq8H1jYO0EhtxOBmhn69z1QENNF
 LBHzOShfFaqthOwKvuIVO8zmj3+Run7de6/rJ23wjFYVk/E+FbxjO1QQTIBDtyM2WdOp
 z/9eBV8yRRVy0y+wYyvP2rvPqhNjc7SEgefutbEjByY+mBjS+fbOynaGlo87+LQQ2pvn
 oqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482489; x=1720087289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDqAmBS4P/7Jqnzeh6wlGENLL0Hv6eaUHFS63phjrpQ=;
 b=f20amrJdljXN+Wxd3VrY27cLxLZH9v8bx0dRzXB0cNbnXKFsRC16HFPxLt79y2+VYs
 zP0Q487iwhqszUgpGDBwJWXLYXwmaEAgyFGZ2iTW7Lc6DugeLwwl60heyrt0unMoCLjy
 J23+WrI8tob2yXCvhoBZfjUW08REHDXs93GuT9U2ujVG4/tKuuqm7i8MQYn0XSoOqz02
 +yZrknv5U1cmG2wifPn5tRnXYwZmng6MN2K3Ps5d9faV+aycjzPCkh2Eanxd3QeeFHwC
 qZ8eTEJiD+i3cjisUyRYptH/NLq8JDZsFfppcEVuBOgIbCvfwpnD5tkoqOsx8ur4pv+0
 DL9w==
X-Gm-Message-State: AOJu0Yyr2KXemzs8cAJacIlNxdSeMhzk7FT/17gF1B1kBBdQYX6aRwKv
 WP4pDw4UM1ZpSyZofy3jNfxRSh0hMx325mnZPdZWTMuMb5/tK7oo0fTv6tpt
X-Google-Smtp-Source: AGHT+IFBoWHFZfN1qyNOpp5kKQjNBe/z0Rb8qJMyEvhMj2ZtVT7/RNK7kQAygytkV84Xwgfs05BpAw==
X-Received: by 2002:a05:6a00:a28:b0:706:a89d:e98d with SMTP id
 d2e1a72fcca58-706a89de9f9mr5650135b3a.31.1719482489275; 
 Thu, 27 Jun 2024 03:01:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/32] hw/riscv/virt.c: aplic DT: rename prop to 'riscv,
 delegation'
Date: Thu, 27 Jun 2024 20:00:29 +1000
Message-ID: <20240627100053.150937-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The DT docs for riscv,aplic [1] predicts a 'riscv,delegation' property.
Not 'riscv,delegate'.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 746df3f294..9c6b39b7df 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -640,7 +640,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     if (aplic_child_phandle) {
         qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
                               aplic_child_phandle);
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
+        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
     }
-- 
2.45.2


