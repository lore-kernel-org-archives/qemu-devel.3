Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C05BCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs4H-0002JO-TO; Tue, 11 Nov 2025 12:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzw-0005js-Li
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:40 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzp-0003wx-IT
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:40 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640e9f5951aso1749262a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881451; x=1763486251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Za+5Mks5dDo7+VKCqxjl33d6oX+mjFDqlwwucW0qEdw=;
 b=ZHIQFa0Z7ZkxAu2cvisWOzanuLPLo3kuObEDjokoouLRFrBOSMLgUguxR9DLvtcssd
 gpEbopaYuVVo49X1wkPUkJF2Et+mxF9UFR1q9LmJLqbyCm340XiMM5HPBS+kwpdnMT4d
 AxRiGQhxN9IjAJ3Ve+6vw0ayDKjWwg3BxFpVVvDoCtYpmHsj/sW3qn3v0E9wMoNLwUAU
 /g2zsVx0SV+zwnPPeRIVfB/AKzkETN2YaKfgqaxg3DWxh4YIswVZ6XPFOzH3FAdEzH7O
 PLkb6xO+57svmafJ2L0T8Y0sIhksi5p0WktlXVZMUxfgJwWh2mVh8v7uq0+890ucahJ9
 QrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881451; x=1763486251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Za+5Mks5dDo7+VKCqxjl33d6oX+mjFDqlwwucW0qEdw=;
 b=tMHkWxcswUXa4OWsH8iu0vbWtqErKr6qOxGm/vD6jTwOSK4137QVRIFgO+EsIv8nOM
 pYdetg0iDgEvcE2xCOxfUV9bPZJs5dk3HuUt3mUrfT4xm+3CaZa1F5vG8W2GM6tdym2m
 MZ8cnDmjhih0zmbG9x33IYh3mdAlNgvajnn3SxgtAN78pOHm2VxEEWiv/bP8CKh8JPP0
 b2Z3Jj7onMqPTvF+2vrlkw1Q6rklvjNP9IDs7YTbiQc5TnNfYBptc18hZAaoiRpyjefD
 TKqD2fsX99jiM/kYoWnp3CxUVO3JbWyHh6Lf6AS+wxgzVERwtFZLDX7yMy6sTy6syLh0
 KRNQ==
X-Gm-Message-State: AOJu0YxDTP63U1fkILF+HmAsecYUNwvMeH++q5fuXPwlCrLIoMGH9w4F
 MYcs+V7lCWfdmJHGqTXYpYWLdeB8VDSOhLcVJLxOgn/sqPahAQiy9aPHDv0vy5YAnwE=
X-Gm-Gg: ASbGnctLNcn3A7zfJaJl8JxhFAYSHD3UirnyKXlmcoMe6Zfbko+U94tNUrJniuo1WSy
 YJTW188arqe0kNZCe3AaCk0ZlAYc4CzzMQ6nO5bEa+CP+zSdOtjJxs8pZ77H/+NTcYaKk/T4Xd/
 Xt78GulMDclspxQ0sTwf98/BGN0to3krcFtS3SrnCsccNkb2mOrtrwQIHvSjdw60elaIBPAOmfr
 bz+UmEOCNM9nxDFCTclu/NRMEv7cxGtxBGmCZ8c5Bq6ieeiZ9aDecmyCsVxKz/5UGI1j5qfigpj
 fQyzXZ037Z8u+pZFbiauDOHu/owmIA/LjtTGgMz9L1XZUwcy+qKDD19thmJSa4zivdXMGOb3ctv
 LMH4ZaTFkFknfP3IHmSZKEgxI1vJJr9haLDFFxfL/5mpQwwoPMWEnqNP6a9IJNypYoAzCbUF/lA
 Sz
X-Google-Smtp-Source: AGHT+IEzV2oPWceBEQZfRjUMRF3Z1okUInmrwb60js1ltUEB6Txr+6XY2GMiVSLduNqZ35nAheRp/w==
X-Received: by 2002:a17:906:6a1d:b0:afa:1d2c:bbd1 with SMTP id
 a640c23a62f3a-b733143e47dmr5499966b.30.1762881451559; 
 Tue, 11 Nov 2025 09:17:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa2510esm1371639666b.72.2025.11.11.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB09C60DA8;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 12/16] tests: move test_virt_gpu to share.linaro.org
Date: Tue, 11 Nov 2025 17:17:19 +0000
Message-ID: <20251111171724.78201-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/aarch64/test_virt_gpu.py | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
index 4e50887c3e9..89bd596b548 100755
--- a/tests/functional/aarch64/test_virt_gpu.py
+++ b/tests/functional/aarch64/test_virt_gpu.py
@@ -22,17 +22,11 @@
 
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
-    ASSET_VIRT_GPU_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'Image.6.12.16.aarch64',
-        '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
-
-    ASSET_VIRT_GPU_ROOTFS = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'rootfs.aarch64.ext2.zstd',
-        'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')
+    ASSET_VIRT_GPU_KERNEL = Asset('https://share.linaro.org/downloadFile?id=lL8wgnMmSXZo7Co',
+                                  '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=qOn1wbfKmS6KVHZ',
+                                  'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')
 
     def _launch_virt_gpu(self, gpu_device):
 
-- 
2.47.3


