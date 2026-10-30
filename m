Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A11606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmhJIQa2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o516KYgC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpwN-000513-Kt; Fri, 30 Oct 2026 12:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpvx-00050O-GU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpvv-0002ht-JK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793379506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXG8FocfoILerT5oDgJnEcrZzjCwKaQypTnyTMDxJ+I=;
 b=JmhJIQa28+w8EPbmpKdsbPEHuNjmeiQZZ9aHQiQeCe1cWN+ic4m2Xb53X9yAjjLl3EDhIr
 bpgQUdjI3AN1QXOcyhkBnqHr6HLBcCar3WmokcQRsh/679AXTC2CVmgGJKg0UNaUmTWcRu
 93mB25Y/UhBrC7piJGfARALZL/hRUC0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-0Zq-AlZaPESVzUWH5MpZzA-1; Fri, 30 Oct 2026 12:58:24 -0400
X-MC-Unique: 0Zq-AlZaPESVzUWH5MpZzA-1
X-Mimecast-MFC-AGG-ID: 0Zq-AlZaPESVzUWH5MpZzA_1793379504
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36998507c13so1430763eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793379503; x=1793984303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QXG8FocfoILerT5oDgJnEcrZzjCwKaQypTnyTMDxJ+I=;
 b=o516KYgC1PmXPNt58AAWQIi+o8dxjVervPtm/+cz4zBi46aIgQ7PgjgxEjkPV6BRPg
 L5Vt1572X09bImuBJFWn7O9osWNcTYtY/0kwNLiuRsDK8MFOjjeDUFsQ9hYWt3pxiIjN
 W7eQKCh3FxHAi8M6hYfYKAP7H5OoVrq1CzMSEkruGFYXhFJJGlh9igZldmMi2rrJyzuM
 W0+LqbMaDTIATyG7Zuammxfmt/yFF7VQFKG4YQ3aFGrr094curPYoWwpwFjKsmB+OaSz
 GSrRFUxWMw3GLcG5aYMcwvF6CXHmfcxCoVoSBPqv4e9QVbYAubTK7yqq7727DiikNJpZ
 xqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379503; x=1793984303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QXG8FocfoILerT5oDgJnEcrZzjCwKaQypTnyTMDxJ+I=;
 b=LgdUx5hw2scJilFDcJDo9EYBeq0gaJ/PZf3I5h97u7JA9jMjtNpr39cwdJagkB9aup
 GJ08OC3D827asS0l5thVouP/llnWpOBd9lnyXFL256GyjZcoAYhGAi5TQq8iaTS3Pkzx
 BbsvNM4ANzwFM8qU2a/kym7DpsiwqQG7MsBsTnFXUsSzE/6YoUFi2q6tEbtjPPdVf1SX
 YZaPe99NgGq7aC7G2NTDwuEG9IyZOko9+TneHDGo/pAkNeO6AyyaytKhSNwgjozkE6Sb
 Ud7eJHS7KfjCkfP7GkNs0dtOL3zo/1/pdPgcRpXSNXN7MoyAXNoiOhp7XTeML5oXuqlk
 xPbw==
X-Gm-Message-State: AFq9FYJFaov2EcPTg1oolnzMWRJ+1G66S5lLCGglWTX3Eyk4j9DL7HQQ
 cjtYLt4zRfExR/xykbnoxunYOhnOec19Hj2VnjRvAXlcjq+gX6cHXZo8myher/Iq7YiTM/hx+KO
 LC3yDlw8nZ99GaExjVefpSvsCTHYgbNBVx/8niI0qDTKNtSIpWShJiBva6sNjO6GxZisf8gtF5A
 QiwmwqmjbWvV2B7zJyRy9RNY425+V3ZMqiCpbJOINZhw==
X-Gm-Gg: AYBFou1XHBE0+kE1kiPQ0biQ0oC0ge00zQXCy4EjdITcIByAnhOWNDlFABNms5z5okn
 2LdDKJxq5CBwMiPRbJ931TnaYKabBWr+yiJaTMnc7pN50c4h2Cup0kCz3lFcooc3+CvtHINwVDt
 gaHVSSkNiqWkVEU3/2fxtsiS7J+K81257eNLN3k+GJOoVQgfJi2/Wed+ZrgeOeq+qfEMv4LBY10
 Cx4tOS422zZ6IAstRcjeasF0dejJpQi+Ss0oxjNuVogvkRbvWDBW7gh1F1J46b5m7vXJ31T6zvO
 bZbZF/fit+Wp5d3VT+jR+KGNFnbpU+v9Bv9gqlDKNixUpyYiOHcNnvFC3OYNKzpzpc+x8cmLqgo
 62S/ZWEpubT8x05bhD7MUWdWfdrqAd38BiW2Qg8JiVm1NHQ==
X-Received: by 2002:a05:7300:fb02:b0:358:5bc0:4f08 with SMTP id
 5a478bee46e88-36a425f611cmr3571806eec.37.1793379503460; 
 Fri, 30 Oct 2026 09:58:23 -0700 (PDT)
X-Received: by 2002:a05:7300:fb02:b0:358:5bc0:4f08 with SMTP id
 5a478bee46e88-36a425f611cmr3571765eec.37.1793379502740; 
 Fri, 30 Oct 2026 09:58:22 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm9254604eec.24.2026.10.30.09.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:22 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Tommaso Califano <tcalifano@redhat.com>
Subject: [PATCH 1/2] hw/usb/dev-storage: fix hang with CSW queued behind the
 data TD
Date: Fri, 30 Oct 2026 17:58:05 +0100
Message-ID: <20261030165807.79423-2-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030165807.79423-1-tcalifano@redhat.com>
References: <20261030165807.79423-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The storage device hangs if two conditions are met:
 - Data phase fits into a single bulk-IN transfer submitted to the
   device while the disk read is still in flight
 - CSW bulk-IN is submitted (queued at the USB endpoint) behind that
   data transfer before the read completes

Under these conditions, the SCSI request completes synchronously from
inside usb_msd_copy_data() and usb_packet_complete() processes the next
queued packet on the endpoint synchronously, so usb_msd_handle_data()
runs again before usb_msd_command_complete() has cleared s->req. The
device sees s->req still set, takes the "still in flight" branch, and
parks the CSW packet again with USB_RET_ASYNC; since the SCSI request is
already complete, nothing will ever complete it, causing the deadlock.

s->req tracks the SCSI request, which already finished when
usb_msd_command_complete() is called; what follows only concerns the
USB transfer. Knowing this, the fix result is to move the s->req clear
from the bottom to the top of the function.

Fixes: db4be873d312 ("usb: maintain async packet list per endpoint")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4658
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-storage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 040cf15051..620d02a4a9 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -273,6 +273,14 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     s->csw.residue = cpu_to_le32(s->data_len);
     s->csw.status = req->status != 0;
 
+    /*
+     * Drop it before completing the packet.
+     * usb_packet_complete() may synchronously run a CSW packet queued
+     * behind it, which must not see the request as still in flight.
+     */
+    scsi_req_unref(req);
+    s->req = NULL;
+
     if (s->packet) {
         if (s->data_len == 0 && s->mode == USB_MSDM_DATAOUT) {
             /* A deferred packet with no write data remaining must be
@@ -300,8 +308,6 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     } else if (s->data_len == 0) {
         s->mode = USB_MSDM_CSW;
     }
-    scsi_req_unref(req);
-    s->req = NULL;
 }
 
 void usb_msd_request_cancelled(SCSIRequest *req)
-- 
2.56.0


