Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E4FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribp2-0000gL-Ap; Fri, 08 Mar 2024 10:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riboz-0000bu-Sw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:07:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ribov-0000lH-6p
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:07:41 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrqDk2757z6K9Bf;
 Fri,  8 Mar 2024 23:03:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 38054140136;
 Fri,  8 Mar 2024 23:07:34 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 15:07:33 +0000
Date: Fri, 8 Mar 2024 15:07:33 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PULL 53/60] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
Message-ID: <20240308150733.00007e25@huawei.com>
In-Reply-To: <CAFEAcA9jN7zO_tR3xmcDjSY3cuKimsdPwZtkE1JVhjAcpSreLg@mail.gmail.com>
References: <cover.1707909001.git.mst@redhat.com>
 <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
 <CAFEAcA_W8BxG6rpcao2hCYntfU9aQfAzHQiy6RJQ-v3ZB4sNZg@mail.gmail.com>
 <20240308143420.0000536e@Huawei.com>
 <CAFEAcA9jN7zO_tR3xmcDjSY3cuKimsdPwZtkE1JVhjAcpSreLg@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 8 Mar 2024 14:38:55 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 8 Mar 2024 at 14:34, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 8 Mar 2024 13:47:47 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > Is there a way we could write this that would catch this error?
> > > I'm thinking maybe something like
> > >
> > > #define CXL_CREATE_DVSEC(CXL, DEVTYPE, TYPE, DATA) do { \
> > >      assert(sizeof(*DATA) == TYPE##_LENGTH); \
> > >      cxl_component_create_dvsec(CXL, DEVTYPE, TYPE##_LENGTH, \
> > >                                 TYPE, TYPE##_REVID, (uint8_t*)DATA); \
> > >      } while (0)  
> >
> > We should be able to use the length definitions in the original assert.
> > I'm not sure why that wasn't done before.  I think there were some cases
> > where we supported multiple versions and so the length can be shorter
> > than the structure defintion but that doesn't matter on this one.
> >
> > So I think minimal fix is u16 of padding and update the assert.
> > Can circle back to tidy up the multiple places the value is defined.
> > Any mismatch in which the wrong length define is used should be easy
> > enough to spot so not sure we need the macro you suggest.  
> 
> Well, I mean, you didn't in fact spot the mismatch between
> the struct type you were passing and the length value you
> were using. That's why I think it would be helpful to
> assert() that the size of the struct really does match
> the length value you're passing in. At the moment the
> code completely throws away the type information the compiler
> has by casting the pointer to the struct to a uint8_t*.

True, but the original assert at the structure definition would have
fired if I'd actually used the define rather than a number :(

There is definitely more to do here - but fix wants to be on the light
side of all the options.

cxl_component_create_dvsec() is an odd function in general as it has
more code that varies depending on cxl_dev_type than is shared.

So it might just make sense to split it up and provide some more
trivial functions for the header writing. This is a case of code
that has evolved and ended up as a far from ideal solution.

We only carry the DVSECHeader in the structures so that the sizes can
be read against the spec. It makes the code more complex though
so maybe should consider dropping it and making the asserts next
to the structure definitions more complex.

The asserts in existing function can go (checking it fits etc is done
by pcie_add_capability()).

If not need something more like
//awkward naming is because the second cxl needs to be there to match spec.
void cxl_create_pcie_cxl_device_dvsec(CXLComponentState *cxl,
				      CXLDVSECDevice *dvsec)
{
    PCIDevice *pdev = cxl->pdev;
    uint16_t offset = cxl->dvsec_offset;
    uint16_t length = sizeof(*dvsec);
    uint8_t *wmask = pdev->wmask;

    ///next block can probably be a helper or done in a simpler way.
    /// A lot of what we have here is just to let us reuse this first call.
    pcie_add_capability(pdev, PCI_EXT_CAP_ID_DVSEC, 1, offset, length);

    ///These could be done by writing into dvsec, and memcpy ing more
    ///but the offset will be even stranger if we do that.
    pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
                 (length << 20) | (rev << 16) | CXL_VENDOR_ID);
    pci_set_word(pdev->config + offset + PCIE_DEVSEC_ID_OFFSET,
                 PCIE_CXL_DEVICE_DEVSEC);

    memcpy(pdev->config + offset + sizeof(DVSEC_HEADER),
           (uint8_t *)dvsec + sizeof(DVSECHeader),
           length - sizeof(DVSECHEAEDR));

// all the wmask stuff for this structure.
}


So I'm aiming for more drastic surgery than you were suggesting but
not in the fix!

Jonathan

> 
> thanks
> -- PMM


