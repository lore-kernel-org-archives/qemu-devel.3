Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE961C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3sS-0000WV-9B; Tue, 11 Jun 2024 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sH3sQ-0000Un-65
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:57:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sH3sN-0003SE-RF
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:57:37 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57c714a1e24so1488222a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1718121449; x=1718726249; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd2Rpmamp36iDBTKs57xjKnW8LLsn8kRk0AsQeNZ1MA=;
 b=g7IZgwvK8Gop0h5C+P20+fXeTWh+jSOxPwopjEhbYuafhz0Qa4ZnQzRs76uN9tAIVG
 YwDhxXwHtGxcDzF9yW+EZHyVmtJlSjU/uNW/8K5dkXoBpwOEwB7ZHRZ2aQXoDhD1N0Uz
 25K6uoULE0yNxeGwhb+a+CCOtVHGDxIqMnRjtIDmX5KmfxtDROUss88rEfyT56iz5t/q
 a/z6Oy39hTQ//Mt2B5K45m6UvP0fDNWLpCmubpBDwVM3R+46zFusnmjqpF5kxLq/b9RC
 gN3C5dKg9bdQnTARJn44YVYs2matreCgsmGEMOslf2oipE56BFDEP8/yibnzyjLsmvxt
 E+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718121449; x=1718726249;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qd2Rpmamp36iDBTKs57xjKnW8LLsn8kRk0AsQeNZ1MA=;
 b=NnUw1xBEgrZP3cCFpmavJEeob57xyvOEW751F0S68iCySBe7T8PJ0YNB0wshh++64S
 tNiYV6Etxe6knb4Q8zGFgWCCFP41iFHcKg4aV7jWdl+gL/rUBIgaOvoLJQ/Fs6rrFZxH
 NehNrWTCYwbg2nqLSLy6IeexkiLh9jPJdBCMZpmGxjmc718DYfUI1nNv9T9z99aR/zoy
 a6eXfqbaoJ+/vEhvb0/9Ph9qLGW/Epx7gzidhCeLeML9uTY3HlMCgt6eykvammP0oT4n
 6zzVqPOrVVCKEMR/NBrTqhLkP1IcxZr3exPoq+j9dDXScl+aGOXfmiEwbg9Fc9FIHbhL
 k//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUflHDZ4r5L+WdJo3yfFB2unDLTr2a8RDLp+y/BmboYZxrkMw71KD00eAbIwn2ZAPKY4rW+8fmX7KK0/lvVlBbaSHIbkwo=
X-Gm-Message-State: AOJu0YwPCKZk2pJVKeRSLUpA8+1eIritWqztXs41u/xO/Tsoe3ngdNaJ
 ugrRW76wtyYOyXLYfvLArm89nZivqw5vvIXuMijB8Y2TmBQStw1sst7Fje9yef/HTR7ekNPkM9a
 X3DkRpNaFTcoSxG9OMc5RT7YzgDwjh2KykqiJaQ==
X-Google-Smtp-Source: AGHT+IHq0p1FHweEXd0wsqWJ4MFkIIAxJDShw4RNWASpw0xPbN89q+TKoFH4uzyFCg7lO/Zb0uKdN3W5awc0GC0gvsE=
X-Received: by 2002:a50:a685:0:b0:578:72d4:e3b0 with SMTP id
 4fb4d7f45d1cf-57c509a6080mr7860717a12.36.1718121449152; Tue, 11 Jun 2024
 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy6_HUjwvww9WrqeqruYRyEDwq1Tee-tm3mxaQE=w92-HA@mail.gmail.com>
 <ZN37R//1H+rDTzeS@redhat.com>
 <CAHEcVy6U3pSyMue=SZ8b_JyWurzgj5fN3Htfg8QqS_Ho16Ye4Q@mail.gmail.com>
In-Reply-To: <CAHEcVy6U3pSyMue=SZ8b_JyWurzgj5fN3Htfg8QqS_Ho16Ye4Q@mail.gmail.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Tue, 11 Jun 2024 17:57:18 +0200
Message-ID: <CAHEcVy6G5e=AiDmX66R0r=EnjB7ANDfyhqgvY+KzJ3_8FBfJ_w@mail.gmail.com>
Subject: Re: about QEMU TLS
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Jinpu Wang <jinpu.wang@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::534;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Daniel and all,

When I was using TLS encryption for VM live-migration, I noticed one
thing: the migration works regardless of the "endpoint" setting (that
is: either "endpoint=3Dserver", or "endpoint=3Dclient") on the target
server.
The line I added is:
"-object tls-creds-x509,id=3Dtls0,dir=3D/path/to/qemutls,endpoint=3Dclient
(or server),verify-peer=3Don".

It seems that currently the setting of "endpoint" is not strictly
enforced for VM migration. I'd like to know, if it's intentionally
done to allow a certain flexibility, or should be fixed from the
security perspective. Thank you very much!

Best regards,
Yu Zhang @ IONOS cloud

On Mon, Aug 21, 2023 at 4:29=E2=80=AFPM Yu Zhang <yu.zhang@ionos.com> wrote=
:
>
> Hello Daniel,
>
> sorry for my slow reply! I tested the approach you suggested by the
> following way:
>
> On the target server, start a VM in -incoming mode:
>
> qemu-7.1 \
> -uuid ${VM_UUID} \
>  ...
> -object tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=3Dserver =
\
>  ...
> -incoming defer \
> -qmp unix:${SOCK},server,nowait \
> -qmp unix:${SOCK},server,nowait &
>
> Set the migrate parameter and waiting for the incoming VM from source:
>
> echo '{"execute":"qmp_capabilities"}{ "execute":
> "migrate-set-parameters", "arguments": { "tls-creds": "tls0" }}' |
> sudo nc -U -w 1 ${SOCK}
> echo '{"execute":"qmp_capabilities"}{ "execute": "migrate",
> "arguments": { "uri": "tcp::8089" }}
>
> in HMP:
> (qemu) migrate_set_parameter tls-creds tls0
> (qemu) migrate_incoming tcp:[::]:8089
>
> On the source server, start a VM:
>
> qemu-7.1 \
> -uuid ${VM_UUID} \
>  ...
> -object tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=3Dclient =
\
>  ...
> -qmp unix:${SOCK},server,nowait \
> -qmp unix:${SOCK},server,nowait &
>
> Set the migrate parameter and migrate the VM from source to target:
>
> echo '{"execute":"qmp_capabilities"}{ "execute":
> "migrate-set-parameters", "arguments": { "tls-creds": "tls0" }}' |
> sudo nc -U -w 1 ${SOCK}
> echo '{"execute":"qmp_capabilities"}{ "execute": "migrate",
> "arguments": { "uri": "tcp:10.41.19.32:8089" }}
>
> and query the migration after a few seconds:
>
> echo '{"execute":"qmp_capabilities"}{ "execute": "query-migrate" }' |
> sudo nc -U -w 1 ${SOCK}
>
> the migrate is completed successfully.
>
> To further migrate the VM from source (the target for the previously
> migration), the endpoint must be changed from "server" to "client" by
> QMP commands:
>
> echo '{"execute":"qmp_capabilities"}{ "execute": "object-del",
> "arguments": { "id": "tls0" }}' | sudo nc -U -w 1 ${SOCK}
> echo '{"execute":"qmp_capabilities"}{ "execute": "object-add",
> "arguments": { "id": "tls0", "qom-type": "tls-creds-x509", "endpoint":
> "client", "dir": "${HOME}/qemutls", "verify-peer": false }}' | sudo nc
> -U -w 1 ${SOCK}
>
> which in HMP commands are:
>
> (qemu) object_del tls0
> (qemu) object_add tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=
=3Dclient
> (qemu) migrate_set_parameter tls-creds tls0
> (qemu) migrate tcp:10.41.16.10:8089
>
> So far as I tested, the TLS certificate must be valid for at least one
> day. Therefore, the VM migration with an expired TLS certificate can
> only be done in one day.
>
> Thank you so much for your kind reply!
> Best regards
>
> Yu Zhang @ IONOS Compute Platform
>
> On Thu, Aug 17, 2023 at 12:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >
> > On Mon, Aug 07, 2023 at 12:07:31AM +0200, Yu Zhang wrote:
> > > Hi all,
> > >
> > > According to qemu docs [1], TLS parameters are specified as an object=
 in
> > > the QEMU command line:
> > >
> > >    -object tls-creds-x509,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/=
cred/dir ...
> > >
> > > of which "endpoint" is a type of "QCryptoTLSCredsEndpoint" and can be
> > > either a "server" or a "client".
> > >
> > > I'd like to know:
> > >
> > > - When a VM is started with this config, is there a way (e.g. QMP) to
> > > change the value of "endpoint"?
> > >   If possible, how to do this? or else after the first migration of a=
 VM,
> > > the VM has "endpoint=3Dserver",
> > >   which can't be migrated without stop / start.
> >
> > Use object_del + object_add to delete the old credentials and
> > create new ones.
> >
> > > - In which case does the QEMU reload its TLS certificate, e.g. when a=
 QEMU
> > > VM has been run longer
> > >   than the valid period of its TLS certificate?
> >
> > The certs are loaded at the time the incoming/outgoing migration
> > operation is initiated, so they are always fresh.
> >
> > > - The migration is done by using HMP monitor on both source and targe=
t
> > > side. Is it possible to do it
> > >   by using QMP commands?
> >
> > Almost everything in HMP has an equivalent QMP command.
> >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
> >

