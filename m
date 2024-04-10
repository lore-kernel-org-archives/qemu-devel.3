Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B16CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTO-0000Nb-KW; Wed, 10 Apr 2024 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTL-0000JR-ED
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:52 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTJ-0002gI-TZ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso6967947a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765207; x=1713370007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5X2EE/M3HTtZrcc5pc+aHgL0l0ZN+IEz6DvlLDGmqA=;
 b=UtA37+7oTYMelq7k448ihPlbDkjYlIPJzSwz8VumbZKf/pF3hexQo6SsttMoHUdtiK
 YMgI/m5zkMOng3fTE9EdsLwljdiNCcaYWLUyAmfMBJtLAB5+I1EqJ3dOxOUeylCN4P2A
 NSCp4tJ+QB8Kz/CZD8yj3QVEWVRdgKtqVBvCHD9/yQ01Hd8wcKDqu0b9+XvXammHPPV4
 8jWqxoFIdyCOEcYvoxbtbaEd+gu0YilUoTws2W/QBevcyVcJ1ZYF1f5p8L6nbL+BLoEa
 3uSNMwIAYNS4jhEQbqqMfYudjctp0SJYk7k6gP+xQ8JggrInNmMzT876qIwe9Tu0krCE
 i4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765207; x=1713370007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5X2EE/M3HTtZrcc5pc+aHgL0l0ZN+IEz6DvlLDGmqA=;
 b=ZYwFhOdDKlzj7Cgkj2Lt6BT04IimJmswJ8gLHBnV1rzQPlQH31K1+8E22BVKk8+kTO
 Y18qtV16GMy5qsL4U4WvwdJnl2Z1zbhS1uwrNFdwi/DT+88hAUiF9uRF+p5rkaeSxn5m
 xCBfzmL17Ybb9DmctutCJaS0lfin3j5X6dsOuq8gI/Y1mN2A4CjilxHOB+jSeKSlHv3x
 fdRO5PTF1ZbSsEEGTFVeKyRrE3EGIRynxUXM6uyxcH6sA6QiPt5z3moG5v1I5rSGFN9k
 noujOOARyIxYBSSCPL6sr1nwZgrT5tT/4IEZs5y8KDNx4BKIgrqB+F0nFV+CwGGILuzK
 U2FQ==
X-Gm-Message-State: AOJu0Yx2wUBeqidZf7eC9yrg7Ozf4p5PBy3krmbMDh0cYEoSkz0vdSk3
 kSL7Ljj60iz2vMD2/uUUmJm5WdSKY1d8aebv3GbTT0TIHZbK3BzuLTrTYU299KRHPOvFV4ZDTLS
 P
X-Google-Smtp-Source: AGHT+IFSU8QhZJ4lQzOID0Zh53L5RD/dqWOz4QO8L4DfCDxmNu2sjTBkodtwB/dwfPNAtA6HDwRckA==
X-Received: by 2002:a50:d613:0:b0:56d:fdb3:bcc0 with SMTP id
 x19-20020a50d613000000b0056dfdb3bcc0mr2519771edi.11.1712765207148; 
 Wed, 10 Apr 2024 09:06:47 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 k11-20020a056402048b00b0056bc0c44f02sm1268403edv.96.2024.04.10.09.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/12] system/qtest: Replace sprintf() by
 g_string_append_printf()
Date: Wed, 10 Apr 2024 18:06:06 +0200
Message-ID: <20240410160614.90627-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Replace sprintf() by GString API uses in order to avoid:

  [120/169] Compiling C object libcommon.fa.p/system_qtest.c.o
  system/qtest.c:623:13: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            sprintf(&enc[i * 2], "%02x", data[i]);
            ^
  1 warning generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874..22bf1a33dc 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -601,9 +601,9 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
+        g_autoptr(GString) enc = g_string_new("");
         uint64_t addr, len, i;
         uint8_t *data;
-        char *enc;
         int ret;
 
         g_assert(words[1] && words[2]);
@@ -618,16 +618,14 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
-        enc = g_malloc(2 * len + 1);
         for (i = 0; i < len; i++) {
-            sprintf(&enc[i * 2], "%02x", data[i]);
+            g_string_append_printf(enc, "%02x", data[i]);
         }
 
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK 0x%s\n", enc);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
-        g_free(enc);
     } else if (strcmp(words[0], "b64read") == 0) {
         uint64_t addr, len;
         uint8_t *data;
-- 
2.41.0


