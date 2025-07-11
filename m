Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B9DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDue-0005XY-OU; Fri, 11 Jul 2025 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtq-0004Q9-WD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtp-00033P-7j
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-455b002833bso2469315e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240887; x=1752845687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x2nVtAA8fp2H3YDMXCDIIgapnlhWHhnckzqsHWXu494=;
 b=pWLbwfRQ/y01dFJe79oyuMaoLAfy5X6aWeE7fxVOScbrTEDSgzCOSYlaSd1hmmQ/N3
 1/PnDCj+So71U6Y999vFPafiUtTdVuCGCIkG3mJ76aG/24oik+nxYGGieTzYSg9ZbqfK
 KF4cD1Dz4VpFXoclFTmp06GtYQl5ohrzuUwg4VzO6/+GqpJW/KxucaxFRFSSfLVCTkL2
 9zwJpBXcLk60B9bM0iLNQtaDU44w6kV/KlUBHZwb+WW8bKSwtigblStvjlSz/VOATanO
 CSsuGrXxLkIu+UEiBaNxrKTE3UMbytLrf92mMvzpL40YSD9AD15k8+rae8Dv1yNDyoJw
 7Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240887; x=1752845687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2nVtAA8fp2H3YDMXCDIIgapnlhWHhnckzqsHWXu494=;
 b=W10M1vu8gnHIG+zsM72XyQgE55OBnREBqp7uLASEsIaYxKy+n+Qy/91j7+3q08QzU4
 d/U6rb/c/HxCucxv5iLiXQMumDLHojTPjNlFeUQScqKodfXxyPHLo9G9XI4DKZVVlNR4
 Hhl8uMyDFrJ+aRVCqzognKfGZ1XNjIeno1tPNhq3JCc9+Ejo+zH6uv8reKIPcHM7l5x7
 +Cvsm7LB2SUle+SFlFl9LXC2x88TMbY+Fcue1u4VDaz7NSP4VoS1pmIEtMU/Eh93xHqA
 EvsknTwjQpMZ8VlWkKhU/ay39reC+GfNyvd0+7rXBNaY9wt8PaU7ORJpIc+Bfozj8XLV
 5IbA==
X-Gm-Message-State: AOJu0YxU/pOe/3mS0/V2lHHvPVjGG+WTJd3lxl8VDkSTA8/VpPW5CW1+
 PFz561yJBoyJUgFig4lBoxMwKDpvWyb1/C//bkAkjkHIRqH09OlPZp/4isQgUE8ieAE/srcI3+V
 oPPFR
X-Gm-Gg: ASbGncsQIBjs8JG88d+awFsCo7btN0bohkEy+y0VB3F+2zkWvR/aUx4L7OsJyJ7x4Dg
 2SIfOU/b1CnGjKM/1nbTbOFxmxlf4/Ul71GZcdIfvxQaZvLirMVnJNm+VZrt+Nf84P372Yc0p6N
 nPC5XLNOeHubXhBxsp1B7Tj8lE5+EhCh/9dk/SPSg6QwWVC9qm35J0lrFZQm4Id0H4vZgoY7G1W
 Fl5vvdmunDfScpSjP/rngwboDrgjjSV/K0t8NUL+XC96gdw4w5ZBOKfRxjGa7/+TVw+gnCIfSiF
 K30dWJCQWr1O7VM+zOgK0gChfqp7YI2w/W+DFNGmwLclnkDkaX7bZct7YfkJtCU/HdiwzWovWhm
 Gfgr+LHdjIroJVBIlZU6j/n6JIU/IRrZ/8C+nG4Y=
X-Google-Smtp-Source: AGHT+IGuX1eqhcqjGz7erYss60WbhYzGWHm1RjdLt+okYvnQaX4ePvQ8lngC296bBmwAZAAhrUMcHA==
X-Received: by 2002:a05:600c:1c95:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-454ec133982mr33708365e9.7.1752240887513; 
 Fri, 11 Jul 2025 06:34:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] docs/cxl: Add an arm/virt example.
Date: Fri, 11 Jul 2025 14:34:08 +0100
Message-ID: <20250711133429.1423030-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Only add one very simple example as all the i386/pc examples will work
for arm/virt with a change to appropriate executable and appropriate
standard launch line for arm/virt. Note that max cpu is used to
ensure we have plenty of physical address space.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Message-id: 20250703104110.992379-5-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/devices/cxl.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index e307caf3f88..ca15a0da1c1 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -384,6 +384,17 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+A simple arm/virt example featuring a single direct connected CXL Type 3
+Volatile Memory device::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
 Deprecations
 ------------
 
-- 
2.43.0


