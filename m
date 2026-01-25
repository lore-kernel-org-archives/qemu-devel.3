Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044EE63CA0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk0h9-0005l0-6Z; Sun, 25 Jan 2026 09:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khurana.ridham222@gmail.com>)
 id 1vjvzi-0002tM-LF
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 04:01:31 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <khurana.ridham222@gmail.com>)
 id 1vjvzg-0002sZ-Dz
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 04:01:18 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so1767931b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769331668; x=1769936468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgY292WfjndhIqO+oMRoE9wZRdTpGDDfjPVXqtL+d6c=;
 b=aXLEy1J7pIU5mlH6u787VEIl5+7Mt+FMuNkHXdTffkJCLBORigZPmXgw91q11BTWvp
 9uRSYaPoI2tbyFgOOgjlD68+OEsTs6FJbP/dNEWUwdD1GhMoz0h+afNx2ZD+02k7fM4w
 gd0dyMmVcFfoAb73WVA1sBZJ3Sj10uExyf/PkbO+XzIL58rlcIf8EqjnyPSR5fWSp0+w
 mUSZ5w4kaEjHtLPGI6sWGuD6HOCGwSOr4WrdPbsN+LF35v5KhoiGq9ZqZE6ryV2n9eKs
 Up24oRdXLMAjN/lXUJqNCCJulBqMw5IFX6BG1xxu1ZeHjdlZ6G3UbK1s+AIps0LV7lTA
 XYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769331668; x=1769936468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgY292WfjndhIqO+oMRoE9wZRdTpGDDfjPVXqtL+d6c=;
 b=pNQGsZg0NrfaukcFrpuUj+3jm4CkwFqw0xre/2X05zx+btv2jRSYNevpTaFgE1ZWo/
 1VRfmUqDm09feonqxdoHsfsMfHEkAs8QC0Xcyn01asrMHFgYsZAVXoiXR+ICHoY/CpYf
 Oqb5UeSwTwGiiX+3Gyxp6VcDuFjvmhhivPPccaF6sOfQuPHz9EIMxYhaxpm49SvrnQU5
 Vg9aFN/5JoughIRVKsb0u4yQcOijHSXVp3WGFpcQlcfBnSJqJENRkZ4xphKwewThizFH
 agfqLr+npsgHSD6ieQmk/5RfuJ/RQmd2kjN3Kd2+JnpZDBSJWaG10feZqtQEKUkdJWzB
 Yt+Q==
X-Gm-Message-State: AOJu0YzAnZL0eegD/2bvFPjktsJdPLh8fKuiFsxNGylsXovLT5QMyo5T
 8sphUjjfL5FmptE3aY0q/mdyzUudpjrTJFqAUhC91xE4tVpa2RfJlxHj40JhZQ==
X-Gm-Gg: AZuq6aLZ22l+9ZoVOhoqlBJ8ORM5yeHjw14E2L9AfTdWDBiJ93WC0aqayMyVcL1ZGDw
 SXocxOG6fRLu8ZoL5G+IpF1UzN5HgZURZD9W8kcbnV97jywky8Ygeag3BmBIMDAnIaQlefOOc5Z
 4BbfpyKXSeHO6JDIWVR0CRMW7kR9bZJQ9hvQCgs+DRziwvPSIixup2AAf+a6gr2er1+s6NmNUjS
 qVrJjAPmf5MciYpPGKlmbvkjertKb7tZtEV5FOSwvVpVhmgqBOt58RpYClFvOhvRGz/3KljbNIN
 +joITUCkUyMOckWtjanpRAwDxvRE0Dy75LN1DzXILsjycWGNQxWzBPxVCJ2NG90O703PI43Nqp3
 IcbhjBDiI5kDqlescBnqnLErtngrlHcgDr88bfLbcQPej6gUcSARsA9i/iOtU6G055MA9XA0+Iw
 nHgKjCjo0lP0XFU00yweFjAQvvhDI9kOYIPh9ui185xw==
X-Received: by 2002:a05:6a00:9096:b0:817:9a85:54af with SMTP id
 d2e1a72fcca58-823412a396cmr973014b3a.43.1769331668177; 
 Sun, 25 Jan 2026 01:01:08 -0800 (PST)
Received: from fedora.. ([2409:40f0:1023:4bd9:3113:58d5:ddb0:62b9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82339095c85sm1912676b3a.67.2026.01.25.01.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 01:01:07 -0800 (PST)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ridham Khurana <khurana.ridham222@gmail.com>
Subject: [PATCH] riscv: correct fractional LMUL legality check in vsetvl
Date: Sun, 25 Jan 2026 14:29:34 +0530
Message-ID: <20260125085958.47957-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=khurana.ridham222@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Jan 2026 09:02:07 -0500
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

---
 target/riscv/vector_helper.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee8..eff349841a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -47,18 +47,12 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
-    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
-        /*
-         * Fractional LMUL, check:
-         *
-         * VLEN * LMUL >= SEW
-         * VLEN >> (8 - lmul) >= sew
-         * (vlenb << 3) >> (8 - lmul) >= sew
-         */
-        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
+        /* fractional LMUL legality check: LMUL × ELEN ≥ SEW */
+        int divisor = 1 << (8 - vlmul); /* converts encoding into divisor for fractional LMUL */
+        if (vlmul == 4 || cpu->cfg.elen < sew * divisor) {
             vill = true;
         }
     }
-- 
2.49.0


