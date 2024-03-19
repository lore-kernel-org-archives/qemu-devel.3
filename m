Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58CAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPqO-00054f-Ff; Mon, 18 Mar 2024 23:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqN-00054K-0Q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:51 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqL-0007Wl-3N
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:50 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c3747e7f8cso2617479b6e.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710817728; x=1711422528;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KhkmixV0UNWnVdRSOs7jdu6zrE4p/BMI06IEhm7UZBw=;
 b=kc6bCip8IJed0RFYJt9ghSAnNWUx6HkY2iTQfkMNZDitrTvcwv7banK+7fVmVggK2+
 HM+7BdCDlrVEFxUpn3jG3hP8rfhjsur4Gaffb5eU1t4vNZDCN4j46URPTNGxlWbfEbKK
 SbgYlaFrV2eF+78pLDhnt2Kl4myu+GZjpTN2aU90FFzl23agkcGFcYHPPQv16n3kenjc
 PYXp3SRtOysO9IkEr7/NzEc3R6m2NpQeKawfxs/1KSlLkyFZTbku6DYRLyaHrvntwcbi
 Mku10No243wTE0W6dQhhaDuRClAcBjdarPK5kEU58DUf+z99FQCUiJzC2YJcuNRbOgri
 Zbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710817728; x=1711422528;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhkmixV0UNWnVdRSOs7jdu6zrE4p/BMI06IEhm7UZBw=;
 b=CjLFEHe9kNQ4g9SbVhKq0zY3EE98SOdAsCrKGAOFL/vAGKJr0RGNwZRyM6SJauCaBW
 kFPKhxMKt6cabtx36Yh365UMIAep/91ybPGsUVsp4ZjvW8pDHuZaFPeRj/XYI0sGr2O8
 O3GGy558hTjoKr0d+zNLfISqZi8sSxd3LBkFEDr3VZkVvgIzXkGDAQWnHHJ6YxFZHgZp
 H60NbjZk8+n+5SDe75Fndk9Vk5rm3Tdr6vOsmaV3lubdcLEqFTY4hFUy2c9L5gZEDECP
 00QJ67UtDjRxLIK5E+H3sz6gwfSY6+ncuuX42EhE87Kz7yzv3jmUp5uUAiqN850B0ipz
 Fe7g==
X-Gm-Message-State: AOJu0Yx/ExH5rZR73pInxK7s5CJdvZO5+LTYYnJusIMXXXsoHVtRBoHT
 eH7S44EOEFQ5sDv9QcilJuoAzt7q6Zh/u4q++PRB5D44FAJjqp2DhRulMyix58jzc8On/79NmIi
 a
X-Google-Smtp-Source: AGHT+IGQQbp46+UU6/2dOZhZjr1/2zDsKwj/3rcOd4KCkY1YMIGsuo22xC3Q6avnjlhkAU+H5oTqWw==
X-Received: by 2002:a05:6808:2020:b0:3c3:7fc7:3ade with SMTP id
 q32-20020a056808202000b003c37fc73ademr10154498oiw.3.1710817727809; 
 Mon, 18 Mar 2024 20:08:47 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 x7-20020a056a00188700b006e6931a50e8sm3024295pfh.79.2024.03.18.20.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 20:08:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] ui/console: Remove console_select()
Date: Tue, 19 Mar 2024 12:08:38 +0900
Message-Id: <20240319-console-v2-0-3fd6feef321a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYB+WUC/z3MQQrDIBCF4auEWdeixsbQVe9RslAzNgOtBi2SE
 HL32kC7/B+Pb4OMiTDDtdkgYaFMMdSQpwbcZMIDGY21QXKpeCs0czHk+ETWaaVGZWxvTQf1PSf
 0tBzSfag9UX7HtB5wEd/1Z/R/owjGmVforTdayEt7G80aaDm7+IJh3/cPdAIy658AAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
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

ui/console has a concept of "active" console; the active console is used
when NULL is set for DisplayListener::con, and console_select() updates
the active console state. However, the global nature of the state cause
odd behaviors, and replacing NULL with the active console also resulted
in extra code. Remove it to solve these problems.

The active console state is shared, so if there are two displays
referring to the active console, switching the console for one will also
affect the other. All displays that use the active console state,
namely cocoa, curses, and vnc, need to reset some of its state before
switching the console, and such a reset operation cannot be performed if
the console is switched by another display. This can result in stuck
keys, for example.

While the active console state is shared, displays other than cocoa,
curses, and vnc don't update the state. A chardev-vc inherits the
size of the active console, but it does not make sense for such a
display.

This series removes the shared "active" console state from ui/console.
curses, cocoa, and vnc will hold the reference to the console currently
shown with DisplayListener::con. This also eliminates the need to
replace NULL with the active console and save code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Changed to fall back to a text console if there is no graphical
  console as previously done.
- Link to v1: https://lore.kernel.org/r/20240318-console-v1-0-f4efbfa71253@daynix.com

---
Akihiko Odaki (4):
      ui/vc: Do not inherit the size of active console
      ui/vnc: Do not use console_select()
      ui/cocoa: Do not use console_select()
      ui/curses: Do not use console_select()

 include/ui/console.h   |   2 +-
 include/ui/kbd-state.h |  11 ++++
 ui/console-priv.h      |   2 +-
 ui/console-vc-stubs.c  |   2 +-
 ui/console-vc.c        |   7 ++-
 ui/console.c           | 133 ++++++++++++-------------------------------------
 ui/curses.c            |  48 ++++++++++--------
 ui/kbd-state.c         |   6 +++
 ui/vnc.c               |  14 ++++--
 ui/cocoa.m             |  37 ++++++++++----
 10 files changed, 118 insertions(+), 144 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240317-console-6744d4ab8ba6

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


