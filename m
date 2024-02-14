Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C69C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFsE-0003oT-RH; Wed, 14 Feb 2024 09:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFs8-0003nf-UF
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:27 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFs2-0007CG-B9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:24 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so1719230b3a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707919457; x=1708524257;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zTwetz9LHqH+clEG8ppyvOGMcGi8TXZ9ML9fD984fr0=;
 b=ZcSyKRmBiteyuw5kbsJoF7JGrexGXZcyWmQQ04ELh6UYxwJRl4bnfAYOgakqZ2OT2l
 g5tuw+MNrJszthYOLyxd/W4QpbtdtaoOJMbk335rFspwz5AWJJ7FzOvN8IWukkLeC9XM
 HqXDKKL+HzevhC9/7flXAlFyAuFvZ1xqBoGXfGN6lQd9FqmLHtevIoZQXE7HQipP+30x
 iWtO/eLAiwzqkXtBXpQIJb2fs1FnFxauByvMdozTRT6aVwav+Yl4DIoZ0vOdfh3QvnfH
 1T808knPR5JeEd6kTEWCmzfxyixqL7sxQbsaUi5pvrXEXhkeHKpH/Mp4pB0D/VGBIzF5
 IRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707919457; x=1708524257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTwetz9LHqH+clEG8ppyvOGMcGi8TXZ9ML9fD984fr0=;
 b=LXs6eC2BCfzKUUb3deYbgCbASlJJ3ERd3OZkV3EXMburKvWWesZjJ/adEBqLCvTdc7
 tniriQoLF0/DEP7HyrLkhgWTCvtTJ6FKDpZydL5eEokF0wsKnYx72Xqj1ZfCLx7ZpyR6
 YZZ2k6e/JwUDZaJCl13PH2Hu6MsCgl+Ep7wFMkubzQl/r+VwmN1dNTnmp21v/tdmk0+9
 Lq5NTyG4yDNk+eyDujnK7MF+TfV+XTIOO0ziE2JHqScwY5OIKp+mdPwdhLXSCVGNVYnM
 SQUy8AukU5QxAP8RvvG+d/PVegS+eHI1gi6b2WFNcEcqwf3SBWR+3QhmQllxOvuRVLuF
 0BsA==
X-Gm-Message-State: AOJu0YyDGjna8lKeEJMHgUrfSUcSgGcPbi8ehS05WvnXaiM59IR1s2mz
 ep9l/ObsOKkm6BpNKDsTWEK9sA/hhu347bG/5Es1xTp2oX4FYLxFTeooEqjkBVU=
X-Google-Smtp-Source: AGHT+IGltqgmv/6WrDiHDRyL4EaJ3d6G/FAlIVqnlC7gofryD/2xUUAtobPdq6snArUnPUojapYE5g==
X-Received: by 2002:a05:6a21:1706:b0:19e:c7d8:6246 with SMTP id
 nv6-20020a056a21170600b0019ec7d86246mr3299268pzb.13.1707919456990; 
 Wed, 14 Feb 2024 06:04:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX9eMy8wc/+IfbzF1jTkM3Y0JnL5kXqTpIqGRTy888y2vsT8r7TtstrL6zvvAuGee6UTb6RnWALdTDtcZ8VZv87Yuow3ZftDI+8mLB13BHfDZHWwPhfmc9wG3at+ymuvu/JgukoNCnQfsJVi93bnmMfwWcyP4XyX4hqr4zRkCIfZwdrtTtiEh+1XGFj020+Btv/YIv3OLFgG0buzxP71YQ+nP99pR9gajNawD1LNNeNZ1pZMZYEvVysJB+eZFwJ
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 i66-20020a62c145000000b006e04f2a438bsm9722572pfg.105.2024.02.14.06.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:04:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 23:03:58 +0900
Subject: [PATCH v7 3/3] tests/qtest: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-dbus-v7-3-7eff29f04c34@daynix.com>
References: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
In-Reply-To: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It ensures dbus-display1.c will not be recompiled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecbb0..eb075fcda283 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -344,7 +344,7 @@ if vnc.found()
 endif
 
 if dbus_display
-  qtests += {'dbus-display-test': [dbus_display1, gio]}
+  qtests += {'dbus-display-test': [dbus_display1_dep, gio]}
 endif
 
 qtest_executables = {}

-- 
2.43.0


