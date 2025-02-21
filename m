Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B5EC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4A-0005cW-Ra; Fri, 21 Feb 2025 07:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS48-0005WQ-Hp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS46-00075r-SX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnNXa72bifXcpK8QJLo0EWswUxugR/C5FGlEBsch7ws=;
 b=ELpyVVa88uPrINZnSAUOUOZJyCaNTP/oKTTI4ZlY0sfr6OwO0QrYq40KG3/vDjRem3pcEW
 rN7wyYbJwNrmGOh/xTcugYDrPuTVoCZcbd6H/zG43WNHlgZZHZxuPzEoRhmxHsk5ydKu59
 O5oap2k0Acvap6IKeyQNiR1PwyGMmJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-t36RtbtlM1qoFTIKA6HkDA-1; Fri, 21 Feb 2025 07:23:33 -0500
X-MC-Unique: t36RtbtlM1qoFTIKA6HkDA-1
X-Mimecast-MFC-AGG-ID: t36RtbtlM1qoFTIKA6HkDA_1740140612
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so14023785e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140611; x=1740745411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnNXa72bifXcpK8QJLo0EWswUxugR/C5FGlEBsch7ws=;
 b=dq4/xCF+fT6xBhKz5uGaPR7sdozwM4EPfdRqCMuFMQ42GbnSfkdRcx3YrNWs3jRiY6
 I77ZCffq7MTZ0c/pHNcGEy6m9GbEpRdW13DqsqTd43HSXIl0NrTtiEZrRRPxCc96/F/X
 q8qsYgzI8hbGet6g+xhJPJTSEjRFrI2XJxhcV3jC5MK75tWRkdLQVSqDln9sVb926wHw
 +Ytm7R4ZVrHlhUCem10AfzqvBS5CsoRW3qiQo9+S+F19H3STY5zK9bOL6fWbzZh0i9+s
 GMnCRLWo/NFpqV89zzGbo4IkEi1wZUe+YUk09Wtchhn4Awh+nUEv5c1tsfZFbOg4K4xt
 a4SQ==
X-Gm-Message-State: AOJu0YwKB/OqYj2t+buMcAy9NMboM7LcROUYZ7xFhTWxrMAjY4Yex4Ib
 3x3CXjIAAGw0Vj2oz7LdCqFPQaMivDGEtq+3i+ziopxzYrvZvds8afy3Ay2G6RuGrP6u/J7vgFS
 qKThL2a6wJiWmWJEEHXAL7CoSxCLHt6izMX7SehOgDnmFNi1Of/tWwjY2+m6DgTD1EFDNg707xx
 W//+knnvpEvrqSZxnYuly9AZmkXD6gJg==
X-Gm-Gg: ASbGncuXlpIhbumQ4zr+/giR+DN4cUpPOHXTMzwHbEeakaZWDDXyovIVWJyzagunTKp
 Ui1ENuqJTvDK3nzvdO7mfwCZTf6mAKAMaIpboEI+eaD3p7LLabS4wpkpfX3Rur8Q5dEszwluGFn
 l/bBIPMsLTmj5lXgm/ecrcPolKxnPuHTURSduDkBLrRvm/mt3Jp9rqhF0ulatBE64QDNjfJxjQj
 P5F1WunF8iLMUsuw2eRIafAXAID7MWNAKL4qFF6MsZec+mh73U6h+0zPQIXpdlf5NP5XdCySoub
 KaoM1Q==
X-Received: by 2002:a05:600c:548b:b0:439:608b:c4ad with SMTP id
 5b1f17b1804b1-439ae1d86f5mr25351455e9.3.1740140611442; 
 Fri, 21 Feb 2025 04:23:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDbq97x6aFlTWlSIbhg9SmwjTBWHz30pZ4y0G1zP18OVqZf0kp6NRu67BnsWJsLe8gKVrJcQ==
X-Received: by 2002:a05:600c:548b:b0:439:608b:c4ad with SMTP id
 5b1f17b1804b1-439ae1d86f5mr25351205e9.3.1740140611091; 
 Fri, 21 Feb 2025 04:23:31 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5923sm23451118f8f.74.2025.02.21.04.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:30 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/41] hw/pci: Assert a bar is not registered multiple times
Message-ID: <f6fc01c7866639649b9af58ad50a7367b2d18eae.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Nothing should be doing this, but it doesn't get caught by
pci_register_bar(). Add an assertion to prevent misuse.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20250117172842.406338-3-npiggin@gmail.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 69a1b8c298..1d42847ef0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1398,6 +1398,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
+    assert(!r->size);
     r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
-- 
MST


