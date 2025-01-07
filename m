Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE75E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCoW-00040P-Jo; Tue, 07 Jan 2025 11:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoV-0003zg-Bf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:19 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoN-0005ob-LN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:19 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so10432790f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268729; x=1736873529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/SJr+0xAZP15vcEaFWAWnIHAp8JE9E44SGnC3D++lo=;
 b=et1donzP1n/vecihhD68v+g+D0Kwt9WmnP4/srhJIu4T5vNTKXj+gjTQRlteMlsBXo
 XUTFj7k72hUC2obQN5DAK6O6TrSKo3I8oFlkClPnUCmifccISsI23juBVvJkW7+REoPt
 lQUCIzf4RbihbD6pES8L+1F8J+BsyHyc43+kk76UC22+q+Zj54yqnMa0qOJx+VEmgZbV
 hTlOsAMH+82piOlvy3ZsPP55CeMARohq6evOBKWy0T76a1qO0Nrs+d341YbWxUL+rgR0
 2gb70JkpMtmH4ZocGzc80HJAuE4C/hwKiEoV1NktiebD2oTck8wLgbz2C1GmooXe5AW2
 XlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268729; x=1736873529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/SJr+0xAZP15vcEaFWAWnIHAp8JE9E44SGnC3D++lo=;
 b=iPU3BvrWZ3GcBylZMvJuzAe3W3rxXspMoqWgDdOu/pX0Jld3R5YK80hDFHX12DePV1
 0c6IiWuZHVX5MMW9tEkzNd2COqROF4kJnY9THVIAcVDqSbbuZEfnW01PiJ2HdNHUxYzE
 966yCw9cLVU2pFxPIDP2SQLlZZ3ESXF+IoYvfJL7kH36vxjxAxsba2+gQh5nZ8juEDPN
 G41+H90orIafuBFPPHDMWzhlUwIevasjXrlbb+kAvkqSJnuBx94jbtwGdfU4qKSlX1MB
 o5gR7DonNYpBLJs85/vgW1xwCoZHl4NGvnaUG5x2rjj/DNU9lWubDYjt41tQ7jwXoSzb
 Eegw==
X-Gm-Message-State: AOJu0YwA5b4Tp6Gz9dbUI7xyEeI4IAom9Q9XsFiLWu3voBEDN5fh7S8/
 1lvN34bp2SE4MGpKV6FM53bMRKuLKscaYDZ8OcJz522Kz61WuK+wOtm1MCdqJMM=
X-Gm-Gg: ASbGnctrz7JhE5uKpUG0X4sB7hKynbt9Ok37Twu+YmLcYDEAB4sJ8SGnJPvTVJFrHF7
 8faPnHEtKAg6+MkGOO3FF5ibq7v6dy8u5DMmK+PfcIGR2yBmiIY3YeH5OwcI3qnegEsFLWaEXou
 sgW2Ax+4sBy7RGFiRh/YHaf2yKRfjR53atb6HCEMii7tfah1Ns7DKDe1eF5jZS8UQRVajoZsXTP
 hemLEQ8q92t/3f+jp0M22k2PfRmbRLad+df1gxPGwumbb2dBHc1NHY=
X-Google-Smtp-Source: AGHT+IHyLVrmZmlrBQJRz/52kbZIecaWIAxhTafHZHyDTgDvNPoSnsk8/DInVMxkv7PmK7nBpojLhA==
X-Received: by 2002:a5d:47ce:0:b0:38a:5ce8:df73 with SMTP id
 ffacd0b85a97d-38a7924412cmr3161920f8f.23.1736268729515; 
 Tue, 07 Jan 2025 08:52:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84ca21sm51110218f8f.63.2025.01.07.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A9825F8FE;
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
Subject: [PATCH v3 02/29] tests/functional: update the i386 tuxrun tests
Date: Tue,  7 Jan 2025 16:51:40 +0000
Message-Id: <20250107165208.743958-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-Id: <20241121165806.476008-23-alex.bennee@linaro.org>
---
 tests/functional/test_i386_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/test_i386_tuxrun.py
index c593ffbe8c..f3ccf11ae8 100755
--- a/tests/functional/test_i386_tuxrun.py
+++ b/tests/functional/test_i386_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunI386Test(TuxRunBaselineTest):
 
     ASSET_I386_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/i386/bzImage',
-        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/bzImage',
+        '47fb44e38e34101eb0f71a2a01742b959d40ed5fd67cefb5608a39be11d3b74e')
     ASSET_I386_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/i386/rootfs.ext4.zst',
-        'f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/rootfs.ext4.zst',
+        'a1a3b3b4c9dccd6475b58db95c107b468b736b700f6620985a8ed050a73d51c8')
 
     def test_i386(self):
         self.set_machine('q35')
-- 
2.39.5


