Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6389FC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sV6-0004BP-5J; Tue, 08 Sep 2026 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUx-00049W-Hx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUw-0002be-4T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p7jtalzlLyhCAYc3MxC7WWwgcA0LpGHOMMDNN/DBTg=;
 b=K0ziSx92PSKR+a7Y26ToXgmwEbA9xH90hOwte/fIkWia74x+l9+CvnKB0C+YFq5z4QNijt
 tSXt3tt9neTv5lVM4OC8EMGcciGV9d/WJQiRb/CcyE4nmBZBNnWtQ8FoX7hIhxeulwyIZf
 iTnBNPvTXBzqMBqbBgQt6D4zWR/9HmM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-4CdGSN02NmuJbwo2-rxO6g-1; Tue,
 08 Sep 2026 05:52:10 -0400
X-MC-Unique: 4CdGSN02NmuJbwo2-rxO6g-1
X-Mimecast-MFC-AGG-ID: 4CdGSN02NmuJbwo2-rxO6g_1788861129
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BE2B1933F87; Tue,  8 Sep 2026 09:52:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FC9430001A2; Tue,  8 Sep 2026 09:52:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:52 +0400
Subject: [GIT PULL 03/10] tests/functional: skip some tests that require
 HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-3-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c8qgPpmZ3XLl9uO8pUVbfyeeb4zTdwm0KeCmlMQU5BE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6ybvHP0q9LeVgKsqErpvFgY6Vtn96GOhIu
 5JWGlBju4+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5UWAD/9iqfYtr4JCZzbUvhr1XDfL6StCrswTQfn2wKyB3i8/4oxpnm7dBsw50hvgZbeElZW4F8G
 fnyv9KrwAY//a8FL/pOPBMt8ScyCh/9zWDemUTALp+JpwkJboPZC6BS/BOpQQykZy0heC4xejKL
 G3NlcT7qC89LBdQM8Tl3eMT+F4eP+GCDaUapdhqd6Ii6Dx0SHb28we/UwR7bPiA8UGgYl4XpXTN
 EYSd9mBB+CKGyQvfLb6An7Wr4arUuXejyPh//KARN7kR3XjPEqZPJ2whzigLkrPjbBcjXozs+mV
 /B/LlxGVPdj6Hrnnak4vYG8TxNht7YyX0aD4zHIypJCUGYYHMzWYdil1uXCLE7ifVa4iStSIeP1
 UJjTPTosKw7fWxccs01U2MEofGsWEiTlnh/z/sG0ioEyN9KAfpBnXyD6bINVcNOh7WMgyqFF9R3
 4stb4T6/aZZPaufPPBtV8+5OaHd+echomlx4TUg7bTzdunW1wAopuSrRQvsUhE9dC8IAXoYnw2+
 2Z0Agyi3U2N/yC38gsm1f2li3Cor6nZ2hkbxP8vn3+OBJ9nE0+CGMSipPlNvTrR3B6d99/PETia
 LVp7z2U3xJMTELj+fvWRNy+iJByhHl4HYwkH2FCVrQQcwC58r6tN1yJhFLxNXowKDX1P3AhbqH6
 AixKBdoLYjDb9dQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Those tests use "info registers" command and cannot be converted
easily, for now skip them

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 1 +
 tests/functional/ppc/test_ppe42.py     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index f3d92034b127..e7fca50292b6 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -28,6 +28,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
 
         self.log.info('VM launched, waiting for display')
         # Wait for the FPU test to finish, then the display is available, too:
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
index 53958a7938d1..a9c154f67328 100755
--- a/tests/functional/ppc/test_ppe42.py
+++ b/tests/functional/ppc/test_ppe42.py
@@ -72,6 +72,7 @@ def test_ppe42_instructions(self):
         self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
         self.vm.add_args('-action', 'panic=pause')
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
         self._wait_pass_fail(self.timeout)
 
 if __name__ == '__main__':

-- 
2.55.0.543.g5ebe2ebe4ea8


