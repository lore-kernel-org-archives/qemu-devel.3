Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CBBC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3X-0007mK-OA; Mon, 10 Feb 2025 10:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2n-0007Er-TI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2l-0004i8-Vk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2361828f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202594; x=1739807394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZ4KLCN5rTxCDwJzmAh6VIQu5Td0a43voxEJaqli8sk=;
 b=gCMCHnDp3GkiPt6jf3ME08BVFZKnR0zOBAPkdHxn/0TEHokJb0TLi8TPQYwbyXubqP
 ltRnCWOq1cWyhESFUQEvNPZBIZ/+FoL/60THGeUIaj1G77W9H592RmGLyLhAEIM0mwgy
 9CpxHujqhJiB8USn1hGm2womS1n2N+958OM3rVdHTv6PEMPzNCxI+hf+ezb+OgjIXK7F
 3BgYw0CGI7imciJFDwjhztRZML7k8K0U2eHRbEWwWBmgBfbUeR52DFD5dIVO+k6QMoAa
 B5RksN3091p/4YxJeWSGfSUZQHfD6Ird5IVSwOxJXNoRGL0yf0KIH/hU+WEhSRgfCZLh
 9FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202594; x=1739807394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ4KLCN5rTxCDwJzmAh6VIQu5Td0a43voxEJaqli8sk=;
 b=qKyyfgupH4d048QERwANhPQOcH8Gqnu7E9zl34CrAg3v07iwjoKK3QGzTdwDbibnRx
 1p8Rr1Fi2vljgbUgyGPqLSOeyHnkBpp8fJUKmuzxOk++6Orl/wBnMaxh1Lwd/b4fbabP
 SdI2NVB6K4GIDUP9E25DYsnOSiEvf+QJjyyMNUTG4aFpnPYaN9Y36LvqCA5Te1ZlPwv2
 JyiE12tzC4mpk8gQr+E3HlIJXA2D/Y3Dvl6wjLBTSNh6KxR2kCNjSWc2IG2AH1YgD5mf
 ZjgJgfPW0r6VCiVNea89AKO8+JTn+sq5Rbdjhn7CS26wnif4EjMZ02c+mzY9lhIWgJAt
 9kVg==
X-Gm-Message-State: AOJu0YxrxhDFkXb2mcVO9VCROa7cNMbVM513P76V8a41CGqWdzifGIZy
 P9rx39Aosu+Wf5vDl1qYrDFtsBggGH/kzjPV7a7Bxl7oNyQ7sDRZRUWqjUPocT6jAWxHerkdQ96
 M
X-Gm-Gg: ASbGncsNqAsHpfGy2q0VxJnrtw+3TE9OiaBCctCPm+1Bt58gjsRtWtQ7MNUl8DIoMRK
 QXtKpy8yW04D7KDSPVapiGb5nSmI3FxuwH/gIewPp+oFLqwVj3FiaLE/EsssiiamoCe972zyf2/
 XweymiXLnFlRAWJSmY67PHZNvqHMqDftx/OE5mUDjjIj7FRaFOEZLOL7ffzEkDoU8XG79TYNBV8
 NiShCkM3Yp33ap2Xqq4aVQySB+rAthOsHSGFCZctUtqrBZqnnJ0feKsanSIzzeHyczyO5KlNU5U
 5bH9ZUIxqTOysXFEuRr5
X-Google-Smtp-Source: AGHT+IGswfkqKoVumkN1pCBydcMMR06ixfGsFyxBrXjAY3QkoNSogXyL9iAfRLt7a8i47BkjQBpncQ==
X-Received: by 2002:a05:6000:400f:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38dc8da6361mr9668002f8f.6.1739202594553; 
 Mon, 10 Feb 2025 07:49:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES()
 macro
Date: Mon, 10 Feb 2025 15:49:39 +0000
Message-Id: <20250210154942.3634878-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20250130112615.3219-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a15mpcore.c       | 21 +++++++++------------
 hw/cpu/a9mpcore.c        | 21 +++++++++------------
 hw/cpu/arm11mpcore.c     | 21 +++++++++------------
 hw/cpu/realview_mpcore.c | 21 +++++++++------------
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 3b0897e54ee..d24ab0a6ab2 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -164,17 +164,14 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     /* We currently have no saveable state */
 }
 
-static const TypeInfo a15mp_priv_info = {
-    .name  = TYPE_A15MPCORE_PRIV,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(A15MPPrivState),
-    .instance_init = a15mp_priv_initfn,
-    .class_init = a15mp_priv_class_init,
+static const TypeInfo a15mp_types[] = {
+    {
+        .name           = TYPE_A15MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(A15MPPrivState),
+        .instance_init  = a15mp_priv_initfn,
+        .class_init     = a15mp_priv_class_init,
+    },
 };
 
-static void a15mp_register_types(void)
-{
-    type_register_static(&a15mp_priv_info);
-}
-
-type_init(a15mp_register_types)
+DEFINE_TYPES(a15mp_types)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9671585b5f9..25416c5032b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -177,17 +177,14 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a9mp_priv_properties);
 }
 
-static const TypeInfo a9mp_priv_info = {
-    .name          = TYPE_A9MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(A9MPPrivState),
-    .instance_init = a9mp_priv_initfn,
-    .class_init    = a9mp_priv_class_init,
+static const TypeInfo a9mp_types[] = {
+    {
+        .name           = TYPE_A9MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  =  sizeof(A9MPPrivState),
+        .instance_init  = a9mp_priv_initfn,
+        .class_init     = a9mp_priv_class_init,
+    },
 };
 
-static void a9mp_register_types(void)
-{
-    type_register_static(&a9mp_priv_info);
-}
-
-type_init(a9mp_register_types)
+DEFINE_TYPES(a9mp_types)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 94861a06d94..b56bee6d543 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -152,17 +152,14 @@ static void mpcore_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, mpcore_priv_properties);
 }
 
-static const TypeInfo mpcore_priv_info = {
-    .name          = TYPE_ARM11MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ARM11MPCorePriveState),
-    .instance_init = mpcore_priv_initfn,
-    .class_init    = mpcore_priv_class_init,
+static const TypeInfo arm11mp_types[] = {
+    {
+        .name           = TYPE_ARM11MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(ARM11MPCorePriveState),
+        .instance_init  = mpcore_priv_initfn,
+        .class_init     = mpcore_priv_class_init,
+    },
 };
 
-static void arm11mpcore_register_types(void)
-{
-    type_register_static(&mpcore_priv_info);
-}
-
-type_init(arm11mpcore_register_types)
+DEFINE_TYPES(arm11mp_types)
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 7480b38d1ab..b1408886184 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -114,17 +114,14 @@ static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
     dc->realize = realview_mpcore_realize;
 }
 
-static const TypeInfo mpcore_rirq_info = {
-    .name          = TYPE_REALVIEW_MPCORE_RIRQ,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mpcore_rirq_state),
-    .instance_init = mpcore_rirq_init,
-    .class_init    = mpcore_rirq_class_init,
+static const TypeInfo realview_mpcore_types[] = {
+    {
+        .name           = TYPE_REALVIEW_MPCORE_RIRQ,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(mpcore_rirq_state),
+        .instance_init  = mpcore_rirq_init,
+        .class_init     = mpcore_rirq_class_init,
+    },
 };
 
-static void realview_mpcore_register_types(void)
-{
-    type_register_static(&mpcore_rirq_info);
-}
-
-type_init(realview_mpcore_register_types)
+DEFINE_TYPES(realview_mpcore_types)
-- 
2.34.1


