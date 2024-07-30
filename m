Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25695C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCY-0005hI-RB; Tue, 30 Jul 2024 18:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCX-0005bu-GS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCU-0006i6-WD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4281e3b2f72so22163015e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378009; x=1722982809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X07qTbL83zQOZhtssmu4m+yBs6p/aBS1K1qhIZAMOfc=;
 b=RflqPW2N+9sf1OruQg05FI3DZV7I+94gqUw6UdU/b6VH2GeJNdj/bm6izkxBbn5q6N
 GFF5QmnQNggF4xyBaJMjsF2ROsaTfYxqhHJ5h+AOCJAfkRL+JkNL4G8OILVjtio8AA51
 S6ibcYfZ7H0eggrbc4r1tPBzGLqHUTGo0VnH0HSxEQVJi8qm1o/+bm9AdgT70YXdk4jn
 sWG2azUuBGAn6c2hB4MokunT0k0W3Xu/kFh4JrTs7OmDp7ycrLoz4DTpDGkAgcVEZYm0
 Hi4tEXZAxSEvuy6GLw2gC7u6TNjd3kdI8w+eLckLKjhengZHdqq9sIA/xs0XfBQKo9HH
 zdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378009; x=1722982809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X07qTbL83zQOZhtssmu4m+yBs6p/aBS1K1qhIZAMOfc=;
 b=s6q4g2nsixoyz6RNRj2kxyrl2i0CPOMzRA9ZRZGP4GYxm8SExJRwA/jb6Pyu/0LCI/
 8PI0ItV45HCCOfS9Z2Vn853EC0beDjZgMyHW2LnFJZcJ17hpHhCqMdJOyJTIQYdYKuBT
 S3703zRfqoAPiyDUrTW76hHw0iQsLxyG9BMe6nvkcNaIlYfUNKfGWQYpqFlsc9lL1x70
 2/vNSSqAWMmteisSZFvo9gG9Oa1G8Acrv47dTo5d3z79EVcNda3F+58Fa+r/2hyqEuhB
 haDCARruvaG27C3/QEeVstXFEA+VNWnfnRjoM3KVGtKJ4wM5/xW0UeYMkXSQI+Oc6FVG
 4Wsw==
X-Gm-Message-State: AOJu0YyxrcA2nvshyAu2QuyY61tBDNDfBw7KW0EX6G3lsYnMch7ofFN5
 ew6OWlFAbnrtK/gC6Y46gjlM9huh51Jh0bqSzwlUQ10SjQjqhHx1yKxHL6hBY+MRm9PzM+eB9PP
 MdXU=
X-Google-Smtp-Source: AGHT+IFLdynvy53y5gMjvknbOtbV++Jc0xdy9l4GQ5Zxkfoq8f/scL2zHt9mVA/yBsBu3t7c/QMoBw==
X-Received: by 2002:adf:f147:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-36b5d0bc565mr6633811f8f.42.1722378008731; 
 Tue, 30 Jul 2024 15:20:08 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b645dsm228583675e9.43.2024.07.30.15.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/6] docs/sphinx/depfile.py: Handle env.doc2path() returning a
 Path not a str
Date: Wed, 31 Jul 2024 00:19:53 +0200
Message-ID: <20240730221957.34533-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In newer versions of Sphinx the env.doc2path() API is going to change
to return a Path object rather than a str. This was originally visible
in Sphinx 8.0.0rc1, but has been rolled back for the final 8.0.0
release. However it will probably emit a deprecation warning and is
likely to change for good in 9.0:
  https://github.com/sphinx-doc/sphinx/issues/12686

Our use in depfile.py assumes a str, and if it is passed a Path
it will fall over:
 Handler <function write_depfile at 0x77a1775ff560> for event 'build-finished' threw an exception (exception: unsupported operand type(s) for +: 'PosixPath' and 'str')

Wrapping the env.doc2path() call in str() will coerce a Path object
to the str we expect, and have no effect in older Sphinx versions
that do return a str.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240729120533.2486427-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/sphinx/depfile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index afdcbcec6e..e74be6af98 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -19,7 +19,7 @@
 
 def get_infiles(env):
     for x in env.found_docs:
-        yield env.doc2path(x)
+        yield str(env.doc2path(x))
         yield from ((os.path.join(env.srcdir, dep)
                     for dep in env.dependencies[x]))
     for mod in sys.modules.values():
-- 
2.45.2


