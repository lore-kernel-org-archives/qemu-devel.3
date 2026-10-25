Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE170606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dR3y9yU/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3ej-000786-Lj; Sun, 25 Oct 2026 15:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29G-0001IX-5c
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29C-0007sI-Ok
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1291320f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949800; x=1793554600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YWTO96i43u688Xw9Jc6X3ctuvyGvDNY5EEACshF1qY=;
 b=dR3y9yU/aVzV3a0L2D4tizW5zrl6JeMDYx746yYX0decoeWacR4YqQH5zrWlrABOAL
 ePPaRLl/M5EtjnSthRE9Fg3mBhkuwYd5xwomQcTKlPukV7/61tymKI1m/jl16EaAvVeA
 B2rGAJoNJoLT+Rdc448QabhBvmfnU+zYVJ/8Ljf6D3XQ+0nzlA22YZO8PyLdYeP/AhMP
 vFK5TT+oVvIDGlE4GwMYC7yc/k2jj3Un3yRzDNdFELKNSdsYd94WXKlrJ0jf6QHo9hRn
 fAflR6fsvQ42as9ArXaFnBUjZhH/RnCpA8KZFcPink9jKZ/uAvlHsVL8e5UBMZL3u2/s
 Owwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949800; x=1793554600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YWTO96i43u688Xw9Jc6X3ctuvyGvDNY5EEACshF1qY=;
 b=PrQMh1fb0CEkkPlhthGp0FW36ErQFjGHVejfsUVPdxv1f+0BBr1/XWG2gmsPw5KzVZ
 7ABH0vgFAi0FiZmYMLMVveR98nOrgWSZ4wYEYyDSj9scw8pW6QNRTzaqgqSa0Tu4Otbp
 dhZZeA//xF1XHY8dH6BWoWSC/xq4+VBMQpZbW+IimOz3pAQ1jdQgMywAg7fiD671xMlI
 v090QAwWGKs+nr/yBhKjcT24n48dHdFXIulIyjzoAMG76hY+fXeU6oehBI5Wb3JG1LvL
 g1DrqC22Rl3opMeGmO0Z2+R5MxNseQp9ThZu/GgGUFHf6L/6ENJhe04pANOsDgfVDbDo
 Qufg==
X-Gm-Message-State: AFq9FYJ6HxWKtR0zk3tLFL4AJgCJKe3muazi6HdI+MZ3G8j0sYTi9gro
 4B/BBDxEICPipw8g2OJZSUzMivq6J80A04AAsdBGH+jpxlUM659ReDNhHVSQ
X-Gm-Gg: AYBFou0aavFvHh5yJK8yZRnyErDLQejImO7YORCcZqgAGFyaRArq7Jl13+gBkRjaGQV
 8A/SntSazYma3T4ZPMKJ17uQUr9T3gNbPMfgUXgvsMfGp9vmBvLKm2zVTcoBHb7JRr5R03Htxap
 sHB3uw1bBxtJm6wBAZGCEZSjn7WCPpbtD2oiMMPnucto/IfQLE6JIZu2TKW3v2Hr8ZZ8U8MyEx6
 6hjW9xTcoMrDgB/ErZOseFk4hUIgUnzgc3DO+YIQGQAqs4iEFXmqqGX7VfuHrRpCkoalPXPtPLC
 zbBMKWQ2UamQxVKfeqcAXhkvNsVt9d7i4qfRPjsJqla/3hsYCzkKVUxt40n8wK6pvgQP24IhSHU
 6apEmu3mGDXDFRvvrChr0oh0rI/XGR7seA6m8fVu6xIM3ILeSZkUGaqDwNx+dQHpZ8NrkvyBKdX
 Z2RPIMuQS0tX5TaIcPL0aip1+VLG4s9Zw/YN7WuchrNl8xkUgOxRTdTKdQpidPcCm74Po0kh36s
 cVdwZafT6e8kBXoEGk9VOXMxX9KK2f6LxwN8w==
X-Received: by 2002:a05:6000:178f:b0:48e:3678:5112 with SMTP id
 ffacd0b85a97d-48e3eb82340mr6622755f8f.21.1792949799670; 
 Sun, 25 Oct 2026 10:36:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 2/8] hw/display/ati: reject 2D blit when width exceeds stride
Date: Sun, 25 Oct 2026 17:36:19 +0000
Message-ID: <20261025173625.3372689-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The VRAM bounds check in ati_2d_do_blt() validates the destination
area using (dst.y + dst.height) * dst_stride, but does not validate
that dst.width * bypp <= dst_stride. When a guest sets the blit
width wider than the pitch, each row's memmove/fill extends past the
stride-computed bound, writing up to 64 KB past the VRAM allocation
boundary.

This affects both Rage128 and Radeon models, and all blit paths
(SRCCOPY memmove, PATCOPY fill, pixman_blt, pixman_fill, and host
data blit).

Reject the blit if the row width in bytes exceeds the destination
(or source) stride.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4647
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/ati_2d.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b9933fe..3cc7602 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -168,6 +168,12 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return false;
     }
+    if ((uint64_t)ctx->dst.width * bypp > (unsigned)ctx->dst_stride) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "blt width (%u bytes) exceeds pitch (%d bytes)\n",
+                      ctx->dst.width * bypp, ctx->dst_stride);
+        return false;
+    }
     dst_end = dst_off + (uint64_t)ctx->dst.x * bypp +
               (uint64_t)(ctx->dst.y + ctx->dst.height) * ctx->dst_stride;
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
@@ -207,6 +213,10 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return false;
         }
+        if ((uint64_t)vis_src.width * bypp > (unsigned)ctx->src_stride) {
+            qemu_log_mask(LOG_GUEST_ERROR, "blt src width exceeds pitch\n");
+            return false;
+        }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
             ctx->src_bits >= vram_end - bypp || (uint64_t)(ctx->src_bits -
-- 
2.53.0


