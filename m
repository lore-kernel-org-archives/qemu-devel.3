Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F227C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypKz-0001pZ-SE; Tue, 25 Aug 2026 07:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKw-0001mZ-1v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKq-0005b6-2N
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9SgPUAb5n42tStqTgmJc5gjPzoBxZIIp3aPLVSFDA4=;
 b=DrTGieMF9WqU8E9vxdKu/ZnngxZaMXlafb8uaav90HoUaGM4y958Qm1DY5qUyDIsRv6w5y
 a/l6hQN2OZLRwaJsZNcvnLvwIvdXMgZ8VurVerPzg/SKuwv+RwRmqq34cccE73dBrIuWdQ
 Qc6CbzGbqpu3Zm04nVpzAzsXqOOCM8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-gEYJoTIfOVywdLdbaQyw_Q-1; Tue,
 25 Aug 2026 07:28:51 -0400
X-MC-Unique: gEYJoTIfOVywdLdbaQyw_Q-1
X-Mimecast-MFC-AGG-ID: gEYJoTIfOVywdLdbaQyw_Q_1787657330
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF3BD195411D; Tue, 25 Aug 2026 11:28:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8B845B1; Tue, 25 Aug 2026 11:28:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:51 +0400
Subject: [GIT PULL 01/19] hw/misc: fix trace-events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-1-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gf1MWHq6bMcGh66L17Lk8mRxvGUij2pMb/fjnDdEbEg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrT3SVxXv22fOyegMIvU/bo/IEXVEX06hTzl
 Eezii7lNeiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao160wAKCRDa6OEJdZac
 5eBJEAC4b8WDY/KrgwU4prAT53Cp1xplM8Pg2g44y4XrPGXky1TzUwUlzKo8sfJ10dkHhxMGVyX
 BiGcdAyIKdxhdCJsa93tl2DdWR4nIpFHJdWTSyPC9PVKp6z2t6tiyUwrn9QvNkdYfhNIkE5i9nA
 7gS8DJkD6hs+2Put8dGSz0LGH+MsHW1AGMmwQ7z5tppkI3Hr/bozOJ6h+jIdfc4j9dbDEJ5Iylp
 6wKyaCqg0af+k/u/tRQ2lOGrlj9thWTu+6Rebv2BkZDedh6VgnzShcHbLE4Api749ZkVikcx8aq
 N5MThN1J5OZpegPfUBiCFcyw/H2nz0Gm1jVY+92nrlI2zubCy/2YAjyB2XhrnBk+V/2G6fw8Sn6
 MTxY2mC4mKkhvZHRfS8YNfjjz923txqg+zoMMDRpodPHAziTOK4TFrPf4dQlfHdP/8fEk5yVSab
 NJNV1obknRMJIkFgXiiAqyj4TRu3El65HPEz6cznxYiVkswbC5AgXvjqZBraaPPlPNl7TRQvBrK
 9sUTU2/a37rTeKAN3NIFj2kxyRCU3+cVI5fLWZ6h/Jc+eHZZbxF5Wj1L529hwaAP0mf6+YIGvVL
 6VAfMzk7soz4yG439CFg5Xj2S1CF2zttLFjywiVL70/+arNPVKwpCaKuP+PVuqvJE+cYZqg6p37
 IaIp88nHX8ZIsrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
trace events.

Fixes: 8041d1730871 ("tests/qtest: add test for K230 gsdma")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825074114.853069-1-marcandre.lureau@redhat.com>
---
 hw/misc/trace-events | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 16db4ba0cc17..0b8be3d0f226 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -446,3 +446,9 @@ iommu_testdev_dma_armed(bool armed) "armed=%d"
 # k230_decomp_gzip.c
 k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
 k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
+
+# vmlaunchupdate.c
+launch_update_write(void) ""
+vmlaunch_reset_enter(void) ""
+vm_launchupdate_finalize(void) ""
+restore_host_x86_igvm(void) ""

-- 
2.55.0.543.g5ebe2ebe4ea8


