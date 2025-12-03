Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82F9D12696
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjbu-0000MR-H3; Wed, 03 Dec 2025 04:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQjbq-0000Kw-OC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQjbn-0000Ii-N7
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764755833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VOpkSPncg7vJ9pqxag1v1H8QoDTXCXXMxs7qQiUB0s=;
 b=FjOGow5Fcb+NklhSOewF6AmPMjUUqJVr/jtZhzmPBGrQ5jwMoAL6gjWeHmMOUEA95lGi+A
 rRovxt98sVTryhJ9br1swNJw57zqM2x1p/HrF5bdHfN6Uz6nUEF4wj1DjkN4mLBe9TZ2E+
 /8jwNJJthWMhjgcx4Bc/efbB3nj+mhQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-0KYz-nfBPZ6JjbMz6uFlJg-1; Wed,
 03 Dec 2025 04:57:09 -0500
X-MC-Unique: 0KYz-nfBPZ6JjbMz6uFlJg-1
X-Mimecast-MFC-AGG-ID: 0KYz-nfBPZ6JjbMz6uFlJg_1764755828
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5120D1809C92; Wed,  3 Dec 2025 09:56:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0AEC30001A2; Wed,  3 Dec 2025 09:56:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CD0621E6A27; Wed, 03 Dec 2025 10:56:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org,
 pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 philmd@linaro.org
Subject: Re: [PATCH 3/3] qdev: Legacy properties are now unused, drop
In-Reply-To: <87ms5jf83d.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 22 Oct 2025 14:12:54 +0200")
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-4-armbru@redhat.com>
 <CAJ+F1C+2vp+Byp2Q40GQZUYLW0xpoTbFAj5oc2R=nbsy8i_8Eg@mail.gmail.com>
 <87ms5jf83d.fsf@pond.sub.org>
Date: Wed, 03 Dec 2025 10:56:56 +0100
Message-ID: <87h5u7q45z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> Hi
>>
>>
>> On Wed, Oct 22, 2025 at 2:15=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> I don't think we have much reasonable way to use those "legacy-*"
>> properties from qom-get and similar, so it's probably ok to just
>> remove them without deprecation.
>
> Almost all of them are unreadable via qom-get:
>
>     (qemu) qom-get /machine/unattached/device[3]/pm bus
>     "/machine/i440fx/pci.0"
>     (qemu) qom-get /machine/unattached/device[3]/pm legacy-bus
>     Error: Property 'PIIX4_PM.legacy-bus' is not readable
>
> Same for all the other properties where the qdev property doesn't have a
> .get().
>
> Only the ones with a .print() are readable, i.e. only PCI address
> properties:
>
>     (qemu) qom-get /machine/unattached/device[3]/pm addr
>     11
>     (qemu) qom-get /machine/unattached/device[3]/pm legacy-addr
>     "01.3"
>
> PATCH 2's commit message explains why.
>
> If a deprecation period is wanted, I'll replace this patch.
>
> If not, I can work the above into the commit message.

In my tree now:

    qdev: Legacy properties are now unused internally, drop

    Legacy properties are an accidental and undocumented external
    interface.  qom-set doesn't work for them (no .set() method).  qom-get
    and qom-list-get work only when the underlying qdev property has a
    .print() method, i.e. the PCI address properties, as explained in the
    previous commit.  Here's one that works:

        (qemu) qom-get /machine/unattached/device[3]/pm addr
        11
        (qemu) qom-get /machine/unattached/device[3]/pm legacy-addr
        "01.3"

    And here's one that doesn't:

        (qemu) qom-get /machine/unattached/device[3]/pm bus
        "/machine/i440fx/pci.0"
        (qemu) qom-get /machine/unattached/device[3]/pm legacy-bus
        Error: Property 'PIIX4_PM.legacy-bus' is not readable

    Actual use of this undocumented interface seems quite unlikely.  A
    deprecation period seems unnecessary.  Drop it.

>> Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks!


