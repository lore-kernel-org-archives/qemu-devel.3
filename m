Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6819D44C48
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOJ6-0003Xt-80; Thu, 15 Jan 2026 09:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ4-0003Xf-J4
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ2-0004k4-Kr
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so9579045e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487195; x=1769091995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSGx3OEhBLISzf0x1Pda8IGrY+Ns7N44p2jUoJb+UpE=;
 b=Uc6PDBtCr/v2MzKpY38BGy/PTUrhdSlDgV9+pmM/jzgS7WHKto7yrdP8lfX0/g+FlA
 HC6h023/Xd2OVTCBcDk7ANAeo53LABZOM+UFUx2qWB3RhWhplprdtbglUrlTNpZkcjgf
 djT9/yCpCGcIp4ijfo3A/ySeJdJBkg0X23AgHBlZ70xw8Iff6vHpGjD5QzvIuKAZx7qG
 7Jr8iclJ9TuS9mIRWDYV/T7CkhyKNQbvQKYYTM0VhzmxtGNHN6W9Omv7y5E4wk9oQuC2
 qYfOt9pVZxZQsSn9OsQ3MOVU6tPXu9xUsbKmD+MTzoB3iBdfUTxY7fH+j1QA22KKD+fD
 Lobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487195; x=1769091995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LSGx3OEhBLISzf0x1Pda8IGrY+Ns7N44p2jUoJb+UpE=;
 b=D2U5MFKChrvJ1feWWbqspWCmxgoZIxeQc05n9NC14NUq1tvSUNvOaCmVc33a4xkjNB
 2avDCyAsXmdeGEJPwxLj6QdOIQyGrxgYvbyBaw0SvguXULerKTlU27Svb+vBE30L3fEi
 v/V1JHwZdcYB5VmTwlL9kUOrFk/CvECRYRYxw+2FWx+QVM6QvK6HajKD0vLSnZBo7VOm
 nVgAGAZIyY546qRDU3r/Dw5z7Go7jnJuEdwGX632jwHNJ6xp/JyiE7tzqftCC0CcjX/A
 T8hnyckesRZ2jMlMoCGIkQwpJJ6bgMUjVRfFbh1+4rdpDFbRyEwv+xRqx+vA001LOT6X
 8tUA==
X-Gm-Message-State: AOJu0Ywrr1EpjxLe5Dv2HhwBwhQgzlcw3D32EpGrgUqoFe4AiCJGOrc/
 uOuRnqow4tTOalJSIVTwUA6ef9+DzSMKqahmQfBYeZJgtTlkSexfchAXXgOSj7KOSvzrSPQJumO
 PQ7VC
X-Gm-Gg: AY/fxX4wfoA9IhlKvSXOVCu3aR5M5lTGtwrM6hUyC0Z0L/sK7d9HQpFTNmUtl42T0Jq
 4BJC7oIJ1pRuKdUkWH0tvWk/WWnBQoPQPfxUWPhTSWAqryopi+bOzMyRwm6T4NFJrATcP0Z6zX0
 BrjKkFr+LJcjuWgVX/uUa/YTqWIPbymuxSo53jt9cJdHLARUnnhuGx6OE2Le28GFt08mNE6df+q
 8OwpVeIosA44GaAB/tKuYwy1l+nDpzLZ7y9v5eEL8csE8pQATONK451BYe9fBvyNO0jnoth3P24
 RE1xqjqlKVx3hFOYf+Od9FvS3IhZFURs28WVhJ6pmc30ti+5I6mmIBpuey9FRvH7MuwxmkcoYVu
 dP2O5YeCY+thHMPGwEcUMPMS5WU79vDId/XYdnlxdmIDoe6ofRXDJuaB31vJonCJhvTLhEvz7U4
 E9L/jeB97PYcSYtgfk39QL/jDgzdgLhKy6GFxZl8rfYEakUWUdLeQJUUHMTkkQS6faeXMvuxZpO
 /A0kP0p8/GtKdz8iKhrpvThwO1tSZgoVWQihalGuYKfEw==
X-Received: by 2002:a05:600c:a4c:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-47ee338a820mr78141035e9.29.1768487195130; 
 Thu, 15 Jan 2026 06:26:35 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm50759435e9.14.2026.01.15.06.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:26:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/4] docs: avoid unintended mailto: hyperlinks
Date: Thu, 15 Jan 2026 14:26:27 +0000
Message-ID: <20260115142629.665319-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org>
References: <20260115142629.665319-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In rST documents, an '@' character in normal text or a parsed-literal is
assumed to be an email address and will result in a 'mailto:' hyperlink in
the generated HTML.  In several places we have mailto: hyperlinks that are
unintended nonsense; correct these by either escaping the @ character or
making the text use ``...`` preformatted rendering.

This commit covers only the simple cases which can be trivially fixed
with escaping or ``..``; the remaining cases will be handled in
separate commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/submitting-a-patch.rst     | 2 +-
 docs/system/device-url-syntax.rst.inc | 4 ++--
 docs/system/vnc-security.rst          | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index dd1cf32ad3..5ccd09a397 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
 
    * - Check
      - Reason
-   * - Patches contain Signed-off-by: Your Name <author@email>
+   * - Patches contain ``Signed-off-by: Your Name <author@email>``
      - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
    * - Sent as patch emails to ``qemu-devel@nongnu.org``
      - The project uses an email list based workflow. See :ref:`submitting_your_patches`
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 43b5c2596b..aae65d138c 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -33,7 +33,7 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      |qemu_system| -drive file=iscsi://user%password@192.0.2.1/iqn.2001-04.com.example/1
+      |qemu_system| -drive file=iscsi://user%password\@192.0.2.1/iqn.2001-04.com.example/1
 
    Example (CHAP username/password via environment variables):
 
@@ -79,7 +79,7 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      |qemu_system| -drive file=ssh://user@host/path/to/disk.img
+      |qemu_system| -drive file=ssh://user\@host/path/to/disk.img
       |qemu_system| -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
 
    Currently authentication must be done using ssh-agent. Other
diff --git a/docs/system/vnc-security.rst b/docs/system/vnc-security.rst
index 4c1769eeb8..97e94ff407 100644
--- a/docs/system/vnc-security.rst
+++ b/docs/system/vnc-security.rst
@@ -182,9 +182,9 @@ When not using TLS the recommended configuration is
 This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol,
 with the server principal stored in /etc/qemu/krb5.tab. For this to work
 the administrator of your KDC must generate a Kerberos principal for the
-server, with a name of 'qemu/somehost.example.com@EXAMPLE.COM' replacing
-'somehost.example.com' with the fully qualified host name of the machine
-running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
+server, with a name of ``qemu/somehost.example.com@EXAMPLE.COM`` replacing
+``somehost.example.com`` with the fully qualified host name of the machine
+running QEMU, and ``EXAMPLE.COM`` with the Kerberos Realm.
 
 When using TLS, if username+password authentication is desired, then a
 reasonable configuration is
-- 
2.47.3


