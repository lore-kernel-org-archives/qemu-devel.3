Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F87BEF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR8-0003wn-47; Wed, 04 Mar 2026 11:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR4-0003td-BS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR2-0002SB-Pa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:58 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6610bd5f322so1127564a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643055; x=1773247855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVqtGVIEK9vja40Xgli2/kgvV58XTVhVk4cWJgJ+jnE=;
 b=poWnQjkrisD6UEb/MpEdwx6pJoXyEngXursLg21i/epan3J9/kQMY1oXmDlIbiOVuY
 Cmg6h9kFtrMmd8EEUxgK/AA6oPbCt27lUZXc1VNJ72GVTpbAPmcN1ewzdEPypMv1qm4y
 497STNdZUAVG8tmYqD3qIvFM3xEIJLqJqLNtd1tiw0lsqVP7CRN5FBN5snRP0Tgj8VPP
 Ftj6d2myjU4gzxZ6KJccvkoWsKov66R9KDQBVmniYIK8O4Q292Eq+JuIYk462Ca4vwap
 +AIIKySH+mP+axwjigU3mDw+y3+SOSxGa4HOCGwaPzUFD/Cm/KEt7CzFxpSJ+5henrVJ
 wycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643055; x=1773247855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVqtGVIEK9vja40Xgli2/kgvV58XTVhVk4cWJgJ+jnE=;
 b=jIxd57TxoCz98xy5/ocjE6u2jMznD45H91n4xdWQUHcQEuMvoFXohqxZI9b9KYRJlY
 /0BzIFnXX3OXEpXV5xCyqUZByyHGiA2E5qNZhLlQfpSACCLurQKP2LcM1mvfioOsmgp1
 4FUH81OcjVaVbAiyWS3fNGM512a/CXCGrN3y7DWFxiM1zEO+otVCMg3Zx8VpqnB4e+Fc
 B/YgXtnk1vczq2Fwffgu+zqZzPH68fcJaUGMFRQ0PyTJAcMYWbJYPm6RtJ+DTkJKUPTR
 NxK8kPKeWW7noMyru31aQz8BQa4IV+yqpoJapRUFh65bzmsxGWLPV3Zzl8aRGqfh/9T+
 s1Rw==
X-Gm-Message-State: AOJu0Yy2fE0samuAxU7/ismBG4ziAZtCN7Ez9eeomydkrBiWUY2/Bwgf
 307/YXWkCa7AYZ8OCT3i1AfDRtJqzJCLRmtM+Bc04ilkMuvA7h7xbh9xu9uCqykOjS77oopVgdp
 K+8G8
X-Gm-Gg: ATEYQzzFpwo1GD60viaVxV8aVXDXFIEak+O5PRfE9kfLZYQNaaSvcU1OFY0jR1x2GY/
 wcoREQ2tMajnIXquB/tUbp0FXtsV5+AH22z+JClqxBjpXqc0SxHobjNurAFgfkD3WIr5F6uwjGH
 ynArH9wDlpUxETvI8qDdhaZ8f/f/9aNl/2bkPN8GnoeAJltyQJ+7wYglfb3nZSVkG1IwLj8lbsF
 Dd17bZ27i8mja+j2daXdS5XkT+ac4ivJXbLgLVfTukOVcPbAQ+2ZjBxMpPaFLk0+SXeyBOYObse
 lL1c3K7k8oEYQ6DPr1k64rHosidLK/u4WAxOJHeIRv+JGXOB+2w43KQaUkzdEQtB0z4C7+X6r/c
 KOW83dPMKqiduUGnwBqPvaR7AMK4AnT09ZCsjsDFTwTDsZTCv9pv/8Wpv5YJhYe4z1yyeZFRitH
 bvTooSd1x2k1mVI6n/Oc09gEU=
X-Received: by 2002:a17:906:6a1a:b0:b8f:bb98:b8f6 with SMTP id
 a640c23a62f3a-b93f11c5ad3mr167593166b.19.1772643054950; 
 Wed, 04 Mar 2026 08:50:54 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b93973d3ec4sm558572266b.66.2026.03.04.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E94062D9A;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/20] virtio-gpu: Remove superfluous
 memory_region_set_enabled()
Date: Wed,  4 Mar 2026 16:50:38 +0000
Message-ID: <20260304165043.1437519-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
---
 hw/display/virtio-gpu-virgl.c | 2 --
 1 file changed, 2 deletions(-)

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


