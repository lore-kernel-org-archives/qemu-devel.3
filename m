Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A732F4368F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh27-0000kN-68; Fri, 17 Apr 2026 07:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh23-0000ZF-Hh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh21-0003qo-B5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ad135063so5596365e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423999; x=1777028799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inUrVWQmjyIpSk78eL5FM6ZMFkrYCwXKPYbxWMDgkSM=;
 b=YDJQ2CIVtdsvlk9FRBJmJWuqKzoiqaeX3NiaNjMTOKWnosVFAq6jp+5onhsXJCSVar
 sxoI3oU/G1Nt0mi/nz3YGSqRjJaXCN+DnUVVL4MIN7/aP+chG1XZUEePOclikaYJvXIV
 Z4ZU2jbiO6fJFnjePE8rZsRXRgcEKR3w9CnCya10EC0C4tM1c4cGca5T+5CBsyooztld
 iK990xFsWyRZfW51k6yT5mZCZXGKraZ266EayA917OPG+IS4AirF0wmCJ0gaYxQILLwi
 geh8xw/L1KxVekEFdWdd72wdZ0FO5sIkONj8zlAKrWc0Q3ShC+MH8mJ7agtKpJrH+kDU
 MTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423999; x=1777028799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=inUrVWQmjyIpSk78eL5FM6ZMFkrYCwXKPYbxWMDgkSM=;
 b=WMSdu6kFUxcwyw8ZtZHwtZhwbuZQWzjHR6hdhIzTcW8Xd1Vd3tRSln/eaHr0dXMEVx
 IOzTFVkz8f4LokIak7AWqjolr5qbYJpqlZoexH1+RWWsYUeihtoDHwA47Cf3CnW6lxln
 55UPfBNzWS1vprxS97VPQoCX8B978n/6fccKRsweEigYxIdkPoBwrUHY9MmdYCEd196r
 kMWvJLa3sA7iv4RoI9p/XWI8MXDDUjUY9lPOJlksjHqvzwemHLKseAdWUII3SaQeoESH
 L6DLYzMfkoT3Ax16vbBsavLvVxn7nGmaPbABx4H8ZSdf0Md+r0/IZGcs/YG708vsW1Di
 HiMg==
X-Gm-Message-State: AOJu0YzVWAkCHrD7ofZw61Ms7HsTN0SlaiHKYTRnOZBc+rG99iDtjyFY
 wZggszwp5BLdmsnQxFjkyrnjTrlsS7qEP2DXaiDVWuCRQu4jlNE2RQQapU+frcSB76JB8OMJh6Q
 dpgJ+GvQ=
X-Gm-Gg: AeBDieushblbzs7vKsX7nq2utpVyzeW7VbKiElsX74O5dfJiQDkGI+9ogsOUqO/MFEp
 eaNQf0jP8U3H/0GC8E5tmVP91y6HJS0x6Kykk5KnmM35fdMFMBt2/Xv5QMgzOrvW/lx2M3SvaPA
 cmIroukq9cEQkV2DfkQBMN9+BeK+/zpQ+IMZzUHa0Nybi3Y949Ssxg7PY/dK0FYHuoFTXQH7ovD
 rt9odVmx3KblzTNmc98HsLK7bLhHeY7suvrqH15JTfG3s9r2q8z0GmjOKxAhW4rVlTZqGFzfMK4
 uJM+zAJcjx65dqfwsNccLAMEFmclWTzDliNMogI2rEerw2YYbr5HrpV+uct4BKknvuVb51wOetZ
 O4tPpvsyDBdC6pyGtO9YcdYVJTOBFXVz68CG3n3fkalvs3hVkCCSmX4OAyxKCoWEkBJeFvkjTdP
 0HHa/DKFVQ4JI9h1v70FI4PR+fWMmHfaEJTXZR7Daz/kmzDooyj8VA1J6EVpEcPgv/06Pxs/2F0
 foZqb0dkpk=
X-Received: by 2002:a05:600c:4711:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-488fb745261mr34167965e9.6.1776423999527; 
 Fri, 17 Apr 2026 04:06:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm20305935e9.3.2026.04.17.04.06.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 6/7] MAINTAINERS: Remove PhilMD from NVMe Block Driver
Date: Fri, 17 Apr 2026 13:05:48 +0200
Message-ID: <20260417110550.70068-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

I'm not following this code anymore, no need
to be listed as reviewer.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df8413c79e7..3cbb5d30709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4223,7 +4223,6 @@ F: block/null.c
 NVMe Block Driver
 M: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fam Zheng <fam@euphon.net>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
-- 
2.53.0


