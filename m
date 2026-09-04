Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E60C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJO-0006CR-Vt; Fri, 04 Sep 2026 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-00067N-Ot
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ4-0006n2-TL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso1155202f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525968; x=1789130768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dt4brfYe1Ld1KcNl+DvbJ4Zd86uiFSmHTQrc5YcISFQ=;
 b=ZjKI0Fxza4+1pR2Rs6SrbyZNE9eeeO6FJ4dYPDAsq9kisCPDCht8vsPN9QohCVkBXR
 p+zhS+CrHz2Z0ET+UFK3XUx+5AGgDTbIr+eAcZC6oy19ET+1WvtQVmcMvcaspe6EPKbZ
 aYOuLv2qFmvhJ0uizIVu50hspQPnj5q1bJtqqRTjv7JF8GXmTUHb8doFSl5JJXgAtIP8
 s9NkYXa5tyh/JR+CkyZ+8zuIuwK7Cjvp+2Rl+wicP9IkDoOTy23Ezkei6WzEP8bduUPy
 n2vMJbGOul9BsM3YH2zceLDbSgfbd7nIbiPO+8txMnEONEMUpDmG5TJ27rqW2oqZYG4l
 ZNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525968; x=1789130768;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dt4brfYe1Ld1KcNl+DvbJ4Zd86uiFSmHTQrc5YcISFQ=;
 b=clxyMXomJ1f5X8vEw8P9M2Tos1xUq9ukyvcYyaggfLWr9X9BvBa1Mru/yD700LIrvS
 a4WO1uK+YpsMa3VT0GxP+vqkyETqdbuTdhhrxi225z0Ix59Yqtmw+GPk9U6OZRHucO8Z
 595IMfRvSDeDgrDpuswf/KmkZj9OfQd/9+MJNfphzB4s1Qd+vsBmm3OP+tR01MU06bCv
 IoBswwM/t23qJl/+2JHNQDt0+oqNE2CBW/6SFihTqZSqRnPZfWvL+fA2kmpEJJwo1EXV
 QkA3JRDpULph9qn5jKM+ov1VpGdyXgL2d7QC6KMkzEghW/MEHebsJ9Vjeownjt5A7mxR
 w9CA==
X-Gm-Message-State: AFuF++ki0BHCjJ7XcgTdEgL4c5lH/4RUlGD3NZSnHWbWsZzjVgDEIq2x
 x98G83uaU3rWG8LKuVg3tanKryWJr3+q2ZJcCAKJ87kWRczewlYs8ub4w1/FDmgWXHg=
X-Gm-Gg: AYBFou2oLYEOPacjY2H8quKox5RO/bLQDH2pYjz3FjBG3xoocbWs7qoykZjfHILA4xI
 7cwWL41NYarI62WHzmZqpyTkqFttfg0oJARPMxj/Sz1Gytu7MUGj9sZaR6A3nS8WmbIJdHDKw8T
 b492rQeLtefwOSbGt4vv8fDDQGmZf/nDCYoUK93o4MAKmj+WZO4WbUejEsJkVqwWmTMzr+c4DVd
 lPTAh+nR9cAwLTzn5hqKD3CAllVdlpOgJPIn3Ly0/vAejCg+lC0afEjE88AFwo4RkQm6reKYPsS
 Y/bpZXo/ZfL3I7BUrRP7Bm2W5caqtwxm9PwsdSLxQC08ae1PjSheBzynaJlzVzf7QnT4sgwYMjp
 JImoOg8ru/vdzJ1GAEn+1z22GpLgPVN8LSn0BAOXLeRVmS2ReGIQ4CKLkAQawiBgvnehY4Fx/q/
 BdUDb8fIAnml2G33I4eK7odYg+fRwKbetQiP3d4RMZKmwLGSWkX0ORSHhHBnWe
X-Received: by 2002:a05:6000:70b:b0:485:8be1:378d with SMTP id
 ffacd0b85a97d-4858be14b94mr6904142f8f.12.1788525968274; 
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm6565213f8f.10.2026.09.04.05.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C51165FFE5;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 004/105] meson: bump minimal version to 1.6.0
Date: Fri,  4 Sep 2026 13:44:18 +0100
Message-ID: <20260904124604.2207440-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-5-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index 5c9de307b08..0a64bcfc6e9 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
diff --git a/pythondeps.toml b/pythondeps.toml
index f0f3af915a1..e4c10d4a9f7 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.12.0", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.12.0", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
-- 
2.47.3


