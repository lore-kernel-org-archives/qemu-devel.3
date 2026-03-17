Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AAAF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QAZ-0006zG-1W; Tue, 17 Mar 2026 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9h-0005xY-FN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9e-00034V-9U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8Fl8K5xVMIV8fIvOk6PNvwuiOGbIFsEtx62dX/yczg=;
 b=ZOsBNSqCsTRMa6whN8XZCS5gDc/lOdnbu/6RGRYJOmZBbLVgYbv58t/ZnJFYeN7wJw41PS
 7F8Gre2/9YlzKaWlIj9kBvMMv6sfZcggAhQBiqPQifFUQDplZmo2zd9VX6WdUXMmo2N7V5
 YlF3kPG5KYb5E8IBO90QUt3/zlq+TLY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-Dk-KjQS-PCS5zxOD-tlrnA-1; Tue,
 17 Mar 2026 04:51:55 -0400
X-MC-Unique: Dk-KjQS-PCS5zxOD-tlrnA-1
X-Mimecast-MFC-AGG-ID: Dk-KjQS-PCS5zxOD-tlrnA_1773737514
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61DCC195609D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68B5D30002DA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:27 +0400
Subject: [PATCH 13/60] ui/console-vc: fix comment shift-out/in comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-13-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Vr8prgUCfsOV0973iCYtnG03OIVCNzvWtGLvSrI4LLk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXamMWTuvpBaP05ztPSm92ZkBiQ/D5N2oFGO
 8d0XsntFdyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5djLD/4ufRxVBY6RbikVjsIh5TgpfQR5mFhGLFjD1FG7lW6ms+blHuY7LBBru5A3ocXM9uKXEtq
 /oeoGBxUW6SQCNYmX4/OV9l3tllyKlO5X+FxAMJukA8xbO3kyrjBTdDsi5NYCfHYBPGIkiOxMei
 lD6fEUOttfltj+GBgDC1ALJ6de7ngWw+PYWf5Zcuud3/tYSBdcSSKraDgCAcCnw2nmp9CCSwkZU
 ScuztmOnCSuXDGaeguTc3io2WFRBFhjBdmulSIov21MYh+yrCKtQRGddLSUEDZ5fJGL04h2fJqF
 Y9aU1VGUORdWpi+bd1lBXxGmM7iLmHct8DhVmffX21kdl/1hS/eOk4C5BeXYLNSbURfPktjoqcn
 1KagstcDNl3i0McFRR6vuyYYvh3TB5o6tVM3xVSclmPlts2HR+qNhbhaa3CMjjREV06EcW/1Q7T
 8Fv8cI9CWmcnhUqaxofy5VrGAiLiIcR07XJ1INfuSe7TBiMIKhpcJSxSf0tBfxqSTsIizcJSKK3
 +4/9vu0dZl3gC9ZeimfgB6Ql1N6e3rGAfvqCXLSIhCtHzV1mwE7DrjjU/ZWVCpT5k83vFkknRej
 yTsHmSEuJoaT7bP3fBZdTWPQqELc9jI46CkY8JU0uIt7svRTeiIRaYVBYmokcI74dczKGrkr33j
 wquqzgtDl9EWo3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

14 is shift-out
15 is shift-in

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 5eca9a5c004..fae8c8ce768 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -847,10 +847,10 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* TODO: has to be implemented */
             break;
         case 14:
-            /* SI (shift in), character set 0 (ignored) */
+            /* SO (shift out), character set 1 (ignored) */
             break;
         case 15:
-            /* SO (shift out), character set 1 (ignored) */
+            /* SI (shift in), character set 0 (ignored) */
             break;
         case 27:    /* esc (introducing an escape sequence) */
             vc->state = TTY_STATE_ESC;

-- 
2.53.0


