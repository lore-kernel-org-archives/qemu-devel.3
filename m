Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D94C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbO-0007d0-Vx; Tue, 15 Sep 2026 16:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZs-0006vs-HR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:32 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZp-0003Kd-2h
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:28 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso1685885e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503373; x=1790108173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5jEk54sCARbNqwEALWIYvVVIO6zgDvVb82j7zjwYhno=;
 b=S8CbPDXpZkAGBaBC6qj/UbjJQOvqXQcONDZrn35ojDZYHV5ZqfnlfvQaaeKagyuNij
 OqIIGPI9fWENh2F+uj3RIW3M465CRv46F5fDZVccuFaepLGH68T01Kr1bPcIU4PoYhgv
 og4tH917QBIkedIG1QT/xypUd3v08ZvBqOlhBli+aQrZnSs/x+g1NiR/51/2O9WxS9ox
 bfeMrURjr2XcladcNq35LqGO/7NuLV+WG5eCFQ+Wq5V+ezDV6tyMupm4RMwcye8wjzqq
 z8C72x/Xy/k8W6XkfQpLDtf+g5TLVSjhDaRs+Zjp7xq6DnnY1OmBicT5zeM6Jm1ZacWS
 OUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503373; x=1790108173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5jEk54sCARbNqwEALWIYvVVIO6zgDvVb82j7zjwYhno=;
 b=iXrOveinH56HfiVFYk499O5ld94r3dUc5UWUZ3Q1HBdZA1anT8E7XlZUgcGrt4maJ0
 EBz0GWeB3pM9q1tMU1JiEEZ+3Sduw7VRA/QmQzJ2gxSTbhKoIKdgeLytrRYkMqzRk811
 7/d62D+5pPUs0zDDTqW7oxogPNju6EEzmVuKaFfXVckCjQJBPFDMc9GL6PVmulZxkvP4
 p+cb+sX9bWphwTUERXoquG3fv6/6pWIMGHZXcLeitfnouytRhrjUPPjAt5a/MF5OCH+7
 T3ICXxDVuzNUjt7rGOLpJSb60A/qqAkHPr7723wkfk4uwQUGCxuUzs0I3iRUQ/va4kd1
 KFpA==
X-Gm-Message-State: AFuF++kpQ4apxBi25Fj3qsJZgBOs7qqF6SstOgLQ5h5Ost9jHw8J6IF9
 DITzP8DB5c38WIgZ1E85gGpwT/0GU7Tc4o7IYnC8UVisOXwr4FVHbwi23T7YAYHIF3g=
X-Gm-Gg: AYBFou1DQ4UyxpQb3alvsdxstB/MoHxZutAANGK0j/525SR8myGStSiDXhAGLZcZj3r
 QklB+OlC56Gg+VezFtT41Q3jZzyLf8C4Exz8bD1T0q8MqS9uUAju+PlZuhc+fA3j2xUpHSQU7WO
 IVNcCjP+gFf1y47n8uqZIH9SX9zhh9WKEEKmTBTPxDVZWp+hff80gmcSpwiMvvf38c5UH5CtOdN
 QrGqmXj4ba1+T665LpJCiJnfVP2BfZ+lz4V4q02qdnh7zwHcUkZsdExJ6831S9i0afb10qgQcXh
 NJ+eSOmRIVB25CdUH2yrvr42BMLV91m8EdwlXMJJPBciIflq6AUyG1noxYegOXClHtN0BcfnSwL
 0HbtRca+1sbflkg65X0YgiHHPSutBQeSkWqE2pQGRoKZnoQUy7atwKiBIYPnU8WT8G616v1rqGn
 etGx1cWRt2WAukMSTR3NR5HHWtl35KOtBwLQir7qfbQtFPrAJyYZRm87LmO7xk27Cik0yexZY=
X-Received: by 2002:a05:600c:3545:b0:49c:fa20:cc04 with SMTP id
 5b1f17b1804b1-49e7a679271mr94888725e9.27.1789503373210; 
 Tue, 15 Sep 2026 13:16:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da071asm16260275e9.8.2026.09.15.13.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B89361971;
 Tue, 15 Sep 2026 21:16:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 15/15] gitlab: update the @user id mapping file
Date: Tue, 15 Sep 2026 21:16:00 +0100
Message-ID: <20260915201601.1207839-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


