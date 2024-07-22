Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DF7C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmT-0008Ls-Rt; Sun, 21 Jul 2024 20:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglf-0003aj-53
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglc-0005zF-GK
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKWGQeqJTV62O0PjhVO4qR0DAdvYkDIxQ36H6bU2Erc=;
 b=hzlq5miZHmmtePkFYx6s5JdD9VcyshdLwZpdzxkxJMOfztrxYeSNcwlo+X8TLsFWt2u+jI
 sIrghdIvXuV2/0Q6sMeEPTEnp6CUn+0GP/nCtAMmYUswVX66+sdpCFIYHHXckVLotH7q3I
 r2PSOqYNPntM9VpYF+nFhaZGpUqRQgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-FUkQ8cBaOGiXJ0jY13f8fg-1; Sun, 21 Jul 2024 20:19:02 -0400
X-MC-Unique: FUkQ8cBaOGiXJ0jY13f8fg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687eca5980so1730166f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607540; x=1722212340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKWGQeqJTV62O0PjhVO4qR0DAdvYkDIxQ36H6bU2Erc=;
 b=lMjG2gmzoX/vjezznCduLeF/lhSKZJzMoKilYOFmKkaoZumsUwywAFUzWps9LKz28k
 2fXGzG5JM1mqpB/yzUk7przOUH+3qFYSam6pBuzovMjC3vBs/nGsptQNBh9Jw8T0vOjA
 +PllrQUCm3CZxiFbqmLjTXFhz/4qBgVv6xIyyI9bjX5AN62TZ4Dz6W4ELC8VRXKPVm6N
 dmyJoa6MYirGMmT6LNfLyKpFEK3GlbaRJJhQSS8l7UA3AfMmhBok355ijcwVFEB9LeQc
 T6xJpjbgR3ZMPwSUrlpU8RzHsrWvnfl98XHa3NKFgDrKbn5q3tfMCE6I5yhxLafGHn/E
 f0QQ==
X-Gm-Message-State: AOJu0YzCNZsQ9yJCT6+ifJSkl36BKR4zG5Y1AwDxb+5OR0PvZHVtBnwF
 TDI+rCHaUBwQQWHVFP51tXA+5MrUduWDVD2QoPYluhYH9fB1W0TpBhQe0I+0ZmC2U+LzQqtkSrx
 ppyN5/cH3zga8ISFfl8NFAo4bwOyRzcx44h3PziHjekyuuwc6sinSwsxnhnrB6+Pxn9ouUWT3Rb
 2x3Xe0RZReULg6vC7Ta19C3f8UzVD/KQ==
X-Received: by 2002:a5d:4b0a:0:b0:35f:1cc9:1d1d with SMTP id
 ffacd0b85a97d-369bae89634mr2784119f8f.38.1721607540591; 
 Sun, 21 Jul 2024 17:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCRZ4W+Hm++PaECUygA8QJPpMhESbb0eP8SqZNfF7e+5rzoq/6O92JYWKj02ORghTFvWzl8Q==
X-Received: by 2002:a5d:4b0a:0:b0:35f:1cc9:1d1d with SMTP id
 ffacd0b85a97d-369bae89634mr2784100f8f.38.1721607540027; 
 Sun, 21 Jul 2024 17:19:00 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ceda0sm7008237f8f.87.2024.07.21.17.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:59 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Chris Browy <cbrowy@avery-design.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 60/63] hw/pci: Add all Data Object Types defined in PCIe r6.0
Message-ID: <acc0b88d341da848fc9e45002dab4507f75e8c4f.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair23@gmail.com>

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Message-Id: <20240703092027.644758-2-alistair.francis@wdc.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
MST


