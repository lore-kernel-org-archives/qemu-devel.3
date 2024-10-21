Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1977D17122
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xQ5-00048K-Bl; Mon, 21 Oct 2024 14:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t2xQ3-000487-N9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:46:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t2xQ0-0004El-OM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:46:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 513B64E600E;
 Mon, 21 Oct 2024 20:46:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3Vk1A0XY2a0R; Mon, 21 Oct 2024 20:46:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD32E4E6001; Mon, 21 Oct 2024 20:46:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB334757B1C;
 Mon, 21 Oct 2024 20:46:06 +0200 (CEST)
Date: Mon, 21 Oct 2024 20:46:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_?=
 =?UTF-8?Q?=E2=80=9Cprivate=E2=80=9D_fields_in_QOM=3F?=
In-Reply-To: <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
Message-ID: <d8c34d96-8e33-db7c-a2b5-283cf531ebaf@eik.bme.hu>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1254660962-1729536366=:46091"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1254660962-1729536366=:46091
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 21 Oct 2024, Peter Maydell wrote:
> On Sat, 19 Oct 2024 at 16:54, Zhao Liu <zhao1.liu@intel.com> wrote:
>>
>> Hi maintainers and list,
>>
>> In the QOM structure, the class and object structs have two members:
>> parent_class and parent_obj, which are often marked as "< private >" in
>> the comment.
>>
>> I couldn’t find information on why to define ‘private’ and ‘public’,
>> even in the earliest QOM commits and the patch emails I could find.
>
> This is a rather old thing which I think was originally
> borrowed from glib's commenting convention.
>
> I'm fairly sure that we decided a while back that they were entirely
> unnecessary, so you don't need to add them in new code. (I can't
> actually find anything with a quick list search about that though
> so maybe I'm misremembering.)

I think the current convention was discussed around here:
https://lore.kernel.org/qemu-devel/33641fa3-f617-3151-e7ca-becaf06e2641@ilande.co.uk/
but looks like it did not make it into docs/devel/qom.rst to make it 
clear for all.

If your search found nothing on lists.gnu.org/archive maybe it has 
something to do with this message printed there:

References: [ (The index is locked for maintenance) ]

I don't know what that means but all searches seem to return the same 
currently.

Regards,
BALATON Zoltan

> Either way, there's still a lot of them floating around in the codebase
> that were added before we made that decision.
>
> thanks
> -- PMM
>
>
--3866299591-1254660962-1729536366=:46091--

