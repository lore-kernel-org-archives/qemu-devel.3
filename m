Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B9606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TjdDDEE/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIFV-000715-0e; Tue, 03 Nov 2026 12:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFR-00070g-Eu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFP-00068Y-My
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so39879085e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726673; x=1794331473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kiaqXQ+x1xiScmlLRb/ugeDWp3B3VhLXz0LfJRet7XM=;
 b=TjdDDEE/cVA8vhud3ebCI7TnEBVzK74MZY1LR5liDjwQFmN3Z3rn+F6eWf+lDZpYAV
 kgPMZ6C1+De+864IUiRXPxZXpa5eUdVRhwtQpu5yRqfbR8O/bBb5/JBPP19oX1j1H4rK
 UVZcWT4/g01WKpQS8kT3OMBn1jZ+iN3CDgdAHn60W1Z9rWZ1a7CI1JwoB9kk2ZtJifIb
 ouU/wfI8QaHIqRec8KK5oMUjWrlou+NZrOu7b4Fj0Tfc3mKQQREP+okjNm0p/awicYH/
 KxuSd0unAn5XyYp3GjRAPK+R9KTUHZp4TsVYDlHi6tgGF0uN1NWbbCJ9Cx6RCKb9mvUs
 AH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726673; x=1794331473;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kiaqXQ+x1xiScmlLRb/ugeDWp3B3VhLXz0LfJRet7XM=;
 b=NUmI+pvsa1COdZ2X5AIQrt0eG06CMpUdQhyrcv8GPpk899AKUAH3LTqkxvd/DYqugN
 BsmE2ytDX0ZHOEuejBJHzXXerBNF+y4yQZMJtp6ddCAG6OiB36ySuEEiNQl3FOvOoPu6
 wFNj6DokZdT9A3Dg4NiZJJrYbnmBy0GMKphWoRR9PA00WRtPAr/F5vGNnOz16sjWMmvS
 TZ339xDdZUp/pFrOx3KlbSjmWSyBTic6m60Zt8YCLhCxl8hBcu75NpFPq93pWUnQEE4b
 AYdVwPigwkpsdUl/+piJa25EGljLf5t9NnhWxoHA0ZeRXsKwkJGa07yuBv/HrNi+dTZo
 fdIA==
X-Gm-Message-State: APuU4Z8yD830Zzgp6jbY2t3zKgb3hNR/o57ZEzXr6f47ipE7FFcTvqMz
 faS2SPgpo/H9nvXwPP1aQ5bc8xyiplLAV+EbzrXRb+6dImh9y23PJfufIaQw66QJpm8=
X-Gm-Gg: AYBFou1cbac8AVnWI6CpUmO9NqieLUmI8MxkTfAHIbUA0Z6g0VNuGRYHqjf6vld+HsQ
 NIuvbYcoulUnm1t989rFD/pbEAKFhmIt65+GjPVUKjiLRf+mafClEb5ceO02K1qq7xGWmcR+8kP
 o+kKxV4ILh8t54f0v8ITqmbbTbtjqPElvYTVmk+yC0SoebPqAHmYEeXtEx0OGr7vJ6FEoYl/wsw
 hoDXgEZchaGJN7MCz56G9uXioVtdUlGC2QEONfVb6DCim7kAYomO+eGSz1I5qAO5JEq3TOkNEK7
 Sct0dCv+I/vnM1k5kEr9CW7UX4cegotHSxfrmj3QstiPPeBky6GoI3pQE2uBXwg9E6/Yyw3kq9w
 qI4w/H0vkeTxJFvuZhHCr7jvEzxZBDHeLiKQdZSXCyDbyjElbAhfO6Oxi5puTXxMcSSiffyDXyF
 jS2kQoRz5ehljKSqjMoqqu6MlPZtvIn3QTzDuxiA2YR7j/Zks8mAibc1VO41Cpi3T8xIG/nzaIZ
 pR2UqdyBVBr6cMVqLxtdX6JN3+JSROUBq8Yh1PB3hQyu9N4OjaqWfX/uocnS4H6kjsvuGG7SsLy
 hn+e7Zz7WvQKRVCmlmscIUguvHJC
X-Received: by 2002:a05:600c:a00b:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4ac1765d8abmr319416555e9.22.1793726673415; 
 Tue, 03 Nov 2026 09:24:33 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cf248sm109240755e9.2.2026.11.03.09.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:24:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 199095F89B;
 Tue, 03 Nov 2026 17:24:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 11.2 0/3] misc fixes (checkpatch, gdb tests, x86 icount)
Date: Tue,  3 Nov 2026 17:24:28 +0000
Message-ID: <20261103172431.1180482-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit a3565937b39779d4e3704298095f566e7559ad53:

  Merge tag 'misc-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-02 21:44:22 -0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.2-misc-fixes-031126-1

for you to fetch changes up to f2e3e3bd30842d75211ad20dea6605c8b3c49899:

  tests/functional: fix call to common_tuxrun_gdb (2026-11-03 16:51:19 +0000)

----------------------------------------------------------------
a couple of last minutes fixes:

  - make checkpatch validate fixes against upstream branch
  - terminate block on x86 RDMSR
  - fix common_tuxrun_gdb call on s390x

----------------------------------------------------------------
Alex Bennée (3):
      scripts/checkpatch: validate fixes against upstream repo
      target/i386: terminate a tcg block on gen_RDMSR
      tests/functional: fix call to common_tuxrun_gdb

 target/i386/tcg/emit.c.inc            |  1 +
 scripts/checkpatch.pl                 | 40 ++++++++++++++++++++++++++++++++---
 tests/functional/s390x/test_tuxrun.py |  1 -
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.47.3


