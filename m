Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04603C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZofW-0003J6-F5; Thu, 10 Jul 2025 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZofR-0003H3-Nc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:38:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZofM-0004uz-QI
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:38:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so713256f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752143890; x=1752748690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=87sus+y4ptOCVCmcdo2NCNREZzl6cqDmG/bsbkl138I=;
 b=fZHb9D9y03BTzIRMIec8DvEUH/vjZSTGGo/qBkCrwUpLD5EWX6tHoe3MTMVkriBltS
 3jOFTmRplJe4G43QkS2kTXDT2PXuFlGjXAtR/gmwCOnLJ8IIjgvuTbu7Ikeev9qPz7+p
 6e/aU5iKeK13wR6g7uF88tiV/3e3Qw+XfaE/4/1wzbUXoxJ1zma5sx7DxKsRZDi8Ha/B
 FVssBnGCbb6AFN+rzKSe/r+62TfwXxQZqqgPcjC3VFChChEx+Qo2nBQzusEJ0aXSku9J
 raioheFz3iIg6+Re/expeXheQu+Pgl3LiIcKWIGowDmXLwkDPnBVH2SzvR3ZwgE6ONn0
 GyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752143890; x=1752748690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=87sus+y4ptOCVCmcdo2NCNREZzl6cqDmG/bsbkl138I=;
 b=fvk900NKqEY1f2VPTKTLhsHIHxcZvTVZbv7BkCgx+e6KNewxw0DOJ1lY6DEwppQ7aB
 xXBI8XFq+nSLwkl8qMtotpbdtZdoa/HKcQ70mgw+U6hzUKcw9F5P+umEnqxHAtPNV7dU
 pL6brANu//uu74ivwj4v0DuHFBXUoXWYbruwbeNhE32HrPr0Xagv3W2SSmpylKCHHrXt
 teR+CvNxjji5jvQXioyI8q8qST/onUXOCPnQoS/Kw+IgGju57huUB4t50HyQp+l/raTB
 tzXMhnrTbY/uVLs/mIBniYGMYuJOatjJURe8Ma/U0p5QQiOK6mrkIKMdSK+Zhf3lTMBJ
 RA9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQPZK0XDoBDc5uJg0m8CFuPPWG9po8Gcoy5ZaWztUK42AxOjIMVvQmhZbyd/QPst9vvWCsNiQc5aF@nongnu.org
X-Gm-Message-State: AOJu0YwBEf/jmT9HJpGNFCHrZzXJYIKl5uE3pElDTySGAYar6WXdtzYO
 zp5Zxr8U8AtJE2p5drRmUPdVbKrP6/IkOCZ+7lCfiq+tlHlJOUZPjoc6eMj8tbLmBz4=
X-Gm-Gg: ASbGncvLsmOH37jO6jWJYX2+YCDqxpdD9PmbELjurQRE0Q2rn/m2bYE//s3U3Mj4tN0
 QTIasBq4omDh27ClK5d/rvFg4ZW2L9do8iuwrQwxcHHwsc4N7+p8PtLsUjH02Cw/0EkLCcUOV9H
 yBaBbH6iSySULus3Onl146ITp70d+W1t7tmlr4RmWFPE2UG0oxITqGnib3aMihDsjFMbhcnXz5A
 uw+QabOunFFb5QyWC7dkO0iX9PZIadaAj9YyhW5PqANI1GMOiqrmheCUXVRdb6i8Zwkq1HLSdAH
 S6kydFSFYhwCNLzNgjxCbj1IF9KA3YXYAI9kIRYYlBUD+1N+/gxmzqxdQxhY/n7CPMHlqvoguAy
 nSEl8JHVV02etjdFFlf29KfsBa+HgiLaODkOhVHPCwm4=
X-Google-Smtp-Source: AGHT+IF7FBDpYX+B0UEKYmIkj9fIO8zUczhbetwDqmJgA80WZidhJCcp6bH++PFeZ8VM2dE8EZfdCg==
X-Received: by 2002:a05:6000:643:b0:3a4:f72a:b18a with SMTP id
 ffacd0b85a97d-3b5e8680562mr1999969f8f.26.1752143890387; 
 Thu, 10 Jul 2025 03:38:10 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2703csm1501773f8f.97.2025.07.10.03.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:38:09 -0700 (PDT)
Message-ID: <3ebf1793-6d55-4e07-a2b6-cb738d8634fb@linaro.org>
Date: Thu, 10 Jul 2025 12:38:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-3-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141018.674268-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/7/25 16:09, Mark Cave-Ayland wrote:
> This is to prepare for splitting the isapc machine into its own separate file.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 260 insertions(+), 1 deletion(-)

Further possible cleanup:

-- >8 --
     hw/i386/pc_piix: Inline pc_xen_hvm_init_pci()

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ede7b68946b..4cec4f44764 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -362,14 +362,6 @@ static void pc_set_south_bridge(Object *obj, int 
value, Error **errp)
  }

  #ifdef CONFIG_XEN
-static void pc_xen_hvm_init_pci(MachineState *machine)
-{
-    const char *pci_type = xen_igd_gfx_pt_enabled() ?
-                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : 
TYPE_I440FX_PCI_DEVICE;
-
-    pc_init1(machine, pci_type);
-}
-
  static void pc_xen_hvm_init(MachineState *machine)
  {
      PCMachineState *pcms = PC_MACHINE(machine);
@@ -379,7 +371,9 @@ static void pc_xen_hvm_init(MachineState *machine)
          exit(1);
      }

-    pc_xen_hvm_init_pci(machine);
+    pc_init1(machine, xen_igd_gfx_pt_enabled()
+                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
+                      : TYPE_I440FX_PCI_DEVICE);
      xen_igd_reserve_slot(pcms->pcibus);
      pci_create_simple(pcms->pcibus, -1, "xen-platform");
  }

---


