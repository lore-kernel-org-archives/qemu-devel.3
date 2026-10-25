Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B8606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iksbSA3m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3el-00078c-HN; Sun, 25 Oct 2026 15:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29O-0001ao-CH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29M-0007vc-Ee
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1118930f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949811; x=1793554611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01/dUz0SaXyWuLdPdwDZCZ3MhYywK56OcRRDjbn84eE=;
 b=iksbSA3mnd9a0KZyA1F0osX5St676tTAJSg0vMVqzPYSzgu9uYf5CfSbnglE0R1u/w
 i1fns3EHGcANGvwH+bVnnLG4TZP5kPA6t/d4s2aSSj7fygqvBhQ33tj/byUeqr52YPMN
 f+WsgnVSBveqikRvZS8R5JM3FBoQv/pyLoucWtaHDaSN30V73MQa3n6Kltq7DXDIRcoT
 +B0NrRvW1kffOjJ5uyqPGF+qxjtchSTa3HDxtf5KIf4e/pk6UAOvjbNwxwhhMRFPAlxZ
 QYBqz5TjiQjcAANzNMoALhTMmz6udUeP+twnazEdfPAl2ULrh4uXSX/Y8Zzv92plOefT
 FjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949811; x=1793554611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=01/dUz0SaXyWuLdPdwDZCZ3MhYywK56OcRRDjbn84eE=;
 b=2nCl1ERXN1NgcegB0E7B/TGKCpjwDh4rpDL7tO51ejgBkemgsdfl8kbIMe1p5h2Dbt
 4Iz954guyEJLOhEe+oAYuBrYrFQbl/vvtBNz5Ksm4AoVUwxq3MnMxTRLVgOrTPKyzD/K
 rd6xzcLebMkJDmq01D5kNz0N130VY7tHH+/GhmGcU5z5IxSBwCvt58LGOc1y8iwneK/1
 nfOM/rU6y2GcJ+RRkA3l9h8tlGEUwkG1EJQfvtMdPKgwgAQ+R6dijPUvdOvs+Y00RrEy
 w35aBXZuII9fyNHlV4/BtVfUpeoAqPuIoVbu4bMUeSEVQdqsbKyxD9IPqat/gG0cGOdd
 qzxA==
X-Gm-Message-State: AFq9FYIatc7n6X5yM9yK9AtNtBCGNIPp32hw8Qygyv86AKqMxdwqSgJT
 5t86keMinXZx/1JyW7b8bh/R0Xo8USeBC5WcZyqyB/OFHW5Pv7eE09irthMC
X-Gm-Gg: AYBFou3fmKIyYUrt//AfAi/ITD+V7qBiFELrQzRnmjgP9A6pHVBa45agxVFjekdO8ca
 +XufkQTHt5UOYyo1qIjYiVH6xVaGDIB99QDZw02jld65bKtbh9xmnVUt0Pdtbf0a4j1KjNIwwIk
 Wu+hA/Y2C35/gnqvXJ/pUplKDjy+TvIRAp5GArSb3LxZJQ55w7W4YAHkYtzHMFVAwzUyli2Aweq
 PhxStofZoi4HCyL5v5TQjKBG8M+bhS8Lah0fvJzAq/j3XtSPfrfdPeFMJ90gW0f6RRJkud2aasM
 gYEbZeAUkRtPn0n9Hdl6rJDSyAWJUJHHWsYsqCT3SqXrJ7CZcvktDeWzCRJbzIyRw9a0pK7rdHO
 FnHgbHlELbXgR4vO6fhG1D/By5J89MXHAgME1qFRKDGDqiTfqIdQbMP/60EJLakE0M7t1+2hFnS
 f/B4lxf7qjDW2wBM0cDBbfw68zaoMkFVIslXdHne1MWvIoeE68rbSD9z1VN/X7ffdza3SZjv8c4
 hBixOvQBwzf1Kmaqe+XEHFa+1aESlZBcmldbA==
X-Received: by 2002:a05:6000:98a:b0:48d:f4ea:49c9 with SMTP id
 ffacd0b85a97d-48e3eba8f38mr7718148f8f.54.1792949810957; 
 Sun, 25 Oct 2026 10:36:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 7/8] hw/display/artist: fix off-by-one in VRAM read bounds
 check
Date: Sun, 25 Oct 2026 17:36:24 +0000
Message-ID: <20261025173625.3372689-8-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 15:13:16 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

artist_vram_read() uses "offset > buf->size" instead of checking
that the full uint32_t read fits within the buffer. This allows a
4-byte read at exactly buf->data + buf->size, entirely past the
heap allocation. All write paths in the same file correctly use
">=" (artist_rop8, block_move, font_write16).

A guest can trigger this via MMIO read addresses that produce
offset == buf->size. The read value is returned to the guest,
leaking 4 bytes of adjacent host heap data.

Fix by checking offset + sizeof(uint32_t) > buf->size.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4652
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/artist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 288d466..5f8cb30 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -882,7 +882,7 @@ static uint64_t artist_vram_read(void *opaque, hwaddr addr, unsigned size)
 
     offset = get_vram_offset(s, buf, addr >> 2, 0);
 
-    if (offset > buf->size) {
+    if (offset + sizeof(uint32_t) > buf->size) {
         return 0;
     }
 
-- 
2.53.0


