Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4289CCCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEs4m-0004KZ-0W; Fri, 31 Oct 2025 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vEs4j-0004If-VU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vEs4a-0003my-LS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761928428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBKs0esqqTv1uc5XTpxVcDMbOQB83MOv3W85sbTD8bc=;
 b=iz/uBIz0ZH3mjAGzJxwlXaecO7Iaa0CVdHs1DvBiSKmuL25G9ycA+vMOYUHaUOffMQV5t7
 +7GY+9CEj1CdNfaYDRqw5iHuH9MOyCvC0xkDMwZVl43fgJK8saQ1QK+gi0wWHXWfvp0uPO
 I8zQARvJNt8rnyjbEql0zea1Ds1W2iQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-w9QHYfunOey3tlmnZGtMXg-1; Fri,
 31 Oct 2025 12:33:45 -0400
X-MC-Unique: w9QHYfunOey3tlmnZGtMXg-1
X-Mimecast-MFC-AGG-ID: w9QHYfunOey3tlmnZGtMXg_1761928424
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 123B6180066C; Fri, 31 Oct 2025 16:33:44 +0000 (UTC)
Received: from localhost (unknown [10.44.34.94])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 455CB1955BE3; Fri, 31 Oct 2025 16:33:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Vikram
 Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [RFC 1/2] linux-headers: add virtio_can.h
In-Reply-To: <CADSE00Kt673u5OngA+teDO3fKcc-uBOoFKyF==U0zv1JDqC4wA@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251031155617.1223248-1-mvaralar@redhat.com>
 <CADSE00Kt673u5OngA+teDO3fKcc-uBOoFKyF==U0zv1JDqC4wA@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 31 Oct 2025 17:33:39 +0100
Message-ID: <87seezrpy4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 31 2025, Albert Esteve <aesteve@redhat.com> wrote:

> On Fri, Oct 31, 2025 at 5:00=E2=80=AFPM Matias Ezequiel Vara Larsen
> <mvaralar@redhat.com> wrote:
>>
>> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>> ---
>> Note that virtio_can.h is not merged yet and it is part of the series
>> https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/
>
> Hi Matias,
>
> As far as I know, standard-headers must be updated with
> `./scripts/update-linux-headers.sh`, so unless exceptions can be it'll
> have to wait until the kernel patch is merged for this to be accepted.

It's fine to have it as a placeholder patch for review (this series is
marked as RFC anyway) -- I'd recommend to put "Placeholder for headers
update, do not merge" more prominently in there, though.


