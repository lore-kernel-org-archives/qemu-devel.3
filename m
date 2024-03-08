Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A821DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehj-00077p-Pf; Fri, 08 Mar 2024 13:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehe-00076d-9a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rieha-0005nR-5F
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zgiv6UZ6Oh2NFmnmSITDqW1+MhIa91EcBCRfhCM6ng=;
 b=R3Dl5OWil3Tv6mrbFLl1G//UmrBvMzigLXQqCqIjRC/vcYPBj/6FRcLP4MNY3GQx3ex1lI
 D8CwaykPz+iArlNF55bO5mDSidQ4fG9r09MrCzW3OixBrnqHYCVS7a4RXbmU9lxCVUmFpZ
 zWPTXwgizww40RdPO/Gddm8QL8ayxbI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-e02MUPo9OSisFZBaEPB4bQ-1; Fri, 08 Mar 2024 13:12:11 -0500
X-MC-Unique: e02MUPo9OSisFZBaEPB4bQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a450265c7b6so142675066b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921529; x=1710526329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zgiv6UZ6Oh2NFmnmSITDqW1+MhIa91EcBCRfhCM6ng=;
 b=mE/LcDqSVMHoPdEO38mNG5PXO9l6t5bHKPePuYGB5zMdR9iasS0rMDseSN/gWYWcLi
 CHotN7664ae80XMVfQQDbx5uCJSy0GcKWeeZZ5OGlwQXMXhlTIzl4D/O+CfFCr7hqiNn
 UcxtpIcqFGAUPAr5tqmw3Y7ws3ThtReyh+rRAwwWeGUhwfHqLv7rTpEyL8kVc10rbFIc
 0YwR6Y3EAjqh6sPyNTPvKSHZXFW09AmGz6C7kV+qLjBxmmdLGzPGMDjOTxm9QyzQkuU4
 cTrNuevJUgO/81jup9SaP2WSMkdHhrROngzr8juOlmaSpB0nVWtHP9c6Ix2v+IDz3wAQ
 yBmg==
X-Gm-Message-State: AOJu0YwS1eC/4S0vjHi+kjuTl5DKlzPdia488IlnNknJjw4R/sJNerCV
 Le3djbMGw8MbvLT7tkwMQFe9dpL9TJbPbei/466EL6O2BnWJ0tt6ccDIgkIurcf7klaE76Dzise
 tzAbii6B0n5hvQDqr53QNGAwj3xWDtG95QUKpRnZyghq5xEmRmoYX3WhUqib/5GVtrmNpryp6ON
 FzNXlB45QpmfMczXctGeNQjPoQB8s0GLZd7pqG
X-Received: by 2002:a17:906:5a9a:b0:a44:48db:9060 with SMTP id
 l26-20020a1709065a9a00b00a4448db9060mr13864474ejq.19.1709921529511; 
 Fri, 08 Mar 2024 10:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYXYgTpjHVOuKD6hlcLFJDwpr/l1BA+IeuIzlRiODg8q/CRESZpSO+iBDeDanQBBqO+b9I+A==
X-Received: by 2002:a17:906:5a9a:b0:a44:48db:9060 with SMTP id
 l26-20020a1709065a9a00b00a4448db9060mr13864461ejq.19.1709921529115; 
 Fri, 08 Mar 2024 10:12:09 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 qk2-20020a170906d9c200b00a3fb9f1f10csm34462ejb.161.2024.03.08.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>,
	qemu-stable@nongnu.org
Subject: [PULL 2/9] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Date: Fri,  8 Mar 2024 19:11:54 +0100
Message-ID: <20240308181202.617329-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>

Original goal of addition of drain_call_rcu to qmp_device_add was to cover
the failure case of qdev_device_add. It seems call of drain_call_rcu was
misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
under happy path too. What led to overall performance degradation of
qmp_device_add.

In this patch call of drain_call_rcu moved under handling of failure of
qdev_device_add.

Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Message-ID: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Fixes: 7bed89958bf ("device_core: use drain_call_rcu in in qmp_device_add", 2020-10-12)
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/qdev-monitor.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5d..874d65191ce 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -858,19 +858,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
-
-    /*
-     * Drain all pending RCU callbacks. This is done because
-     * some bus related operations can delay a device removal
-     * (in this case this can happen if device is added and then
-     * removed due to a configuration error)
-     * to a RCU callback, but user might expect that this interface
-     * will finish its job completely once qmp command returns result
-     * to the user
-     */
-    drain_call_rcu();
-
     if (!dev) {
+        /*
+         * Drain all pending RCU callbacks. This is done because
+         * some bus related operations can delay a device removal
+         * (in this case this can happen if device is added and then
+         * removed due to a configuration error)
+         * to a RCU callback, but user might expect that this interface
+         * will finish its job completely once qmp command returns result
+         * to the user
+         */
+        drain_call_rcu();
+
         qemu_opts_del(opts);
         return;
     }
-- 
2.43.2


