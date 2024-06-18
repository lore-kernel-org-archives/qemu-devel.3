Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA2C27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 01:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJNCx-0006rc-Uj; Mon, 17 Jun 2024 21:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sdZwZgYKClw97OLMIAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--fdurso.bounces.google.com>)
 id 1sJMqT-0001yK-Fz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 20:37:09 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sdZwZgYKClw97OLMIAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--fdurso.bounces.google.com>)
 id 1sJMqR-0002l3-RW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 20:37:09 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-62f4a831dd8so89438317b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 17:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718671025; x=1719275825; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8YP+JCisrP2EHv1oyPdw3Wt1GjDXWfQDW/Bjqlg8csI=;
 b=aeEIhLiZwmHqtJUUOyUQkV9nG/xxkyIE2V/+xZnWLDrzR9vXq0CL8KOGuih3Tqej0J
 lwnFd1ScMwrXD/LcvYm4CVrK9DybW7cHEQxXUudj5yrN0m11qO6PSbR1gH18sVIHiIm5
 uGZBuQgkNj1iRC37jpw17oCCxRlDCycxvX56Ys+t3koDETxJwPK0uLH3OInX8Bg25kM1
 sepCNLz+GYDxNLJSzMDgtxKLEJc6WL/s0OpSvPdUf3MZtTECs0ppNLc8yHu7CeK4dGyK
 1cZUW4b5f1GGs/74M7Hd8nIU8eurkmMMfTuAbGOKUB+33UpFPOlBRhb1V3jRl1QH9QX6
 SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718671025; x=1719275825;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8YP+JCisrP2EHv1oyPdw3Wt1GjDXWfQDW/Bjqlg8csI=;
 b=tpwBAV+n9AKpWN2BCFoO2n1Eplsw54IKg8Z+wKJa2Id/rW4/mwKJuBtwZdS3i68afA
 8E+Q3NUVK9/yUVoM1UiwhiuFDqT509G39JMAHNKSjoqbwi7kwtHxtxLwhF9nO4eIVQrh
 9AvwNTi8NYBn9Y6QkMfh0hPDugJQMOBm9e4CHC5WnnWQry5g2AeK2liv0YbwRTsFhHkP
 VubRAo597JNQd9nNG9YioqJx5QjtyNYMG7Vm3d7R4TgdIHDp66rAq3myt4TN7vaY6Zqy
 G5WCdyOPTQFBrRFoqORGi4BjkCEvq69hykd2PIR+5L73L2BaMkMAfYEhONv2EHOe1cuM
 VVNA==
X-Gm-Message-State: AOJu0YzkOO1WgHR9fuHR62Vq1C0r5gFqYhn88L5BcJFSrPuIbychpTZY
 nEBawmNxyPjzBhfBtDKPfos21CJyxnwcmcj7vtDfC4gOUJxf8+btUG4BVVpx2XgzpND00c3ULn0
 GWF8+i0+Don0V9oQfrDIHvv+vYuBRmH5d5crxhzUiy4otnFNfqimzeDwEy76VHXA5EN5NWN6TXE
 g1PXFFDGn0IwXhNrOPc/eI2q1JkHfo8qI=
X-Google-Smtp-Source: AGHT+IEgB01OsSnyoCQxrSyANTpGk0aMo3/i8wQrS11RfoZ0U2h8mtisIHbpYrb/aR0Gzlkj0SDbL9orFmg=
X-Received: from fdurso-c.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:24fd])
 (user=fdurso job=sendgmr) by 2002:a05:690c:7441:b0:630:28e3:2568 with SMTP id
 00721157ae682-6322294d217mr33196677b3.3.1718671025114; Mon, 17 Jun 2024
 17:37:05 -0700 (PDT)
Date: Tue, 18 Jun 2024 02:36:57 +0200
Mime-Version: 1.0
Message-ID: <20240618003657.3344685-1-fdurso@google.com>
Subject: [PATCH] hw/usb/dev-mtp: Correctly report free space
From: "Fabio D'Urso" <fdurso@google.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Fabio D'Urso" <fdurso@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3sdZwZgYKClw97OLMIAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--fdurso.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jun 2024 21:00:22 -0400
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

In order to compute the amount of free space (in bytes), the number
of available blocks (f_bavail) should be multiplied by the block
size (f_frsize) instead of the total number of blocks (f_blocks).

Signed-off-by: Fabio D'Urso <fdurso@google.com>
---
 hw/usb/dev-mtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7e4a0765ae..554b397e88 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -886,7 +886,7 @@ static MTPData *usb_mtp_get_storage_info(MTPState *s, MTPControl *c)
     rc = statvfs(s->root, &buf);
     if (rc == 0) {
         usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_blocks);
-        usb_mtp_add_u64(d, (uint64_t)buf.f_bavail * buf.f_blocks);
+        usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_bavail);
         usb_mtp_add_u32(d, buf.f_ffree);
     } else {
         usb_mtp_add_u64(d, 0xffffffff);
-- 
2.45.2.627.g7a2c4fd464-goog


