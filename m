Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B978FC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 11:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt1yg-0002yq-DZ; Sun, 09 Aug 2026 07:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuL-00082z-OY
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuK-0005u6-72
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ccf2360620so6725685ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786256474; x=1786861274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/D6HjVKa4QQ4IcscIfUtE4RoMhIMfrZSlP4SYUTz+h4=;
 b=QN4kc31HTpuFAEKifULoD/+RYdkjkmiOOWv3h1sByKmpbBAHJ79g43HVD6jpWANCxi
 2nm/lC/+Ntovv/eBhEwZbQ1OvOGiEIFGNfWvf3z65OdSgpbSwmAGAWcpuDDoRktJQsA9
 RMMkmYnejoCObbamyiIfWpBEiNdplbhMpPT77Pv11tq3zE/DTIIIfm1sKLQaQe4KXkwm
 GRZbJs1UIT4D0bhpC8OBP6fhlfv3PysHbhUQcUZSCN1WJX2foyaYdNfwBSlgHwDxeik3
 lovVwTFbj7b19BVp5NYgbRvEtfuHSbOfNzhIxZ1X8h14dYUWTZEoOJGtFa2IqfSzCXKY
 Tydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786256474; x=1786861274;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/D6HjVKa4QQ4IcscIfUtE4RoMhIMfrZSlP4SYUTz+h4=;
 b=QXuPiEZ7BgCM8jjKZz2mCrDFPtf6OohnY3dPkpMikIuTRQLxVF1HhuZ862h+CGVDpP
 OVPQbeG4XYSiYzaVluj6TAZWhApCUuCFuXm6p4ApUPZoEJL4lLh6HLyNXHXQBbXDlgK9
 Yqm/HfqxUkquexBU54iylc+OEMEEj6TI5/Xa48klQb/2Kth6oyzyIbKoN0plS6TFowe7
 k8B/a2S1fBq7IBha0xCZ/3OdhODPvQFKswGLJE3RjZJ2q7Y36xXbhrxR+AMurECUgfOA
 TxT4sd58hOFO87mrXIJFSWSppNy9tvS343R8nU6Ux/7DxRLzZ69vmZsw3iIrv+lZoyiu
 HQ8Q==
X-Gm-Message-State: AOJu0Yw82BiLrp2iYE90lPgqDEAffaNwB/cAsFakODfKlAfFjiBkWxwG
 HhePeVxljH2zc3lj9S38pQvoemP/WN2TEDGJkOjPdCh6rY/MF/d3NxFyaioLseLxehBKDw==
X-Gm-Gg: AR+sD10XhXG/20yB9qyhAJK4zQtXCNKLHaivDf8eoGNYJYWTG5wiOMc5+/+7e7Y/S9T
 k8vKTBRxOvuSAflH7rhrlnZ29ZbJRIxO2W0cEIt0yqvfUOxdjrzOx6DPm9fwA9V/iSA51ZiiCFt
 sUaWijzbBIP8xbQ6iNwFpGKlT+eSlu3ZSh4qFVrPzjC3qR/dlJTz1oSgt+xVdOOAZ0Z6aVUVKOz
 PA3BcjrhWOQ93mjkeiy+Wq5GELpEz0GCjstFMaD8MSJaPLUgT3FNlDTQs0WZcHnyS7REMAS9Y0G
 ZOIhytCWCLVivqpTq0zSpkWTRhmMnTo1SSiKLKkReLZmVuanOcila1zNnEzHXhsrMW5CJBDWPMG
 2NuDWTtMoat3eId8j/Fp3cwVLQZdKmLCEZ0tzEAEmvjYluIIYMuM7fQr7f1Kuas5x55yWRUrMZY
 utYkDGk6kDbLs3GYkqfWCtxiH1c2C27TXGWyBrT0vrnv8xMIBmZvDO3DD3wJOUZlv1E2gTqF94q
 B26Eu9r/pQDfxp5eVpL5C+VPTQ4KvZ9
X-Received: by 2002:a17:903:1aa6:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2d106a18e41mr259197365ad.2.1786256474572; 
 Sat, 08 Aug 2026 23:21:14 -0700 (PDT)
Received: from localhost.localdomain ([159.75.12.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccac6d7sm21805265ad.6.2026.08.08.23.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 23:21:14 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 4/4] docs/system/riscv: document K230 CMU support
Date: Sun,  9 Aug 2026 14:20:44 +0800
Message-ID: <20260809-feat-k230-cmu-v1-4-8792982c446c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
References: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 07:45:49 -0400
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

Signed-off-by: Simon Law <0860734llx@gmail.com>
---
 docs/system/riscv/k230.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..dd50b0bd2e 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -18,9 +18,31 @@ The ``k230`` machine supports the following devices:
 * 1 c908 cores (little core)
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
+* Clock Management Unit (CMU)
 * 2 K230 Watchdog Timer
 * 5 UART
 
+Clock Management Unit
+---------------------
+
+The CMU model provides the register interface used by the K230 SDK U-Boot and
+the upstream Linux K230 clock driver. It implements the four PLL register
+blocks at ``0x91102000`` through ``0x9110203f`` and the defined sysclk
+registers in the ``0x91100000`` window, including the software-visible
+``SPI2AXI_CLK_DIV`` register at offset ``0x108``.
+
+The model implements reset values, writable and reserved bits, PLL control
+write-enable semantics, and write-one-to-trigger update operations. PLL lock
+and init completion are deterministic and immediate so that Linux clock probe
+does not depend on virtual time.
+
+The CMU does not propagate clock frequencies to QEMU devices or alter CPU
+execution speed. Peripheral reset, power control, and a guest-initiated K230
+system-reset backend are separate hardware blocks and are not modeled by the
+CMU. Consequently, a guest reboot requires the future K230 reset subsystem
+and matching OpenSBI reboot backend; QMP ``system_reset`` resets the CMU along
+with the rest of the machine.
+
 Boot options
 ------------
 The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then

-- 
2.43.0

