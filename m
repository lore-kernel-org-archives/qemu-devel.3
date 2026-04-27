Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA092FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOBx-0005Wz-09; Mon, 27 Apr 2026 11:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3N4XvaQQKClYF86F4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--rkir.bounces.google.com>)
 id 1wHOBv-0005Wm-LW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:11 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3N4XvaQQKClYF86F4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--rkir.bounces.google.com>)
 id 1wHOBu-0003vn-4P
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:11 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-354bc535546so10618410a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777304888; x=1777909688; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=m+euPCGzXKAX2DOBO4RfOMZ5ORa12ZSpckTUq80KcUY=;
 b=lp0lpi7/IQMB+UnxFTEWoVHwL8C+iF4JAVnfI42Ipp91zuFNJkAOf0jBPWY6TZh7/P
 2gSIR0WiYmTvoDglRb97qIWmAdwrBLYoi3pCdqhk9vozP0FFjVslm6JDwQRBkNhcb++a
 xKWparZ+/SzPltNUUqkiED1s8ftsPnZiJzef9ZF9y9I1oUy4QAidJF+HgplPj6iue80A
 CkQJuQzsftjIChiaybreZpRXSFbfe8JvVEsiydXJ935Ni/h0npD9QjM2+sQYhtW89iy1
 66qpcutA2c0B1f0IHCVhmQH6DIchbzhjCWCBG1aNIIa5XKtm9W6Q5eQ8wqVNBBbcxmI3
 zThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304888; x=1777909688;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+euPCGzXKAX2DOBO4RfOMZ5ORa12ZSpckTUq80KcUY=;
 b=VeeVcRGY2x7DtN72YKl/0P6CA1MTQY2eHbqT1R66a2auNBq0HrLfCRwJSxL6pJpVC1
 Mzjw+C8AH7Ccte0uhIL/GR7AxLaHGvfVJVCLucg6OgkUEbSCFNlUXhgF5eLCxmPnn+9d
 ZdzF+ivbTvYmJv7T7stNLREzygavSuxG2E78Xbhr81QZ3BGvxhgSkxx6dojkZ/b7IfAJ
 yxD9FJobzrJ+HFIj/ju6F5i4UhNkhNGkRCVdf3nROxgliraYYeveahZmcNXX0iX0JX1d
 jt34pFu16vqodN/vvaJLUd1DEvlU5zk69xzlKN99bppwO4GTQYpiOrVSr6F0nrdb1BcJ
 kGYw==
X-Gm-Message-State: AOJu0YyEuERJlUq4ln27xzXTI+BdE5FkXQyfaEN9SQN8b+uwPW0gg+eF
 N8lNJ+nIuUu00SeH50wu9Y0lmUhh3g36GjQ3oPVtxTYn471Pz5q1qc0a+5IoteeRdkyKqsV3Ag=
 =
X-Received: from pjbmr10.prod.google.com ([2002:a17:90b:238a:b0:35f:b524:f8b2])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5845:b0:35e:58d3:3286
 with SMTP id 98e67ed59e1d1-36140498567mr46498994a91.24.1777304887710; Mon, 27
 Apr 2026 08:48:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:40 +0000
In-Reply-To: <20260427154441.1918536-1-rkir@google.com>
Mime-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427154441.1918536-2-rkir@google.com>
Subject: [PATCH 1/2] qom: improve use-after-free debugging
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3N4XvaQQKClYF86F4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--rkir.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch invalidates dead objects so their usage will
lead to more predictable results (crashes or asserts).

Change-Id: I1dc36dbc1030c2e41c937f08baa97b2e81d44c82
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 qom/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index f981e27044..240e36c39e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -613,6 +613,7 @@ static void object_property_del_all(Object *obj)
     } while (released);
 
     g_hash_table_unref(obj->properties);
+    obj->properties = NULL;
 }
 
 static void object_property_del_child(Object *obj, Object *child)
@@ -670,6 +671,8 @@ static void object_finalize(void *data)
 
     g_assert(obj->ref == 0);
     g_assert(obj->parent == NULL);
+    g_assert(obj->properties == NULL);
+    obj->class = NULL;
     if (obj->free) {
         obj->free(obj);
     }
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


