Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF24C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMw-0006xS-4Z; Tue, 05 Mar 2024 02:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMM-0006Hy-85
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMJ-0005sv-Jz
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:09 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a0b1936400so2462888eaf.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624223; x=1710229023;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oaZOxuMruCzpX9cG/05AqpvWpWeh3L71YtF+WLnYGuQ=;
 b=D/OO7UprfeihY7W4L1cvUSN3/EnS9V9z6TFOoh5W7w0lcb7kf9zwLvOzLLeJBUZdGA
 Xv2pjAIWWtoqKaJiwxMn3iE1st3ptUTYtGKkNRPi4aUM/UVOZ3R7x0t6RV58AO98y++w
 obKs2cukktB7iyrOC3/bmaEM7rlMPZwEpB8mUq2VoWm4iWsFHJorYlMRn6KTFim/9IVI
 01jL/+yAffeDU8XGSr9MjqU6/yNRVj2na2wpmC2P3Q1dW4wiqBm6t5bXANtd7CWZFtuh
 5UzGRwiqVohIJH+NcCZPgn49FnDAM0T0Mn1h3ak2Uf51Tadg1s24H0UBtCzxAStBxLeM
 inoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624223; x=1710229023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaZOxuMruCzpX9cG/05AqpvWpWeh3L71YtF+WLnYGuQ=;
 b=CuoXE5Rxg1YTguMTieXayZEKRnkLbOfd6nM8rHerSFpy4O640DaIkCq9U9Vx602QBc
 Dsek/DVUtLBWwXO+1wwqlbWbWjJdrhSZPb4MLBXsVpKT8jY9ogishye5yYmBesMuUKnN
 a98XPuyanBH54GFAut/t1F5xCS0Tqj5ata25g1NYZXJPfnss+7b/DG0yMlDADLO9IhEX
 ejIyCXtqGgr1QbApoRWuZUz8Q5RXq9qO9QzW5k7sdrBGYHBhYuSYEERjOo76AhkzzuEK
 cRjzO53RnAqu0udSaUSsf9xnthsvJXD4SvUUoESz0Tme6W3KgPHmfJRO6g1Cdwhr5BDD
 8fPw==
X-Gm-Message-State: AOJu0YzUGpYmmR8Ek2fw9XAXiX27WKnPcXvFcyxKme4JX18hpt5I9HN6
 KIErfqu5L8hVjrvYgz4syEuI+F23EKN00RZewJyD0RUzx0KYu9KGtVBJZU70dqs3nZoMO/x8skB
 d
X-Google-Smtp-Source: AGHT+IFD5V9C+rYlvE7xfnzq62Jhok5FWGVhkrdtetfQdPkAJsCibYir0qzDD/g5wLhA4zYTdyRSCg==
X-Received: by 2002:a05:6358:7e42:b0:17b:c797:8a08 with SMTP id
 p2-20020a0563587e4200b0017bc7978a08mr1157066rwm.20.1709624222779; 
 Mon, 04 Mar 2024 23:37:02 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 i125-20020a639d83000000b005dc5129ba9dsm8564842pgd.72.2024.03.04.23.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:37:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:28 +0900
Subject: [PATCH v2 11/13] contrib/elf2dmp: Build only for little endian
 host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-11-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

elf2dmp assumes little endian host in many places.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
index 6707d43c4fa5..046569861f7a 100644
--- a/contrib/elf2dmp/meson.build
+++ b/contrib/elf2dmp/meson.build
@@ -1,4 +1,4 @@
-if curl.found()
+if curl.found() and host_machine.endian() == 'little'
   executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'), genh,
              dependencies: [glib, curl],
              install: true)

-- 
2.44.0


