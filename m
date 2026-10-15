Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187BECC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHAkl-0008Ub-Hf; Wed, 14 Oct 2026 21:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAkk-0008UO-5l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAki-0000AZ-FK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso61680535e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792029566; x=1792634366; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8CJxtwWzoxwg1UM/B1jbRAKPv7zwQjXGNMN4bg15vIc=;
 b=jn+AvAWVZ/2gMILKriTXgcZdSNKFiO7g/APUxXxB93T/IvqrXtLFo+OEuss3JZAFJy
 CMRKkOroKO4fC+1qQxBmUWojn+gndn+zwLuXcJegdpidIOiRcEnIHwD7CKIDKr/qBNzR
 ho1sDlqBn18EP+pJFrUiskXKBR7xx1jXPUY+BOQ0NUY38Pb5yzbwH2S2vl3m5F4VZZpI
 EUF4LN3YdIaQCVLQ/M671MsAWAVrtuuB9yS6LGncSTOgcMbM/LumZfmIFHQpK9A1ZyLx
 +6OKv3kMPx8tZQal09roFbL7RKKH1I6Vu25LF9eRZA1IOu2L3S7ZCABeTjsl5V2rwEhR
 2UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792029566; x=1792634366;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8CJxtwWzoxwg1UM/B1jbRAKPv7zwQjXGNMN4bg15vIc=;
 b=Ul1nBmqFF/LCSGBEG6uSa/ppXxTEGdK4tlQGH7QpJ1Mxiscf8rKPtEQP4Pyb7yVn18
 sIY5pg+NlxvYW2AwifXFS7fkXI6OYwf9ilNNvftRgaenNAZkQpgo6vLZ9EZcqK0i74hr
 kW8Nk2Jll3yxtkx+9Fq3Xa4eVNFaalmCuoHQo5nXo0SU+Nl4WRjT7TyVSJNqaDCg8cLO
 SRD7z65+pF2d4Yi89TuNcEDVAb/MjW0e0nc8729jazTxSFesZ5EuCT2rKS/IuPgPQ/zw
 DnZ80qQW5prulXRYkKIVTybfi64YU+YZbmxbOVXUyM5lloEJXrKGE3LW0FBv9WyFFiHt
 HjcQ==
X-Gm-Message-State: AFq9FYIfndTzBH1DXM0SSPqkyDGAglwX18jpdrjL9n+aR60Rk5j65YEq
 p8TYQV9IInEOYsrV3DoUQwy+PtFavVcFMKPku82yl3/OQEXRyF4MbqxEUbWPgi7m
X-Gm-Gg: AYBFou2nrzkE9/qer5TJxWkH0Kr0MwIHgXD0jcGOYoSrr1AVAOL87GZWMUcQ7ChwUVx
 vYhF4k2z8d6258DWZOCJ/1Fx7BjyXNvDDebtCOktYOWFuddOUzzCjigRWvtGcked8haYkyFP4dh
 lcbHOHwhw5YU7hWwEVW1JzskjC+3QV4tUlLDwVUEk1xPv0086p1+TRds9ifc1WPQ55ThCrH3WyN
 G0B537hHK7R0jy1tEKnxzR+Yl/US902VbQPcHw5aJsEobspNuVICZx/DXYhOxLIcu+iZ/A4AVb/
 G/anA/RHVQNsthludlR5GSSD4t3TulVqoZBrCIk4TUDQ6uBmu6JSUCTvCnQwpObprclKXyf/h0j
 KX2SyqUaRCXT892TxgDo68JG+pN7wawaDuCOhbNkMu4oCbwZI/WUHfPEqPSYGUi/pjUe2VtdsuZ
 sCrMOmQknkHp0p+XfNIttqyzSHPpBmfIZRnTr8axzoWImt+TCeJ8tYLYUHKHafEwUDzD7itDhIr
 bj5alnzQW51/+uCNXhluRHbBAA=
X-Received: by 2002:a05:600c:810a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a18e3ef100mr331615355e9.0.1792029565874; 
 Wed, 14 Oct 2026 18:59:25 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd972aebsm36974675e9.1.2026.10.14.18.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 18:59:25 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v2 0/2] io: make sure we don't close stdio fds
Date: Thu, 15 Oct 2026 03:58:23 +0200
Message-Id: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf4XM2pq2lIes/A/DAoYBxgA1LRIN4
 d8tGFcuT3LuuSt4ckweimgFRwt7tlMAfYoA+2rqSHATGLTUqZJKi5Zfws8NW4GD9SQueZ4amSS
 NyWIIq4ejoBzFW/ll/6zvhPOe2Y2e/Wzd+7hc1O796vFffVFCCkPYVkalmNV47caKhzPaEcpt2
 z6ErUDxwAAAAA==
X-Change-ID: 20261012-fix-stdio-close-98864055d473
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792029564; l=1408;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=o5YoeP9+MANegk0svBirjQc+04T87vcTiLChrT27p7E=;
 b=5VpgXY25MXYu9yiudU3cQO73hxwu5O0ksxcUMda/93g9VgV0E7H4SOv6hfMtSlgMPi977vdf+
 wJHZwI6Vd0HCnGdmmeZEPH2yaTHYMJdAf0enTxNJuY0P/bR5iNRRNV5
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x335.google.com
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

The stdio chardev currently closes the stdin and stdout fds when it is
destroyed. This means that, assuming char0 is a stdio chardev, invoking
the HMP command

    chardev-change char0 null

will cause QEMU to run with descriptors 0 and 1 closed. That's not a
great situation, as:
  - the stdio chardev cannot be recreated
  - code assuming fds 0 and 1 are open will misbehave
  - the fds 0 and 1 will get assigned to newly opened files, possibly
    causing them to be confused for actual stdin/stdout

The fist patch fixes the problem by duplicating the fds before they get
passed to qio_channel_file_new_fd(), the second patch adds a warning
that is printed when qio_channel_file_new_fd() is called with a stdio
fd.

Changes in v2:
- Code style fixes
- Set *errp when dup fails
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
Filip Hejsek (2):
      char-stdio: avoid closing stdio fds
      io: report a warning when a file channel is created from a stdio fd

 chardev/char-stdio.c | 16 +++++++++++++++-
 io/channel-file.c    |  6 ++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-fix-stdio-close-98864055d473

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


