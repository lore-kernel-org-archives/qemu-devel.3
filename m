Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9DFF8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIs0-0007vQ-Kf; Thu, 16 Apr 2026 05:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqm-0005Je-QF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqk-0007rP-Mp
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so55276625e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331045; x=1776935845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iezE/09wMgPXUNZaJ4iybBG+v+0R7DAEbDQ3r+Tx1dE=;
 b=ix2Kq9uAyBt79DXLEGTMiLGLq1JrElGUfspV9PtcCRLx9iuc+ProtWHGdsNpv+0DAe
 wiOTSSSR5iKUEvP2xh7gCUZw4i0iWr89pYxQZ8XEpgWN/nX6SKh7v8RtcHMFc3b0MJzy
 JrbfL84F0xaMmii1D1hvl3hZx80qNgFEBH1BCtYAVJFHyyR7bZo/a/V6hfXtNp15J/+r
 wxSGdVc6rejpGWupRqwfBdhOHOUze+l2MobLxda43es556BlzYPALvX0A7BBj1BbyK4P
 U+2xyFXuIAYHdQ1fXQrXwCmmV9DTK7zRw9DEWSbI1X1+TXXyvjNghYBWKb6K43mpTv+m
 SAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331045; x=1776935845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iezE/09wMgPXUNZaJ4iybBG+v+0R7DAEbDQ3r+Tx1dE=;
 b=VmEoifZmihux+grcskbdwEti4zFQG5bLk+IFamnduKbNEmJMBEezSdCi3h5cw2ysiM
 LwXLP7pe1o15z5T9/0fcDyW+z3sULODOdZ+hoKYyolxxwg6R+lDTGJu6XUvwPNBUOEg0
 MqbQMnt73ETprq7P+qpT6+thvtvWNZGzs7P1SYu5ii7SDc4QGVWI9aJc36cSxK2Dx2li
 TXN2pXzUnpQOcUPZdxrNACVhraDkndEgE5nK221e0hzm7GmPmbsE3loPGselR6nn2sDz
 jdoId0E/zznOcnSsC4S0hoBGnXjew0VHjrgx68zPI4VQGg+XROj5ZpFvdpYx1yNx2/dA
 GXcg==
X-Gm-Message-State: AOJu0YwpQr27ZzDamuT7rt0/stJ1ZiBE9v79c3/cJCZZZ04+WilfPmQy
 ymFE0bSBlRzaJkzazesiBNKK4RCou7LyirnPgQG8kgECliqJ3TwKbVaroK2qxAio+WYecyHd0iy
 iyVipzWc=
X-Gm-Gg: AeBDieulvumcFZkhvGluHDU4SU97a6r/0GJVMVrAvFw0viZS0BxwfGt8QVyE6JWO+Ti
 0tWk5CX3eQaGUfGXJ9BmIGqIb1dqu5YCRgluDYu6YQRzm8BV4i3q6paL36n97UC+dh86u5MlUpp
 TyKbuDDyxYoHdjkE5RcMBX0D261GT0Vpy417lYNw7Uoj5oy515kMZLWfF+B651J8nUVm2CTSph2
 NiHijQwItrhl/RJcBjlEFN84bNHIfCLxTUOM2jnzBh729OPiOyK8MGyQzveiB1wzBh6wEVr8DWI
 59i3M154pyZAVJyp9zp7VmOS4sfbfpre7TP16LRXDbFAnEnZt4bdhNqvq1+FoNOnjmzFLfn5PUl
 aYHnc1100GEdB57NH44p9AQbDSGQBTjybi9AhPWbKrPgHELPqwGSV5U2ZYHy9iXYiLjd+K+nWKx
 PrqTgoogrSpkdpcUxAA0KOp7b+Zg0LSQmC4LoOhGPUK0XHUBPkJcgGz03Jod8kJ+aTbjPXv2VtW
 pVU7jd6A042gUyubD0CuNDEm+roZ54+sJwAFDfepw==
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id
 5b1f17b1804b1-488d68c2cb4mr321701385e9.24.1776331045253; 
 Thu, 16 Apr 2026 02:17:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/28] MAINTAINERS: Remove Xie Changlong
Date: Thu, 16 Apr 2026 10:16:54 +0100
Message-ID: <20260416091654.316158-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Xie Changlong has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Replication" block filter orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fb56bdac8..a50e5dbaab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4382,8 +4382,7 @@ F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
 
 Replication
-M: Xie Changlong <xiechanglong.d@gmail.com>
-S: Supported
+S: Orphan
 F: replication*
 F: block/replication.c
 F: tests/unit/test-replication.c
-- 
2.43.0


