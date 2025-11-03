Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED70CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzUD-000363-2K; Mon, 03 Nov 2025 13:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzU9-00033g-FG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:40:57 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzU0-0008RT-86
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:40:57 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7a226a0798cso4582036b3a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762195243; x=1762800043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMHF6Itji8tSyj3SeH81sPOFo7/igN7zQv9u3hJvP6Q=;
 b=iVjL44+6VciwWApcnm178eMo5NXQ3+6kiLD0o2wpxr5gk3L6LZii/xa9k1kTdWIfGj
 QdNZSDBmTDADMR8EsnBv/oMzz3op2a080J1pKsF8io7aKe4dKy5LlCVDV7GBZ1+gR3Nc
 sPMtEIG7FinKVOZ6I+/pzVXjkCe3m6kN2l3JzKofUFD3gXtR6Js28KgWAylEw6KelW2O
 KSSpCvCGzKajfX3dwVNoQgjUd5mtZ5SqrMvkA1G7Q8mIQFYjNkD2cpDhBO0iu2kpbvim
 DlaMjS1cYlmaYtzKM6Nemm0l8xXr2hw8P28MllCiryim45QzcAIOIVRZTv44voYRc7Pg
 SwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195243; x=1762800043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMHF6Itji8tSyj3SeH81sPOFo7/igN7zQv9u3hJvP6Q=;
 b=elIctS42lXYQQSksQmmwnW4gJL1MBcLA4RwhxEgmzwk335Ti1tL0hW017ijG+tJFrp
 JWsYjKl7cclT1ubRKxScA6zVEJwLNK6VR8fE2x09YO8iGTYcnkhSWcEtdA3p+sANzjr9
 BYvc4yEXOyhszDZ67L5w4Lrvbp1QcLOoEeohxF5qAfm5mPePM5V6HYmhtdlRtMem+VJh
 +pjpZR8Tpl9HLwhOUn6/0zJm+eLMyOCZCr2FidQOvXExY6ZG6hzLlsM4W4fE4pc131SO
 OWx64c+VwJXkofp0HwcoeiS2kVEOzifa108OtA3XK3JR90Mg2QlqD+hK+8MBMg0wz/sl
 vkmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6P0kQXsWjVexG5MgR/ol8QNhOqZCe7k+6pnOzyFkcmfICNn9Ou8kiLV8xS+fcnd1E0BCvXAnPUAZ/@nongnu.org
X-Gm-Message-State: AOJu0YyEWVOvFqr9v/IzbDc0ZNU2LisLdvvd5jkpojLc3PsYIj/ILP0l
 +/rbH8FIa7WmC3mnwAWPz3UuwBFWtfkCvnqrY9WJF1d1bzo9/eONGw/n
X-Gm-Gg: ASbGnctAzOQPFs+fQUlIc0kcrP3aeyw5GaHJuosWmxKBXG64L4yND7zy/Ilzp2D5vqP
 f1OBrdG3gtkUPFvz3inlXW77w3ZNx4hPE0j3r8m0d/qzdxDTIEgs2MUY+PNnCauDx47dvhrEWyu
 O0UJZlaDY+g7r4iwUW/o9qiohsbp4R27qOsglyxY1b7WUwQhcxoT5RZZiAAYhOdkiRKPBtjUnkQ
 AtSj2+yruLxnrCJ/VJpivBt2pjQ/Lq+2cEeOT0n2/LzjkOrnRmiCwGJXTkGsn38gwGHqSsnTMOw
 LbsX1nOReVogdVt03QoGzsfPlVJ3pgh4tgNkYxJuVLVQNfYqVJTlhd60Kgy17dfXoLFyVvpqmFW
 g/3MrBgebU+3NuQtfz+2y3u9bTHl7DDuGmuqZfcdknKrdW3w4gGV9X6B7qMOTi6QtzNl9AAO0mI
 BgpPFjjE/Vt7u1HYFFhwdHgVlG0CEwkUeGoAc4HME=
X-Google-Smtp-Source: AGHT+IEKYYes0xyNCKdFRJ+ME1cr/adajOCOgaJtGTvfn9KU9EzsjYbyYRgSqd63GeL7HszrwPUTZw==
X-Received: by 2002:a05:6a20:a126:b0:33f:4e3d:afed with SMTP id
 adf61e73a8af0-348cc8e56dcmr17236814637.33.1762195242623; 
 Mon, 03 Nov 2025 10:40:42 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd634081dsm64255b3a.58.2025.11.03.10.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:42 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de, mark.cave-ayland@ilande.co.uk,
 sarkarsoumyajyoti23@gmail.com, peter.maydell@linaro.org,
 zhaoguohan@kylinos.cn, qemu-devel@nongnu.org, stefanha@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v4 1/2] hw/scsi/ncr53c710.c: Fixing null pointer dereference
 issue.
Date: Tue,  4 Nov 2025 00:10:30 +0530
Message-ID: <20251103184031.22118-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
References: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
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

The code dereferences s->current before checking if it is NULL. Moved the
null check before the dereference to prevent potential crashes.

This issue could occur if s->current is NULL when the function reaches
the "Host adapter (re)connected" path, though this should not normally
happen during correct operation.
As suggested by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Improved upon by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
and GuoHan Zhao <zhaoguohan@kylinos.cn>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b3d4593b72..871f76c2a2 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -835,12 +835,11 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     }
 
     /* Host adapter (re)connected */
-    s->current->dma_len = len;
     s->command_complete = NCR710_CMD_DATA_READY;
-
     if (!s->current) {
         return;
     }
+    s->current->dma_len = len;
 
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
-- 
2.49.0


