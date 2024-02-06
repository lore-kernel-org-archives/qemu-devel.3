Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E41FC4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9fd-0008AV-HH; Mon, 05 Feb 2024 19:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fc-0008AB-NI
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:40 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fb-0000LW-1k
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:40 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7c00128de31so195901639f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 16:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707180637; x=1707785437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sBEX41VGUb5Bl+vdYZ+dSfQN3Op8JOfGKtT3SM0p5T0=;
 b=HvmF3TQ0HUZlHrnwexByr5TwKevJnGNj6Qyhf770pebzC0OSrY+q6jJ5Mm0Ia75NID
 60N+bnHUawPOqInNSWTUNpq+v9FxZXqjkGB3K28qIDqX+3iUZYuBqq+3gfv8WetL+blw
 I4K2/UJ2KszP5W5+7Ft7W8rQI0DeJ2ZpELcnu7Y0NuFsnMgi1xXSaOKGTElI3ONXeLzU
 jme/2AOULYjvGxuBXy6ldeBu8Q8T9IOLuVCMHDvNiMMnj7APGfhdMmC1WVZhGjZ1PbT8
 jEe1wdxIeXNHW4MkO8NQR53zI9IBmGfLHZ+KNxA5pD0Z/1ctWApRTPUnABUTNKwoINor
 NeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707180637; x=1707785437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBEX41VGUb5Bl+vdYZ+dSfQN3Op8JOfGKtT3SM0p5T0=;
 b=v54m+gzCSJbwvbBKtakKumLZ7/y0eSqeiaoagHmeI0HNprAU22Ozby4OQPkjA7yMEM
 Bn32qFOByeVMNFmicfswMPUiqWCitIOwNSV2ar18mhBMWzKUZ4G0Euc6gNRM5YqoYzNb
 DCF/dVd375eL3y1mftMMyYHqaIX6CWzvB98rJW5PM//1ec1+f014qSZAeIi9OB3ReIXX
 XArOSpJK6W9LE8XALMuP3mOo+O1L4aiyNGDPEK99rp7YglTkbXILGuGEILHq/vs4UdpR
 albZ5p75eI1nRtaYPleiRhos6mXoPs9ABrcjYd/pz9Xfgkn6kK/MANp+xSiWeogJ5Yuk
 3uYw==
X-Gm-Message-State: AOJu0Yz9bY71D7B/0ePjisWfpCm9ng/Y96tRCZYjojHZhYOq/adRYPlj
 U7ZI7VTP7EeShD7HxVwCgEpFcTtLFAfF4ifEq7RQ93KSd5sU1GLkSk8mWHx+bxc=
X-Google-Smtp-Source: AGHT+IE/mi8WEvMDjWYBWXxqBc5o4RkDgcMVjrX99HdziWVJhKQv4V/AebASiI2BfBSbHl7pNj1eRQ==
X-Received: by 2002:a5d:8ad5:0:b0:7c0:1fe2:da9d with SMTP id
 e21-20020a5d8ad5000000b007c01fe2da9dmr1267498iot.19.1707180636793; 
 Mon, 05 Feb 2024 16:50:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUVm+b74xEZ3nRtgNIj5I63Y7j6rjQq+nVh1Pjhptex3V4IEIi6S51CRSZ9kY7QVG2LAG0a2S/EdfbuzUjS+QoCNDQSfRnRbkrCqrWLrFCCr/5pS7xalTXoS1EGrzmvJJ6fEq1oJeRZiH4SJqv1Q93DTJorRiWGfj2/8QDCCqKV7gPkr+AQ0S3rK2bXdooNhqRwyNz8RyxR3hEveienZL1VnPkdTHtCkg736qT0IrjMjJkXNXQZwiNAkQkJOD6WgBdU5+AkqxGf69VdrS3yw2Krzr5kcec0bUznjg3J
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a02a408000000b0046e2ce45dafsm245840jal.165.2024.02.05.16.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 16:50:36 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/3] Hexagon (target/hexagon) Only pass env to generated
 helper when needed
Date: Mon,  5 Feb 2024 17:50:31 -0700
Message-Id: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently, we pass env to every generated helper.  When the semantics of
the instruction only depend on the arguments, this is unnecessary and
adds extra overhead to the helper call.

**** Changes in v2 ****
- Separate patches to pass P0 and SP explicitly to helpers that need it
- Add the TCG_CALL_NO_RWG_SE flag to any non-HVX helpers that
  don't get ptr to env

Taylor Simpson (3):
  Hexagon (target/hexagon) Pass P0 explicitly to helpers that need it
  Hexagon (target/hexagon) Pass SP explicitly to helpers that need it
  Hexagon (target/hexagon) Only pass env to generated helper when needed

 target/hexagon/gen_tcg.h            |  3 ++
 target/hexagon/macros.h             |  4 +--
 target/hexagon/attribs_def.h.inc    |  1 +
 target/hexagon/gen_helper_protos.py | 10 ++++++-
 target/hexagon/hex_common.py        | 44 +++++++++++++++++++++++++----
 5 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.34.1


