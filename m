Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A655C83013
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 00:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVJN6-0006Kx-LY; Fri, 27 Jun 2025 20:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN5-0006Ko-BL
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN3-0000qe-Ow
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2819745b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751070280; x=1751675080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VRJZppcUw0sSJGJMIzcFuLbUi7mAY//+2Rb+QyfSrxY=;
 b=i1SxFXpDoXHTUxregjuYZWdkUcxWDQRaSCEgqlQGWXGwtNUjjfg8kNFJt4zrtrHLRO
 NJFs5OZ30ny/K/q0U8JqJEBAj0vLhRBPlsIbH7Rti31cd7zpPGNKmgX1aBotA1lnbz4q
 TNcbUbfsbYHqCixrVmRV0Xn8mGKdjWITlBxYGTaDLp4OxPdDHg1ci9CKrNeQ7ptHVz8S
 R/oLKLfGuPAcdJYMZHgj6CIn7ZJ3s+cyO8IlqQDU96KfQLuq2Vm6lUQukc0ub2RO7MBH
 PxUCnyBM0tsKTHODzcxpJoB4QL+yGwQ6Q3fBCYY9y1qPcN9h6ETZuASAH9Kf3W/LrqQZ
 cFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751070280; x=1751675080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VRJZppcUw0sSJGJMIzcFuLbUi7mAY//+2Rb+QyfSrxY=;
 b=ljnTo28zMgbg69CwqhIYpZKyh6/U8EyavO83PZPrNY9ZYquaDnxvfPaT0VPBZ83VyP
 FOH/Udl5gXFSwbWCUIbKrtrcJeRSluGeryLeoX0q/YPmNzm0l6Ba8px8fJMTGEpDvzMo
 MTdFJemoRdjlJMMrhnaURq9KPXj5edl1gRuZUGt1ieupXJFkDTkvU1iRRR5K/STsHDQE
 FzHjRXebjkJhAg4i38uDr94B7WtKMzDh8bKyuy9epYXLKvjvA/Vo5wsZHcGAVVKDS5Wx
 ZC3t4ynI4wxsy3dfzcLQ2dluOtXaxJsKA4AauM7anCRSLXzYzsM4RMQIpr3nMk4g/L2O
 JNhw==
X-Gm-Message-State: AOJu0YwH+Sxy+MGlw9iTJObKwIEUgltltY0+FbCONpxqEXQCk9luDDxb
 eiMqsuGaOOmIlxBUqIn2NuCKGWpLqi3u8anjHkAVA2OLaHjbIZ+1kqZml5Z40ISfH0DNP9dCrLN
 l561I
X-Gm-Gg: ASbGncvEp06WlIYweJ/edyX21aCq9x9bmLUSiovi9RqoOtWnvZNQAfFbHO/1lWAk14R
 j0Ks2qXqDtxY0iTnL18wW1Ey5/QA+F+Wz4zsVpO+WHp9AFRi1p9fVFgReH+FD8MJxNZNNIT9ouy
 Z4E2uM/hVhY6oUfKfxrlbZmXPxnkMiru1T98iXzP3K3nVnqUVINpzRvCXvWHf0LWALgf4YSOj3h
 J23yatf4UDUHsVmzcU+nM8RjMm0xjMltFB3h0AcxfE0kOPH35tDwIsyfW4fff4TWn/yytLUVM/m
 yapWXvQPub33EzzGOAOxMPFfTe5MlQ4CQNiyc6unJQc+zTNvXqpEtM94buJvIg==
X-Google-Smtp-Source: AGHT+IF7oqTiPsM96zvyS+Dt2L47GwuysGPz3MrA1Vl2vNLw4PSw38scOUo69umRYPEqIV+Glc21IA==
X-Received: by 2002:a05:6a00:218b:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-74af7b0902amr6823756b3a.12.1751070279600; 
 Fri, 27 Jun 2025 17:24:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5579d37sm3025751b3a.81.2025.06.27.17.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 17:24:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/2] control guest time using a dilation factor
Date: Fri, 27 Jun 2025 17:24:29 -0700
Message-ID: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Depending on host cpu speed, and QEMU optimization level, it may sometimes be
needed to slow or accelerate time guest is perceiving. A common scenario is
hitting a timeout during a boot process, because some operations were not
finished on time.

An existing solution for that is -icount shift=X, with low values, which will
roughly map virtual time to how many instructions were executed.

This series introduces another approach, based on faking host time returned to
the guest, by applying a time-dilation factor. Time will go slower/faster for
the guest, without impacting QEMU emulation speed.

It may eventually be used to fix some of the timeouts we hit in CI, by slowing
down time in VM, to be less sensitive to varying cpu performance.

v2
--

In review, Paolo mentioned timers deadline should redilated in the other
direction. After going through this part, it seems that arrival is always based
on one of the clocks we have (which is dilated already), so I don't think we
should redilate that, as this would create a discordance between time set, and
real time when this happen. Feel free to correct me if this is wrong.

- keep start time per clock and apply accordingly
- apply time dilation for cpu_get_host_ticks as well
- use a default factor of 1.0
- rename cli option to -rtc speed-factor
- forbid to use option with kvm, as time is not provided by QEMU for guest

Pierrick Bouvier (2):
  qemu/timer: introduce time dilation factor
  system/rtc: introduce -rtc speed-factor option

 include/qemu/timer.h     | 60 ++++++++++++++++++++++++++++------------
 system/rtc.c             | 11 ++++++++
 system/vl.c              |  9 ++++++
 util/qemu-timer-common.c |  7 +++++
 qemu-options.hx          |  7 ++++-
 5 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.47.2


