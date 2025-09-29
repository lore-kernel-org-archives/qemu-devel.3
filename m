Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1CCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G4z-0003Cs-CF; Mon, 29 Sep 2025 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4X-0002tq-9f
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4J-000810-Ju
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso21874135e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160736; x=1759765536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5duVBAedShsIcSkwo/CkemVnUoYuZ0b5Z9+Uw86N4Pg=;
 b=EmlZDPVMgOAKRE49nHsPYiSrRv7W9b+iNcNgCcICmjECSWWnV1Z6FCZx1+MZxSbNTs
 RfmDTu4pkineZjgf0eE/mjwKL3hzWXN9LGdoeWzcQmt/SXLXBPCIhCu5ap7Xnblrfeap
 9Vl3WjONRzq4onGJ5pDRTGI7Yq2pj2FDRLC05rJCgxVvF+sO+afKh0YOQT5FOQE3oR8M
 5fQlNfuaSam8Cewuzs6MBBd/CslFw3vtcfot+uSzFIzjLL120+4IWJzM614EFJpkEHxp
 OX3O0MFREX7HQ9eFf+Bd5UpRdFyOg1kniS5wjlchJNY6+j3BNCe3xtygZxALGzPSJUNB
 Q8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160736; x=1759765536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5duVBAedShsIcSkwo/CkemVnUoYuZ0b5Z9+Uw86N4Pg=;
 b=Db2gHJp43lG9qPBrwgog84vtiD1enxbYv2ogr/Tt8unsXlI6ezleEqolyqvWF/U5AA
 eH/eX+ZOMCYQo+JL6SGHvOhqWN8jmdu0O4db/khxV3InjtP76jgbiRVEDNp6M1ATayLA
 CArmlSW+pk9HrtKW3EHMkgwXh3VrcLDzQJlwOg3J4MNVlO84FS8Kgvvf2W0EhvHfLh9a
 sS+WyncEzVkE61UBH6H17xMOB3d86ouRxGRbNcfFQb+e5/PWkv0Xd9A+ximWRGBoEaMU
 /Jk9xHTwboXr/EF+8pJFoeVM+VpeioodvjivdA0APGo1J1js5j75M+nZb31wxg6hUv1D
 trCQ==
X-Gm-Message-State: AOJu0YxHxJ+mI4opzHjToskmnRWNPUdlGmasuqwFBv37k3GHQwWd2hXn
 gX3Y0rBITXfOjOOHG3ph89R0nmAunV+s0etSxlSE96yKf7bnqeQXbVRWPawbYILVVyUm6mQkyox
 uVUd3a+IUwA==
X-Gm-Gg: ASbGncvpkL7aAOIkfItL0orQZ3wS4UfIRrn/yF70vStwI5ChaeKeUtNYgFO+YRMWsIk
 ZsPJNemNnPvow2ye9GPj1RsgrUjYDxZKQfjaqmup1W7J3rpXOXeqV9HZWoeUW4SrKdtnk0+9I+O
 XzbnRtciNvHnA7ZKe9qm6Mxm66shPDnuBh9lBAYBQifN8syeSAcZMJVVHJ8XIJiSGh6XfC2KL0M
 oSHjDHcHougxiWx3vmmbGbFuC5GBYJgVd+grkP2b52wy+Nx+TF7E+j2kvS9IYSL/WjRlNyGvzqJ
 K1LJFvSFSOvP+E66HOREk0SvlA7bFw2WCHliOZGvNlqk3gR5sz3S2U0wUJq5pwVnhrsRXniZq8r
 41hEwnqw/g01y+l8SZNcUUjPU6XfY0fuwswpVHTnSS1Su+CUgcw3/AEHpPeDdIcM3Aux3ZRJz
X-Google-Smtp-Source: AGHT+IFnrr+DJyaTbMYchai+g7LxYZJVHLrsdZD0UddcfiiaoKSbGm+KV6blFypn4IkDHPPrhdVuzQ==
X-Received: by 2002:a05:600c:1d16:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-46e329ee194mr156056255e9.13.1759160736157; 
 Mon, 29 Sep 2025 08:45:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3d754sm18544875e9.4.2025.09.29.08.45.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/6] system/ramblock: Remove obsolete comment
Date: Mon, 29 Sep 2025 17:45:24 +0200
Message-ID: <20250929154529.72504-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

This comment was added almost 5 years ago in commit 41aa4e9fd84
("ram_addr: Split RAMBlock definition"). Clearly it got ignored:

  $ git grep -l system/ramblock.h
  hw/display/virtio-gpu-udmabuf.c
  hw/hyperv/hv-balloon.c
  hw/virtio/vhost-user.c
  migration/dirtyrate.c
  migration/file.c
  migration/multifd-nocomp.c
  migration/multifd-qatzip.c
  migration/multifd-qpl.c
  migration/multifd-uadk.c
  migration/multifd-zero-page.c
  migration/multifd-zlib.c
  migration/multifd-zstd.c
  migration/multifd.c
  migration/postcopy-ram.c
  system/ram-block-attributes.c
  target/i386/kvm/tdx.c
  tests/qtest/fuzz/generic_fuzz.c

At this point it seems saner to just remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ramblock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 87e847e184a..8999206592d 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -11,11 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
- */
-
 #ifndef SYSTEM_RAMBLOCK_H
 #define SYSTEM_RAMBLOCK_H
 
-- 
2.51.0


