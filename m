Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D874FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGil4-00080t-By; Tue, 13 Oct 2026 16:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikq-0007xP-5G
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:45 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikn-0003Mt-Ba
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:42 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-35834f72d94so6096399eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921937; x=1792526737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9grlkE7NcjVbWKGA44KZGoN8QKYGDpltY5XgCndOBEc=;
 b=HlCi6khE8AtdDxBX1eiO3PJQJkj02gI5PVMPc0oiR6A1qgQGPiZR9iRXC0VqedYD6f
 SU9W2jYqFU7KlDGTW5Mdv9uhKG9kZ8IKwBKEg01psdgtgWr9Zg/AxVkqbEd3U5bqUcBD
 uFVVU+sb4jtu3Chn8bbcnpTCdyJY5q2RF3WbOxvvjMapXVSwpkas1F9MZYzXWuzPvDth
 zpWsbs8AeOiBOTkKMdgNtKs1ywLcB6aOv4cLh0hpQdbixIQb+uQjCUDcJX5Z+kCREeJH
 3FdNMiPDSTflv3BtKbUR6JAQd9j3DbTpuybyb9q2GvenFSNH5sGQkbDqQsSRyPcJzi2e
 g5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921937; x=1792526737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9grlkE7NcjVbWKGA44KZGoN8QKYGDpltY5XgCndOBEc=;
 b=oUzUwMfhlZOXDzT6ynA5criBpdVdmhhlI158c8jZ0MvbUHmaFdU7Am42amzom50tfq
 CvutXlVoXqmPLj8mlezbVNf9N388yrUH5/USt8CGKht3sx47qIOjjLVc6jFdtjGcmTNM
 93rTukugOE+EMyzSQg6ygn5y0Ivl4W98TBJ7L3IhxW9NAbx5tN6BQflPnFOHNQ5opK+8
 kCUy4Jftz6wlfizUlkzWcqeFgrJ4A0dZZz9521BNsYT7QVvRds6rHQ7j7OwGa5kZXCLm
 wXSazoNWAB73yuodS2ixRq3vi1+F1qv1lzirQ8VPiJxtYNL99eXzmOBRf+vWc3J+DUmN
 PEIA==
X-Gm-Message-State: AFq9FYJ6G8CShMFFclgA8JjnMLLEY/smlfrcUbAoVXQAbApBN88qkqHs
 obQ919hcSpikyi0eJorUIz1i5JVVmuNkMs3ROEEIb2XVs1RhFiff2yH0NxckP7W8
X-Gm-Gg: AYBFou3wrY8QgLZT5bRpGDFQOm71/ZfZKJu5mv2FYC/da94eM628c6qQYDF73fROiQA
 YX7JDeUBx4ITaBTtyoJw1xRSx+m1IxFTMIqSq2wpDLwawisnEdyLB95aR+94fxZp7MtorEECKQS
 YR7yjDiAKV9ZuIFoC3Gf03WCBdrWJsa3veeYs1Ww1puZMngQqLtzoAwlUtnhQt8voA+1tFbNvXj
 qoJIOZBiXrQkp8yl/oBLWWPp8CTHSBgCKOQ9nSup0bPv+dV+/bO6c/meV5VdBDqhDV1+Blm85uc
 p1CECzo4ckO95mLspFodCtALX+0GbtnY89ud2+kKJo3QQllVVCnAe1YbYTlb56iTIx96ppleHDr
 boLc9vXLtbvqjBRTIQcoIdRbANSZ5n8HAbZiq+TNRBCHGsrXq3NId7zN+GrAFD4eyXzyEI4O41y
 aZnrGcVq1vFomOZu4uAHnhbR4keDbM5Iz/cFJvhbxBjMES8st1uM9fmt0uUj+FM9j1aKehqCvaK
 Hqw9jElhfPBxec7v3SFWiekfCId
X-Received: by 2002:a05:693c:20c1:10b0:35c:2986:35ab with SMTP id
 5a478bee46e88-35c29863f99mr4584533eec.13.1791921936333; 
 Tue, 13 Oct 2026 13:05:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm25568233eec.11.2026.10.13.13.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:05:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 1/3] hw/pci: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Wed, 14 Oct 2026 04:05:22 +0800
Message-ID: <20261013200525.1340-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261013200525.1340-1-luoyonggang@gmail.com>
References: <20261013200525.1340-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is for avoid call target_info() in class_init.
Now we directly guard in pci_qdev_property_set_loadparm instead.
Don't know if its an API break, but the smallest change.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/pci/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb0..9d3dcd52942 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2878,6 +2878,11 @@ static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
 {
     void *lp_str;
 
+    if (!target_s390x()) {
+        error_setg(errp, "'loadparm' is only supported on s390x");
+        return;
+    }
+
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
         return;
@@ -2895,14 +2900,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      pci_qdev_property_get_loadparm,
-                                      pci_qdev_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  pci_qdev_property_get_loadparm,
+                                  pci_qdev_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 MemoryRegion *pci_address_space(PCIDevice *dev)
-- 
2.55.0.windows.3


