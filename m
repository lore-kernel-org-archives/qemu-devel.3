Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E94C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxB4-0003y0-Vx; Wed, 20 Mar 2024 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmxB3-0003rm-EM
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:44:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmxAy-0002zL-N8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:44:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4146af3ebc8so6058905e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710945859; x=1711550659; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fmq+TBCrlythQqBzbYVWcdHpSQXtVA9jNsLlyjGlw/E=;
 b=G1aEmkwKIBJ3XYwCNwi1tgTgsRWNNh3WnH8jxUanLB78pxTkxVfq9xc68YBQtXe2y1
 OWentu+jci4MbiS1BHogqFUEfuksNQpvnHHoo93ygzbn0TJTeo85+/gDFrmVeioxgHir
 rL5VUzKHdplk0zuZb/dPrxcm2hn6fvVV2fNnlR9uhxBST4U+Os4cdFyF7WRs5AP2Nvsn
 NFddTNC3/iVia/hFyfqCUaTff3OgC/+DJ1nWbbc8KIDY+AMxXdYP09xMeF+yjcUvIVYa
 kt4dCUsQgJ1oY6VGeMVTd8M9uVq332ciB8e4tiWba5lILurh4O9TJQ/GZodMJFjCBisN
 JkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945859; x=1711550659;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fmq+TBCrlythQqBzbYVWcdHpSQXtVA9jNsLlyjGlw/E=;
 b=ofy1aCvm4UD1OfPh6/Api6Gsllk1PCdlovXBWZcXLlH+P0xXJyomHwewOHrRfEZQ7m
 uXgfqDvmCtGGPmm/qsMt3lhS4BTsXz2a6dgTjpNxMqbzVutu7Jfhes4ruGgMcOpamhrp
 FCMtGLTWurGBYta5DHSNnAwU4NSxnZzWeexuXYYWZy/EOT8eSqknE3z+pYSyb6Wnw/Ef
 s/wA4YT3fMnJ36GzTdNqQ/mVsdTXGBxNRQZ6e82/aJnipsHL3h6tFeLnlkMq+qahhchP
 k7Lp0DO28JJ6HJo20AnTOMNnuFNAE8SrE1jBSVkQtRytm1fA9mdRyNJ8qs33ZRNX2ZJ7
 YNeQ==
X-Gm-Message-State: AOJu0YwYxElzIb3hBdL9r/ut5ovJpvmNnlp1fZMP23jh6gqHh+JCjVHn
 H4AaBbkzZduyrn2bAYdwXSfDDbcYKgmzoUF1w0m9kNunkfhonPruw/PXreKaLXs=
X-Google-Smtp-Source: AGHT+IGbTE7kYvLeocpsjNBvoABsd189t7StRoS1NK2D1Bd00UqdryNUpCbuOu4yZMIEgD4SJxVZIQ==
X-Received: by 2002:a05:600c:4fce:b0:413:2e2b:bad2 with SMTP id
 o14-20020a05600c4fce00b004132e2bbad2mr14658048wmq.5.1710945858708; 
 Wed, 20 Mar 2024 07:44:18 -0700 (PDT)
Received: from [192.168.7.120]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a05600c4e0200b004140837a0d4sm2461628wmq.3.2024.03.20.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:44:18 -0700 (PDT)
Message-ID: <e68e95c67048c732f15d54f7bd75732c749072f9.camel@suse.com>
Subject: Re: [PATCH 2/9] backends/confidential-guest-support: Add IGVM file
 parameter
From: Roy Hopkins <roy.hopkins@suse.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel
 <jroedel@suse.com>
Date: Wed, 20 Mar 2024 14:44:17 +0000
In-Reply-To: <4ayfzr7mwmb2smh5jdwnimasmvazmozeo7kn7x2oojaqreijjn@myyxobx4rml4>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <26c2bb5f2de41471dde304223cd943215d3183c5.1709044754.git.roy.hopkins@suse.com>
 <4ayfzr7mwmb2smh5jdwnimasmvazmozeo7kn7x2oojaqreijjn@myyxobx4rml4>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::332;
 envelope-from=roy.hopkins@suse.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2024-03-19 at 16:10 +0100, Stefano Garzarella wrote:
> On Tue, Feb 27, 2024 at 02:50:08PM +0000, Roy Hopkins wrote:
> > In order to add support for parsing IGVM files for secure virtual
> > machines, a the path to an IGVM file needs to be specified as
> > part of the guest configuration. It makes sense to add this to
> > the ConfidentialGuestSupport object as this is common to all secure
> > virtual machines that potentially could support IGVM based
> > configuration.
> >=20
> > This patch allows the filename to be configured via the QEMU
> > object model in preparation for subsequent patches that will read and
> > parse the IGVM file.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > backends/confidential-guest-support.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++=
+++++++++++++++++
> > include/exec/confidential-guest-support.h |=C2=A0 9 +++++++++
> > qapi/qom.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++++++++
> > qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++-
> > 4 files changed, 50 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/backends/confidential-guest-support.c b/backends/confident=
ial-
> > guest-support.c
> > index 052fde8db0..da436fb736 100644
> > --- a/backends/confidential-guest-support.c
> > +++ b/backends/confidential-guest-support.c
> > @@ -20,8 +20,29 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport=
,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CONFIDENTIAL_GUEST_SUPPORT,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 OBJECT)
> >=20
> > +#if defined(CONFIG_IGVM)
> > +static char *get_igvm(Object *obj, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0 ConfidentialGuestSupport *cgs =3D CONFIDENTIAL_GUES=
T_SUPPORT(obj);
> > +=C2=A0=C2=A0=C2=A0 return g_strdup(cgs->igvm_filename);
> > +}
> > +
> > +static void set_igvm(Object *obj, const char *value, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0 ConfidentialGuestSupport *cgs =3D CONFIDENTIAL_GUES=
T_SUPPORT(obj);
> > +=C2=A0=C2=A0=C2=A0 g_free(cgs->igvm_filename);
> > +=C2=A0=C2=A0=C2=A0 cgs->igvm_filename =3D g_strdup(value);
> > +}
> > +#endif
> > +
> > static void confidential_guest_support_class_init(ObjectClass *oc, void
> > *data)
> > {
> > +#if defined(CONFIG_IGVM)
> > +=C2=A0=C2=A0=C2=A0 object_class_property_add_str(oc, "igvm-file",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_igvm, set_igvm);
> > +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "igvm-fil=
e",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Set the IGVM filename to u=
se");
> > +#endif
> > }
> >=20
> > static void confidential_guest_support_init(Object *obj)
> > diff --git a/include/exec/confidential-guest-support.h
> > b/include/exec/confidential-guest-support.h
> > index ba2dd4b5df..b08ad8de4d 100644
> > --- a/include/exec/confidential-guest-support.h
> > +++ b/include/exec/confidential-guest-support.h
> > @@ -51,6 +51,15 @@ struct ConfidentialGuestSupport {
> > =C2=A0=C2=A0=C2=A0=C2=A0 * so 'ready' is not set, we'll abort.
> > =C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0 bool ready;
> > +
> > +#if defined(CONFIG_IGVM)
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * igvm_filename: Optional filename that speci=
fies a file that contains
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the configuration of the g=
uest in Isolated Guest
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Virtual Machine (IGVM) for=
mat.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 char *igvm_filename;
> > +#endif
> > };
> >=20
> > typedef struct ConfidentialGuestSupportClass {
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 2a6e49365a..570bdd7d55 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -859,6 +859,18 @@
> > =C2=A0 'base': 'RngProperties',
> > =C2=A0 'data': { '*filename': 'str' } }
> >=20
> > +##
> > +# @ConfidentialGuestProperties:
> > +#
> > +# Properties common to objects that are derivatives of confidential-gu=
est-
> > support.
> > +#
> > +# @igvm-file: IGVM file to use to configure guest (default: none)
> > +#
> > +# Since: 8.2
>=20
> Should it be 9.0 or maybe 9.1 ?

Good question. Obviously it is hard to predict which version this will
potentially land in. I can update it to 9.1 because it is unlikely to be in=
 any
version prior to this, but what is the normal convention for choosing a ver=
sion
number here?
>=20
> > +##
> > +{ 'struct': 'ConfidentialGuestProperties',
> > +=C2=A0 'data': { '*igvm-file': 'str' } }
> > +
> > ##
> > # @SevGuestProperties:
> > #
> > @@ -886,6 +898,7 @@
> > # Since: 2.12
> > ##
> > { 'struct': 'SevGuestProperties',
> > +=C2=A0 'base': 'ConfidentialGuestProperties',
> > =C2=A0 'data': { '*sev-device': 'str',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*dh=
-cert-file': 'str',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*se=
ssion-file': 'str',
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 9be1e5817c..49d9226e35 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -5640,7 +5640,7 @@ SRST
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object secret,id=3Dsec0,keyid=3Dsecmaster0,for=
mat=3Dbase64,\\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=3D$SECRET,iv=3D$(<=
iv.b64)
> >=20
> > -=C2=A0=C2=A0=C2=A0 ``-object sev-guest,id=3Did,cbitpos=3Dcbitpos,reduc=
ed-phys-bits=3Dval,[sev-
> > device=3Dstring,policy=3Dpolicy,handle=3Dhandle,dh-cert-file=3Dfile,ses=
sion-
> > file=3Dfile,kernel-hashes=3Don|off]``
> > +=C2=A0=C2=A0=C2=A0 ``-object sev-guest,id=3Did,cbitpos=3Dcbitpos,reduc=
ed-phys-bits=3Dval,[sev-
> > device=3Dstring,policy=3Dpolicy,handle=3Dhandle,dh-cert-file=3Dfile,ses=
sion-
> > file=3Dfile,kernel-hashes=3Don|off,igvm-file=3Dfile]``
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Create a Secure Encrypted Vi=
rtualization (SEV) guest object,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which can be used to provide=
 the guest memory encryption support
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on AMD processors.
> > @@ -5684,6 +5684,12 @@ SRST
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline to a designated gues=
t firmware page for measured Linux
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot with -kernel. The defau=
lt is off. (Since 6.2)
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ``igvm-file`` is an opt=
ional parameter that, when specified,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allows an Independent Guest=
 Virtual Machine (IGVM) file to be
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specified that configures t=
he secure virtual machine and can
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include, for example, an SV=
SM module, system firmware, initial
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot state, etc.
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e.g to launch a SEV guest
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. parsed-literal::
> > --=20
> > 2.43.0
> >=20
> >=20
>=20


