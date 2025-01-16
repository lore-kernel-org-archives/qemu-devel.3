Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2115C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSFf-0000e1-M8; Thu, 16 Jan 2025 10:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tYSFd-0000dh-Vn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tYSFc-0008Fw-AX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737043060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvgPcGfB/6RHZuQxTauuuQGONAp82xTjpjkZKsQ7lXA=;
 b=cO2iOL1sFtAsJpWi3WgoFrNVre7DTif5zLi1hK8iuA20EW9l0dA3lpVXkRQ1eDEwsT4Yy9
 qcLnACi01ZGjFZawMTc8g53BHbwS9KeengInALmkV5SG8UUcNnuBNFqdnn6RVinnj9GCnM
 GPJ4nZC5TdTcyvuP+QxLdJo0YCydfGY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-e-COnUP8Ng6yCYzWO18nvA-1; Thu,
 16 Jan 2025 10:57:35 -0500
X-MC-Unique: e-COnUP8Ng6yCYzWO18nvA-1
X-Mimecast-MFC-AGG-ID: e-COnUP8Ng6yCYzWO18nvA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3CFC1913388; Thu, 16 Jan 2025 15:57:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.205])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5CB530001BE; Thu, 16 Jan 2025 15:57:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, paul@xen.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Hilber <quic_philber@quicinc.com>, "Mohamed
 Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v7 2/3] linux-headers: Update to Linux 6.13-rc7
In-Reply-To: <dcc0b6e46ebbd92ff2b689670731eaa8ffe43b9f.camel@infradead.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-3-dwmw2@infradead.org>
 <b486bc8d-af20-46f3-b6f5-b32cc0a54fa5@xen.org>
 <dcc0b6e46ebbd92ff2b689670731eaa8ffe43b9f.camel@infradead.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 16 Jan 2025 16:57:23 +0100
Message-ID: <87r05292fw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 16 2025, David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2025-01-16 at 15:07 +0100, Paul Durrant wrote:
>> On 16/01/2025 14:59, David Woodhouse wrote:
>> > From: David Woodhouse <dwmw@amazon.co.uk>
>> >=20
>> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>> > ---
>> > =C2=A0 include/standard-headers/linux/vmclock-abi.h | 182 ++++++++++++=
+++++++
>> > =C2=A0 linux-headers/linux/iommufd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 ++--
>> > =C2=A0 linux-headers/linux/stddef.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 =
+-
>> > =C2=A0 3 files changed, 212 insertions(+), 14 deletions(-)
>> > =C2=A0 create mode 100644 include/standard-headers/linux/vmclock-abi.h
>> >=20
>>=20
>> No functional change?
>
> Well, other than adding vmclock-abi.h. The rest is almost all in
> comments apart IIRC from the TAG thing, which shouldn't affect us as we
> don't use C++.
>
> I didn't really want to make those other changes but it seems that's
> the process we use; we have to add the new header to the list in
> update-linux-headers.sh and then have a separate commit which runs the
> script again to do a wholesale import.
>
> I suppose I could have cheated and done the import from 6.13-rc1 again,
> but the extra changes did indeed seem like there should be no
> functional change.

If the other headers are not updated by this change, they will be
updated by a later change anyway; IMHO it doesn't really matter when the
headers are updated, as long as the update is done against a specific,
released Linux version. Dragging along other random stuff is normal for
a headers update.


