Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC34C021A5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 07:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiTML-0004m3-GB; Thu, 13 Feb 2025 02:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tiTMI-0004lW-O3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 02:10:02 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1tiTMA-0005DP-8h
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 02:10:02 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3vAy1mq1nUkubAg--.4945S2;
 Thu, 13 Feb 2025 15:09:41 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwDX3Ymhmq1njoYlAA--.50148S2;
 Thu, 13 Feb 2025 15:09:32 +0800 (CST)
Date: Thu, 13 Feb 2025 15:09:05 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Message-ID: <Z62akRdahoGqHN5x@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
 <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
 <20250211092655.00004310@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211092655.00004310@huawei.com>
X-CM-TRANSID: AQAAfwDX3Ymhmq1njoYlAA--.50148S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWes-icCNgAFsj
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw18KFW7Ar48AFWUAF4ruFg_yoWrWFykpr
 WxtFy5GFs7Ar13JrZ2vw15Xr1rZa1fGFWUCryvkw1rZF90vr9Iqr18Kr4FkFyDZrZ2yw40
 ya12qa4a934j93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 11, 2025 at 09:26:55AM +0000, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:24:13 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > The previous default value of sn is UI64_NULL which would cause the
> > cookie of nd_interleave_set be '0' and the "invalid interleave-set
> > -cookie" failure in label validation.
> Hi Yuquan,
> 
> Maybe we should harden the nd_interleave_set code to fail
> to set the cookie in the event of no serial number. That is a
> device not compliant with the spec, but none the less it is not
> implausible with test devices etc.
> 
Thanks for your suggestions :)

I have send patch 'cxl/pmem: debug invalid serial number data' trying to
fix this problem. Welcome more comments to guide me!

link: https://lore.kernel.org/linux-cxl/20250213064008.4032730-1-wangyuquan1236@phytium.com.cn/T/#t

Here I have another question about labels. It seems like current kernel
only deals with nvdimm namespaces labels and leaves cxl region labels to
do. Therefore, for some dynamically-created cxl pmem regions, users have
to re-create these regions manually. Does it means CXL drivers could not recover
a cxl region by cxl region lables now?.
> > 
> > As many users maybe not know how to set a unique sn for cxl-type3
> > device and perhaps be confuesd by the failure of label validation,
> > so this defines '1' as the default value of serial number to fix the
> > problem.
> 
> That magic value is specifically chosen to be 'undefined' to trigger
> clean handling of the failure and not provide the serial number
> capability. 
> 
> If you have multiple devices and provide a 'valid' default then
> there are circumstances in which the device will be seen as a multiheaded
> single device attached to two places in the PCI topology.
> 
> So I'm not keen to change this.  Ideally we'd have made this a required
> parameter from the start, but we didn't and doing so now would result
> in a backwards compatibility problem.
> 
> So I think this is kind of a 'won't fix' situation on the qemu side.
Ok, I see.

Maybe we could modify the Example command lines in docs/../cxl.rst to remind
users to add this parameter. Is this feasible?

> 
> Jonathan
> 
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  hw/mem/cxl_type3.c | 17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 0ae1704a34..a6b5a9f74e 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
> >      pcie_aer_write_config(pci_dev, addr, val, size);
> >  }
> >  
> > -/*
> > - * Null value of all Fs suggested by IEEE RA guidelines for use of
> > - * EU, OUI and CID
> > - */
> > -#define UI64_NULL ~(0ULL)
> > -
> >  static void build_dvsecs(CXLType3Dev *ct3d)
> >  {
> >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >      pci_config_set_prog_interface(pci_conf, 0x10);
> >  
> >      pcie_endpoint_cap_init(pci_dev, 0x80);
> > -    if (ct3d->sn != UI64_NULL) {
> > -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > -    } else {
> > -        cxl_cstate->dvsec_offset = 0x100;
> > -    }
> > +
> > +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> >  
> >      ct3d->cxl_cstate.pdev = pci_dev;
> >      build_dvsecs(ct3d);
> > @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
> >                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> >      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> >                       HostMemoryBackend *),
> > -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> > +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
> >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> >      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> 


