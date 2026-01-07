Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E2FD0D14B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXvV-00018m-Q0; Wed, 07 Jan 2026 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXuR-0000V8-Gm
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:30 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXuP-0001UR-AG
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so1621311f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767809122; x=1768413922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DIvb6ViQEU8E8eaVBG0QLx+ZeZxFp33tT7GmM98CiU0=;
 b=jYVFRY7RsjF/5Bg2qrkc628RW6Xqz/d0qXQddUf4Y/crQI2gmw1M/NOGmHM/xvPwXE
 519ArNkBuc4aZzDo6VppauHNGGKjX1gpa+uVcMO84Qd0mJePbMpZPvP/FYG6M/E5MEFe
 Quj4Ik/GwA1ThQl+rHt5FA08PQzNuiqbUSAy1j02pgzc80XmVgg4AB0/Yn6ahFTsLYnn
 gcozyIFyVvLBa0JxYLYUf0Bjv18vhHDmyy7filMgAplsF+Fb1K2lankijnCVEyPYQ7fn
 nziNaDM9UytmdP4rlhulJE0YMxlM+xopigO9uaFK+5bIgKGCDRSeJWdsd3ROUanijGZ0
 SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767809122; x=1768413922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIvb6ViQEU8E8eaVBG0QLx+ZeZxFp33tT7GmM98CiU0=;
 b=dwqE5VIaffrsQpdxs8P+eTs5pCdWokQnJG3suMiAp+K6ngE4W3c6/cfDTyVxYYspO7
 hFUgKvjmYjB/Lqm4VX8tkZJharV4cQDCXdoOQH5la+VLXdZwXERUfj6sn1kOAFsKUR1u
 NpSI0qck8+onKDaKQRlo8jEiq7bPbiX0ZklDk5vIHQaXOrzLvcyT/KDRF6L/iGT73Ck4
 bumhiv/XtZkM7bjHqr8sG0cprnTOIClPY4s91cHmDPIvyp49YICKgSUYTDkVuGZQLox5
 bXqDu+HeJYReIrKIEcBWCx+fhKat5/khbWvGUBFrQt9aKkooHAqJx+3S10iAgQ3UgEIn
 qFmg==
X-Gm-Message-State: AOJu0Yxv94vV/B7BMpjgMX9EyBTpSk/y/+tTs6bzVObUNP4BJ745rIGZ
 Pr9EIKXKnaAxrmk/panFulqcWUEPGH5REdTX4pQCWkJS3iK8Z+V4wWbf3dJNQSLqnKwTsOTtW7P
 fauV0pOM=
X-Gm-Gg: AY/fxX6een1gKZwdtgXZN33DGYJtH/N2g/z+DPqP/nQ+6N2/pL0HWjvtXOuD7Itwgrd
 m03+7FCnoHr4kKQouUWAsDSzfGXPaq/APx5lCtXy6XrqaSxhMpulO5DjbfZv1l4EI+HcVa43n/x
 8wJ0k7voy1SX0WBbJRDxWIWVu3/KbF+8lPfamiys68RI+fr4udEYRbL+whf6UEeRYWMcfxahCRN
 y0eW85t2UfDRvro502uLLlikRou2Ivn8kJEA/k676qZA3Hgn3hLO+paoI/xzSZqleDTX4DrAYNu
 2jrhgl5Xh1IXFJV/aBzdVzj9Q8pw7elP6nF++itSwuNvTVWg5HBBpgHlC2/ywZ7tXcUq9lyQVN4
 j5tzrKy0JOIrK8Bi+j3H5fbu798KRAazWn0v0drU/mvxeG4o8DZXev6LANbsKuUcRKw7XBIvLy5
 y156nAxBU6kMrzvCwOv6XrOX3fUBXT9ftgF1S/sbFCDg+BgwHSNhWlL/DktjbB
X-Google-Smtp-Source: AGHT+IEkX0iIKtSU14l+RJwgDjb1Wv/jdm/7HRCSZS9DxJHGivjP0HO+ucEU/eXEUacwbSjL5DE3MA==
X-Received: by 2002:adf:fe8f:0:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-432c379f3c9mr4053210f8f.53.1767809122517; 
 Wed, 07 Jan 2026 10:05:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm11556865f8f.42.2026.01.07.10.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:05:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] dump/win_dump: Build almost once
Date: Wed,  7 Jan 2026 19:05:17 +0100
Message-ID: <20260107180519.50820-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Build win_dump stub once on non-Windows or non-x86 hosts.

Philippe Mathieu-Daudé (2):
  dump/win_dump: Abort in create_win_dump() on non-x86 hosts
  dump/win_dump: Use stubs on non-Windows hosts like POSIX

 dump/win_dump-stubs.c | 21 +++++++++++++++++++++
 dump/win_dump.c       | 14 +++++++++-----
 dump/meson.build      |  6 +++++-
 3 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 dump/win_dump-stubs.c

-- 
2.52.0


