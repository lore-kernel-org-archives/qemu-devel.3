Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DEF4613C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heJ-0005Jl-ND; Mon, 23 Mar 2026 11:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he3-0005Ef-1X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007t6-AN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:46 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b97ed4ad579so471589066b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281400; x=1774886200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcNNN6LnbCh2h/xUZIidQ+ou/aw5Az+bDe3k4kAEWNk=;
 b=XoD77l0zjoeKfSQVRJYARIVaeZYil3HZLlsY1/9Yjy1+86jYmExmsGZPlQ2DgsI8tV
 gq2jhsc7Kd8zCqEhPtktFOvFIBNe/A70JSBYFXAhZ+IpzMFFjLFdBXUNGCtcKuJRVmgX
 IBrE2zTIQgbyzNyNNzQBCvXNJxUi0MB8noofLPPeXN1YuP/gIEG29r61kZN06sLEBVHd
 dt+qrwT4Ww+zQO2Tpjwn2B9ngkA5uyea/SL++6drQMBfdFiI9Ss6sU7iBKK4zn9N1fR5
 Bef7UXz2Y7/LSvBxQe+RBV5dCus8cddUmLxfm59y8WkfSXvOrGg0GxYp9lZzYG8CJjcd
 EEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281400; x=1774886200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcNNN6LnbCh2h/xUZIidQ+ou/aw5Az+bDe3k4kAEWNk=;
 b=hEsgIClA6Q+Bc7dON6sQReqNitoespSTGS2QL+/u8tdeoQ/hwsXJtC1T0AZmY0s3Sg
 HxhORcI3kBclaGB8pRNZVy/qCRDOMWQVRJZQctGOuccGX4rGkVH4XTlh9KWYT+x8qgVu
 7uH9b7mwatBCVepO8SCzxGMzdMC7hSnGj+VcfRMeiP/ohZnib6TmhNMav4fwUAPB7QdG
 TeasbDevCO1HvTUQ8UqNheIURtAH5U6FKi1CgfCUd22Hn9HTlz7OkyJUxyYd0VLgBAf7
 d1ugPYGL4aVQYydFeAI2XdRTLILIME8nkFnL9qf2kbi8UuPunC+2Fn1oRH7xCa804UuJ
 AWxw==
X-Gm-Message-State: AOJu0YwsiIbHIUvmDHdAyTHPhStluGGM9xRiw/5tawdBLSCpZQoRl41q
 BSlDaS9ShIL+I3rB5J9pRvs82SbTbAerJJS1lqGrwIJPXxf6jwwYfVn/T/u64RdgKj8=
X-Gm-Gg: ATEYQzzQASlosHf7byZ4GDl3ztNzDhkcPwUuoQyeKPGVP8jQ1xA5Y9aBmh6qJBjYUHC
 YRAjSoVQzMZw76d49EVdSADUTWna+co9kax/xCgaErdtVQyBp0MSllgMqD7H7vOx37+MaW7nHm0
 9FCNsjsz+7OPPOWfvPiNhzF+ux1qBla4mXol7P6JmxgXozWXbB7aVSUzzFRyFrZdDyCmyV97P/n
 2xQxm1cRbr5q/dASxUb0Zrq5pgpJsjEpYly2zO5R/C08HPP/o9vHi4dHB0LJo2IMxwiWYT5zBF2
 Iy4Cvajyv8x0mUHNpzPNE7rs1K1OC+hX/fkcY6Uy4dTG9CSUQK5gagWnAo0VXsTmDzrWiNJo7Rf
 nnRwRBNrybUF6pi1OcThDCx/f4zTxr3U3T6LtWQwvKRGnNrDV7EklLQVnGWs9w3+g4EdZt1+NFs
 0FWsPMdXewc/WJ1AwV0XxDwdw=
X-Received: by 2002:a17:907:1604:b0:b97:edc1:f9c4 with SMTP id
 a640c23a62f3a-b982f1ed7b2mr965827266b.1.1774281399873; 
 Mon, 23 Mar 2026 08:56:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983e4e9b65sm409956366b.31.2026.03.23.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 138FA5F81C;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/8] tests/tcg/multiarch/linux-test: use portable alternative
 for dirent64
Date: Mon, 23 Mar 2026 15:56:31 +0000
Message-ID: <20260323155637.145015-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

dirent64 and readdir64 are glibc-specific and not portable to other
C libraries such as musl. Define _FILE_OFFSET_BITS=64 instead, which
portably instructs all libc implementations to use 64-bit file offsets,
making readdir() and struct dirent equivalent to their 64-bit variants.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
Message-ID: <20260320155107.2143191-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index bf6e0fda262..0fa3165602f 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -16,6 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _FILE_OFFSET_BITS 64
 #define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
@@ -83,7 +84,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent64 *de;
+    struct dirent *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] = "/tmp/linux-test-XXXXXX";
     char *tmpdir = mkdtemp(template);
@@ -191,7 +192,7 @@ static void test_file(void)
         error("opendir");
     len = 0;
     for(;;) {
-        de = readdir64(dir);
+        de = readdir(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") != 0 &&
-- 
2.47.3


