Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C3EC35FE2
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0y-0004vj-Kq; Sat, 14 Sep 2024 21:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0v-0004eE-U8
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0u-0005ep-48
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71911585911so2897922b3a.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363519; x=1726968319;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CdRY63ffQFqOcAWbqBHjZhZUrkr1co+m6SgDSpmyEPE=;
 b=aBEigefPiL3XB6LG8Abfjh7A+fPO3kgoMlYsfkC8SoMcVu7zh8+N8hGUUV1hFwVwFy
 ybdaMIxQh8lQWFzKg6modOF/J0LuBs0F81y/q7qcBemREzsejrI28hC+RDnw5YxTZn+L
 Wru5ccPzUoU/Jj182es09VEiAPZcPK9/st0iqni10eZklKJ9W83MCs5ow648VoVKvPoP
 +/8fP6VFkiz8Sxhizfk78O48zCcRW2NnyT8wlPc3H9O2cGI2I++pymDXq6zeGconh8sA
 Hpr+LBQk8ADwJWHQgVM9FPWyo278FiDRZWNlCqfJgj+MS5TRxv1C/PD5qHYsW5/vCeh0
 DgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363519; x=1726968319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdRY63ffQFqOcAWbqBHjZhZUrkr1co+m6SgDSpmyEPE=;
 b=HDvr88bOHYEvRYIviHP15jeBg1UfmRAeR/RKDOpN+LLWc+8oYV7nL5Mw6XeG/uRI6q
 L6LVFSTKopJFzq2g8QAIsuYm3HYMmLpJ69yyAu803F55iXj7bs+ygA4ML3bV93r5c68I
 l6CVuhCb8eP6ZcIuG2Dk1mmm8oRxvTNxGuo9yNkUHgeoZbIEMnaaJ58huem4BZ/Y5xWO
 6h840g6j1tMvijMGjmiO0WH+gttWZFUsBWZt9R/yTZdqut4+2Sf9qlnuhsUzNoN8dtK1
 LDEsun3SvDf9jPPBKgj4Kvf4Sr/MA6BIy4xK/uJMX8f5AW4/ibvLekZrhMuaj7HMJYEt
 aTDQ==
X-Gm-Message-State: AOJu0Yya79avXLW5zPbKwzUF92ooQMxNSi0ZzqVaQKFP/4THgZjPeNRv
 baFDYA/R82ZViDDL0HbQ9wdXBSvZIscq09m4cEN44/fw4Wf1MBBeo2UuStE5NVEFnUaFfHY19lZ
 KKEY=
X-Google-Smtp-Source: AGHT+IE0cB4d7jRE8OfdjaJVelZJxIWLsNvH+4lYszvBHLWNGt0YFUefas5bjxZc4uiS9Q7bStFW4w==
X-Received: by 2002:a05:6a20:c6c1:b0:1cf:2ba0:c36d with SMTP id
 adf61e73a8af0-1cf75ea277emr14580005637.3.1726363518649; 
 Sat, 14 Sep 2024 18:25:18 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7db4998f3besm1745669a12.62.2024.09.14.18.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:25:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:52 +0900
Subject: [PATCH RFC v3 11/11] docs/devel/ebpf_rss.rst: Update for peer RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-11-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

eBPF RSS virtio-net support was written in assumption that there is only
one alternative RSS implementation: 'in-qemu' RSS. It is no longer true,
and we now have yet another implementation; namely the peer RSS.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/ebpf_rss.rst | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index 4a68682b31ac..06b09e8a3fed 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -5,9 +5,22 @@ eBPF RSS virtio-net support
 RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
 by calculating packet hash. Usually every queue is processed then by a specific guest CPU core.
 
-For now there are 2 RSS implementations in qemu:
-- 'in-qemu' RSS (functions if qemu receives network packets, i.e. vhost=off)
-- eBPF RSS (can function with also with vhost=on)
+For now there are 3 RSS implementations in qemu:
+1. Peer RSS
+2. eBPF RSS
+3. 'In-QEMU' RSS
+
+'In-QEMU' RSS is incompatible with vhost since the packets are not routed to
+QEMU. eBPF RSS requires Linux 5.8+. Peer RSS requires the peer to implement RSS.
+Currently QEMU can use the RSS implementation of vDPA and Linux's TUN module
+with the following patch applied:
+https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com/
+
+eBPF RSS does not support hash reporting. Peer RSS may support limited hash
+types.
+
+virtio-net automatically chooses the RSS implementation to use. Peer RSS is
+the most preferred, and 'in-QEMU' RSS is the least.
 
 eBPF support (CONFIG_EBPF) is enabled by 'configure' script.
 To enable eBPF RSS support use './configure --enable-bpf'.
@@ -47,9 +60,6 @@ eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap co
 
         tap,vhost=on & virtio-net-pci,rss=on,hash=on
 
-If CONFIG_EBPF is not set then only 'in-qemu' RSS is supported.
-Also 'in-qemu' RSS, as a fallback, is used if the eBPF program failed to load or set to TUN.
-
 RSS eBPF program
 ----------------
 
@@ -65,7 +75,6 @@ Prerequisites to recompile the eBPF program (regenerate ebpf/rss.bpf.skeleton.h)
         $ make -f Makefile.ebpf
 
 Current eBPF RSS implementation uses 'bounded loops' with 'backward jump instructions' which present in the last kernels.
-Overall eBPF RSS works on kernels 5.8+.
 
 eBPF RSS implementation
 -----------------------

-- 
2.46.0


