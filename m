Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9j-0007XA-6M; Mon, 06 May 2024 03:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9a-0007Be-UK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9Z-0001kz-BN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR2g9jkVWlGLAB7DDh9+A7HqZElWfzJuBsbUVbmFt4Q=;
 b=WPqP9BdJW9zooPsJnvqTdXzeVDRe978y9IX2Hb0vHYSkwKbKT1Rp4xAve70sQNK5yg8qVu
 bu8kFps35rwEjwjrkW+RsOQ29cO1kfddwYghzFAUK6PCjaua0AZFCNSel0Wr36SfEPgNWP
 oTHZTOaX7lrWwL3yN9J0zQ817Exl5l8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-97Htq_yPMVam8fvjEX6tqg-1; Mon, 06 May 2024 03:52:51 -0400
X-MC-Unique: 97Htq_yPMVam8fvjEX6tqg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51f22618c20so1189078e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981969; x=1715586769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR2g9jkVWlGLAB7DDh9+A7HqZElWfzJuBsbUVbmFt4Q=;
 b=CkDDv9h1vN5xl7aOWJaNtB0aogVYkqjFa5G5/2VyMbeetPFnIeo82YMslFW7wQgpuS
 vGQ6vb7YyfCkuktBDU1kZv/oK/yRrqqIKaKgPHaVbiG4J0MvmzrWP5jRBk1qdtbWWQyI
 0nbnIn59UOlvcQvwlGzv0mjNelPy7feP63NyHbpuUHJjv7t/eFsU5GPY2OjofL/TEutz
 +NUUNG9dZKJoOKZhvbTbtaXk1P0GPRgcu5fH4zP0mln+I6Ind4fXQ5JJXaUpLeRY4N4s
 d5kloTTt0ATJhl6HCot1pc51ez0VJjG6xj2SOYnf/psTpCnvRMPiMS67ctIESMqvesyv
 2cmg==
X-Gm-Message-State: AOJu0YwPkiFmP2bhybeOiO1AEIiZgnN/YFbOalGQQGZ+vB2bg4ghgNcs
 qbGPRtIcdtzYNg1Bl14HK3sXvm3Z2qTDeNtfSaCG+4E6Lw2xCa9pFKHkM5Ee4vafm4wLGDuxexv
 95mDSCdBqcVa0Tpdh6ELyguD/LvWEOQkFUjEjly7hLfQs0rQU6xt8NXpc45v5bl5EoMZS1myJMX
 h/+RtpY4x/D4mlszaq2mee+0v6Sl9HDDJFZ6Q9
X-Received: by 2002:a19:f60f:0:b0:51c:cc1b:a8f6 with SMTP id
 x15-20020a19f60f000000b0051ccc1ba8f6mr7247946lfe.20.1714981969071; 
 Mon, 06 May 2024 00:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn2hDtxBr5nb3hK+NUCo/epXvGZhjxJ6vLtl4lMiG1153ZhvLkslYV/ZhkXKhzAhniOk71Rg==
X-Received: by 2002:a19:f60f:0:b0:51c:cc1b:a8f6 with SMTP id
 x15-20020a19f60f000000b0051ccc1ba8f6mr7247931lfe.20.1714981968742; 
 Mon, 06 May 2024 00:52:48 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fw16-20020a170906c95000b00a59bde503a5sm1843363ejb.48.2024.05.06.00.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/46] numa: remove types from typedefs.h
Date: Mon,  6 May 2024 09:51:12 +0200
Message-ID: <20240506075125.8238-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Exactly nobody needs them there.  Place the typedef in the header
that defines the struct.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h | 2 --
 include/sysemu/numa.h   | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 66f0b146c8c..e0a0bc31e7f 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -81,8 +81,6 @@ typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
-typedef struct NodeInfo NodeInfo;
-typedef struct NumaNodeMem NumaNodeMem;
 typedef struct Object Object;
 typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 825cfe86bc1..04676141470 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -36,7 +36,7 @@ enum {
 
 #define UINT16_BITS       16
 
-struct NodeInfo {
+typedef struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
@@ -45,12 +45,12 @@ struct NodeInfo {
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
-};
+} NodeInfo;
 
-struct NumaNodeMem {
+typedef struct NumaNodeMem {
     uint64_t node_mem;
     uint64_t node_plugged_mem;
-};
+} NumaNodeMem;
 
 struct HMAT_LB_Data {
     uint8_t     initiator;
-- 
2.44.0


