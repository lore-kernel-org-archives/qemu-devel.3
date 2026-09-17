Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF84C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FVw-0007En-FR; Thu, 17 Sep 2026 13:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVq-0007CX-HL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:06 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVo-0001jg-Nz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:06 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so8037565e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664583; x=1790269383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tf+mkj5hW2gXQd4FRj9pMR3/7nIVm2YxClIiD4Ub4A0=;
 b=qH8bL8a9XnlYnjPAWvhPC283AA231wib9sgaqa0+fxAjk2FWczxZwUqZA0k2XGUMDn
 WFLrocsP5F4EnYgVGYzKyYfWcBFz0+RL3i2BuD+wxvXzXtjZDB20b1e8KDYHNmeiZrNb
 e+n43Nke6ryvA0eF7l5Mc9R6DHchLfcLy57qNfYqrBqPa12KAqEl/HTnva/iFuXN+Wp7
 khprRcbgHnh1m6h9VAkulxOoqdai1qS0iVyOcz3FQWpU/WW6R1aPK+mpV7DUoI4OqR9p
 kOHYy/Evkl7/LRjsNaRq7c90v+6Erhzso/nqVPK1BJvnuqvyQLjVP83h3xZ5hbrI+ifX
 lAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664583; x=1790269383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tf+mkj5hW2gXQd4FRj9pMR3/7nIVm2YxClIiD4Ub4A0=;
 b=PyCGAV2mmAjZB9gc2JVN8Ze0C+ak07O8tC5frUg4gL1XIvzzrgXx4ksJTyy3Fhev/h
 Upk/obpciMUFEs5tugvuJj3eJrle+dSJZmuvKa35RTCzATCnx9ezaeIPqxSdDbV0a4e2
 YwAltFX8I9We5Y5C7qbf2ZFEU8tHTtCD8yZBxBV9D0wDsoRZfKDvf33+i4zqewRv9e0f
 QnpDfTKzFyOB01lCjYrubEA+wTmXa2JgFjC+1wK8DVC8O/hHTmwgfmgPKwSfULVFPbPW
 XzLtGE23kC2yLQij+FFJZB19t0mj6GdHpE/Oxxi90A6lYCw5neFaUjnLBCGhTtHP5G8f
 GupA==
X-Gm-Message-State: AFuF++lB9ojb06JgnxS/0Y6MV+NTyvDtoWl4ncsrIoTv1mpBo7cGpdoO
 9DxNKrn6/HMxqcFONtsb47124x0t/pc64Frs5FKJqWTIGSHuRUTXTKRCDyZz3KSDB30=
X-Gm-Gg: AYBFou0GEvItK9v99ojxaMMw3kKg+kdTVnPFxMgcunBValUBJTPbbsqXGIzPvtl/9RB
 DqB4uovncnZPYlhYV3wYGEcCcnfDuaWliS8DG//m7sk6cuBtFthMVgzH68lPfLIMetfsVCKqAGL
 cuigeaFfY0t8ODcePegvkYXMsGitH7rOsPXmDcCvKcaQ4fTR+c75j4Cehr/oNw8kT8hiO9xwIHm
 eYujvZN6gCabC5YpM1PiIHM16km7fIqgvMQCVk7p8xtE7Qf/UwKZEdEN7K3SMn7IA5iQWQj1wRU
 UfZXtslCsgI8ctxHAL/la5ou65BQO6ik/A7ywnaCCfSZyBW/BOyEhOA4lg9Mrf6cF9n8vcPlYAA
 Iba3IGRzXAQyiLL+SHe64hjmhcXxhX0A7QJu6Mw5bF1y1hL5Wd2BG2ASitMeqGANkD5oqLZjWwx
 Q8mvsB4yfgbMh/A3IxU0gr9JqX7y5mVI9mT5ZvT7tAIXgpkpX0R1iqQAgpaTHyof7+TAcU3/c=
X-Received: by 2002:a05:600c:198e:b0:49c:fc6e:8cb1 with SMTP id
 5b1f17b1804b1-49eb7346e60mr90402225e9.21.1789664582984; 
 Thu, 17 Sep 2026 10:03:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm121609765e9.4.2026.09.17.10.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:03:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D967C5FCC6;
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
Subject: [PATCH v5 16/17] tests/tcg: Fix building outside of the source tree
Date: Thu, 17 Sep 2026 17:56:00 +0100
Message-ID: <20260917165602.3405537-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Running TCG tests from a build directory that is outside of the source
tree fails with:

    [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal error: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No such file or directory

This is because the build directory is not mounted into the container.
Add this mount. Do not bother with preventing overlapping mounts, they
are harmless.

Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260915110855.491985-1-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 95f533b0ab5..a5e0462732d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -277,7 +277,7 @@ foreach target, plan: tcg_tests
       mount = mount + ':' + mount
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
-            '-w', here, '-v', mount,
+            '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
-- 
2.47.3


