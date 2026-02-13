Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E3EEA853
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhH1-0003ne-TA; Thu, 12 Feb 2026 19:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGz-0003ms-K5
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:05 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGx-0000qa-Nm
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:05 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso415017b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770943382; x=1771548182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbsBM3kE23XRKko7Z/Dni4MLoWdVDjlTC1rdXg1+3EM=;
 b=X1ZdWvan0EL+kVNiyxCxyrGKq7lk/wNkHZnOdXzykxP9HC7oKaDzJLQvYIXMexfysb
 AfIefdnUURbUVN/sJtmfLaPxjK2lj8aEV+TuJCqmX7CpRzkwUEZIjS3aRgyqbGR5ruG7
 coEDv+AyoJTKf4GBYWjq/klb0qWkindYflLTenX+q23XRamXRXTogN3s48iEgrjG8unZ
 jUe9ULBdjQa8zbZ256PeRDxUFSWa01gqJ6Ipbngn9zCuI+TJoi6kCMLasIkLhY4JwpvW
 5EmlUZQ3lR3cX4WrbuACoXlVkEcajXojTgQ7s+b4gu8sLzti4cCy37ABGBSHcoYFDoJo
 D34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943382; x=1771548182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbsBM3kE23XRKko7Z/Dni4MLoWdVDjlTC1rdXg1+3EM=;
 b=C4/ln9/04mNuaxC5+pTn2Pqb3n/2aCCQGmg1BCQ9aJjmzWY5sMpg+T9NnCbaIauWgU
 yLFZaKw+16K3C3vIcTBqf+aX8uoH44OeJwRi7QF3xLDu4G6m2jc06UxAiY6intxpozlY
 hd4iHmxD21jpJhQ9cNS4mcaoKpjmtFmMATyHmdDSLtWNEmUT7xisgfmpAHeJuxh+SI5b
 QEyEnvODuGumdEY0OK/6jw6ewopR64MAW9BWWFJpsPXZCikufTqUAhwRLepLVgX/UDZ8
 sH/XVFnbdmJEndrh5CdjZ8OJfWP9X7HY3BiqNZUguyI187xqXxq069/MIhWS31F9/hKE
 m86w==
X-Gm-Message-State: AOJu0Yz8w22Ngyj4CiA6YHlt3+13twYhLpk5wF0tRfXLX9/NJlpf1DQg
 062F2clJCd4Rc1hR25wqEkC4jR1QIDAUJoRao2PNpU3zw8w+P9r7f9oEgFBmlh0giaZUJTOktSA
 HtfQY
X-Gm-Gg: AZuq6aLxu+JoBaP0ZZcv8n/OrY5qdFvspOh+8jP4AD2WX20SDBr2nE0JNqG59TlIxmz
 BuoYM60Ox82iL+KYwWsnKtX80rHvw44xPDndxSyLVfUJ+p/S/At8uAEMGoRoBgpk071fA8M9GnI
 DE3/KqwiRBHrwn6ZvfI2ofQX/d8Ltgmy0ihdgMN03i/CEJ15U4N5bOjMrytvEiqeoXPN3Os0YRr
 wxfVUKTNs5KQyjoTGbgapcVqlDGeqf308opXGVVagOzxdvum5CM+Yb5zllToCFO28zUgWkr8CuD
 Ti8pnpURcoocwG04w2fqf9huQATFYD6MmZPK0UjWBnezE8tmHtEucfAxGgDGStIxU3UHEbkEuKV
 xZFJizDEJ18yS+YoMki8KAY6A2ol1Hh8tYXbZD4zc+GrXue5i19JucOh238fJv+ycIUFpcRh015
 WJ/iDh1fAfI+eJzQ7LKYAJenH9vVB4O0h/x/6pnKRn0aZoGI2psKk65I7J2UsSCz2FSvK/fMtDo
 9Xt
X-Received: by 2002:a05:6a00:4f87:b0:823:9c6:1985 with SMTP id
 d2e1a72fcca58-824c948163bmr265064b3a.16.1770943382230; 
 Thu, 12 Feb 2026 16:43:02 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431f2sm504326b3a.22.2026.02.12.16.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:43:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 3/4] docs/about/emulation/uftrace: add info about automatic
 tracing
Date: Thu, 12 Feb 2026 16:42:53 -0800
Message-ID: <20260213004254.493059-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
References: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210201344.1403613-4-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index e8793b0f9ce..f547e118eef 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -849,7 +849,7 @@ Symbols must be present in ELF binaries.
 It tracks the call stack (based on frame pointer analysis). Thus, your program
 and its dependencies must be compiled using ``-fno-omit-frame-pointer
 -mno-omit-leaf-frame-pointer``. In 2024, `Ubuntu and Fedora enabled it by
-default again on x64
+default again on 64-bit platforms
 <https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
 On aarch64, this is less of a problem, as they are usually part of the ABI,
 except for leaf functions. That's true for user space applications, but not
@@ -976,7 +976,7 @@ You can follow the exact same instructions for a x64 system, combining edk2,
 Linux, and Ubuntu, simply by switching to
 `x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
 
-To build the system::
+To build and run the system::
 
     # Install dependencies
     $ sudo apt install -y podman qemu-user-static
@@ -988,7 +988,14 @@ To build the system::
     # system can be started using:
     $ ./run.sh /path/to/qemu-system-aarch64
 
-To generate a uftrace for a system boot from that::
+    # generate a uftrace for execution (collect symbols automatically)
+    $ ./trace.sh /path/to/qemu-system-aarch64
+    # show output log to read timestamps
+    $ cat uftrace.data/exec.log
+    # generate final trace (compressed) for perfetto
+    $ ./perfetto.sh <start_timestamp> <end_timestamp> ~/trace.gz
+
+To generate manually the same trace::
 
     # run true and poweroff the system
     $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
-- 
2.47.3


