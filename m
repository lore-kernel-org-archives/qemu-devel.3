Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1250DC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbB-0002PG-0z; Wed, 16 Sep 2026 11:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rac-00025I-Cb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:26 -0400
Received: from mail-wr2-x20.google.com ([2a00:1450:4864:30::20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raZ-0001NC-RX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:25 -0400
Received: by mail-wr2-x20.google.com with SMTP id
 ffacd0b85a97d-482f6356256so353287f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572622; x=1790177422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7FptWd5Jg1/aZvBoGje7ZffIe7jR1suwzb5Czmj9/aE=;
 b=hwZ91cCz2N9uNeiRNPrY2F6lCfoolTl7/XprI4NmDK98wVkupIS5IB3GS1NrZWSi+C
 G0UMaYtdPtBhkLSPogTygNvohDia3wK+uZ/8AMkFWTUARNpWdOiH7TnOyM0+b6JHWj9w
 dRBT/7cJ1ButmyN1419Wmn6wKcx5m8NG6B2DXXry8rhiy9cvYapwhFx9SpdFp4Dn3oxV
 Vq9cpozVx6vD1WMJ/d3Tpm4WM/WRpIy0w9o1uf9HkWNsdrnCcu8iX24By/V2HpsKE0OG
 4gtwR/numxei1UnGwaJ0SXDSfq1njX/yrtkc+nWnmySm3FhakqNbhR6xvQtKwSzqyuRG
 1gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572622; x=1790177422;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7FptWd5Jg1/aZvBoGje7ZffIe7jR1suwzb5Czmj9/aE=;
 b=PQOr7x2N2yyy5juaocM80SY2yqRe0lLCPQkq2zsY7cpUMWDcXp4koqHjO8mNTEjajz
 C9uriM1w6P+niTwCGyBaybAzcGtJ4c0b2R4SkEaijIj9WUtf+y5PK70SGP8OFDK/h39M
 ao6pxHIpHanfV8cPe+KMKiT8tL2MtTLamiU++svZRfbXsF2C2l8sncCQn8Jnf/H3+XsV
 WGLlJ4qtBBHvY5pTchL3ZNeC1zxYrzbcMvzWQHVQlWWHFJIPxfFCawPW05CcvBWTZYjB
 /YDwYDCs6hjNZTkQtSTp4CbaUk2qXY/bprb/7XAYJXNP7w2CglMCt5hsplAPJZ+tUA7M
 Vt2Q==
X-Gm-Message-State: AFuF++ngGF7lPGQu4zPheL8FgFS5azW26eKRJB4r/OnN8FUSyDm7RegI
 5VkJ6L+vijQeNnd2kfpEbUMnZlq17DB5EBTjoul60VQ7M9iNjwxt9A0CFG9VZ/AGfFk=
X-Gm-Gg: AYBFou0GWXQouMg2YfJsnU4V6wf6HPegIFm22/5zowwqcbxi+9WFg5ZOWFMIbNddoTG
 n592HoOUCcmK6QGFzBnG7yIS82AFeEqrj481BjgbYkVGPBbmOWAWcAo4NBIoNVsxJj7guGD7y8L
 uMcraBmxcy1MDhuk/dmyCFWZ9N0dd+qeMRYX8uywWQdQtc358O5c70yV/n9UmM6D6yOqcZdYscI
 rY80zH8jrYa1G54xYVZtQEcqi/gPBRSsTAaoAHryrH+n7+u9uSju4Jz0PIF75XvPNKlgLGLUpEn
 8P6P0a47N+7lLT5h4tzqEuutlWGZHLtKCy/f1asC63HEyMER/gbSow5KtW8FDCnCy0Q+21EMiWS
 yIpGf1iQJzlE4igdqt1nAujD5Wl28hECrJNuXtp14A2O/Xm/1Mgt7WsOqtXkPuD7OGleFcd1r7Z
 4GngLWYES/N/5Qm54qXiwgrl7w5iaKXuW4xqu1zhkmyY6Wgy7hmS1GTlTONblLkCooxidprRU=
X-Received: by 2002:a05:600c:3e16:b0:49e:8222:3451 with SMTP id
 5b1f17b1804b1-49ea20b46ebmr40693715e9.14.1789572622122; 
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0efce2sm1100205e9.6.2026.09.16.08.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 99223618F9;
 Wed, 16 Sep 2026 16:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 04/19] configure: correctly honour --disable-containers
Date: Wed, 16 Sep 2026 16:29:57 +0100
Message-ID: <20260916153013.2134555-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::20;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x20.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The configure script originally only probed for 'runc' command
in order to handle cross-compilation containers. The Makefile
under tests/docker would then probe again when used.

In order to eliminate the additional probeing, we changed
configure in commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
to always probe for 'runc', so the result could be passed
along to tests/docker make rules.

That commit overlooked that the 'probe_target_compiler' func
was relying on '$runc' == 'no' as a proxy for the state of
the --disable-containers arg.

When we started unconditionally probing, that short cut no
longer works and we must explicitly check "$use_containers"
too.

Fixes: c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 6084a7a065e..4c7bf406b88 100755
--- a/configure
+++ b/configure
@@ -1401,6 +1401,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
+    test "$use_containers" = "yes" || continue
     test "$container_command" != "" || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
-- 
2.47.3


