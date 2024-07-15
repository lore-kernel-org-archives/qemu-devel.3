Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFECC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 11:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTJe1-0001Ce-DY; Mon, 15 Jul 2024 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTJe0-0001Am-0H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTJdv-0006fP-Dz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721041998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VdC3poWepDQ+k/rcKiFhNKt7cgjIrB/WBi7CvX15gr0=;
 b=I8LcwiCYBRD3xnEBriZL5TuGLeptCxI8/yVMUx1ai9ScL7kkIef8Brk5nt66V7cG+Dpoev
 xgdUfKmp9bWyirPEjJlIviumsX+S8rRB6N5DhmQInr4+ZzzF8yLv8iznvzXo3G5pTIrFbr
 OIXGg6YANShn0aXok4axLB2Wlekv3D0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-bJC4MQHQNIacJAQbqnLmyw-1; Mon, 15 Jul 2024 07:13:16 -0400
X-MC-Unique: bJC4MQHQNIacJAQbqnLmyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso26965745e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 04:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721041995; x=1721646795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdC3poWepDQ+k/rcKiFhNKt7cgjIrB/WBi7CvX15gr0=;
 b=uIS87d/2RNFE7Mm2KSJfg736cOazlogC28nWkJ2cktdDDLr/RFKZ5G8xBk26I1eKBs
 GWukdu4q8ctt42Fo3FuzFwtoG3CPJKBTQvdcWhihHE2X63Yt1jOv5sIEouQQirLxiGcP
 KhXbsRzaAPe5Zc3a40/tqEvSR8hP8IC2NDTsy379C/b/mYI2VF0yTXWaCupbOPH79Y3F
 qCyS3tpEAWlhwBGvggqVerLArzSupYbVw0jWfGCp5TKJyRJYFv6ZU8bR5tkqvs2/V7gK
 vYu5ipHVjQt0/mcmQjUSzsamnP6F3zWqQGgnXni3iFPjhfv9A4+OYbpjB34PilGcDn68
 WIaQ==
X-Gm-Message-State: AOJu0YyRCvs5DOJpqLnsxNEl5i6xLHejnAMuL5Uty6B2AaCW+93JMk1j
 g5la08z6eUlX4lrpFNFmEh8amPcOBDXw73emEa1unH1+SmWFN4TXEGyTGq3ZswH1/EtPwWNSHbU
 35Z23xuU6sCHwmbTFwWjymK2BVHMAdn4S5W9X3Yq0skvFHuWZ48AK
X-Received: by 2002:a05:600c:3042:b0:426:6eb9:2643 with SMTP id
 5b1f17b1804b1-426707d890amr116656125e9.11.1721041995200; 
 Mon, 15 Jul 2024 04:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnfXBCTkzaXK0Mfsi+37CSPVm/7pYInty0HJC1LcrQvhoiRx3z7hYVvFmEbLIcng18Y2TOBQ==
X-Received: by 2002:a05:600c:3042:b0:426:6eb9:2643 with SMTP id
 5b1f17b1804b1-426707d890amr116655735e9.11.1721041994656; 
 Mon, 15 Jul 2024 04:13:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:fefc:5135:163e:495:83c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf195sm6057344f8f.42.2024.07.15.04.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 04:13:14 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:13:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240715071232-mutt-send-email-mst@kernel.org>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713182516.1457-1-salil.mehta@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 13, 2024 at 07:25:09PM +0100, Salil Mehta wrote:
> [Note: References are present at the last after the revision history]

Igor any comments before I merge this?

-- 
MST


