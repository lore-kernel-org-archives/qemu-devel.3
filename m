Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691EBD5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QGx-0004Mn-3G; Fri, 08 Nov 2024 09:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t9QGl-0004Cf-TD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:47:29 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t9QGj-0005HN-WD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:47:27 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so562299666b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731077244; x=1731682044;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpaGWOL1qCixuwh7dSG/JDouTW8eM8K/0qL8NGiv7/w=;
 b=TIaAZcc4xjFOQpyqChUk0cAdzZNMm3MfUi63JftZQSrXWHMYa0CD42LyOJgUeaWVkx
 odfbW1VvCkp7wxHawNGNXSbyQJeVnQlTZTdPD9AZ6YbKZYzcUXyggGjltqhNZMyimKC6
 t7WIQn5Ckhhw4VNqKUgcuTB2ZRuNY+QwnhSglpJ4YWm5x5U86BCfdG6ITmTuPZOiBkAm
 38h850/DR7ofJNUDru02wjo4mKztsdnQ2bKF9KCpZ9KGU/ySQ/yUxmGbIidux+Uw8hUg
 yJa8EP9WSwgAAVIbS9gFA50rZMz7iGyLz9r1w8KE0xYF57/lm4VbyvbjkCQBggnbFehr
 jAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731077244; x=1731682044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpaGWOL1qCixuwh7dSG/JDouTW8eM8K/0qL8NGiv7/w=;
 b=QJTWqV9jtVZYEwN5Os8UPosBtQBIfptwOIlrFm7YBtDuWQyznOYUGGCVcFn7H8xa0+
 7IUXeWSVTdY17APydigcAybpZJ+cH+yoJCRbhApL402b3qRB3NkKxdWO2GvO+jQ/KWoJ
 BSvoEaj9ml+dZSsLB1BlUf3r7e9Cq/aYO4JecSttpBUrtwh3WlAGgH6umrX3ek1O6g7r
 qiPR4tQC4oKkgYJgqv4KeiWbmzRqUn2G7a2pYB1tv85/Stf0YVLfMviirYuaXbErfAuz
 3ToSC/MvxSnlu5fciDBUsVX9FSYQEYmMPGMZxfY6wQI5GFE9ZHuZ4JAFAzamaFsLAMv8
 Qg9g==
X-Gm-Message-State: AOJu0YxEShzE4ydkRHkFvPZ0GHKt+o6YEQLPDbWdRx3f5li2uK/priMA
 rFOwO+beVe7x3LGbhJeyWdCyfncjY/HIG5TzrahGRFFdH/Xv11LE8+pnrNCNo7SYvShnYyhw4iQ
 zmw==
X-Google-Smtp-Source: AGHT+IH/u+IHKjLSuv4D+AFrAyRbQrYspXAWYyLv6Q4INQ1hrHhDWbPmTCFuaHPWPdIg/f6sErf7ww==
X-Received: by 2002:a17:906:f598:b0:a9e:b174:9cf7 with SMTP id
 a640c23a62f3a-a9eefeb4df1mr273562866b.13.1731077244225; 
 Fri, 08 Nov 2024 06:47:24 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4a9b1sm240534066b.52.2024.11.08.06.47.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 06:47:23 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v8 05/15] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Fri,  8 Nov 2024 15:46:59 +0100
Message-Id: <20241108144709.95498-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241108144709.95498-1-phil@philjordan.eu>
References: <20241108144709.95498-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

I'm happy to take responsibility for the macOS PV graphics code. As
HVF patches don't seem to get much attention at the moment, I'm also
adding myself as designated reviewer for HVF and x86 HVF to try and
improve that.

I anticipate that the resulting workload should be covered by the
funding I'm receiving for improving Qemu in combination with macOS. As
of right now this runs out at the end of 2024; I expect the workload on
apple-gfx should be relatively minor and manageable in my spare time
beyond that. I may have to remove myself from more general HVF duties
once the contract runs out if it's more than I can manage.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0844f5da196..c7964ab784b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -506,6 +506,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -513,6 +514,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2608,6 +2610,11 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+macOS PV Graphics (apple-gfx)
+M: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/display/apple-gfx*
+
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.39.3 (Apple Git-145)


