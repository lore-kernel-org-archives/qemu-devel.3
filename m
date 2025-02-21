Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B2C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3I-0004Pu-BU; Fri, 21 Feb 2025 07:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3C-0004PD-UL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3B-0006yt-89
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aOcHI/6ihrxObB+6D978/KQRlCQdnjX6vRn12oDIrAY=;
 b=PJlSV4gHVvRzP59pUiPVR8/8RSV+XZFFWyJGAIi1KZBFL6lxYF61H21aYhlzQLiaI64cTh
 t2C4tOUz3NPTB2EV0n21M81Sy/3xV/n55wRieEp2JHLb//xBDf6j57EayNH/TciQSmQTo8
 tRLRA4/bnVM/0CdwgFAfwgOGuflhVHA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qhjWwqXeO020XroAKl4-PQ-1; Fri, 21 Feb 2025 07:22:32 -0500
X-MC-Unique: qhjWwqXeO020XroAKl4-PQ-1
X-Mimecast-MFC-AGG-ID: qhjWwqXeO020XroAKl4-PQ_1740140551
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f255d44acso931277f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140551; x=1740745351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOcHI/6ihrxObB+6D978/KQRlCQdnjX6vRn12oDIrAY=;
 b=wz9YneiDeLFZ3wvxITB6F5nhAlTbrAqFYlomWTaVpDC2Jvh+Ourlaa7m/yYzVlFMzl
 Acu3xVOSpqZ+CHcItBabg5tUAcZL7RH8P5kzyUpoq/OteuZnkvlUyqxocJSKNl1GfsRE
 OUSkHZI1bFFixH5XNS1yRyG5S+JGRGF58VumzD1z7BjrgQp32WVGBz7BYmDWhSvMifRV
 j8R6Djrg8znTO7Q9dV2RE9/AmEhP1YvUgYrFbypZ0eNkXM3y0WC3+RttoltszCKyr+Ti
 cxe2C+NQj2I3CfhIeUbb4qV1JB4zLp26/0fTC3PY7Bzv3TnKL4TnGK6ItEZA8gESmXkc
 hJhg==
X-Gm-Message-State: AOJu0YxU9DdHzOG6AjcFwTnF2haMbA1r42baVRFcBpugLsXrbKguHA5g
 BF+TQ7Lq/gYswzd8EOWichQ3dW5DPsX2of8umacYVb9G87gaxahmAdrVCcFud3HQOS4AWpZgXuO
 AFr2o1S4Ns/mGljOh2oDJpuh1hgBns6IX1j/DEjHcQHLCX6FtUCh0eKh5Ix1lIskUXYDSQdS/W5
 9wvqA++Wm8IW2xsAqZo/uYUalCslEBfQ==
X-Gm-Gg: ASbGnctcGx82wMQByzeeP1dZoM6jRwsZNZHdOQY0U8ShwVl4YnqcsWFLTFt/FCEYVPd
 oILpBXMWOTxFS8akVMs4+LouKkQwZqOvgo6mkUg3jFE4zzolegwzKP4j21gAY8oE+dooaAd9O1B
 /BVZDvRRSTRlGq2MvU1H0um1OgohPhJNj64N36akLm+88cktukdF+ZVzugMgOvRFUypU+PiZT0r
 7sqzM9DI7bs8a4ptbU8M3WIu8kG09Vg5uGHHr7oKQQLTh28egR/rVBUhqTT/WJddl/pyZh1+IuN
 JFPSLA==
X-Received: by 2002:a05:6000:4025:b0:38b:d7c3:3768 with SMTP id
 ffacd0b85a97d-38f6e946edbmr2026434f8f.12.1740140551153; 
 Fri, 21 Feb 2025 04:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErmAESHos3VULoU2lru6dRQ25ywZWT3YY+u+cL68nfcp0ji68vis2RnXs9dmxkipZJXCg5cQ==
X-Received: by 2002:a05:6000:4025:b0:38b:d7c3:3768 with SMTP id
 ffacd0b85a97d-38f6e946edbmr2026414f8f.12.1740140550708; 
 Fri, 21 Feb 2025 04:22:30 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371c67sm15582315e9.34.2025.02.21.04.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:30 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 devel@lists.libvirt.org
Subject: [PULL 01/41] docs/about: Change notes on x86 machine type
 deprecation into a general one
Message-ID: <6f9a1a01433738811c9795dcf29f299c60835558.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We now have a general note about versioned machine types getting
deprecated and removed at the beginning of the deprecated.rst file,
so we should also have a general note about this in removed-features.rst
(which will also apply to versioned non-x86 machine types) instead of
listing individual old machine types in the document.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250116064644.65670-1-thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/about/deprecated.rst       |  7 -------
 docs/about/removed-features.rst | 11 +++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7b42d6eecc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These old machine types are quite neglected nowadays and thus might have
-various pitfalls with regards to live migration. Use a newer machine type
-instead.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e..156c0c253c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
 System emulator machines
 ------------------------
 
+Note: Versioned machine types that have been introduced in a QEMU version
+that has initially been released more than 6 years before are considered
+obsolete and will be removed without further notice in this document.
+Please use newer machine types instead.
+
 ``s390-virtio`` (removed in 2.6)
 ''''''''''''''''''''''''''''''''
 
@@ -1006,12 +1011,6 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These machine types were very old and likely could not be used for live
-migration from old QEMU versions anymore. Use a newer machine type instead.
-
 Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
MST


