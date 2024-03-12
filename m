Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C66FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAb6-00088l-LG; Tue, 12 Mar 2024 18:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAan-0007Tn-LL
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAak-0004OU-Jz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2lpmRuQpB9vA5OA++aQfNEAFEu+9OfR1snJEg9JCvg=;
 b=QNWHfJateMJOpd5zofEo7uc7oGrmwB+q60va+CjFMPwiQzGLSLrmqHWr4BVRSRLqFSyHdR
 WEWLKQr9Wb22Z7J7PTnKJ9ecIeUQ1giFEUyP2YYZ590scnGQApaFd+JqodnZfQ/1YnCqUk
 t1cjiThexcg3/XrslbHASWom9v1y0AA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-lr1Wul9_NUyt_XQBe1GpzQ-1; Tue, 12 Mar 2024 18:27:24 -0400
X-MC-Unique: lr1Wul9_NUyt_XQBe1GpzQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5684c1abc33so2350501a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282443; x=1710887243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2lpmRuQpB9vA5OA++aQfNEAFEu+9OfR1snJEg9JCvg=;
 b=tLRb/Y4S3ja4DbpznNiV27QpFzmZU/ZfU1dQXQ9hAa25xvobQX2i3DnREXOBzAf5nJ
 PYlfbXu/aiu7YTwkjHz5hdsOz3t6DZRvIjVDBsM1b+UEUihFFO5Mc06iMuW2480meqZI
 VGtwQxst9z8/f0J+fwY4vKSEc+KPcqbbgqmUqvbiCLTo26HqI7ABzjDIZVbR9S9j491M
 FX/6Oaus68sNnARFP784ghRBDLuRlgKQaciKc7OmkhGM1bEEYnza+pqzZy4cVhnjC2/f
 o3Y7pi8xaiMwT1aIlOtqumWekd1TOW3/UP63NNmZYm1Dj9Oje8O3RFEWIpLKQT0SvPUP
 OLwg==
X-Gm-Message-State: AOJu0YzRuB350MT4JbsQ11swVVingKc4DEg0tzNdxAzv9e0nlx4ZWy14
 ga84WmxGHBbJKDTKqlA+wPdi2dnFfJcPesmO5FnJTuu4C40zs47tjaEEhxAAYFujI313yQOBe8g
 Q1EakLK0kL0OlMqhqIGzNiqf/44vlnA34YkKQRgbV7fUaWw3NUcSL/LUPYrnLKp4xpiYgF++6/Y
 5MZBgOz7oSMeskIU0k9Sc2j3VVvTJ/49Tg
X-Received: by 2002:a50:9e48:0:b0:566:ab45:e6c5 with SMTP id
 z66-20020a509e48000000b00566ab45e6c5mr2157423ede.28.1710282443024; 
 Tue, 12 Mar 2024 15:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxDO4TGc3w2tLD2JLb7Y5kfREmjXSbzSX6P7SIcBHWNwfLLoRHL27m3wQgi5keSuq/qBGa+A==
X-Received: by 2002:a50:9e48:0:b0:566:ab45:e6c5 with SMTP id
 z66-20020a509e48000000b00566ab45e6c5mr2157407ede.28.1710282442491; 
 Tue, 12 Mar 2024 15:27:22 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm4411838edt.12.2024.03.12.15.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:21 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 35/68] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
 ct3_realize()
Message-ID: <d477d07a5d2c392c7aa99cb76921ed3e40d141ef.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in ct3_realize(), @errp is dereferenced without ERRP_GUARD():

cxl_doe_cdat_init(cxl_cstate, errp);
if (*errp) {
    goto err_free_special_ops;
}

Here we check *errp, because cxl_doe_cdat_init() returns void. And
ct3_realize() - as a PCIDeviceClass.realize() method - doesn't get the
NULL @errp parameter, it hasn't triggered the bug that dereferencing
the NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
ct3_realize().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240223085653.1255438-4-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b679dfae1c..b0a7e9f11b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -645,6 +645,7 @@ static DOEProtocol doe_cdat_prot[] = {
 
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_GUARD();
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     ComponentRegisters *regs = &cxl_cstate->crb;
-- 
MST


