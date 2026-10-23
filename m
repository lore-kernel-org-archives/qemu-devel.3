Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Tq7uB0JD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKH7l-0005Du-2I; Fri, 23 Oct 2026 11:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKH7j-0005Dj-A0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:24:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKH7h-0004fJ-Kf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:24:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so613324f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792769040; x=1793373840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fyRGpVuAB/YL1MZcY+6qFhzYzmkXQA5aHAl+YOQKQtw=;
 b=Tq7uB0JDCDBeisF6QhX6tEzvVFnMQNA/zQ8vrux/HX+USu9nJ2F3e9fIDdwzO9A/5A
 fR8lmbIYC3lHSAY7SWt1HmV3OR0vnmXS7jQJyeWHChCJcoBjDgWfFVV04hZRa+k0CJOF
 AHgPbHNLirjoDqK0Br3Afnmw+kgT5eVRBakQJab2USYbJCGiRlrBPibCRybZNhJrRHjo
 Qxfygg/QrgNX3U+r/XfeEiLeorB8wp+ExVQJHwwoT+omE8UptAiXkWKtHHeCy3ksyWXA
 ppVBhRCPFgbmB/pMOn2ZkUcqf0e2ClwjBGlmD87treCrWgLGcVinqrpyuVl9A2ymyiyY
 qJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769040; x=1793373840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fyRGpVuAB/YL1MZcY+6qFhzYzmkXQA5aHAl+YOQKQtw=;
 b=dP5DUTNJbmR6g/GdHgdQUudJwGRy1BYkRP+r+CVDcIHoIZDS5uXxIS9Lt6whC5F5KT
 M/Y+35CbgBS4Ta0GUjB/7B71q2D8iZwdqNx4+jzV+dN9qKHJwyF8TUFmhbod8ZwmyU1W
 p48Bu4AXuooLZDFcMHrAzw0/+UpQrn2B45aikK0y0eEFeHHNASIQ97DXOVBXHHGggqIV
 B0BwFjGIIYlip9vk+scHkKRVRdIQdLjnck1IsLS5jxHbHWK+ElNcG6t6NrI55A18GG/0
 w2Y2nwHsKyHyW155En6Fj48/k7FpJ9B4fdhXWAjobO1UAbN8wl9OpSbIRHmGTCEpgz1T
 Tang==
X-Gm-Message-State: AFq9FYLfLQcey2DO6UE0IAaqk2eD0Agb1PgK1A8OB1bGJDuFuVfIGsUA
 fC/WIsNXeoi5sLYxr9ZCCvnRHiCaPxlPkYnE5Kjoaj31nbWSnrQ+hJkGg/GYLqrLeMFJlqX/ma1
 AVTLVkLU=
X-Gm-Gg: AYBFou1ivce7xAOqyRZMJOiXDTcpOZT7JcbTjsBlMtqs032/Q4Y9HFHZ4PiSyk/DiZD
 fTRAc4ygnbljwpXS4KlZ4iaQi03I7C0QeiHAtwbJPmM5TaeufYdPVWws4WglvuTi3GWEbQNd1gH
 LNVdubV+6GZMVFgEAEcqVNueqgxGXyI4j5rzC7xn4FiO0+mUyMGtQ4F58n82MMDZHXFxRoeiRYp
 dIgwJivEn1Ou2LJ2pM7Ue8yCOBf0z9yoViD6GPK2Y3+hzgkxAE+S3JwSQ1SSXXHjLFI2ZUGHeRg
 RvRm6TYILM1GVm7ZDFMs3DOOGLQlY8eiTNhUOp1IV3FexSFNgNJIAZCLFiWBgEE5tm4OioxUHtj
 S+X6FyduMm3Loz2SEUPSqKxLcgk7+E7Zfb6jno51+PJAQKDd6q7HP82vg/pwElALOYLiwDTvjhq
 t83zXWWxjScJXYsUHLuWB/Mipm28UGKyZQZUBnZuVkj6E+/t3qQHlif8rESEoGk346KhL8U8ssB
 u0J2KLi/2KRX/yd3IPc2/AkJRlaHIFSAQy4Qr2WQySEjQrrBNWjTIIXHjvqUuZopmPtXpEzvn/S
 qppX6i17HZ7aBIvwenfLKrZN1VE/U3KhqeBKzXtKGh0G+edm4pQN+rGKj0gQ
X-Received: by 2002:a05:6000:1789:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-48e385aff7emr5119566f8f.31.1792769039578; 
 Fri, 23 Oct 2026 08:23:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d408f15sm415572f8f.33.2026.10.23.08.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:23:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
Date: Fri, 23 Oct 2026 16:23:57 +0100
Message-ID: <20261023152357.1614817-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The checkpatch.pl script insists that Fixes tags are at the start of
each line of its input. Although this is where they ought to be
in the commit message, it is not where the script will see them
in common usage patterns like

  git show <hash> | ./scripts/checkpatch.pl -

because 'git show' prefaces each line of the commit message body with
four spaces.  Allow spaces before the Fixes tag; this matches how we
check for e.g.  Signed-off-by: tags.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format and commit ancestry")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I just ran into this myself today as well so wrote up the patch
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5df266acb17..82f62f60212 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1889,7 +1889,7 @@ sub process {
 
 			if ($line !~ /^\s*Fixes:\s+CVE/i) {
 				my $tag_case = not ($tag eq "Fixes:");
-				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
+				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
 				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
 				my $id_case = not ($orig_commit !~ /[A-F]/);
 
-- 
2.43.0


