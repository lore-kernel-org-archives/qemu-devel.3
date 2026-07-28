Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946DC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonUE-0005Ps-JH; Tue, 28 Jul 2026 15:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSZ-0003cn-HK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:31 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSX-0001eJ-Qx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso161195a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266844; x=1785871644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
 b=D8omu9Du/0UkorCtGyhr73TtjY98gEmaL/qXwyorjycBqE/D8xs+aguGR6po/XCZkt
 GMYHvK7LOMWaezsf7tcWoq2J199u7rz4foCJBJDYLS3Gqv46UyO2SLJV0UlW88J/b3CO
 Y7hcL7SKBQOgv7FbP/AyO5PMyHHPkjqdGm+sa9DuCaIf8IK1+cdUzlwjC+8HXwck51YN
 Y1M1BvlHwAxbOEQZAXycyoQcTfIAwL1tIpXEjgkiHiY28yC81z3PayEJs94hYpIxbZnM
 r+Nswyrlr91NyDtSTqWgI0mztzL4bI8FmDpnOarWhE962t/c4iha1wOqCGhoVxr8BoVq
 afkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266844; x=1785871644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
 b=FAxrOX4ZcZkL/6s965ARvGVDEI6zHsPyLRBuqhkAdo3ZzyPga0nadtpLf5pWtuMeg7
 i+mfZHiEceQpm0tVD/r7CA8Cjh7lsRmxfOFR/Ipdso/iu1+XW07/XFQmfnVLSRO++huX
 SpWRI9OTsKPqHy6mp/tm0PTyMLYZ+BSeoVW5gPViXIcxi8BPZYsHXnAusn4oIrRymBv5
 DmpyGfCQYXvjsmDS/2L3zlfw/XsmrvdW1LLagAjIKJvfOaZwTyxjyNsoouHirPH/7lQC
 mtaHpzn09CbdClsWCFYWA8fDo5oDkqKqKDstu7pAD6fKVNymF2j5i0GKusFds/dGFxBs
 1Jcw==
X-Gm-Message-State: AOJu0Yz5JbeEG6gQ2hca8fxrq2zqxiH38DI0tRbIEzocRPYEvgTc12Lm
 pHBihPg0svUyqFOUiaUWVq5wKLI1zJ0aYckeEBkagpEOC4uBc2O0nRzzwkicDJaHBx4=
X-Gm-Gg: AR+sD12ii0mtGTV/kR9XB2SbAjdcTKXMxCiB0EU04K4XeqI3/3+vj9Tysd6F0u/qmHn
 kCz2aS9XYnIKbGVH0U/L8xuniwep8NZgRTqTFcwFnSFOGgPi/Kly5LhpA7BeGRmA5BXbEypprYW
 R+kMcWepmM5T21HecRwer17tdemRLM1ZhA4WuVYce2RFYVqm4qKu0m3ubEW8jRQNDGfgKVCuIP0
 nvYIpNy0Tl2YOF9CucV7HHHqh8LJnc2M/ZZLBuw4u7bS6B5HCXJ+/IW6+rIgx71X8HjAQbC5xRR
 0nVzoHykvg4kNQ5jL3k2tzknSsNqknl/Roi/W7OLKVvS1cfahfDaTrCCu0aCJ2cKjSpvnvBj6Ul
 DRkU0VL8LCfeHN4VQz+OSrwhMY06ULo+V4wKMPNxzBvNd7ki7aYkVrlAQ4sTx6Jv5bOTh8436hA
 RKjYZdqvCN+KjWjFJ5fwV/jpHi7yx/PVqyxsyScdZGxQe07y7DEetrbF1g505qet8OoaefPIHXU
 1eBUvkOdhfRzWc=
X-Received: by 2002:a17:90b:5864:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-38f6a1becc7mr3877953a91.0.1785266844304; 
 Tue, 28 Jul 2026 12:27:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:23 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 23/24] hw/arm/boot: Load DTB as is for confidential VMs
Date: Tue, 28 Jul 2026 13:26:29 -0600
Message-ID: <20260728192630.240375-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e8efada209f..9b3d3558bcbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.43.0


