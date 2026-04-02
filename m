Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66FCD6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2C-0008KK-Kf; Thu, 02 Apr 2026 17:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2A-0008JE-Hb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:02 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q29-00076S-2I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:02 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso282214466b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167019; x=1775771819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=NuNwwD3a+iWe6LJPdo8wKTlKLC4oFZjDpC0OGtTGcauGiOv8RWDzFR/rmpUy0OeiYl
 cI0896e2x+0YjveNcukYU1EpDy0Cze3tjLJDk5vWSZtoMLt+RrxzupAj/sKA5Mq027SH
 OVwvlJrj7ciKGf3cop8VUZoTzkQX3hymfdtGtyn2XnruvXksYGPbEm1qikBUKsWA17k/
 0Wy3k2rjwV3e/gl5UfAZnuIrcWmibufre/sQJ2plzbs60ocVEUoysrsSbSYqf/OjO5Y3
 UcxeovJaY9/qV4XamgfI3WTsqG6C1hobiFWs42q5kSBMD2zGryxTZ8HXEX79POwPcXdf
 ynIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167019; x=1775771819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=FFyx64Q4gqAdmmfay+NH5tnf9kg4GUBr1UGVtPMVasGUhguP1M/Dlow/UKFZN53Agw
 +ZWAgDI0QukvERwSdqLnrPhgOgzHhxfgYGK1omkshsKo0pCs0NlLszVvTqvnr+OIJWS9
 /uv8MewVCY5UBRheJQzaLHXDgMr7q7Z5cEoqCTn2YsHtgYi2sGynul3Ss/LhRlyeLhv4
 38AsaWziAJ27HcuDnahGaRKyI0hCfSQEZgs72ggRTyrSUJPHFPP2EjbwxYh3T7jFC0xf
 8Xz5fdOEvEI72TsPiKyIjciaaSP3eA4PZ5XDIIiZaJl0fYiu22Gq4bYGCut9C6Xb55Fa
 7KzA==
X-Gm-Message-State: AOJu0YzkjrG2UQ4qO7CksYqwV8h3ew23cOvKGyLlzWaFiVWKzo1Uf74A
 PZlIyqrYVPVw7S6JzR2/HN8TBkPqrlNjlrNJ0MepsrXPtrb//irDBpeRyqIvQmuO
X-Gm-Gg: ATEYQzyW6Tb8op78uNkQQcUKDHpd1KpEMCYEqsSUGN56J6WLCf9gN19ROF89hTS5Utn
 5RK24AFNjt/8KB0wj42Qbm1g0r7E6xTOwaolqlioA8OABs+I46dr/TlGVTCjERTLPqX4VG8/X7o
 WL/h3y+epcM2iVEc6fhjZb++tWXfHOiqJjwzE+vlyfztDZ8QOyiduiAMHDYFdX2+P8KYBY1xk2u
 B+G008pGvSBEaMz8tfM5cU2oG6JMiPt5sNgg9+nmVmEOe6MqtE+2djG1/DuY75TMaB6ko2sNKVa
 krnr4XNpoaNybgNdawcVWANNhzH2pIYuWGLKDu88UGDMtqKMxllOc+qPrTx9KY5OSUgE22P/AnS
 FlwP8u9QiJFBOekreiY7SrwH7mJFZ8ajkhn1Y9u1kwWgMPLZmG7Vwzysdq3p/MH9FiI6/6jhi0B
 nf+vgqsjTMYxamk0dndUnuKUSv1x8wngkkym8pLmTomgwdSfsjS7dFx2vYgtC6XeqYtAdwxX7aF
 xkTLRrN
X-Received: by 2002:a17:906:f5a0:b0:b97:6d1b:4be8 with SMTP id
 a640c23a62f3a-b9c46e2677fmr199715066b.10.1775167019041; 
 Thu, 02 Apr 2026 14:56:59 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:58 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 10/33] qom/object: export object_resolve_link()
Date: Thu,  2 Apr 2026 23:55:55 +0200
Message-ID: <20260402215629.745866-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62c.google.com
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


