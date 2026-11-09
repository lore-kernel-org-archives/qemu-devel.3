Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F6606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WcYfniqa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu9-0005P6-VS; Mon, 09 Nov 2026 17:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu7-0005ML-NP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:55 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu4-0003yg-UU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:55 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so1055704b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263512; x=1794868312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5441FuHsTE4+VNAAN9IpQ+nxMvPG4b0Qt/NjzEEnxOI=;
 b=WcYfniqaf/zZP6sGgXNEHm+NJKtu6wux/C0r3qZjwKihxgd1TgQUflzBIPyde0IqsF
 Z8fBb64eCZTG6Pvck/g/1pFQIrSGedsJtS8Ab26ilP781/3MBEvpVF5FBE+OAFm5oL0w
 9s5kpRh4neoWg4wC9upG9zfUeLxvmGOwUuOI/Z0lWY02BT9uAGeUx3nxCtN1ObCtcPKP
 GvGVw8Kf5PwPNVsqMrDYqNu0+W29SQxs4e2fjxIVqahJBEQ6oXB1p+d32O6da7wb4zPU
 rbh+exuFtTr5ybVh1n/88rfxfOKwrusssDTYA9HNtoW+bV5Vy5nEBKaKkCIqDMnbgcC8
 /PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263512; x=1794868312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5441FuHsTE4+VNAAN9IpQ+nxMvPG4b0Qt/NjzEEnxOI=;
 b=kVpU1VyxanbfuYKJIHczP2COhW0Pj6LyNzQwwFi4Phs3JlAVZ3iEzdOgxEo152l4DX
 UZpGPtdTQZ5Z1QCiOIu3plrxggqDVMejRy3RxJxZHX39iFtpFTTpWCZWYALwGyR1+BPv
 bInKkgEibeOzhWVSkHlnuQXNDrnG58/kaPNsOI6FT+9eRZ9xxtxCNl0j9dES9ICpH5JI
 Xsz3+DKDUTZC99mFN+HZCpoLU8/LHZ6y4mMF9qnReW7CdmuVc+0PrbAMmfx+uRPULhWe
 O7aSe9YAxIUMUOdgrjCsiFBJtKTfzoP3qrdSZFb1XTUYyISsNb94TQWzjPFgu2rEj8O/
 XOuQ==
X-Gm-Message-State: APuU4Z/w3W4WPAi1/sKe+Dv0QTsCTYS+1CMmiDl+2hiexQWzOLHWfohd
 zuyYENcwSsRR+ATR/5rWPPT+hm26WfWtPCbZxWYmNOJ+P8MVQuiTU+4hU3bWp1y2wi+naTE8fWj
 X/zQu
X-Gm-Gg: AYBFou39yrL3C4KstxK1eOr54fwyCFyIpYpKhIwvfW7FCqNcYa3NJzOB/p36K+TBrSV
 u9xL08C/yWFcdFan+E5EPr1fteT2ovnjb7otD9REpnU+vwpS6e1gIr3kyvhKIxIjpVLaBSPg16I
 Qadclx1CJVHl82LE8gIWGuiTEYWnWmETXwKO3clIbrkK2nBOK1mCzAQiDUBfLuZAGW8WPn/dIth
 xlrXCDM1Lq3bAeSHYPBN9VPilHzqLBFXGglWhJk5vhQ53Pjrfbj91B3GtLf6b0dYbxO2zYuKnsb
 BbeErPTIqoqU/c7/cCkt9t35nf0iKh/0ZuQENsLH/CRvaG858qQJIMzlmBz5+qH1DBT5lB1zMcT
 i/8qm/UsiE1LoZg+gCmaVsjr6i2A/fCU7oLsLFnDWNH8NGGuD6sNFbl+ceK+vJsUZdFmHvbmgmt
 IjbhQDqLcPgnPpiVV6BUh21tpWfZznscV3ZEFg++5EbuFyIWp2JbYFcKvUwrUrFqO1/C6fkEF7w
 eBd1P/xU45pV0Z5Cy2aMphsLEaQp4BGAmgmO+jhNfVFwfqWhF3igispjbyVGWJcJE7tlXPNWq91
 Oo62bBoNyeKKpCrM572w8xpqNMn1z/Ev3x0PPpnEjV6AgiDqehFzHw==
X-Received: by 2002:a05:6a00:2451:b0:8b1:1410:ac5a with SMTP id
 d2e1a72fcca58-8ba860d3665mr1012252b3a.13.1794263511627; 
 Mon, 09 Nov 2026 14:31:51 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:51 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 22/23] hw/arm/boot: Load DTB as is for confidential VMs
Date: Mon,  9 Nov 2026 16:31:09 -0600
Message-ID: <20261109223110.1619504-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.53.0


