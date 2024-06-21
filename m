Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B07EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfm4-0004JM-9L; Fri, 21 Jun 2024 11:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKfm2-0004J1-Tg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:01:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKflx-0005DP-HI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:01:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5LBQ1J0Rz6K9DH;
 Fri, 21 Jun 2024 23:00:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 10E4F140C98;
 Fri, 21 Jun 2024 23:01:49 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 16:01:48 +0100
Date: Fri, 21 Jun 2024 16:01:47 +0100
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Message-ID: <20240621160147.0000633e@Huawei.com>
In-Reply-To: <OSZPR01MB6453195EADF10E5D7EB35B4B8DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453BEE69D709FAD5F5431228DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <OSZPR01MB6453195EADF10E5D7EB35B4B8DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 6 Jun 2024 08:07:27 +0000
"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:

> ping again.

Sorry for delay - I was waiting for some of the tree I'm carrying
to get picked up before applying anything new.

I haven't yet tested this as fully as I'd like for upstreaming, but
with that in mind applied to my cxl staging tree. 

Thanks,

Jonathan

> 
> > -----Original Message-----
> > From: Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>
> > Sent: Friday, May 24, 2024 5:31 PM
> > To: Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>;
> > jonathan.cameron@huawei.com; fan.ni@samsung.com
> > Cc: qemu-devel@nongnu.org
> > Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
> > 
> > ping.
> >   
> > > -----Original Message-----
> > > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > Sent: Wednesday, May 8, 2024 8:53 AM
> > > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > > Cc: qemu-devel@nongnu.org; Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>
> > > Subject: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
> > >
> > > Since the kernel does not check the interleave capability, a
> > > 3-way, 6-way, 12-way or 16-way region can be create normally.
> > >
> > > Applications can access the memory of 16-way region normally because
> > > qemu can convert hpa to dpa correctly for the power of 2 interleave
> > > ways, after kernel implementing the check, this kind of region will
> > > not be created any more.
> > >
> > > For non power of 2 interleave ways, applications could not access the
> > > memory normally and may occur some unexpected behaviors, such as
> > > segmentation fault.
> > >
> > > So implements this feature is needed.
> > >
> > > Link:
> > >  
> > https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujits  
> > > u.com/
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > ---
> > >  hw/cxl/cxl-component-utils.c |  9 +++++++--
> > >  hw/mem/cxl_type3.c           | 15 +++++++++++----
> > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > index cd116c0401..473895948b 100644
> > > --- a/hw/cxl/cxl-component-utils.c
> > > +++ b/hw/cxl/cxl-component-utils.c
> > > @@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state,
> > > uint32_t *write_msk,
> > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > INTERLEAVE_4K, 1);
> > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > >                       POISON_ON_ERR_CAP, 0);
> > > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 3_6_12_WAY, 0);
> > > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,  
> > 16_WAY,  
> > > 0);
> > > +    if (type == CXL2_TYPE3_DEVICE) {
> > > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 3_6_12_WAY, 1);
> > > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 16_WAY, 1);
> > > +    } else {
> > > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 3_6_12_WAY, 0);
> > > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 16_WAY, 0);
> > > +    }
> > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,  
> > 0);  
> > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > >                       UIO_DECODER_COUNT, 0);
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 3e42490b6c..b755318838 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -804,10 +804,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr
> > > host_addr, uint64_t *dpa)
> > >              continue;
> > >          }
> > >
> > > -        *dpa = dpa_base +
> > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)  
> > > -              >> iw));  
> > > +        if (iw < 8) {
> > > +            *dpa = dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &  
> > hpa_offset)  
> > > +                  >> iw));
> > > +        } else {
> > > +            *dpa = dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
> > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > +        }
> > >
> > >          return true;
> > >      }
> > > --
> > > 2.37.3  
> 
> 


