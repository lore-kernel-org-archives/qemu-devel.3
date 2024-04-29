Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E65C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HeX-00037w-2s; Sun, 28 Apr 2024 23:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1s1HeS-0002nt-3B; Sun, 28 Apr 2024 23:26:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1s1HeQ-0004LA-AY; Sun, 28 Apr 2024 23:25:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f3e3d789cdso2078144b3a.1; 
 Sun, 28 Apr 2024 20:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361156; x=1714965956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGndkpX8zFykxd0+aOmMXx0HjUfMtkRzpuTrli0Be+I=;
 b=MAi9AZQkv5h0YcIOcv+v98JxyRD3H5rwqhSkVxxmd65IYdVvTn3AmnW2kv1GitpaVl
 zJods9OfGmTVlLPcoLfH3VplOPYQ0lxzxbk3foYc0C9XKDo7mSmcS1cq/jufR6HtoexM
 zx9dUA6509bXO6nW2XRAav14BIUeTM5lJtVXb4WX+ACWLonLSfoMLr83R3xncS5CD4Yj
 L/7sQjPMu5rSbAg5zhuAhAqSJWl0PJKbKY3NBlnCULhZIPzOUq+xAHt/cb/I+khB01PC
 k4eebB5Dhg79g2TFjwIAN6Wj2UkscqdJ4+KdsxaN6zOq9oYwF79+QjGkGXE9amWP5JTt
 6JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361156; x=1714965956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGndkpX8zFykxd0+aOmMXx0HjUfMtkRzpuTrli0Be+I=;
 b=rMHm7TlbXAMPR0R8z93gBSA5ZcTmRLWEENb9IZMwcQQIBnm054rIRg1P2GcWtNgNNm
 OasLCR6KG3VYKAJwwneCZWa+h/qvf+75JIfjBP4YXC4OwbBNi4rFtcq8OMoxxO0Xfsmh
 VanuA0Xb4rY3nMVWmelAWQ+ConZHp89EdxJueIIw/g6YpfTA4GGx/wzQzZY0v/ttmrqj
 PSqgi6Xx7++Un7zZG5CnrpZ5p5qRDExzmsDf1jGh94c9PGIu5ZrLylH7lS0Nph9xQksy
 VQnBtWbb/vELVq51CTBqVMua0m65+dmBplRh5elUVo9i1EmXX8/wUCi4M5h8ugQIX/qP
 pHlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwlA5rpAoNSmWl4TmzafDPzPUl/9Wg1T+DSYRB6PP+qjJrXcFshCdAi3IAULroNFrwo6oUeDEe2lnhcKMWJOonN/MH6PM=
X-Gm-Message-State: AOJu0YxDPYpYeIuHxdXQgguCD0c2otb2GT27Vc9fkfhR/6tF0CX9+8kN
 218OoHFjcbnXWxJ9QckGxRwbyvqn8BjnobylC5LO5BwsuzxxiJ8+//LvAA==
X-Google-Smtp-Source: AGHT+IFwr3I8t06UQ5gfn1/T4gw6b8enlpK5YvlAXKbqmSF+LLL8rClfzTL2hbEx8gGe6joWjeE43g==
X-Received: by 2002:a05:6a20:5643:b0:1a3:b642:5fc3 with SMTP id
 is3-20020a056a20564300b001a3b6425fc3mr11368120pzc.41.1714361155736; 
 Sun, 28 Apr 2024 20:25:55 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a056a00130900b006eae2d9298esm18213121pfu.194.2024.04.28.20.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 20:25:55 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, zheyuma97@gmail.com
Subject: [PULL 1/1] hw/ufs: Fix buffer overflow bug
Date: Mon, 29 Apr 2024 12:25:38 +0900
Message-Id: <f2c8aeb1afefcda92054c448b21fc59cdd99db30.1714360640.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714360640.git.jeuk20.kim@samsung.com>
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x435.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

It fixes the buffer overflow vulnerability in the ufs device.
The bug was detected by sanitizers.

You can reproduce it by:

cat << EOF |\
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
outl 0xcf8 0x80000810
outl 0xcfc 0xe0000000
outl 0xcf8 0x80000804
outw 0xcfc 0x06
write 0xe0000058 0x1 0xa7
write 0xa 0x1 0x50
EOF

Resolves: #2299
Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index eccdb852a0..bac78a32bb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -126,6 +126,10 @@ static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
     copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
                 data_segment_length;
 
+    if (copy_size > sizeof(req->req_upiu)) {
+        copy_size = sizeof(req->req_upiu);
+    }
+
     ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
@@ -225,6 +229,10 @@ static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
         copy_size = rsp_upiu_byte_len;
     }
 
+    if (copy_size > sizeof(req->rsp_upiu)) {
+        copy_size = sizeof(req->rsp_upiu);
+    }
+
     ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
-- 
2.34.1


