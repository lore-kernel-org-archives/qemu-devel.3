Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10123C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 11:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTJxZ-0000RN-Sx; Mon, 15 Jul 2024 07:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTJxY-0000Qr-Ed
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTJxU-0002BU-IW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721043211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npDbXbhJ85FSXMLm85o+LYd1iikheLpPs3dveHdC+fg=;
 b=gNKH4KZQdyKekDAkgon+Z8vA3W/62vshsiF1lAm3LJTJ3Vka8cGSizgB1ovCqEfNrBXlnn
 gmNsYUilrfeqE20p2y+RkDSQklGO8T2GGJuzUOzeqYWlXvxKEAUtlu5631wqR1erbEqnMF
 8cqaRbXVTZPnEGGdp0JoR4U+eIl0FG0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-J0-s5uIoMBeqmtHXMuYgRg-1; Mon, 15 Jul 2024 07:33:29 -0400
X-MC-Unique: J0-s5uIoMBeqmtHXMuYgRg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ea88005bfso4543854e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 04:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043208; x=1721648008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npDbXbhJ85FSXMLm85o+LYd1iikheLpPs3dveHdC+fg=;
 b=idRYrK0Y/wI5nClOrK6pg7WE570i4N61rKktfmyTQWFqgEN0u/al1vZctb6VVsPVXW
 CCJzu0QpaxeaTWKCVNy9YjkOa8B3SdJtI10tRxTp8XXHociArzwPCF8EmsnkkRHxVl8g
 0R3WIBRCk3iyk9mw4v5Dgrdt9Og5lgLqFBbzMQW4ouyNixq5ZaG6j+4BhJzG9vA0ZlTK
 gnjFrzwhSGZZSm2VnNFq7KKblNb7KkJQDOB3MHN7qpMFtyLzuwOWS5pu6FOClP3OAqei
 ShjZvbd+VYb1XHja1vxls8UIuPlA0MSY/qmMG4Cz3JtyUwKrTHkXXaiGcEPndljD86xF
 FDxw==
X-Gm-Message-State: AOJu0YzF8OreZ+juBVsjdn3Nn/FFufgWRgWnzw139ts621cCBAqnK4VA
 M8PeWmCr3KHMI/b+MisvAyT5IkiPCKeH+OdbjmChbwM8KiFtz4CactypxEVKnexf8F2Gw9xHwEv
 0+C/0KWENde24+sZeTSvNw6ImzNqGVpE+PldN1PsZBQWEHJRld/yI
X-Received: by 2002:a05:6512:3a84:b0:52e:93da:f921 with SMTP id
 2adb3069b0e04-52eb9997854mr15232596e87.19.1721043207995; 
 Mon, 15 Jul 2024 04:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+4Gz/ZJEoqqM1wK+AdOGdI1fvzrL5iEURZDpJ7/Fpfa7zWGRfnBzuUyZgVCRQEhI99lUucw==
X-Received: by 2002:a05:6512:3a84:b0:52e:93da:f921 with SMTP id
 2adb3069b0e04-52eb9997854mr15232554e87.19.1721043207312; 
 Mon, 15 Jul 2024 04:33:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:fefc:5135:163e:495:83c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3be3sm6147611f8f.24.2024.07.15.04.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 04:33:26 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:33:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240715073301-mutt-send-email-mst@kernel.org>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715071232-mutt-send-email-mst@kernel.org>
 <a43a5a1636c84896be5930570c538031@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43a5a1636c84896be5930570c538031@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 15, 2024 at 11:27:57AM +0000, Salil Mehta wrote:
> Hi Michael,
> 
> >  From: Michael S. Tsirkin <mst@redhat.com>
> >  Sent: Monday, July 15, 2024 12:13 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  On Sat, Jul 13, 2024 at 07:25:09PM +0100, Salil Mehta wrote:
> >  > [Note: References are present at the last after the revision history]
> >  
> >  Igor any comments before I merge this?
> 
> Hi Michael,
> 
> Assuming there are no last-minute surprises and If you decide to merge this
> series, could I kindly request that you collect all the Tags (XXX-Bys) including
> the Igor's pending Reviewed/Acked-By Tag for the entire series, so that I won't
> have to churn out another version (V16)?
> 
> Many thanks!
> 
> Best regards
> Salil


Yes, there's no need to resend just to add acks, I collect them
automatically.

> 
> >  
> >  --
> >  MST
> >  


