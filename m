Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B5D64064
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Rrd-0008WE-QF; Fri, 08 Nov 2024 11:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrJ-0008U0-5k
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrG-0003qc-A3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso21274245e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731083351; x=1731688151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j7j975pXlGw+vVjq9yeZZzQunJjncVGsi/tk3WFhJXY=;
 b=IdKhdxdgtjSQtPMLve5FJI4Wc8ai1B/GbGz2XR6xg1lGOFcbxlv5uja3gYn43t1Rj4
 kb+H9alZrmcDwuG0qeqPE1LJsbhiJg1Ml5Azp9uSNDNxS1sdplpGkSegNUiqFZRUvu8c
 CK3Jm6ZrAWxAA44cN2BBsiyCyVXk8iy1MJo49o2qIQwTh5heXfxdkx3NLS09HehmzOZ5
 zxAxxKZDzZC3g513jk61E77/fh5uLpl1qBZjhgMZsvCu2mDBXT/XsXCtSttba76z/a8z
 OIKdXJaYwuUI14dNhuxLIRtjRjGuP9YXh1NylVcl4PkP/SVLAPGzoeQaOsDOLcvu7nK/
 EnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731083351; x=1731688151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j7j975pXlGw+vVjq9yeZZzQunJjncVGsi/tk3WFhJXY=;
 b=I6aMqpy+hjIX5tZyNrsWGWGcz/pHFVSQXnRFwBKZmf+KuInfGZ/sfZqmm2+y2nDctn
 kDI/AETC51rlXYjRG5spP/sevKucG6az5nsXCrYDf1dqRgCRZl0AbBFgkauWWq1SRrYO
 9R3bBrHxj5mlsexePwGjkYBWPybOsoxeu7/lnrDl7qLp27mKuzPEwtDBDmsLBoD9goJH
 ZwPHRonrtsjpmpEw/jNsTHGofmkGu3t7bIXmHJ/Kbz5hdjCshKh5POWRP3/yq7If+lTg
 IitfudcCCyPZHR6PfVHX0H+XXKul6jN645KI2r5nYQ9DKoUFzuyj62OZ1P1qyA6GXSL+
 9OeQ==
X-Gm-Message-State: AOJu0YyD3GuFXlGPQZ5TFh3vQ7lwtL61kA1pN0AVV51i0vm1smC7qStI
 QRSz0eNuZ2VT70wirHSMk8T1JndaGLksWMAUk8p33hBIyeCW3BadbYKiIJdFY73k+OTphdDRR7j
 p
X-Google-Smtp-Source: AGHT+IECIkpkm9BQAjVzp9e4ecQQR8FiQVyMAYRz1QJq48r/kwL1SNTb8O95OtI2H+M2cc/tJFEXIA==
X-Received: by 2002:a05:6000:1ac9:b0:37d:461d:b1ea with SMTP id
 ffacd0b85a97d-381f1885defmr3087250f8f.48.1731083351073; 
 Fri, 08 Nov 2024 08:29:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0530599sm78109135e9.1.2024.11.08.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:29:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 0/3] trace: Minor cleanups to trace header includes
Date: Fri,  8 Nov 2024 16:29:06 +0000
Message-Id: <20241108162909.4080314-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series does some minor cleanups which deal with cases where some
C file is including a "trace/trace-<subdir>.h" file directly. Our
documentation in docs/devel/tracing.rst says that that should
generally not be done; instead there is a trace.h file which indirects
to the generated trace-<subdir>.h header.  The only exception is that
source files in the root directory include trace/trace-root.h.

The three exceptions fixed here are:
 * system/dma-helpers.c defined its trace events in the
   root trace-events file, not the system/trace-events file
 * we forgot to create the indirection trace.h for target/arm/hvf
 * a couple of source files in trace/ include trace-root.h when
   they don't use anything defined in it

thanks
-- PMM

Peter Maydell (3):
  system/dma-helpers.c: Move trace events to system/trace-events
  target/arm/hvf: Add trace.h header
  trace: Don't include trace-root.h in control.c or control-target.c

 target/arm/hvf/trace.h | 1 +
 system/dma-helpers.c   | 2 +-
 target/arm/hvf/hvf.c   | 2 +-
 trace/control-target.c | 1 -
 trace/control.c        | 1 -
 system/trace-events    | 7 +++++++
 trace-events           | 7 -------
 7 files changed, 10 insertions(+), 11 deletions(-)
 create mode 100644 target/arm/hvf/trace.h

-- 
2.34.1


