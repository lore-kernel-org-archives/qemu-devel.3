Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C88CC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsG-0008Fu-PQ; Tue, 20 Feb 2024 03:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsE-0008Ez-N6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:10 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsC-00088m-Sh
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:10 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3e72ec566aso254662966b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419187; x=1709023987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8GBZt3ozw77G1fOSzxE1Z5aQQqqOuC8odoQdK5akbI=;
 b=DDMoM7ok28dnMBkW6/70YnCl19p6LbKxJIYxjiWjr0Sf9aD8RAID8UATfJf27pdZHR
 Y0FWzyNLOuYSOdSSwmZSlgV2jdatpy8mElb6KrxN10S/cZUhI8Qfy6QubKbO7ZszsSxc
 xT9TIoTF6f9Rf97Pmbh3zyUn91JRcZ3Fex8S5m6FEGltHaC3YBQ1yRph0WlpYqPvTWja
 NhRSYZYR44xaLIulKsB3Rpp4B3oG9PhzlVXb7IIemqD55k1lmJOEVRF30xaR1aQ6dyAA
 mV/+J9l/e9lfklSq9CjJd31sDRXZGZuwYr36M7RVo2C+0utXQBzGJXQzzAS/uW05jYzo
 AgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419187; x=1709023987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8GBZt3ozw77G1fOSzxE1Z5aQQqqOuC8odoQdK5akbI=;
 b=q2EEjzufjJEMGqxFrSOdolYou3i9nH8HC6Xd/UPgabnEZnhW6eo78Oiu6mT++njuB6
 VOI7FVqNMclBc6LbB82tqYLTcH3fYjAH5VWMh4WCkhLpMRCU+39SKadIUah3wBN36LYT
 KUw3zrhR6N5c5L5mwlvw3oqYnsCp2NPgBo5xYvtpzz7nzvCeeDPVIDkKsBv8RZckFStA
 W6+qtQn4BHh1eXsxck905OTnElpo+r8bd2yjT10p+ISkA0JHk80JmdpOGVhvzpEBpiQl
 OjjMunGnm0h+LAw/nH1hx+D2Xxl7aZBPRefM8dg1csBBveABcMvDmdoRtbKggZ1k5ifS
 TGrw==
X-Gm-Message-State: AOJu0YwV77JiWG10JK/7AimWi/Fe8APuYXWBAngdVekGpY3xlc8ZsG5f
 1jCHUWBuc/Mae5hmei/qZlrVIdEuksG7SIMU0ZPdSqWCncWxkfgFw4t+1+sjVhTdxSYq4JktKn7
 DJO0=
X-Google-Smtp-Source: AGHT+IHti0ycLwWCC1yhqUuW30/Tu+yGZUdVgGPxlPgeXFevd2RHJfIEBbhY/hZp9Z7sGgVI1UwNcA==
X-Received: by 2002:a17:906:35cf:b0:a3e:b7f6:f173 with SMTP id
 p15-20020a17090635cf00b00a3eb7f6f173mr2630587ejb.74.1708419187000; 
 Tue, 20 Feb 2024 00:53:07 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:06 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,
 "Canokeys.org" <contact@canokeys.org>
Subject: [PATCH v1 01/21] docs: correct typos
Date: Tue, 20 Feb 2024 10:52:08 +0200
Message-Id: <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/ci-jobs.rst.inc      | 2 +-
 docs/devel/docs.rst             | 2 +-
 docs/devel/testing.rst          | 2 +-
 docs/interop/prl-xml.txt        | 2 +-
 docs/interop/vhost-user.rst     | 2 +-
 docs/system/devices/canokey.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index 4c39cdb2d9..6678b4f4ef 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -147,7 +147,7 @@ Set this variable to 1 to create the pipelines, but leave all
 the jobs to be manually started from the UI
 
 Set this variable to 2 to create the pipelines and run all
-the jobs immediately, as was historicaly behaviour
+the jobs immediately, as was historically behaviour
 
 QEMU_CI_AVOCADO_TESTING
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index 50ff0d67f8..a7768b5311 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -21,7 +21,7 @@ are processed in two ways:
 
 The syntax of these ``.hx`` files is simple. It is broadly an
 alternation of C code put into the C output and rST format text
-put into the documention. A few special directives are recognised;
+put into the documentation. A few special directives are recognised;
 these are all-caps and must be at the beginning of the line.
 
 ``HXCOMM`` is the comment marker. The line, including any arbitrary
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd132306c1..aa96eacec5 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -728,7 +728,7 @@ For example to setup the HPPA ports builds of Debian::
     EXECUTABLE=(pwd)/qemu-hppa V=1
 
 The ``DEB_`` variables are substitutions used by
-``debian-boostrap.pre`` which is called to do the initial debootstrap
+``debian-bootstrap.pre`` which is called to do the initial debootstrap
 of the rootfs before it is copied into the container. The second stage
 is run as part of the build. The final image will be tagged as
 ``qemu/debian-sid-hppa``.
diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
index 7031f8752c..cf9b3fba26 100644
--- a/docs/interop/prl-xml.txt
+++ b/docs/interop/prl-xml.txt
@@ -122,7 +122,7 @@ Each Image element has following child elements:
     * Type - image type of the element. It can be:
              "Plain" for raw files.
              "Compressed" for expanding disks.
-    * File - path to image file. Path can be relative to DiskDecriptor.xml or
+    * File - path to image file. Path can be relative to DiskDescriptor.xml or
              absolute.
 
 == Snapshots element ==
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ad6e142f23..d1ed39dfa0 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -989,7 +989,7 @@ When reconnecting:
 
    #. If ``d.flags`` is not equal to the calculated flags value (means
       back-end has submitted the buffer to guest driver before crash, so
-      it has to commit the in-progres update), set ``old_free_head``,
+      it has to commit the in-progress update), set ``old_free_head``,
       ``old_used_idx``, ``old_used_wrap_counter`` to ``free_head``,
       ``used_idx``, ``used_wrap_counter``
 
diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
index cfa6186e48..7f3664963f 100644
--- a/docs/system/devices/canokey.rst
+++ b/docs/system/devices/canokey.rst
@@ -14,7 +14,7 @@ CanoKey [1]_ is an open-source secure key with supports of
 All these platform-independent features are in canokey-core [3]_.
 
 For different platforms, CanoKey has different implementations,
-including both hardware implementions and virtual cards:
+including both hardware implementations and virtual cards:
 
 * CanoKey STM32 [4]_
 * CanoKey Pigeon [5]_
-- 
γαῖα πυρί μιχθήτω


