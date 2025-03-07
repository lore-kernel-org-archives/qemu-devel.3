Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB6BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWqo-0006kA-Vk; Fri, 07 Mar 2025 07:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqWqm-0006fF-HP
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqWqk-0005t3-KD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741350644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ob5LsXY4rqaHazhk50DBrrsKA2KX4HPTdbKRiCrTPu0=;
 b=cxhH/Nd6RhtjUt7ZoJeuxPHfWaRywzPPBtpeRolfbbzLBYjMcErH+mxm1DBD1Wj1cOskNy
 o04ek4J+tzT8hTghLzMqgA4nKoWu2X0buoecW4hPOwxR4S4S1n0Bu7ZKyXJVnY20V7tO4W
 K0iG5pXvl+ZcNsZ0Fa+uBJQFEe3W3ZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-oRJXLdJkOR-eZlibe1mpGg-1; Fri,
 07 Mar 2025 07:30:42 -0500
X-MC-Unique: oRJXLdJkOR-eZlibe1mpGg-1
X-Mimecast-MFC-AGG-ID: oRJXLdJkOR-eZlibe1mpGg_1741350641
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7AA0180AF68; Fri,  7 Mar 2025 12:30:41 +0000 (UTC)
Received: from localhost (unknown [10.44.34.26])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9C761955DCE; Fri,  7 Mar 2025 12:30:39 +0000 (UTC)
Date: Fri, 7 Mar 2025 13:30:38 +0100
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: New git repository for Go bindings
Message-ID: <xu3qsijvpbguwdnlj6ovomlkd2wggd76x2lvfusmczljhnmx4f@kgw6di2754ta>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osawk23o3x24zmja"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--osawk23o3x24zmja
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: New git repository for Go bindings
MIME-Version: 1.0

Hi,

I've been working on and off in having Go bindings for QEMU's
QAPI specification. The last version [0] seems to be accepted so
far but we would like not to have that in qemu.git.

In the past [1], Daniel suggested creating a repo per each
generated schema: go-qemu.git, go-qga.git, go-qsd.git

While that works well from the point of view of Go applications
and is neat organized too, afaict they are all bounded to QEMU's
release schedule so it might be enough to create a single repo
such as:

qapi-generators.git
=E2=94=94=E2=94=80=E2=94=80 golang
    =E2=94=9C=E2=94=80=E2=94=80 module.py # The go generator
    =E2=94=9C=E2=94=80=E2=94=80 qemu      # For qapi/qapi-schema.json
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 doc.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_iface_command.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_iface_event.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_alternate.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_command.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_enum.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_event.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_struct.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_union.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 go.mod
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 protocol.go
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 utils.go
    =E2=94=9C=E2=94=80=E2=94=80 qga # qga/qapi-schema.json
    =E2=94=94=E2=94=80=E2=94=80 qsd # storage-daemon/qapi/qapi-schema.json


Or perhaps a per language repo?

[0] https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg03019.html
[1] https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07024.html

Cheers,
Victor

--osawk23o3x24zmja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmfK5u4ACgkQl9kSPeN6
SE8Ujg//U4mY3Rpk3CCXcm3ZNpTMEiPqKUAA9cy2n3T3KpGPraFlVacw80pyDRnO
gZ+4P2curd8/eIZpeL+Jw3bV/m//IkW94M+vtlT39pwFLO3USJzVnfMN5mpVghu2
tyU13NXnq6dd3IuvMDZZSOEGhU2AegcttZd/D5Rh1bHh/ZelB9w1f0Nk457M/Gfu
ak1MIjWTpg6CKOeIlbxw79x0HaD/ZSASiY/TbheVRZDUJrrfqg7OhDoGFo+ROfE1
YPFxVdGJTInYE4mMnNGSebmHsREw8z24vMgMFzSQTOVesG6BZKSyYP8rhcUG9hOA
i/UEXs3Xaeb99jFA1R4ukxj/u/juhfOPNToU3zBcfZEa9chdIQrYMUf3TOQRzzki
NINhue/DnQivPSP3GHqExeUv0duMzIa0BHlTpN9dJnMWQo7WteHJAQVtCaLsrJZU
5Lkor9Qgy1bCf/RNTGei5nZa/F+zWPT1/LlQ85w1cBkuZuy+81EqbPYkZr+oQqbN
wIpl6jsmQdaRV1S1x8iHQsKVe7vB7Yq6E1mDN3/5MklTKMJ+0wFH322LS+YeiXEx
EJN3DSZiuu5+YJWBQEUfrttlo2Kc7W43Fy4C7yd/oCa0Zq/frpBlPRZP4Ncs8Jjq
VkmE5qQ4gelI3llTJuvW938Pqd54JLuaLBjZRA920c2oKJpclCw=
=idIL
-----END PGP SIGNATURE-----

--osawk23o3x24zmja--


