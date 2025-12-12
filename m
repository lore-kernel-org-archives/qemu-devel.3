Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853B3D4417D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU167-00058d-1m; Fri, 12 Dec 2025 06:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1vU165-00057t-At
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1vU163-0002RC-Qe
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765538042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/B1sgkaP44Ei/Kyws1LqsI2YZbu31C/KxEIUojkxYKo=;
 b=M3sEPMNEoxDON1/BgVo1Jdd960CU32movjOIXCm+jyEubLyDu0rDjkEzpNYuwRWd60XwA3
 LQomZhorrqmsBLUnAYEnAIvBgSU/6LJ9S4EvAYyhOwkgYQUPALHZE77TGB+fRCGi1YkSnq
 Joh5tmChHOK6cpi7jCQVtv1O7f2CYbU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-zmvL8oZnOmuY9gdkLxhnhg-1; Fri,
 12 Dec 2025 06:12:49 -0500
X-MC-Unique: zmvL8oZnOmuY9gdkLxhnhg-1
X-Mimecast-MFC-AGG-ID: zmvL8oZnOmuY9gdkLxhnhg_1765537968
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F2018002C0; Fri, 12 Dec 2025 11:12:47 +0000 (UTC)
Received: from fedora (unknown [10.44.34.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD5B1800451; Fri, 12 Dec 2025 11:12:44 +0000 (UTC)
Date: Fri, 12 Dec 2025 12:12:32 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>
Subject: Re: [RFC PATCH 2/9] MAINTAINERS: fix libvirt entry
Message-ID: <aTv4oIQMixqu4lyB@fedora>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <20251211180132.3186564-3-alex.bennee@linaro.org>
 <7f479d0e-1370-4574-9966-e373405ddb1f@linaro.org>
 <87tsxwt15o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yHnhE2P8MJGxm84l"
Content-Disposition: inline
In-Reply-To: <87tsxwt15o.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--yHnhE2P8MJGxm84l
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Friday in 2025, Alex Benn=E9e wrote:
>Philippe Mathieu-Daud=E9 <philmd@linaro.org> writes:
>
>> On 11/12/25 19:01, Alex Benn=E9e wrote:
>>> We have a particular tag for lists so lets use it.
>>> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>>> ---
>>>   MAINTAINERS | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 05b644cfc9b..a3fdc4ca911 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4466,7 +4466,7 @@ F: gitdm.config
>>>   F: contrib/gitdm/*
>>>     Incompatible changes
>>> -R: devel@lists.libvirt.org
>>> +L: devel@lists.libvirt.org
>>
>> Maybe keep both? See:
>
>It will still cause them to be added to the CC, like all the other L: entr=
ies.
>

Good.

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--yHnhE2P8MJGxm84l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaTv4lQAKCRAU0rOr/y4P
vJcmAQD/U+KJCT/GEsmqPxjCNvP76/dgkQ7+tnPBqMmoPh6u5QEAmyiBcHrhfJYj
CKGCWUMkv/9R7m2+9RHXsGajaSNo6QU=
=1ohF
-----END PGP SIGNATURE-----

--yHnhE2P8MJGxm84l--


