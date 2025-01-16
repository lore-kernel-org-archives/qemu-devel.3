Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRLc-0001xH-JW; Thu, 16 Jan 2025 09:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLa-0001wr-82
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:59:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLY-0008F1-Lj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:59:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so9640515e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039587; x=1737644387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6pmziWnNaDV6beFRLi5dxmWiupvkK6+TjRcXkuuJ1cs=;
 b=CNW9o3awO/0L9hzbJSra31gUVrn/11HUw8bX5RVqUs5uh/9+vuLtQO02UOuSIhMiXA
 ceKbJypVgSMFPUk0BvSIarUl9cF1OC3DOnFqTVQ/UHBHUOhwkHudjtpqCaCuvA47SYZz
 A/wv9M7bWvJgJ9NuB+3CkIsk2/s13GciW90cAWtx+qZi6LZ+2xl1I8tEex/iu3HJPtEK
 gqpSeNH6sPSAa0KxAP7ItgiJ6eXJoJY6eIM38RDn5cSvGIES8iRCB5xrEUZ0z+1aZ9UA
 vhBxgcQnLvkOuHI9mAx2i3EUEibCMugLOa0XiONOzOcHv1bhkVYOmXk0tZABr3PdJ2XG
 v1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039587; x=1737644387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pmziWnNaDV6beFRLi5dxmWiupvkK6+TjRcXkuuJ1cs=;
 b=nAQU/UctYUyZxQBFfFol0hPDfWQqgqjIlNnRJd6W8m7N57SL822Zmk4ZhrYUR49xwg
 67E9mE2rHXoBr/ijZsvJQokUMGzMfdctlhiciu15JO0Bk/IhbeN0iECjzoKq77HesdB1
 vI3YJvMZN4md/rq8x61iEL0AKa+l22/2jWQDYiWCTnuUKcCAMoh0ycYTJHDnZwceRdRz
 WvtLyGDdAhGpjKBP5K8igO+vE9B/bU8Js8kBmqGHd8yRuJYdkE6EoruP5/GVN4c2wa8A
 BMYzl67nLCL1lmjgK3k4YobHQlelEiUJWvkoqJOB3TIJqPaECzVmgyU8/ShTbzVkNg6k
 vh4Q==
X-Gm-Message-State: AOJu0YyLbWJuQahLrrYgquPboOkTL/PoFwFVeaNX/249HuSNaTQwa0Bd
 m3mV6924CFQwJihfPz2XFQCVpZIIareCMEZVW4L06qsLYeokVyb0bEc7ue3VCdYf09EKwui/LJ9
 39W4=
X-Gm-Gg: ASbGncvP+1j0g5lInvhsi3Qb2gv9fM0rxqEd3hfoijcPYBmeCSd5nkF7jrmTMlkrWcs
 niLytBDD4+AovdyAR3XC/hE6YlKC88Hc3DqLYl56kAqF5NbcV/YB10DY/9ofSUZumgHMC/k/qjt
 d5RFtKTOASP4+fFG9Pz/iNxEGbbOyhIfu6Y3Oi/na/94spWq+f7VzCkf8w3X2IaqmavKlBR80WR
 pcFyTDHW7j3v17E9/famAbOswCi+BomDOZKvpUQ5xK3RHw8RG2xAWH00npimjBCXLu3bgBke4oQ
 zqXGQ6YlHT6GIPpx2zzxGI023RngVPY=
X-Google-Smtp-Source: AGHT+IGhBahpXmlwOAM1TWFTZKRt57VqRUEyN64K4dImnjWAujJuoRZ7ymPjwp1yEQDXpmf6jqPSag==
X-Received: by 2002:a05:6000:4023:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-38a87330649mr31307055f8f.41.1737039586851; 
 Thu, 16 Jan 2025 06:59:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3215066sm93922f8f.11.2025.01.16.06.59.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 06:59:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
Date: Thu, 16 Jan 2025 15:59:31 +0100
Message-ID: <20250116145944.38028-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The versioned 'virt' machines up to 2.12 been marked as deprecated
two releases ago, and are older than 6 years, so according to our
support policy we can remove them. Remove associated dead code.

Since v1:
- Corrected disallow_affinity_adjustment removal (Thomas)
- Do not modify docs/about/removed-features.rst (Thomas & Daniel)

Philippe Mathieu-Daudé (13):
  hw/arm/virt: Remove deprecated virt-2.6 machine
  hw/arm/virt: Remove VirtMachineClass::no_pmu field
  hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
  hw/arm/virt: Remove deprecated virt-2.7 machine
  hw/arm/virt: Remove VirtMachineClass::no_its field
  hw/arm/virt: Remove deprecated virt-2.8 machine
  hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
    field
  hw/arm/virt: Remove deprecated virt-2.9 machine
  hw/arm/virt: Remove deprecated virt-2.10 machine
  hw/arm/virt: Remove deprecated virt-2.11 machine
  hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
  hw/arm/virt: Remove deprecated virt-2.12 machine
  hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field

 include/hw/arm/virt.h    |   6 --
 hw/arm/virt-acpi-build.c |  10 +--
 hw/arm/virt.c            | 136 +++++++--------------------------------
 3 files changed, 26 insertions(+), 126 deletions(-)

-- 
2.47.1


