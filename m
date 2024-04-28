Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB1C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yYF-0004Cy-I6; Sun, 28 Apr 2024 03:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yY7-0003VM-Fg
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:02:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yY3-0005V8-N5
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:02:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso3137175b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287726; x=1714892526;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSwN7T4THBSw8DVoEdw6sbR9jhN10SDsiob3Jp9LpFY=;
 b=ZcC3DykVdDM1IWia13du2Kx/bDvcgA1GbPRSL6r5kocM4wKVhbl4OjZcccitucSvuo
 j5L2+vjjmlCqRyNnOc44Nz5pvc0Mw8ySjRZCzwVowNi3sTE9Q7+9dNBSGxmpPj28XSfu
 h/W513v9B/ifs2Yx2d8mMLUd/FQ7lYr5SL/LjsiJSzCVF2rpmBbinU7NXmDHKNFn14ey
 lyfb/8+JINN0tccso3ABN38DbvzLIzgS+RRmTAa1JW/9ooMNDUn2qJ35+UXoog8YB4zH
 z6Gz9ZPjoO/NZL1DAmCX759mGwtXIzJCcLH3h/fAhcx0irTSlpWhmmh6GOTSvgEBvMZC
 qC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287726; x=1714892526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSwN7T4THBSw8DVoEdw6sbR9jhN10SDsiob3Jp9LpFY=;
 b=j802R77wKd7VTqRMKd/IgHFnfkOYJrV26ecOQeIht/rVOojgcRfM9Rp03BRf+3j2Km
 GRp5HPX5bMmDSTignicYkUy0V+q+OkfZBUySMwB41DMo8WpIgfi/QL57a5qn1fbfQ1YL
 b4ptB8oGQqZm2+tqekRdqTNgdfh5vBQBP9Nmwpo78Bs3KAergwwYQCZI1PTDFQUhiRS1
 ygvv94omqObWoBwFAoHkknablJxJ9LawxnAM5Zvl6G20ABXkpZqiT22AyxtRl+7BbMui
 ShGFcuXXP2sDv3NYaTyqjqjOR1evxeN6N4tSl0Lt05Vb7zgik1J4fR1IeMGWKLh3T4v+
 B06g==
X-Gm-Message-State: AOJu0Yzc/qaa47dyP5aITOZ7GwgZZTGLx1GU0jnHoKqae44JudUFMTgk
 3EIf/2P9SM/vyCwFhBY3U3rihJJdQm2ito5XOyfRYkfsWNZPgAn7h6a1nj3c13w=
X-Google-Smtp-Source: AGHT+IHYKy8dYYp459cczsrpJg9WUwOUgeZUKMmSV7L+U7cF2aaC9p1YxKdMnCqsOeuj1m1Gc+Hkyw==
X-Received: by 2002:a05:6a20:4f16:b0:1ad:82c4:917f with SMTP id
 gi22-20020a056a204f1600b001ad82c4917fmr6539524pzb.33.1714287726259; 
 Sun, 28 Apr 2024 00:02:06 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 fc20-20020a056a002e1400b006f3e9bdf393sm2572760pfb.8.2024.04.28.00.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:02:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:01:01 +0900
Subject: [PATCH v10 18/18] ebpf: Add a separate target for skeleton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-18-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This generalizes the rule to generate the skeleton and allows to add
another.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/Makefile.ebpf | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/ebpf/Makefile.ebpf b/tools/ebpf/Makefile.ebpf
index 3391e7ce0898..572ca5987ae6 100755
--- a/tools/ebpf/Makefile.ebpf
+++ b/tools/ebpf/Makefile.ebpf
@@ -1,23 +1,24 @@
-OBJS = rss.bpf.o
+SKELETONS = rss.bpf.skeleton.h
 
 LLVM_STRIP ?= llvm-strip
 CLANG ?= clang
 INC_FLAGS = `$(CLANG) -print-file-name=include`
 EXTRA_CFLAGS ?= -O2 -g -target bpf
 
-all: $(OBJS)
+all: $(SKELETONS)
 
 .PHONY: clean
 
 clean:
-	rm -f $(OBJS)
-	rm -f rss.bpf.skeleton.h
+	rm -f $(SKELETONS) $(SKELETONS:%.skeleton.h=%.o)
 
-$(OBJS):  %.o:%.c
+%.o: %.c
 	$(CLANG) $(INC_FLAGS) \
                 -D__KERNEL__ -D__ASM_SYSREG_H \
                 -I../include $(LINUXINCLUDE) \
                 $(EXTRA_CFLAGS) -c $< -o $@
 	$(LLVM_STRIP) -g $@
-	bpftool gen skeleton rss.bpf.o > rss.bpf.skeleton.h
-	cp rss.bpf.skeleton.h ../../ebpf/
+
+%.skeleton.h: %.o
+	bpftool gen skeleton $< > $@
+	cp $@ ../../ebpf/

-- 
2.44.0


