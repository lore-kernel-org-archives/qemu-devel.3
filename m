Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6E606A33D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9sB8fDe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3Tr-00077O-QZ; Thu, 05 Nov 2026 14:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tn-00074r-LP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:35 -0500
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tl-000279-Uw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:35 -0500
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3820955c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908227; x=1794513027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b4Qkg1WlnjlDPElKS1NfJbk3KOMVachnC09ppt17eF8=;
 b=A9sB8fDetfvnXUwVoVSL+u/M7QKLY2ID+oKRpplbOR7qcYbVaCUfwHWkRp8dZdFh3H
 9RdI9zWaJZzt9tET2Y2wQh51QM0NvYkNFgnP+h2AYTNltHbsotaGlB76jYXN3H8YLyGm
 gmIP6eVgreyD0QJSZpq6H0cANtDThKPHJriWRqZNU4amP3HCTEOfIrp8L4SPaWJfizdj
 ObKfxh4DL3514Uk3y2VhuRhDPJIJlgJtyMqZesgVUjWsr9ttP6P7P567GCbKYr/u0APJ
 hCA7ZlsIqGizoweqrlA9OS6NC3KVRYGOSxVkmg8SjS5b54zD7nx98eEZ3tjIwEP1rwj3
 TP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908227; x=1794513027;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b4Qkg1WlnjlDPElKS1NfJbk3KOMVachnC09ppt17eF8=;
 b=Zv5f4HAhl1tf+nzzGeTfxq7LeSMVgHHLNhfWLc8aoqRbdEjamjEgfULmmXtZ2oTexC
 5+xF1s1/qLbgXPRgBh+uIgLR28uGSb2jdioEis4QDRufnX1lkPN2w8JRAjVK82jUnjf1
 GJ1vHGNwqb2VyTvCWa1xAbp6Zyc9Hk7nObyD7F/cJNPLe0kbT0k7XoUTcu00+V5U0EGf
 7WPXvafcK6yajB88LDCO4airf1Q9hiTfFVW+n6nMRJE1rJth86RRL1YpdknQiVv40ppS
 BAXReTxzpMCSjnvWbzyhPClb0Kw0mlINNR5Or1XFZ4fwb2ybuAv9r8+MpIb4vPQlRH7c
 3txw==
X-Gm-Message-State: APuU4Z/BicIx/j5Z+kBIEdo6KYUAnaSHIi9I0Fqnt3BqYV8+/1TAUCAy
 horQvUOu1NulNOtsdR7s1WOZHLhDbmCnBTTG1Rx7SkFp3pUPmMME2GRZ7inb57ql/3g=
X-Gm-Gg: AYBFou1YA/2ZkfPcdQS0PiVFWFrx+mGRXEyNn2yWDcdnZl5Q2pYvGQzG3JY6VtimWoT
 uL1CiS+FDlt1v2GXafxnsg6EGM+GI3V2hVi2CMZyUmK3FR9moFtjRhy3IgTg9jtb/4aWBFc0KkC
 pUDWqLaoSFlRJYVwnIu+hSs/5WEq4HwnmgyOCcggEW9BNTD6wwV7Lawth6eECCxuKYbYj6jDJQu
 IGzP5rQoG0wX7BZ73albaSrXznJcOFTb1+5fDGRoirH7XGDg36GzQODMvuC4ur6yKeWaeaL78MU
 VUdup5y+F34qqb7dR0/UapJ/BHgbQJNzUpYBIYc29I+3x4u7HkVQpDKJUIcBWwo5KrEwazS5ErA
 fnTBwyrqIwpN+Bv3bzAzVRcjHyMRMe77ko5/xbkR0heeklBJvOLW7z9f0Pb4Fb/zV+iSYeWChUL
 yncUu+71IUN2pzb4EqU6WS5KNan6kIhTmKkAZNIdvaUKUu4iZX+tZTJHg/1BkWaOeBL8gK0oAZP
 I6gHeJ9g865RHquZZQKs9EJcxyzwi6vyO1J+ct/PrgdIbA/SUvskgM68s2A66Cr14cmEnKzOIbj
 0PoKAWJP6zLr3/RKjWL+YGsbigR01dAsGNUMR6E/k8Pe41CY
X-Received: by 2002:a05:701b:2093:20b0:19e:f233:4f87 with SMTP id
 a92af1059eb24-1b25d2f734dmr33918c88.15.1793908227309; 
 Thu, 05 Nov 2026 11:50:27 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm19459875c88.4.2026.11.05.11.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:50:26 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org
Subject: [PATCH v2 2/4] hw/scsi: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Fri,  6 Nov 2026 03:49:55 +0800
Message-ID: <20261105194958.1117-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105194958.1117-1-luoyonggang@gmail.com>
References: <20261105194958.1117-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the multi-target work, the goal is to move to a single
unified QOM tree that applies universally across all targets.
This complements the migration away from instance level
properties to class level properties, which again aims to
ensure a fixed QOM object model for each class.

This requires that properties are either unconditionally
registered in the class, with invalid options rejected
at runtime (for example, during realize()), or that distinct
subclasses are used for specialized use cases that need a
distinct impl for some targets.

It is harmless to have the 'loadparm' property registered
unconditionally so take the simple option.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/scsi/scsi-disk.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index de2b6d85da..7fec5a74d1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3212,6 +3212,11 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
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
@@ -3229,14 +3234,11 @@ static void scsi_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      scsi_property_get_loadparm,
-                                      scsi_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  scsi_property_get_loadparm,
+                                  scsi_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
-- 
2.55.0.windows.3


