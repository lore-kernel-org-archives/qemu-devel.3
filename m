Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD18D44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOJ2-0003X9-N2; Thu, 15 Jan 2026 09:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ1-0003WU-4a
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOIz-0004jM-Bd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso9070075e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487191; x=1769091991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8D0tuo6L9hq8eRYiyZ2ZRoJM1wMpms++7NO6X3T+CZ0=;
 b=yCTKsDMgnOtbu6jQrjpyozlfeRHJXcmhjGZRqnBk86lXIS2D6qAR8dJ1SISy7Ox59W
 jl83YnwOyNx66+kDwEPCHBLe/7h5fUxD65vvbotyviIzErvUz9Y5PaHOB0zlqIveYlvn
 4G/AUiFvVGfYXFOOgO8iTvS6SeHnx/ufW+oNXuhv/FPUOfr7XKuNR/w+y0xtXn6z5BqW
 zrMwMGiTwr13efC2xNvyeK20ndCTfdGf3UARe5+BYQ441pKZqRkSK8lFYg4x3I96o5H1
 XzKBEZGggiq0a0E1Ke4cn0PJnZO8HgGtzuTpAeAKQB/bT0VGsS06tl03FOnG3umDvp8n
 ur6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487191; x=1769091991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D0tuo6L9hq8eRYiyZ2ZRoJM1wMpms++7NO6X3T+CZ0=;
 b=dD0rS33U43HP/XGCwU1rlfsEEABwF2T0Q54OhV3csLrJSVS0Iks1UGqC2L3FQGoLBT
 JjbwrA1q26RE8ZPAMPWAnYV5VSEtFn1qdmyZEA6ObaYqiP/nuhy5cQe5RB88HiP3bhDE
 flikJP/mk8DzAM2jjDBtOtUx3zPi4PJhq+wReKBksU6maS0/vOOWPLUk/KQjy3QXiG7U
 HTJKVYGVLPb/WeBjYoN9gOWy3n2Jj3iT7kbKPK2huOwpuF7z9UD6vnJxtgKkLCSK/wlt
 SW78Hwa4VQNEEMPx6h7iGAPVpeN0S/u5TZxja0wk0jez2o3nmwxxvkNzx6WIdSMqkZI1
 Mt0Q==
X-Gm-Message-State: AOJu0Yym5I8cR8Lxyo0vyWl7sZs3mnTgWypasOyxs872BsEZCqyYulE2
 EJVAbL9H4S1NNi/GBmkxOgb/rKgJ+OIiDmNtV4ieJkbNLafBmgNaFmYqRcZvCcQfmesuwqaVrnW
 Agn3J
X-Gm-Gg: AY/fxX5889DX3AUyMapLMjv7VFkTB0+oWWeIfZUU7gMuisc9C3CoDKXgULq1mwevtVr
 67N9WrFzcNI0NRNsG4PT2qHZRo7ZaJ7EE3+dUvLlBtdvKnIkG3vlC4UcBp40bfZbVrDH84HhdDq
 YOH7AS1LiS1z6/7vxOo4Do6TkVhZ7CPVVQKv/IsXtNmBjJkRRvUHF1wob8WDsSftJmA/aufSkOL
 eBE/WW6G6I8Vwg7iMZMEW4PHBHV0E0jjXt3Dn6ICiENd5RBs1Tl2dkDeihJ0FB9pjPqG3NJQrIs
 vZmEs8W5DjZUFOOCJbM2HKX7Ca7LZ3WOjQNsPA8UkvKVbnYJi4jZ1+0I/ANiJSPg7I16LVnNo6e
 rcA2eOGmXlg21CU58hra3Gn2H2pFlZjN0940QSIOdCCkSIuwx+3YskzqYDkPFrHatuH/NsyHEPa
 BYOaNGY7YZmwLAhSs9fB6muKPnockozHcRTZ3NkJk/A4sXU3KRvHMMIAdmpTxCNXRmwZwdoGlaa
 a7EF7+lGSFKoAChQr4J75VImmM1cT6xvObSfZ4kBGpEWA==
X-Received: by 2002:a05:600c:a51:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-47ee32e5cd3mr80824005e9.6.1768487191277; 
 Thu, 15 Jan 2026 06:26:31 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm50759435e9.14.2026.01.15.06.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:26:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 0/4] docs: Remove bogus mailto links, minor cleanups
Date: Thu, 15 Jan 2026 14:26:25 +0000
Message-ID: <20260115142629.665319-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

I noticed while reviewing a patch to add documentation for
a new Arm board that an unescaped '@' character resulted in
an unintended mailto: hyperlink. This prompted me to grep
to see if we had any others of those, which we do. This
series fixes them, plus some other things I noticed along
the way.
 
The first patch cleans up some awkward rendering in the
xilinx-zynq-a9 board docs, including dropping a hex
address that was triggering a mailto: hyperlink.
 
Patch 2 is all the easy cases which we can just escape
or put into ``...`` preformatted text.
 
Patch 3 removes some uses of "@var{...}" in qemu-options.hx
which may be there because the authors had the impression
that that would be rendered into italics -- it isn't.
I've replaced them with uses of "<...>" as the most
common way we currently mark up "my-option=<something>".
These aren't mis-rendering as mailto links because they
all happen to already be in preformatted text.
 
Patch 4 makes a bigger cleanup to the colo-compare
option docs: it also uses "@var{...}" and here it is
causing mailto links to be generated.

thanks
-- PMM

Peter Maydell (4):
  docs/system/arm/xlnx-zynq.rst: Improve docs rendering
  docs: avoid unintended mailto: hyperlinks
  qemu-options.hx: Drop uses of @var
  qemu-options.hx: Improve formatting in colo-compare docs

 docs/devel/submitting-a-patch.rst     |  2 +-
 docs/system/arm/xlnx-zynq.rst         | 51 ++++++++++++++-------------
 docs/system/device-url-syntax.rst.inc |  4 +--
 docs/system/vnc-security.rst          |  6 ++--
 qemu-options.hx                       | 51 ++++++++++++++++-----------
 5 files changed, 63 insertions(+), 51 deletions(-)

-- 
2.47.3


