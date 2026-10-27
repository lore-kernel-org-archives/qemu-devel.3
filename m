Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6790606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzQH8AVP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn5F-00070K-3p; Tue, 27 Oct 2026 15:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn5D-0006wW-0c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:43 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn5B-0003up-G3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:42 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-36a1e794908so45900eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130220; x=1793735020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLIiTwiniZVNxB7/lQ0mjV3mimZDp0FZmcqxP3kuF9k=;
 b=FzQH8AVPmaS0fL//kA7WURn8J2TWRal2d0w3tfi1IIt8SD0A5HVZT8srpyp/3RXBKG
 vQ+JUbGutFpxw3AlVxnuRsr8ciqZRQDnVB9Gw+KA4/Q6EMTJl7Wccp5uuOHhkLoEd89A
 JY9YGlt6TL8ZLrAOL71HPx7e1ysWmzQvQSNaU+qkzcm9ymMqSmvunMLE7WdGsVUwyqq0
 zQUFXfwet05no+vCO39AxzZbmTHL1Y+fS1hrJrjg0C/hGCrMYCd8IYjxqaRbvI8FrbnL
 6xQXrCM47OZ/8G4CGUhwCDa+cVoAZJba7QFW92StKMyHjN31Z1/OnttXJ75zFjYYxIzu
 MXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130220; x=1793735020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLIiTwiniZVNxB7/lQ0mjV3mimZDp0FZmcqxP3kuF9k=;
 b=keC23C3S/igc9mjl1RpxTY2yaUeFP76zOm3kZKFLEn+In0EOic1Vj1lZHtqSRr4ubg
 1fEd7mURGIsOlNeywieNF8PvQ3limCltFXPU7LHHVi08lOxC61WG6U+whmkG7y6STSkq
 FxlQJfkiUvP5K/dHKRPFKIgvtVYVrWqKXtwomlY5khjMyt+K+Bve2HkxwFHkZkrMkSUN
 NNCm/QIB6oSYTUkD/4ymc/bJIuXaQFI5N0vO+oDiEX7anJF3HhqOr1cKDXqWnAf56CUp
 LvUPu8RqED5HxUHOC0w1gnSg+fcRDnR1dLjEgCTeIuAC5FynOuBWrRiTBxbIo0PJURwB
 L8ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5T+JeS4SJbVLcLPqmDsy0W0013bRk4YWfJDCmh4RorhAN2nqZS4Knq/qAzYySg3f50TlS/YAA0dGA@nongnu.org
X-Gm-Message-State: AFq9FYJ7ucS48uY76O+pNZHvEdGTh+2O8aCIeIRt/FYjzx/ETjLzsH8R
 RgNyXVSe8nODk8B259Wg2Bx/C5rMZeOs2jbLQrrO8OBbGE65osvQwCFT7VwmDPVapl4=
X-Gm-Gg: AYBFou20FZtACepCVfpqGP7ULX1y8blsZnN/edakJm4sd3vCS7thybYTGAlAsFPxahr
 dAXy8F23bKK+Pp868KgPFQpBSqEVgGBPokTvbU2m2OT23+01+YJb1qFU8Ge8AbyiX49ZTbp0hfn
 K8w4v1CaRj++ZlEqA8xj3XoqrUFa7PbS1DAsoIFNPNvosDHng8bpULZT0a3+It1WK9HSdtztzPk
 uUddM3NZn03CRAJrML5oGnv69RWkE6CB6RZ2omlcdM5dlyOUkdAjiCV5xLU5lakDGNG/tk4HPR1
 tmh9a4us9uQ/TM5TVn3LP52bjKVCA39PO7NG38G2tmX9WbxqeBef4VQp8H8kwi/GhPxM6sOL5Rg
 2e9NuJQRh+fBBS3nJd2szcbUYqrCcEz4XoK/Ad2yVWKHpoGKMB2y2Ngauur9x8DtDBbxG3LJ8IK
 Ym5T3HMrWS21uBmRrMicc5EHNHs/rrk4NZFP3SddPKKFBPmFVO858ycmLNQAoI0TDUw6uC7ILHj
 3qYfaFGOAKIzLCPy3XaCdLHTo+I9nqvejXjd+Bvq4QGoXIzWaoXVm1ObhLtHoYN+teGcfdR8w97
 gkLaqDRXA8BUtUMCZUzxrLiswWbO/aqjAPVSpTHf2hjrkLtVWBWMVKCDkmbhIUZmlhsY6Rbwtvr
 bz+ABhv4W9xMcCYehWI3spEXTxttfLIoOluSnBFQawHtzTsVtwQ==
X-Received: by 2002:a05:7301:4b09:b0:36a:1938:8508 with SMTP id
 5a478bee46e88-36a2016e243mr540962eec.38.1793130219959; 
 Tue, 27 Oct 2026 12:43:39 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:39 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 8/8] hw/input/hid: clear wheel state and mouse_grabbed on
 reset
Date: Wed, 28 Oct 2026 01:12:56 +0530
Message-ID: <20261027194256.76031-9-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

hid_reset() clears the pointer event queue but leaves the rest of the
mouse state alone. After a guest reboot the wheel and pan multipliers
the previous guest enabled would stay in effect and leftover residuals
would leak into the first reports of the new boot.

Reset the multipliers and residuals together with the queue. Also
clear mouse_grabbed, so that hid_pointer_activate() activates the input
handler again when the rebooted guest first polls the device, instead
of keeping the state from before the reset.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index bc84e99dbc..403cac127e 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -551,6 +551,11 @@ void hid_reset(HIDState *hs)
     case HID_MOUSE:
     case HID_TABLET:
         memset(hs->ptr.queue, 0, sizeof(hs->ptr.queue));
+        hs->ptr.mouse_grabbed = 0;
+        hs->ptr.wheel_multiplier = 0;
+        hs->ptr.pan_multiplier = 0;
+        hs->ptr.wheel_residual = 0;
+        hs->ptr.pan_residual = 0;
         break;
     }
     hs->head = 0;
-- 
2.56.0


