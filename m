Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4053C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZt-0005FJ-QL; Fri, 02 May 2025 14:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZr-00059m-U6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:39 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZp-0005TX-V7
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:39 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso436825566b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212256; x=1746817056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7W0BMY8RW+QgVy2DDvRgW0zJIWF8qk5txc1xkIoqDmI=;
 b=okKwYrCH4fb0GAwxyZUireMgFtNBlnquyTJl+scP2BgYKObt96paspU8yAaFhakmr2
 VrmCi8P62Jhe2KaPE4V2s8mqGmqajR31Fdm2BU+0/jPGvg7ZMx55XoETp7PQ8Cp4Eu5A
 DsbEZsXAieRZMIkY6izlCJrf1QEExT91dV1CjcpigFHiotRGN2s892AlDj2rCWDWDgGj
 E7J5ftsn3laa0AmBs1iBYnYZE5SP+3bmTPbOvU3QPMD/b9T6kf8KJ8/3NehvTFiniHfv
 V/x8Uu8g6lI805iUIZnCVg1k7gElSOQxvojXb0FxlKvhvnXgekBSH/nHyVzgakVNCYwi
 EqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212256; x=1746817056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7W0BMY8RW+QgVy2DDvRgW0zJIWF8qk5txc1xkIoqDmI=;
 b=BtBv6PfgeYaX3745e2bHmspQDo6i2EQjZaRZrtAFLiZRNBJy+G8wHu2PtAAoS8eXI2
 PpDVmJCISP0b+hseilIoQcPAlQl6zGHtpmgdFzU46Wl3WI3F4Wt/Fyv5dP0hk5I37qIT
 RawjwhYszXze2ECIpHRiM0MGZsT3+cLpfHckBLPv5S/qW527q2Jpdtaptw69YH1ltTOk
 TJko7vId7CzgNCCiEy6pCdsH+vq8Ko+ab5HLgW1MS84W3lp3dbW9Gx5sq8NxCdxMsz+E
 P4QxXCk6j//AMZYSX2oIANQNHF9IW7u0MaDKbDEVysDkvYsls2oaapa+j76D74h6xsQH
 0S/w==
X-Gm-Message-State: AOJu0Yw2Rf2iXOrlmhFmcim1t6FxUFEKWQaZ1SIeN/VW8JXAjMQSJJBw
 CleLPMlrv3rBC7my6jVXAhjCslcqe6dYV9iLXrZTTERN10s/D7LBcbRITXm8Z6ECr2UuLIXMFG2
 m
X-Gm-Gg: ASbGncuFWkhZGWh6C0jdhLfVS3c7G8alsvr6xVYV0MGlxUMcBd2sm22ZPe+WiOIjF1k
 dkW3QujjqjRMrDoQyGC8KgGYOVkPWlaXEnS+8dqcRpZZtRW3Yb4rV5/Rr73g+g8HAoDHiENFokc
 u/IcaKnqU/V0GM8fHkqgObgzb6xP/mHjk64SmQaZt9nN6wKMgMp00fIZVRBigGry8NzPGxkJw0l
 QBmnJulFNbOfbnZyion1iJpDAa4Yzd7jRQDQL0w44tTPk9930knpbunNFxM9b7I5FsFIUOT2qd8
 rGTD50N0WvnDH4YkiwNkef0TkxshvwOBZZU0t5/XDyKu8VkpfSVR+KNEMvd2X6iYzX8iJguspB1
 mUecl7UvORZ/GSUuGjEC9
X-Google-Smtp-Source: AGHT+IEWo9HjXE4DNH5rf35EVfESZitQ5851Peyvf3rqPh+6nbMg8i/8hbEMRlvbQwc9Hq9pE7zeug==
X-Received: by 2002:a17:907:394a:b0:ac4:2ae:c970 with SMTP id
 a640c23a62f3a-ad17b5ac529mr354547966b.21.1746212256211; 
 Fri, 02 May 2025 11:57:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18e68b571sm31491866b.104.2025.05.02.11.57.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 07/19] hw/i386/pc: Remove pc_compat_2_6[] array
Date: Fri,  2 May 2025 20:56:39 +0200
Message-ID: <20250502185652.67370-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

The pc_compat_2_6[] array was only used by the pc-q35-2.6
and pc-i440fx-2.6 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a3de3e9560d..4fb2033bc54 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
 extern GlobalProperty pc_compat_2_7[];
 extern const size_t pc_compat_2_7_len;
 
-extern GlobalProperty pc_compat_2_6[];
-extern const size_t pc_compat_2_6_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 49632b69d29..7573b880905 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] = {
 };
 const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
 
-GlobalProperty pc_compat_2_6[] = {
-    { TYPE_X86_CPU, "cpuid-0xb", "off" },
-    { "vmxnet3", "romfile", "" },
-    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
-    { "apic-common", "legacy-instance-id", "on", }
-};
-const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


