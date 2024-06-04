Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5083CC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVmc-0001L3-GN; Tue, 04 Jun 2024 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEVma-0001Ku-G8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:09:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEVmW-0000oH-L4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:09:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vtv5M5gMJz6J9s4;
 Tue,  4 Jun 2024 23:04:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C797140736;
 Tue,  4 Jun 2024 23:08:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 16:08:55 +0100
Date: Tue, 4 Jun 2024 16:08:54 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Gregory Price" <gourry.memverge@gmail.com>, Gregory Price
 <gregory.price@memverge.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 25/53] hw/cxl/mailbox: interface to add CCI commands to
 an existing CCI
Message-ID: <20240604160854.000006ad@Huawei.com>
In-Reply-To: <20240604091451-mutt-send-email-mst@kernel.org>
References: <cover.1717506831.git.mst@redhat.com>
 <2010f46e48229ec29146c4941768db61fd21fa76.1717506831.git.mst@redhat.com>
 <20240604091451-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 4 Jun 2024 09:15:02 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 04, 2024 at 09:13:26AM -0400, Michael S. Tsirkin wrote:
> > From: Gregory Price <gourry.memverge@gmail.com>
> > 
> > This enables wrapper devices to customize the base device's CCI
> > (for example, with custom commands outside the specification)
> > without the need to change the base device.
> > 
> > The also enabled the base device to dispatch those commands without
> > requiring additional driver support.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > 
> > --
> > Heavily edited by Jonathan Cameron to increase code reuse
> > Message-Id: <20240523174651.1089554-3-nifan.cxl@gmail.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/cxl/cxl_device.h |  2 ++
> >  hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ccc4611875..a5f8e25020 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -301,6 +301,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
> >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >                                    DeviceState *d, size_t payload_max);
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > +                          size_t payload_max);
> >  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> >                              size_t len_in, uint8_t *pl_in,
> >                              size_t *len_out, uint8_t *pl_out,
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 2c9f50f0f9..4bcd727f4c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1424,9 +1424,9 @@ static void bg_timercb(void *opaque)
> >      }
> >  }
> >  
> > -void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > +static void cxl_rebuild_cel(CXLCCI *cci)
> >  {
> > -    cci->payload_max = payload_max;
> > +    cci->cel_size = 0; /* Reset for a fresh build */
> >      for (int set = 0; set < 256; set++) {
> >          for (int cmd = 0; cmd < 256; cmd++) {
> >              if (cci->cxl_cmd_set[set][cmd].handler) {
> > @@ -1440,6 +1440,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >              }
> >          }
> >      }
> > +}
> > +
> > +void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > +{
> > +    cci->payload_max = payload_max;
> > +    cxl_rebuild_cel(cci);
> > +
> >      cci->bg.complete_pct = 0;
> >      cci->bg.starttime = 0;
> >      cci->bg.runtime = 0;
> > @@ -1458,6 +1465,14 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
> >      }
> >  }
> >  
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > +                                 size_t payload_max)
> > +{
> > +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;  
> 
> Line too long.

Hi Michael,

Your resolution with MAX() on your tree looks good to me.

Thanks for fixing up and sorry we've been such a pain!

Jonathan


