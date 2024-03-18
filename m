Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE52C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9sR-0001EV-Tu; Mon, 18 Mar 2024 06:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sM-0001E3-34
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:05:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sK-0005w7-8r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:05:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4141a52a98dso1635335e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756346; x=1711361146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRdZ7V52KGINFgH2MKciuqDB0KCcONfxHqjyag63VzI=;
 b=dynqvVM4uDC6FtuWGa7JlBcdSRUo82Ok0Av4h99SrPVRaPO6ZK9bSXajIPiPWmWsDW
 BUPjqHLYPs9A07+FALh7qw7GttNlrd26L/f8RTN945y85wOhUOHDszXeufviEUrSBY/r
 5mFOaZQ3Ww+ncGEVS7gu6/Qc9/qHnJ6PlfIM5eWx0SEozDnTn7pxtFKquRfZolGlhZO6
 LAxK9d2T0FmDTiKLwZYAPY00SGo2VoXn++ZbDxsznJmz4azBq26JORR99WWu4zNbPPBG
 Dn2adah/gxoKrP8ndPeoScE3F+ouw5ukRxRmxGRMyeOMeSp5iz7Scr1vgKDd+VkxfL2t
 dMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756346; x=1711361146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRdZ7V52KGINFgH2MKciuqDB0KCcONfxHqjyag63VzI=;
 b=Uzb9gkUIvsuqgQ91FSpEV4HZ7UkVitS6EangcCuYc4ibSAnm5aXxbY8mV9XnQ8RUBk
 d/j6JrtfSgWcd3DTj2qfggUwfDEdSeJfjOI4eOpaT/RWF/z4M7ocg/65BAgVjPWvbwSc
 I5C8qs6Z9xEs0f373PpftK0Tk6/j4OsbHeGzh+5kL8Il28QVt0hl1uGlpWyjl7XE9CL3
 CvSTGpyWc8i8xW8lSS89DVRLXj3HCYJQuidnVOnW8pscjmWJpedpH8KJ/QNmv2OT1KW7
 P5GRRQARgtYKned51pB9YzuEyepovGrw0jwh5hROOdCFxzDzpeA4WT7Iu4N7LxT8eabJ
 FEMg==
X-Gm-Message-State: AOJu0YzTS1yNNEDlT/EjIwEAblXprgglipXZePxPOi+IOT+M4HtsS4/s
 9W4Yjjp52GPtdRs7bNU05kT5NrOT8mys1iQOd8LdxEN72o+CThtttgb+yOClEH3RZHP1nFeg48S
 8
X-Google-Smtp-Source: AGHT+IGMvNfmHcAL172Bx+WYh2V7B0UtgWb+kXZpui9ibhMJWuFGhogUQAHQnY2gW8q8qIYz4dJNRw==
X-Received: by 2002:a05:600c:a45:b0:414:a25:9970 with SMTP id
 c5-20020a05600c0a4500b004140a259970mr3759902wmq.39.1710756345850; 
 Mon, 18 Mar 2024 03:05:45 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 hg13-20020a05600c538d00b004140b6625dcsm4984940wmb.13.2024.03.18.03.05.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 03:05:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 0/3] ui/display: Introduce API to change console
 orientation
Date: Mon, 18 Mar 2024 11:05:39 +0100
Message-ID: <20240318100543.78846-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

The idea behind this series is to reduce the use of the
'graphic_rotate' global. It is only used by the Spitz
machine, so we could convert the '-rotate' argument to
a sugar property on the PXA2XX_LCD_TYPE model, but since
the Spitz machine has been deprecated recently (commit
a2531bb855 "Deprecate various old Arm machine types") it
doesn't seem worthwhile. So just extract the API to change
console orientation.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  ui/console: Introduce API to change console orientation
  hw/display/pxa2xx_lcd: Set rotation angle using
    qemu_console_set_rotate
  ui/console: Add 'rotate_arcdegree' field to allow per-console rotation

 include/ui/console.h    |  3 +++
 ui/console-priv.h       |  1 +
 hw/display/pxa2xx_lcd.c |  1 +
 ui/console.c            | 15 +++++++++++++++
 ui/input.c              |  9 ++++-----
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.41.0


