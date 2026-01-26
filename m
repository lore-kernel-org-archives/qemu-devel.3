Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA4D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd9-0001ek-0l; Mon, 26 Jan 2026 12:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcw-0001TX-Qs
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:51 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcv-0000D0-6f
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:50 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so4330958f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449427; x=1770054227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=RD1p7pSQtxsmm05Y5K2AgKi9CFwid6MQa6Bpb18jz9uFTEyRTEF5IfTFv8liezM06X
 bEBiuIYwqmYbU8ASQESHdL0x3CuaktzQKPzac0QO12eQQBD6QtcxSfufazDz5IZ6jN5p
 bgCc4nmBttFPsQMhHtn47ftwEz0AHc75NpnnKl4iTAA8BzxsJm6OKBq2qzv4u1STjrek
 cH95AjwN/snGw64koD+aGMkKom0ImdlPS5ObWhqjGCQuJblkd5pZ/nJDh13QpDUm4iPT
 jb/jDIZs4InB7n8/dexfE6UNAwcS1xkHxRSzLUlHF6SX+mCVEVQdS1MPiAZ+AnCzrEAR
 kn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449428; x=1770054228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=bmPfSmXsdpD2VRvLK7W6m+R/d9h43Y2uPj7uSlJuz6xyYMKGk4XohCyFMdGMVaeiT2
 j13h+B9JWK1eHKTWXTJetaOFGWlp8z4atLWIMVUdCsfAEPtCp3MKDVKYrAcbl+GRd0HJ
 CpyNIiy2KT7SNQ/d8GRHyRO5VxAeq0EYphT3F7LrcvZxWDnvGesp6SjLjHZd6u4ZPzbT
 Y96CoxAEneX1p6rncXBxhGITS5m7kXjkCu1aT+cBNfoGZr2Uuj/liHyCAjePc/AuY1Ng
 mnqLpd189huXn4G4YOz+n8HpYkKpWUDZXaImx93ldwOBKM0JWiPJI6aZWAGA57q4mYGE
 pfcQ==
X-Gm-Message-State: AOJu0YxK43aqmJumOosjCzBwX21XviWqkrkFoyLmtnMAfzwktkBR0Zp1
 x0doUnrGdLL5ivmlXQXW/aIfJJM+CQwDO0CDzPtfErXQ+rpkV6qjpi6vwokKUzJn
X-Gm-Gg: AZuq6aJ+GGEX07EoHelE834DUImFmqQJhwmV2loEYuQYDO2ECQVNdgkdgbdsqIaHHEv
 xivsxObGj4/euSoNYFkcqZLdngxV6c4S+NUPzBnkC3ulIi+Yh28yAd3N+fB3/3gKjzJ1W9Ue50A
 ybzvptCpbpOplSp088KOn/hylLGT4USuCZxjRi2JIW3yBqlw9kyfMtESXE4EZ7O9ItchWYmg4ox
 I7NmSoxiFRTUTsvb0M7vgQHFSCp4Ob7WEqs/GLn5GPxSke6wFLXYu/h/CSIJwRU8z0nJG2hmpMQ
 zS1rGPkVfgcSr7vvNVA6Cpu/eOau/f+jV3VlTnNN4DZYmBVUlGI+TR3hbf/+v+7Kziyu/ApkMND
 gkEn8MXTK5d2fFyYfMPV3eOkpJxHZG93Fi8vBbKYH9kiq8fzalRNoY3bQpLvXXhFD9ULOyCg1N9
 uvexVTUkZFR9wonHX6zL0gmIQY6/bks1QEiCFghRYmU9danKqNw40lvg==
X-Received: by 2002:a05:6000:420e:b0:435:9ee1:f91a with SMTP id
 ffacd0b85a97d-435ca3a43c4mr9883719f8f.53.1769449427416; 
 Mon, 26 Jan 2026 09:43:47 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:47 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 23/27] qom/object: export object_resolve_link()
Date: Mon, 26 Jan 2026 18:43:09 +0100
Message-ID: <20260126174313.1418150-24-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42f.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Export `object_resovle_link()` for use by other
subsystems.

This allow callers to resolve object path and verify
type contrains of a link property.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/qom/object.h | 12 ++++++++++++
 qom/object.c         |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..1573d41d4f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2034,6 +2034,18 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *object_property_add_new_container(Object *obj, const char *name);
 
+/*
+ * object_resolve_link:
+ *
+ * Lookup an object and ensure its type matches the link property type.  This
+ * is similar to object_resolve_path() except type verification against the
+ * link property is performed.
+ *
+ * Returns: The matched object or NULL on path lookup failures.
+ */
+Object *object_resolve_link(Object *obj, const char *name,
+    const char *path, Error **errp);
+
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..7e16765cb4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1904,7 +1904,7 @@ static void object_get_link_property(Object *obj, Visitor *v,
  *
  * Returns: The matched object or NULL on path lookup failures.
  */
-static Object *object_resolve_link(Object *obj, const char *name,
+Object *object_resolve_link(Object *obj, const char *name,
                                    const char *path, Error **errp)
 {
     const char *type;
-- 
2.43.0


