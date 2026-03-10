Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299ECFD88CC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06P2-0002dx-VC; Tue, 10 Mar 2026 19:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Oy-0002V5-21
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Ot-0008U1-IT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso23016475e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184925; x=1773789725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBVK7S1FNfsvh/lLwgB2rZVR8RIVo9HUkZZlR3Lzmog=;
 b=N/BdVpM+QIl4HjnLmrLbUNjmAl5oYI9LU3onvfN4xrkpHpvyH15sSle9Cz6s5X9TWV
 ZeSxV45k2tOLo8c1VboIdWnDbQVb6c4q1mBJK+G/gWtr2XJgtrsWBZRpY5PnfWUcsoGN
 ZV791V3nkXOySAF+0pG7NM49hx5H3Pyawe8SqKz/pa7bpxVJ6v36eeHnVMdWssOWjXUG
 MASQ5iu9TBi8cDRtU8ZBhmref59xOPoYREclh4jDkLlzMkaE6Ud4mQrRnyK3ph7GJH86
 uA0pHwtsnmbHaYMqd2Z/Fy7N26oNoAFzGeQZGg0CiZ7NGjz9S46gpfdtOMEKaK70C2tY
 lf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184925; x=1773789725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBVK7S1FNfsvh/lLwgB2rZVR8RIVo9HUkZZlR3Lzmog=;
 b=iF67u0FgNDhroYuzL1Mw90/5kWGu6Hx1Owf+dB+F4OeIuyZfd7/og7lX5GAqJhZUoO
 faWHszzne69gWdkSmDfA8DTMPGVDBnboDfsmoBHPsZytQ3ZTQeHt6JVbyTjXB7jcNPwO
 GpyltCsckzCaHzc1M8pE1Xz1DtYub3mIts7CkKffKUT/Yb6gFJufGxKKmz5zcCzuFSV5
 9PokxTVIdqwN8xuwvTKBBBzPU+tivffvAhgck8n/YnV8/TRM/EIkuvDnYxKouZMMW5zD
 6xTn7PKV8yGluhPQ4xXfpme+aEeVELd7IWcJvamGkgeCbMDlVE2zDG+1nsQ5ahfdM0ac
 Fb/A==
X-Gm-Message-State: AOJu0YzavZed+4x4lsbbdvnBQcAoNn521LHf1Lb3qar24FtcX74n2FUS
 1UC41b+NlrMPk0yMba/YGBGz1cEGFGwJCrq0+JbVcSCcmk7sAFYbA8+TN8XO1VLFRkn6yfeyA+P
 37UgoO68=
X-Gm-Gg: ATEYQzwiN/M8GnPKOD4jF4JHIpfpvfXk9nojia1pWAQIa0h7iYTVdxaeYul1JrWbS1H
 j29GkYnFI7cnGIy+TWgcDKxRBtA/n6MGMrLVxV8hpodJUcchAFviTSfiwXxsth9ocn5UlfDnlq+
 fanpqx1x4RlMzTqzZI9z7/Zq5n8W3a5/7WF3Ffks3vUDPZN3KnRRwkIg4NP7WMXsCN/1Qj33iDg
 +U1LWV9LgbRbZkOnPG+21RYjVVrWKkGHH66wC4dHbaqL4WIb34GzYm3ezrC7dLnZGQMOd47R0sg
 p9MMzSGvRrafRHavkhwhSZiT2EzqP/BtcaZgwKyh5bSjeqZFxl1AXoJbNDB4MRFhNFjrvwKPi3b
 Q2iS/jHaeQjiizXAUF4OG9gDUCNjCWMWmLiiGx9BTgLLu/quu/MUl4qYwTVmHh9bfLWRNIL/G4i
 enTIpBlcu20sLGsz8nYeZpV2NNQO4C6burms9So8uIvum7dJrm0/EZTrx1GaLLBNUAnsjjkJB6
X-Received: by 2002:a05:600c:8b0a:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-4854b10c998mr8941095e9.22.1773184925461; 
 Tue, 10 Mar 2026 16:22:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6070acsm5494495e9.8.2026.03.10.16.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:22:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 11/16] gdbstub: Emit base_register index in GDBFeature
 entries
Date: Wed, 11 Mar 2026 00:20:39 +0100
Message-ID: <20260310232045.58440-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Record the base register index in the generated C file.

Check at runtime that either @g_pos argument of
gdb_register_coprocessor() is zero, or it the base register
index.

This change pass 'make check-tcg' test suite, which runs the
tests/tcg/multiarch/gdbstub/registers.py test, itself calling
gdb_register_coprocessor() for each target tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/gdbstub.h  | 1 +
 scripts/feature_to_c.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 79e47a024ec..75eb4d9c365 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -6,6 +6,7 @@ typedef struct GDBFeature {
     const char *xml;
     const char *name;
     const char * const *regs;
+    int base_reg;
     int num_regs;
 } GDBFeature;
 
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 1329695ad04..a52cd2e9ec6 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -102,6 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
+    sys.stdout.write(f'        .base_reg = {base_reg},\n')
     sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
-- 
2.53.0


