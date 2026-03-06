Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211BFFCC066
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDc-0006rJ-HU; Fri, 06 Mar 2026 14:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCV-0004ED-Cn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCQ-0000SQ-NJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso98452965e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826661; x=1773431461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqfMeh7SO7T4uFotbbczP7UgIC82Ne3itRNZDNM569A=;
 b=oxd9ciXL24i3vwDP2H8YivJ+19ZPFEaN12pVLzyOOwMcCtfKuDOrnMFmCUUOkUZDw3
 9Qe1DofnLBNsQBk/jw6kaVl5e14rOvN8XjT81C+35eV8EVEIOfmJ1CeNyBfELH9nzA5j
 P9eNdLbwlmSZddjQ4XisS7De9aAyfb21Vsz5NMW5ZPEWQWPuhqWl/0Z2Wu59alc+03y4
 2W8HnzQF0KT7syoNeFwVKFi+94ki6sLNkqjDvXnQjIoDiuc760MxkTjrdMFjI/1xYGS9
 V1uGy9Zl6vYQ2EncyKwuaWxAt3hMSbR1eCefwOm41HiMuuewC107fVQbAUxoCic1i4UD
 uyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826661; x=1773431461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lqfMeh7SO7T4uFotbbczP7UgIC82Ne3itRNZDNM569A=;
 b=EtWBstuBgOWrNa48egJwlc97TJaWRQ7+zROk2ZwbeIycdl29mAsO234SrVebrxsuND
 XJ5slOS0s6CwHYJ2CYg9VSyDAlg8ItaNKzdCgKTs0Qz39/5+7BhlOIQuRhYr2RyjO1xm
 8ICzJYp8nQV59QHjI2YwGlB6vvbaG59U+Fs+bc9UQgU5ZfXEMzIHCb+hOvv2pjcz/RKN
 sgOms11yo5giu5xr4Blz8OeNWJlAgvhnm879gUf8srfdEvMcMeXEduE8F/bqJx9LrfPw
 MLKMOrHpWjMmuLGQvGxPhbTaYChB/QsCr4sAygYygBJnLKn3uu0Kr+jNo7cCR7spoLeG
 2Xag==
X-Gm-Message-State: AOJu0YwEAMQV96zExB6Dh/kA0S0eZFm442IFwjMzE1R5ysLvJRt8urKn
 kTljZFdGJz1FI9fru++kSrXL3P/krJL7ANsRkuJb1nJZfQ9wMKZbwKaqB9Kg2ILG758=
X-Gm-Gg: ATEYQzwPamPHEx+mSq9oSb+h6S861rIIrc4Z4xiv4jMpRNN4s5bKhC7munZmEP6mkhu
 j2FG7Z96vmY4i8lLtfhrUV5ZybxuBcNdmn5j0K//a6OMtdcfZvE2SCEwbCfbfAvZ0SlSLw08ruY
 7AIomHV7VEQdqefVi2xucluSStG+ZUtO4LMjnRJkiAAdUjJPsarTcZYuW+B7BIeu//zTDwa3KiU
 N4TW5aT7SSnqxz5bVUsZeuvirhoMs7j208/JKsXF066mVb7M59ik4Kt1F/yKFxzgqHpIuZdB0aW
 g1LAs8AebX3AsyNY7U7DmOhWG13PtQHMZSpwAxC6Ci0E8ZT0BcqYHaDVPZ2Z8YqyvRn264i2pW5
 aE685ygGa/ZcgfUYkM4Snp5bHxhrJU10KvcAoUXKAxPrNVH0dDgBbv2JIIcllpO35shMd4nNkNp
 iFdSFZj/ehmelSzhXpI7kcSbw=
X-Received: by 2002:a05:600c:64c7:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4852671d9c3mr52513325e9.8.1772826661215; 
 Fri, 06 Mar 2026 11:51:01 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485244b6e9esm43632815e9.5.2026.03.06.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B23C689DF;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 16/20] virtio-gpu: Remove superfluous
 memory_region_set_enabled()
Date: Fri,  6 Mar 2026 19:50:43 +0000
Message-ID: <20260306195048.2869788-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

There is no need to explicitly enable/disable memory region when it's
added or deleted respectively. Remove superfluous set_enabled() calls
for consistency.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-15-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-17-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f5fe1bf4e73..abf7c176a65 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -171,7 +171,6 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
-    memory_region_set_enabled(mr, true);
 
     res->mr = mr;
 
@@ -225,7 +224,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         b->renderer_blocked++;
 
         /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(vmr));
     }
-- 
2.47.3


