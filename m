Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCc-0005zj-Nb; Tue, 30 Jul 2024 18:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCa-0005pM-Oj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCZ-0006iv-10
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368313809a4so178094f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378013; x=1722982813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24RQoEKyoT+5UpLOepmNrf2/RkiZNFw5AqywzTwtt80=;
 b=zGXGjZVbbv7NTLfgx57Pmjdk7i2QwSJ6IWN9T5e6Yqj9uJzTC6KsOsSrO27i0t2ZvB
 nxCkFUhV6okfRDZJB5m1MR6JtR+0E+EeCnspq5RaYWIOV0AxtWs4eAExpcH3cVO4dceU
 Y+cCsxT4x5G9cPZF2TpZEbbDaB931NtXGU5ZZCfJVDfseIyazfwk3e8g5oL8P/6NMuvu
 KWIGlzmZttiHlb6JAfk4jcLkc3PVyuDllIHyWxLUPDYvFRfZfCntBLTXzWSIAlNlj5s3
 OZCbkRzZLqF6WsOH80mjj51lBEt44p1V7mYrAD04Px9gwx5d7cnJLJoa60WJsZQ0Awk7
 mEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378013; x=1722982813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24RQoEKyoT+5UpLOepmNrf2/RkiZNFw5AqywzTwtt80=;
 b=rcgWAPP7mM/i/5f8Y7y49vx9SAKS9GibGkhWB98g4MCxOz+JUknVYxpHsFta+JENxJ
 rVauR5ghdaHSzfwTzPJp9I4/GFiomQsHEcLM76DuisZTglj5UtZfA76jZarMiJOBErtj
 N6AZ/8BdsSptt8h4zNVt34E5Wo0+jesSd8r93W3NUrmc58pUanUlVWZfng2OnFB5TMjt
 T172LXkKOaNDolo5aOUEYjyXhljrUASFDKCcvOSzn6YMGoh16hUObUDkX1vzOEbNMWXh
 V6TMCdJBFRbrauTaotnSw3E+eTCaBWPQYsvu+KGu8fZC272HQniRHCc2SETYiawia/5B
 aM1w==
X-Gm-Message-State: AOJu0YwFPBSl+vrveEoXcc9OOaSbjcan+XHFdEWVNg0+YdfngL+ScVbv
 9ROzVRldakHJMQdJe3MBswTEsSoXUZPHJwNAWLU+pOM0j89nbBmRdSuBUM4FSGgFq3Zh6DIVMpn
 G8Xs=
X-Google-Smtp-Source: AGHT+IGkau5/2VEu6DmLCIUql1Z711qNocqOHwdy3AXd2lmcjkI4CXFpJ0jvONilGnO9sVSnxhtn7g==
X-Received: by 2002:adf:f6c3:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-36b8c8d7eb2mr2009958f8f.4.1722378013231; 
 Tue, 30 Jul 2024 15:20:13 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857eb7sm15585085f8f.66.2024.07.30.15.20.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/6] tests/avocado: mips: fallback to HTTP given certificate
 expiration
Date: Wed, 31 Jul 2024 00:19:54 +0200
Message-ID: <20240730221957.34533-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Cleber Rosa <crosa@redhat.com>

The SSL certificate installed at mipsdistros.mips.com has expired:

 0 s:CN = mipsdistros.mips.com
 i:C = US, O = Amazon, OU = Server CA 1B, CN = Amazon
 a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
 v:NotBefore: Dec 23 00:00:00 2019 GMT; NotAfter: Jan 23 12:00:00 2021 GMT

Because this project has no control over that certificate and host,
this falls back to plain HTTP instead.  The integrity of the
downloaded files can be guaranteed by the existing hashes for those
files (which are not modified here).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240726134438.14720-2-crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c35fc5e9ba..450d67be6a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -299,7 +299,7 @@ def test_mips_malta32el_nanomips_4k(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page4k.xz')
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
@@ -312,7 +312,7 @@ def test_mips_malta32el_nanomips_16k_up(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page16k_up.xz')
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
@@ -325,7 +325,7 @@ def test_mips_malta32el_nanomips_64k_dbg(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page64k_dbg.xz')
         kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-- 
2.45.2


