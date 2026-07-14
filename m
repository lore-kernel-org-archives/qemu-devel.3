Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BECEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 05:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjVUR-0002en-59; Tue, 14 Jul 2026 01:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjVUQ-0002dT-BJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 01:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjVUO-0002tp-Il
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 01:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784006127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KoFq14fT7BCMR69Zuaewg+XxkOiEOTTPatg7TmvdgrY=;
 b=gkSu8Aimphr0Al9MidtkmqkpxmrKFUnJ/4z5SyXMTIrBfaylqg1oXzv5M/7hVsItz95ZdJ
 GVDVyzkUWo2akElhdal+UHXL4uaDAV6LNnrLnZn5F6YwwvZeEl3C02+BRZbj6FSRbV0EBr
 jNvM4VZnynJ/5YnNGkfTsAcYmwzQR6U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-Sfo1W6IxMnS4uuKKW5ZFEQ-1; Tue,
 14 Jul 2026 01:15:22 -0400
X-MC-Unique: Sfo1W6IxMnS4uuKKW5ZFEQ-1
X-Mimecast-MFC-AGG-ID: Sfo1W6IxMnS4uuKKW5ZFEQ_1784006121
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8E21800473; Tue, 14 Jul 2026 05:15:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 505E71686; Tue, 14 Jul 2026 05:15:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF1D921E6920; Tue, 14 Jul 2026 07:15:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alistair <alistair@alistair23.me>
Cc: Conor Dooley <conor@kernel.org>,  qemu-devel@nongnu.org,
 alistair23@gmail.com,  qemu-riscv@nongnu.org,
 bin.meng@processmission.com,  mzamazal@redhat.com,  mst@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
In-Reply-To: <14e03e0ad01262333268b51efc512ae8d97d95f2.camel@alistair23.me>
 (alistair@alistair23.me's message of "Mon, 13 Jul 2026 09:46:39
 +1000")
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
 <20260712-divided-cork-204b87d9651a@spud>
 <14e03e0ad01262333268b51efc512ae8d97d95f2.camel@alistair23.me>
Date: Tue, 14 Jul 2026 07:15:17 +0200
Message-ID: <878q7ecftm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Alistair <alistair@alistair23.me> writes:

> On Sun, 2026-07-12 at 22:47 +0100, Conor Dooley wrote:
>> On Fri, Jul 10, 2026 at 01:43:04PM +0200, Markus Armbruster wrote:
>> > Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
>> > maintainers, 2025-01-28) removed the only M:, but left S:
>> > Supported.
>> > This makes no sense.=C2=A0 Downgrade to S: Orphan.
>> >=20
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> > =C2=A0MAINTAINERS | 2 +-
>> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 576ef6fff5..aa2df9cbe3 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
>> > =C2=A0
>> > =C2=A0Microchip PolarFire SoC Icicle Kit
>> > =C2=A0L: qemu-riscv@nongnu.org
>> > -S: Supported
>> > +S: Orphan
>>=20
>> This should have been updated in:
>> https://lore.kernel.org/qemu-devel/20260513023859.518484-1-alistair.fran=
cis@wdc.com/
>>=20
>> Alistair said he applied that patch, so I'm guessing whatever tree
>> you've
>> based on doesn't include it yet?
>
> Yeah, I thought I applied it. But somehow it seems to have
> disappeared....
>
>
> I think this patch should be dropped and I'll actually apply:
> https://lore.kernel.org/qemu-devel/20260513023859.518484-1-alistair.franc=
is@wdc.com/

Makes sense, thanks!

> Then Bin can update this in the future if you want to.
>
> Sorry about the confusion here
>
> Alistair


