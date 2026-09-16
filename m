Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED360C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ri3-0001q8-Fw; Wed, 16 Sep 2026 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ri2-0001pL-3i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:38:06 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ri0-0003OV-CJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:38:05 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso512716f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789573083; x=1790177883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5jEk54sCARbNqwEALWIYvVVIO6zgDvVb82j7zjwYhno=;
 b=bYjPk9B0VadSzPiPiGo3DOYbdzKkR9k0rviM17ygVY8ROos0Rz2+y4iCE7IV/7hjdx
 YuVFl+JEql+QmRXHAoYr0GlWCpNHyoKa6/v4bm+EJ668HkfhXpMaTaueoTWtUgKmg70b
 DRWoLeb9HoydIOU8QY/L69uRu6UU7ZJcWYJs9Ja+6VoSwiT2Ksawa2d2/pwmf/HSdNw+
 6y9jVQYwFOof5RtO2Uqz5SxCSOCH0rkuS9lN8GU1y/ut8do8BpivuNkI4ERI+22kh5ga
 oVZUL2ZqN0APwbAL/SRirv52sAvjWCEA7OqcL3zJJxhSLa3tDQnzUuh9Y7WxLRjAhP1V
 MGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573083; x=1790177883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5jEk54sCARbNqwEALWIYvVVIO6zgDvVb82j7zjwYhno=;
 b=dN8BI1f+J1SprG0+R566xzQ3I+7CBVSSZIiVuyTp0O0/J3QLKT40gjrQejKOsTg2Xe
 9iuQAcIDH/ybHqQj72r7DXHaXg8meOoSk6LyuQGzeNsBoQJDYHBZ5b9iodvbq4fRWZJ4
 mqKCfKmSonEoqrrUzUgRsVuTIq+ZANzUXFJO1+/71hmPDZynXpaerY7321fGzaiA+b52
 /MicvQOuC+sO9dVCb3kQ+g4jeBHPFNFq4WUxwFxxYfUvwMtfhg1r+KYdcjxbtvG9AVAS
 1neoNSuZ7Tl5kDNRjkr4ITs6j/tVy527ZpZKYkGgNc65lb3LHeK5JjMhz8XVe7n92gaE
 1VAg==
X-Gm-Message-State: AFuF++n/YuWWhyOpYxfeFimZ0ziZ1Z5w8jyC9zfxJ6tNvbdQHbxz6AoL
 UO8lgiw4lzAu3UQdk1e2P13umjy2rBu+KXYkS2shKf5g+WknpJCkuBSqJvkgVvtJsoY=
X-Gm-Gg: AYBFou0Xa4cEA6VO+/Tufk4Oo+cmbFcAidWAtrLyND+S+o1GlrvLOwmYvcyGNoxdAst
 +TzUq371weT3KgM+DBVFAFdh8FdBSEyz7edNTQS/7HNucp01A1t/+gTqFZ9f6FG8GMdvHgDm8v6
 k8GQWd0QdlIzweBuO9I/CGeJdgkf6rSZtxxHthV2SlDpPUYryCCldNDgdrVbpWVPgfwZlFTMBl+
 PL8Jv2NU4n4EZNwKuW+7D8OYF31XBMMuuU+M+qgRbZw46dv+2QE2KS8Z/Ny+4df7lQ/h0EeXMhF
 ROqJb18scKrxvGCLee5dxdzSMfyiqeZAZdaDq2b7Ylo13BSzkMJlGxQ1RloNC4vN3Jj1EpwqEx7
 f/qh7EmeHqCo8tYHIBuu6mnuOEGzL7kseUbXHPCLBe0bDIvlaFsI2UCwbgAkrDG4BdcUN51TfXe
 xvfNhpctqBml9VlwiA+Z0a/xfxbuZHWnFOhbNImSPpzvGkg7zi5XtJfY9DW+gntEIPbPajsmw=
X-Received: by 2002:a5d:64e7:0:b0:485:8c16:a355 with SMTP id
 ffacd0b85a97d-4870d27897emr4244038f8f.45.1789573082519; 
 Wed, 16 Sep 2026 08:38:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27a36sm7600519f8f.17.2026.09.16.08.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:37:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC06961A5B;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 16/19] gitlab: update the @user id mapping file
Date: Wed, 16 Sep 2026 16:30:09 +0100
Message-ID: <20260916153013.2134555-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

I needed to fix a POSIX-ism in the script as well.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260914184534.706637-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-map-auto          | 8 +++++---
 scripts/gitlab-map-update | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/.gitlab-map-auto b/.gitlab-map-auto
index 28ce448f1bf..3f717a15d4e 100644
--- a/.gitlab-map-auto
+++ b/.gitlab-map-auto
@@ -12,11 +12,12 @@ a1xndr	Alexander Bulekov
 adi-g15-ibm	Aditya Gupta
 agraf	Alexander Graf
 alex.williamson	Alex Williamson
-aliang1	Aihua Liang
 alistair23	Alistair Francis
+amachhiw	Amit Machhiwal
 anisinha	Ani Sinha
 anthony-linaro	Anthony Roberts
 anthonyper	Anthony PERARD
+aroxell	Anders Roxell
 berrange	Daniel P. Berrangé
 birkelund	Klaus Jensen
 bonzini	Paolo Bonzini
@@ -36,10 +37,10 @@ dwmw2	David Woodhouse
 eauger1	Eric Auger
 ebblake	Eric Blake
 edgar.iglesias	Edgar E. Iglesias
+efarman	Eric Farman
 ehabkost	Eduardo Habkost
 eldondev	Eldon
 epilys	Manos Pitsidianakis
-famzheng	Fam Zheng
 farosas	Fabiano Rosas
 gautammenghani	Gautam Menghani
 gkurz	Greg Kurz
@@ -51,7 +52,6 @@ imammedo	Igor Mammedov
 jasowang	Jason Wang
 jmacarthur	Jim MacArthur
 jsnow	John Snow
-juan.quintela	Juan Quintela
 kbastian-qemu	Bastian Koppelmann
 kmwolf	Kevin Wolf
 kostyanf14	Kostiantyn Kostiuk
@@ -67,6 +67,7 @@ mauromatteo.cascella	Mauro Matteo Cascella
 mcayland	Mark Cave-Ayland
 mdroth	Michael Roth
 mediouni-m	M. Mediouni
+mjrosato	Matthew Rosato
 mjt0k	Michael Tokarev
 mstredhat	MST
 npiggin	npiggin
@@ -79,6 +80,7 @@ pipo.sk	Peter Krempa
 pkrempa	Peter Krempa (work)
 pm215	Peter Maydell
 qemu-janitor	Qemu Janitor
+raphael.s.norwitz	Raphael Norwitz
 rathc	Chinmay Rath
 rth7680	Richard Henderson
 schoenebeck	Christian Schoenebeck
diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
index c134c226aa2..743ad11900d 100755
--- a/scripts/gitlab-map-update
+++ b/scripts/gitlab-map-update
@@ -33,7 +33,7 @@ glab api --paginate /projects/qemu-project%2fqemu/members | \
     .gitlab-map-auto.tmp
 test $? != 0 && fail=1
 
-if test $fail == 0
+if test $fail -eq 0
 then
   grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
   LC_ALL=C sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
-- 
2.47.3


