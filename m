Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67674C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWy-0006VT-RD; Fri, 24 May 2024 06:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWv-0006Th-4W
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:09 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWt-0007eb-Kj
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:08 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e95a1eff78so9102331fa.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547924; x=1717152724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAPTdk2tBTLhsGMXcyf3g+dPATMhben3YmhgWkc5O5I=;
 b=m8o7LBFT3+98efzsb0IHYK0suZpryeJlTF/C9SPHvc7QK5QHpzwHkVjoZGaa2sltTI
 NWWSEvDO/QnTVzcoL7B+V7oS7VpKgIAFiHxGE9y/rK6e2qGAoYzfzMSEnV69f8Ngfhtb
 rPsLYbRJ/MpzbT5hjjf7ki9UwMjxvKb0e4VkSE2I04dXIOOjkOIT+HIQrEhQGnzBnsij
 QULSsDXTiPYzmmHuZE01+tpeOPd1f0G3nkfukTQ+NrROjq5RjNUfUMBrOtRvIkw6y2+o
 e1rJWRNUgi333S2Aw1qnDV+7Xvx6zeBPoj1q6nXZEAwSPIgx+t3Q8oN0EAR7grbfvneg
 2maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547924; x=1717152724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAPTdk2tBTLhsGMXcyf3g+dPATMhben3YmhgWkc5O5I=;
 b=BP9pq0arLsrENc+8rlhwe46HvRDLK0zZCFpWjEtw12E9M2j/5HD6XzSgaESJyZIB7r
 T4NpZYE7jrhgEpt/Rs3mK3jJj7Phl7k89gJkCsqkFzwLusXit9GTNYUKBSI5F8DhRYIG
 CRlTFHmbEerDPxobfOPF+wR4/cbUM35Vl+gBeZoC8nBzGhvqKUrBmUh4HmOMe54/uuTg
 rwAyw4fekgwu1aocpimifwb36sxUq/U7z46+GDOjM/MBIVDXnBXS52aX8iyks0K8XHU/
 Qg6DlL00YlqI+lTR0T12y8NwEzqizoyd9TNKy6bGwk1lM7XXORDESlm3LHccsvXelMSb
 S3LQ==
X-Gm-Message-State: AOJu0YyB9UWbUDQTS3RiCeXWLB9WnE0JhiZph6sF5Iasioc1XNUmaVGM
 x458nUzM4EZZdRQC4jXhNesUqXEib4rK1ThTh/zazHM4tLg9ZbtSEEjzwS9d
X-Google-Smtp-Source: AGHT+IFUjna/f3aSbZaPkjcscT5RiiQTauvOvojfkAQqidjrCDubERIlSddZtrR+moSv9e6MGInP8w==
X-Received: by 2002:a2e:b04e:0:b0:2e6:f51e:ec1b with SMTP id
 38308e7fff4ca-2e95b042c6fmr16760271fa.3.1716547924259; 
 Fri, 24 May 2024 03:52:04 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bf26002sm1473161fa.136.2024.05.24.03.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:52:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 5/8] softmmu: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
Date: Fri, 24 May 2024 12:51:49 +0200
Message-Id: <20240524105152.1301842-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

For xen, when checking for the first RAM (xen_memory), use
xen_mr_is_memory() rather than checking for a RAMBlock with
offset 0.

All Xen machines create xen_memory first so this has no
functional change for existing machines.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e6257ef65..b7847db1a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
                                  len, lock, lock,
                                  is_write);
-- 
2.40.1


