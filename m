Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B2606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pYfNaAi3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnHD-0001VU-5J; Tue, 24 Nov 2026 04:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHB-0001Uu-3O
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnH9-0007sD-6O
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so27429965e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514242; x=1796119042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQwcLkfwr27wbEup5IjqmQpU2zAj5Y5cm7Pm4A7sGLk=;
 b=pYfNaAi3gnXaLbvFHakGxC0Nj5Xwc5yXgLgdjlUGFF0lb65gKVtmP2kvT+o9PfYE9Y
 wKKvD5vG9B1uIWUVqLrsWO3SJp8wWIzeCP8u5/GHUAYnB3UqngNgyh06Q7sFSm893tmz
 pRRFwYQPqy7NXxwD8FuEZksYBNM8cFXC+KhcXr/fyYZjHZqqYh2MHnnASpk6xv1zmJxy
 lXPKyvplg9qN31aYKCsMsvNzIO+pASmUgSGz89v5Z31e43tQpslnF1OB7hMlrO2Sl4Pi
 P00jpRVcgxpAiR92q8pow70nBwMVijlCYPhXjBUJ/JGASmheuFPkJct7XwSJEr2ZelzY
 ZYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514242; x=1796119042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQwcLkfwr27wbEup5IjqmQpU2zAj5Y5cm7Pm4A7sGLk=;
 b=y5oWaW8MGPW/Y5HzLT7kR9kC552634DConbJ1lPf4+GMu+HKehKLlYBLZ5cZeT2/Bm
 vb/HNgAXE/P1KQQ0jYxXDizfw83HMM9aJD9FxymHFj2aj5OlP6a1qYZk34C0BPHoSK+a
 v7oqyq2WA5RydoZ/UcAOapbZRTNTGMEETFVvtnq7pQ6fKplCmze1M/zv0NNEEC8vabrY
 HCYqnJkek1667iPUMHh6ySPmaI6/vE+g2/nPjJVwCTaEUAVaUyIY3hEMWwIkNwHw5C/9
 7YF2SwP/B19G/futuGkbbL1e3b09G5m1kQnsKuimnuINOoYB7Hjj2HmBs/teUEL5ue/M
 pvPw==
X-Gm-Message-State: APuU4Z8JwMiZ0ANnyj6/rvhfEe0Vrhq7JSt2sacaAu4JOmb2iWil5384
 FkC4Vc3uOkCwraNhXy4uqQFSP1M8bBlWMa4x37+65/aeLQzoZxPeOmmlXMgIxYSr70AllFE7xBu
 A9IXn
X-Gm-Gg: AZFdTZez0h5nakPBVgkV0FuPy4kN+enwALcOQggZrZBn8uV5e19MAFUGBsVs+kUjjmL
 iWgfu7KowTnF3CaubkYBYwqOQhqdCId4mSkTupM+2RikMg3phDRfCZ0cQdikVTerg30lIpVQHrE
 WLNv9T42C1Mq9PwnO+vuPIX2jjKhwMIuog+EHTOQm3avBVATT8OOAE0WS17tm8kxLK0/aLROplN
 XPqro00enMVmEd+QqygtxT6g/DZkTPzoir/NJSDfaq9+dhzVV/S3CEVVDOkCJp/Ip+Px34LTnTb
 6XbFT2KAOdoAU/Smb2TKYkK2wjqYzCZtKvaDr5KWQD+HaklTUtH3n5SRpvgVcXx+gHhHCPnDDEn
 eyiYM2ZirdQ9aUZTGUlmcSQidJU0XqeUl7rAm4NzhYz4b2rF2xEyzUXUwZCR9qb+fMXmbH+vf09
 t0WWy6cCja8fiUnn0VfmFLJNE/FFteTB8zK1kfAGpkRuj1V1EDmmLmbxIH8hx0G4084s7CEvoC6
 WYfoZwvwVXO5KoKejQcoBqNMfgeYoII4D+5sQtEaayRCRbN2y0ToK7lwtr1Qz+RgbVouODPP7RJ
 YLxP4TZjXZrjA7Cd2zbsKqi7JFPu0ENYaueREXxZ71HugD9tdMW6DupHrTUWWVxSkWLRH3l/1mS
 CYdAvrmDGS6WmjJ6pCJKbFZ3bguQcvtIGog==
X-Received: by 2002:a05:600c:848d:b0:4bb:694e:496c with SMTP id
 5b1f17b1804b1-4bb88810b39mr301958725e9.22.1795514241758; 
 Tue, 24 Nov 2026 01:57:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm783591885e9.4.2026.11.24.01.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH for-11.2 1/4] hw/display/vmware_vga: Zero-initialize scratch
 space
Date: Tue, 24 Nov 2026 09:57:16 +0000
Message-ID: <20261124095719.4126146-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124095719.4126146-1-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vmware_vga device has a set of scratch registers which the guest
can use for anything it likes; we implement these by backing them
with a lump of memory pointed to by s->scratch. However, we allocate
it with g_malloc(), which means they start out with uninitialized
contents. We should zero this memory so that we don't potentially
leak host memory contents to the guest, and so that the guest will
always see deterministic values.

Since s->scratch has type "uint32_t *" and s->scratch_size is its
size in 32-bit words, prefer g_new0() over g_malloc0() for this.

Cc: qemu-stable@nongnu.org
Fixes: d34cab9f49bc3 ("VMware SVGA II emulation, by Andrzej Zaborowski.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4519
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
4519 reports multiple things in one bug report; of the three,
this is the most interesting, so I put the Resolves tag here;
the others are addressed by other patches in this series.
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 567806f0e47..f7289687319 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1256,7 +1256,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                         MemoryRegion *address_space, MemoryRegion *io)
 {
     s->scratch_size = SVGA_SCRATCH_SIZE;
-    s->scratch = g_malloc(s->scratch_size * 4);
+    s->scratch = g_new0(uint32_t, s->scratch_size);
 
     s->vga.con = qemu_graphic_console_create(dev, 0, &vmsvga_ops, s);
 
-- 
2.43.0


