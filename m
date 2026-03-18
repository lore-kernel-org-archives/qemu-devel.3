Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C910775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzl-0001zx-Tl; Wed, 18 Mar 2026 13:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzf-0001z0-Sd
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzd-0005o0-Mm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aecc6b0861so269935ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856059; x=1774460859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=pVVRkDFqPaOidYm3P43KAn2yKyzASL8czlESJMAiWtPdmU+WGeP9uGSTtm1MQJCHJ0
 jmrUz4sKuzwXX+SFgcEjLusrMT4Qa0x6Ktkh6q98WgsCdu/TvdqKU7ZMlDsy2h3qaAiR
 FO3RvqWs+F+Etz9/qpbH5EdXO8cl4thgNjlZeG+M/gn3pLsa4iDU95qkqmbHJ1StfPRV
 OzAXzFn/Bjo3GWOC+PkmFhp02Q2q4V/Dr2lIUJSVnCkYuDVRCQiuI3w1PxLzxcDDROnf
 3yz6RllMXe+a54wEih7/tFcrRt1K6aMnzk1qJD/PXm6KC0sQ25amk2hCNe7MUC4ZAK1p
 18ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856059; x=1774460859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=f2JFXwJA7OSom0qQjDYjp2mytZ40iPljx6x+CLzQ3B8bK5zpeXXYJpLwWICSqT6gsk
 Z6AfkkrDLNxh9kNf8e1V+4iZugCNnZxqL2IdsRYTYkaddMvsrcgGSgHxDCBfiS0bG4h+
 T4Xn/oLcZyxNJr7tUNLgnEl/rwsQ9S623clh5Gnc0njaqmSJFsX3Ch90spqwPX6CkEtB
 qyDGwgIiLyVB7r4hlOyKreeeNWsGgmUmW8slitwLJ4EPW+UJAoKfmw8PJmoVZWzi1MsS
 kGWQcnmQQfAyAzUC9RD5TeSDWdLE1WvMopwJnpYjpHuAp1PPeBfXN0sHtfkUHWiaaXcS
 CeFQ==
X-Gm-Message-State: AOJu0Yy2SPG/GdS4WT9FC6ymcRZGLbN+0H/D17Y2WUlP0nSG50yXQgEG
 7chGI0j/bLFwQfXyHncZCRufn9Yt3rrf7lHE0mKbM17bxAq7kJbmficQJM41azwq03UG0pVKl8n
 9/DVCuuE=
X-Gm-Gg: ATEYQzwAxufjgDeH5ZjjMx32phTm3BphjiuQ0vAwnOcTzWGZpqNJvNxMLoheDvwI7/G
 dGyg/pCJV37DVQJoi6jVk7hiDCP+7YyX+K/kNXcTKOY/77h6Qhsrsj1EkelE5L0pCWXqo0NGdhi
 kqC/GS681JWi7QTIO6yf7AyCVGRb636Ov10iLTaYSg6vAwtee/OwGeXkv6L/mP+JNWmnXZ28XYo
 gNv3/PCUReLkcScT3M/TXfGmNw/IgeFWXP9ILI5AMcE+QNMHDdXHpMhL3CC/T6i9egF1MheBSeE
 MwZqeP0OqZ/8mpexD/B5qcPImexjfRC58TuEREXZG0Qba8NJV5lL5mWKESBAM5OlafPsa009qdm
 0O7Ex5PH4rp1o89U3qFY67R6iphwO+iLhjq6UV13AhSfzr8yBcz5utOOfx1X2XVFb4H2tEO53YC
 Ek64Yd76F1MiaHpvuUDWuyeU+Ao7q86JeoOBLpHTkQeZTzfHFJGIIPV0gmc2NvgiU1DAU8Pd1p1
 sLuTpnTbUS64p4=
X-Received: by 2002:a17:902:d506:b0:2ae:803e:6c0d with SMTP id
 d9443c01a7336-2b06e34dee9mr45552205ad.19.1773856059176; 
 Wed, 18 Mar 2026 10:47:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 1/8] hw/vfio/listener.c: remove CONFIG_KVM
Date: Wed, 18 Mar 2026 10:47:26 -0700
Message-ID: <20260318174733.1717643-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Code concerned is under a kvm_enabled() guard.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/listener.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a93..31c3113f8fb 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,9 +20,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
 #include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
@@ -303,11 +301,9 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
     if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
-#ifdef CONFIG_KVM
         if (kvm_enabled()) {
             max_memslots = kvm_get_max_memslots();
         }
-#endif
 
         QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
-- 
2.47.3


