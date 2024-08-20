Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE3DC531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAh-0004ra-Bs; Tue, 20 Aug 2024 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAf-0004qb-Td
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAd-0006Kq-VK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso45355805e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165354; x=1724770154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hCKwMpRhpzsd7Pv66w1vIFm4SCoH1ZrYAy4xntbqp0g=;
 b=s2QFm10ukcCxpSomfZ1v8UA9uDsROrlegxNfyL/vQxrraFQyMWWAPZkQXEqWpzdKRe
 6ysG1DKsXcfIDMFlvJALeXqX0xs+XXkQTB9KCXTl+Y1J+pO7WH+qZlEiqnPd7tzwp8e7
 aw18FZ2ya9t6BHFIn3SYwHVzlhsZGo6bmmEqlNOyCDwYsSdSxgtCeRQBnnDcdP1zTCki
 x0dZ1lnPdOz89eOn3zv8N4U8VdZpI3eMCRsz0MrJo0JoJHzyF1b4+GkA2+tLKKP1f+7z
 mFam0YK3R6tEq5F6yAN+Bq9UuNpOZzBcKVthRYTZQbL92RvzbmswE9wAGZEHbwgbXY5/
 XAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165354; x=1724770154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCKwMpRhpzsd7Pv66w1vIFm4SCoH1ZrYAy4xntbqp0g=;
 b=cM1+Dne8UVhBFvC7JO8XSc5Dr9BqyUOuRIAnE6ufEq1oau/wRihOPOyp/PGB4ufBtg
 yA0rON3nItVQTstqk0dzS/IZwk58jKEr50shUrqXt0ay3WaTV/fGkT2S1oclE6zWhmK4
 bO8ingxE22h7VEyt9LN7MClS6WwelgXta7w9wBc+UEVvqiEaOUyTfHfepIW8WWzZtYaD
 +wclYuIV4n5kWJNpoBH9LbsWP0OnyMG3KihSqCQPzNlF4MLoFmLgATAFxzGLPhYo4C6o
 MLgL3HUM24jqEBNEDwsBge0LFR1GucV11RZ/VmaDiFOpAFIUf/Ln4nXAF2VeP1JhpXmJ
 Mi7Q==
X-Gm-Message-State: AOJu0YwLwIGi2uuIORYGhuUL+hDChTx5gsy3fLH69xb7ZMU7xGMLuknH
 biawMP/NEcApV7peLh8TeQESyGQ40ATfiSdxTZpkK8+cX2GBRdjbA5FtDcSObuC3oecAOYYz/14
 m
X-Google-Smtp-Source: AGHT+IHl05aALreG52M1SEXE3GbbcJw2BdXfikXbVPC0h/Cjfzff2Gj++z3g9mfOsM0VxR1Pld9h5A==
X-Received: by 2002:a5d:4dce:0:b0:36b:555a:e966 with SMTP id
 ffacd0b85a97d-3719465fc3amr10863427f8f.35.1724165354007; 
 Tue, 20 Aug 2024 07:49:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 0/9] tests/qtest/migration-test: Fix various leaks
Date: Tue, 20 Aug 2024 15:49:03 +0100
Message-Id: <20240820144912.320744-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This patchset fixes various leaks that show up if you run
migration-test under the clang leak-sanitizer. Since they're all
test code problems, this is 9.2 material. The one leak that was
really in the QEMU code I have sent a separate patch for:
https://patchew.org/QEMU/20240820144429.320176-1-peter.maydell@linaro.org/

You can repro these leaks by building a QEMU configured with
 '--cc=clang' '--cxx=clang++' '--enable-debug' '--target-list=x86_64-softmmu' '--enable-sanitizers'
and then running the test like:
(cd build/asan && \
 ASAN_OPTIONS="fast_unwind_on_malloc=0" \
 QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --tap -k )

thanks
-- PMM

Peter Maydell (9):
  tests/qtest/migration-test: Fix bootfile cleanup handling
  tests/qtest/migration-test: Don't leak resp in
    multifd_mapped_ram_fdset_end()
  tests/qtest/migration-test: Fix leaks in calc_dirtyrate_ready()
  tests/qtest/migration-helpers: Fix migrate_get_socket_address() leak
  tests/qtest/migration-test: Free QCRyptoTLSTestCertReq objects
  tests/unit/crypto-tls-x509-helpers: deinit privkey in test_tls_cleanup
  tests/qtest/migration-helpers: Don't dup argument to qdict_put_str()
  tests/qtest/migration-test: Don't strdup in get_dirty_rate()
  tests/qtest/migration-test: Don't leak QTestState in
    test_multifd_tcp_cancel()

 tests/unit/crypto-tls-x509-helpers.h |  6 +++++
 tests/qtest/migration-helpers.c      | 20 +++++++---------
 tests/qtest/migration-test.c         | 36 ++++++++++++++++++----------
 tests/unit/crypto-tls-x509-helpers.c | 13 ++++++++--
 4 files changed, 50 insertions(+), 25 deletions(-)

-- 
2.34.1


