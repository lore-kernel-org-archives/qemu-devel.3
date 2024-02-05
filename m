Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D2C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2FT-0003q3-KZ; Mon, 05 Feb 2024 11:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FR-0003pR-1x
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:09 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FK-0000Vm-La
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:08 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so647057166b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152100; x=1707756900;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GE9FQp5IqKdaxvICnBK99j0uS0woDRaiB8rUGevheDU=;
 b=2O5VzVjS5r8fQO4AfqDoRIl9E5+091BKn2hbcBGeAlFsL/4Erj+QhpfUZfSKChamlj
 WzD7Hv31BdEJtNspbIeJcz1DIHH1uffF/q5UdbgVNv3TWfQJRmE5JCOxgLn9W5jY1M67
 SKDIETReJCHL29HLv6xpgggta4ED5HB/lwVKDknCn3B9hOVrDUasfY3XhLPflNK4Hni1
 iSujTl8zMQ4ky9ODQ5bDYD6x/OxTCnWXKetCt+j87MkVcMum6q+mKGZB7BLf15J1NWLb
 gPNPHqa5qzkhoHIFnjPF9f6Vo0koD6vW0iEeDPIuTHo1b2i3zgAE4oUsh8vkNt8/+uL7
 TUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152100; x=1707756900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GE9FQp5IqKdaxvICnBK99j0uS0woDRaiB8rUGevheDU=;
 b=w9pTrGsmhR+7q5hNmg7VTtSM3s7GIEAf/UAO+iQLV2qFJvfWmEoD8NNAlXjYKVzIqJ
 UcC5uDR3LjmObhkfahFetUpokujopE3CaTq1zMjneR0x5qiMHswZEsPdoY84oW37CBuA
 jv1dTnmngOPe80Z6dhkkg8Z3+NcL7RY8xhwpACRyVI5ldXoF8GiNMebi/Wf+FOFtnRWR
 qIWPYDntocSqQ3Y9PSAdzjSjUzAZYFeC/lopY7HcM1LpLzW7jGVdiL62e8H3JGPduKEl
 OgW3IlsjjbYa00xrSZlzd7lw+EckyHB9lNWoM168xUCbfgcXle+6lfJ6z4nVAs/h1VCm
 JV0w==
X-Gm-Message-State: AOJu0Yxhdk6R0DfBvCZaBAp3Loh4nO/cWUyXRKbDpyfBNLwZk8w2Lq/l
 yPyPSNmM8hiratt084Fw6e6s9PoythfxLD8eUrjh2okjrfE+bOkfjD4mX8P97ISIik2TN/QUSZR
 W
X-Google-Smtp-Source: AGHT+IETP2Pws+k5yTJ65XAWi6U5TGzI86Ndt0MYkDQHVvBUOCnjA3mPWSkMb2t2QGnoSwcxYc0jpA==
X-Received: by 2002:a17:907:3e8f:b0:a36:696e:c542 with SMTP id
 hs15-20020a1709073e8f00b00a36696ec542mr14076ejc.33.1707152100157; 
 Mon, 05 Feb 2024 08:55:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVZAbbvUgkCRTWjxdL5G784WEQoeB4zMmi20eNjQtHOjsX0KF3W7PKTtavJrCTumbZuDxjZpw/ssfd94EEKM2bV8TjGEZI2EmphBZJsGCjf0Lhcn/eBjYZxOiaA9Vl/sG9GaOk4Wew0NnR4JuvgKnCqCNfVgRqWts5bL4E1lZgJ54Z+gv39aWvCW7Ht7uCkcIhbGoM8ESWDp+WcTDd4dQUJi0hkIUWKWaiDMXH1lry7dd8hyXeVbp77Zkk=
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906074e00b00a370a76d3a0sm20580ejb.123.2024.02.05.08.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 08:54:59 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v9 2/5] ebpf: Added eBPF initialization by fds.
Date: Mon,  5 Feb 2024 18:54:32 +0200
Message-ID: <20240205165437.1965981-3-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205165437.1965981-1-andrew@daynix.com>
References: <20240205165437.1965981-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::62d;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It allows using file descriptors of eBPF provided
outside of QEMU.
QEMU may be run without capabilities for eBPF and run
RSS program provided by management tool(g.e. libvirt).

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss-stub.c |  6 ++++++
 ebpf/ebpf_rss.c      | 27 +++++++++++++++++++++++++++
 ebpf/ebpf_rss.h      |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index e71e229190..8d7fae2ad9 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -28,6 +28,12 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    return false;
+}
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index f774d9636b..150aa40813 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -146,6 +146,33 @@ error:
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    if (ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    if (program_fd < 0 || config_fd < 0 || toeplitz_fd < 0 || table_fd < 0) {
+        return false;
+    }
+
+    ctx->program_fd = program_fd;
+    ctx->map_configuration = config_fd;
+    ctx->map_toeplitz_key = toeplitz_fd;
+    ctx->map_indirections_table = table_fd;
+
+    if (!ebpf_rss_mmap(ctx)) {
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+        return false;
+    }
+
+    return true;
+}
+
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index ab08a7266d..239242b0d2 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_EBPF_RSS_H
 #define QEMU_EBPF_RSS_H
 
+#define EBPF_RSS_MAX_FDS 4
+
 struct EBPFRSSContext {
     void *obj;
     int program_fd;
@@ -41,6 +43,9 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx);
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd);
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key);
 
-- 
2.43.0


