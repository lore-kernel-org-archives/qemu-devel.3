Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F245CE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCp0-0004Ly-Sv; Tue, 07 Jan 2025 11:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCox-0004Fr-F4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoS-0005qz-0g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so7532355f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268734; x=1736873534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=xzaIps/wVJwJKo6yxlO7oqmJDw1og9bURfqcch/CHkXccSnMfD5qBizjdcY0Z4OLGe
 KNWBngtPfVcCtI20ADsmxF1cy2OACqtdx2rlR17cB3xnW4CaMl+1sksaJBL+DD94JiZ8
 /xUmwc+pqGZ9HStAGwfqyW4Ew/7rsbn+9+pppfcGrpdi8XlQyTS+Ugz23v0mH3YHRbGg
 rIyevDhcWoBN4Oz0CHLfYbu+hByIpQKrrqWnlR9XsUaZbT3zQ1mcbWT5aCCK3wtdR1KP
 GimQNMa8v0afGKmDm+A0yNRzot6nBuZL3k7fNbqPSHOh4Cuv0N3vpQOLU0QYKtRyqAzH
 3gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268734; x=1736873534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=I5WeaCEZIFzds/0ViCsRsJwpylhpzatcDRQO0rAB+oUc9u/OMN5uXcSRoUODE3jAxv
 h3Bg9MY90J0+GHvVZCa4/9Ny9fCZbfieP7nhL6uPqUwtt165uRX0CLsGUZSn3srGxnBg
 R6yGLxRaYxnaHV5LGVBXI3MHjiwrKN4UchiGQRBP6fcIB7fvxZz8KplWhwa76+82njZG
 ZSRym4KRL7lXI+XvNkcIqWZHipb2nJkbGq4v13UI0uBM9AEiOqbKFolkIJ9rvJP7/NeR
 E0kh/srbN/RgYzQOnGNbgX0pLAJEI3U77G3/AEgKsEooYePfpDc0lf1ZZsZf83QcqkHd
 UIBw==
X-Gm-Message-State: AOJu0YyKsVWCBFVN8R3u9ZVgzCQ7xxj1C4tPQ6Mt6DTb+SAQ15RI5NdN
 Fiie8j3KhqyakQnqrYX41jhZBO8Y95ga1OMNbrVj92vNnnSfx898PwBJap3EQRI=
X-Gm-Gg: ASbGncvgS/QkcB7TOynsMI7Daqm53pZLcNleBVqNbLnOQqpm9aUQuy7K+0j4Wz8ehYP
 CIb4/O8iw8rfCl1w9Zmqf88vx1wM27KSkm9y/7MPWOemB5NA/RG5io236JEubwMw35iY7yacds6
 dMLH8uUpRdwIJdZr/l42KN2qN7XgYmwFuz2iM3SNwp2LF/GGgsyhfPGm/dCjpWVGjz4Wo2J7VXx
 aSAeq3bOQYgwKXw+oorCG8e/Gt+R07lqmF0R3YroxqADRoCHmndY74=
X-Google-Smtp-Source: AGHT+IG615Arlpv0gxDBvVJqfGCuJrrV7B0i+vru7SvdAIn74OPbWtlGlrnVi8z9S7CyhnJI5ikMew==
X-Received: by 2002:a05:6000:1acb:b0:385:df19:cbf with SMTP id
 ffacd0b85a97d-38a221f2e1fmr56448349f8f.28.1736268733975; 
 Tue, 07 Jan 2025 08:52:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a412f778esm36660188f8f.4.2025.01.07.08.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE4B35F94C;
 Tue,  7 Jan 2025 16:52:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 07/29] tests/functional: update the mips64el tuxrun tests
Date: Tue,  7 Jan 2025 16:51:45 +0000
Message-Id: <20250107165208.743958-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-28-alex.bennee@linaro.org>
---
 tests/functional/test_mips64el_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/test_mips64el_tuxrun.py
index 819549a27b..0a24757c51 100755
--- a/tests/functional/test_mips64el_tuxrun.py
+++ b/tests/functional/test_mips64el_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64ELTest(TuxRunBaselineTest):
 
     ASSET_MIPS64EL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/vmlinux',
-        'd4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/vmlinux',
+        '0d2829a96f005229839c4cd586d4d8a136ea4b488d29821611c8e97f2266bfa9')
     ASSET_MIPS64EL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/rootfs.ext4.zst',
-        'fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/rootfs.ext4.zst',
+        '69c8b69a4f1582ce4c6f01a994968f5d73bffb2fc99cbeeeb26c8b5a28eaeb84')
 
     def test_mips64el(self):
         self.set_machine('malta')
-- 
2.39.5


