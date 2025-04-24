Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C8C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tiH-0006FN-Jj; Thu, 24 Apr 2025 06:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7thz-0006CP-Pk
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:21:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7thv-0006Nd-Ds
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:21:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjsN73zNyz6M4Ph;
 Thu, 24 Apr 2025 18:17:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 234A414025A;
 Thu, 24 Apr 2025 18:21:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:21:18 +0200
Date: Thu, 24 Apr 2025 11:21:16 +0100
To: Anisa Su <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <20250424112116.000024d0@huawei.com>
In-Reply-To: <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
 <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 31 Mar 2025 19:38:45 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 16:31:29 +0000
> > anisa.su887@gmail.com wrote:
> >   
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > --- a/hw/cxl/i2c_mctp_cxl.c
> > > +++ b/hw/cxl/i2c_mctp_cxl.c
> > > @@ -46,6 +46,9 @@
> > >  /* Implementation choice - may make this configurable */
> > >  #define MCTP_CXL_MAILBOX_BYTES 512
> > >  
> > > +/* Supported FMAPI Cmds */
> > > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > > +
> > >  typedef struct CXLMCTPMessage {
> > >      /*
> > >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> > >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> > >                msg->command_set < 0x51) &&
> > >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > > +              msg->command_set >= 0x51 &&
> > > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {  
> > 
> > Hmm. There is a visibility problem here we should address but probably not
> > by introducing a new define.  Maybe we should move the enum from
> > cxl-mailbox-utils.c in a precursor patch.
> > 
> > Jonathan  
> Thanks for the feedback and review Jonathan.
> 
> According to the comment above this condition, "Any command forming part
> of the CXL FM-API command set... is valid only with the CXL Fabric
> Manager API over MCTP binding (DSP0234)."
> 
> From my understanding, this check is to ensure that any message
> sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI
> binding and all other commands (opcode < 0x51) are are sent with the
> MCTP_MT_CXL_TYPE3 binding.

Yes. That is the intent. Why the spec requires this distinction is a long
story we won't go into here...


> 
> Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes
> that commands from sets 0x57-0x59 are prohibited from being implemented
> in the MCTP CCI, would it be more correct to change the condition for
> FMAPI commands  to msg->command_set < 0x59? Then if/when commands from sets
> 0x57-0x59 are implemented, if they are implemented according to the spec, they
> should not be added to the FM MCTP CCI.

Agreed. For this check, if we are changing it we should update it to
incorporate the additional FM_API commands so < 0x59 to include the
various CXL fabrics things that have been added.

> 
> Please correct my understanding if this is incorrect.
> 
> Regarding the visibility problem, I intend to move the enum defining all the
> opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox.h
> in i2c_mctp_cxl.c
Ok.  I was going to suggest a separate header to avoid info about mailboxes
that wasn't relevant bleeding over into this mctp bridge device but that
header has very little in it so we should be fine. We can reorganizing things
in some future set if that header gains lots of other stuff.

Thanks

Jonathan

> 
> Let me know if that is what you intended.
> 
> Other than that, I have removed the extraneous TO-DO's from the other
> patches and plan to send out v2 with relevant corrections soon.
> Hopefully that makes the remaining patches easier for you to review.
> 
> Thanks,
> Anisa
> 
>  
> > 
> >   
> > >              buf->rc = CXL_MBOX_UNSUPPORTED;
> > >              st24_le_p(buf->pl_length, len_out);
> > >              s->len = s->pos;  
> >   


