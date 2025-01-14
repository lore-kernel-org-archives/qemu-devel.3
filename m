Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1E5E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFf-00056B-1Y; Tue, 14 Jan 2025 06:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFd-000556-BH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFb-0005Oy-Jg
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so10497742a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854706; x=1737459506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DqQTTK9Sh5XJ9myCGTy9pkOibsLIRbJz9Tu9rOcYZ4=;
 b=A4QB1mBlzVVvNZeOklzQs3EHauah8u/7Ii/Qm4ZQO1HhCa20Pv8aEQLcbSOTMUtAfC
 x01IzwANF9V55m6fsyXs216UHTessl9IE6XESyRuDSk/G51BPAIXGNPINp6hoQU7ljW6
 RxghuDEc17RSasRjJLAnRCQyBfXzidwbV4Y34Y0ErL1iX1JQ2KEDVWhETe1RpxbE/qdf
 gVSud62Z0BELEZ+QOpKaAZ8Y22IzNHPlk0QOPru3EYSVDbT3+S/HBsGNO4QUQ5c8gowi
 cF7OsIGkimizeCtX7x4NRE3SqqXAw+8QRPb6v6NSgK4fWkL0AZRIfHVV19zYEnSWLtIK
 o/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854706; x=1737459506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DqQTTK9Sh5XJ9myCGTy9pkOibsLIRbJz9Tu9rOcYZ4=;
 b=NvOXNH0YJyilQ2Gv+dN+O38oX3+Ov21PsvEv90WiT3KSuI0LvaAlSxO/hXB+ex4a5c
 47eKOqqg+yivtYIRT/IgdX8skRh9FY1AdJCo8SK3TcT4AbbTy2FtY2oB5NKllz2rG80V
 nvV+HPz2XYbiaRfxNPG4No0TdPqvBkDOEV+FR8wxBbMX6EftuK9DXSMZk82I4Db4dONK
 oGXyQddWUcWdbGebdJvWaQ+4W3xKLZ+7w5dlqfjZNDZ92Wfnfca6JPdgqy3cQEDmXw5o
 1O11JQm4NPkr5JFAvRrpQlF8z3sphxdEpPY6nP/Gr6csPXzUy5md28jRuB4lYpSDpnX9
 kODA==
X-Gm-Message-State: AOJu0Yw4Yv/NCJytCXDGPCXgsGl8R96BeRR3cVcAEPSMzpTmPTVqAiVV
 f2Z+o3aq9/XdRFspeci8Ea1bmkEqCCTHa7T57VEAuHlVKQlVglE98jpnmwUKUW9xjp5ukwIzsbf
 DK7U=
X-Gm-Gg: ASbGncsMSK26TGrg0e4QkkTUw9kgoQeKEZfZjWjN4Hx3W+IxOLeEKln9hetI4fd4jSN
 C5a8QjcyynM2A+qNeAGwpAUeOZnyiHuLqrcAJk1VGiPXuFCCBN4zo94T1+teFXnefCxmzx9QblE
 zDftmeCp53+kbsX7FxlMIsQi6am5oebLSSja1XRdN/FJkoJq3AfM12Z8xkHStXRw/DYDTjgn2n7
 GvxWmUX8KPlluZ9bTz9uc1BpXnsC9jILWt/mLL3WT+FPZvfH7yQzXI=
X-Google-Smtp-Source: AGHT+IELSQpyZMkTIrI2S414p872NkGhs2AUUkgFQLRAbZ0dznXkH47Tp2d88oamqAHzZh7fh+JY6A==
X-Received: by 2002:a05:6402:388a:b0:5d1:2631:b897 with SMTP id
 4fb4d7f45d1cf-5d972e08403mr23149494a12.14.1736854705216; 
 Tue, 14 Jan 2025 03:38:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4b56sm5954625a12.32.2025.01.14.03.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAA355F8B5;
 Tue, 14 Jan 2025 11:38:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/37] semihosting: add guest_error logging for failed opens
Date: Tue, 14 Jan 2025 11:37:45 +0000
Message-Id: <20250114113821.768750-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

This usually indicates the semihosting call was expecting to find
something but didn't.

Message-Id: <20250109170619.2271193-2-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index c40348f996..f6451d9bb0 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
@@ -287,6 +288,7 @@ static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
 
     ret = open(p, host_flags, mode);
     if (ret < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to open %s\n", __func__, p);
         complete(cs, -1, errno);
     } else {
         int guestfd = alloc_guestfd();
-- 
2.39.5


