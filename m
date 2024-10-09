Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4061CEE336
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syamO-0005Xa-Ik; Wed, 09 Oct 2024 13:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamH-0005WE-4e
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamF-0003KP-I9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c5b954c359so8179739a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728496029; x=1729100829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1moFj93Y1ZoSXpMR1pbmEnoefXvbMoch/laHzozeBsU=;
 b=CoB3aeV2ZoBT6fuazOmR/KYbucJ4dibPqa4qJgKC8FG/pY8CuKWqttecIjgHO4TdL4
 5wqDMA/FcBm/rLk8i/Ip1nVqfQ8P79AiVwAF9q/2dfY4gt9BIZD6tRfbU24MeSOTqm39
 5ZGLw9sA0WWzo4ewwkFCl/ys6C0cPpW5UiN0yJk7iuScDpFqw53gZlbMub7zym3gqL08
 /9OWam9/zSX3e29Lxr3nE9y7tU09ZFqrl6sboNY9SBhGmj/psY47K0V6RmSYy8Eu/vvP
 n0/WcQQbcYcwZy3ByBAmz8QGZrHjnmrpKNDEwy8vDWVRg5lHO3rl5thpkCr2XAQyXceP
 qbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496029; x=1729100829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1moFj93Y1ZoSXpMR1pbmEnoefXvbMoch/laHzozeBsU=;
 b=rF68Ayltn34mp2fvur1Ps0wg6DFF/IA4UR9szGI9DaQlsYfxLR4X46hNX6PqqvX8KP
 RtfYorKjfvUau3nUclhx8tse2/IqpfZkMKbjC/W9EFJ67aXEJiDBIVpk7Ie/V1tL6Bze
 vSR8vBeWSV8JW3ozSoqPfT4sh5PBiLmqU1S59GDkEKYADUxlWJd2eal/vlCKajGeTZEG
 alrznqzaV0mF3m02pDAJhi0c5Dfrdkj6GERBhAvlhTIoB+GM9y+TCVW5VAHaexMKqyy0
 G1lgcwYv4nrI4kVm0sbG/gOzLWlFukujO0cuc3p4JaH8PBISH4S8tcqhEOiRnW7f7Q8U
 asLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTnTTt0S/5jT1ITyHXWuYtnCrcHh97UjjRC6mv71FtUR//ywDIGfOG8JZYje+lU3LG3isgKvGtV+T8@nongnu.org
X-Gm-Message-State: AOJu0YzHVPVKa8/ztIyjbynmV1tKCJVnkqAs4iuJIJt5Y/n99BTbRtS7
 gbvJp/Vi3b8dR4ng0c5DKhRbInlr7/d+bSsSpL09ZLrX42ZBEihR
X-Google-Smtp-Source: AGHT+IGsbIpuugdCUjBKn7XQe060PLaJNNf1aeaLnDH5pyp80Rlg1/Lx2lTMaJtDDpCCSEd3YDlyqQ==
X-Received: by 2002:a17:906:794e:b0:a99:4e35:9a25 with SMTP id
 a640c23a62f3a-a998d31be57mr262229866b.44.1728496028672; 
 Wed, 09 Oct 2024 10:47:08 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994f38068fsm491667666b.40.2024.10.09.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:47:08 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] chardev/char: introduce `mux-be-id=ID` option and
 _MUX_BE type
Date: Wed,  9 Oct 2024 19:45:13 +0200
Message-Id: <20241009174517.286935-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009174517.286935-1-r.peniaev@gmail.com>
References: <20241009174517.286935-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x532.google.com
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

Patch introduces `mux-be-id=ID` option for all chardev devices
and TYPE_CHARDEV_MUX_BE type for distinction different types
of multiplexers: frontend (current "mux" type) and backend
(new "mux-be" type). Actual attach of the chardev to the
multiplexer and mux-be implementation will follow.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c         | 3 +++
 include/chardev/char.h | 1 +
 qapi/char.json         | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index ba847b6e9eff..4b3e45b2a128 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -918,6 +918,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "mux",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "mux-be-id",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "signal",
             .type = QEMU_OPT_BOOL,
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 01df55f9e8c8..f68f949f6ebc 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX "chardev-mux"
+#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
diff --git a/qapi/char.json b/qapi/char.json
index ef58445ceec9..30748784513b 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -199,11 +199,15 @@
 # @logappend: true to append instead of truncate (default to false to
 #     truncate)
 #
+# @mux-be-id: id of the mux-be device for backend multiplexing
+#     (since: 9.2)
+#
 # Since: 2.6
 ##
 { 'struct': 'ChardevCommon',
   'data': { '*logfile': 'str',
-            '*logappend': 'bool' } }
+            '*logappend': 'bool',
+            '*mux-be-id': 'str' } }
 
 ##
 # @ChardevFile:
@@ -440,6 +444,8 @@
 #
 # @mux: Since 1.5
 #
+# @mux-be: Since 9.2
+#
 # @msmouse: Since 1.5
 #
 # @wctablet: Since 2.9
@@ -482,6 +488,7 @@
             'pty',
             'null',
             'mux',
+            'mux-be',
             'msmouse',
             'wctablet',
             { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
-- 
2.43.0


