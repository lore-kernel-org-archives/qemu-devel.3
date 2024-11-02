Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2AFE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DH3-0005XP-46; Sat, 02 Nov 2024 08:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycoekjan@gmail.com>)
 id 1t7Csi-0007QN-Td
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:05:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ycoekjan@gmail.com>)
 id 1t7Csc-00046t-Br
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:05:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso6646762a12.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730549118; x=1731153918; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N8UzXm3DGxTAw9snxekvgZQEX39pCi/j8bD6NoMWeBE=;
 b=eCM6PoLJgZFCzUO3CNKqLy2H4rNaGFx/h3p72AWOokra8D49GWECgL0SQ7EbJG7YEr
 CXewc9FvenZ1GcFpxhoShIZ9rqDTStn3aO1hJ76UylxjJIeX8cNyviP2S7KeCXuWpYog
 ma+gIsaszqgG/ICYmhwrNttZLOHGOsz/NuhT6nDh4LkZTSJjWykKKkViWH5IY1CBLOv2
 Tmoiqr+V9ADj49+diLXkD4ZVrKFMrgWfsJCsShj4wNz+7XDNU7TKrwqqyCnQ9rLFI6JG
 nlLjggoRrsrINW79Ihgz2G/91e81vc0K+WhvqyLS/pqBzOG7a2bfdYfwyxD/Vc4gyLtE
 XMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730549118; x=1731153918;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N8UzXm3DGxTAw9snxekvgZQEX39pCi/j8bD6NoMWeBE=;
 b=gxshFlZRQbgGmN9yGxM3T5uEF6bO81yMkVTFkIaCsk0Sx8uSUsUWrfzMPxW3vUN597
 dK/5v9x6FRxUw+qtq6+OQ/514quLvHuhWPl+DEJv6wooovW9R/m8124wJq/A/uHo+ITr
 +4fABu6azjniZs+KG5zljFM22hVrcjg3DxUoX2qWlePcYKbKI2PDFMFMo97+XIwsuAJ3
 vp2d4QgH/Vjlr7zprebVjJZs1AyM5I2RFaX/cjCFCkh0CQhRvBMo2JCb3Zqf3Cg/Sbko
 5fq7DGGyexHH+fCXl2jwr0rVkrGCJEMDcAje6DjTbBo8j0ZG+Qp/icD9Qpxep8WM+59a
 Kwuw==
X-Gm-Message-State: AOJu0Yz5PNcMfp/kuq8d+jOQOrlSExFln2sH/IchXseK930vW1DAP8nP
 Dwn6xTr8Nic7o7TOBlSntfobZMKkczggxZkIkBpU3T8zlYLkydj4+fND11B7SjaMtGiLzfWVNWG
 TBdVQ5PFoqHLDsF1Lfok0BreL99kYs9FynMQ=
X-Google-Smtp-Source: AGHT+IF2/WR469/oK6ie+mPuPhHYgKi6HiUPxjq4QXu+7420CwM8XhLomxeMzAE8k4oxCQOwg0j9TqL2c+AEVADEQUc=
X-Received: by 2002:a05:6402:320b:b0:5ce:cf4a:79a5 with SMTP id
 4fb4d7f45d1cf-5cecf4a7a9bmr731170a12.6.1730549117367; Sat, 02 Nov 2024
 05:05:17 -0700 (PDT)
MIME-Version: 1.0
From: Coekjan Yip <ycoekjan@gmail.com>
Date: Sat, 2 Nov 2024 20:05:06 +0800
Message-ID: <CA+Oymobc=DOOuy431LJHTq4sOPiLRjpxyTzFp-zRE+NXOCim2g@mail.gmail.com>
Subject: Inquiry About PC-Relative Code Generation in QEMU
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=ycoekjan@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 02 Nov 2024 08:30:31 -0400
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

Dear QEMU Community,

I hope this message finds you well.

I recently started studying the QEMU TCG code, and I have noticed that QEMU
seems to support generating PC-Relative Code (`CF_PCREL`), but this feature
seems currently enabled only for System Emulation in version 9.1.0, while it
is not available for User Emulation. Could you please clarify if there are
specific functionality or performance considerations behind this decision?
Additionally, if this feature were to be enabled for User Emulation, could we
consider the code generated by QEMU as Position-Independent Code (PIC)?
Thank you for your assistance.

Best regards,
Yip Coekjan

