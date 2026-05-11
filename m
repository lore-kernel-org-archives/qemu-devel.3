Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23AFCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQgR-0000X2-Oj; Mon, 11 May 2026 09:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agarwal.vineet2006@gmail.com>)
 id 1wMQgQ-0000Wt-0h
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:28:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agarwal.vineet2006@gmail.com>)
 id 1wMQgO-0006xt-Cd
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:28:29 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so4190581a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778506106; x=1779110906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Mgi60AVQjdDo4uAUqDxD4yW5h5uW3gRwueZrleiCFk=;
 b=OahPAVkUyr9p+Q/jBB8A6GeWWrnjG40bK/MHIwgSzrCzLlbzskq8OaifwnmtxEpRnp
 KG6dsVRgM+1z4smCwldbykhLuSEJmgR9XAWChCA13yi5AZKtVjdy45AabwKQZcoeJIa6
 s/DbFTuU68/cGnNU+awfnxT66E3Xt9bzLgSNOaVNL13ltbeyUxthdKfYEgbHd7YhzM6R
 A8uI2STOWMMmsKoLT7ocZimWMqayWaBTT4fbtJZ1Gk+4UM4j+02+BIMrxrezeOqXziZL
 JaRme77O6w45o4fuExI8fbhjdQ4ZAk8wBGP5LSvYkTPBIfaKQiCqSrPh5zRXoNfF+Da2
 Qe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506106; x=1779110906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mgi60AVQjdDo4uAUqDxD4yW5h5uW3gRwueZrleiCFk=;
 b=QQwtht5LCovle8FH80GCPJV3lsq7jwCXFR4qZ98Q3nNYicXGx92C01zBrOxHe4dM2S
 XP6En00CsTPLv5J6nF8GhRVAheAD0kYFItI1B57fey39qesJQ6SkgC6s2UoMs/P+iT5s
 mY2v2UYCdYThhpSazeSgjGdufDgb3ivIVfJLyZkVHZ2diqP5pRvlTQdUl8beFuK4SWHc
 kyAFWcPtL0SrTrZB/bJzWuh0JMlhMLNEEv3+T/3TgNWL7oSOcShmFr398DnZ2Zb7Zq+c
 ZnbqSr7tGONx+QMDnqTHJs4/zQ9i7TWs7xc8CZBM2RUUC5aKsycLT4RaXeGdSrYY+d45
 um8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aYq9Dloj99a/deAkxjxqB9WRM0/SxNczgRE0pDkvG/SdfxboC+rDoQMSTpzylckh7MpiSsGd46XKV@nongnu.org
X-Gm-Message-State: AOJu0Yx73IDu2f9MBraVnWqDU2AwwWBhQZu9SUMHM6s1ktcKvqWcRsZK
 IevUaEgfzQ+60XKnj2wXoRsPwF5+7HeVQtGygUmp5/fBjmf3RyTfDcCI
X-Gm-Gg: Acq92OH3PUbqP1JYr84LMfcNHc4q14RILirSJOTE98KuSg5gUdcFi1fb0E9WUIUj+Xh
 hdQOHEreSJLT17CDPFt537wUfzQ14M+ryOA/AHoDkTfnMLJr/HRMpMr2nstuLWs8lRHIuiHltUb
 oso5KoMCqMmlrAeUvF9UlGnOo4NMTYd4zLdtGlayFnmsJW6HoLJIkuy3WguBXUa7qpQPNhyhE+y
 ijW5V1CXDq0a5ji2dC9YQxihK8p9bgFciVBAXXON4MAw+irUQuWhV6cBXSJCJ5RwwcW3la5mpQ3
 bUsKWq+1KKM43/Q+UTpk08XUM9n6LJbk45t10kIt5yzmzdH6F7LIexk3P4qLe7cOiJWK7djAzBo
 mQd+4BdMimrCsU7Q8fYF39+Qtpyjuf5ng6cd7a2udUOnxDxE7b9uTpdAiQW5sBoL0u6/8i9h+U2
 a3Uu3Xb74jNG0RyREuC8egJGGahgms2g==
X-Received: by 2002:a17:90b:45:b0:366:159a:c228 with SMTP id
 98e67ed59e1d1-367d468cf75mr10421896a91.6.1778506106168; 
 Mon, 11 May 2026 06:28:26 -0700 (PDT)
Received: from vini ([2401:4900:8fc8:73c6:dda6:576b:fa0d:f68e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e9723esm112837665ad.67.2026.05.11.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:28:25 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] hw/core/sysbus: Guard sysbus_mmio_map_name() against NULL
 names
Date: Mon, 11 May 2026 18:58:14 +0530
Message-ID: <20260511132814.63954-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=agarwal.vineet2006@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

sysbus_mmio_map_name() passes MemoryRegion.name directly to
strcmp() without checking whether the name is NULL.

Commit e27194e087 ("virtio-gpu-virgl: correct parent for blob
memory region") intentionally introduced a MemoryRegion with a
NULL name, so sysbus_mmio_map_name() should not assume names are
always present.

Add a simple NULL check before calling strcmp().

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 hw/core/sysbus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3e1160ee92..80cfed442e 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -148,7 +148,9 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 {
     for (int i = 0; i < dev->num_mmio; i++) {
-        if (!strcmp(dev->mmio[i].memory->name, name)) {
+        const char *mr_name = dev->mmio[i].memory->name;
+
+        if (mr_name && !strcmp(mr_name, name)) {
             sysbus_mmio_map(dev, i, addr);
             return i;
         }
-- 
2.54.0


