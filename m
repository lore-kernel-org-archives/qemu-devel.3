Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86766E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Ml-00053k-AV; Mon, 02 Feb 2026 16:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1MJ-0004uN-I1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1MF-0007Mf-Ge
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-480142406b3so36656815e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067276; x=1770672076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=egZXu3DNBQBdQ3b5iffnLqz+XIAliqZ9sGLkXEZxMkE=;
 b=hIYm14CoztFTV/64c0BbuTRGh57jQ4V+IQJGPGhZLMuVEURGXboogWGyw0ZEGC6JbR
 n89I1HUCSQAaPdMoS0IjhYZIJQM3jQJYPfSLOZ804C+gkBpFWlH2k9r2Z4n9xEPcdt+L
 gOUHgcwo/AS6xNdJDzn0lY7nLo/jStjLCx7EYaH07Fj1RiH73oq5zRFnU/Mx3Ebj9hJj
 zr9wHvIsijGxPMLZBm/vsMF4a6lGabRBwZmB4TFHabeUlWjPxd8GATrQM4IpVZY8M6b2
 4z0a+/9F4/1VYUFRLRlzjk90RNNC2S9OXSiUBrLSOJiJX/g7Zpv/Hlu0rDiX0MjuJ1qI
 X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067276; x=1770672076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=egZXu3DNBQBdQ3b5iffnLqz+XIAliqZ9sGLkXEZxMkE=;
 b=bllfh9hRz4M1LZro2M5Cii1ZxgV24dYI0ybgrVCNpASXk8Efhz22OeJT/4HY9bLNOw
 EXY3i3dwMjMczc2Y8DtNt4vfJS1TVb+z1gxqA748DsALary7jAHXL7Eq7U519BI6lEpf
 eW3+wcvQoJzi1iDRBVDC27POVpeQBKtY86nC/HLCFJP29tcmSNDkFnKFxv6TL8rxdA2v
 8V6srlfBEAH6n6YGQ42ZvbrlhD38qLv/P2IgLsfQlf4wxHdosbyxR27m0vrs52pDXNzn
 10Fuz2krbMcLbMOmwf43JH7nZmco5W8V3vcaGi8D4Mb3jtALZMNRq3653Lycxk6bL/MK
 pJrg==
X-Gm-Message-State: AOJu0YwUV95+VMlxbDyvfLZuG6xJiinH+oHEXAh6OglT7s9w8274FPdZ
 OX9rVfoMZBp9y+rMEaDvpcUb1STOxorh/UF9cfWLK0GF0SCZWyRgtUuJilIn9Z6v122Yv+bobXV
 qMVn1gHM=
X-Gm-Gg: AZuq6aLVTzxVAtsa6qVzlm9BXU6A/wmmHOok4OaJJrAFcBQGR7FlkQUe+pRVOc14S85
 GQrPBks4aUtIC3NBWhmaugT16yqJZhJTBdiHgOQGr5Ofj2OX/xw9IwpChzlWQkW81mwZtGHZ1JN
 GdRaaXXGf3IcrR5KXSt/GFEIH71n0umY5Rv6awYBKpp2Ky7tFN4TmyqKaL8BPT+WyPj6shZPd2L
 D8PeLb5lgsnvHn03U/mUGeTQ4QLuAtvJIR651QnQNzlWVmCaENm1qq8dGlx26g1VNfQer63vala
 DqG1JWqXWH9QNpvRgUCxtRc0oXUpqh3K7pG5ddS5f4utydWXf2DmCmi5ZUu1F9FycBHR28LMBwf
 5b5rnv7DjLFCxopScQWtFGcEzCqbX9d/ITUyDMubr+rBBMpO/uhqJ6IrIyH397Px7s+qBoorcF6
 h9HQF1xdAjhRgMVpO1mccJp9Eh4BnUwlpKl3tBVcV59JdRo6CE4R9gvfQ+usNmTKDCwTQ79ZI=
X-Received: by 2002:a05:600c:628c:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-482db47ce39mr171234055e9.24.1770067275765; 
 Mon, 02 Feb 2026 13:21:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbcf9684sm118700725e9.5.2026.02.02.13.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] hw/nvme: Fix bootindex suffix use-after-free
Date: Mon,  2 Feb 2026 22:20:11 +0100
Message-ID: <20260202212019.94205-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The bootindex suffix can be used as long as the property is alive.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/nvme.h | 1 +
 hw/nvme/ns.c   | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 8f8c78c8503..d66f7dc82d5 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -239,6 +239,7 @@ typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
     int32_t      bootindex;
+    char         bootindex_suffix[24];
     int64_t      size;
     int64_t      moff;
     NvmeIdNs     id_ns;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 58800b3414a..38f86a17268 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -944,12 +944,11 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
 static void nvme_ns_instance_init(Object *obj)
 {
     NvmeNamespace *ns = NVME_NS(obj);
-    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
+
+    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
 
     device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
-                                  bootindex, DEVICE(obj));
-
-    g_free(bootindex);
+                                  ns->bootindex_suffix, DEVICE(obj));
 }
 
 static const TypeInfo nvme_ns_info = {
-- 
2.52.0


