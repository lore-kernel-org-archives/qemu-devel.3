Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105E4C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidvq-0008I6-40; Thu, 13 Feb 2025 13:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tidvm-0008Hj-Mn
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:27:22 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tidvj-0000ym-TY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:27:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so20294565ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739471236; x=1740076036; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cmghmuCnhycAkjWOUuCwMZFMKLZ5v7aidKalfucPC10=;
 b=eJJPZwthNtiDB7i9OMWk6fmE5f7R5Mchf9tzy6xGPw1W30bjbc4NaqoqoX7A3vPLDN
 hGvQg9ouY3F00xjQC09l+o2rCuZcQCl2iuBG4+MYtLWlQeynxdM41gc7UPeBTux6YTcy
 ePR/HVqLcZZkLEPCmloWELGLLUYAzX1pXO5W2RV2UGSd4HBYlH/kew6zYdCWMPZdmG52
 ab0eutiYGq2z+eOuWeTC8llqmMS5CvolZhF3HTJfeX43g2k4YJXQEjq7IkJ1bgsy1MYF
 8hxX0ebJsdOp47NmxDIT5EIS7RclR2NcnfVqJiix2lXKDhzBOvcfdC40/omVFkhalhKd
 /3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739471236; x=1740076036;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmghmuCnhycAkjWOUuCwMZFMKLZ5v7aidKalfucPC10=;
 b=Nu0kd7dKOZ1tfDKA1xz+wCVrpO31cnvFWfzeE80i5dJNdUL2403rHvcccXOumLdBmW
 0tHB1Tel9Ty9JvsrkYAN1JkVCmSYZFU80QJJd5weeIEOEevYwkSuSTNLTq+LCLdR0dIn
 45CTbSLAjTk0qmKJPIMjcvfCIHMhxM7e9cUIo2mIT6z1Am+cCmhsAptW1uezcNleyhz2
 fo0NYIJ2EqnOTIPXqj62tt1QQ+ggZDy++q2PM+BQxVEGk/MftcssZfzPqgR+PNzN58zZ
 SFnUXe+/IV+dNJbi4BjVC2QCWLffsx7vHuoTTNozIlzSUjIC6TEb83vGVxGLdFSgkzIn
 48CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxRiKgBn0M6z6PjohEuYSL7/ISOOZ3aOHB3rKaxhf+eKz24QaaLsy9QlwlDf0SpCD0YEsdgwOfLoL@nongnu.org
X-Gm-Message-State: AOJu0YxHANRJ3kE62IYv1+2oDCyNeSShEb/i0nIZkIAx2v2AX02kSPkz
 N296KwfetLeZDq56WN/TriWatebhMdFhVs6XB/YN0nWYXOiuvIsh
X-Gm-Gg: ASbGncso0lJDnvZO5/wOdfduzUp7Mixl9YMXq666qvEuZRrCFemoDf2jc3Nsa0oCFSA
 ssHRYAUs3A1GLLvyGjxa0xDyq/AkgtdTIYbtkmLjmOzO1ZRm5QSWtNHm2B+wsBc13610ElU8F0Y
 q0qQroOufTuPlIv30xwh1/3KI9gdXjaVYfK9vUy9kfbA6xZF+S+UcJLYuwx9KcRSnZ06nqsQIEQ
 gblG2xWyBwp7MN2Z4QU0UNVQF8OGe/YK2OF2CVqB6lzS4XPmMBLLFGccW/80x7mU2DqDyyz88+Z
 67Q+qyvC5idx1z+UDH+SPKOLxOgHpFxY2m3asw+nNjY=
X-Google-Smtp-Source: AGHT+IHHVKOSijGgzkJb8J/7oWAd13hrPMDbDrXhsTaZtvB9ikRLLiNjtVxpFMg94MGeoTtCDznDcQ==
X-Received: by 2002:a17:902:d502:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-220bbc67fbemr141122475ad.32.1739471236605; 
 Thu, 13 Feb 2025 10:27:16 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5364669sm15385295ad.86.2025.02.13.10.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 10:27:16 -0800 (PST)
Message-ID: <67ae3984.170a0220.36b6de.8cb0@mx.google.com>
X-Google-Original-Message-ID: <Z645erpowZDDVt1E@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Feb 2025 10:27:06 -0800
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 chenbaozi@phytium.com.cn, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
 <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
 <20250211092655.00004310@huawei.com>
 <Z62akRdahoGqHN5x@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62akRdahoGqHN5x@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x630.google.com
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

On Thu, Feb 13, 2025 at 03:09:05PM +0800, Yuquan Wang wrote:
> On Tue, Feb 11, 2025 at 09:26:55AM +0000, Jonathan Cameron wrote:
> > On Tue, 11 Feb 2025 10:24:13 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > 
> > > The previous default value of sn is UI64_NULL which would cause the
> > > cookie of nd_interleave_set be '0' and the "invalid interleave-set
> > > -cookie" failure in label validation.
> > Hi Yuquan,
> > 
> > Maybe we should harden the nd_interleave_set code to fail
> > to set the cookie in the event of no serial number. That is a
> > device not compliant with the spec, but none the less it is not
> > implausible with test devices etc.
> > 
> Thanks for your suggestions :)
> 
> I have send patch 'cxl/pmem: debug invalid serial number data' trying to
> fix this problem. Welcome more comments to guide me!
> 
> link: https://lore.kernel.org/linux-cxl/20250213064008.4032730-1-wangyuquan1236@phytium.com.cn/T/#t
> 
> Here I have another question about labels. It seems like current kernel
> only deals with nvdimm namespaces labels and leaves cxl region labels to
> do. Therefore, for some dynamically-created cxl pmem regions, users have
> to re-create these regions manually. Does it means CXL drivers could not recover
> a cxl region by cxl region lables now?.

As you mentioned, region label is not implemented in current kernel, so
I do not see a way to recover a region with region label as it is not
persisted to the LSA of the device.

Fan
> > > 
> > > As many users maybe not know how to set a unique sn for cxl-type3
> > > device and perhaps be confuesd by the failure of label validation,
> > > so this defines '1' as the default value of serial number to fix the
> > > problem.
> > 
> > That magic value is specifically chosen to be 'undefined' to trigger
> > clean handling of the failure and not provide the serial number
> > capability. 
> > 
> > If you have multiple devices and provide a 'valid' default then
> > there are circumstances in which the device will be seen as a multiheaded
> > single device attached to two places in the PCI topology.
> > 
> > So I'm not keen to change this.  Ideally we'd have made this a required
> > parameter from the start, but we didn't and doing so now would result
> > in a backwards compatibility problem.
> > 
> > So I think this is kind of a 'won't fix' situation on the qemu side.
> Ok, I see.
> 
> Maybe we could modify the Example command lines in docs/../cxl.rst to remind
> users to add this parameter. Is this feasible?
> 
> > 
> > Jonathan
> > 
> > > 
> > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > > ---
> > >  hw/mem/cxl_type3.c | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 0ae1704a34..a6b5a9f74e 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
> > >      pcie_aer_write_config(pci_dev, addr, val, size);
> > >  }
> > >  
> > > -/*
> > > - * Null value of all Fs suggested by IEEE RA guidelines for use of
> > > - * EU, OUI and CID
> > > - */
> > > -#define UI64_NULL ~(0ULL)
> > > -
> > >  static void build_dvsecs(CXLType3Dev *ct3d)
> > >  {
> > >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > > @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> > >      pci_config_set_prog_interface(pci_conf, 0x10);
> > >  
> > >      pcie_endpoint_cap_init(pci_dev, 0x80);
> > > -    if (ct3d->sn != UI64_NULL) {
> > > -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > > -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > > -    } else {
> > > -        cxl_cstate->dvsec_offset = 0x100;
> > > -    }
> > > +
> > > +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > > +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > >  
> > >      ct3d->cxl_cstate.pdev = pci_dev;
> > >      build_dvsecs(ct3d);
> > > @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
> > >                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> > >      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> > >                       HostMemoryBackend *),
> > > -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> > > +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
> > >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> > >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> > >      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> > 
> 

