Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1285CC4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqb-0005Ua-OL; Fri, 09 Feb 2024 14:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqZ-0005Sh-2F
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqX-0005AW-Jo
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b4e6972f6so654963f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508056; x=1708112856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuY1O9E5szKTCV5MMy0oqz5P+mAsVHcaMG4FXksjYKo=;
 b=Rdt9j9GSlsLH/DxySMwtyC3prrPxFSPBmUhoVqQW8+jIEwox2TUYA9Y8SV7CuFrbk3
 i2DZHqzMEnEM+KdIUz9za5T6NzQxsu7ggW8vxXFnQBzRQvBA9JF0rx/TxwM/i6IQNRnd
 rX12j0yaz1lN+futtyDfmQ639pwt+LFGUeDmFkNvYpJG0C3FcBxOJqKZjBDLouOAp9zp
 y+VWt+pTdnk6ijZgE8PonXJt7nJSp8ky+WWKHEnnsqJvB59JXQQmJmJixEL/emaawLvR
 AHLQyuEr8KeFXzl1zHWWHKjuVRLdzTb0fsstQCNCm7xn481ge7MvA8DutIseQr9nIvo6
 xsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508056; x=1708112856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuY1O9E5szKTCV5MMy0oqz5P+mAsVHcaMG4FXksjYKo=;
 b=DatitNqFklUyFRGsP9XZov07ImINuATsIcnADPp+RAwnFtgRjtSd2+HM3nvh/FSdzL
 BZuSYbHawm9j9hs0wwWb/MAsliC+uENWAxc+hoW1HK9a924uF9qUCKqjd9rB5c/KsqSN
 iB9vnqTqSfuC25UdkuI9JpXg6PwwrHu4+d15OyFrjVJM6lyX9s8yHz/qNnH4fdflGxYH
 lgzKhZvbzeYRKxpxyPC71m8dNqSwXmmdHoh4pOmO2HwgGUlhcEzd5YWa5xG1GN4pjgeW
 wtNUkYucWiW87h5BHJmsnIqCnsG6pFLKmQZ45Rr4AJBJmHO2QQACh2FeE2hvZdJEoyk/
 V8mg==
X-Gm-Message-State: AOJu0YxtKhzX1AjIAKCyAEPc0wt22CtnrUZ1RhR0VqQmQBqhydh5/g7P
 l0sRIsdR1AsLY6DV2AYd/IgdNNKntwkiZLbIfan2YAcPq36rETFns8Ulqz4vD3BbNXaqi5EKTOL
 I
X-Google-Smtp-Source: AGHT+IH6qppKiF+tlTgaf3PNV+Y86iNk/CNRqXdXbRHm+W/O2zKbkPgrJnQCZV9SPvlTNLVt1SdPSA==
X-Received: by 2002:adf:f607:0:b0:33b:5e7a:cf02 with SMTP id
 t7-20020adff607000000b0033b5e7acf02mr19638wrp.31.1707508055847; 
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWjdOrjh7VQeo9X+GxhNkCwTZBjRXwTqmmwCkS3H9AJ1bA8DcYhIrpN3XW6Z/FC1ouzGIQakAmP7qfCzwTxjXlq2dsOX6SlNY7R5ffqYw7mavabLl3G86LxZ+fIguPeGyhkubfi/UeM1tl9CBlcGd5CPTnpITF1wdcZPzwRozq5d+Fe5eQ=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l13-20020a056000022d00b0033b1b1da2adsm42649wrz.99.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D53C45F876;
 Fri,  9 Feb 2024 19:47:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rabin Vincent <rabinv@axis.com>, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 devel@lists.libvirt.org (reviewer:Incompatible changes)
Subject: [PULL 02/10] docs: mark CRIS support as deprecated
Date: Fri,  9 Feb 2024 19:47:26 +0000
Message-Id: <20240209194734.3424785-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This might be premature but while streamlining the avocado tests I
realised the only tests we have are "check-tcg" ones. The ageing
fedora-cris-cross image works well enough for developers but can't be
used in CI as we need supported build platforms to build QEMU.

Does this mean the writing is on the wall for this architecture?

Cc: Rabin Vincent <rabinv@axis.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-3-alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c7b95e6068e..7b0c59919e5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -192,6 +192,13 @@ in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
 an alias, but for consistency these will get removed in a future
 release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
 
+CRIS CPU architecture (since 9.0)
+'''''''''''''''''''''''''''''''''
+
+The CRIS architecture was pulled from Linux in 4.17 and the compiler
+is no longer packaged in any distro making it harder to run the
+``check-tcg`` tests. Unless we can improve the testing situation there
+is a chance the code will bitrot without anyone noticing.
 
 System emulator machines
 ------------------------
-- 
2.39.2


