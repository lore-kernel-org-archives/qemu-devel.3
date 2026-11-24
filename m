Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02526606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTrf2aoE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVgPh-0002Iq-Rf; Mon, 23 Nov 2026 21:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPa-0002IP-EY
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:38 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPY-0001ui-NZ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:38 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-9912c47367cso2618836241.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795487855; x=1796092655; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YGfAwFcAboRMyLZdBEyGrqcVAFGxiXTz2qFd2Z51Ing=;
 b=oTrf2aoELphshn9l1ImgEq2SHYUa/gmxedAab6Mi4V1xa3tdNmtnXICQ2xuWS7N8ci
 dtPjqoKQJmN7M8WSDQTKqY/9z6qMK0wHDcmtMU307GPqtXuO/P5IX8ynEl+tBRzpGn24
 rcdacZZotXwoyKUv0DsaDuzuLLbpPfG0kEf0OTlMhTw28l84CEpSiq28NiXd/Ye7WlBX
 bEaK60OcCGUF5cepo9ckCQSMaQx1quUIMPzzJsMRhcqRBmmwnO/HAPT4zjEm8rzdOmeW
 8zk2F8tSoZ9HUA7N3v54Yt2ELFfXRpSMeCnHEfFVdReG7TUDaPvL3ueGXyJ4P2BY9ohN
 02IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795487855; x=1796092655;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YGfAwFcAboRMyLZdBEyGrqcVAFGxiXTz2qFd2Z51Ing=;
 b=TVnIdWanRnzlfl8p+lXkEw/Z74mmRYE2OEurhadoX+lAsh1jZ20vBk1NmFBltubcxQ
 yAXeitd3+CdGCYCF1oppzv7jvzy57/hEYKiKATVfYCIIP2pi9tr9JPycqmpfTB7Zc5sI
 RL0LfReNlQnR/SiDDh/T1K0OA+t4vPo42VvflXWw9D6nH+WZqlNW7a99oGrB6NW/OrIk
 1PoDU0lGYpRSz2kSuPKs5fOVyLdZW6clhZ/Hpk3lgzrPEwpfGpqxChT4KrmSyWVwTRjI
 zi5Cs8f3kw9jeFnM8T3tRZg9hcbZ8ZXSpS1Op8YK3pg6/mn85zLT0FPYaR0OagfMnhcL
 nE+Q==
X-Gm-Message-State: APuU4Z+Q48LX9fplFUw+zGuJfN/gjueBkJ3ITZDI3kARX5idAcaF51n3
 ZT7PCeDZ6EdlzreNzedNGNTfKYiXcsGDevRFptMdSFNQ1Yv2iikQTOhw
X-Gm-Gg: AZFdTZdp5PvpU5ynGTrZh+CBZt3v2DPEQRipCJc40l7k+HlQO5bSgNoxralSA0E9uD6
 d0DJoTC79uNI41U965AOndfeqhVBWd+O4CdC1d+UYcKu99IJE/rX1x1UErfa/MvKTInwRj2XVW2
 dePsAIG/JaXFVUqZr3B2q/4a2xlzxgsM7gP1Z/AWgBpur9hoZzsXlcl66iw3G2uzvC0CDRVusc/
 EhgWIuUaHN67jGLnKrH52XGL8mgzountzFpOVNpI9rv1IyPC48x5L3O6drCSx3bJgPyP+LTkxWj
 nZrBr7tbdsUqv5g92y+h5yHlJUG0GEfKwVD3LA/3+mgxn+f0kBaZL6S+M+/nF/qgRgaPhB3bpvK
 2YAOZ9U9IEabX7oDHAUqaC1cFNrueLkExIlRz+/KU+7Rr5HBpG0Ljh2/0goIqTn5TXB13QjsswG
 wP/8jIZP3EtZbWuqknYGIxtvDjL/6smqaw5wyILK7o4agSvUkYkY0bozSDCillmS5ozzmaROBxy
 e/7WipU7ood2epo4jOckj/avvTpiQ+Y4Tl1J8lBsji+e+ef99l9xslAuj1XlZ/xYE8RBbw/OkXj
 dCr+VuWejRu7i+63oy0=
X-Received: by 2002:a05:6102:f07:b0:7a1:f2b5:6469 with SMTP id
 ada2fe7eead31-7d6dba41de0mr5260931137.38.1795487855559; 
 Mon, 23 Nov 2026 18:37:35 -0800 (PST)
Received: from [192.168.0.131] ([2804:14c:3b83:954b::e84d])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6e05ac5asm13618504241.9.2026.11.23.18.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:37:35 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Subject: [PATCH v2 0/2] block/dmg-lzfse: reject truncated decodes and add
 regression test
Date: Mon, 23 Nov 2026 23:37:07 -0300
Message-Id: <20261123-dmg-short-decode-v2-v2-0-e1dee5893891@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgM2ioJXEYfSpG0GrbQignh3i
 +Mb/n+gSFYpMDcPZLm0aNorqG3ARbsHQeVqoI5GY6hH3gKWmPKJLC6x4EVo2Uw00OCt76GWRxa
 v939d1vf9AJ4EoixlAAAA
X-Change-ID: 20261123-dmg-short-decode-v2-ad172424faf3
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Julio Faracco <jcfaracco@gmail.com>, 
 oxsignal <awo@kakao.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795487852; l=1838;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=gbD0LX/JcwdIDy7sXtS6/6d9idB9ba9I4LIMkdPXO7w=;
 b=E6BLRRl6EmjqqbjiLndxfsJl1l23v/cARAkoqTVrRCqcZMllDgX94JS/nCYe+n4tnzk00U0p0
 UW1mj71H0d9DvJZT7FPrPafPFSVP1+CPH1qQSmmFQwgCUDitPezSpE7
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=jcfaracco@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes a heap disclosure vulnerability in the DMG block driver's
LZFSE decompression path (CVE-2026-116483) and adds a regression test.
  
Specifically, this series (1) updates `dmg_uncompress_lzfse_do()` to reject
any decode where the output size is smaller than the declared chunk size,
preventing unzeroed chunk tail leakage.
  
It also (2) introduces a new qemu-iotest (`dmg-lzfse-short`) that
constructs a crafted DMG with a truncated LZFSE stream and verifies that
reading the chunk correctly fails with an I/O error.

- v1:
  * Allocated an extra '+1' byte in dmg_open() and checked out_size != avail_out
    to detect both short and oversized streams.
  * Used qemu-img convert to raw and Python reads in the iotest without file cleanup.
    
- v2:
  * Dropped changes to block/dmg.c; simply reject decodes where out_size < avail_out
    in block/dmg-lzfse.c.
  * Renamed "short decode" to "truncated decode" for clarity.
  * Converted the iotest to use iotests.FilePath context managers and direct
    qemu-io pattern reads.
  * Explicitly asserted on "Input/output error" on truncated chunks.
  * Refined skip logic to only trigger when the dmg-lzfse module is missing.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
Julio Faracco (2):
      block/dmg-lzfse: reject truncated LZFSE decodes
      tests/qemu-iotests: cover the dmg LZFSE truncated-decode fix

 block/dmg-lzfse.c                            |  15 ++-
 tests/qemu-iotests/tests/dmg-lzfse-short     | 141 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
 3 files changed, 153 insertions(+), 5 deletions(-)
---
base-commit: 2bfbe39d0fff8af881cffe2bab9b615e77807c35
change-id: 20261123-dmg-short-decode-v2-ad172424faf3

Best regards,
-- 
Julio Faracco <jcfaracco@gmail.com>


