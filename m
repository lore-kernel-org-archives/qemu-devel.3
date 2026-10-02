Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C92CCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdrw-0004aw-0F; Fri, 02 Oct 2026 10:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdr7-00046e-QS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:39 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdr5-00086M-VB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:21 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 d9443c01a7336-2dfaf76605dso25350235ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949797; x=1791554597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KKj70xiMz7h/gagRNUkAOOkov58WG1YJeesJ3q/MfEY=;
 b=csnofDTGo/HQTHy/FlgASnxCHSdUuV5XUKRTAB1NNxndvbIbm9bIv57gQvchK/dnp7
 N/OT1IvyZg3ujLn+/u685BKtIBDuDK1A6enTRyI2gkBwIuIL0cGgiXMtCLCdx3/Q9GDq
 EiPDxZd00nMIqfGoSKo3j6VOtchF3qEpzKd6lzFETwmPAtBNRDHf1Z5hpBUmgBXbPM9Y
 ozF8Czj12Ld3z3daf8KHMZgyNctN8ZGvp71rakCJu4rneO12HwriMy7De/bAS9mhbqaE
 DJeRR9DmhO4wj4kqERd386rWWixlxB+vAYFFpFRe7meUsTVtPQrmVygx7zuoD0kAhQao
 74ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949797; x=1791554597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KKj70xiMz7h/gagRNUkAOOkov58WG1YJeesJ3q/MfEY=;
 b=EPZSM1KwxAn3DbqGSV2+zYYxQCvptsNcE4JZuTjRobbaeaCIX96uAvraF/4PnPkff8
 xJC1bn9eAXwMYyXTjyiwlbTlQcmdTBeaXJTfjnIQ3JhkGVOTvYpI5tnwIw9bwCgWyNzo
 5kYsl6EMTVz1NCkoeVQXnQQZL3P38XDZ9HFuiovBdb2oKKXnOatvuLpOzuqGmuUwLt6i
 QGlBsHMmPzjKm/fbtScLPRmSOuaHIOMynE8EOtV4OKwBMtzzKnMY+Oi0FMev+LnDstV8
 Q0J1Kjy+AUdkuWXOOeqnWLUHirDe0j2AeRYTXmfXggcwodOmxiliiXIekG+RoInz5nUk
 wEtQ==
X-Gm-Message-State: AFq9FYLFdznNSVhHdWSBXiX2Ve8YpJqCp7zbrGmF+l0l9E9VPAgVMQnQ
 MWnHXOXVuJuGl70lwOja3WpVhXqXU8dz+jyNYVAUEQxkMeAfIt9lwaof4Y8YJ5Fv
X-Gm-Gg: AYBFou3e26Qn22kx+hTcE5r/s4bSgmdHEQphoaGh6cvXv5QjGWFEMowo5v2eT9k+57E
 RFFJgmGGNRqtUm1NhIkiDQ6Tj9xouIVj3xKh2LSkpZv0Z+tCsdCYEkzQfTULTcwzU23RjezebUj
 8pZBAKdESD44aliOQPHIg8qbg2Cy0bYrnNq6owzu0osoZKta8/CNcYyRo+e5QjYD+WlbLWk9pGL
 XptWbD30w77gwNRt8xFLUoF0379J9YQLrcV8amZzYCPn2oQNtVvWguSxZgQPLg4otvcjeHrNowB
 DeNClkw1RJ8Ogbc05g9udGVMUWCZvHCVVYAoDXhAhPryKuqKeEUN7jQHPUzB/boLsIIfAKn8N40
 63BeHL3nz+ze3sOyE6fo7ua+GqLjX34Rqb+b+ba2tOffTfud4zT+6VTYQFoJrtCbe7YyEerbf/Y
 7Crqky6bnVaDM/4Sp6o8kS9ZvJTEs7f7yP+VTj4H+eAIxSK4M+ihhYCFLCEyJiXfmBgG/SnuP7j
 WTixuGMZmkTsc12op0ytx7w1xM=
X-Received: by 2002:a17:903:3d0e:b0:2dd:c100:4b82 with SMTP id
 d9443c01a7336-2e49b6dee89mr26152415ad.57.1790949797429; 
 Fri, 02 Oct 2026 07:03:17 -0700 (PDT)
Received: from dt-VM.localdomain ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f723a77sm7996165ad.71.2026.10.02.07.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:03:16 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 5/5] hw/dma: fix k230_gsdma integer handling issues
Date: Fri,  2 Oct 2026 22:02:45 +0800
Message-ID: <20261002140245.30214-6-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002140245.30214-1-dingtao0430@163.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Validate the address before subtracting the channel base and use hwaddr 
for channel calculations to prevent unsigned underflow and truncation.

Resolves: Coverity CID 1685514

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
Compared to patchv1, the modification of ch has been removed. 
Because ch is an unsigned int, it is sufficient.

 hw/dma/k230_gsdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
index 7635cd19e8..e422b436a2 100644
--- a/hw/dma/k230_gsdma.c
+++ b/hw/dma/k230_gsdma.c
@@ -329,6 +329,9 @@ static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     }
 
+    if (addr < K230_GSDMA_CH_BASE) {
+        goto out;
+    }
     ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
     ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
     if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
@@ -355,6 +358,7 @@ static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
         }
     }
 
+out:
     trace_k230_gsdma_read(addr, size, ret);
     return ret;
 }
-- 
2.43.0


