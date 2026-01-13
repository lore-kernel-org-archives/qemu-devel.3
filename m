Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C003D2F347
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfiWe-0005sP-8S; Tue, 13 Jan 2026 12:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfiUm-0005QY-CQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:47:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfiUi-0004QX-Hf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:47:56 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drGsf4tW6zHnGh7;
 Wed, 14 Jan 2026 01:47:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 12E9B40086;
 Wed, 14 Jan 2026 01:47:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 17:47:36 +0000
Date: Tue, 13 Jan 2026 17:47:35 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 2/5] hw/cxl/events: Update for rev3.2 common
 event record format
Message-ID: <20260113174735.00002934@huawei.com>
In-Reply-To: <87ldi3f2m2.fsf@pond.sub.org>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
 <20260102151512.460766-3-Jonathan.Cameron@huawei.com>
 <87ldi3f2m2.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 12 Jan 2026 13:16:05 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>=20
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> > format has updated with optional Maintenance Operation Subclass,
> > LD ID and ID of the device head information.
> >
> > Add updates for the above optional parameters in the related
> > CXL events reporting and in the QMP commands to inject CXL events.
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Markus,
Thanks for taking a look!

> > ---
> >  qapi/cxl.json               | 20 ++++++++---
> >  include/hw/cxl/cxl_device.h |  7 +++-
> >  include/hw/cxl/cxl_events.h | 15 ++++++--
> >  hw/cxl/cxl-events.c         |  3 +-
> >  hw/cxl/cxl-mailbox-utils.c  |  3 +-
> >  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
> >  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
> >  7 files changed, 121 insertions(+), 21 deletions(-)
> >
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index d5b86159f1..b3c2ac9575 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -33,20 +33,32 @@
> >  ##
> >  # @CXLCommonEventBase:
> >  #
> > -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> > -# Table 8-42 Common Event Record Format).
> > +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
> > +# Table 8-55 Common Event Record Format).
> >  #
> >  # @path: CXL type 3 device canonical QOM path
> >  #
> >  # @log: event log to add the event to
> >  #
> > -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> > +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
> >  #     Record Format, Event Record Flags for subfield definitions.
> >  #
> > +# @maint-op-class: Maintenance operation class the device requests to
> > +#     initiate.
> > +#
> > +# @maint-op-subclass: Maintenance operation subclass the device
> > +#     requests to initiate.
> > +#
> > +# @ld-id: LD ID of LD from where the event originated. =20

Logical Device.  I'll spell it out the first time. From the glossary:
"LD: Logical Device. Entity that represents a CXL Endpoint that is bound to
a VCS.  An SLD contains one LD. An MLD contains multiple LDs."

So what does that actually mean?  It's a number that identifies the
bit of a device that is presented to a given host at a particular
point in the PCI topology that we are faking from the underlying CXL
one.=20

I think best I can do is just spell out the acronyms. If people
want more they need to look at the spec :(

Time for a deeper explanation that probably no one ever wanted :)

=46rom a physical topology point of view think of something like:

vPPDs are virtual downstream ports that assign an LD ID.

	HOST 0           HOST 1               Host 3
	  |                 |                   |
         RP                RP                  RP
          |                 |                   |
          |                 |                   |
        __|_________________|______             |
       |  |   SWITCH        |      |            |
       | _|_____       _____|_     |            |
       ||       |     |       |    |            |
       ||       |     |       |    |            |
       |vPPD0  vPPD1 VPPD2   VPPD3 |            |
       ||       |     |          | |            |
       ||_____________|          | |            |
       |           |             | |            |
       |___________DSP0________DSP1|            |
                     |           |              |
                     |       Some other dev     |
              Traffic tagged                    |=20
              with an LD_ID associated with     |
              a given vPPD (so 2 tags here)     |
                     |                          |
     ________________|__________________________|______
    | (CXL Device) HEAD0                     HEAD1     |
    |           Now splits up based         Only one LD|
    |           on LD_ID                               |
    |__________________________________________________|


Hosts see:
Used letters for down stream port numbers to avoid
any explicit mapping to the physical ports above.


          HOST 0                  Host 1             Host3  =20
            |                       |                  |
           RP                       RP                RP
            |                       |                  |
    ________|_________     _________|_________         |
   |        |         |   |         |         |        |
   |    ____|____     |   |   ______|______   |        |
   |   |         |    |   |  |             |  |        |
   |__DSPA______DSPB__|   |__DSPA________DSPB_|        |
       |          |           |            |           |
    ___|______  Nothing  _____|_____      Other dev ___|______
   |CXL Type3 |          |CXL Type3 |              |CXL Type3 |
   | (H0, LD0)|          | (H0, LD1)|              | (H1, LD0)|
   |__________|          |__________|              |__________|

These IDs should only be reported for events that are isolated=20
(as appropriate) to a head and/or LD and as you can see the hosts
don't actually know these IDs even exist hence there is no need to
report them via in band path.  If they don't take the values
that reflect the LD we are actually talking to, then we are
reporting someone else's error! Via out of band / switch CCI we
see the top diagram where we definitely need LD_ID and HEAD_ID
to make any sense of errors, particularly as the memory addresses
in the records are specific to Head/LD pair.
=20
The recommendation of the spec is don't set them for simple reporting
over inband mailboxes. Now you might think we don't have out of band
support upstream yet (my staging CXL tree does have both MCTP over
I2C and USB) but we do have the switch CCI and that can tunnel to
out of band interfaces (technically it's over PCI Vendor defined
messages but in practice it ends up the same from a 'what can I talk
to' point of view as something truely out of band like an I2C bus.
We don't actually have event queues on those yet though... When
we do we'll want this command to queue events there as well as on
for inband path.

So we are adding them now for 2 reasons.
1) The spec allows it even for boring inband event reporting
   (recommendation only to not do so) so we need to check the kernel stack
   reports correctly.
2) We will want to add event queues on the out of band interfaces and
   for those we'll need these IDs.

>=20
> What's an LD?
>=20
> > +#
> > +# @head-id: ID of the device head from where the event originated. =20
>=20
> Are these identifiers taken from the CXL spec?
Yes. Though feels odd to reference the glossary for the definitions.
>=20
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'struct': 'CXLCommonEventBase',
> > -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> > +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> > +            '*ld-id':'uint16', '*head-id':'uint8' } }
> > =20
> >  ##
> >  # @CXLGeneralMediaEvent: =20
>=20
> [...]
>=20
>=20


