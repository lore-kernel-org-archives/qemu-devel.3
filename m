Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE5CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmxp-0005If-4Q; Wed, 20 May 2026 15:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmxf-0005H0-Cc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:52:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmxd-0002mG-NX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:52:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so3861654f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779306728; x=1779911528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qa8InOu7Uw3spJrO1u5kMJVu42BjwKBtAX0lC00blUs=;
 b=a5JQFZJ9wl8yJyoDAdvYMVH5E49NVqQqqoxkXp50SXZQQI1esECd2RqEvNqWjFNKz+
 UlYzgZH/2tRqDL29zAMvWhVP3otUprrP/NyJSKDg1sFoVIcAJPv7f8kyAg9R+wfdQMrX
 btErlfkFGhBPCK9rTX5cDY2BMXxTi+Km3Tj56YrPLdopkCYJF4VhiFTgKiJBS334o6Ed
 quJ6ytsp2coyaOzKhKw7jpmU8Y3UCxLEb/MvEu500k8H20i+KCVcWmDqfmxztkrMW+aB
 g7GNUuKQpyZ++DK3OoBQf6+8tccIBzOhdCVLd0rHA/AYzjoS+YVgs6BYev3xrZ7PEHN8
 t6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779306728; x=1779911528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa8InOu7Uw3spJrO1u5kMJVu42BjwKBtAX0lC00blUs=;
 b=KpvMDEIRK51812UH4XwquRLOKwRrGRnjfhR+gjxhhSylKT21r3PQadSQ6qSg25xYs8
 JxcHt+XUehmuUInAOVn7fvryMFjF+YYjF9tCdoqxj3If6luRhtzy5dV69+1HQZYh/sX3
 PS89k2xlz9f2mA55aTlf9jbRtTNKIKd5aDSfq459sega7CMExsDWYoArfFhjAU5zXLOF
 yBelYFYM9U7NvJuNpBxpCpW+zdAFFzJt3akONKp5mv83AN7kMdVWhCr1Tzwxw3LDP8Z2
 ZmIN77zczblABPWBSMNZV/993FDIedtjLYlvRHPgC4GbaTleU1VT0w9m5ePb2kRll8sp
 BXYg==
X-Gm-Message-State: AOJu0YwIUIaYMlGEM9GUGJd922UUORkKAWo4UWxGNOWRznQLy8+KI6YV
 TBFIwaxNhDqSdASScbolMMR0s2khq2Dj4jyCW7Yl5XLfo6CSQUR/wOqEXBufraELCVDJyAizKMa
 2vrqz4Bg=
X-Gm-Gg: Acq92OE6OOvyhdEjN69/Yu8LExsj8W8YYKM6+SziLbFaM4nZWZAdpBTRDGcxPL6oPVM
 Li/8t+UaaaabL4NAcBGXTxHvBdae0G/YVK2ivyZQy0BpB+T8fzwocDu2teZ2W+Kk5BWOi7Qs5l+
 D0Ci2ApygO6t6Mvc15aT9a3gsjpUQcCm5kFv0JLwuXeN/vdRDaKdJKyns79Z94fCjlDzdgE/mpN
 BixJsxqKkDZBRsxdk+M8XbWktPJOcTL4iAfCPR8aIMCLGg5YRqEKXh5hRawb7NrH0/hiS8oZONn
 JCt7suiJ4wtY993Z+ZFlmTdAu0aedKHYq1wZddvufEeR8hoBR8s5SufjQhBSK3WKO6/fL2flP/V
 XDFCJyvkroUkBgtTIHmI1IUnpcdjoKxtCrpLAKnBr9W0pWWsa6JmfLku4FSk6DZsoYT/htwpSmK
 NnSYQm1rUjJ81633eIzv4bJiNvjr7c0mS7jA0KZGI+b+cXE9oNbceYPf7DiTJXdkr8hYqXXnuz
X-Received: by 2002:a5d:5f90:0:b0:43d:1dfe:350a with SMTP id
 ffacd0b85a97d-45e5c5bf20cmr42125831f8f.22.1779306727980; 
 Wed, 20 May 2026 12:52:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm56007786f8f.17.2026.05.20.12.52.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:52:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] mailmap: Remove PhilMD redirect entries
Date: Wed, 20 May 2026 21:52:05 +0200
Message-ID: <20260520195206.40679-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Our ./scripts/get_maintainer.pl uses git .mailmap as a fallback:

  $ ./scripts/get_maintainer.pl -h
  usage: ./scripts/get_maintainer.pl [options] patchfile
         ./scripts/get_maintainer.pl [options] -f file|directory

    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
    --git-since => git history to use (default: 1-year-ago)
    --mailmap => use .mailmap file (default: 1)
    ...

  Default options:
    [--email --nogit --git-fallback --m --r --n --l --multiline
     --pattern-depth=0 --remove-duplicates --rolestats]

(see the '--git-fallback' used as default option).

Per gitmailmap(5) man page:

  ... the file .mailmap [...] is used to map author and
  committer names and email addresses to canonical real
  names and email addresses.

I added my entries in the "replace old addresses by a more recent
one" section for this script use case, but we have been doing a
good cleanup at having all files covered in MAINTAINERS, so with
retrospective these entries aren't needed anymore (besides, using
them retroactively credits all my contributions to the latest
employer).

Simply remove my mappings of that "old -> recent" section.

Reported-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .mailmap | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index ce569d83f4a..82ff20b8ddb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,9 +104,6 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
 Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
-- 
2.53.0


