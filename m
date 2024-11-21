Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F651D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAeh-00023a-RN; Thu, 21 Nov 2024 12:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdj-0000RS-3r
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdS-0001cG-Af
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3823cf963f1so687004f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208788; x=1732813588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX7juP8P3Dz3dam5JbBdnNQ9MZQFT/0pRbnxh9O9VZE=;
 b=AOeE2LaluN/ICVffAKIU064Nj9823lG3+p66XiA+bR6mSsZyDgzvwiRKXTH7CZoaGb
 WKSggR55H6Gf2lh6P0q8SknNqaabevu1LgKayiVTHtD6L3TKv1Jt2fTT3LcC1BoEfE+z
 B9ZOpHuU8v8t/fHFDlPuNU5UbLPVIgmJ9HEP2oYg29MXNsD1SMwoKFzCpLeS2AD0mvTi
 mOqzWODjCd/GY/hwaJKwzORFhzEe+xsxdocz+Efi4fFqVRbXnEBzlwKXJFrKEVY3dO13
 GuX/z03wNvhV1lWdYgjsMZZauyWHgo4ziUzvL7+pleGFNbIJNMw5kkjgkUqUsuPAxo6m
 DMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208788; x=1732813588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX7juP8P3Dz3dam5JbBdnNQ9MZQFT/0pRbnxh9O9VZE=;
 b=VYs9WxGMOPXRb08Lgu0SEjqO/RBlPCpG1a719OCS44YlUE3kSjrZ2KywdwYc7qL/+1
 GfmgGDowkP9SSzLvqwm2z8KS/rbg5sVvPMI4Xkicj8/4iHioDkDGi2PlEs7RSSqh0wAv
 49T5FH0ET3JIkArfkJ806W5I5zftH52yI5VtkGNZyfdF/o7Lvkx1elAfeNjSG2YyMuLb
 TFo16RHuF5WrP4wo/FXItybL578uDS4jyzlyiQXxirfii57Qw6+9uvVczAE6TrhG8nNn
 rys/PnUAbhtJ+kFp+GgYLoA809+ylVx00IiFpOaukIdhmtMsDISI9/wc6Ie+uRIorZkG
 RqEQ==
X-Gm-Message-State: AOJu0YxQl2io2lvgxSbfrnN6X4p+5CQcKGpK468ofwzdV993P45lt44O
 VOTMsjTfhTrVaWW9GxNv4iZ6peGG14j2tAfWEu3dWLEyDmkiMQLSOLaZCdgg1iA=
X-Gm-Gg: ASbGnctOdN0UEHI5RjPu1BryN8oaBg1Ft0evqcPk+egrdQKGsOCW1VHE5I/uhIboimy
 5ItTOFHFDgsCOusQ9Tmtqorqn1uvhIMtMaN/KvPwv2Wi9JSFpnx1W66sy+foepdeZOKFsyMdjYN
 znMvQLSGUcp2vyaRYzfc1pdOGFbj/Xfj9epDon7ESv/kpa1DLvOIVtfkKGdgO1u4zTcPLOmbnEL
 go0+/2geKwYZOnWIjnLoVeoF68WpK2iYvSXaMcgFfcqY8kl
X-Google-Smtp-Source: AGHT+IGP6kebeC2LPTZKsaekqtLwTbMwJwKU++AiGWreRNT81i2UAyPKHUX6eLm0bHUzXeFOqlpubg==
X-Received: by 2002:a5d:6c6d:0:b0:382:3afd:125d with SMTP id
 ffacd0b85a97d-38254b0422dmr5944667f8f.34.1732208787943; 
 Thu, 21 Nov 2024 09:06:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad627bsm56549f8f.12.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13BE460406;
 Thu, 21 Nov 2024 16:58:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 18/39] tests/functional: avoid accessing log_filename on
 earlier failures
Date: Thu, 21 Nov 2024 16:57:45 +0000
Message-Id: <20241121165806.476008-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

If a failure occurs early in the QemuBaseTest constructor, the
'log_filename' object atttribute may not exist yet. This happens
most notably if the QEMU_TEST_QEMU_BINARY is not set. We can't
initialize 'log_filename' earlier as we use the binary to identify
the architecture which is then used to build the path in which the
logs are stored.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-19-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index fceafb32b0..90ae59eb54 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -81,10 +81,12 @@ def main():
         res = unittest.main(module = None, testRunner = tr, exit = False,
                             argv=["__dummy__", path])
         for (test, message) in res.result.errors + res.result.failures:
-            print('More information on ' + test.id() + ' could be found here:'
-                  '\n %s' % test.log_filename, file=sys.stderr)
-            if hasattr(test, 'console_log_name'):
-                print(' %s' % test.console_log_name, file=sys.stderr)
+
+            if hasattr(test, "log_filename"):
+                print('More information on ' + test.id() + ' could be found here:'
+                      '\n %s' % test.log_filename, file=sys.stderr)
+                if hasattr(test, 'console_log_name'):
+                    print(' %s' % test.console_log_name, file=sys.stderr)
         sys.exit(not res.result.wasSuccessful())
 
 
-- 
2.39.5


