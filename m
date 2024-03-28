Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8809C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphB8-0006Tc-T8; Thu, 28 Mar 2024 00:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphAx-0006Qf-Sg; Thu, 28 Mar 2024 00:15:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphAw-00036S-5N; Thu, 28 Mar 2024 00:15:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e0fa980d55so4869045ad.3; 
 Wed, 27 Mar 2024 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711599335; x=1712204135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MklDWJNI6nVWpkEeHpNJc4a4g30z91Cu865WR8j+/mE=;
 b=F0Qu+wajYzuhvGtoqwf0dhp25Vg1vRYgLMOtTixnPsnzrx7UuVjtX65QO55vrh5N3C
 vxQL8wahL9tKAB9tyM5n3id6ELF8NJDxwWKCZ3KDQXsdCEArVNyemr5xeN9/Yb2LJ7Rj
 P1Y2iJqkUAeCg9mdowkB64fYNU85J7PNG4JqIHPoTG4VsO4OXd2m6s0pPx+uEngNrtDp
 3cQSKFxKkob6em1uc5wNOYPDTP/AFAprJtjSh5gdjM/Xbpw7jGYYnw3vwv+xqbhKxApf
 Jrox57SsHuNDjcBy9HEiZKEKacj+5VgsAQK+FY3XaiMbNuWrcYhjKMqAusIbJ2N1Ualp
 dBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599335; x=1712204135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MklDWJNI6nVWpkEeHpNJc4a4g30z91Cu865WR8j+/mE=;
 b=odmCviHxAE7qjdl9u/DYTS25F2sRiPjx/6997YA+5VmTRjEy7ObcVzPTaMOHAlj5Bm
 g2IBMbOa+OKiwaD1QzVQHXZPHhgw6YXcFhHhd1qIGNwSD1reC75+cJNZOjRBWxFtOhpC
 qN+lNnDteyKQYo2twywS1ge8F6Y94mf5g23QZNCskwiF6cFPoi8+l4GyMh/3poykHay2
 JuyRlq5/o3pxoupyZc7j2fla+W4xRUGgIkC9eCniSHQJGGgo+hsn+SY3O955A1rEkJTo
 AXWzZdmbwRaotoAl14BZi5sshcN0ZyS2v9kw61EXQN5PdtApt+hV1RdN6ketTlLjwLzW
 MD3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS0DuMZo5g8GM2AxoS/N+D4ZXtlbXKX2JTN9QCys+bDoBICRYZ4kpbiQ8rZvRlEbv+R50DxI7LKc/TsmjOb/o1WRxa
X-Gm-Message-State: AOJu0YyerYauvquFn1OBIDtQTzPaDl7084OCT1BkQ0SWDthxhjHp5cUv
 jbetDdNlW8UPeKq95j460tdSJji44/8NqzItgjmFcohH9C+XtbeXyOPAbtrfqcE=
X-Google-Smtp-Source: AGHT+IEVtf2h8LoBYz2zmBn7c4lDpBzopCeO3G6HBCRrlBWFz8gFqA4CGhYeK9iHDrARTE+78EOglg==
X-Received: by 2002:a17:902:b70e:b0:1e0:b709:139b with SMTP id
 d14-20020a170902b70e00b001e0b709139bmr1368359pls.56.1711599335420; 
 Wed, 27 Mar 2024 21:15:35 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b001e0b5f9fb02sm395416plk.26.2024.03.27.21.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 21:15:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/4] tests/avocado: Fixes for ppc_hv_tests.py
Date: Thu, 28 Mar 2024 14:15:23 +1000
Message-ID: <20240328041527.2602823-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

This series is a bunch of fixes for ppc_hv_tests.py. It includes a
generic avocado patch that I've posted before, but that seems to
only really affect ppc_hv_tests.py (I haven't seen other tests wait
for console after executing a command like this).

If people feel patch 3 is too late for 9.0, then patch 4 should be
left of too, but 1 and 2 at least should resolve some CI failures
and are self-contained.

Thanks,
Nick

Nicholas Piggin (4):
  tests/avocado: Fix ppc_hv_tests.py xorriso dependency guard
  tests/avocado: ppc_hv_tests.py set alpine time before setup-alpine
  tests/avocado: exec_command should not consume console output
  tests/avocado: Mark ppc_hv_tests.py as non-flaky after fixed console
    interaction

 tests/avocado/avocado_qemu/__init__.py | 7 +++++++
 tests/avocado/ppc_hv_tests.py          | 7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.42.0


