Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B50AD2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTF-0000pX-OS; Tue, 27 Jan 2026 06:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTE-0000o1-Ci
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wS-Sa
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so54469605e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514165; x=1770118965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lz5UZ2w/FCsEdQppyTBabPGaO3jaIlRCxXMzGz8WL/w=;
 b=JtpW9dfHvQPhCByPARunkLV6t/84wpoqlBcbetR1HgJFUbuVjlvFFnji/3CCZWGkRd
 +eSuyHJ4hYMZwhh6EKHISJ2pWNimjyeC+yUaIm8sTEIkC2ch3QsLrnSArFI2mSzamyeX
 2lo8eTzG6jXnQvr6Wq936+Ys6cvB21oM5o0pV+Fv6SEiQBoFT/GqGym2zsNniczQUEh7
 c712zxfesiWuy6zHQEc6yIXJBtK+JverRDk9eU7dSwWaaPd8kRhP97MIGha4QUk96dH/
 Py09Sa8vXR2Fw7DaExq5Y8za7BicYsK3bk9RaazG2JUyvYtA+x0kxlfcpIJldcFaM5Xl
 tZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514165; x=1770118965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lz5UZ2w/FCsEdQppyTBabPGaO3jaIlRCxXMzGz8WL/w=;
 b=IThVmubU0ipUTHl36NeZDzcJ0dP7jprXFGCTrzyYetWOennMG4nupHb3Qoc4r3Hm7d
 Pf4H/TI5/L57s5qniWGcnHS7Q1wKoJE0sU0h4iGT3h6+f1l08Nrw2t0fw53WyXWnVHK5
 Xb7nZJMulkpglzVV8Y4oMAPb3g8HJqeZC2+azQS0tU0CZcJfjj2kGzThbMjuAbsGXIxJ
 6URu62mRCIHhTvwQh73/5r/Cc650DkVF+skjhcznIGKj4PdHbPeVy6CaRJEvg66oJwRC
 p7JsWFTtxHE27lhAa6lI/GZ8Xds4sXcOgJrj5SBFw2ewXSU17YMd7RnOTy2ILRjzE8qS
 QR7w==
X-Gm-Message-State: AOJu0Yw/nJ8eIdRyOUdrTZ4u4qHL21+tWvm/YV9btzh1xiYqXPF7f1YD
 Oibug+4jMfUVX4dNvhMyNosPT7GzO3oWc+K8xURqNCQCnu0obY8TQgGeBtSqnRB+o8cH8qzRj14
 cUbjecK8=
X-Gm-Gg: AZuq6aLk5IMzqC+0/wkV9lI/z1sqzhk0BlJSFT63+la6w5sXIip/1dJBbA271VNu1Li
 7MXpm0QbkQiX3suJKF45FNUFQng+/CE/KtswbM7bp+A0yAfP4R3FCUnNzBWdqlUOP30NSw1V5lA
 ppWC3LsARZ7zG9N8eyK7RubuSm/WO9njcpVL0oFrF9+7aq5mQYjysteBWj3xId+oViHAsEw4t91
 lWhENfyF+FniwBW3ATZsNN/0QYoxGHhya+e0xCwnthdRDSRU+VmYx/TEiu3VMjN6uxGEAK6/xe9
 5wc2tvNzI0xO6g3HpJHRcmqyl+yN8G6vZJIfdAd++CSHc2Wcjrw4ezZN0atgcyEm3jfEBI5qGSB
 SRCCXWhCF7tYwgBJDyL/Dtj7IVsmXG8Pl1at/pFjxlwevjurQNTs49ygHosSDoduM5NSs5RYlUC
 8G17Cezv1qyBU=
X-Received: by 2002:a05:600c:450b:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-48069c0fd5amr19301955e9.6.1769514165245; 
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d63a6b6sm127340085e9.7.2026.01.27.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BEF535F8F6;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 4/9] MAINTAINERS: remove myself as reviewer
Date: Tue, 27 Jan 2026 11:42:34 +0000
Message-ID: <20260127114240.3009791-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Mads Ynddal <mads@ynddal.dk>

My work has changed focus, and I do not have the time to continue.

Signed-off-by: Mads Ynddal <mads@ynddal.dk>
Message-ID: <20260121112725.40060-1-mads@ynddal.dk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260123145750.1200879-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index c7b732c34b1..0c7a3bf5d51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -536,7 +536,6 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: target/arm/hvf/
 F: target/arm/hvf-stub.c
@@ -553,7 +552,6 @@ HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
-R: Mads Ynddal <mads@ynddal.dk>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -3656,7 +3654,6 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
-- 
2.47.3


