Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC26606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k8TBxeF9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn9F-0001fd-Lr; Thu, 22 Oct 2026 03:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn9E-0001f1-Ac
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn9C-0008OR-Uo
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so355256b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653813; x=1793258613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYMMwfEptCdF/p/S7c8Mici4skxqSYqLHy6oHt7gm+U=;
 b=k8TBxeF9FunY6bSaVmE/Kq6QWvBp80JjHfy20IZhn9Q0nj1H/gp8an54/kLyJ0smUq
 9P28n6T8fLkhsgcQ/mSDJOJ3E1ukbx+KddNw2PPM6sFqvGgIBC+sf2cmV0FZeH3ZOT+/
 whjFglfLAgawkKuunucYwxz1omVMLPulnVfzuwf71jUk8OxUrXdEqdfDSWVD4oudwVD2
 Jfy3pgk7QvcbzURQ3Tj4D2kRZopDItpX1KyY4gPF2rgsex69UtgjWftIvSHn+YYvWS14
 5Io0vBpxX1FTwai2qcwP36FRrX0BqQRaQcE7fkKYsoMZ38fliDN2tQqcszgO+tq9Mz9x
 jXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653813; x=1793258613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYMMwfEptCdF/p/S7c8Mici4skxqSYqLHy6oHt7gm+U=;
 b=SzkQU5H7Ec2A2ppHbQZWosIDDzzuKOdp6awH1LmMnPIVkZbD9Z2/v7BFo1FmkHsy9W
 RE9APwcrZ5n6t87ST4J963M0dkf2htwEBUA8Y/OZRgMGuc27doTLMKOYDktpaBfT6Usn
 dUO4QCVBaQZj0IRsbXa8Z/H/6j9HHmLrouFOyHRIufIcOXcYhW1OmQNA+lgaaqKC6uA8
 nVLbC3sXSeqN3zaQO/fhl3Ul+/rqqNvTNQSFuOIyrXFikmLRZQBWtjY7s/ApzKEm3yOp
 Cm2erQBVoTsjUoGCinRuTa2g82E00cF6mAsik5E36e2J7eqILYlKb0npmjSuGSMRPSm1
 MbfA==
X-Gm-Message-State: AFq9FYLkGs/q8wUamrxrfkFLf3JtNtLFKY6jKi9X0T9omg7eRyrOQ1iW
 DoxQ3o/lMygf3rGOL23P5Ub3Osv8Zdu7+bJz+DoYziwOQ5sBdC9aR6uneqXw6QkTctU=
X-Gm-Gg: AYBFou1NuhNVDbcNg5XZO1fYKTGa87ibUHKEP++Abx84Bum/F7iYQXkRbqgj/AQovwO
 nMxUvh/Q3XrhVNcAQNEGWSV4gj1jMGjUoMIjwoH8xmSqPgq+HloB+5huc0sAgmMSLrbYe4mu/26
 7whZLufOzN85QQGA8UXFguBFlzz72eaOTxFkNFPby7GwSYA+93Pgjp8NMlmeMypVCyPcaLC44va
 wqASKocc9KcsOy0I0lN7VjtS6+F608CkrZtmi91Te3j+FUCdfie2Po2kItZmSsgnRHMVm3qwve5
 GrNvwITEayFs+uLdGki6f1P0iAKVo5Qa8fLgP8XF/njRA5k6tAEUbPtjUC3HfZGy8kjV9+VbRdg
 vsb6n1RaQc8T3A+GzIc20L7YL7IHSlvpiSSl8RbNRN9XiOirS9UebrY0R0WVUmZ2IgtzQRob4qh
 BugcF9/p4YK6DmRqJ+hr8+GNfZmNRW0XmwP+bVWFWhSy+uinlP5DBS3CZRZvfuxWAR0QFw8D9LH
 Phhz81EOwasjXwoA7UqH45u0VBtA83qP5gdRAcobjE2odkoPDKDUKAFB9+0
X-Received: by 2002:a05:6a00:1408:b0:888:cf3:e4b6 with SMTP id
 d2e1a72fcca58-8a0a047594fmr1010988b3a.30.1792653813334; 
 Thu, 22 Oct 2026 00:23:33 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49dcsm1699776b3a.16.2026.10.22.00.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:23:33 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v4 4/4] hw/loongarch/virt: Fix UART clock frequency in FDT
Date: Thu, 22 Oct 2026 15:22:38 +0800
Message-ID: <20261022072238.319308-5-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022072238.319308-1-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=waysorrypub@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UART uses baudbase = 115200, corresponding to an input clock of
1843200 Hz. Update the FDT clock-frequency property to match the model.

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 hw/loongarch/virt-fdt-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index c6f5d02..7be71e2 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -474,7 +474,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_add_subnode(ms->fdt, nodename);
     qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 1843200);
     if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
-- 
2.56.0


