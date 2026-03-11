Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA6EFD064E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0EBj-00058P-Lq; Wed, 11 Mar 2026 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0EBh-000584-Nu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0EBg-0003t8-2E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773214859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
 b=Bl5BN53frCCh/gltcwqvn8iG/cUQX3TyvY73kQ9Rm484Un6lE2OdIzzORownp7+GZRWuZ/
 wrD7TX7pnA+PQ3EgGha5nIzG55dLzUCB0YTyyzyXURl3RbIW7Bfzcl0lz2tya2JCNzjagR
 yAhnqD8PpM4fKBavu1wXGSwSy8DHKCQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-dFZPzwV6MDWrtf5xamITWQ-1; Wed, 11 Mar 2026 03:40:58 -0400
X-MC-Unique: dFZPzwV6MDWrtf5xamITWQ-1
X-Mimecast-MFC-AGG-ID: dFZPzwV6MDWrtf5xamITWQ_1773214857
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ae4cdfc468so100978395ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773214857; x=1773819657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
 b=n+z07RSO5/B9HtvOxkvIWwSHm9Rz2Yd/i+8MuGy9BsQYzSbhyqhzV2dbaP1+abazy8
 tPq2P01evmBu8UN44mFw7npbheXzxbpBu7BmjDJcXmMlbvsZBKbWYxdDyYTEMBSn4H+0
 IhHSgYtZrFtfF+LojP8/aiAJDYwEzZDzbV0ucsnsvVp/YGMV9PWMHhA/QAD7C3Vqx+1d
 UwZz0MRO71lPMy7Xvf8mngd1WCNzqKejzzeqv2ZL9uKzO0Q051kESAewf0Mnv/1qKFQM
 CrgHLlCoJ5NoX0RiNgo6MFZ10igKrKFo8UiQlYdHwbHQM2+U9WyxdVDahfMMQ8MR+h5E
 ZWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773214857; x=1773819657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
 b=CnSG+FODkLz659AgG8jyGycx2tvG+3cCgOGZagyz5hK886fVBie/luPWvb/FtujAaX
 /X7SR9JYOvQ7DOiXQ5zBXpkTRzpViKTslLxd+MMwbi3PwGKMLSqRmvBCBM1/Y3cxFr3T
 3qn6g+gUx9Yao2JhmxWcO4QKqnV/2TuUuxwXFLmGNr8TrsJp9dRE+v4JzRElCJE7AMa3
 cTKABr4ucwbvKK1nUpMquVjRdly73OeeAgGnZUJmRr5voudX85Serwc1LA+XtO27rUZb
 dLHy9Vnc8vSjexDOoxSDAoQTxZtGFwf8X1Z2Kdu1lBjrYgeWxmS/RfvuJoh/YZcUmTl2
 Gw5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHqtjDSd2Gt15xYNMyCe+wphQdCveaetNZOauI/FFUPn2CyvwHu2ve+ir3pS/cnxfFq+v0lPh2yld0@nongnu.org
X-Gm-Message-State: AOJu0YwXY30bG4ZiUWiWkaCIWzADbnJmba7hHuS2c0Iqb4VvtHYPegYa
 HZk+6T/vWMDA6hSH77flWLHOnuPa3g2EhqDYQQxzTq14lA9kFFtCIW+Q3dUUasuyrHtfcbfBH5f
 8Jj0O5px3TEq3EeMrDLP0Xj5NWIKBBqaoQNf809AnVnW/LUPRgyPk3cSc
X-Gm-Gg: ATEYQzy3LtbzQ/3btbpZlBr8ziwjhTFJjvk6OSKpB9SorWSZY8pa9gJ97i/T3NkZ/SL
 vNbYxWhP1h+nepTj0/+hv1ZapJvDfooWcdI8gWUHLf2VzDUwU1FeeQex/XVlXJc1VrAJo3RdCvQ
 3Dr4nG71k6GBovOv1XhrwSXNh4YpcMAxOWzAikmZUOxhfhXn7axHJNlQlf5eF6kxchnLuhPwfDA
 E1F8tmxojVATEfc4QH4Dj/3KoD2tFYwVtyoDm1H12H/nXDQD6tpYCZSfF8IjIRP6PvnBOS/WXHq
 9my5iqiS5K3eLWeWJT9jzWDCiNYYuxSh1d34PsKBC1e9WxHNeLRD9mIJersv2DVV/H7ZB5GNn2A
 5Yb8wCElrxa6e5TMQfGFBhyTtv8UOYxoUkhi0CLyUYBRbXmmRbTLCqh0=
X-Received: by 2002:a17:903:32cb:b0:2ae:5797:e082 with SMTP id
 d9443c01a7336-2aeae816f54mr16844225ad.24.1773214857043; 
 Wed, 11 Mar 2026 00:40:57 -0700 (PDT)
X-Received: by 2002:a17:903:32cb:b0:2ae:5797:e082 with SMTP id
 d9443c01a7336-2aeae816f54mr16844035ad.24.1773214856615; 
 Wed, 11 Mar 2026 00:40:56 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2aeae34dff2sm14849995ad.57.2026.03.11.00.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 00:40:56 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v3] coverity: fix coverity issues related to confidential
 guest reset
Date: Wed, 11 Mar 2026 13:10:48 +0530
Message-ID: <20260311074048.61367-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix issues reported by Peter.

Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest reset")
Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 5 ++++-
 target/i386/sev.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

changelog:
v2: fixes: tags added. reviewed-by added.
v3: fix double reviewed-by

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..ca6730d111 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
     ResetType type;
     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
     bool guest_state_rebuilt = false;
+    bool force_vmfd_change = false;
     int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+    force_vmfd_change = current_machine ?
+        current_machine->new_accel_vmfd_on_reset : false;
 
     cpu_synchronize_all_states();
 
@@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
 
     if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
-        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
+        (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..9dde972c11 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, ResetType type)
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
-    if (!sev_common) {
-        return;
-    }
-
     if (!runstate_is_running()) {
         return;
     }
-- 
2.42.0


