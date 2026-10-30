Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1omSTY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMolb-0001SD-Gb; Fri, 30 Oct 2026 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolY-0001RW-5N
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:41 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolW-0002gT-2W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:39 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-3550c917fd3so1225920eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793375017; x=1793979817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LjY640+5hXYIzmOYfko7rpSId7DPU5DcwkBqnyO+aH8=;
 b=s1omSTY7Iuv7vOwINgm7+9z1KicECSh1hT54gdLgHNOugw/4EC1uauMrkOBPVraD0k
 n2//yyU5kq1OL2mszK+rSqPmMtjJmNetUCwBuldh+gK9nbxxkSjQKaNJ3W4fIF8mQnbx
 hfje4FOy07UiByj/dV1PHXB/UzxXeJnHN/r3jNNI/F7aV2vlPvlBF56x1ucgNMWF4iII
 rpS6cXqXFqxczTUIrDy+15PXBtZDfE6Mwjw2QwVv27JegMtPuPtUE94molgY8NmNyJpu
 Qmb/uuVdGeSGK94aHuDJRffIpKmMvOHbnt75Zy5RzCuzT71/9pdF9HU6vk1MyP44lzN0
 8+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375017; x=1793979817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LjY640+5hXYIzmOYfko7rpSId7DPU5DcwkBqnyO+aH8=;
 b=sZu7d1UsgSGN01yKQe+9zetpYkt5ptJT4kF1TW7ny3CmH8SEPbyAnftg1J8rgF8SBk
 T/9p1ImFxH6iEOUF7bEdXhQntwIW92it5JhjeSeX2Ihy0BJISqsHcytV2lVRoQoDGxgy
 Gn/o571eoUpG4VJBK1gwXFN5Xn4JIVVrJUzSQDMw2JTdp/C+H+8dSjhDkrmmg96NAmuB
 AJJdISWgem0Bw+m4VlBP02+hgVbjfj6uTnrV6MommMxdW9jjII+CebX2If3BXm8rc1Xm
 fCuArIwq1XDP1eo922KSaJfuKr2tC9pL05odiVnWh+A+v1s7I1CAOutmu2hK5A/jsanr
 VieA==
X-Gm-Message-State: AFq9FYLjHdKQ8W0ai4M9hH9IDY7SEOdw0BxBdEjQ353yjcHmS384iQRF
 FXvydv2zUQiMc0MEXFAPkagcZFM0ZlCuc6FKhw8NgkYvxenxuuUN1wMi70Pe/5do
X-Gm-Gg: AYBFou0MIJfsRyiw0RK2+qnai5LDkC/W57DPxQBRIj/DDeCpfbNoMPKbydWEx7XmTGU
 LcTcJsds2F3wRze76Ar9alGqyaEhLBLYLwL/nVAr93+jIL/zeOMinhMJaoLvOZhBj8PPjIpVYQG
 rpy8a+arjYOYVz2Z7JjR0+jPpx8Zwcs7TpECwG/2FC6ZRQ2vVpSCEpTInqrmts4yEYzyhYIJn3a
 kjSLFG/sT/BIF/piWKj225y7PURaMQCzz9zOomA12TyJoFpZD+/pRNWmSyYvI9eLnL8yvLQQaa7
 N+zlnE8Ken90Zz/H2elIGB9cxGVbZNAUzDAl1vD0Ppd1Hj94vAvWMvZ/GyixUMhwuTCYiuJjiEX
 eBx/BBUU0O/g8nUMra4dFWb5IPmpFX6/c0Vgyw9fCqkfN5wttQdW67724j0HG9oCl/Z22DpjYkp
 wOD/PvVe3h5It3gJg5Trbd2eTlH3ee/pbFnYzDgoJ69LZEbEbKXZ/mKqGpZLkQjOnc/aUsKdGbX
 2JsVaRimAFujzJYDOncRopek6eyxgGqhE6TBxHt7YAYPFF/YZ8Hig6Tr7PZ13F+09G+QGUXd+hN
 P7xMKQfYUGJbbvgffszHP7kvBpPSYut0FhBVPC4kzhRk1km0
X-Received: by 2002:a05:7300:ec97:b0:359:8492:20ff with SMTP id
 5a478bee46e88-36a4240193fmr3784978eec.12.1793375016603; 
 Fri, 30 Oct 2026 08:43:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm9620706eec.22.2026.10.30.08.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:43:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/3] tests/qtest: increase ASPEED SMC timeout to 720 second
Date: Fri, 30 Oct 2026 23:43:16 +0800
Message-ID: <20261030154317.1807-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030154317.1807-1-luoyonggang@gmail.com>
References: <20261030154317.1807-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132d.google.com
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6c710f8d1bd..b9de0872833 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'ahci-test': 150,
-  'aspeed_smc-test': 360,
+  'aspeed_smc-test': 720,
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
-- 
2.55.0.windows.3


