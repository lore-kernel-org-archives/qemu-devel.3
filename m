Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0838FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ohR-0003Sb-JF; Tue, 30 Apr 2024 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1ohP-0003SC-QV
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:43:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1ohM-0003cJ-E9
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:43:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNGM0Y53z6DB69;
 Tue, 30 Apr 2024 22:42:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 20728140A08;
 Tue, 30 Apr 2024 22:43:09 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 15:43:08 +0100
Date: Tue, 30 Apr 2024 15:43:07 +0100
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Message-ID: <20240430154307.00002879@huawei.com>
In-Reply-To: <OSZPR01MB6453EAAAA6C5CDCF87422A588D102@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453EAAAA6C5CDCF87422A588D102@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 24 Apr 2024 01:36:56 +0000
"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:

> ping.
> 
> > -----Original Message-----
> > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > Sent: Sunday, April 7, 2024 11:07 AM
> > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > Cc: qemu-devel@nongnu.org; Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>
> > Subject: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
> > 
> > Since the kernel does not check the interleave capability, a
> > 3-way, 6-way, 12-way or 16-way region can be create normally.
> > 
> > Applications can access the memory of 16-way region normally because
> > qemu can convert hpa to dpa correctly for the power of 2 interleave
> > ways, after kernel implementing the check, this kind of region will
> > not be created any more.
> > 
> > For non power of 2 interleave ways, applications could not access the
> > memory normally and may occur some unexpected behaviors, such as
> > segmentation fault.
> > 
> > So implements this feature is needed.
> > 
> > Link:
> > https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujits
> > u.com/
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  hw/mem/cxl_type3.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b0a7e9f11b..d6ef784e96 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr
> > host_addr, uint64_t *dpa)
> >              continue;
> >          }
> > 
> > -        *dpa = dpa_base +
> > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)  
> > -              >> iw));  
> > +        if (iw < 8) {
> > +            *dpa = dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
> > +                  >> iw));
> > +        } else {
> > +            *dpa = dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
> > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > +        }
> > 
> >          return true;
> >      }
> > @@ -906,6 +913,9 @@ static void ct3d_reset(DeviceState *dev)
> >      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
> > 
> >      cxl_component_register_init_common(reg_state, write_msk,
> > CXL2_TYPE3_DEVICE);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 3_6_12_WAY, 1);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 16_WAY, 1);
> > +

Why here rather than in hdm_reg_init_common()?
It's constant data and is currently being set to 0 in there.

> >      cxl_device_register_init_t3(ct3d);
> > 
> >      /*
> > --
> > 2.37.3  
> 


