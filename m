Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E602AC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjsum-0006Zh-AZ; Wed, 15 Jul 2026 02:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjsuj-0006Yo-L7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjsuh-0007Vi-KO
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784096170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbGCDqNigyncBEwWSGou2t5T8lGpgHvgcQhLwf6cLEQ=;
 b=bdaxwCCgs9zTOg/BnOH5rD34ERlKmALIKIqEYtweHYHynEQfbMzx5tYDTX+k7Xb7iV9XI+
 RiPcNXMf7M8SasjDumYFwXF2FiQ2MvrgLUwtiE2pf2gwsNILFy/wm6JRNLuK/RGf47lNyy
 jG9mtFUxKmJl/tDmERVqeffKAKGgjmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-NUwPxI9pPSqWTUtw6YE_Xw-1; Wed,
 15 Jul 2026 02:16:06 -0400
X-MC-Unique: NUwPxI9pPSqWTUtw6YE_Xw-1
X-Mimecast-MFC-AGG-ID: NUwPxI9pPSqWTUtw6YE_Xw_1784096165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76A4C19560AD; Wed, 15 Jul 2026 06:16:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 943A118004AD; Wed, 15 Jul 2026 06:16:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E63121E6920; Wed, 15 Jul 2026 08:16:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  alistair23@gmail.com,  qemu-riscv@nongnu.org,
 bin.meng@processmission.com,  mzamazal@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
In-Reply-To: <20260714151629-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 14 Jul 2026 15:23:13 -0400")
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
 <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
 <20260713025003-mutt-send-email-mst@kernel.org>
 <650b9d5c-ca79-447c-b91d-a83d017f42a6@oss.qualcomm.com>
 <87mrvvtibg.fsf@pond.sub.org>
 <20260714151629-mutt-send-email-mst@kernel.org>
Date: Wed, 15 Jul 2026 08:16:01 +0200
Message-ID: <87ik6gixr2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Jul 13, 2026 at 10:17:07AM +0200, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>>=20
>> > On 13/7/26 08:52, Michael S. Tsirkin wrote:
>> >> On Mon, Jul 13, 2026 at 08:13:38AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>> >>> On 11/7/26 10:00, Michael S. Tsirkin wrote:
>> >>>> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
>> >>>>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
>> >>>>> device, 2023-06-28) added the section with S: Supported, but no M:.
>> >>>>> This makes no sense.  Downgrade to S: Orphan.
>> >>>>>
>> >>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >>>>
>> >>>>
>> >>>> No, this makes sense. The reason this section was added is so that =
Milan can
>> >>>> get copied on vhost-user-scmi but not other virtio stuff:
>> >>>>
>> >>>> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
>> >>>> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
>> >>>> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>> >>>> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
>> >>>> qemu-devel@nongnu.org (open list:All patches CC here)
>> >>>>
>> >>>> Pls drop this patch.
>> >>>>
>> >>>>> ---
>> >>>>>    MAINTAINERS | 2 +-
>> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>>>
>> >>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>> >>>>> index aa2df9cbe3..4d558ddee9 100644
>> >>>>> --- a/MAINTAINERS
>> >>>>> +++ b/MAINTAINERS
>> >>>>> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
>> >>>>>    vhost-user-scmi
>> >>>
>> >>> So what we want is to add here:
>> >>>
>> >>>    M: Michael S. Tsirkin <mst@redhat.com>
>> >>>    R: Stefano Garzarella <sgarzare@redhat.com>
>> >>
>> >> But these files already get M from the match against hw/virtio/ -
>> >> what am I missing?
>> >
>> > Yeah, just trying to make Markus script happy ;)
>>=20
>> Appreciate the kindness!
>>=20
>> In decreasing importance:
>>=20
>> 1. Correct get_maintainers.pl output
>
> Is anything wrong with it?

No, it looks good to me.

>> 2. Legible MAINTAINERS
>
> We can always come up with a new rule for such cases,
> where we have a reviewer just for some specific files
> in a project, but the supporters are from the bigger
> project.
>
> How about we drop S: completely in such cases?

Could that be differently confusing?  Honest question!

1. Correct get_maintainers.pl output

   Appears to be fine.  As far as I can tell, it accumulates S: for all
   matching sections.  A matching section without S: should be harmless
   as long as another matching section provides one.

   By the way, this is another reason why my patch was bad.  The S:
   Orphan gets accumulated, and can lead to problematic output, e.g.

    $ scripts/get_maintainer.pl --status -f hw/virtio/vhost-user-scmi.c=20
    Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
    "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
    Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
    qemu-devel@nongnu.org (open list:All patches CC here)
    Orphan
    Supported

2. Legible MAINTAINERS

   S: Supported is without supporters is mildly confusing unless you
   understand that the supporters are listed elsewhere.  Evidence: it
   confused me.

   No S: looks like we forgot to add it.  Feels less bad to me, but I
   might be biased.  Could it use a comment?  Not sure.

   Hmm, S: Supported could even be misleading.  Say Milan had agreed to
   look after this in his spare time.  That's status Maintained.  We'd
   use M: to record his commitment.  But what S: to use?

   S: Maintained gives M: the correct meaning, but mislead readers about
   the status of the matched files: these are still Supported.

   S: Supported is locally correct about the status of the matched
   files, but misleads about the M:.

   I think in this case we'd use M: Maintained as the lesser evil.

   The reliable way to find out status is running get_maintainers.pl.

> We can also tweak the name:
> vhost-user-scmi (part of vhost)

I guess the "vhost-" in "vhost-user-scmi" is enough of a hint.

>> 99. My script is happy.
>>=20
>> [...]


