Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AD2F8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIqQ-0005AA-OV; Thu, 16 Apr 2026 05:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqN-00059d-LO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqL-0007jj-II
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so72740315e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331019; x=1776935819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S40UE3tDYC2J1tndJ4zXFpPks9b4/LjwSkUmsid18bE=;
 b=dCVaFDP6HiC/atr/NN4HjS9upuRwpiT+JY3+DdDy0tJmob3P161di6u9w3jcdjrDr6
 ZcArjYijU6lFWctqAUXRM8s9H2PK/bzJTpNjP+/hWUEvHngntKVmALP6MlWtyp9qnMhB
 QGCy4S98ySn0Rc7ifc6Uira4BHseWkhJncQUtkUSk/1sD8W1AY3BeBYYgge87rzTM3Iz
 eWAt6VG2zQzIEJ1ChoSF9QSsuszQqdv4SwOQfm3iFNwmIB1qZ1IDLBJl6E8/KJoA/ck8
 ozKA0T7lL7C5U6VkXQpd7CDshiZXqq1H2buBs8RQQ5hfum4FTRuwLthhenMkxLw5smwD
 ydEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331019; x=1776935819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S40UE3tDYC2J1tndJ4zXFpPks9b4/LjwSkUmsid18bE=;
 b=WRAMC3fBOXXWBLIq8rx3g9Tug+RDiMfUJ1lvIvNJGNoF5s+fJDXQkweUNhpH+rw8oF
 Z2yNGxVds31/2t8Ne/GPKWc7cB0j6fiCnFXV7LDxjMoQ4lTyIzux/9m/FfBmExzwpkQY
 HNw/3LolRcDs0i5wivQUsESTgR2mx413kX0AA6AGL2Pyzpb63GPkYF65eDX4UuySMYup
 ZCIHtZJmXypMT6l+rMIDqvlu+Yna2FzxANV13GLz8sBQtxEN9cq6yiccfRUWBdSGPg6s
 TuXT7Vl/y2Ql1BFzMfqmAq1Cg6nv4I5XMieL6EOT9ji8vDo+zmIH/n4GFSEs48vDwhbQ
 PtxA==
X-Gm-Message-State: AOJu0YzAHau35w7f2nC63X/UkhStkKB4VhdQCj1ZCd1NqaYfzdIJUKpr
 M2EJxMdTMsGJm667AseEBRALVmVBuLoltpVsyAcL+AgkASykGuva9GVHmvT6KHy0p+FYAAnx8VP
 /N17bqCE=
X-Gm-Gg: AeBDieseY1mOuXKKMBRZom7fg3lwW7QLkRVMNOOJKhchFvKgzTG2qalQ8SK+OkItJR7
 C/ZM5mWoSeef5n7tl0A7dAcFxmsCIKWvYwASaD7COnGFwwu+z+8LnaW1NkH0r20vYAA8bgBu0K4
 Yly2oT2OXmnGltvwnGVSr5NuSuv+yBWI38E8+UaLPX/0OlQ7yNCq+l21eipvCWLctb+DVVWkKVd
 fBvbWwjw8rH/0sO/Tw8+jOfzAgCzyXEc7ocaGjubKjK5X2KAsUOG+SeQ4G25fBM1ALXUcbh+GS7
 2fCIvHN/JeXHLKoIW1p6O7pE6Qzihs2I4C+eS6hgj+kvJwwvoKumEnXzZ2iBxuQ5HT3iU0dufrZ
 q1ASG25+523QH+j2zi8Em2YMW8OY7cE+qbMMUP31sVXquw3mg1rbbF7KP6ZYp1hrJfb+9WVQ3wK
 qiZGnN0v9KGMwpxQ0L/uT11YpWa8VVCQUs/XsawL2qE5uNDczepul7+ObiUrINRfbaK6m0A5s33
 rD4GYnyJL5Bw9AaSXK5xbONDIXe5I5Q1Ju1Ogmosw==
X-Received: by 2002:a05:600c:c0c8:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488d67bbc13mr260574195e9.4.1776331019183; 
 Thu, 16 Apr 2026 02:16:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.16.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:16:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/28] MAINTAINERS: Remove Beniamino Galvani
Date: Thu, 16 Apr 2026 10:16:29 +0100
Message-ID: <20260416091654.316158-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Beniamino Galvani has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 119d73a11c..2a5dc03b93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -719,7 +719,6 @@ F: tests/functional/alpha/test_clipper.py
 ARM Machines
 ------------
 Allwinner-a10
-M: Beniamino Galvani <b.galvani@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
 L: qemu-arm@nongnu.org
-- 
2.43.0


