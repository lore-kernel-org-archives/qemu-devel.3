Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD7BC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU8A-00065y-92; Thu, 31 Jul 2025 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGw-0005vm-9A
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGu-0008SK-3r
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPlxUATnson/OfqUGGpfiSwGtkiFdFaIwugyp8JmNkM=;
 b=Mv4CX88yx/t3JLJn7G6voUZE9XEr0X787Op3zp6aIbPwnFBJJzwenynCYihvmRHAJg8DJm
 HEAzWfk2HXJCAS2i6338IY7VOahBT1mFdGPgwuPAtbAPhTT/Yf/Y1rIeoWBfWxLqViERoP
 YPgM6Rkah4TUZGM9mU9iG6ijBOejWNw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-LU-hpcCRPzGdYyIM6im_Zg-1; Thu, 31 Jul 2025 09:24:30 -0400
X-MC-Unique: LU-hpcCRPzGdYyIM6im_Zg-1
X-Mimecast-MFC-AGG-ID: LU-hpcCRPzGdYyIM6im_Zg_1753968269
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f2dd307d4so1110092a91.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968269; x=1754573069;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPlxUATnson/OfqUGGpfiSwGtkiFdFaIwugyp8JmNkM=;
 b=aYkCqdYrs+mO/Q7hdXMH+ikttwZwjJGeU+eSIeQjspYDgxb0b0cmiXKZhseseOE2Gb
 vVmOZdQhpFmxKtIM7BWcSFoSBVFMgdVYXarZ3OfcNkKvjZqZiXWSUkTwcqutn8z8vHBe
 HJdxc4mzAUq0RWq6X7qJNeY2D0/YzAn0vElFvV3X3tIJU2uPeu7Xr2ECoIE47UPRtAsU
 MJA/EfhwFB7W8qaYUpf13848fPg1VrgrJrRljKtUEBMC8kRU83u089mR4i66JiTF3N0e
 aSfFt6WTi57aavgMYBVf5y4I7NyaC0IgLVEVRTIHAI42IPsVzUlGZ5esb3upwnmr32QU
 6qvA==
X-Gm-Message-State: AOJu0Yz3BdF5GdWAaGEt5W/AFJEy8Fvn6w7yxQiYAImFypwGb5SXorm9
 DfthgpymVI5X7J0IF38H8gHQ3GeYwZqYrez8Bw2CD6Lmo44kFO3erEoUbeSW4PwjdmHANxL8DgT
 Khe+egsPR/w2iLadEtfoBCr7mf8o9Ftauvdcnj5W6ZfYICCNfHHGlX0abuea3HKp3P/SrK8MGyW
 lvqOxwwUmBXMXoQlB6RUY2A+Kld80820ODZ8rmkhmYwA==
X-Gm-Gg: ASbGnctHSkf4BV+l3guUOpFu6d9S+JmbO02AZl/OxVNC9D+NE597EcGkNVd9fge+xJ6
 VXttOgiACpDxHdFqJuLjJbYN7ZGBlCEepAl0/or9Aiueh+gMBDl2a5+/ymrzxHD34rbjg/bv6+s
 cU6q0HmSGraPjrAjUiSuCsrjAJz8j1c6ZP8yE9LBkhN3kgbE8caRkvkfGFo4MUR/LJOHAHpXo0L
 c+xBkOSxn4aGYP0/dyyHH5LE4kNtLwvBCtPmOJ+5YBaKgoB8et5JA4jr5q9XV+JMrBONxNtQtYo
 bvBJR833EWURF/obP/kDIY4T0U8QazRpoGEsAy498UKo9WMDMQmm
X-Received: by 2002:a17:90b:3c04:b0:31a:9004:8d36 with SMTP id
 98e67ed59e1d1-31f5de54abdmr10222472a91.20.1753968268895; 
 Thu, 31 Jul 2025 06:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF28oQZ0p4k4XEz1Z4GzPjUC43COF4UfZLe2qygVaSZ4YPphOwkAAKP19X3nNB7/EVgdzKzg==
X-Received: by 2002:a17:90b:3c04:b0:31a:9004:8d36 with SMTP id
 98e67ed59e1d1-31f5de54abdmr10222379a91.20.1753968268189; 
 Thu, 31 Jul 2025 06:24:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:56 +0530
Subject: [PATCH v8 16/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-16-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=armenon@redhat.com;
 h=from:subject:message-id; bh=x35890LQbgla3cF+l4tZAoC5i9xLCJIObHqhxSSTf4U=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37jPd3K2p+jb6NrU2UXefPvmQOcGr4zb3fPnJUwVnm
 k8KmvGso5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwES2zGBkOLE6+e7MXKNpZf+d
 //AncTHenv3i1JS+4P91mxq4Gw7k1jL8DzqVzuAX4+/xQFdN1a3vMyeXy7czaczerZ/VAw5dUr7
 BAQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 2f9105e4a3b3d1a443d44beed1b2bb2d876439ec..d095ea370464b7098ef37d0ad37c2fc595edf6ea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2479,32 +2479,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "failed to read block name: %s", block_name);
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "migration stream has error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "invalid payload length (%d)", len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "block '%s' not found", block_name);
         return -EINVAL;
     }
 
@@ -2639,11 +2642,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.0


