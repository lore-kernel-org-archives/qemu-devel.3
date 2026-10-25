Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47350606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B2Giktj6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyiv-0002Pu-Cr; Sun, 25 Oct 2026 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyif-0002Ot-2y
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:57:07 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyid-0007KC-Hp
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:57:04 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36681e85e87so576111eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936621; x=1793541421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYMMwfEptCdF/p/S7c8Mici4skxqSYqLHy6oHt7gm+U=;
 b=B2Giktj6aERr2o938CILuGUnLFs8NWR/lB7ZFW9272nPBsXniMdwGxL1ROoHvSBVCM
 RFnvCqDashdCxHQSIHQxrsgUV/x4P8kjmhJSrzJ6M29fG1mAGOL+FUCVUB+F9FR8oRt1
 53lULMRm+HCnqoFOXZ5fm+FYQYV+H7wrYUi8YXkCWUcZcEM4sqoY9IuS8xQ9LrZsKUel
 D6ec+TSdwUAuYBRCZQvkMdbT8H4nDLH7YBsT5XsNK/TRpYM9yIZIy9Yay77mGjMtjAIn
 7WhPfwq9KfffZHj4p3GLtrEjoEhbVlE13S5VCpwgvaQrFJMJcq+LnVd41RzSOj6Gbz7H
 X1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936621; x=1793541421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYMMwfEptCdF/p/S7c8Mici4skxqSYqLHy6oHt7gm+U=;
 b=KC5pHvrewM9VfriqiP9gFTkvIXCqYuUh+WqIq2fnuVchhgMj2LBFjPOxvvS03wbqXy
 ZE0whrdm6nwoZbLLzU8F/LqPs2y22X38mDvIlPHWWAPxh27tDd77HYvyNxr1z05msrlk
 VQBAQxbPJ2jvMkPlL4uLUb8tZvEHRmZHnsFe8FBFqyGxUDn3ce9X1uWYjNLSMw2aW092
 XXKq07oXbrG9Oa4L7KQnE/DAWdfV+jSCAG/rNxvtL4NIMSRtqi7dX6hl5T9eOmWCzM82
 aOUjoZv4ZbpVtecnR1bPtM/sFOYspjevkv+TDwvSekdTDEZFHAqqoECvgZ1cQ9k3O5mJ
 kqPQ==
X-Gm-Message-State: AFq9FYK6Gfb2HtzgU1DNFk2ul1231+AHStkRbK/U4sF527WRVTfnvcTv
 jK7G7V0P1f99/MukKa3nikQqBlbbVksUt2zdMSODoqJKoSRR2nyCHcm9NhWqSviY
X-Gm-Gg: AYBFou182bEGCBVkdIM2pyd+URZtJoYonFtcoNw43mHRo/z9G3OlU8TsPHAqrdeu1Rf
 2fhbcO9Au3lKa+pmdgoXmrsUBSr7CHj00lHKx2iZAzJrikui+/dxJUyqfuame7o6UDorazhCERH
 h5JQ/+DuYiQS+u5yuXZg4TkVjGCTpCoI0eygTlW9I+oUBpha070xzk/VwjMXLeJNahCQx43skVM
 9GTuH2UMt+6Qgwy4pQn4YRTDZrCk2lVk7VdMVPwJqW/1ZUC6EhmlU6lEwMVWUIcXsBx/Hz28p89
 SJImz5E3H21apoGAomAOaMkIICakwTjyjwyUiOr2Z4h9Ga1g08pBYweXsE3yI0s91IzEAwovtlJ
 43CrFeGfF004L5C1gTtXbKtynYY6dLVZvRXAiPaL9M3SjcdU74SebBquKtcvNlA+3pZb6MTWJDa
 nuqrEQ+slpk+r/XLDpi+q95P5GJJxvjQ0ukyNzzuNU6GKb6S7e4RSflqxzAGql2XcpgUOsoqPcd
 W2vZDj+dmfH1PZ7xyvj0Lmmm9WfDCACdOoe0E9YopgkpVfNJAreV1k5XU6l
X-Received: by 2002:a05:7301:1826:b0:369:f126:9ce2 with SMTP id
 5a478bee46e88-369f126a505mr4180709eec.41.1792936620695; 
 Sun, 25 Oct 2026 06:57:00 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:57:00 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 4/5] hw/loongarch/virt: Fix UART clock frequency in FDT
Date: Sun, 25 Oct 2026 21:55:58 +0800
Message-ID: <20261025135559.236356-5-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=waysorrypub@gmail.com; helo=mail-dy1-x1329.google.com
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


