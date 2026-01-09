Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56937D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Pa-0003qF-LE; Fri, 09 Jan 2026 01:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P7-0003YY-Ta
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:25 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P6-0002oe-Ah
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:25 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c54f700b5b1so559963a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941722; x=1768546522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGTK42IF6KmJNzRKzLqeNTLx0V2AloFvL8EwbWCo6uw=;
 b=E+uNQ/PnpNtAUuN2XE6NtVqYmgsUhrhEeqXCGN50Aesn6EUfrcj6CYer86W39dtUVK
 M3fHeEP23DqU8C75Dn8TPWtJYPpJWCIOTpJCjtqSOLHM8zjyrKRMw0Sb5GS6IxdNGvgb
 ehlUaYoQA3RDlscwAA68WovTcMucKaX9x9DicTWCdXFJ6/s55LCTQbsBcE60x+DsN5Pj
 JG61KeeBdgOlQKhWI/M7VNJiGM39cH1fhbWMMYeue4207ks69nQwJzCfe6cuyOf9346B
 uQxP8WVtFRPykEna9u6Ch4B3Ny8xcI02n9Mmk1JlAo9d+a3gqcZoleVuvinSqLhkxbmK
 5gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941722; x=1768546522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DGTK42IF6KmJNzRKzLqeNTLx0V2AloFvL8EwbWCo6uw=;
 b=bYjWmQ1QhYASt0TVFK8vj9R1H0ks3KiZerVAzJ+eUx1K+lP1I3AlMV44IfZ/NbtWCj
 8aEYvL63bIlKofztobHy8ky8y0hrI+F4i0k8xbzsZED67jTsujiYatOKaYh5tI+3fgRe
 iBZ4krZ//WNCA9DXzXjLxUc+UvnKwQIFqW2ZbqDeTzCnmHwAxloBWVXCmZ5W45ncM1zf
 4GTA1MCXUjRRzgqIq7axKATCR08NB2zuGraIFSoDR7ks2KN7q9aH9r0oDeowyxrWMaM9
 xpGnYkJHboKe26VG2v0HK0/bJiPptzX6AZ7HaomxMlHCijlU7+FDTk/S7WgC3RBGZW/c
 f/Hg==
X-Gm-Message-State: AOJu0YxU9qMYIFhlQv2dvmDS+3CKBJPW0K3THa+Y3KXPGh/SJIZAvWhh
 PW42kKKF7oI6IkFiq780D5Mt8xh3y4JxPr5yPrzwO+YXD0IP732MOCysE/HiQg==
X-Gm-Gg: AY/fxX5yKE1x8LfCtEVlpFCgNTYN5rJEgiBLLeW84wIedz66CrAtSQ1U7HKeH7hH6//
 E13rKFE2Mkp+oQQ4QiNrrXZ7Bli2k4OYPXz0obERuhMfappiCLANgAezHvTaqH8hdfVToGtMlTV
 qEsxissmBnYbydiq3sSa4vahZUq/ABUmI7k02S6w67iravRGDKeXsf+fa8ax1RffWe6I3B74IHZ
 PiN0QUPEaA6TllUgZpJtyGFFIpJwKpGB60g4fcmY3akHxH4Od9DdVqotadVA9z4fCioOz8TsVDI
 XNZ4PU1kwsfc8M3aAgkAhixu614rqLmRylYwe37CfsQMV0JEinMs/GaX7Rs/D8s5eSTfqEvdSst
 T353j+TrtHU7ZUhLASDiTXfeHjAtJEJpyV80gqdK7+txV7Z+cvaMkAxha/cpAGBVPKle4FdsYts
 l3no8sG/40H9IHl08qYpTKjEGjLNvEdPrwWggksh04HzARJytgmmZocZOSnHEHmDONQnyx0Qwhb
 7C28OBO9Jnf/8SGSvM=
X-Google-Smtp-Source: AGHT+IF78XNsuthPdapVt4woljLS2sA/u+R+8uSwMJSzX3aCjewPMZ8uRumER2ZLjuodBTKJvZMbQQ==
X-Received: by 2002:a05:6300:210a:b0:320:3da8:34d7 with SMTP id
 adf61e73a8af0-3898f8dde13mr8641263637.22.1767941722589; 
 Thu, 08 Jan 2026 22:55:22 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:21 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/34] hw/core/loader: Free the allocated string from
 size_to_str()
Date: Fri,  9 Jan 2026 16:54:29 +1000
Message-ID: <20260109065459.19987-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The string needs be be freed with g_free() according to the functions
documentation.

Coverity: CID 1642762
Fixes: f62226f7dc44 ("hw/core/loader: improve error handling in image loading functions")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251030015306.2279148-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3d2c1ae286..2fad7292e5 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -153,8 +153,12 @@ ssize_t load_image_targphys_as(const char *filename,
     }
 
     if (size > max_sz) {
+        char *size_str = size_to_str(max_sz);
+
         error_setg(errp, "%s exceeds maximum image size (%s)",
-                   filename, size_to_str(max_sz));
+                   filename, size_str);
+
+        g_free(size_str);
         return -1;
     }
 
-- 
2.52.0


