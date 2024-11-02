Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CFCE677F8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 11:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7C15-0004v5-BU; Sat, 02 Nov 2024 07:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0v-0004t2-Or
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0s-00046L-0X
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:51 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso452333366b.2
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730545788; x=1731150588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TNhsjX2Cpr/yA7SqOqjWgXIMitZ+Y61hdylnWvfm0Ok=;
 b=G+7YrDtv6tBcapzRcklwLkmQI5z6nSo9ZyCk9iSRGwAJTpbg3oq6grZwudQcF9Gp/r
 mmOwVp1VQUtjQOeUjkDvpIPhDJ471OLEZcqnNzR5o/8jqWiviQBpnf0BgRtwPha8ez+5
 yk76eeOf7wfRTFu9VxQwYY7BS5t/baTRZawJ3oYqx7mnVbbEMeW+ZzelqTdIbz+GMAiB
 tD5FpizR14JY6RK5Y5h2QbKd8lirUyIPNAAjNWcQTo0ZBWJV1x0GO57pGlM1xrMISPLl
 dZKTXsHPm0FyL51yLfK8B7UFdP8RID1I1LEe65PDQ6BXnsz7Y8KDCtTQDzVaOMhS0sCA
 fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730545788; x=1731150588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNhsjX2Cpr/yA7SqOqjWgXIMitZ+Y61hdylnWvfm0Ok=;
 b=Q9du/pOWdz9O9gsxEEacKVCt01Nvu6398MRD1DL+d5vSgdkvKccUG08UFBuEOb7EeL
 eADR1721a6KIdtbcOiI47g57x6dq9Zj1YR7LPm6OGXPYF0Pxco2U+ATHhzCWZWAr3c/B
 rv8iH5pdumuZGKad7l21WYzPs72O8HbHqq+s7mzWHnl3GBDcL8aoeFwm+zPUGxop8jmu
 Vs9INax9J/rw659kywMedA7TSDy5L2hoi6NYuWsScrNB3muezErG4afFsPNq0+F8eEUG
 uYuQ3WChavn7pbKPH5ZR9ji5lyPo/71MviPu70uSm7+6I8qXExnTV1AknCpIt3w7emgE
 PiXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHgNMgGAdmdfoxQg449HGsBfDYpgNjWPKOcV9wc1hdQP28oSPOuEQ0COzxRXjGVF2WD+OoDzx5xiRY@nongnu.org
X-Gm-Message-State: AOJu0YzgE+uy0LfQQrMC0qW/8FcpC8qE+WNXp3zKAxpIfkTlIb6LwrIe
 srRtxCvvceJetCCtn5ptkyDiPd7B9Al2MxxyPwG5kVJXqGjtBVdR
X-Google-Smtp-Source: AGHT+IH1cKT0JGN+Km1JmEUR31/srysYx3LFwCJ5IlUoW2Hst3II0ilv/x0Ys5TGFYZmSy/ep9LT5w==
X-Received: by 2002:a17:906:6a28:b0:a9a:e9c:1d8d with SMTP id
 a640c23a62f3a-a9de5ed2633mr2480888166b.17.1730545788122; 
 Sat, 02 Nov 2024 04:09:48 -0700 (PDT)
Received: from finn.fritz.box ([185.237.96.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e56684912sm294991066b.200.2024.11.02.04.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 04:09:47 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] chardev/char-mux: tweak mux bitset operations
Date: Sat,  2 Nov 2024 12:07:17 +0100
Message-Id: <20241102110719.682399-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x631.google.com
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

Patchset tweaks bitset operations by changing a constant to unsigned
long, introduces a static compile check and simplifies bitset operations.

Roman Penyaev (2):
  chardev/char-mux: shift unsigned long to avoid 32-bit overflow
  chardev/char-mux: make boolean bit check instead of find_next_bit()

 chardev/char-mux.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org

-- 
2.34.1


