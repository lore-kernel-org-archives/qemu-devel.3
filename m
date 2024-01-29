Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAC0C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMcJ-0000Ej-MU; Mon, 29 Jan 2024 03:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcH-0000E9-7v
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:41 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcF-000567-Np
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:40 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-59a1a03d09aso739482eaf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706515418; x=1707120218;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VzVRVHtg9Mk35tPXkbEDWM6r9DNFo9zkJCcDPTPN+mg=;
 b=ZeZiBsRqT8pYkAhQ/LyZdThADu3PYc1uQ6Qcv605pABk32q0Eo1OcfzbDuzqTzIro3
 NKK9fKzrfRqY4G/YavB34fOv3Kiun7IVEm112T02FwCR0ho3/ZQmdUyT6Uy79b+DYZwg
 v2Cx3xQF41VX5We2bZ5qp14vl4SnmS1zXM4Lo1kbI03NWHr1RJwLNcqOxlDL920t6+0x
 EjAFzL+LR6a2PIplXFYMvELjjB9BaX/+YzxPE4ORiFupQ7hDs6x8z2MQvxjltssyFkHk
 RC8IJAzNsCQcUcnFbVj70ondJedqHsbVcm/OJW+rk8ZLbqVnNBDjFHYDzTznl9YXww0L
 3bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706515418; x=1707120218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzVRVHtg9Mk35tPXkbEDWM6r9DNFo9zkJCcDPTPN+mg=;
 b=AAP+3ErQjq+vhngR6hsO97riDkBw/6kv44XNfvcGvlgADXvNZ2EP/KK+r4MznAAK9L
 tJlqXccBjaQf2f/VmG5vRFpPDrN0r5sXXJJaGBeRb329GWAbbCP9A4TgDNgiSzAE3Sj2
 l1NfCZf+nl7OAhB4lmtFGzEZoBZwn+uZcBMaO70EoXZEQI8HdPoKIFqLF+txfk2zF/Wn
 tZTmK9d4pgWvLo1Mu0L/Og38YUQgMOcoNLfaK0h5QLfZWclooJbctNuk2+JLTaa8LRzB
 qPlNkeQAp2sBw777Gv0xOXJ8OwY0ltN65BSHnNB/Mjiuywmt9KpigQRKL2qIhjxp3zzc
 tVrg==
X-Gm-Message-State: AOJu0YyNuTlos5AzQukk6Pdqql+n9PsjXQaZH/XTemQdyoO4BNsGTU4W
 evZZxy42mpBTprUkIc0nIDClBsF8Lyz0Pj97TcwMCiV/WArWaDA61xsolKpQvYk=
X-Google-Smtp-Source: AGHT+IFvz36UbhpYjcsTYr7MBAnVeYjoIlr7WJhjQdfweZtmO1hKOVNlTr+DEDeeN6SBBwtRa/munQ==
X-Received: by 2002:a05:6359:4c10:b0:176:5c13:3cb9 with SMTP id
 kj16-20020a0563594c1000b001765c133cb9mr5524963rwc.3.1706515418534; 
 Mon, 29 Jan 2024 00:03:38 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 x22-20020a17090ab01600b00290a270d8bbsm5339584pjq.55.2024.01.29.00.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 00:03:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 29 Jan 2024 17:03:07 +0900
Subject: [PATCH v2 1/2] hw/smbios: Fix OEM strings table option validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-smbios-v2-1-9ee6fede0d10@daynix.com>
References: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
In-Reply-To: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qemu_smbios_type11_opts did not have the list terminator and that
resulted in out-of-bound memory access. It also needs to have an element
for the type option.

Cc: qemu-stable@nongnu.org
Fixes: 2d6dcbf93fb0 ("smbios: support setting OEM strings table")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 2a90601ac5d9..522ed1ed9fe3 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -369,6 +369,11 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "value",
         .type = QEMU_OPT_STRING,
@@ -379,6 +384,7 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
         .type = QEMU_OPT_STRING,
         .help = "OEM string data from file",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type17_opts[] = {

-- 
2.43.0


