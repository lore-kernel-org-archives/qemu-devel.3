Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3F2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf5q-0002Hq-7J; Tue, 02 Apr 2024 10:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf57-0001ny-Ns
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf55-00006f-AF
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso3778739f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067941; x=1712672741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qcHH+OAhHv5oWHUpWK7YMWCpNLvO0BPFhkfbb/3C2c=;
 b=hskFWnFBvkFPy8nFb1IeN2z+snIZBvs3k3PXE7OJ4wIUl+Cnl6LUze7nB3D9SRIFIm
 TvDcv0Tk64fLxcqiDjo6DZzaB3eE+XLqVayJdJBwdJWlEZXxm01tQQLXNL6P/57cw2Pv
 eaYwOpzuw4NgqHLbgKbUrCGMZ6y0Nj+XcxAY1oUhyA0k9moSoscOlATq9SjFrjGfKOuS
 MZpPFwGEI4lW+Vhsd680XjrAnWX5zj/mUD7N1U8bwTuIeR8OzBJPvjBRZiWWnZ0uj3NM
 fs1SNIjjgJ6XqhGQ9KqJ3gpRjMgOnxH3ZwB2ZEVsIgKi0Vc45AMkijSuWjZ9RmszWkUP
 rF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067941; x=1712672741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qcHH+OAhHv5oWHUpWK7YMWCpNLvO0BPFhkfbb/3C2c=;
 b=Zo67w44yqG4aE07gg58tz0743VdYLvzQAir+aZhq00oIY1gmBUAsfnwAfDwuxlBGM2
 xGb2jBieF9zSC5cBIsatHpNPkgTQDn++LxNV2YtS0lqTPdg8ky6Y67KaLc0/l7PU1K+n
 ocOT34m3WXuyUjQEL8SDPvTZwu5PbOXdvVcK2V8oC4fSHBlvZKWDBCxdTjcBrBctJcI+
 AohdMd6Cv9d/gY1ASQr/g/Y4txxhT1ceyS2esvv80SlzVhH8Okipp07Cb+fA8qtlgNqp
 ChMWUo3Oxx3NPIRJM8VlZoSS+KVtQ/Ic92f+VBzb+nCFwXw5ML8AmADzUYcK2uGa8Wtr
 SB+A==
X-Gm-Message-State: AOJu0YwXNElIB9qe50ypg4vlHvU1w9zGJQyNQVXmyAPNEo/dKJG/P8c6
 6Xb3u/jnooCvpfM3IEL/a1MUpHrIjtUFqQqOnKYeaHH/I5Xz/P2tw8vSARpcR35f9lIMUTKtts5
 gqB0=
X-Google-Smtp-Source: AGHT+IEXIE7qmPsir59JZH4f0PPcQyJ4KagaBvkKMFNWGMsHJ3uFs9sfwByBvLsTeGCD+W46V6Wgcw==
X-Received: by 2002:adf:ca8b:0:b0:33e:7719:325d with SMTP id
 r11-20020adfca8b000000b0033e7719325dmr7135610wrh.2.1712067941079; 
 Tue, 02 Apr 2024 07:25:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 az15-20020adfe18f000000b0034335f13570sm12328862wrb.116.2024.04.02.07.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 10/15] block: Remove unnecessary NULL check in
 bdrv_pad_request()
Date: Tue,  2 Apr 2024 16:24:25 +0200
Message-ID: <20240402142431.70700-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Kevin Wolf <kwolf@redhat.com>

Coverity complains that the check introduced in commit 3f934817 suggests
that qiov could be NULL and we dereference it before reaching the check.
In fact, all of the callers pass a non-NULL pointer, so just remove the
misleading check.

Resolves: Coverity CID 1542668
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240327192750.204197-1-kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 395bea3bac..7217cf811b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1730,7 +1730,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
      * For prefetching in stream_populate(), no qiov is passed along, because
      * only copy-on-read matters.
      */
-    if (qiov && *qiov) {
+    if (*qiov) {
         sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
                                       &sliced_head, &sliced_tail,
                                       &sliced_niov);
-- 
2.41.0


