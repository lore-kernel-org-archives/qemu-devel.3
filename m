Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E6F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEQ-0007J9-FK; Tue, 17 Mar 2026 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QD1-0003WD-TN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QD0-00074u-0k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHZNzWRxqxGiSXE7F2i8ljBio5nXXS47O7N1x/xGiG8=;
 b=SQRX2PHvVIaKBj7PZs2/IKl5/1VyAUBGBxcbxc9B7LyLzYkMXjIkxVpZpmbdNNFddExU+G
 PCRGFc42J+byk1AfQFpQc84YU9ZPd4CLuMz5VxB2yQ+kTKwJb5Jb22cetYoFfdGjx5nOdL
 sh5mIpQOD9dSnnJLzEcu9H8rVcTroGY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-LhebHe7gOB2rtAP-EFKC0A-1; Tue,
 17 Mar 2026 04:55:24 -0400
X-MC-Unique: LhebHe7gOB2rtAP-EFKC0A-1
X-Mimecast-MFC-AGG-ID: LhebHe7gOB2rtAP-EFKC0A_1773737723
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBC01800614
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5706A1800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:03 +0400
Subject: [PATCH 49/60] ui/vnc: explicitly link with png
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-49-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=638;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KE0+NAziyLdDva+i9ZPLvG9Nc6njG7yN6tsIU9uJ1Vw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcTS76s6R73NRkLV0ZmknjKYlHHQyancAwD
 LyeoD/PGxqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5chUD/9aLeVHHW2O6i/Dp0mT4u4JQAq+4d8NPb5Ny/Sw4ZfFQoMOVByB5d80j5qFpIE3i2oSBZn
 8OL0RTFmkFca9ALut2cIagBL6xh+PoR15sUSQb+B8wD/Zx0rBt8L56OcH35ybbc3lmBB6TSWW4I
 gqeeRJyej+xVVvD3zUeonsbprhOyLMqIT1yrDM6McCS07YnKbjpiR8AG+j4pa8PStfSj04+kPjp
 Q5Qyr7YYpmCfJhRKmrD22GLivFz5xty5Qu/vyXopCDtoqoHlB7+gzQNovmihFKSc5kx5h2RkkWq
 ahjWKxFTbPl3u63UMbzKsVy6eTKIQeTc+D+2LU9/sJ5e8A7wLbafyfdvjpQMlzBjaEgK7zNHhxT
 FCcL+FSLJ4PXUj46HkrXXPSPNPRljd7Te6FeF/Ma3BEmfRMciF9/+ESxHUxdNAWwhUkbhMQ2O73
 lteqP0SFCjgopjfTrUPvy5N4IWxTNHjJHOvsZumGH5SyZ+IW2JUKCcSs8sFjoUIR9MHjxi4BtTG
 mXwh935qEybm5XiCxyjd/9RdOPCDX2E0ZDACu46TsfVTBJaJzgiX6vpHJvdlfwEeST2I04JC1a/
 FdRF22lTz/hKq3QJdUDn2e4bhRRD9wcNuv/l5713cvi+pVwTUwm56RTxxNgkZh4jI2hEybY350x
 pmAZVfyY/blllJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The VNC code uses PNG directly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index bae6ea0d2dc..b31ddf96282 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -45,7 +45,7 @@ vnc_ss.add(files(
   'vnc-jobs.c',
   'vnc-clipboard.c',
 ))
-vnc_ss.add(zlib, jpeg)
+vnc_ss.add(zlib, jpeg, png)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
 system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))

-- 
2.53.0


