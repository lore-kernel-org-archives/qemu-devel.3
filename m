Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA23CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShG0-0005KL-Bu; Thu, 28 May 2026 16:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShFy-0005Jy-2w
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShFw-0004J6-9Z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso2389248f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999782; x=1780604582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ODOV5JhKUMQByHszWJrpHVUdsjZx7YbkUWxZtjF5qcE=;
 b=t1IAanMV0xTW8d3tYOjBpTZ8v9E9lXPl5imleiOGzUCVTy9c/Zbg71JI/1esqTBEzU
 Mz8iiS629UHlEuILOSjsyTRnpPRzsMqgjL7A0x+qGaKXjy7I1zNiHNhTSR3gwlsoJUip
 SlDQNB4LabfhAxpPZCTLpk1ey55afTbOnL87V4/oQC21cL87brvUsI2cjZk4gjQyj7SS
 5l9VyreYjPjfl7HXdI3vMiQEuZldS2TQRf/R3hyKnMbRH6S7BIjAKHhPrOWP22+DPOot
 rVvoJ4ZYjgOcVOWzWuKOy2ZYKN52aZlpZ9KVtUhJkQC/re712/GR/1BMNAogtUHhmqXI
 yCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999782; x=1780604582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ODOV5JhKUMQByHszWJrpHVUdsjZx7YbkUWxZtjF5qcE=;
 b=kDLhw+ge12dNPQy9pNqZw1Td/j4khlcDMsrh1K7l2RM0kooANXqBosL5lfC6D1+t7n
 La1xoHuKCaF/XTF2joZmow9uO0a/Yv/SZttF9OzixdSGFtU24Nt1NosZTkHBAQ18GhWS
 6UQuZYEZVfkqEyT20lbQ+WUDtgkOZVIwdaDVfPN5QAAoB4uZykqOAGFoi43jN9GPSvTc
 4BvOlhBHwfBl6VstGKXkaHu4AInly8xkCYfuyyTuqEp9rHq68hR1oSSLcTDs34oAAnas
 RlsByEiVLIZrCEnecWE8Gvn49e+fMRPXh4/ysQUVYYRVJXmuTamCJegmYCGrkgsjBqwx
 y4UA==
X-Gm-Message-State: AOJu0YxDQagyKyb7TJgJeR1KD4xFQ/SKJerTwlSKVjqpoXDVGFXrL/nn
 x3kkFDJdW8Z9H5GDQoDkEKB9SSRWOWLXGvb7/i5Q03DkGde3vD73uDcaUk6XoQu1dGsKuoXvXDg
 Ic3VOQyRpPS6v
X-Gm-Gg: Acq92OGJHDPkoDY+WF+BS69XWszciO+wuVKLGBDLYBHGm6yWM7sCNMoDYSzdHyvmbhj
 kEdYIHejt6r2g9wc0eE5c5Mltg/+sNXARP4yA7k8LUUgTNk0z8A8Fauz2CI7f9ImnyEDuYBtDjf
 fJvHsbGDS/kq8Omrj9yOAFmlCQj65qnkhw76UEKn71VPzeCFz+iYcUrl0eZ4aCiKDl6yRvqEg8S
 v3QLt+IDS1Kb+lR+w5A0r98n2W8iWXID7/jzwxIZ82r8dgNxptobU0qYPOx/Lg5US+MjasMfSlZ
 6PdDpXBmV3JdbeLHrIC5G0ANDGcRzfSFnp750yH1oQ2BK3wWKp36SD4fdZoJBTuJgUHMoVYf3Wc
 GiaemKJGpBs1gB4lGMtFsBMIDGQYzVDvYhxGejdQ9rIcwSzIVZ7NCVYUTAk9/fC/N0Y69GPRzRE
 EXsg63NgVpOK/lRDc5UtgVtZRf8RdFHod7qhoxZkTDlsVxYqsUc14v7hoO8j85V6ISeQ==
X-Received: by 2002:adf:e503:0:b0:45e:ed7e:f8fc with SMTP id
 ffacd0b85a97d-45ef029a166mr967798f8f.12.1779999782472; 
 Thu, 28 May 2026 13:23:02 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1c7bsm15639999f8f.29.2026.05.28.13.23.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/22] system/exit-with-parent: Close the file descriptor
 before exit
Date: Thu, 28 May 2026 22:22:31 +0200
Message-ID: <20260528202253.49122-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

From: "Richard W.M. Jones" <rjones@redhat.com>

On macOS we leak the open file descriptor in the background thread.
Close it before returning.

Link: https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04286.html
Reported-by: Thomas Huth
Fixes: commit 886898baad ("Implement -run-with exit-with-parent=on")
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260518184333.8505-1-rjones@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/exit-with-parent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
index df65d2231a2..d236944572f 100644
--- a/system/exit-with-parent.c
+++ b/system/exit-with-parent.c
@@ -109,6 +109,7 @@ exit_with_parent_loop(void *vp)
         /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
         qemu_system_killed(SIGTERM, ppid);
     }
+    close(fd);
 
     return NULL;
 }
-- 
2.53.0


