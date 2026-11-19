Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF95606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=pz3oeyyh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3KE-0003IB-NE; Thu, 19 Nov 2026 09:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xU3K9-0003Hs-RQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:41:18 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xU3K6-0002od-W3
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795099265; bh=0JCqk5XdcQIwi0WGARunjGJvz7dUBLEW0UxnpcWwPX8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pz3oeyyhTnR/ulApWfomtRdyy2DnmIBs1WU2bmnAbz69HkHbizqV7DauLISS14PuF
 Lohd3ICaklDj/MlipHX8xDsQMW/IaRLSfPXqbXMpVJvW7CLjZ40OZgXKhk3qE6+vfg
 r+78Tmb84cvbMBPS65rQGXDW0LfWzhqJh1zbv1SU=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 121CD20188;
 Thu, 19 Nov 2026 15:41:05 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8566421E6A04; Thu, 19 Nov 2026 15:41:11 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: Why device-list-properties?
In-Reply-To: <66383708-4218-48d2-a634-3c4c3e21174e@redhat.com> ("Michal
 =?utf-8?B?UHLDrXZvem7DrWsiJ3M=?= message of "Thu, 19 Nov 2026 11:38:30
 +0100")
References: <87a4n5ch94.fsf@pond.sub.org>
 <66383708-4218-48d2-a634-3c4c3e21174e@redhat.com>
Date: Thu, 19 Nov 2026 15:41:11 +0100
Message-ID: <87zev4anp4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michal Pr=C3=ADvozn=C3=ADk <mprivozn@redhat.com> writes:

> On 11/19/26 10:17, Markus Armbruster wrote:
>> As far as I can tell, device-list-properties can do nothing you can't do
>> with qom-list-properties.
>>=20
>> Both take a QOM type name.
>>=20
>> device-list-properties rejects types that aren't concrete subtypes of
>> "device".
>>=20
>> device-list-properties filters out properties named "type", "realized",
>> "hotpluggable", "hotplugged", and "parent_bus".  These are precisely the
>> properties every device inherits from "device".
>>=20
>> Why is that useful?
>
> I think it's only by inertia (from libvirt's POV). I mean,
> device-list-properties was introduced to libvirt in 2012
> (v1.0.0-rc1~216) and qom-list-properties in 2018 (v4.4.0-rc1~209). Are
> you looking at obsoleting the former? If so, libvirt should adapt.

I indeed wonder whether we could deprecate device-list-properties in
favor of qom-list-properties.

