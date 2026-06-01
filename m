Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141F6CD6E64
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3g2-0007gP-6L; Mon, 01 Jun 2026 10:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3g0-0007eq-Gv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3fx-0005v2-KM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so1370393f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780324292; x=1780929092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NT18CePaV0fGVJXLvh+q22hGG/t8aNhHu8KRmvW+bGo=;
 b=cYBlZgB5XqPjpZeaB9wl7egI9T976zBq3Hvd9RDN3diEvmoYmFdBETJLsHQzG3FLgp
 /wn6wA4XSl8jeYVCtbtcqqYHRn4MahdhlzIOXiG+vdP2MDeWF61cAjDJOyDSwqmbcV3b
 G0ILRB3sSB6ars/jzJtIEAtJq9sW7lVnAUAEPQ6ilthRTH2mgNljtIp02xNF1v6grXKC
 d8VvuYZJYPq/I3AgiaybM8HES4dE9gPoWYTwDwV2HQQqUE9U/NSWgl8dr8s7ri1DEvS3
 gNfPKN6b8zSf0iCYvVCkIJSuhV/x0U7l3vk2vePyD0OHunkSA9pEAyx/jOAb+ydRPx4h
 72Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324292; x=1780929092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NT18CePaV0fGVJXLvh+q22hGG/t8aNhHu8KRmvW+bGo=;
 b=sPlyqr0VxtRMzyAvmYdhHJnK0adk2RpU6mi+80WS0anbAE4N95q2ukiEgGywpRxqb0
 KVAo5rE91SyVQwqJ/1w1aCwyVTsd+rL8tdQwjmLhiZCdQi1K8HPQa9negvRHZAARTaTV
 9j1SEDHovBG8q9rgJo54KE8Xmk2252TPHZZxAL098BVxi5VmuosYCYGqJ6u8tJDzyXhj
 bH0jJsyp2oMrYlXUAx3+qokmpIE7hefVKPnVOYdCjnWEfZ+IDJmz3bCJmU0/cKx2+r7I
 RuZjYMbm8cKA2ZiMdDJaNG5kRr3RL500HRPSvmKednNC3vm35PbgvT7fkWpTgxLruj5w
 +FUQ==
X-Gm-Message-State: AOJu0YzR5tYjwtInvs4GC3Mbk5ut7WiXpPIRYmnwSGZmkAL3Fw4oTmBq
 m1TFH6GAPhwrVHwPkywqHVOhtYJBPq357fCuFS12Wdg29ILHzql6RA+Fbo4Z+EASvVs=
X-Gm-Gg: Acq92OGYyYzCIjEs6Us2CSKpcDyZxg8buuibzpCaPYhKdzuY0kHrO9KtKqtaLnF1o+3
 roUzF/Pr6M3F9QmAR8B0A5ojEHDYaNyY3xLxXfbkumK1iC5Cb1bOtrzPVD/Uwnzo3iXSyyVagWi
 NW8z0+AweKIRcDEPSrKkzYHowD+etWcjLs8SVCjymmJ1mqA29lXl0LQ5H7l1fvUDeMLoNCSJSzI
 kZnDt4OklfiDF/dhQTaZIyRrsUyhuQv8t91TAtUQFe6+AL6YbQpHvt9A+Yx89uUQBgD9jC+GJGZ
 cBZhgJes7SuxOuESrd2O2dfCXMTTUkbg2D+XDVWXW3rcBoMSkjlFUU5Gb4iZKglMy5qmkxs94QF
 K86AkkxB0VY6GJtIIPeUwcMxJ/6qCSON6SKa3Q7vSbw+jffBiqpLxawd7VqAwdEf08Np3dhTqsX
 sJmy071niHrW8By3qtRQLEi+5lKdbhsC/r2Q==
X-Received: by 2002:a5d:55c2:0:b0:44a:247e:67b1 with SMTP id
 ffacd0b85a97d-45ef6b025a3mr15719859f8f.5.1780324292031; 
 Mon, 01 Jun 2026 07:31:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3595ef4sm24594620f8f.37.2026.06.01.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:31:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC9215F8BB;
 Mon, 01 Jun 2026 15:31:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/3] Revert "Makefile: include tests/Makefile.include before
 ninja calculation"
Date: Mon,  1 Jun 2026 15:31:27 +0100
Message-ID: <20260601143129.144786-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601143129.144786-1-alex.bennee@linaro.org>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

This reverts commit fd63125b9089610d63a53c11ff2fda6b53a2265d which
broke the ability to run the check-functional-FOO series of tests.

We will need to try something else for the MacOS builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 829c51e364c..54547a37b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -45,8 +45,6 @@ include config-host.mak
 include Makefile.prereqs
 Makefile.prereqs: config-host.mak
 
-include $(SRC_PATH)/tests/Makefile.include
-
 # 0. ensure the build tree is okay
 
 # Check that we're not trying to do an out-of-tree build from
@@ -182,6 +180,8 @@ endif # config-host.mak does not exist
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
+include $(SRC_PATH)/tests/Makefile.include
+
 all: recurse-all
 
 SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
-- 
2.47.3


