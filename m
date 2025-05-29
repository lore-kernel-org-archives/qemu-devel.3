Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8AEC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKeVd-00057Q-Ju; Thu, 29 May 2025 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKeVa-000572-3t
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:45:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKeVX-00073H-8B
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:45:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-602e203db66so1585054a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748529921; x=1749134721; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q5+6f2Kx8DhYVjbe4Ur/J4kVZ3UGtV99EJCehs1YOqQ=;
 b=DeaoRJ4bzooKbwEGGzD5bem0UhPaFYoauMQjcptfRseaC8Jazjz8vKtB+IEpzv8jNi
 vfyYluV2NBgvg216HeReNs9Gp4t+e1LlfVtaDPujUIKO6O7CUvc5ejXwvpGmsEtP3BY8
 /2NaSxjcDBQV2RGKf0o5xUmva6EMgv6YD+mixwMkY65ipY/aEzFVnPfbugRMxcVA74mG
 S+dFZe9zX34/mx32zWnyAPUo92ji4+RJCdoHm84zaaQZUm+OdMxusPQ2HTECU91rM17T
 zGIJFAoteEMiMXhEdX3WUNLfnNYaHWDklOdXtXObR/TrPKSFchemMZaq5HIMEbWMa2NW
 lb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748529921; x=1749134721;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5+6f2Kx8DhYVjbe4Ur/J4kVZ3UGtV99EJCehs1YOqQ=;
 b=Ee6nHjhjMVPkPKrUe0ThdlkvFPNf/2e8Aci5cizyk8nRjjyp1EdYzpM5NwhTxHw+be
 dNoGTDX1nl3lm5LKwc4K+076sdzszhWtKLEUPRqjtgR8G0deepu0cKPPO9MeqzAOhTLn
 B07g+0sA+CHpnNU3zg7pyWPm2SPLyFjhscPBG5KVmBuia0knr4R0K3dQZqquYOXGqU6F
 EPsBT641z2PqZ9WZV1eh0rV1bnzmNQOG5bmYb8cwI4NQhhiUk162o2j5K6y0REPNfcv1
 GEN3/9quSH5JvX30a5NKfiMvTHGlev2FVyUG/W0iiZyRdSGvSDiQCvBiZQcWILU1Ddqc
 lY0Q==
X-Gm-Message-State: AOJu0YxCrJH0zsHZIf7hlY66HgIYH3jmldrn/gieP7O9s/KNYcGjowXa
 OyKq0AIWRZ8FtdRJrnHAsvigidVuJZiRXMynZ6LKlm3g1guVdBgODn+WbKo2PGOAtS9UjYVgV15
 sorhCBHlw4iPpVzZVCy1WRpGfytD4fG4=
X-Gm-Gg: ASbGncuFtIB1xsiDA5gO96ZEWUKqJapSj2cE6ExL0wXtO3WBVvx7cFycpe4uhapP0tT
 wVq34yyB+YS+JfZGCz/SJFviurTQa02SS/qgNbpwPUztQONB5zRkUOlnQ4VZN9Yw4179wuOkb/u
 jZbub0fLQVgZSxUVrny+NZIbFrJNDoji4=
X-Google-Smtp-Source: AGHT+IEVKZy2UAE1JMP0nFMalH5bs82ZVQla5S3GhTH9zkiZr9RvoopUvuU+8X0fcwk8x0WK/1C+ksCf7AGB3pv+RBY=
X-Received: by 2002:a05:6402:278c:b0:5f7:f55a:e5e1 with SMTP id
 4fb4d7f45d1cf-602da407926mr17862907a12.24.1748529921323; Thu, 29 May 2025
 07:45:21 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 May 2025 10:45:08 -0400
X-Gm-Features: AX0GCFvKZRRVuzTuW5lYtZPojrqnsAv0E9FS8rRlMwbTGVwyR3vZfPwB3xTiJx8
Message-ID: <CAJSP0QXpwWZK3KeGZ-FVFLhu7CCv8PCRbGZ9MEJK5nS_jUWquQ@mail.gmail.com>
Subject: Armbian TLS certificate expired
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The OrangePi, Cubieboard, Banana Pi, and replay tests use a sunxi
armhf Linux package URL that is failing due to an expired TLS
certificate:

2025-05-29 13:37:56,005 - qemu-test - INFO - Downloading
https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb
to /builds/qemu-project/qemu/functional-cache/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22...
...
urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED]
certificate verify failed: certificate has expired (_ssl.c:992)>

I will ignore these test failures for the time being. Hopefully the
server admins will fix it. Otherwise it will be necessary to find a
working URL for these tests.

Thanks,
Stefan

