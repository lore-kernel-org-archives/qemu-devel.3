Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb785-0003uD-JU; Mon, 05 Aug 2024 19:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb783-0003qW-Fd; Mon, 05 Aug 2024 19:28:39 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb782-0001OV-0f; Mon, 05 Aug 2024 19:28:39 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cb81c0ecb4so4379145a91.0; 
 Mon, 05 Aug 2024 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900515; x=1723505315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teGqMchYARnIAhasEwslauOJTM1BGvTJjBuj5K3TcCc=;
 b=OPiQfqmdEPBq6pCvLcWFHfaFV26kXiSNzQfh4m62R4en7ZG6pkExB8kRQwHz6Aj0XY
 9kLyLKG1yiGuE37z92suc7at6wQtOd5rhySJ+s1J7x81xAdvsbCo7KTT3gqT8KHx/dIi
 Bs7OVsde6xOaFfDVMMkzhhIwAFOaNGDL4y/g4Hu18HQhqpr4/q7WJ0nHTXmn/sjgGqK0
 LhyfqXTHnoQX3VtG5z1j3L6RaBsQSMjVnJ4rI85bq0DeZZK1Y1BOal1w89B0fzjssDw2
 9X5XG/B+z9NSRfhq+vcrLwH5tN20JyhRa+sb6+NGCaMyWd3FmfngmnRasY58T2rklU9F
 gkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900515; x=1723505315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teGqMchYARnIAhasEwslauOJTM1BGvTJjBuj5K3TcCc=;
 b=Lzd4mjCPKCVC54QucR4IYCXAaPZZv3Hh6Hz+ZxMcO/LNLz0sz195BeVsTvb6hN3Xn5
 YkWqQgH1wpVSY0VlR5h9MBBAN+bfSAxuNlHidaYmvKS/FiTPJ21l6pzCv7LjGSvB72SO
 TBPmtYIKV2CFPl01aXBD4CYGD9gTabasQqjohfBdXUxCbzSI+j2EEcIivou1+OMf6+aP
 VMd6OaVPrSyGkL0WAy82x5tBQx+5gEV7cUlpsHg2IWX2QqeEnlWN8i9tLApnr45v02wb
 rjuG/I1qW0HcvqjT5NeX2SnyVk1MpvzhwA9I7C08xjj1N13Ua+6BDQEf04/So3EXh3N7
 ZtfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhWmJNUQPpGGBbm0JhoQ68/P4LhoUkq4In4t2qF04Exc2L+5PW2jF15/bdWIjxuD7brWWDKbzshP/bAVKlgUS4hnw
X-Gm-Message-State: AOJu0YyBBwQB5DxfjFy9SZrOI5RSBKxb8czD6SO6x/rmfmRil+k0OWzF
 7y3p4HbO/iG8wkS9vkqfLysBp6llWQKDLJs6W0Cr/m1XB2WYftJPDt7udg==
X-Google-Smtp-Source: AGHT+IFAu5Zw9i0YLM9AcxI4U8+QhSUYZrYOXLED8D1P7g41N8yhJm2VVMy5CAk7rZ8PoELdpmyRGw==
X-Received: by 2002:a17:90b:4a8b:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2cff09346a1mr22359425a91.7.1722900515310; 
 Mon, 05 Aug 2024 16:28:35 -0700 (PDT)
Received: from wheely.local0.net ([1.145.206.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb390be6sm7659100a91.51.2024.08.05.16.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 16:28:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] tests/avocado: Mark ppc_hv_tests.py as non-flaky after
 fixed console interaction
Date: Tue,  6 Aug 2024 09:28:13 +1000
Message-ID: <20240805232814.267843-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805232814.267843-1-npiggin@gmail.com>
References: <20240805232814.267843-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

Now that exec_command doesn't incorrectly consume console output,
and guest time is set correctly, ppc_hv_tests.py is working more
reliably. Try marking it non-flaky.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_hv_tests.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
index bf8822bb97..0e83bbac71 100644
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/avocado/ppc_hv_tests.py
@@ -45,7 +45,6 @@ def missing_deps():
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
 @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class HypervisorTest(QemuSystemTest):
-- 
2.45.2


