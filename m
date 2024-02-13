Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0F8C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyHv-0000tW-Ql; Tue, 13 Feb 2024 14:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHu-0000su-Dl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:50 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHs-0001p5-Pp
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:50 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so11564285ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851867; x=1708456667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCjGzp0b66K/4g+8NCWC4cfrL5PhW9DiQFJWcv54wVE=;
 b=NDK6gxxgBPW9NntUsi4EMRqe8EN7iTdovUEB8r0nxKVW6GbBnXdLwDENhZ6FpFnono
 gelvHexRY9HPcItsp9xuY8GcdIH3triURBEz/Su5JZxLghXJ38fb59lVIVz0+6vxbsZ0
 0CDYFGaiuEA/4Q9u5hK3XQAn3OkIEeZxQeEo1siuMShJU4VTLNH9vb5hwmnScwcd+6nj
 CmYvPMI45uZs6SBg/1VIYiQWKWYhSCcjwgnvrGb690UYKbxO62JHKeiqxCk6TsNJl1XT
 IEBzLzN8i2RcoZ6ixXDhwbHanOhCk8r6t1Em/tTuTeDOV3Lt/08/4Os8yQ/DvhCUZ5Zn
 vZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851867; x=1708456667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCjGzp0b66K/4g+8NCWC4cfrL5PhW9DiQFJWcv54wVE=;
 b=ukGADNgCiJ2wSfRMq+egqlEnKaYx4yOOz9iS2aGUS7gu6PiCv7A7KL1r8/Io/aACN/
 FgpSdvWFsUBaRZsGHMeaIUd9hcE+8H5ibMpzuRvR5hxvWUy+mVuaL0k5IxMhpL1sFmJe
 LANPbSAFO0XcpgcgK/Ph9sSTWABlO2fdMxDvdJZEOSkhJP42OXwCwkYBttvxtVaFf4gY
 X87aI72Nbd84Yq5nYhjQ7/oTy2s0L5L7rE4osqz/FZe1XqBMUc0fo04QrHqKSiXor076
 dhSO45vF7vLluVZfBHGD2kXehMCESKMs3wDnBZSqW93T8iPetUEhggfSngZKkBbLdx9s
 4+CQ==
X-Gm-Message-State: AOJu0YxlDLjQL59p3TFlV/VAtC5Dgh4DiMZbFkN3MGdNIOn/IX0n1eX2
 niq6u3wcnD75odZ69vz+f8tBZwL8jXSfT5Hyh388FKA+ji7TblL+Y9Y09WvDI+Z/Je6nrBYp7wH
 L
X-Google-Smtp-Source: AGHT+IEcvI+DmpKZwcRcSx6dIHGSx+2nIb9XT8gl8NAXDvyJUg6kQxiWP9a5RQ9cT4fHwcFMdomHGA==
X-Received: by 2002:a17:902:ef89:b0:1d7:3238:b2c6 with SMTP id
 iz9-20020a170902ef8900b001d73238b2c6mr375965plb.63.1707851867071; 
 Tue, 13 Feb 2024 11:17:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXPmdvc+/jYp6dsvmGU008A6WfnUJXRQH8Y+FCwFJmwX32N5po3p0kkRxe/1J06H95Y2PiCWigYtqMgW/miNrk6f2U1/Axz0WQHL8AB89LFSCvvbg9eribAW609xe+1a40V+NacGUB2Jho/uiAX5GCeI+oalUWALy/hENun8cf79DFp1QjmijKPrHMztDOc4d23dOZhatx/aZu2pf+irLZY2Q6gF/izkE63fCaaPz2ccY2J0K2D5KSG/RkthnsQX6J7dQtZHLAnP0kJptKDIhENouYGLO1ySTFnp+Q4dvTVAZhJn2PE67taj7bUbyWFOQThF5s9gJ0ncBXXWFeNvImHjxUa9m3/9Gm/hfjz/UhdKf9R1bTeM89LCO+ElFTMJy4j/54/Yjn6WlGb
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:17:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
Date: Tue, 13 Feb 2024 16:17:31 -0300
Message-ID: <20240213191736.733334-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The loop isn't setting the values for the last element. Every other
element is being initialized with addr = 0, flags = VRING_DESC_F_NEXT
and next = i + 1. The last elem is never touched.

This became a problem when enabling a RISC-V 'virt' libqos machine in
the 'indirect' test of virti-blk-test.c. The 'flags' for the last
element will end up being an odd number (since we didn't touch it).
Being an odd number it will be mistaken by VRING_DESC_F_NEXT, which
happens to be 1.

Deep into hw/virt/virtio.c, in virtqueue_split_pop(), into
virtqueue_split_read_next_desc(), a check for VRING_DESC_F_NEXT will be
made to see if we're supposed to chain. The code will keep up chaining
in the last element because the unintialized value happens to be odd.
We'll error out right after that because desc->next (which is also
uninitialized) will be >= max. A VIRTQUEUE_READ_DESC_ERROR will be
returned, with an error message like this in the stderr:

qemu-system-riscv64: Desc next is 49391

Since we never returned, w'll end up timing out at qvirtio_wait_used_elem():

ERROR:../tests/qtest/libqos/virtio.c:236:qvirtio_wait_used_elem:
    assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)

The root cause is using unintialized values from guest_alloc() in
qvring_indirect_desc_setup(). There's no guarantee that the memory pages
retrieved will be zeroed, so we can't make assumptions. In fact, commit
5b4f72f5e8 ("tests/qtest: properly initialise the vring used idx") fixed a
similar problem stating "It is probably not wise to assume guest memory
is zeroed anyway". I concur.

Initialize all elems in qvring_indirect_desc_setup().

Fixes: f294b029aa ("libqos: Added indirect descriptor support to virtio implementation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/libqos/virtio.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 410513225f..4f39124eba 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -280,14 +280,27 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
     indirect->elem = elem;
     indirect->desc = guest_alloc(alloc, sizeof(struct vring_desc) * elem);
 
-    for (i = 0; i < elem - 1; ++i) {
+    for (i = 0; i < elem; ++i) {
         /* indirect->desc[i].addr */
         qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
-        /* indirect->desc[i].flags */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
-                       VRING_DESC_F_NEXT);
-        /* indirect->desc[i].next */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+
+        /*
+         * If it's not the last element of the ring, set
+         * the chain (VRING_DESC_F_NEXT) flag and
+         * desc->next. Clear the last element - there's
+         * no guarantee that guest_alloc() will do it.
+         */
+        if (i != elem - 1) {
+            /* indirect->desc[i].flags */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
+                           VRING_DESC_F_NEXT);
+
+            /* indirect->desc[i].next */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+        } else {
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
+        }
     }
 
     return indirect;
-- 
2.43.0


