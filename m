Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C9606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YUWXr84P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbs-0001y7-3B; Tue, 03 Nov 2026 09:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbk-0001vw-Js
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbf-0005BH-RL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so38330565e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716522; x=1794321322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FgROo/vlM9c4RYnciV7KohHLhoWcV6ohztF8lPwXQck=;
 b=YUWXr84PJ2jhAH785BPMy/mNi4RlmnAYt+pcc8yBZeEDrjDuV5i/yihXN/4supxiAJ
 VXtQm6tJGkBEHzRP6jUKWtOJyDcDFGGBrFCzz2gi5qB5T1TZocXoGfTislog3gY/hvBN
 lVceZNa6vBiqaL126IBvLxYLZUFYbQNCdDfbIy3IIqqCuG0aQ7YbHq/Bx4Liz4OOmfUT
 kT0h7VvUs7IrUYhZlJzb0z7fHdLMihexgUMskws1PjaLAiGEi24k/SUULXTp4+TSYIXr
 a3wEEJ+u4UGGfcYLN3VrL/RKcSNDpcgiXyS6YEV3WGvMOsrRXjSZR0SV2P/jekzitCOz
 jLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716522; x=1794321322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FgROo/vlM9c4RYnciV7KohHLhoWcV6ohztF8lPwXQck=;
 b=yV+rCeCV+gLoyX3p1XzKpkqMoccaoeSC69DFhoXJvqGZZd6uzgwTJoGAl/neBUbBST
 RerveEBVTQiOIyFzHiKaASze7SRxGK+wGoRHfEVYax92lpj8CpJ9k+gyqjKPCPaZnCu1
 wNvJirwHnePvVKEFC6t42fkkPfteil6m3xIoBz8tOZ33u0nirWrekz1X0p+Fu6kO76VQ
 WtHMxAgWPE5yENwEd/QdYXHj0jdvp0hRyoNxUHplT40eHHmY16RmvsE4uKcNxWcVJQM4
 Omw1ibZzR0S9wVPzp29Bcep4+DdDHlKymLjfE1SSxvoFOcPKbqcZGUrKU1lrkNF4jzC7
 CIiQ==
X-Gm-Message-State: APuU4Z/s282FONYKwNkomDaHV8apv7QUNCWWOYM49CJfpAj+FLb4qBwS
 so42hAgwG8V71msa5wEMA2+FVEpFrhsoH950UkCzZE1Un3OY6Cq3cyHf+Z68Zjf75m24EJo01uR
 uOZTBuEk=
X-Gm-Gg: AYBFou38DHsTUyACG3ZPbXV/XkEhbK0QB9vOdKwWxUXc2CJ/TItjxjWlkROWFxHGzoo
 4z1vLQafgkKTFLERt3enmEarduO1nkoFsHyYkUftvdyJHR3qFxrNDcG+4NojPmip5F47sLiGB/6
 9ge6x/CDYxWwdLkg8Le6kXCl6jBzSY3QMZutyCjnsuX7WCxZI2Gye9mk0RoyYJFx11TYHcxUF0N
 CLL+oJaT9gHjsQvX5IGKREVEdB6dHiGTbuKARYAaYh+JUFxwZQCXNWplY8q+93dXOruicVs1xcv
 yAOIPswTchG5zmApRrdk+eVJuSprznRWUuC2pxzfJB+2MzzhdKD9sJhvpQHJ/AUA8l3zMdeeFui
 fYR+sf7APfSL8q8z9WlRIUYxDEtTjQo5fV8bl4rIZANWoC8bqxYL/D581O8RVFr6bICZPFLwue9
 kXVFBldYvy9Jmnd4i8fogpmGXLIDyN1o//ihUFouOCov3WxgB++xcNrsmwfLvCaSPc8FBPuOBm+
 WOlot8Zg0kZRxVNRrZw0CrT09XJGr8SjmWyqBfFJCnUTOtWhQEU+jv4111tLMGVnlAVNC+O+wkD
 OgzV2k8HEWTJO+iJMaGGKEyTlodqQpTpOYAn422Rfry0JkMt1UfzSIxVgz+YnW/XLe7sVcy/buY
 q0Blbn1u5sLt+sNF4j+/gsn/vVQhH+ibeVQ==
X-Received: by 2002:a05:600c:a4c:b0:4a2:967:dfb8 with SMTP id
 5b1f17b1804b1-4ac1765d7d7mr306178835e9.20.1793716522318; 
 Tue, 03 Nov 2026 06:35:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 3/5] block/vmdk: Use larger types for byte counts in
 vmdk_read_extent()
Date: Tue,  3 Nov 2026 14:35:14 +0000
Message-ID: <20261103143516.2182626-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In vmdk_read_extent() we use 'int' for cluster_bytes and buf_bytes.
However, cluster_bytes is extent->cluster_sectors * 512 and buf_bytes
is cluster_bytes * 2.  The maximum value for extent->cluster_sectors
(enforced in vmdk_add_extent()) is 0x20_0000, and so the worst case
for buf_bytes is 0x8000_0000, which overflows a signed int.

Make the variable types here int64_t, which matches the type used by
bdrv_co_pread()'s bytes argument and by extent->cluster_sectors.

The worst case thing that a malicious VMDK image could do is cause us
to try to g_malloc() 0xffffffff80000000, which will cause QEMU to
abort(), so this is a self-denial-of-service only, and so a hardening
bug rather than a security issue.

Cc: qemu-stable@nongnu.org
Fixes: 2b2c8c5dec6ba ("VMDK: read/write compressed extent")
Reported-by: boy juju <agx1657748706@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3843
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 6e4e0423dc9..bd18d32085f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1940,7 +1940,7 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
                  int64_t offset_in_cluster, QEMUIOVector *qiov, int bytes)
 {
     int ret;
-    int cluster_bytes, buf_bytes;
+    int64_t cluster_bytes, buf_bytes;
     uint8_t *cluster_buf, *compressed_data;
     uint8_t *uncomp_buf;
     uint32_t data_len;
-- 
2.43.0


