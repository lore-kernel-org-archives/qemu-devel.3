Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165DAC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 07:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rat2R-0001NT-4V; Fri, 16 Feb 2024 02:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rat2P-0001N3-1o
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 02:53:37 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rat2M-0006Zt-B8
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 02:53:36 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51296b58239so318698e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708070011; x=1708674811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a6jtcrefzMd7LNO41mdRMT1bmmA3xSa8hGdCnAaXxYI=;
 b=k8U7gqQyTkPRs5m59x+K4ELSXzYAijEtGAALp2SOYpKwH6O1Ypzh/EKETCCu+u6w0m
 3QyloVkDQv4WIS46NqN26FRjt5zO5tE2gx7ziQHeEyMYH+PLAOFueKixS3CiiHWdF3QL
 Bnv1yFjZ0pOB4V8jE+qco+G7OIPiYmJ83QMJa7O7zn34VmVCs2G8lDWWnHTIXib+Yw1Q
 dU8GTx7G7278pRJcBmCmxiQO5NwveST7xb/GEpbiIsVdEOKC/lBLc0AUYiforpoFX6jc
 bX2nxodciAeg9HuwG4jSy9dc+U6ndRjBFi6YpFT1xHCAMbswCdosZfMhHPogRzvgErw7
 hLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708070011; x=1708674811;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a6jtcrefzMd7LNO41mdRMT1bmmA3xSa8hGdCnAaXxYI=;
 b=HsRbIBycTSf/J0SrpP3C0p/rVUM8VSSq8g6HZpqSVBbpgxeWbxwhPtfJCpZjTDfq2h
 INIBX9J3Qcw+iHfcKFh9OxWflZHh8iSh0CGy5dr+uhI33YYMVEZ9JthGeNlbSESHxzjx
 xZKw/qfS5r5qoFbKh1XJgVP1SR2/pQHOstvHtTU7AKgWfLML4IgYhUpaDID2kBKwlCOj
 vOxV6geiZ7QOd3JRGniytl6kgbifi6VlHrR6olNjD8Go5Vgo4QX58tm6urxNb3YhGTNK
 30ssfPVnkg5E2qpRS7tls8nzKRLb/k1EwSgulvqyUzC9lFvx6U+YQGm4/NLd/FiUDDb2
 FSrQ==
X-Gm-Message-State: AOJu0YzsGJsUfzgTiG2xRoxiUdTcNopl/ZWQFiGD/DAEN11ARHSM/gne
 PlroasSlPZX0AdqG4vUUgKhBj9F4XSRBVXc29WFAbvt3hDNhznuE3WMQaV+GTuDbvWJXbIOtf0j
 /9cg=
X-Google-Smtp-Source: AGHT+IH/8iMR9MUM9ZZpbNF37H2SwydUMAnWcXzNaj/pdAa8o58mgtQ1prOqX+aH4JZ69LN+tJufMw==
X-Received: by 2002:a19:9143:0:b0:511:8763:bb63 with SMTP id
 y3-20020a199143000000b005118763bb63mr2597213lfj.41.1708070011176; 
 Thu, 15 Feb 2024 23:53:31 -0800 (PST)
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 vg11-20020a170907d30b00b00a3d6ff5f087sm1294597ejc.55.2024.02.15.23.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 23:53:30 -0800 (PST)
Date: Fri, 16 Feb 2024 09:52:32 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Lukas Stockner <lstockner@genesiscloud.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Lukas Stockner <lstockner@genesiscloud.com>
Subject: Re: [PATCH] pcie: Support PCIe Gen5/Gen6 link speeds
User-Agent: meli 0.8.5-rc.3
References: <20240215012326.3272366-1-lstockner@genesiscloud.com>
In-Reply-To: <20240215012326.3272366-1-lstockner@genesiscloud.com>
Message-ID: <8xv91.32qjtsyqi8qb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 03:23, Lukas Stockner <lstockner@genesiscloud.com> wrote:
>This patch extends the PCIe link speed option so that slots can be
>configured as supporting 32GT/s (Gen5) or 64GT/s (Gen5) speeds.
>This is as simple as setting the appropriate bit in LnkCap2 and
>the appropriate value in LnkCap and LnkCtl2.
>
>Signed-off-by: Lukas Stockner <lstockner@genesiscloud.com>
>---
> hw/core/qdev-properties-system.c | 16 ++++++++++++++--
> hw/pci/pcie.c                    |  8 ++++++++
> include/hw/pci/pcie_regs.h       |  2 ++
> qapi/common.json                 |  6 +++++-
> 4 files changed, 29 insertions(+), 3 deletions(-)
>
>diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>index 1a396521d5..106a31c233 100644
>--- a/hw/core/qdev-properties-system.c
>+++ b/hw/core/qdev-properties-system.c
>@@ -941,7 +941,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
>     .set_default_value = qdev_propinfo_set_default_value_enum,
> };
> 
>-/* --- PCIELinkSpeed 2_5/5/8/16 -- */
>+/* --- PCIELinkSpeed 2_5/5/8/16/32/64 -- */
> 
> static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>@@ -963,6 +963,12 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>     case QEMU_PCI_EXP_LNK_16GT:
>         speed = PCIE_LINK_SPEED_16;
>         break;
>+    case QEMU_PCI_EXP_LNK_32GT:
>+        speed = PCIE_LINK_SPEED_32;
>+        break;
>+    case QEMU_PCI_EXP_LNK_64GT:
>+        speed = PCIE_LINK_SPEED_64;
>+        break;
>     default:
>         /* Unreachable */
>         abort();
>@@ -996,6 +1002,12 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>     case PCIE_LINK_SPEED_16:
>         *p = QEMU_PCI_EXP_LNK_16GT;
>         break;
>+    case PCIE_LINK_SPEED_32:
>+        *p = QEMU_PCI_EXP_LNK_32GT;
>+        break;
>+    case PCIE_LINK_SPEED_64:
>+        *p = QEMU_PCI_EXP_LNK_64GT;
>+        break;
>     default:
>         /* Unreachable */
>         abort();
>@@ -1004,7 +1016,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
> 
> const PropertyInfo qdev_prop_pcie_link_speed = {
>     .name = "PCIELinkSpeed",
>-    .description = "2_5/5/8/16",
>+    .description = "2_5/5/8/16/32/64",
>     .enum_table = &PCIELinkSpeed_lookup,
>     .get = get_prop_pcielinkspeed,
>     .set = set_prop_pcielinkspeed,
>diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>index 6db0cf69cd..0b4817e144 100644
>--- a/hw/pci/pcie.c
>+++ b/hw/pci/pcie.c
>@@ -153,6 +153,14 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
>                                        PCI_EXP_LNKCAP2_SLS_16_0GB);
>         }
>+        if (s->speed > QEMU_PCI_EXP_LNK_16GT) {
>+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
>+                                       PCI_EXP_LNKCAP2_SLS_32_0GB);
>+        }
>+        if (s->speed > QEMU_PCI_EXP_LNK_32GT) {
>+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
>+                                       PCI_EXP_LNKCAP2_SLS_64_0GB);
>+        }
>     }
> }
> 
>diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
>index 4972106c42..9d3b6868dc 100644
>--- a/include/hw/pci/pcie_regs.h
>+++ b/include/hw/pci/pcie_regs.h
>@@ -39,6 +39,8 @@ typedef enum PCIExpLinkSpeed {
>     QEMU_PCI_EXP_LNK_5GT,
>     QEMU_PCI_EXP_LNK_8GT,
>     QEMU_PCI_EXP_LNK_16GT,
>+    QEMU_PCI_EXP_LNK_32GT,
>+    QEMU_PCI_EXP_LNK_64GT,
> } PCIExpLinkSpeed;
> 
> #define QEMU_PCI_EXP_LNKCAP_MLS(speed)  (speed)
>diff --git a/qapi/common.json b/qapi/common.json
>index f1bb841951..867a9ad9b0 100644
>--- a/qapi/common.json
>+++ b/qapi/common.json
>@@ -107,10 +107,14 @@
> #
> # @16: 16.0GT/s
> #
>+# @32: 32.0GT/s
>+#
>+# @64: 64.0GT/s
>+#
> # Since: 4.0
> ##
> { 'enum': 'PCIELinkSpeed',
>-  'data': [ '2_5', '5', '8', '16' ] }
>+  'data': [ '2_5', '5', '8', '16', '32', '64' ] }
> 
> ##
> # @PCIELinkWidth:
>-- 
>2.43.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

