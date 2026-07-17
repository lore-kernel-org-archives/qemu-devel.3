Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A3AC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdpL-0003IO-Il; Fri, 17 Jul 2026 04:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpE-0003Gd-AJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpC-0000m9-Ba
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so4095408f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276497; x=1784881297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i2K9NQEEWbGezDEeN9Dv/yWhjakBnroGsaCdZhfSqB4=;
 b=gtkAaQ37waRwTuDIEHoXIGUZFAfKrRBpH5clLbisrrDQER8tnYRy7eXE4eqMGuHKsu
 cUjhcO6Kmn/sKrTLKeXVaStm/dfXb6wvT6TK0skcdbArFj34CCl7nZ2yIDV2xFPU0+59
 Svd0fGGcTKeCKb7OF0qJNoIPxqP0p3xGt98VY2FQqYM/Xze5BhvMT+xp86tBTnk5Y4Xz
 unofm3cJ/98p7DJvz7tVBQ2lNXgEidYg7TrSkxrRGwLu4W6nStoVfFLKxZc7lWAQbuDf
 WHAD3ycxD8NYyP+k1W6fdsFOQsCi+77GfyK4RSPIXBkOT7N5ojeAby83mFdHQ4JBbLax
 ZdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276497; x=1784881297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i2K9NQEEWbGezDEeN9Dv/yWhjakBnroGsaCdZhfSqB4=;
 b=qtmCIqTsY64/+Kl4gsUMreqfbcW7/pkLz/33D2DC3pbTBQRwtxNQj39hd+d7GnhxCD
 0+mqVwMg/GkzkpHmlp6knlSXeQaGspRhwBhmSDgBRWBmwGls/mEAQjS/NLxq+ohdpuMG
 KsnHNVuUIRLyJqDDSV2QU7mOeKkzGlcHGMWxm5PmBrB9raKvi2HYG3qI8IeQnq9yqpvb
 aeqfGg94sgblVQ/zcC6Nj/LmHW0nB/Izb94hsdpR3Aki6jDYwG+eh5IcpjXZpPkYdHGC
 ETFNOtfeAE0mGFjzPQ1xULyISlSI2DskxBoDUa8IVQj81WWarnp0zo4R5GmCE7860qfC
 5eKg==
X-Gm-Message-State: AOJu0Yy4C5UA5M6kPBHaRKk+D7LICv4rUDdlMXP+oDWjbMqeF70+6ad0
 Q7/1fyMjZjSBsxtUTsbETR2NC/D7O8abwnCdwuLBKgXjhgrrEH6iC1swFJbHR99vi4c=
X-Gm-Gg: AfdE7cmryJFYlDyIDDDfeXmQVmQ+7HoiWJBz3w28QEkV3h5mKoYlYB7JQLVoLkZUwU2
 O04wbz7ApOfpwZThH9157i+x2pp+3V5kH5Geox+Ft2SC76eYW0Htc9Dr/33QgDRWfh4ViMtdoCw
 WtVCnhmgkVWUx/nhDbwl6TJOb19hoBuoa6s0DqzHC+E8f4Xp+uIvfbkV0la1YSoesUCcENae+ah
 x9c3eFfwBU71pEsb5V1blDsaT6TMVgQtu6GOsvlm+nst5nQ889ZrDCP5yXRJzlxR+1SLouFkXpT
 autqE2bMlT6e2JJSJooDKmcLsiVodCGl+uVaEyN9JdiT2nKrQywlsi9ciRoMVDR6FmQ7/LS0sR9
 5y6JlySDKQufMF4bH3rWQGY048KUy5up0ceR6BdaaSSlPDkPt2+QIon6+Uwq2eeCJcI3f7d+4Xj
 DO+seLhdRweyb1H5gHZJxyyTLgzyjwZ68RJHuQ5Zy9DzugSL4vhSz+POZ0YhrN778Tfb3QC2VLF
 sE00KXkQpXDlvz0cMotnWhhjI6spI8sbynzwKoRGC4Jz1btXSmeWB6qdQhQYw==
X-Received: by 2002:a05:600c:1382:b0:495:49da:e15a with SMTP id
 5b1f17b1804b1-4954a40d1d4mr16542485e9.30.1784276496614; 
 Fri, 17 Jul 2026 01:21:36 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edd7d3sm1622587f8f.25.2026.07.17.01.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:21:35 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 0/2] hw: provide a fallback default machine when the default
 is compiled out
Date: Fri, 17 Jul 2026 08:20:20 +0000
Message-ID: <20260717082122.2439916-1-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

When QEMU is built with the machine type marked as the default compiled
out, there is no default machine at all and starting QEMU without an
explicit -machine fails with:

    No machine specified, and there is no default

On x86 this happens with a custom --with-devices-x86_64 configuration
that drops the i440fx/pc machine but keeps q35: i440fx carries is_default,
so once it is gone nothing is the default even though q35 is available.

This series lets a machine advertise itself as a *fallback* default:

 1/2 adds an is_default_fallback flag to MachineClass and makes
     find_default_machine() use it only when no is_default machine is
     present.
 2/2 marks the latest non-default PC-family machine (q35) as the fallback.

There is intentionally no behaviour change for a normal build: the
is_default machine (i440fx) always wins when present. The fallback only
takes effect when the default machine is not compiled in.

This is an alternative to simply flipping the default from i440fx to q35,
which would change long-standing default behaviour for everyone. Only one
machine may advertise itself as the fallback (find_default_machine()
asserts this, mirroring the single is_default assertion); on x86 that is
q35. A priority-based is_default was also considered but seemed like more
churn for the same result.

Tested by building QEMU with and without the i440fx/pc machine: with it
present i440fx remains the default; with CONFIG_I440FX=n q35 becomes the
default instead of QEMU having no default machine.

Rohitashv Kumar (2):
  hw/core/machine: add a fallback default machine
  hw/i386: make the latest non-default PC machine the fallback default

 include/hw/core/boards.h | 1 +
 include/hw/i386/pc.h     | 2 ++
 system/vl.c              | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.47.3


