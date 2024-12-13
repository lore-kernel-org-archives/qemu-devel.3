Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D9E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7SC-0004x1-At; Fri, 13 Dec 2024 10:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7RY-0004QO-Td
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:06 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7RI-00056O-HO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:18:59 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso308328666b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103127; x=1734707927;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYWLPafzihE8PDd+NR4N69DEyaMCy4jGTA3EEV2mGPo=;
 b=V9r+s5p1L4qycksOhNx+/1gf11GEMaGtWJzxAb12hwHgzr4QYeswAYbytvBVSsIlnB
 hTGDVxjUNNmb91LXQ8MK9pdw7sPffeo2P9BjwLOuNS2ub9k80Ve11CUHjjL/UDs8G85Q
 k7+8sX4LACYOmKjmCw9S1LYsKdU8GbdfM9MuUzZoB/BXNa8WN6D/tDHY8BmeitgIzl05
 g1OiuIp2XrPGKJ/g38xf9zDP2s+vbYRa2m3Mkh4RyBE/GIDl/NgMPaCK2ORtr8f2zTku
 1WA4nyCzrkpBKex/v1aZogQJMeutMjKylOy+9RUvbrwbb4eQwke/K07VW1KESmz92rsG
 eL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103127; x=1734707927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYWLPafzihE8PDd+NR4N69DEyaMCy4jGTA3EEV2mGPo=;
 b=rx5JuvXtotZKHIt9SiB0546EUKF/tP8XKHNESzjX81HT8059D5W/TvFXOFJ774bxJh
 1XcA3navrufqO0J7I7CAbhDqNX5e1EKNcTPv7EBXRQOhppbcIKu1tB3lU1C80CakMogU
 4MuMR4yI/GaJsBKt8RgKwkNq8JwBGYRFAcSmdI41Xqm9/Q9piwVOuXBhpj84ZKYndi4Q
 n1clQKvv5LYQ/ytUQIEdvzLRIjZN31kwZEFhSzqG3M79zElZ6ccWMjA4bTnwfKWEp8nn
 es22NResdnj63FN3glxZi9WSpOzJH/CTS2D4wBb0UwRIjaMKQcSbtuZBnC0xqF3Pz4ql
 31/Q==
X-Gm-Message-State: AOJu0YyAjDEihNYfVMfi4sN/AUi9CBkjrenMYuaHsbUhmkKIQ9hubhhb
 TGDHtyfAvc+eHdojcMV88n+lVKe3jnCmgXUxDNY6/e6zZgoRH/rCKi0U4PfVtVOG/fu/+nodOji
 eTw==
X-Gm-Gg: ASbGnctJ9cF84C/Y5mWuL2bWs52nQhNTZvslGb07bsjDfGte2mW1GCD2QTjIs3omBxP
 zWmx+OuET6LSJdZ7kA27KthOxxe+mygrM1G0Dt29K0EZC0U9J/FOfhSfwGqmAF1HQCLzqWKRsX8
 JHvMsgbFUbMZlCKIymiUGmJE1Eve6R9vyP2IczWrt3/4uPIyth1SkVWktjrF+unc9HGI1aPZO2x
 GcoSOvpyQ+z1Vx3c78hdE8i1pO5DUJ7MauI5QC49tDqRlV5PTBoSGPB1JNUyLfNNFrRcOqayscQ
 5M68n0K+ZzoVnuq6Q87xcBApLmarIFp/
X-Google-Smtp-Source: AGHT+IE+96JPa3xipTkyLG+OaubvDgRJtDfEHtmyrbi0ta+/hRuJsstPqSTuejT3HunoXcolOfsD/A==
X-Received: by 2002:a17:906:730b:b0:aa6:af4b:7c95 with SMTP id
 a640c23a62f3a-aab77ebc7a5mr331627466b.56.1734103126663; 
 Fri, 13 Dec 2024 07:18:46 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.18.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:18:46 -0800 (PST)
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
 qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v13 05/15] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Fri, 13 Dec 2024 16:17:55 +0100
Message-Id: <20241213151821.65748-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::630;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x630.google.com
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

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a214..09899f7407e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -507,6 +507,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -514,6 +515,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2612,6 +2614,11 @@ F: hw/display/edid*
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
2.39.5 (Apple Git-154)


