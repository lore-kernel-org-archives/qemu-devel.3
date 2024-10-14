Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CCAD16240
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Iy1-0004Ck-Lm; Mon, 14 Oct 2024 07:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0Ixz-0004C8-LR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:10:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0Ixx-0000tN-73
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:10:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRvXr3C8Mz6LCln;
 Mon, 14 Oct 2024 19:05:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 773211401F4;
 Mon, 14 Oct 2024 19:10:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 13:10:15 +0200
Date: Mon, 14 Oct 2024 12:10:13 +0100
To: Fan Ni <nifan.cxl@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH -qemu] hw/cxl: Support get/set mctp response payload size
Message-ID: <20241014121013.000062c3@Huawei.com>
In-Reply-To: <Zwheg1hFMG_MYggX@fan>
References: <20241010014157.175548-1-dave@stgolabs.net> <Zwheg1hFMG_MYggX@fan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 10 Oct 2024 16:08:51 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Wed, Oct 09, 2024 at 06:41:57PM -0700, Davidlohr Bueso wrote:
> > Add Get/Set Response Message Limit commands.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> 
> The commit log may include the cxl spec reference. Otherwise,
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 68 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c2d776bc96eb..98416af794bb 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -7,6 +7,8 @@
> >   * COPYING file in the top-level directory.
> >   */
> >  
> > +#include <math.h>
> > +
> >  #include "qemu/osdep.h"
> >  #include "hw/pci/msi.h"
> >  #include "hw/pci/msix.h"
> > @@ -56,6 +58,8 @@ enum {
> >      INFOSTAT    = 0x00,
> >          #define IS_IDENTIFY   0x1
> >          #define BACKGROUND_OPERATION_STATUS    0x2
> > +        #define GET_RESPONSE_MSG_LIMIT   0x3
> > +        #define SET_RESPONSE_MSG_LIMIT   0x4
> >      EVENTS      = 0x01,
> >          #define GET_RECORDS   0x0
> >          #define CLEAR_RECORDS   0x1
> > @@ -393,7 +397,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
> >          uint16_t pcie_subsys_vid;
> >          uint16_t pcie_subsys_id;
> >          uint64_t sn;
> > -    uint8_t max_message_size;
> > +        uint8_t max_message_size;
Huh.  I wonder how that misalignment got in.

I'll spin a separate tidy up patch to deal with that and
include it in a trivial series I'm sending later today.

> >          uint8_t component_type;
> >      } QEMU_PACKED *is_identify;
> >      QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
> > @@ -422,12 +426,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
> >          is_identify->component_type = 0x3; /* Type 3 */
> >      }
> >  
> > -    /* TODO: Allow this to vary across different CCIs */
> > -    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
> > +    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
> >      *len_out = sizeof(*is_identify);
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
> > +static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint8_t rsp_limit;
> > +    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
> > +    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
> > +
> > +    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
> > +
> > +    *len_out = sizeof(*get_rsp_msg_limit);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
> > +static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint8_t rsp_limit;
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
> > +    struct {
> > +        uint8_t rsp_limit;
> > +    } QEMU_PACKED *out = (void *)payload_out;
> > +    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
> > +
> > +    if (in->rsp_limit < 8 || in->rsp_limit > 10) {

Good to document why these values - possibly using defines.
I think 8 is the minimum the spec allows, but is the 10 based on
anything specific?

I'll carry this on my gitlab staging branch but want to
tidy this up before suggesting Michael picks it up.

I'll end up splitting this up a little though as only one of
the MCTP mailboxes on that tree is not dependent on the i2c mctp
stuff that is queued up behind Klaus' series.  So I'll drag
the guts of this to near the top of my tree and include the extra
commands where that i2c_mctp is added.

hw/cxl/i2c_mctp_cxl: Initial device emulation

I'll push a new gitlab.com/jic23/qemu tree out later today with this
done.

Thanks,

Jonathan

> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    cci->payload_max = 1 << in->rsp_limit;
> > +    out->rsp_limit = in->rsp_limit;
> > +
> > +    *len_out = sizeof(*out);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
> >                                    void *private)
> >  {
> > @@ -3000,6 +3050,10 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
> >  
> >  static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
> >      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> > +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_get_response_msg_limit, 0, 0 },
> > +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_set_response_msg_limit, 1, 0 },
> >      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
> >                                0 },
> > @@ -3035,6 +3089,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
> >  
> >  static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
> >      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
> > +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_get_response_msg_limit, 0, 0 },
> > +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_set_response_msg_limit, 1, 0 },
> >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
> >                                0 },
> >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > @@ -3055,6 +3113,10 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
> >  
> >  static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
> >      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> > +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_get_response_msg_limit, 0, 0 },
> > +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> > +                                           cmd_set_response_msg_limit, 1, 0 },
> >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> >                                0, 0 },
> >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > -- 
> > 2.46.1
> >   
> 


