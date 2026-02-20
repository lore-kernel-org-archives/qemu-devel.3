Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3822C5ACD9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 16:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtTGs-0002DL-VN; Fri, 20 Feb 2026 11:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtTGs-0002D5-5h
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtTGq-0001NV-He
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771604543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+W5oQMDGwVl0qrxF+2WQeNVsk3fULyjvEKkCm5P42o=;
 b=RNHsHsjAkHN+eRnyuixjqR0hSLbnVKX12N1gt1RL5cd8BSHNadOAX4Ey7KwQ/qBHajVzTK
 Hch9ot4jVvTxbiIbodgK9tY1+LbZKQXkZs+1LiYLw0c+EpuqS5wYp8um3l4opFhKkpBFvu
 8OGOzmRg9/nVgf/52lObCFQCR6r2nqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ni0oBzLTPJO7Mh2Dl_AXbg-1; Fri, 20 Feb 2026 11:22:21 -0500
X-MC-Unique: ni0oBzLTPJO7Mh2Dl_AXbg-1
X-Mimecast-MFC-AGG-ID: ni0oBzLTPJO7Mh2Dl_AXbg_1771604541
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43624564fc9so1979764f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771604540; x=1772209340; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+W5oQMDGwVl0qrxF+2WQeNVsk3fULyjvEKkCm5P42o=;
 b=JhayPlKvspT4+Kg73hvIg8WE3pd5aMt2lXLR2yLRpDHQhWNlsnEnRbwYruRAqoVaqd
 YtrYNrQKNBvEL/lMGODP7+kmPzbnHXDfdZiL+hTnIA5jqO5ehzVg0CpbmS8B8lgdYsq4
 pYAg8ZjMRDdPZyhEdUR/yfdgx7mRTgzrIN5EgsFKElLyNYzsYfinGRY/x6tPN++hdEJ+
 ctJFcpJADjLFgscH6rty7J3ZgZWkwB+gYGkngphtLSU3gAOQyFB/k/ZBN9UoANVpl6eW
 1PYpGADzjIT08biOnG6QL+lkUpTNGKQamSrvpt/ea+BYdRj97udNZyxK70w2TbEDXSzU
 tGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771604540; x=1772209340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+W5oQMDGwVl0qrxF+2WQeNVsk3fULyjvEKkCm5P42o=;
 b=OEdAwFJQ5uFgR26X1/2aguB2xS7yqYbZl1/11b4+rUdowIlUDsGSmqCy1BAjGnug31
 z9oUbf1srfPkHIUyp/ZV5SpEm0xlrODpscduvw7pZhtjzr+Jon2dKCCnDWBuExmpPpF6
 DcK3pr5MmlwhUMDEeUQOGXKUcRxKnmF+ASAjAcflmFrOW9IjlXRA/x+oZB7Y0H+PqR6P
 RlDf9dDS4NMmPD05tIh1P9CVeDdv6+QjsY3LJFP11x9vtAnyRlyvxXPI4pWbNaWtngDt
 1S39WscZ0MiPZ+1EmlLwPWsLywIKgrAq1+S7j9+lZ/GJgTFrW7cMXWodCaKyuoKrtKf5
 xD3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdtW/bmV6a/ztaN1l2H/m0+AxWf+J9UJ/spAZfytvrkMgwlmwsI27adYZg7jLGZKjBCkFsQb3JOjEn@nongnu.org
X-Gm-Message-State: AOJu0Yz2TJxp3A+GSP45acPvM2EgFPZ32qVfrQhHr3EVyP29M7/Be8hx
 1CXpe0VjPyPgE6ocxZDpCuAVPlN8E7dbwJH51dCFw7G1uWpW8DCCOkCoMUgTAIbA44hHzwWCEGS
 J+A/Axl0cuBHR3sJKz41gjHXV9Y9m+jNwlOf2kqeRJhiXnoI0/U0PnpBB
X-Gm-Gg: AZuq6aLOcNPc8MktYu6ddZ7UmJdx8b3EXx19W39JCIK5JXzwLdigNO6fvCyGJCF5Tio
 2COtOb63f7KftmYgkgX96DQlH3fxAvL1zA7XIONpFO9ungWcw4igH2gF17Rr04LYsDtcf3zKNOn
 o/B/Z1CO1yWV68Tuwl31DI6OfjKpJELaBiy4Ilbg85ZGUWMQ5RJcIT61yMqp53i4ZmjpjzaVJK5
 Vd8hM2Y04s4b561bPT7olnZKit4coap1fp25aMW0nrSa2sofwOFrm9uFolXqchTsLtcmMof6YRK
 nhscFuRZWEK2fu6gbAKO/iXUd+4oItdtswc4bkIGqsdSvpatjI7EDxG42UMSB/SKenAlWdOQR7/
 hXr+ti7WCzWS1n4VVVqJsDZ4bHrrkxsQYrfa9kZJO7tgm2A==
X-Received: by 2002:a5d:5f52:0:b0:435:e060:8071 with SMTP id
 ffacd0b85a97d-4396f157d1fmr954245f8f.16.1771604540503; 
 Fri, 20 Feb 2026 08:22:20 -0800 (PST)
X-Received: by 2002:a5d:5f52:0:b0:435:e060:8071 with SMTP id
 ffacd0b85a97d-4396f157d1fmr954183f8f.16.1771604539982; 
 Fri, 20 Feb 2026 08:22:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad0166sm57443419f8f.35.2026.02.20.08.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:22:19 -0800 (PST)
Date: Fri, 20 Feb 2026 11:22:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
Subject: Re: [PATCH v3 0/9] : pnv/phb4: Update PHB4 to the latest PHB5 spec
Message-ID: <20260220112141-mutt-send-email-mst@kernel.org>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 10, 2026 at 07:40:50AM -0600, Saif Abrar wrote:
> Hello,
> 
> Addressing the review comments for the series v2:
> https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03768.html


breaks tsan build:


https://gitlab.com/mstredhat/qemu/-/jobs/13201554945

../hw/pci-host/pnv_phb4.c:968:9: error: expected expression
        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
        ^
../hw/pci-host/pnv_phb4.c:969:43: error: use of undeclared identifier 'pci'
        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
                                          ^
../hw/pci-host/pnv_phb4.c:999:9: error: use of undeclared identifier 'pci'
        pci = PCI_HOST_BRIDGE(phb->phb_base);
        ^
../hw/pci-host/pnv_phb4.c:1000:32: error: use of undeclared identifier 'pci'
        pdev = pci_find_device(pci->bus, 0, 0);
                               ^
4 errors generated.


> This series updates the existing PHB4 model to the latest spec:
> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
> 
> Updates include the following:
> - implemented sticky reset logic
> - implemented read-only, write-only, W1C and WxC logic
> - return all 1's on read to unimplemented registers
> - update PCIE registers for link status, speed and width
> - implement IODA PCT debug table without any functionality
> - update LSI Source-ID register based on small/big PHB number of interrupts
> 
> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
> to various registers of interest and verifies the values.
> 
> Regards.
> 
> Saif Abrar (9):
>   qtest/phb4: Add testbench for PHB4
>   pnv/phb4: Add reset logic to PHB4
>   pnv/phb4: Implement sticky reset logic in PHB4
>   pnv/phb4: Implement read-only and write-only bits of registers
>   pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
>   pnv/phb4: Set link-active status in HPSTAT and LMR registers
>   pnv/phb4: Set link speed and width in the DLP training control register
>   pnv/phb4: Implement IODA PCT table
>   pnv/phb4: Mask off LSI Source-ID based on number of interrupts
> 
>  hw/pci-host/pnv_phb.c               |   1 +
>  hw/pci-host/pnv_phb4.c              | 583 +++++++++++++++++++++++++---
>  include/hw/pci-host/pnv_phb4.h      |  16 +-
>  include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>  tests/qtest/meson.build             |   1 +
>  tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
>  6 files changed, 837 insertions(+), 58 deletions(-)
>  create mode 100644 tests/qtest/pnv-phb4-test.c
> 
> -- 
> 2.47.3


