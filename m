Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DA5C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQx-0007yq-Lx; Mon, 12 Feb 2024 05:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQt-0007wH-Jq
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:21:05 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQs-0007fG-72
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:21:03 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so1968668a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733261; x=1708338061;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=ytKY3bGA8+4KH8VC79vSDZItRQcxtvVWlKe4TyyVsu7GSPsP4HDlNmHF0xkEwk9cbm
 aV6cCRigUozvWc9OJoDU2kQrsze7NQSmeHw7ochXgezQKPLieFKz/E5wBCnqFr1iOEuM
 5neyAePfz5g14OGJwmsUEN8yh/LHPft5nFF/Z+Z3Vvr3C1HY5whXU+IuDpo7WtGzt4Ta
 4vHDGVJNjKlBOmvjybeLd4GypHiGuhBdSNYlUA4AZqKCoy24rRd5v14qgakHRY+OM8ag
 u4LaF1p79i+JVnO/lOcOiPuqc/lzVv737mO9v8f650SPskabxpXrmN/jdOGL6N6Em8/L
 5ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733261; x=1708338061;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=r6Y1kPZbt1Q+vIFJehs/ksu6zL49HxJezG9LO6CaGb5FuDPP0lTuNshvNV03VcOU4z
 uQOW120MInwp8fuDYC5izXWxQHCvmgmAHGW3RqgNcHZViImYg6W9de7I9abMPwnd+uu+
 2Uc2PwphCFIOmEvG8cXblmWWpnC3ZKRNSxSU1nQWIdJK2C6+x2vMLCdVKigSJTRb/JMm
 /1RmrFFvW4rnHuVujq6eVxMOUB2uQavNAWQPDTz/c3XdCfS9EXyT9EgfXQstJ3xCqFnM
 nGpwdBkhe4DVedxXEmurypLK+6l7sY+pfJfWp1keeOOWWV0SVkS4pEConTjCsnKTzapW
 ujjw==
X-Gm-Message-State: AOJu0YwhbR3RL0OCP/ZNOenB54H5tmk7EJCksp9aI+WEsQgeAl3OACJH
 9fe2M+w/8gnYQWhbV3w6D7lV90hEROozHEByzezRkSGHD7pcwbwP8SrLid3Fs+s=
X-Google-Smtp-Source: AGHT+IFMb0XoKUmG1qDkYaHa5qneTvoHUdwgzpilQ2vYCBG5bFJJnF8uxcTX2voHqLZYo1c4N9U/vQ==
X-Received: by 2002:a05:6a20:c88d:b0:19c:93c2:7ef3 with SMTP id
 hb13-20020a056a20c88d00b0019c93c27ef3mr4421126pzb.46.1707733261130; 
 Mon, 12 Feb 2024 02:21:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVQMd7kw/OKM/X6YWb21/I1F5Pf6oaycPxqkou3TVUUygdI+kOpgc2ErnyikEIRbZ1W6ozpoL8yBKPcPYW2qBk805upHkt2T7qP3z+3fbnMeOPPJ3ZDQIqG8ieQXv/zz3EHpe5PC+x/sUyjzht/l49PNR8GYuud8RAum+koj5a4AztVJPURkDgASgbhaL64uk35dQtIlM0toMoG8t2JffmUcW5HkvOV0iahHBepn+KpS076oFe7/yqyjeSOTkEHnsVtMreUk64GvG02rGAaigVuqO5dhXK9Wj4qA0lpCshblbAMgJyM6KNT2qjyZsBUUwDhpG0JG/u7+RbhdRC7DYLiu5lvrdomnqd15wPltVkhYR3Vs2TEPNVFGLPxcsZJXSeI3LloplT7Td3bktJ8NKjIMCHykXXTxRUL2DJqFmqQkf+crP7sAvwWhIIveuc=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 d24-20020a17090ad99800b002965eb051e7sm127054pjv.53.2024.02.12.02.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:21:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:33 +0900
Subject: [PATCH v3 5/7] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-reuse-v3-5-8017b689ce7f@daynix.com>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
In-Reply-To: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d801..da209b7f47fd 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
 

-- 
2.43.0


