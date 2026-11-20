Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E8606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjBAJQ1J;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UouoOS/d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3c-0000pI-1j; Fri, 20 Nov 2026 07:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3Z-0000oY-Nw
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3Y-0004kt-1S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=YjBAJQ1JSLgr7UUdKwg8DvWhsdXGBPcSDYt/uPxAGKNPvR4rmtVg019oafRNwFtogPdyRa
 lsx/1u40w8LndDFnnzPRyhTHX4LSvSwyEP5Lm1Mt8ehZctOiAPy772HZbyF2p+U4bIQYpK
 95Nhh1V1IhCd82Mmil4BaLwG3dB6Qsk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-gY6RuZuzMVC4m53dqDjf0Q-1; Fri, 20 Nov 2026 12:49:28 +0000
X-MC-Unique: gY6RuZuzMVC4m53dqDjf0Q-1
X-Mimecast-MFC-AGG-ID: gY6RuZuzMVC4m53dqDjf0Q_1795178967
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5364f562140so16446081cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178967; x=1795783767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=UouoOS/dvArxogHp1PEfq9zdA03VewZ6DcGkwaBvYwO5Mkx8NTMOsj5U+ArzytdFlf
 aJA25G5G5PnpZpyFT/mqoAZQXUQQKOx641vtwuxqqMroUte4k7IZdhgkJLxrP3EzCGOR
 ZVkR47Ya0voeBq7imeYAJRXEyYu8ZrCcBLr/QFdpX3qhEOshKkTyapEKNVGkyKWC11My
 fcY0H05aDcHbu6C6/Ir6KGESt8h2io9xt0O8qo0Gxf7Sz4bYhcohbxXXLuw59B7jcyhy
 swp0m3xYTGk004/VBa8igCI+DDo1Lcwn6ltbEK/ylGZ3BrDWNvhSBc8ijR+nFzvz9So1
 LsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178967; x=1795783767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=lFeUxNa31dhkQMRy+gKUvvfsCKhary+hLTPPib2bwkDorDw0ZUrBFxRgwREvyzxIdh
 1xl0PQBmqWsbIuyBdE7d6EqKpym5wiIweXLBbyOgoqWPWwA1fa+a6+oALThgjSzYWIj1
 18vDBMlzKY9JvT1gdKXjfZQGOVyksXX4EN5wDKirAqCWGpS2RZozCMEBhju7oqV+iYqk
 PhEN8mxvlTcoUk8dOTe+ULQxQKfkLubvqIXxw8xv+9ICFoOLijrZpTFGG8DrJBND1o8K
 AbtNKyiS0B25UEJ45Szh7OfR2h7qd5cfeD7lIc8aimW4d8wOWl0OHrTngQ5O791fpAuv
 va3g==
X-Gm-Message-State: APuU4Z9itrPq6pSbo9hZ0vzkQw5ORxrS8aLVbhc4vQp+qjpXPWUSw5aO
 Au1rmn0FddER6xcVJbluoesCDoMP8ElFcGjhcegqABl8tdxyRFAnZMDhR6RV12hI2dlfDTGHRwz
 d7Uviavz/jAUMw1mldS6uN4JWwg6JKcK+iO6fWD5Q1330DDfTHCc38Q6kSk+yYmsdKQguLzNTYe
 2eWvHvzRuyooJXNK3nKBnFkU2HKIebwoC39wGk2A==
X-Gm-Gg: AYBFou3I7xCF60U6CEqhTylLFBrWSjYXJxp5xVlxregU6k7Uk/fQzkqE5zk+LFh+fwG
 XKtl1N4QeAKzpkwgdDheENcEHqW9aq5nY9ZUzNiDBa9felbnSay7lKF8oPtBWTWPnfxRXXZdU2d
 iap8JZrGjaEc3+yOgc4s9RsPjF0Z1+gYDgmBpF9FoqqnaeEJ6gP/mKxmmPyBIZbb0+zCgzIkDWL
 kWs099NfG+fn6n1fqLgBiM0cB+HKPgWreH+0QWFNr9JVG65HnuidXWIBKV0odVj5UfUJMEPvwAx
 cI15b42l+7SoeIsIeDt4DpUIItotWYRZrKeUk1/Wg/rdK/IJz0LeIEDHhfqDSiBAjT8AP+g/FJj
 bYaobT56V8c/nT9WARuFmt8k9Fg2agkP3ggaGX1TDmuGF
X-Received: by 2002:a05:622a:e3d6:10b0:55d:8483:6993 with SMTP id
 d75a77b69052e-55d84836b15mr3114821cf.18.1795178967356; 
 Fri, 20 Nov 2026 04:49:27 -0800 (PST)
X-Received: by 2002:a05:622a:e3d6:10b0:55d:8483:6993 with SMTP id
 d75a77b69052e-55d84836b15mr3114471cf.18.1795178966721; 
 Fri, 20 Nov 2026 04:49:26 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e2d1sm21547311cf.14.2026.11.20.04.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH for-12.0 1/6] pcie/aer: Remove the usage of VMSTATE_VALIDATE()
Date: Fri, 20 Nov 2026 07:49:18 -0500
Message-ID: <20261120124923.1656220-2-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120124923.1656220-1-peterx@redhat.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paving way removing it.  We can replace it with a post_load_errp() instead.
Tested with migration with "-device ioh3420,id=rp0" against pre-patch,
which means migration compatibility is unaffected.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pcie_aer.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 43b14c1f22..87248556d4 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -807,21 +807,51 @@ static const VMStateDescription vmstate_pcie_aer_err = {
     }
 };
 
-static bool pcie_aer_state_log_num_valid(void *opaque, int version_id)
-{
-    PCIEAERLog *s = opaque;
+typedef struct {
+    uint16_t v;
+} tmp_u16;
 
+static bool pcie_aer_state_log_num_valid(PCIEAERLog *s)
+{
     return s->log_num <= s->log_max;
 }
 
+static bool pcie_aer_state_log_num_post_load(void *opaque, int version,
+                                             Error **errp)
+{
+    PCIEAERLog *s = container_of(opaque, PCIEAERLog, log_num);
+
+    if (!pcie_aer_state_log_num_valid(s)) {
+        error_setg(errp, "PCIe AER log num too big: log_num > log_max");
+        return false;
+    }
+
+    return true;
+}
+
+static const VMStateDescription vmstate_pcie_aer_log_num = {
+    .name = "PCIE_AER_ERROR_LOG/NUM",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load_errp = pcie_aer_state_log_num_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(v, tmp_u16),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_pcie_aer_log = {
     .name = "PCIE_AER_ERROR_LOG",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT16(log_num, PCIEAERLog),
+        /*
+         * Only to use STRUCT for a post_load_errp().  New code should try
+         * to use something look better, e.g. subsections in order.
+         */
+        VMSTATE_STRUCT(log_num, PCIEAERLog, 1,
+                       vmstate_pcie_aer_log_num, uint16_t),
         VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
-        VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
                               vmstate_pcie_aer_err, PCIEAERErr),
         VMSTATE_END_OF_LIST()
-- 
2.56.0


