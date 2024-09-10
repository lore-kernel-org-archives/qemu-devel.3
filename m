Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40994EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9Bc-0001vP-SC; Tue, 10 Sep 2024 18:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BL-0007vK-JO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:59 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BH-0006yz-EL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso4609376a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006670; x=1726611470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYUGVuBQPVEKq8uP3q9x4VvG+Oea4tuw5RjsMn3QXjQ=;
 b=v0RKQf35dKljMjVgwHcwDblDbVBsgRDO5hUfvkC0New8xigHdfHt/LQxTgoiGVEY66
 zGx76ONqIMxQWxxyCc2y9Cj92yq4FiMedpEP6AxvQ+VFABpLqdnpW2osdMe00cuwjUfp
 EQKvFokRwsCKq2zZ9PvXLE0XWMYJssTO3vW4tBN7UV6IErFW4INUwg0rCNYT6q/Y7p22
 NMlVQjbrbl7u8r2oQe14w4pziRk+pY8emdX6KoBj7vTkwi4wlBHRZZcavzVNWo/yRYm7
 GNyMlsxHZFc848xchE1WUfh+g/QTQTtEsVsk44Yo6tCVU044kNsnpGaq4u3ooy3CJI93
 FmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006670; x=1726611470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYUGVuBQPVEKq8uP3q9x4VvG+Oea4tuw5RjsMn3QXjQ=;
 b=gbSicHeWssl3VqNEgIdwHEuz/copnFigLdydXsYYD19A8Ge+4y7CTgnaajl0qtMMLm
 oYeJQ3/lW/Jtc9VM/JSiuLaQf7ygHVm5dYokaQfmraufNQDJqFk9mPmSxasghjn0c8vP
 PYwe56v/WEvJnEEsxADfNQv/vid3zO3zRcKsppvwgKIH3lH1nhrKEmWWem2WjceSksL5
 0JdM8zPjMykWTg4+7T6FJzfjDKpkEvH5CrwAF6yBaMu91eiA5DKrO3a0TWqSgwQUXHfr
 QsSPXVhqMhmFlE8jc40mpjVx+WOeE7HORIDWX5zSjOiDhQzdiTAOW/ZMz2TxfYX4x890
 VHfA==
X-Gm-Message-State: AOJu0YwXoKgPQ+nLt1keikr3fO2F3gXH+T0wqYIg3xYEkvmgpwYSpOmE
 Gur92EYHogbcjbE5SBoqXLnqeauzyoi8QJNGQTiLgwgC6NVHQQmz5wzX7Fn1fzWOHlX96iZ60U+
 Vugss3K2y
X-Google-Smtp-Source: AGHT+IGvdYbUxOn3oVTMiIOAaos8t5NEoWDicsVQH4rvVkTo7ZcM156Q62Eu90CVjvFHEgcLmkFROw==
X-Received: by 2002:a05:6a21:3a44:b0:1cf:284f:778d with SMTP id
 adf61e73a8af0-1cf5e0ae114mr3221600637.16.1726006669948; 
 Tue, 10 Sep 2024 15:17:49 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:17:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 30/39] hw/pci-host: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:57 -0700
Message-Id: <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/pci-host/gt64120.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 33607dfbec4..58557416629 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -689,7 +689,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     /* Interrupts */
     case GT_INTRCAUSE:
@@ -933,7 +932,6 @@ static uint64_t gt64120_readl(void *opaque,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     case GT_PCI0_CMD:
     case GT_PCI0_TOR:
-- 
2.39.2


