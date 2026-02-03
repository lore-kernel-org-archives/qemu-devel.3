Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F71E8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSO-0006hQ-IG; Tue, 03 Feb 2026 15:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSI-0006eg-M4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSF-0003WC-EI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so40518105ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152218; x=1770757018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj+J65/hVHAdLn3TpalL7Huy1Q4mzDUSA7K1x00Tkbg=;
 b=tnx7QLUijy+16wbplGQolC1t/TVCsJT06fJzamPlecbA5qVx0F2ZXyvUv2VlDObzFS
 /gWORZ4z8dR/bWu2f364Omye9meAQtgtaijKc7Gk7k49iDIXxEdCQ0vVJKuFo6yxGw2k
 t7UIjlZgZ5Mg8Wx4ruvqNNU/tVSX9zstxwdzfJNPBPazJJiumbQHgXbOT0HXjSREj9UD
 hlvgvmXpaQb8kLMSxFBcyYqGXImGwZ6+CvmCfCx8uXgOtcDihK9WEp2BOK3pmkjZLXCf
 dHbqbo5k35sPSrafvYunWDQ2gAnu3vCCerewK5HaCod3kRr2K9XN6g92zQxNgkK6gvFQ
 6jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152218; x=1770757018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vj+J65/hVHAdLn3TpalL7Huy1Q4mzDUSA7K1x00Tkbg=;
 b=VdtHF/UygQ+3QGGP6EBMIrWS18m7vfgJkOGZjt5pHKxYL1KJftTy+bwvqce+cHcLY3
 L6ugEst6qAFgaP4CPKWTFXaj9kBBI8lb9qnVCmqrmCd/Qb2n5AFS2fDkC0yJqcxR+HWK
 yEUaBo0QC4icCY0vsGJU/nZoT6vnqViBSQ3Ro/VKR4OGM5yGsOuRpe58wLc7A2xWgEKr
 9sSPr+Qq6tEASoEdZP7oRNGsDxrNR3WUwEt8KNtPGYlUpon09rYzAx5ukGKUiTSxYEjA
 pWiVZl9LU/HK4mFWiSTnXsxUYAEShcGRKjBEEd9c40Xm1+x3kWGn9KvEiY/XYMmRBjxl
 mavA==
X-Gm-Message-State: AOJu0Yzsn4rMIVMN6Mz2cg4XpgUk8PjDUmy3uXJCyoEFsjEqLOHjzO/4
 o8ITGJHlVR25+wBMCvn7w14Q32hk4LGDUUKOBjgtMDkvIQzuQwYPuczOVNWSRLDiPSfszsQp72S
 O7fBLuCc=
X-Gm-Gg: AZuq6aLckGm0S9FuMLEDr6rlzCrxySUcuHtA6JbWPXcPX4E1YhRqle44qDBBEn5U1tX
 xGZUKZepRXdaPjO+OwLLz4zpPP5rdhQAOBkPPOuhBUlS4tXlS0i3w8QE51fG5IlSXy6wPcWgx3B
 X//kaWm9dCDGsLnBw7UtS1SCbb2YsnmmePOWyk5IM23FFO/XeJHsTotvrMll0m2Ynt33Xb//YCF
 hSsGGUd7mvRqfPJBju4VW2wPuMTleCc3H6sMdEyojFwLSwvswT4habwnvb5nwDPNBSYDZjVYx0E
 cOn7opzgUNIaOI+s4e4gum9zqQsUsy52oUG4SoY4xn82Mp49FMDSIEUB5jOft99t30IiQ4jilUn
 WbQG34cjhjX3mAbqy4hvoc52QSPClY1OKE7glklcwjqzeCCctSo8UK+I115xMAz8UCaQzJFcg3+
 qbBIJAefTmG+MPFJ0eEAKLlgo6ysX6+tIbEpypj+enumUI/Poodsg2doLImAaLgvGd
X-Received: by 2002:a17:902:ea0e:b0:2a9:9c2:e900 with SMTP id
 d9443c01a7336-2a933fa556emr5403605ad.31.1770152217876; 
 Tue, 03 Feb 2026 12:56:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 9/9] hw/virtio/: make all compilation units common
Date: Tue,  3 Feb 2026 12:56:37 -0800
Message-ID: <20260203205637.3109749-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d913b94e1ca..4f308beb961 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
-specific_virtio_ss = ss.source_set()
-specific_virtio_ss.add(files('virtio.c'))
+system_virtio_ss.add(files('virtio.c'))
 system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
@@ -52,10 +51,10 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
@@ -97,5 +96,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.47.3


