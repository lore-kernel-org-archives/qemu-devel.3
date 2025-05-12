Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ADAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTn-0006M8-6u; Mon, 12 May 2025 15:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTb-0005e9-AL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTZ-0007Xy-JV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h/gsHrUKk47zq1WT//raH3haROpL8GFhxMEDhMKQnc=;
 b=EJm7EgU86LlTf62dpgw7k1SU9gawJKNQv4s8dlQ4bgWfAOwJkhgc2SDMnRgA6GDlTRQr7C
 FRcC8kHTU3TJHD6s3hE6SSm1rwkmwe3QjIn/zFSVRoIq3YJAJJZ6bRpIyIbyVkHEKzjgEa
 KaFSPlI3N8XyR8PUt64H2fPejaW8d24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-tC2pHSomM9GuWNSrouWwkg-1; Mon, 12 May 2025 15:06:06 -0400
X-MC-Unique: tC2pHSomM9GuWNSrouWwkg-1
X-Mimecast-MFC-AGG-ID: tC2pHSomM9GuWNSrouWwkg_1747076765
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0ba24d233so1523963f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076764; x=1747681564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0h/gsHrUKk47zq1WT//raH3haROpL8GFhxMEDhMKQnc=;
 b=FJOiT8sM9A7lY8TIQj6Uonep6jrwYLH1YhTnGfXAbUat5eFR/OQuMP8ymlXXDZThCj
 ErocfhQ01Ksw6l4+yRy8Y5et3xCX7VdreXRcvzvMBMUs/f7WXUO4Vyj+UgdL3NdJbE0o
 KMzTwdSFgFa4vpm+TbzYMsLDCrmdr47UQOW3EqETS1tkvwiJty4U+eMKVYCEvck2htLh
 UqF4Ma0+tCG3UlmkYcalpaP4oAPgxNhEH67b4AThJnH7gS92yRDqimwte3YnPBXox960
 5hemiRJAifYjLj0qvWpK0+nB5EHIlINj2X2FOw51wfhS9KjEsqAG8Co3SgUG+04pWE2t
 CLWg==
X-Gm-Message-State: AOJu0YxFOkaa5gccqHJc0ZCg4mX5Ev9TxH4+Dua2dV+xIezj1jj792jS
 NzZEO8evEgYihc/hk5P/dvtdHWmLuj18yTm+TNPqdV1mDZqYlZMm+1oOIXLPpA2NvwbANyKyv+e
 6Zf/J/KmstBbqj9FCySD94/LP/BUmBR9rRqDxtLnpmXAcBvLOFBMKgSc6CRcibVDZ0424l4jTEk
 gYJiJpUFQWQON0jYG0L3IiNVdmTwmY1+j6L3pK
X-Gm-Gg: ASbGncv4MsEPK+3LfgehSdB8ut4LyU/+5MT5u4AtE4YWN/Zxk2zirRi0x9XdHCNyd9h
 e72FOFqeg5JrCfh3duLW+aVCrN7WpLTK71zuHfEzL4dfdX1b+YkFU8IUPrkyrTjL+hxQ3obVjie
 Z0UIMIFSUXV7ARPTV0MynwTFkCgHsNr7p/ZKmYWD3PljNpiXflF6iWOb8EiBd/gRo0He79/c/YW
 oQornH2/Qy/W/r3z1bmR/l1QlfvXCgdxZR2HRjo6jflOf+NToA+7kcp4RMkPw4R9I7FCv53RRmM
 s8L2DYaQfjWh4k8=
X-Received: by 2002:a05:6000:18a9:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-3a1f64277dcmr12428765f8f.9.1747076764358; 
 Mon, 12 May 2025 12:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFulrY6SKCEYcsb8AWWqOODyA/rMFRtgL66RIy569xK602uFf2vVKZLFfmeTEguGPCLnU/qnA==
X-Received: by 2002:a05:6000:18a9:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-3a1f64277dcmr12428745f8f.9.1747076763944; 
 Mon, 12 May 2025 12:06:03 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf43sm13426521f8f.70.2025.05.12.12.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:06:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zheng Huang <hz1624917200@gmail.com>
Subject: [PULL 15/16] hw/audio/cs4231a: fix assertion error in isa_bus_get_irq
Date: Mon, 12 May 2025 21:05:23 +0200
Message-ID: <20250512190524.179419-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

From: Zheng Huang <hz1624917200@gmail.com>

This patch fixes an assertion error in isa_bus_get_irq() in
/hw/isa/isa-bus.c by adding a constraint to the irq property.
Patch v1 misused ISA_NUM_IRQS, pls ignore that.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
Link: https://lore.kernel.org/r/6d228069-e38f-4c46-813f-edcccc5c47e4@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/cs4231a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 06b44da8690..eb9a45805b7 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -682,6 +682,10 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->irq >= ISA_NUM_IRQS) {
+        error_setg(errp, "Invalid IRQ %d (max %d)", s->irq, ISA_NUM_IRQS - 1);
+        return;
+    }
     s->pic = isa_bus_get_irq(bus, s->irq);
     k = ISADMA_GET_CLASS(s->isa_dma);
     k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
-- 
2.49.0


