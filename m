Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D40C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoUG-0007LE-4e; Thu, 27 Jun 2024 08:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMoUE-0007JR-9P
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMoUC-0000It-Ah
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nw0qhz27VWUrSqZIIfeJN8ARonahQAgkRezb5pMK8yc=;
 b=OS+LKdFJzQUrZcV+zuzhyu3l3csT5NlhQ/Uz1Cfs1r8JNVPz4da/G/ZTwHd+yEoT+VrMo3
 5u4W9erzmBwafKQZ94GQnregH7JpsrVqVcNxsZ65HmGKka209q+JOK2roUhWLrbCcIX23z
 GOghew/ix610aL+LuxDVf2svpmoTbao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-wO9_j1CiPuaGmcBBJ_XoTg-1; Thu, 27 Jun 2024 08:44:20 -0400
X-MC-Unique: wO9_j1CiPuaGmcBBJ_XoTg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42490aed594so29814105e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492259; x=1720097059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw0qhz27VWUrSqZIIfeJN8ARonahQAgkRezb5pMK8yc=;
 b=XB6Ie9ueNCfUNv8W4CsNSe0aE1fE2OHsfILCPU3q7Zl7av7j9zDo1OuRWswLJhJiPe
 7RRdbDJq3HTF15xBf34tLBnik9VX1VcvqSQeHi9fKNA3UXRy5nXLrB7Ctvq9zPINk6jX
 iVpbiLqB+dLxW43VcW4p8ld6YynD0PERnrPTM0xBOBLEC6GEwt1kY2rhxruoyBKIakmj
 0y1DdXOGwYKQBLnM50U/8O0jn/IlrxQXZYgrhrXQ/03CO4Pta3iS6otEHCzju6zkQEXN
 Aibm+j957HQGT+DkBJfPIYS/1rfeJseovO/3B3JwggwT0HFUfqdRGr/atenuzkb67GGb
 XR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ02EVY4B1m4moZI/iQjCpwxPPweAa3f+ByTy4BmJpF7cqJl1Pa/KuYGQQveo/h7KxGqGEpjaDFBdLbxaTXH6Ev6hSO/I=
X-Gm-Message-State: AOJu0YwehOeS7iRkpOFc71rGOtlozZlgn5mIEm0U2+bXx9e1l9erYzfV
 1obmHJ4RpatGWbHTiLun8KAMQspFA/BdhHEK23jD83hnnNeoNEgm+i35mVwyrTVaJ37kg6Epti2
 ThKbtfyaaNVAQnjpQxZJ4plGOMBIcVrKrxnJ28NA4n8Gy8+lk6rYT
X-Received: by 2002:a05:600c:22c1:b0:425:6203:1874 with SMTP id
 5b1f17b1804b1-425620320b6mr22619345e9.37.1719492259379; 
 Thu, 27 Jun 2024 05:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHohbWV/ivJxiZFVuuYraaTNf2L+sOsL2CZcVEC/0Y9Guk8+Ak4yvsUbjlxA7IMxQDL+AtLrw==
X-Received: by 2002:a05:600c:22c1:b0:425:6203:1874 with SMTP id
 5b1f17b1804b1-425620320b6mr22619055e9.37.1719492258521; 
 Thu, 27 Jun 2024 05:44:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:a007:5be4:b928:19f7:7c2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc7b09sm24203915e9.47.2024.06.27.05.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:44:17 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:44:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 ankita@nvidia.com, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 linuxarm@huawei.com, Dave Jiang <dave.jiang@intel.com>,
 Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
 linux-cxl@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627084356-mutt-send-email-mst@kernel.org>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
 <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 02:42:44PM +0200, Igor Mammedov wrote:
> On Thu, 20 Jun 2024 17:03:11 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Rather than attempting to create a generic function with mess of the two
> > different device handle types, use a PCI handle specific variant.  If the
> > ACPI handle form is needed then that can be introduced alongside this
> > with little duplicated code.
> > 
> > Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> > and segment directly.  devfn kept as a single byte because ARI means
> > that in cases this is just an 8 bit function number.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> with typo fixed

typo being "in cases"?

> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 


