Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4057C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZW8-0005mO-AS; Fri, 18 Sep 2026 10:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW4-0005lO-Kk
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:40 -0400
Received: from mail-wr2-x1f.google.com ([2a00:1450:4864:30::1f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW2-0007pG-PH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:40 -0400
Received: by mail-wr2-x1f.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so423244f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741477; x=1790346277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xbxC2j4wcYFekiRIr5rG3ctSTMf4NNM4fAwgS1HeBx8=;
 b=bGI0ibzBhDF/ngY4kWeiE8uVMs3JShX+HzXVcFxSMeXwST9YJb3tKEeO/hNsTp+t+E
 CdlPManSUsX1p9e8OKtWIj1H+koNxQLMcdj1WBWPiFvDg/73qNpBdVeMGJ9PjfhFwsmf
 i4zK9Itj/RTU9oEDCIJV6QBA1XQCZ3CJE6kwRl6pf9ERUa+1hBzo8VO4AyQRCD8Fh97/
 +GNbaGGK3QAnZ4lE5rXnq+rRJZQxW2NdVhdb7jcaDmpnSXYHlqPlugFmCl7+frsYVV9A
 0CXO5UnhUPXNp7BAh3f8PJopRjqwt/nIac29uKudBBO9PybGUanqMpWcOCvayjJm1FoI
 vDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741477; x=1790346277;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xbxC2j4wcYFekiRIr5rG3ctSTMf4NNM4fAwgS1HeBx8=;
 b=HcIR2kbvyM+XCUrs3A6oT1mDgMweBHv+//WIWWUQXK7RTuWryVWRH6CH0kAXeU86kk
 kc8u1Ko0szCCMcx+/ww6ZO7yfhvtfiMEwjDKVkxlhbBGLzioDLl/YWHxRdJBLA47gAxa
 WudxfIq81ovtcpN3GFvriLlJnHaI6fuJNQdJJewTI58MA0kCeyI2JraNF3phrIzkFZ1N
 oThZYFiegJRinChblthWPwbv3e+fS+xzbkrOXhI6WJFNnRNqGZqGGxCe3+wZVubYT3gO
 T26vxZ3dM+Woy8oaQZVkP9Ll3PRwAk5Gj/zXiiYg+VMnOZkN952uPug3mo3iKxPdZeSz
 Sq7w==
X-Gm-Message-State: AFuF++k/Nlji6LkuwimvMSi0p/L99mw0KY1IYvX3EcNO9Lk8gxGKmuyC
 qt1o7LJwbwWo5SnWGNG9ls3h3WTaEHrOxEHZ4tIisniPB0gWW7/HEfX8OtQW1vGMXWY=
X-Gm-Gg: AYBFou3JhQa/CgEmxcI9kViQSJVEM3mUqLQ83Kys+PyykRu8CxT2T3OXgcZ1lmyf3Iu
 fAQhcwr4dBGqGcwJUjB6uwh3HmIOZ58/bOZgAPA+vDNVZ7CUedxyjSPEbwWSfIJHM7M9CNEc8QT
 KGrLEUHvGh52Q+bExvGNlWeMFqkivTZGOIie36neTfM5akLiDnQKgE7Y35YvG7mkdD+g965Vh+6
 9KKYqv+ILdN1cdAwZcznwHgARjtHR1zj5ClsD8dDHlERHgJk/tYOvycUjTESCvvBOVGkOPlUn3b
 5rfSG5HtM+d/2B40O0y/efWi1ObUFKXDudmtVqCmBitxwW1QSwq62i4fl1J3b4k6oThwpItQDpZ
 ImDDOzP8sCds6gMOqkhoAnsCgZAyP5694Y5fB0bKyE9oK9AOSw3tBIuvR7rxzzj5DmbOB6KUNSe
 jVV/50x0Elk1Z1ZeHE41qHXKKwdmdWC4pm4SGugUcn+8JEvEpHNx+geBYbDI/XT5LaotedCS8=
X-Received: by 2002:a05:6000:490d:b0:485:8a47:5b91 with SMTP id
 ffacd0b85a97d-4871e36cb87mr3443956f8f.46.1789741477096; 
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4905492f8f.34.2026.09.18.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 05F385FA62;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/17] configure: correctly honour --disable-containers
Date: Fri, 18 Sep 2026 15:24:15 +0100
Message-ID: <20260918142429.336497-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::1f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x1f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260917165602.3405537-4-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 8f8fec4efc8..04e312a111a 100755
--- a/configure
+++ b/configure
@@ -1397,6 +1397,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
+    test "$use_containers" = "yes" || continue
     test "$container_command" != "" || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
-- 
2.47.3


