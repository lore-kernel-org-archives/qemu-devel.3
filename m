Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960B6C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wa-0004mE-MS; Thu, 23 Jul 2026 18:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wZ-0004k1-Ie
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:07 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wX-0001Rf-Bx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:07 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81eb41c1f1aso10182227b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845864; x=1785450664; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NcYm30w4l7Vli4IAxyKgucSKPfeiorfv7ej3+wDF8Ng=;
 b=XcHxAtIQ7sbAsA1pypNc1v/cq+CXSi62xRDXm7afKUZ5YEyG0pt+OzlH+cdXyfoiWY
 LZLV0QvI+8sJjjYcN1XCf1eYxD5dlbzLr/HR67Ds/JowZiHibVTlld/6+VLXQZcj5BmJ
 g5SAeMrGvpTphjf10JloDiOXg5NVMEnbAWO5unn8Nf+eMVPFeZTEnbbn3mjGMRbaYf6D
 a27DlGetCD0e+bjiy4cnhAUZ+Ylha2mZNoyNTWXM5UD5lo2jvxjUh7w8GwvFbF4yUueU
 /tX4ZkN49TkI/2OWWaObt9EIR+BLveSOTXl8c8L5/NoXmmffvRwthJCwzgmT1lOqrsP0
 /2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845864; x=1785450664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NcYm30w4l7Vli4IAxyKgucSKPfeiorfv7ej3+wDF8Ng=;
 b=snOJZD8fM7hyjm4Gxh5taxZzfFKMg0CEbrnNfzIDcYI0lMloQVlDGsHTUBJwdRtTRJ
 ceSOyxnJlPBxN13pv5XgoJlmGKV604BlmAOjjQfiPE/frElITlE2dYNYfV/FTtmgwa9e
 ACmAhIQSJwHkO1shzEUT6mhdx9hla27HmOWg0MlTOYNec6iDvykWXHIkYmg/AZIhKl61
 ufoveL15vc7+kFFIkWhoeAsAioqxrX5NUv6DnvesyvXC0EYkP13z9Bvb6rJRQpm9OM/d
 IJYpCQO+gPwf1ZW5Ioma/Q060xnj8hRHMGxKx3/LHhNbm72t2SKDTL8VWW/sohH3NvnU
 cLog==
X-Gm-Message-State: AOJu0YwN6darADeD6oPKKfJNRJgFQSGcoDyBu/r75CgXtQ9TDmIfwm7A
 PzBSP5zYBT1lkXDu8XoVN+G1/pYBbAUN1zLLGNYyaIh+KDc14IetoJNN
X-Gm-Gg: AR+sD11uSVUBXXSVNz7ayVhdsCkpFjHX2rhQDxcyjBuvqvN+77juUF4YK/aHFQe9ehv
 AIKsDQvOSQ2nIOKKYEroJY0axyrRp3uYh1NNIlNF7dtzidZPJsXKqGlDGOKRx+Mvdu9zBmrTgih
 0skYMpKplzG/1EMgj8EIbOzaVtLn4vJ+vBszbblEPjAHUHKIKZSI1uSAPNMfknlSLVeoJwmwtZN
 TW8j+GD9Qc7G24IMs9TcBvL59GGs2JC9xyGam+gcqYStzo4vBCr3TLd6l46VyYE2q3pqK/4AWAj
 0SQPWq6d9kpImvSP30EMzQvpKlJ7xosESzm7kVepRL3BWbjGp7LKRXYCttjw/jGh4WnBBqTGq1g
 VuoijIlkU0DOIhnVzjdnqOZrMufTLrsayM39izmX0KULoHDXg6FZ9sWcKxirsRMj2b3MYlthUjl
 vt2ZvJ2rU=
X-Received: by 2002:a05:690c:23c1:b0:81e:9bcf:3331 with SMTP id
 00721157ae682-81f4c308803mr15470147b3.50.1784845864063; 
 Thu, 23 Jul 2026 15:31:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:03 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:05 -0700
Subject: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=1380;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=4NYTmMM/tKQClf8Rfwd0s8ArOE7KiiEH3lfBWfSv8GE=;
 b=phRfMm78NGRBj6uBF6zMDcCEhyCfeowKCx4+ej3y94dVfM5n66RXMSPbK+UaifHytU6Sc8h5I
 VlIfEHiwhCVBrikoJ+SbUFScNgv+jfy0OCahLgR2lVACw5+ssxMOwlp
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a wrapper to iova-tree to call g_tree_foreach.  Provies a means to
execute some function on each node of the iova-tree.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 include/qemu/iova-tree.h | 13 +++++++++++++
 util/iova-tree.c         |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 14e82a22d5..4d77f4dc57 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -161,4 +161,17 @@ int iova_tree_alloc_map(IOVATree *tree, DMAMap *map, hwaddr iova_begin,
  */
 void iova_tree_destroy(IOVATree *tree);
 
+/**
+ * iova_tree_foreach:
+ *
+ * @tree: the iova tree to traverse
+ * @func: the function called at every node. A true return value ends traversal
+ * @data: an argument passed to func
+ *
+ * Wrapper to call g_tree_foreach on underlying g_tree
+ *
+ * Return: None
+ */
+void iova_tree_foreach(IOVATree *tree, GTraverseFunc func, gpointer data);
+
 #endif
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 5b0c95ff15..2239bb6ae1 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -303,3 +303,8 @@ int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
 
     return IOVA_OK;
 }
+
+void iova_tree_foreach(IOVATree *tree, GTraverseFunc func, gpointer data)
+{
+    g_tree_foreach(tree->tree, func, data);
+}

-- 
2.43.0


