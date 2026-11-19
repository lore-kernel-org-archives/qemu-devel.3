Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E397606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AwwyP+Ti
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2jv-0003yQ-24; Thu, 19 Nov 2026 09:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jp-0003wX-N6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jm-0000Rm-5v
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-491971ac844so2264944f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795097020; x=1795701820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ulEB7tgxg8tSBn0XzVA6Wzlemvf8SZiJ+RKpPC5H+1g=;
 b=AwwyP+TiG3IOMTn5pRqWtXd1+ADcC2Wwk25SsYnP93h957LcAyxPhI727xOLWou4Qr
 7Jg8ew3bzl1w6ZXLQoFq0R48cguyIRdPRxhV3+7d5UIbz+aNMkUIA7KfTPEPbqnARhvT
 wVavHWdckqHWwUXVOxvvxLEaMLFsY8mVMeEk2+SWZup7M9Nq1l1ZscpL4ZdJhlxVx/cu
 6gJ011jO1CTkdveA7Kr1vuUTyaUuXDMy2fjv5xk/nuC6gCkAHVgerCeMvRpaH/PMBOw+
 aeI2x6GelfodX+3ryegCTZYA7m8yD9rMR9RxMN5lKU9ycvskOCqwJ3SfEDqi8lyPqXg4
 xrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795097020; x=1795701820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulEB7tgxg8tSBn0XzVA6Wzlemvf8SZiJ+RKpPC5H+1g=;
 b=LP+m0AOqiaME++jTMFIWedlKNEkRpgwGErixws9/R8En2YFe/roYe0ivkvwgIZjSnU
 c/RpUb2kA8+dNpwW+KpIvA0d4nXq7F7HiATUiq1EvgZ6W9c+yh6uv5Pqdy7PY8KQ8lNL
 9li0DSisEnO/1Ylt15qyzrGqSsBWmMT/d0ktg4U8ZhSy0LM2OwueR1nkhUolBvXE53ic
 5YR7VNJqbjdT9Ud3Fwjk51o/J1xbFfsuMAWzFKDp98Lf18g98kiaPh7KFv5LUCQjtq5Q
 gqhsQ1XYEGxikoe5HDtq0LpVpYRmnSOzfaf/v9Q+i8U/NpfQ1K0ErryXlCvD0T9TTUE+
 28TQ==
X-Gm-Message-State: APuU4Z+9EHSjKN2jQSHU8pHNo+cxa65X/aevp7tTNUvfl3sqSYX1h9Vk
 TJZXY33PgJek2S+xsXhIcw/RjTxoQYr94FlBH3u227xPEu4RgEg/YRZPfHvcwdRdJFkr8V5qnYo
 FzoB+hZU=
X-Gm-Gg: AZFdTZe8HxlPt15KXEaR3DNhSqdQmE/bpGWgIeLzc2el6YIAhNKMGDmEVR+TaznFZ4r
 CObENuBdSF5+sE6T+x6lsqbAz9NdOgVvLFboVwsr0XXw5gBF0F2G+pNHeY9zsZC3JAw5EtW5VnQ
 Pa7yoHGUYVKgbAYjJRH6wR4cdyQ4l7nYlQV6zjor7vbwjCMKsn4PZm5Gvo8mIllkTtJAO9e9cah
 nRYcrke3PmDaelKF73rKN+aLDjLwLuRJy/jmiiJ16l/bT2UffQtU/tjQYaa0Vq0uYnu+DBcrB/t
 /ZgwAmXInYOX5OzyICV2CYxlTx1WcAnSn5lVHd0T9FlRjd2lWI8562xf0Vyn+Y0R/Mqc6xgsbM5
 RdJj8QZk+qOpHxRfIDj1SZc+psG3/ecYxtgSW+pxUuis03TaD2BB2B+theshM+wzS5qoNrPN7jL
 EOWKL+Uazd6Xrogz3Mq/Xy7BcGxhzWnEggUk5JgFMt3PPsZhghFF6FSlZuuTsPEgfc7U0YKM82Z
 3uRKGesx6XdN9+raS+SDQfGabAM6CezcoCCv1yDcKuu/rSG6HaonX21xHokEBr9j6mBx08cCNUb
 GoX2O085VVyc/TJq4MoILyDou1OeU14yD8HYAgBcg4zbHbvMgJGz9o4PtsBJFkUrD3xyZdt6s40
 +3DXvgIVam8llHbyJjRS1LB5A8WccNyl67g==
X-Received: by 2002:adf:e9ca:0:b0:4a2:dae8:ca5f with SMTP id
 ffacd0b85a97d-4a63bdb02f0mr10524234f8f.36.1795097020351; 
 Thu, 19 Nov 2026 06:03:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab53e891d8sm19118f8f.10.2026.11.19.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:03:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH for-11.2 0/2] block/qcow2: Avoid crash in qemu-img amend when
 reftable is empty
Date: Thu, 19 Nov 2026 14:03:36 +0000
Message-ID: <20261119140338.2918386-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a QCOW2 image, the header is always cluster zero, and so that
cluster must have a non-zero refcount.  This means that an image where
the first entry in the refcount table is zero, or where it points to a
refblock which is empty, must be corrupt.

In the "qemu-img amend -o refcount_bits=..." codepath, we were
implicitly relying on the image not being corrupted in this way.  If
the entire refcount table was zero, our "walk the table to see how big
the new reftable size is" loop would say "zero", and we would then not
allocate any memory for s->refcount_table, and
update_max_refcount_table_index() would underflow when calculating
s->refcount_table_size - 1 and then crash.

This patchset fixes that bug, and adds a test case for it.

It would also be possible to refuse to open an image for some of the
more obvious cases of this corruption (e.g. "on open,
refcount_table[0] is 0"), but checking the actual refcount of cluster
0 is a bit trickier as we only read in that refblock on demand. Plus
some of the existing iotests (060, 098) rely on corrupted images of
that kind only being detected later.  So I have stuck to fixing the
immediate bug.

NB: this isn't a security issue because the crash can only be
provoked for this specific qemu-img amend codepath, so it's a
self-DoS.

thanks
-- PMM

Peter Maydell (2):
  block/qcow2: Detect corrupt images where first refcount block is empty
  tests/qemu-iotest: Add test for qcow2 image with empty reftable

 block/qcow2-refcount.c     | 15 ++++++++++
 tests/qemu-iotests/315     | 59 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out |  9 ++++++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

-- 
2.43.0


