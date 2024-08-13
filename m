Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56408C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkoG-0005vN-CT; Tue, 13 Aug 2024 02:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoB-0005qj-Ao
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:03 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdko9-0003Ic-Oj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:03 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093705c708so5010576a34.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529699; x=1724134499;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=yjrL0zD0mzLmWFiejHwyp/81hOKlKwW9e9uiwSeZ158rrEyR7V+XzgRhKmfvBF6Rlc
 4Xk51KhFBp4RPHCX9NNu1/mdLXx+qEDrNefvvVdXljuaUIJxzUVZQBbBLG1kIxOGFP2G
 t5ZTsblFYtTzMMcrCpS1rO61nQZP5LeO7YYkKR66jezXSc/Q5hU4t7pLkRXrQR0qv8vz
 SlIfSyaauWz/cay2DYEfK4g9cgqD3CyWUocDhLw1OX9cKtqF7eTA8NLo8Qs0sBlqf+co
 bWVyxFuVvT+SzCrczYMxLJ564UfeDCHR4vSZcFOj4wg+to1LL+Watpenfyrzy/WoNty3
 Wa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529699; x=1724134499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=XMsViIPZ1YBoopjZ6kpTS5O/plNE29Vb8N+WYM0Ixzi57XnNIbRiAkuuqryYZAvSFu
 /iDSZ88jqXHrRnERGHmWSFyxbNkUd9vpCo7yNnyGXzlOwjtaSwQKIMQfIngddkyVbL2V
 RLbKoqYu7foccasM8uhuEL3FbX/qImV1OW5CidF51hxQvAY6CsVikQUHKY9nGEVOaqb4
 +41TaIqTfIfQBfzn0s+SyyHvdbQotvapSvWKUFkM+MWCQ5YaX2PI0H/3tl8/QkVbXwAT
 DtBoZUYj7LW65clb0Z91Y6fB2NnPklLI1QN9y1YNb8U9cPdlk4qv3m55Mirrqg63yRZA
 G+SA==
X-Gm-Message-State: AOJu0YyzOdkmwMnyqnANJ4pazXACZ/VZ/zHNz5F82CqtOL86dBIWEVjG
 ZywxZJyPg6/dP2x76fGhjxe9iea7+0sSmlsj2sh/Ngp4V9+3F45WleY4837gZYM=
X-Google-Smtp-Source: AGHT+IFWNoShctOMKaHWZFBnGz3sCacmY9Wa2W+OkJeM1AkLIV3Fsj1Eg9ZCyvYs4gWoubRKR1zByg==
X-Received: by 2002:a05:6830:610b:b0:704:3fef:f045 with SMTP id
 46e09a7af769-70c9394f4e5mr3263451a34.29.1723529699268; 
 Mon, 12 Aug 2024 23:14:59 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-710e58a921fsm4973357b3a.67.2024.08.12.23.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:14:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:45 +0900
Subject: [PATCH for-9.2 v14 02/11] hw/ppc/spapr_pci: Do not create DT for
 disabled PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-2-4c15bc6ee0e6@daynix.com>
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
In-Reply-To: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.46.0


