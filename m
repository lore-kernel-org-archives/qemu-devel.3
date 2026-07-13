Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8BAC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBrZ-0000Fu-OO; Mon, 13 Jul 2026 04:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBqp-0000B3-Bx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBql-0000HC-48
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783930633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7+cgzFKPkYQX3yBAkydO3mKZsnuRctVg0sZJ8aNOkI=;
 b=aOJNFPFhbAa63PZBLjtDBV6xT2j/FTthgEjTT2vgaxVJ9Xf4YrS9laH0WhKvXvKn5iWgWV
 aouCx3LerSi6TOYudNhs/4Zx5EBnY57uhjdNms85XGudZ92fwbOJ6irlwlgs+odgCnP1hQ
 GglwrEnVfajxnUPFYQZnrVorz18fAZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-VlHAnnX3MxWTkaYABm_7jQ-1; Mon,
 13 Jul 2026 04:17:12 -0400
X-MC-Unique: VlHAnnX3MxWTkaYABm_7jQ-1
X-Mimecast-MFC-AGG-ID: VlHAnnX3MxWTkaYABm_7jQ_1783930631
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B7B180064A; Mon, 13 Jul 2026 08:17:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66EDF30001A1; Mon, 13 Jul 2026 08:17:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA00221E6920; Mon, 13 Jul 2026 10:17:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,
 alistair23@gmail.com,  qemu-riscv@nongnu.org,
 bin.meng@processmission.com,  mzamazal@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
In-Reply-To: <650b9d5c-ca79-447c-b91d-a83d017f42a6@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Jul 2026
 09:11:34 +0200")
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
 <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
 <20260713025003-mutt-send-email-mst@kernel.org>
 <650b9d5c-ca79-447c-b91d-a83d017f42a6@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:17:07 +0200
Message-ID: <87mrvvtibg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 13/7/26 08:52, Michael S. Tsirkin wrote:
>> On Mon, Jul 13, 2026 at 08:13:38AM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> On 11/7/26 10:00, Michael S. Tsirkin wrote:
>>>> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
>>>>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
>>>>> device, 2023-06-28) added the section with S: Supported, but no M:.
>>>>> This makes no sense.  Downgrade to S: Orphan.
>>>>>
>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>
>>>>
>>>> No, this makes sense. The reason this section was added is so that Mil=
an can
>>>> get copied on vhost-user-scmi but not other virtio stuff:
>>>>
>>>> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
>>>> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
>>>> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>>>> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>
>>>> Pls drop this patch.
>>>>
>>>>> ---
>>>>>    MAINTAINERS | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index aa2df9cbe3..4d558ddee9 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
>>>>>    vhost-user-scmi
>>>
>>> So what we want is to add here:
>>>
>>>    M: Michael S. Tsirkin <mst@redhat.com>
>>>    R: Stefano Garzarella <sgarzare@redhat.com>
>>
>> But these files already get M from the match against hw/virtio/ -
>> what am I missing?
>
> Yeah, just trying to make Markus script happy ;)

Appreciate the kindness!

In decreasing importance:

1. Correct get_maintainers.pl output

2. Legible MAINTAINERS

99. My script is happy.

[...]


