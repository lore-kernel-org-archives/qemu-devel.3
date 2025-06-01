Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB523C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZO-0002rr-Nb; Sun, 01 Jun 2025 11:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZN-0002l0-BY
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZL-0004fl-NY
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dAlrl0LtxfLCgi64pVTEp018uC/mUt8mFKXJwY2ZbY=;
 b=gbJN+zEZRFgg7oUtdT0QXDXkE+KJnKN6up/FQF+Mg8YzPbThwSTu7W1fYfjq1sSqy2pdBq
 Me69TmMxdaI4biqwWcuRG6cK8epxNjaXtMpOaCOfkSF9a9Mf4sfd1OdFwXOv0GNhiA3wH1
 jyoCKScuWmPmG7BJR/83Dt7Q4lRi0jY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-mEFfjfG_PIi4Fs1IRjcHXA-1; Sun, 01 Jun 2025 11:25:49 -0400
X-MC-Unique: mEFfjfG_PIi4Fs1IRjcHXA-1
X-Mimecast-MFC-AGG-ID: mEFfjfG_PIi4Fs1IRjcHXA_1748791549
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-445135eb689so17895465e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791548; x=1749396348;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6dAlrl0LtxfLCgi64pVTEp018uC/mUt8mFKXJwY2ZbY=;
 b=DGqedluLjAxx+PdN/hbT5dX3nQdBTPXkFQK78S8Dhvx0q6bK98V+KyAhkJ4mxeG40E
 fByQWRuD2nwwNClyRzEH+/MkLbYdBZCJ4jU6bvU1slXnGcMCTcpGjhHSW7+5O4fNP8Ln
 GBUYK0SOJIq99mr0vgbCkq6/NQlrUc567czEVvTBZZYswX4ED9k6O5XdNyrcyc3F+1up
 n7ie7wtBqlEBnW0IFh407eMS8Rgl8lNyCaPv1UEddAUC0xCi44j8WAxIivDsdCuV118H
 I4YQq6rlRL1MoG9ACfBKGk02fOPU2fiMxC96Focb7TlRO+jiR2emRT90b6HUB1cc1LuI
 nU2w==
X-Gm-Message-State: AOJu0Yy9cPFrElWn0pe9m7/tAO9WKb0akQqBM/u0emtzlH1tUNAIbqdu
 e8nGc4rxOzXp7skNd1nfGwNY0TO3MeSg7iRE7iBjkXSzfpx2HhSb1D5HMSHSsGCsR/XWsjzLaHp
 FvVIZUIAch59E35BZRgmxhVSJ6SICAn+cpSm64GM9zJebRDVt+Ekcd9oofcV5El8PHAE5PDLeXK
 sC/wRNR5s2xFf60qQimntvaTewqTJX8G0VKQ==
X-Gm-Gg: ASbGnctVVC/XrSLBFDE/6R6jzej3xm1hyQBzb7VMtMeoyKfft4GcvQmMvW4ZP2/WzX0
 qmcqKn9b438BG95B8QKd4xv+1I3sLNXXBhu+GM+kr0NpoD/d0v5U//I0n2w8m0QjFUPVJX/6Zr7
 stPO3ngexX8X6mLsa9XvXbm/r/JamMqgUHKkiE2mFzaBdobsA09yz+seZfaS0rAUc6bc/fXxTNb
 FT0YMg3l86nZhUrfRM+Zqf2PsRznY37daybhO9aSR2j9s7KJ9z5+EFtbLSLmH9vqk5b04XIqiTA
 YFLq5w==
X-Received: by 2002:a05:6000:1447:b0:3a4:f722:f00b with SMTP id
 ffacd0b85a97d-3a4f7a02565mr8143396f8f.11.1748791548144; 
 Sun, 01 Jun 2025 08:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrecldD8gO1vYtpqEneN8pyJrS7ibr/3skTLCJo76l3qH38tE1b2Dky2bAOOFlgbrXleMVA==
X-Received: by 2002:a05:6000:1447:b0:3a4:f722:f00b with SMTP id
 ffacd0b85a97d-3a4f7a02565mr8143369f8f.11.1748791547674; 
 Sun, 01 Jun 2025 08:25:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f92585sm92452755e9.5.2025.06.01.08.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:46 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL 24/31] vdpa: check for iova tree initialized at net_client_start
Message-ID: <ee2136d8f5a1a4c317e39b0f3ca99e2095106ac8.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

To map the guest memory while it is migrating we need to create the
iova_tree, as long as the destination uses x-svq=on. Checking to not
override it.

The function vhost_vdpa_net_client_stop clear it if the device is
stopped. If the guest starts the device again, the iova tree is
recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_start
if needed, so old behavior is kept.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-2-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7ca8b46eee..decb826868 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -366,7 +366,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-    if (v->shadow_vqs_enabled) {
+
+    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
+    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
         v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
                                                    v->shared->iova_range.last);
     }
-- 
MST


