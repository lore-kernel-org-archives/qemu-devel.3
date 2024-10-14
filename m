Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11334D1624B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUa-0006dH-3O; Mon, 14 Oct 2024 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-0006cP-Uy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUI-00056J-Ru
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:49 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso2029741a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906224; x=1729511024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T8GPnrIClqHUeqhHxscAgWLKxqQlmLCT983D47kZpU4=;
 b=T8z5+tmFVJ1EfjOzUlA3rqQxIC4gdCPRs8BYERGBqyAZuPz9SIseBPKnpsgALFpsjS
 mFavk76MBTFEIgdo9N1VV8fFcw59FzMBiPvvTrjs39QzzYpWWk024uo0mjpaWsNHjkBg
 tibnb4ygHcKz3KNA1KruOdh01XsSlQbksjNg3d2XEwApJ9VmL+GyoaifN3jeeIlbqdu0
 sngDd5s9GYr/FDtKCXMr75BbAwTQFKiatIi2+0huAGk1UBotPv/8pHg/nCirpo7hcb/s
 2uo5R497Hsa13SzBR7yf0vrx4npKWnhoEPTT6IvNy8m+kOCn7FHKp/I1FUdkHSoIX0NE
 p/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906224; x=1729511024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8GPnrIClqHUeqhHxscAgWLKxqQlmLCT983D47kZpU4=;
 b=CtJ2wuXB/uolSUNJ9dTIirLUsczjibC8Wez6VzvzhLPJq9vKtWLJFJCnl2pjfFPlaP
 TxroGThBCNns3/rdeFW669Vd1H2/N+NCOARVYxcZDnQ2Ek4vhXEPFS7WwhmPWCnHYElE
 7VWhN6ey4Us97LuP/iuVeKBmxOIj2RRLmPcHnxWMA1Rv/harGnCOH8MjQr1o1591Ck6j
 wbVF+wxM5GZiZkSyoIEY/4+WdF3Hx+cHIwrudWECu/OVQeOW+5HxCEtmZlkOLQYctlk/
 Vst190q/jGAbbc/91gjvIcLkc/EW5wvdy7jVPeQeN59Za9FjH1/2LXuAe+LnBrBR/On7
 UyXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX0dOp8ycFhyzpOr4o1euicNCbKmOVlXX/NE4BudPb9YRGBRwGoIfuaM/uhemO4awtEELiIf8pfIwe@nongnu.org
X-Gm-Message-State: AOJu0Yz1m3VPqyBl3AqxGYyVzYMZxKqbJinU3eDvHsG1t4LMKKAyRIuQ
 DLTOukR6hQRTak7RgQRZz6RpjZkcWLaRL/3Ld8AW0vbVSY8K1YpA
X-Google-Smtp-Source: AGHT+IHJU3eAdWanpMrVMHH365JiGRfDgii+XOzT8gEC0kmwo229/4g84lyZ9k9qtQbsNqThikFNkg==
X-Received: by 2002:a17:907:60cd:b0:a99:fff3:2eb0 with SMTP id
 a640c23a62f3a-a99fff332aemr500573466b.40.1728906224183; 
 Mon, 14 Oct 2024 04:43:44 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:43 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/8] chardev/mux: implement frontend detach
Date: Mon, 14 Oct 2024 13:41:27 +0200
Message-Id: <20241014114135.389766-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x534.google.com
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

Frontend device can be detached in run-time, which can lead to a
"Chardev 'MUX' is busy" error (see the last patch with the test case
implementation). This series implements frontend detach for the
multiplexer based on bitset, which provides the ability to attach or
detach frontend devices in any order.

Also first patches do some refactoring the purpose of which is to make
integer unsigned where possible (such as sizes or lengths).

Roman Penyaev (8):
  chardev/char: fix qemu_chr_is_busy() check
  chardev/chardev-internal: remove unused `max_size` struct member
  chardev/mux: use bool type for `linestart` and `term_got_escape`
  chardev/mux: convert size members to unsigned int
  chardev/mux: introduce `mux_chr_attach_frontend() call
  chardev/mux: switch mux frontends management to bitset
  chardev/mux: implement detach of frontends from mux
  tests/unit/test-char: implement a few mux remove test cases

 chardev/char-fe.c          | 13 ++----
 chardev/char-mux.c         | 88 ++++++++++++++++++++++++++++----------
 chardev/char.c             |  2 +-
 chardev/chardev-internal.h | 16 ++++---
 include/chardev/char-fe.h  |  2 +-
 tests/unit/test-char.c     | 24 ++++++++++-
 6 files changed, 103 insertions(+), 42 deletions(-)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

-- 
2.34.1


