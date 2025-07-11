Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E968C83F27
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuF-0004Xt-0R; Fri, 11 Jul 2025 09:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtn-0004P8-Dz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtl-00031g-ML
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so15572175e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240884; x=1752845684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jgAVdewJ8pDHlKu4rlqFJIDOTB9PnXtF4nPjiIJFR90=;
 b=fdCUyFaQCaBMwdepBChafWPJ61Hw3h4eJF6TyR63paV0PJK5DHlRYQmgnaJbC+sWpl
 A23Alunt8tqdfuQMnlyczEQkLwb/NRYf4rCnoSoFNYQipPfrMnEyWbVV36bOjY48bFcV
 ycaBYzb8v7QN5xrADNkk+cBMiz1aBRPm0gwnESKM2C70ojetp374KKX7iweA5NMKJstm
 TjAelLr7yHTnUhKkd1uLAlxagDwsd7TkkkccsJaU+x7GBkxkrBbqVwRLHPr7CILyq/qH
 YQnF65RCiI4HbxnMs0FdhtqBZorftd/I0GDUBVkQEh3RwpjYveFuiMof+mPwCmPAqsMu
 C9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240884; x=1752845684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgAVdewJ8pDHlKu4rlqFJIDOTB9PnXtF4nPjiIJFR90=;
 b=R+QFYMPECJE+SNnewxbm7zUnJ+BBf5DZn4GjuRrFrAk6z+MFdVwnEVDtSMuFhaVoIl
 ZxeyOuvxZgC1+uq9/A8rEx+hCTnrnOtw5Xf/vyLZazFCvgygYvmXCfdK5FQuNprXITMz
 0liUqEKQL3qEF64a0JA7X71AnVDm4fTMjqIHf/ztVEWzs9I5HhBOeol5Rts96lu/AcrU
 /ULhT5VRbZ4jedsNhHojaYTBkX68UbzVl5TPvkswlUVsVLF2x3d+MIQtd5xzJGTujegV
 +ghYlaLtgLKcDpfAk+6eR0HZOTwf3VwFk3AF01WOeflWcHNbUHuLpi4mmpd/quc8qNAj
 8HRQ==
X-Gm-Message-State: AOJu0Yz+Nz1/B+ysn4JCezRi3wtRT90Dn5Bn/R4PCgF603UhF3YXPkzV
 K4uUAmGZfCvNkg+RL59oLwUuIqts9NCsz0T5idXTd0JWQW/FGCodL1hBS9wWMRBaL7VQzdLnHof
 /DAmg
X-Gm-Gg: ASbGncsV8GB51uUWdzQV39e1jXwpcFy4+7WzzYF/QRqvmS2Sc1c4uteOQMgh0giW9Z3
 B41dBai417VNpsEKmEpNg4KzdvoZ7tu8/FKQ6P0+g7tMrm+3cQcfyh65e4Fe3yPT6E+u2ckwve3
 VBzKcFNtepszWzf/au6IY+m6ICWch8dcmv2aROlfKcfCPMjygiyhJl52n3E9rj1wp0R+r4gxkc0
 X85Ewt1bmnnjWo4GuWnyECv5JYs9MyQllouZ5jNP19bJMxrpFRZU1/ZTbg8sK/pm4CQZUjt8ebz
 lyauBpIuGAGrA4jJcmhFnFRigpunQGIDoicNNJMCaPBXVcxpXWeRFug0R6h9eoEDi9xr8EXQngB
 mfEvdqkN4wAQtmNJKypARh2oj6bVn
X-Google-Smtp-Source: AGHT+IFWstTJlC0XjzSPW9njkSxKiUqpISxufyhLCs1/s1sQ87P91tylBaVXeowsiN1FgL9pX3shUw==
X-Received: by 2002:a05:600c:c09c:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-45526f25a77mr22769485e9.18.1752240884174; 
 Fri, 11 Jul 2025 06:34:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] hw/cxl-host: Add an index field to CXLFixedMemoryWindow
Date: Fri, 11 Jul 2025 14:34:05 +0100
Message-ID: <20250711133429.1423030-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To enable these to be found in a fixed order, that order needs to be known.
This will later be used to sort a list of these structures so that address
map and ACPI table entries are predictable.

Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Message-id: 20250703104110.992379-2-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/cxl/cxl.h | 1 +
 hw/cxl/cxl-host.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b68644..b2bcce7ed60 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    int index;
     uint64_t size;
     char **targets;
     PXBCXLDev *target_hbs[16];
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e0101631744..b7aa429ddf4 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -24,13 +24,15 @@
 
 static void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+                                           int index, Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
     strList *target;
     int i;
 
+    fw->index = index;
+
     for (target = object->targets; target; target = target->next) {
         fw->num_targets++;
     }
@@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     CXLState *state = opaque;
     CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
     CXLFixedMemoryWindowOptionsList *it;
+    int index;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
     if (!cfmw_list) {
         return;
     }
 
-    for (it = cfmw_list; it; it = it->next) {
-        cxl_fixed_memory_window_config(state, it->value, errp);
+    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
+        cxl_fixed_memory_window_config(state, it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }
-- 
2.43.0


