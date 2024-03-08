Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribe2-0003Hb-EV; Fri, 08 Mar 2024 09:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdw-0003Ax-5Y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdk-0005Ow-6s
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zgiv6UZ6Oh2NFmnmSITDqW1+MhIa91EcBCRfhCM6ng=;
 b=aVRaIv5A3PwEcl8efZnFKoP6krMmpbtF9VBHPf5Rfoai+SozXgP2l/5vCzVF+/3Gpp5PcO
 OWCS4+2R5ALMyxojfEDizAsbgRW2PajpQIoZ63QeIWOysjmhjTlCpI5j7qEdF7gv8qfhnQ
 xjTFifmDSQIdQczdESP0N6oC8oPKhPM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-TuwuWb9NMm27eDRNwgF0-Q-1; Fri, 08 Mar 2024 09:56:02 -0500
X-MC-Unique: TuwuWb9NMm27eDRNwgF0-Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a44460e6c06so48619966b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909759; x=1710514559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zgiv6UZ6Oh2NFmnmSITDqW1+MhIa91EcBCRfhCM6ng=;
 b=KUt45QBC5WYMfQvp2eZx4CPVybTP3Rj4EeezNf0tLjMS35C4ZXElBWqgGQhlYHlyEB
 Fk4uWZv3Gngiazb056jtxZ9e2bWb/LJ7NU5LQxkv+jY5vdJL6+Mujw3yvKWcJs6Flrpe
 t17X0r6fk3zgG/6wSi5HVqjDpnZ+eRqVJkcvO0SBIt31jYd/RbhhYLSAuNfIhAI09lna
 9o0MydF//opgje7B31qabO/NLbJWsrjsZAwmUgAerGbdz+Q6hCPBilQNJB7Wf+Hicyst
 KSjDsgnuoHbL1vJtmFKiSNt++AD6+ysRlrRYpD6/iAt9PWVMaBm2uyhToWODXr7H59Ls
 801Q==
X-Gm-Message-State: AOJu0Yw8QCeTgRbIPN5CE34LTZ4WQjN30o2SNzJD6E6HvHbfyHLSSN/O
 UnRcOZii0zkjkffGJPGlbg7kg2hatDiRuCHWlaNeZD8QEL/9T/Kq4YD759Qriksg03mN8D8H5gl
 W5ShT5Cog9hHdY6CWnDTzoORTAw9gPo5W3qNLFUeLp7jKapy+bJqBWYWoAxUDxrNU/5N5wj+N3S
 PYRTsdqU3Y8jjAIdXMT4bLXbnYiDBM7dApn/1f
X-Received: by 2002:a17:906:a18d:b0:a3e:7a8f:27dc with SMTP id
 s13-20020a170906a18d00b00a3e7a8f27dcmr13846407ejy.49.1709909759537; 
 Fri, 08 Mar 2024 06:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtS+GNEqrM015sAUrXbVWrcfdpQONUT2z+ICqCQEm/V8DUpl9bD3b/OPl75CSwHYd8UHHJxw==
X-Received: by 2002:a17:906:a18d:b0:a3e:7a8f:27dc with SMTP id
 s13-20020a170906a18d00b00a3e7a8f27dcmr13846396ejy.49.1709909759013; 
 Fri, 08 Mar 2024 06:55:59 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a1709060e8f00b00a45c8c9a876sm2119554ejf.88.2024.03.08.06.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:55:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>,
	qemu-stable@nongnu.org
Subject: [PULL 02/12] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Date: Fri,  8 Mar 2024 15:55:44 +0100
Message-ID: <20240308145554.599614-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


