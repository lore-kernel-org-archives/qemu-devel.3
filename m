Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD2C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9FU-00005M-N7; Mon, 03 Jun 2024 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sE9FT-0008W5-TH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sE9FS-0003DM-Br
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717427120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD0KSZdVG7eigsmSSRsltR847vCbYt4xUv1MRF2No+E=;
 b=aMK9PAjuEi6XHWirBLFjE7RlBRo3Urzt9fpwocnTzd3oiUZPyTJ8qH73z97B0Ga+puA+T8
 GgVZgXoEK8/Mg433TPjXBTdYxLHYL2ehG9X6jj+MwJE7Uw/bV+g8G/zcKUye/V7Own5HrU
 zcUAol1C7fcYCzBPGIljBlPcScLYh10=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-8RY24sGhPPCzqJasfOVdeQ-1; Mon, 03 Jun 2024 11:05:18 -0400
X-MC-Unique: 8RY24sGhPPCzqJasfOVdeQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212adbe3b6so24617575e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427117; x=1718031917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gD0KSZdVG7eigsmSSRsltR847vCbYt4xUv1MRF2No+E=;
 b=VjNgKfCMf5q+KEjcr0FuUoY/heoeURY9B0ME7mF4FeyoqoUJXMfMvcLLdaB/nqUW0x
 /uPWNBlFNVwgZ/NQK2xnvGFGEs0JYh9Z2sw56cDxZ9USeu1UWNp5okcUFJ0n1bRSJ092
 P7pVvaQX+kB7ZU7OayP12ztAiUz6AJK5mJpp9uiUXuwgTXHAvuFq3RYA7ZOc9d5aKzyb
 BTW1oh5BSBAjzWJzHhPDhOC1PYXytjBowXe25foh8yR93YJX19F2hugi2QIWLylHWJEs
 hc+tI/83Iv8riS9fjLJbHixVjBsku6SSVmyAvGupFMT47VgbgJH2OSOci37a6iibrDr+
 er5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSWI638jxO50yra6W9nbDDcIIrtZ8OqkZmxD081ZazfRbIK3Hew23FrW1VgrZWjqQXPGgD5/eXVqT2pchjwcIPe1QG4sw=
X-Gm-Message-State: AOJu0YygQtYWtTntxNIclfVySzPEm7a52gtV06sGA3dnVJl7mUu2ywQw
 r3iPWFaJMxLLdYh/Kq7Esw6AN4HcS/ijHSdjIPWmxIxEBfeVuO7FzOWGcbPF+ely/TfDdOIHZXM
 utmbOuZ8wk4W4IbBxioJ7UgIL8FsE3brda0qcHQzzV3ItUIUY5Hzn
X-Received: by 2002:a05:600c:3595:b0:421:1f6f:3e15 with SMTP id
 5b1f17b1804b1-4212e06ffc7mr82371395e9.16.1717427117499; 
 Mon, 03 Jun 2024 08:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeBnz+CcQW2iVk+w8yLYx1JQsZP7DYgIludVQN8Jyl/tA68UV2Efe5cPhu1X0B4+a4l5jJPg==
X-Received: by 2002:a05:600c:3595:b0:421:1f6f:3e15 with SMTP id
 5b1f17b1804b1-4212e06ffc7mr82371065e9.16.1717427116841; 
 Mon, 03 Jun 2024 08:05:16 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7417:6800:36c9:6b1b:9f6e:56c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42133e66ce0sm97705835e9.23.2024.06.03.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 08:05:16 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:05:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
Message-ID: <20240603110458-mutt-send-email-mst@kernel.org>
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
 <48ebd16f-3eda-4292-9257-bcac9c82cc5c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48ebd16f-3eda-4292-9257-bcac9c82cc5c@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 03, 2024 at 02:53:35PM +0200, Philippe Mathieu-Daudé wrote:
> On 31/5/24 18:22, Ira Weiny wrote:
> > Peter and coverity report:
> > 
> > 	We've passed '&data' to address_space_write(), which means "read
> > 	from the address on the stack where the function argument 'data'
> > 	lives", so instead of writing 64 bytes of data to the guest ,
> > 	we'll write 64 bytes which start with a host pointer value and
> > 	then continue with whatever happens to be on the host stack
> > 	after that.
> > 
> > Indeed the intention was to write 64 bytes of data at the address given.
> > 
> > Fix the parameter to address_space_write().
> > 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
> > Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> > Compile tested only.  Jonathan please double check me.
> > ---
> >   hw/mem/cxl_type3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks, patch queued.

Had it queued too but sure, I can drop.

-- 
MST


