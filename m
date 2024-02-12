Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934FC4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTR7-00086P-EY; Mon, 12 Feb 2024 05:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTR4-00084L-J3
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:21:14 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTR2-0007gQ-Ul
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:21:14 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso1928860b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733271; x=1708338071;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=o/RGKrF55gRTMNnIvFr/t26x8RIZN5W52oSBJt7DwrFS8qp5kpZZt394BfBYgybqcL
 +Q+QlHF69I+aq3Lu6qPnzQfs8/yLeYR9T0XH6iC4XoIDRzBNQz4HDq1uf6fY9f64mqtd
 fJ3X1AjI7CtOqYZ6Wd2rq9GjmrBJtMl7nsTtiqr3TV4dgdGixsb/DyBPPkfiwYstiWCU
 jJrB3sSv+hsSn4kKfzjrTFM1TfBkFf9KnP8ciTryVa8ugv9X77MjfZlF4bEQ/l28j9z+
 TWNpwcNQVfo+MyDlE7Kmkz1aVaGs1lZoYf3gyIUiGwK+Pco+NfbkjP1bMiPZPJedq09q
 Wd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733271; x=1708338071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=AN9d5dvfJz9tV19tq+0LcVsf5/r71pvCuDHqeibLYUCUZz2vweqt8fOaV1Ejs+3Ici
 wOyZwXYwk0gD6LmAIWvcx49Rt7bDZytFXXvaGMO6f6D7c5y6rlTFTGCHivgHlYZui+Dy
 AXcqAHrIVj9UqjHZfC/0A4dC5KMzAt291mXWutJHCYQV1mFjNEutmJaG7KGB0vinZt6U
 hpwV0ueZvYw9T0FdiEo3fWrD4HahjrfBlzN6UmutQMAFM5tzRD0tHEslsc/EupLCaOtx
 GlSuzDHyhAvXOC+IDlMPeBUpZcQVuQofQCEvhegJs+AKzhRl0izE9reTMl8/6Ri+YomV
 fvMg==
X-Gm-Message-State: AOJu0YyLMz5RKEBEiKqHhWdrmxeelbQsO9QHm58PfA1+x7SrXkw3wuKy
 Pm4f5u3tOmtEMiIXuNYVTIP8GdgJR6SR3qFGAR26FscblGjJmmX5ehrDIViGUxg=
X-Google-Smtp-Source: AGHT+IEJmTF3pwG6hLNQDAohKwvYfN2pbah7IQe++f9oZFNw6E0CQMn+hmoGF6NNGH0T2yWNIa1UlQ==
X-Received: by 2002:a05:6a00:1390:b0:6e0:5b63:e7fb with SMTP id
 t16-20020a056a00139000b006e05b63e7fbmr12352485pfg.0.1707733271337; 
 Mon, 12 Feb 2024 02:21:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUnNRdFopwcssGZ5aJE3HkS+2V7iYI+mDLVgWOrYcgh5sVLeF6HNbwOM3VyC/7KAPkV82H3qZRv0XaXul9PYpcP0FYhpxv0d/x8QVP3Ld35KIlDKaKCeP8LZ0Tkr7zid1H3IJo1cP8sJPnc/cdP1EYJes907I3fa66KY/mz/XOqYiYKWAkbh1Zp+eDUixpqRCzySj+wU25sMhtaPSCp2Y8Po+unUi0QAmtvjpHDpnFfGlN/ckTqm/Nj3FAaBs6/KFs865te2V9pK/5gcpJowNUETbzSpoTKBOp6D5aFFXstaOL2FKzi0ieOxXLDbLg449SCnKNQZ6iaMztadSr3BaXdR2W3U39Y3XQpxUudKAP+UznOGzTCHbO3zR3jIv2gFySwWccjcNwy2Fdh03DRPaYmCcpeOpRgF1G94CZyR2sywS2Y8ZIAtEx36JHhVes=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 j18-20020aa79292000000b006e0545768dasm5187099pfa.151.2024.02.12.02.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:21:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:35 +0900
Subject: [PATCH v3 7/7] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-reuse-v3-7-8017b689ce7f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 9ba34cf8f8ed..9d668b8d6c17 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -91,6 +91,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unrealize_vfs(dev, i);
             return false;
         }

-- 
2.43.0


