Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEAEC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyaw-0000vY-WA; Tue, 10 Jun 2025 09:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYE-0007S4-9E
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYB-0002gk-OW
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so4649584f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560278; x=1750165078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flrTTu+SitP359j+Z3lRJJJYIo5FewvRFSPrNcv9gRQ=;
 b=lrn572OTRP8vwh8B+EPFn2e/kZ+hTTmbCaTD1wIsu8B/GUKxwG/TZpaVfp9qpFYnza
 xFDmYcEufJqNFD36/qB5N+Ly6BRItZCaCBFr1kGgYagooBJubKWMG353JMPHVPtuNMNF
 nSDwFC9rKzpLQDicnNVNG6i5/E3QFjzIiTidxWLXIkzP8SRbRAzhDbFKNZLtrzhYXgTP
 CpvlmwWJDy2kDeFf7PwQTqxz+Md3iAuTBKgLKebaxiOap7uSR1Oehu9Y5VggHWAqSz1a
 0a0UlSj95xg1iDljCwfv6di2E0TBiM7VU9gK6JR5S2DMcv8+YHAO0ozstp/oIfyBvwjN
 wfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560278; x=1750165078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flrTTu+SitP359j+Z3lRJJJYIo5FewvRFSPrNcv9gRQ=;
 b=k7vcwjQoWFq2muj4E8aS6IcBGIGLK4TeQCOjEduWGMBoeb/d6Ri+MIPbT3AYNR7Lfw
 xdgp8yUlNw1f2tMstC0T1umc5Lg+Ei/y9rD7wdhFjjpgdYyDbcp42LU/ViRCrAvlCGjx
 0P7KA2hOZaZedLPokQ4TxLjTOH6CHbyG3BbtwcPgYd9zAZRkaxV78fM3Y91p6HJ9M8i0
 XgEeVGLMHjmyCB/JAJtTBR9wsE3VcFfeyufLLeDCgey86tnHNQpEYEd8VLcV/TlKU7bJ
 KTXMYVLHcXy5igMYhIDVL9WL4xYrr9a3mCrZCaTQLH+pFsoQ+3uehk3+2iuplI366fUU
 ZFZQ==
X-Gm-Message-State: AOJu0YyjFU0imWM6XjwCKqiIi+80Lty6kGbrb6SRl+ToxIeHFDhgseoU
 fe4nMKuzgryCvezlJnunyg6T+g0ho9RA+Tixz7d/Ez6sD4hARnCH+IHDKiC7oAAaH4KWzWnurfq
 1nobPR8U=
X-Gm-Gg: ASbGncuS6myHl+rE/aPSDE+obYNZ5YlQp5PXVBPe+2vZgPtqC687SIjl6oqeGcB21AQ
 QZwa6GQtlcsV2+USlvn+RqOCv6N2iQAJMhdQz8cUjP9zDCm2CiHBW/7ZGEHc2fa/CCtzE07RlWq
 rPZQJ3ynt1WjMDZbQiVCt2y5cFTVXwod0U70ThHKFPPKoePgmrwJx+T4tMFdKA9cJcIGYs8Manb
 2Q7F2vm4wzRlyrlXt+2Tpjog30pVqNUgjVNZq3C7AadtB2wf4NipU8of2KgFQofOe2Mrjigraww
 K28+EvuJ5tLHktJsGONKT+7rrrripvyRGcU1KLO91fFL6LvFLd+z6LQ4AuTC/CxcqMYGySRgVp4
 HynbWGI7TUP3285Nom1ZtVltadQ8Hn7uh2rXMqu3M/A==
X-Google-Smtp-Source: AGHT+IGi8gwfALciyZUsHpEdGffKQx2rylHtUQ+HmNxKCgqi8DFfopjgUCG1kwN/RTXZzzN7qQughA==
X-Received: by 2002:a5d:4b47:0:b0:3a5:34db:4cfd with SMTP id
 ffacd0b85a97d-3a534db4d97mr10239966f8f.7.1749560277723; 
 Tue, 10 Jun 2025 05:57:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fceasm12039698f8f.82.2025.06.10.05.57.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/24] hw/virtio/virtio-mem: Fix definition of VirtIOMEMClass
Date: Tue, 10 Jun 2025 14:56:27 +0200
Message-ID: <20250610125633.24411-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Parent of VirtIOMEMClass is VirtioDeviceClass rather than VirtIODevice.
This isn't catastrophic only because sizeof(VirtIODevice) >
sizeof(VirtioDeviceClass).

Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250606092406.229833-2-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index bc4f787772a..e0ab31b45a4 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
 
 struct VirtIOMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent_class;
 
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
-- 
2.49.0


