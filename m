Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B300D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvzY-0007zf-7k; Tue, 26 Nov 2024 08:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFqXY-0004hO-6D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:03:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFqXV-0003UL-1j
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:03:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21145812538so42457745ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 00:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732608194; x=1733212994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c3rZxnvTwyQvkWJKdeGmyoAhgKD9L896K2Toi49f/K4=;
 b=SgdbtKGEFgrxMqGoy1OkhpmPcYEK+2edxRRudmT0IJ0ZLfYMY5DvIb7prvh+NmVsKn
 XjTuar6xIFJtGE3nn3iOr/2UPLpreI6tsENQB2u9fMX7sFNGCqzUo8FHHF5iOAle1CjV
 yADqwqHKnt5oLEa51GqxreIbkB8hXuugSdlKyegCRdvjVyVgMmX8d/Bd5a8NFyBrswct
 67olwV6CXI0GYin+XTcAafircegq2CRGBAGZfdCsXGLPtdtDl+5mROBzphSqEM4S0WLX
 vCTr+i1ZaYWeb5DqopQ299fllw369ijUyrGTTqX7JXOkSmmUnTz8ZZDcXEOO69BBIaOh
 XfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608194; x=1733212994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3rZxnvTwyQvkWJKdeGmyoAhgKD9L896K2Toi49f/K4=;
 b=xThE53aVDjEmWOqXHD0k3pu6HUO6gMb3cj/xQS2kbl/6nXinqZ3l3i6VbarBLCozpd
 eXzZ0qgiuETHFQg4oVaWOX18WxOaVnvd59ubplG0EJIugosVXoO41n0ZrzQlWZ1zfhMH
 HSUY1fLxNfOrv3y5+T1CPcynIi7FHRyGp4rlVHpRAnrhQsaeAsLK4hd1xPgJnMkmMlt9
 5f096oBRFxU95okVtTS1RDA3EdY8vypb7z1mFGMO0oLNw0rLZ2/8XuYrcl52UGjb2AvA
 KZW7vBn4jYbCW5pnaC35a29qXnQCdYx599xIOiaEEAkPiGtseXpmi8o1qr84f7IE4nyt
 v7oQ==
X-Gm-Message-State: AOJu0Yyct+gCh2MhaWRLg64Y8NMR9C20v+WeepsntIXSIPZt1BDDXrk+
 GHawE2ZxfuvYV9ZScoe79/dgKKLYkXoFZbtN1hfjye505KoO47jKvnhuUjbejTCHsg==
X-Gm-Gg: ASbGncs3Au7lJWSKFkmQiwaXN+crhAtixDKZs6eY//PrWuxE9DjpyjlrtT+7YgF0PlA
 b0E751xhX1wMXauB+Xvyw816H/WETZlSAW8F5/kY1jd6QqDOBWVB8ebKk4+CkLDYW2sE8eurYUF
 gCM4Z3ugD5rpgawIaqK4bo+b4mTlBLLfalkQQdUaeCQty0o5McZ/u7XvV0V+YIQ1uTD35ghjkFS
 iiMCfu5vn3uLJJOoQEr9K99anr1EpnLEoDDankx8F/WJt45jBb2fJcK7ZicK+bZzw8IPEci
X-Google-Smtp-Source: AGHT+IE4o41DHKYVYw/Cxcw/im1rEx92qvpa+aYDzZs1yFIlsVxCLR9CySVwq1+DA21U8ZIpcdiXiA==
X-Received: by 2002:a17:902:d4c6:b0:211:6b37:8b4d with SMTP id
 d9443c01a7336-2129fd5c7b4mr203328705ad.45.1732608194494; 
 Tue, 26 Nov 2024 00:03:14 -0800 (PST)
Received: from localhost.localdomain ([212.107.29.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129db8db4asm78718375ad.10.2024.11.26.00.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:03:14 -0800 (PST)
From: Wei Chen <weichenforschung@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, david@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Wei Chen <weichenforschung@gmail.com>, Zhi Zhang <zzhangphd@gmail.com>
Subject: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
Date: Tue, 26 Nov 2024 16:02:13 +0800
Message-ID: <20241126080213.248-1-weichenforschung@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=weichenforschung@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 26 Nov 2024 08:52:34 -0500
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

A malicious guest can exploit virtio-mem to release memory back to the
hypervisor and attempt Rowhammer attacks. The only case reasonable for
unplugging is when the size > requested_size.

Signed-off-by: Wei Chen <weichenforschung@gmail.com>
Signed-off-by: Zhi Zhang <zzhangphd@gmail.com>
---
 hw/virtio/virtio-mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 80ada89551..4ef67082a2 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -671,6 +671,10 @@ static int virtio_mem_state_change_request(VirtIOMEM *vmem, uint64_t gpa,
         return VIRTIO_MEM_RESP_NACK;
     }
 
+    if (!plug && vmem->size <= vmem->requested_size) {
+        return VIRTIO_MEM_RESP_NACK;
+    }
+
     /* test if really all blocks are in the opposite state */
     if ((plug && !virtio_mem_is_range_unplugged(vmem, gpa, size)) ||
         (!plug && !virtio_mem_is_range_plugged(vmem, gpa, size))) {
-- 
2.47.1


