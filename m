Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33BAC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FW8-0007J9-Bu; Thu, 17 Sep 2026 13:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVs-0007Cz-20
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVp-0001jo-Dn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48586861639so425738f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664584; x=1790269384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qqeexVrUP7S+bjRwHH7RDoI2I5dpPVlDr3aItml2BS4=;
 b=ECgwnMG/2UYlh/hcci4GXXTtcKqY9VEvDnFal2i7mP+98sgXzxYlzAHA3NAHUHNs4M
 hUAQeYQh/DK/1AkU5VpYM3gDNUZymoT/B2Z64RFwHRBl7YY5mkd7bP9+dcjB+Vb1dXPT
 DUH0TXWQ/qPJkIC6cX1ZqnoLca4XY7W2S7AJBgdvUbbJTWiY1YdXf2cIzUb51uUt6Ypp
 YT1cEq4pTsI4+mxggqARQAToq/pfjaYp3L1aAClflQKbMlsvX30LRN/xOvzBNfkRcRYP
 kiLxLgEocOJ1SBE2yxDWYcYk4QRh5oTw079X720FG9sAsVcPXxaMoM0l0DRCONo05x9X
 vUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664584; x=1790269384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qqeexVrUP7S+bjRwHH7RDoI2I5dpPVlDr3aItml2BS4=;
 b=F8uQdc7l59/oIGhTaWtq6/qYsDExRXoEZ3zNfu4J8Gi4hkjbq9rgMG6GJun4JaFNy0
 D/T/m19XppAX/TJx+wlq5kY1ffIVoKtPlxUuVRuH28JoubQ+W+AQAcpMNd++Tp1WOmi+
 vHcyX0KnOtmwFdIMGzyxTR4sbSWqwTqWndaqcDvr3V+tvx97cP43Ykm4HDcLOSw1399k
 LqUtvt0x3HTB6Cq4r9ovHfq3n5dfInHVVEFytgF2oONTJqHCfJ09GaPYcw04xqkN4CS1
 D25vIljCCl/1acS0Hw+GgJylhx/1JJZiqVU7n/CMX2GlX4EEoMq13UClOxkwvfNPqaY/
 TLqQ==
X-Gm-Message-State: AFuF++nOLv0Ef9TEAwMWm9PzDy3+bVcy16NphvzcRSJl0beyddDzkySI
 nZsgjYU81NIDYIn7AgnKbpbrKsFWGEYN6F2yIyVleUhDJb9m8qmfsvqky4SauPCGf9Y=
X-Gm-Gg: AYBFou07Hw/SpHoaWcuqbqy0iw4JA0husBXyE3XoItdFF93DVBbs4yaQ3uEtNcDxAJ+
 kibLs8Z05w/M6TCD44yfbgGlEOA1WN+OfTawDFdfUQVeRgAd8n1ct1tzNeVLxnkGtPur4uPZEQh
 B2TP/A1gzHYpv3jNbm6/mmNK9tSZVHW1GsIs9Odgzv8fahJiCapFTO6LRl5NmRnE7z30naP3hTS
 N+xnGBipwmC3xia5z3gQm2P7KnZdnuTWzQPbq/UhYcWFnVvJy7PvNDbuPAmKhK1QihGR/20CgH7
 2cbYVr0nn3FIbl7SqTAeNVvqxAFsYHuxFjic6Uu7s3Ff+KLi5Ji4Ua4LOPtquBwPwhVlRRSx+b3
 zJqgZAnNU4971eJAF2vSQ/TU0c/zWRAQcWGV3owjtziP0qQSUHApFPSn6FHwRaBnMhm8OAHxQp5
 Rl9Ta8TPSrj6BUWTqxwHFlruOM5ae8YiDij/tgl+e0dVlRq7EOmZ8rriTpZGz7qFNmLlYx4q0=
X-Received: by 2002:a05:6000:2992:20b0:487:64b:ea03 with SMTP id
 ffacd0b85a97d-48713c056damr4437989f8f.10.1789664583856; 
 Thu, 17 Sep 2026 10:03:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf418dcsm17047776f8f.35.2026.09.17.10.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:03:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0001E5FEF7;
 Thu, 17 Sep 2026 17:56:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 17/17] gitlab: drop check-tcg from clang-system job
Date: Thu, 17 Sep 2026 17:56:01 +0100
Message-ID: <20260917165602.3405537-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

We have no cross-compilers in the fedora image so don't bother trying
to run the tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 5f21703645b..a97cc0b20b8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -441,7 +441,7 @@ clang-system:
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
       --extra-cflags=-fno-sanitize-recover=undefined
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
-    MAKE_CHECK_ARGS: check-qtest check-tcg
+    MAKE_CHECK_ARGS: check-qtest
 
 clang-user:
   extends: .native_build_job_template
-- 
2.47.3


