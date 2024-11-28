Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9603AD70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkL0-0005vy-6W; Thu, 28 Nov 2024 14:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com>)
 id 1tGkKu-0005pF-Vh; Thu, 28 Nov 2024 14:38:01 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com>)
 id 1tGkKt-0001e6-6v; Thu, 28 Nov 2024 14:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=4cxulYeO4NhY3t6U7QERTjOlXT5wKxyH+m3yclIV2gg=; b=UpGd5
 9j2M+YyfJKOOJz4NDFXchilnA61SvNOkJ+np2oYtTv/pwemf4yuosqcnk/A078pC2k7ky6wGX/UD/
 jUgpUealMDkdLIOz3GWiniuAyEYGTiXwDNH/uIvaocqqZjzg3qmjLMofgMYoJFBQwSAWyzenlpaqg
 1kg0np98lJ4xsgKJadnKI/LL2d8xTnu1zP1+k4O+gTAjubKuqDHG6ZqaS22dZc8kHO9DYlICANtEP
 JZiwVHKtax3bXOLerHhL/4MJtE7PLR7G64aGPUif5trx6d0/Y8eyAtihl83E+CPf0LaHhS115l4Ix
 b4U8Qg991lAfv2P8AQ6cme86Y1RNBsZN/mXL0/TKfFRrXuZONB9oJYk4EP5hDRdGBOwcD7CQffilC
 8/6prVLPcnWioeqfu6CkSweXbmqm7gDUjKF3Mim/bFC0HNJdI3BWmiQpjzJcjTsArqr+X6oa06/jF
 0Df8R7ckzs4b0FI51rXJ47NkRPoZ2VyZUz0oTZroQrUNKALUKNUdghaMhyDudqq+TO25uWDu07tUF
 RYYvX778DO/4OImiqECzjMVlsRPXqeYk2IP00M9lD7wqQO6U97URztj+NsErlJS1/3CqtfUQGSXD2
 9yYF4ChIII/C2krmc2Zc+RSZvYHCb6IMaBYLO+g4kFf+RR6U7VulocpBohnoRA=;
Message-Id: <eaab44ccc59b83d8dff60fca3361a9b98ec7fee6.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 7/7] tests/9p: also check 'Tgetattr' in
 'use-after-unlink' test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This verifies expected behaviour of previous bug fix patch.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <7017658155c517b9665b75333a97c79aa2d4f3df.1732465720.git.qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f6d7400a87..ab3a12c816 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -702,6 +702,7 @@ static void fs_use_after_unlink(void *obj, void *data,
     g_autofree char *real_file = virtio_9p_test_path("09/doa_file");
     g_autofree char *buf = g_malloc0(write_count);
     struct stat st_file;
+    struct v9fs_attr attr;
     uint32_t fid_file;
     uint32_t count;
 
@@ -725,6 +726,10 @@ static void fs_use_after_unlink(void *obj, void *data,
     tunlinkat({ .client = v9p, .atPath = "09", .name = "doa_file" });
 
     /* file is removed, but we still have it open, so this should succeed */
+    tgetattr({
+        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
     count = twrite({
         .client = v9p, .fid = fid_file, .offset = 0, .count = write_count,
         .data = buf
-- 
2.30.2


