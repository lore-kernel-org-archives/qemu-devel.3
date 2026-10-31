Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9999606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHVWUTrQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC8r-0002XV-5A; Sat, 31 Oct 2026 12:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8m-0002Ue-OF
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:14 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8k-0007l9-8g
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:11 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1438d9363fbso1304706c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464869; x=1794069669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9DnP+gTwSEOX7zrI2haaQoi28yWED+v2p12ws9Ei1k=;
 b=AHVWUTrQHl/xgZBeEF4sENHZpdrAzM0Lmm30Pta1hw49jarWUOnAl30/je1IPu+u/W
 NxtfwhN99RJBgjvXxLSv1dmTZ7GZSZAJBdxQkrjseEDlJ0ADGnBSYONn0FXoqsuV0Vnf
 vk6IvKVr6ePaxzVdYrHDR1zXT3q8Q1nxLGRgYf/gUrn73f92/yaB1pQUBtfH3vxIb34o
 4VT1MrVTpSovBUOE0qPA2B/fXQgY6OsjSTTXogY8Ckex1WBTJV8bqmjeJE1vq9l43jDk
 6vs8hu9C9/7O3En7eA0Z+6f1/Phw+JcIkqjAcekG8WwSJtrqJOggd04J0SMN/ATQMQL9
 Jdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464869; x=1794069669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+9DnP+gTwSEOX7zrI2haaQoi28yWED+v2p12ws9Ei1k=;
 b=WeRh8zj3GY7ej6zHB/+HL6bAHdxUD48qRVufuhooem5oAK0U46C1lrCN8PEi0Ku0LH
 xnkCBQKm/f7/U14M9hjKosDPJEPfTO48O21NIiPvRYxwrkP13jGBSTjMuU7pgTxzqEX3
 2lcwab4wzZJkJK8JBtHLg5UWYobwmftSWB6otB85I2mdUs42+S/BQ5v0s0+yuTxVhT0l
 tnepZSmg8xmUfl5uWDROnpwmxzxsAdC+QeLZ883yYYYGHE/1DDCxDv3BtlkfR4Wb5nHe
 w6mCWi+9rLvupgyWNQNT3cv25xTa+50dtUpw2C6ekpBfogHzMwdaVkU39c+1C3TXCSOJ
 5uGw==
X-Gm-Message-State: AFq9FYKCwq+AY8BjY8BnVUYZKaNrpedKpdp68hM0c73+fXDJkHUrnI5C
 7PQ8R1bAg1qAQ6Jlxl5Cky1u6HNCp3RNjByo5vng4gIHnH6kEhwSNsgG4SxAPz6B
X-Gm-Gg: AYBFou1Z056fwQruHA6Wdb6+Tz9nXcntknCdBuFdUjXHdRapEZWbZNHGBdBwwGh1r8h
 +8jdsAD1pO3hg1iLC7457d4Vf4DYusXWc+x+rsbEDzfdvr7+ZDl2H31l3HUc0V1oDor/UpZsp55
 lCieA62QGkO8g1lKuXFPB9DTd3KMN7NyO+Vsa7abVYx5UzAxrKP2zHZbNQpZjs9Vbv9lVT9dOF8
 RsZwoBx2fqkgpHaEs+Lrr1mvXkuOoaQa6f7NurO9D0BktgvN5nqjVvyY6nxi5FfNemJpd1q3+fy
 Uaeyu7hjIv6/C8QEyydly85eXIpjSKXyInFkg8wGN+3kxhgavS6InhiEndaFw8keAblczXm7NNL
 Q16S7xVzCW6K+evpZhViWR30wFL3RQ7MZM1hKSocve3rg0/+5qmAs6OCvYXhrB6D3LirfaiuKyo
 NXdb075AZaX6n/69l1Mgm2AsLbbFsA7+JrBR7f9j5Su9LaorYjNNFT8YhdmA9BjKIF8d3hRZ8hT
 BL6xlTW/++nPPS+fmV1dpJLLdqPGGHPue68USxr69+pVeKTZbZkGmE94xtCtlNEDRLuP+vKSk/i
 VcyIp1EBlmbiAPuXg8ao8QscwXlGVXzc19dmz2xEmnx4tQZS
X-Received: by 2002:a05:7022:619b:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-1a9497b9d52mr17080343c88.15.1793464868541; 
 Sat, 31 Oct 2026 09:41:08 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 08/12] hw/virtio/virtio-pci: pass is_available through
 VirtioPCIDeviceTypeInfo
Date: Sun,  1 Nov 2026 00:40:03 +0800
Message-ID: <20261031164009.2048-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_pci_types_register() builds the base, generic, transitional
and non-transitional TypeInfos for one virtio-pci device. Copy an
is_available callback onto each of them so a device can register
target-specific variants of the same names.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-pci.c         | 4 ++++
 include/hw/virtio/virtio-pci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c73f1f546cb..1ce39e92e9d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2522,11 +2522,13 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .class_size    = t->class_size,
         .abstract      = true,
         .interfaces    = t->interfaces,
+        .is_available  = t->is_available,
     };
     TypeInfo generic_type_info = {
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
+        .is_available = t->is_available,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2562,6 +2564,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
+            .is_available  = t->is_available,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2576,6 +2579,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
+            .is_available  = t->is_available,
             .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ee50fb0d551..6c3561d319a 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -236,6 +236,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, const void *data);
+    bool (*is_available)(void);
     const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
-- 
2.55.0.windows.3


