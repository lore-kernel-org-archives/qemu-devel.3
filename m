Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384AAF3382D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2R27-0001o7-7P; Tue, 17 Mar 2026 05:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R23-0001nO-Mb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R22-00043i-6c
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso28776845e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773740889; x=1774345689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVwcDllVF+PIsQQDJxzoY8CPdJKMLwF1VpkJA51D9D0=;
 b=I4kC1jFW6yHN0b6FQOgu8Ab0yfYTc/ybfbg9DznE2nEZRnkAVkVANE20tVNAeKjW2J
 lZQLOMSREpVgJNE3mxKddkr2mDXQtVljGQvGm65ISCWT1AvyBpn4qYQlODzxTB0gBdTN
 Jt6xf1BpcqgOBxynQDqoQGR5NZ7rk0NBV35XQ3CGup715p8b3wtz/XW2oQatLreh8wau
 pk6Z0e903x2Qu9eEVzGFlrlIG6CB0GJ1jh/pr6isUEuapAuRMyQlibUw+VI+QX+xglri
 4IFrlCWLY7Y6kM196LHI8L3rWzuZO4OFaBlaA7XV+F1hX6/1Ay7OQJDs+n2fClEQ4Ecd
 dAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740889; x=1774345689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IVwcDllVF+PIsQQDJxzoY8CPdJKMLwF1VpkJA51D9D0=;
 b=T59gCujUMJcsgfkJAvAZlxaMWftUj2gjuFNJRsi1y35ur8XdHyFQCklBjdJtt2Yhmv
 USFlEypsiKoZvzFOeMBYqoHNumHQtT8MJ2GsP94v9lbeL/1KRXAp5rCD6aQZvwfb0zx7
 YML0Z6Q6kpTD7exw58bwVSN6a0zun+FWoiASjUCeuIu27dP+sqbALaSH4No6RXWKY6Q2
 pWNp/ixrtTSQQpNxlpW1fpXAe++x+tjC72FYDt+/JdVAtJYOZjlNcoNWpN/S4FGB2ppR
 qp+ggUtgjyVro/pvINxcTHHVFNQx7X9iY62YwuJ7Jb50hZ5Ti1CM55x8QFs+phmehbRC
 lq9w==
X-Gm-Message-State: AOJu0YxmSHBgUOCvfdoWAX+2zHhpsgDEy/2CadkX1upf7pG8kuecQpYS
 OfXHLxlf5qeWu9yb3UimuosmCE24LLQ0QWrdGJZtaxDrof3ZzHbS1f0ePo+N6H8ZjNbb5dgIQo2
 Jf7ek
X-Gm-Gg: ATEYQzydEsZxDl+CH7CFvTTs5WrvpR5DeCV41WJ10W0qP2Bb8JIoCYVK+Dkm2gFIpVs
 rajHygrWlvfbigcFEwCJSjdl2GnbeHTg8B/n9Ht+m2p4HoMuglaetnR+r+cQmPuzlTUyx2I1x4Z
 XVGrJUdmMJQ3urbuZkrou/FzEmc6pebCv40up7tPg4vGU/u5v+1yPbpb724NXV2x/dLR+LqbtKp
 5xBxS286UTiw8jom8kXYqahSQnQTrhncgSk2P2Zh7XyNEvjv7oX5eo6787q8q4i+dLsZgo3rsZ6
 wXgh53zdYu5ddn4Mfk6amJ0riojHfGxfrasU7Fhu2mEjZUIm52d22h2oV0i5KWbKQJydArOdlqG
 ZcWvGCfyqmv8jE1W5+sEM2jwBSrBu74Sm3tZQR7ih/pvziVEDASELQqIIUrYMEXBWi06b/CL5lZ
 T72fpOnVufFLhYMFxNaBpupRjORMxJ2qauB3ZG0zQsUdwCqHu6NduIGJSbFH6ErjLNSqBM5Tc8m
 KK4FKRKs3JFT0JJmSH8fks7byr4lAw=
X-Received: by 2002:a05:600c:1395:b0:485:3026:2b8b with SMTP id
 5b1f17b1804b1-4855670607emr263158695e9.29.1773740888501; 
 Tue, 17 Mar 2026 02:48:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea98070sm54329075e9.6.2026.03.17.02.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:48:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 1/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
Date: Tue, 17 Mar 2026 09:48:04 +0000
Message-ID: <20260317094806.1944053-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317094806.1944053-1-peter.maydell@linaro.org>
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The fsfreeze-hook script starts with #!/bin/sh, but it uses
several bash-specific constructs, resulting in misbehaviour
on guest systems where /bin/sh is some other POSIX shell.

Fix the simple ones reported by shellcheck:

In scripts/qemu-guest-agent/fsfreeze-hook line 27:
touch "$LOGFILE" &>/dev/null || USE_SYSLOG=1
                 ^---------^ SC3020 (warning): In POSIX sh, &> is undefined.

In scripts/qemu-guest-agent/fsfreeze-hook line 31:
    local message="$1"
    ^-----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

In scripts/qemu-guest-agent/fsfreeze-hook line 46:
    log_message "Executing $file $@"
                                 ^-- SC2145 (error): Argument mixes string and array. Use * or separate argument.

In scripts/qemu-guest-agent/fsfreeze-hook line 55:
    if [ $STATUS -ne 0 ]; then
         ^-----^ SC2086 (info): Double quote to prevent globbing and word splitting.

There is also a use of PIPESTATUS that is more complex to fix;
that will be dealt with in a separate commit.

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 5b915af017..6e2d7588af 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -24,15 +24,14 @@ USE_SYSLOG=0
 # if log file is not writable, fallback to syslog
 [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
 # try to update log file and fallback to syslog if it fails
-touch "$LOGFILE" &>/dev/null || USE_SYSLOG=1
+touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1
 
 # Ensure the log file is writable, fallback to syslog if not
 log_message() {
-    local message="$1"
     if [ "$USE_SYSLOG" -eq 0 ]; then
-        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
+        printf "%s: %s\n" "$(date)" "$1" >>"$LOGFILE"
     else
-        logger -t qemu-ga-freeze-hook "$message"
+        logger -t qemu-ga-freeze-hook "$1"
     fi
 }
 
@@ -43,7 +42,7 @@ for file in "$FSFREEZE_D"/* ; do
     is_ignored_file "$file" && continue
     [ -x "$file" ] || continue
 
-    log_message "Executing $file $@"
+    log_message "Executing $file $*"
     if [ "$USE_SYSLOG" -eq 0 ]; then
         "$file" "$@" >>"$LOGFILE" 2>&1
         STATUS=$?
@@ -52,7 +51,7 @@ for file in "$FSFREEZE_D"/* ; do
         STATUS=${PIPESTATUS[0]}
     fi
 
-    if [ $STATUS -ne 0 ]; then
+    if [ "$STATUS" -ne 0 ]; then
         log_message "Error: $file finished with status=$STATUS"
     else
         log_message "$file finished successfully"
-- 
2.43.0


