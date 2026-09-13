Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF23C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qHC-0007l3-MH; Sun, 13 Sep 2026 15:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x5qGJ-0007Os-44
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:53:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x5qGF-0006DQ-VG
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:53:14 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so1301441f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789329189; x=1789933989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=ltWVkHI4hoNMDccBVxPNyNKUekOKbENSycKRYsYarkeHSOgx7JxRbkf4onPL97GiX4
 2VJsVCqNwTUo/Ta8jq12E5pSot4ZV8t6atio5xdAcisLuK6nagUY46OexpHwyyr14odX
 VwGkkalz04Zs8+VTnTiUZGd6XbOeevei/mn20nc54USMKWAZ/CUxV99ZZEluAnUyp3IT
 mg9qOQnygaOZXItwSRqyK284o+ODS4QU2sJ0y4JD2I7k+PJ9AXoDYxGlEWcYfQuMb0sZ
 GKAn3D+Rt8qnskqw+J6rIFOseBz6y4ciupOcRBhVx/KykwHtTdzKvWhQDEpnnDrVnP4t
 sZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789329189; x=1789933989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=jlvl5axEwnkxONNTvPXYNXF9MWcBkCp0KrAho78UrDBWwrwWPxV7gRx4CNWKUNItO7
 phBvfguTOpGKDzRsxaM2HDIw9Ri9mnUv2zZq2lYgtH+KJft7970we9CDa8Uf2uWy3/oE
 1wuEmE/DDxu54dJysTi0fKIlsFdgIWBcyuRX27D2JeMpO0yCm5OiIk+nukYiMrn7e50w
 VWVSg553HToXdXWMFPiAsd1Ty27pIn8vduO4f5QDiWx/+2k0+tuDK6CeZyn9ewDo0BXS
 DoI5zetq5SuL39aDWPA+howwTg0kER+9Iy3CzYMBBux5/zvUvUC3zTDWajjKSRe0oQdI
 mAhw==
X-Gm-Message-State: AFuF++k5+Pd7PnM27OnUBXT1R8AFHv2/tHmnb8c+tD/EyjEfokFdo9ba
 qR2U1jsSVJB+Hk24V33oj+blimP2TMrUUGAkY5s//pQAGawcdRQJ+ihbjk3XBCQ3jPUZtjqvPBM
 IA8dV
X-Gm-Gg: AYBFou2bEeNeqN0xDQpC1I6QFNcn3lwGk5PToHTC7NXU8t5t1JrOCILi0slsgDV5OLy
 fAcd0uVxhGELCJ2LcNHB1pdRul3sLO2a0a4pctFE1078R8I2YX7RWLna285PIt0pMkegHMenHtN
 zyB+e3mHD16Ni2Np9d8MNpcRkd6rko+XBILh1UHfTkRQgbHhOMwh21+dbS8KJ+NjiMRUhiaaw5o
 ytPQ518RtDcJU6wIMxB66Yn3LTaTH7tcvs6a1XO80dh669GmIB+9nFKpp3dMOzwl4CUd44sXjr9
 wf/pFiys8167NNP4lL9Q2foOLRQjFulRcMcGcLzafRdgO5S68RUSHh0lxUedxoNTV95jvr9Pj64
 jgrk2SULC4f9LMJ0xXjN3/JlcVu1LP9HNGVs1Qu/BCA2VLGJPvb5TBH4vbtHP2PxcT5cmvX++CI
 5hUiOCHXyVb6sLhI0lHOaTxdzeMzGck0lzcxtYa6sBu3ujr8p7xEqswzYx2qMh
X-Received: by 2002:adf:f091:0:b0:484:36c8:ffb9 with SMTP id
 ffacd0b85a97d-486eb2ec349mr10916227f8f.4.1789329188768; 
 Sun, 13 Sep 2026 12:53:08 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:ef7b:3cbd:e3a9:adbf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm20374678f8f.16.2026.09.13.12.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 12:53:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v8 3/3] iotests: cover the qemu-img bitmap operations on
 parallels
Date: Sun, 13 Sep 2026 21:53:01 +0200
Message-ID: <20260913195301.1514888-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913195301.1514888-1-den@openvz.org>
References: <20260913195301.1514888-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=den@openvz.org; helo=mail-wr1-x42f.google.com
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

From: Denis V. Lunev <den@openvz.org>

qemu-img-bitmaps drives convert --bitmaps and every qemu-img bitmap
sub-command, but for qcow2 alone. It is built on a backing chain and a
rebase, which parallels has neither of, so half of it could not run
there and the format is left with no coverage of any of this.

Cover what applies in the parallels test instead. A copy made with
--bitmaps has to carry them, and raw has to refuse them. --merge and
--clear leave the bitmap count alone, --remove-all sweeps it to zero,
and --remove-all --add in one invocation leaves only the bitmap which
was just added.

An image which was not closed correctly is left out. parallels-checks
covers that already, next to the code which drops the bitmaps.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-bitmap     | 39 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 12 ++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
index be0ba8185d..8ae9314114 100755
--- a/tests/qemu-iotests/tests/parallels-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -273,6 +273,7 @@ stored = file_path('stored')
 copy = file_path('copy')
 STORED = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69'
 OTHER = '11111111-2222-3333-4444-555555555555'
+MERGED = '22222222-3333-4444-5555-666666666666'
 
 
 def read_header(off, fmt):
@@ -434,3 +435,41 @@ log('--- and the image is still readable')
 info_out = qemu_img('info', '-f', iotests.imgfmt, stored, check=False)
 log('image opened' if info_out.returncode == 0
     else iotests.filter_testfiles(info_out.stdout).strip())
+
+
+# qemu-img-bitmaps drives these for qcow2 alone, as it is built on a
+# backing chain and a rebase, which parallels has neither of.
+
+log('--- bitmaps can not be preserved into raw')
+make_image(STORED)
+raw_out = qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O',
+                   'raw', stored, copy, check=False)
+log('    ' + iotests.filter_testfiles(raw_out.stdout).strip())
+
+log('--- convert --bitmaps carries the bitmaps into the copy')
+make_image(STORED, OTHER)
+qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 1M 64k', stored)
+qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+         stored, copy)
+copy_info = iotests.qemu_img_info('-f', iotests.imgfmt, copy)
+copy_data = copy_info.get('format-specific', {}).get('data', {})
+log('    %d bitmaps in the copy' % len(copy_data.get('bitmaps', [])))
+
+log('--- merging one bitmap into a new one')
+qemu_img('bitmap', '--add', '--merge', STORED, '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- clearing a bitmap keeps it in the image')
+qemu_img('bitmap', '--clear', '-f', iotests.imgfmt, stored, STORED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- remove-all sweeps every bitmap of the image')
+qemu_img('bitmap', '--remove-all', '-f', iotests.imgfmt, stored)
+log('    %d bitmaps after remove-all' % len(bitmaps_reported()))
+
+log('--- remove-all with --add leaves only the new bitmap')
+make_image(STORED, OTHER)
+qemu_img('bitmap', '--remove-all', '--add', '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    ' + ' '.join(bitmaps_reported()))
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index 994c67390e..df6f676106 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -92,3 +92,15 @@ read 65536/65536 bytes at offset 0
     0 bitmaps stored
 --- and the image is still readable
 image opened
+--- bitmaps can not be preserved into raw
+    qemu-img: Format driver 'raw' does not support bitmaps
+--- convert --bitmaps carries the bitmaps into the copy
+    2 bitmaps in the copy
+--- merging one bitmap into a new one
+    3 bitmaps stored
+--- clearing a bitmap keeps it in the image
+    3 bitmaps stored
+--- remove-all sweeps every bitmap of the image
+    0 bitmaps after remove-all
+--- remove-all with --add leaves only the new bitmap
+    22222222-3333-4444-5555-666666666666
-- 
2.53.0


