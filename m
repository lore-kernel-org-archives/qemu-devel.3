Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E6C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXO1-0001Cg-Ew; Mon, 29 Jan 2024 14:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUXNz-0001CQ-Vs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUXNy-00049A-4G
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706556817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvjp/yv9MYfjpaVuky1mjuSiNYHOhRxYQGVGB0DiLGU=;
 b=LER5kHd1YetRTdtIFyB3sZngk++qH2UZZnxnCxWJUF2LFBLd2TkafSNlIJBDc1S6KlwxLb
 m19tpx5rAQ8Lk2mGfYmvVk/kbdOD/7e5JMzcMbZJ44NvgrNQXU9KIKAyT7lSCc++Cs71o4
 GNoEkpW5IlA+1BGPkG58n2mpPlBk54g=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-kr9j9sigMkiP34foFQNnDw-1; Mon, 29 Jan 2024 14:33:35 -0500
X-MC-Unique: kr9j9sigMkiP34foFQNnDw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7cede81ecf8so1550469241.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556815; x=1707161615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvjp/yv9MYfjpaVuky1mjuSiNYHOhRxYQGVGB0DiLGU=;
 b=cWYToXtNU2wsPXMuHlLGKgcOP52/KOMfHgiT+KKiAzsQGCYeCGqiw1art/8PcnRpN6
 ifByKEjraH8GZo1i1r5EWoZmQj3Wa1Ien5FrefEiF+0c2f0msBVIB+TFs3SsqUFGEFMz
 G/+YM360Z0+M6h5N/Gipk2xI4hZZBFtwO1kWC9SO+R2rVKXvu5AJr+amjCrk1oEzeNFB
 dwne+xkx8SPtXEJIdO6vSDc9oCSf6gXp5sbj54MpVo5Adu5qhkPgyUPzGtRTdoAYUYLA
 TA3/pL5U/lHILwSbV1PICaE5P8hVGRdJHKIhn7jCCdG3+nDxbAc4cScj7v1QkAaIxzAG
 7QfQ==
X-Gm-Message-State: AOJu0YzS3l3qCVSelXaAjuEEx7LGkl90unbAu2P837q3VBky4ucdS8Rw
 up31WQYAEZap9TaBgbLVlTXf1PbGXm9K4PhSnO1XTBrx2bTh6Otb6o2o0kqazh+pOqutD1ZhxBA
 dcDbGTn1kpvtRyATtZdlQry7TGURif8EvOw9bOSfoEAr4Q1fsN4Of5ZSuMw2Hoha5izDez8dIVw
 wqOrBA03ZWcXtpjbk+u2LCKSQTS64=
X-Received: by 2002:a05:6102:1177:b0:46a:ff40:e036 with SMTP id
 k23-20020a056102117700b0046aff40e036mr3946830vsg.21.1706556815220; 
 Mon, 29 Jan 2024 11:33:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9XYJ08yUlfz2lKKVGPg7pcu9LttCivrvtq/SOT1j/EJyYGwNKTv7YcsMwvbOi01iOLVEP7ikc/r2VBuPfzkk=
X-Received: by 2002:a05:6102:1177:b0:46a:ff40:e036 with SMTP id
 k23-20020a056102117700b0046aff40e036mr3946755vsg.21.1706556813483; Mon, 29
 Jan 2024 11:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com>
 <Zbf0Fbhmg0tvMbxK@redhat.com>
In-Reply-To: <Zbf0Fbhmg0tvMbxK@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 20:33:21 +0100
Message-ID: <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 7:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > diff --git a/meson.build b/meson.build
> > index d0329966f1b4..93fc233b0891 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4015,6 +4015,11 @@ if have_tools
> >                 dependencies: [authz, crypto, io, qom, qemuutil,
> >                                libcap_ng, mpathpersist],
> >                 install: true)
> > +
> > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.=
c'),
>
> I'd suggest 'tools/x86/' since this works fine on 64-bit too

QEMU tends to use i386 in the source to mean both 32- and 64-bit.
Either is fine by me though.

> > +               dependencies: [authz, crypto, io, qom, qemuutil,
> > +                              libcap_ng, mpathpersist],
> > +               install: true)
>
> Shouldn't this executable() call be conditional though, so this
> is only built for x86 host targets.

Yes. Also should be 32- and 64-bit (careful because Meson uses 'x86' for
32-bit).


> > +static void compute_default_paths(void)
> > +{
> > +    socket_path =3D g_build_filename("/run", "qemu-vmsr-helper.sock", =
NULL);
> > +    pidfile =3D g_build_filename("/run", "qemu-vmsr-helper.pid", NULL)=
;
> > +}
>
> We shouldn't be hardcoding /run, we need to honour --prefix and
> --localstatedir args given to configure.  /var/run is a symlink
> to /run so the end result ends up the same AFAIK

Indeed; just copy from scsi/qemu-pr-helper.c.

> You never answered my question from the previous posting of this
>
> This check is merely validating the the thread ID in the message
> is a child of the process ID connected to the socket. Any process
> on the entire host can satisfy this requirement.
>
> I don't see what is limiting this to only QEMU as claimed by the
> commit message, unless you're expecting the UNIX socket permissions
> to be such that only processes under the qemu:qemu user:group pair
> can access to the socket ? That would be a libvirt based permissions
> assumption though.

Yes, this is why the systemd socket uses 600, like
contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 and
root:kvm would make sense on a Debian system), or a separate helper
can be started by libvirt.

Either way, the policy is left to the user rather than embedding it in
the provided systemd unit.

> > +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> > +                     CAP_SYS_RAWIO) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    /*
> > +     * Change user/group id, retaining the capabilities.
> > +     * Because file descriptors are passed via SCM_RIGHTS,
> > +     * we don't need supplementary groups (and in fact the helper
> > +     * can run as "nobody").
> > +     */
> > +    if (capng_change_id(uid !=3D -1 ? uid : getuid(),
> > +                        gid !=3D -1 ? gid : getgid(),
> > +                        CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING)) {
> > +        return -1;
> > +    }
>
> Does this actually work ?  IIUC, the file that requires privileges
> is /dev/cpu/%u/msr, and we're opening that fresh on every request,
> so how can this run as anything other than root ?

Agreed, the capabilities can be dropped but the uid and gid cannot.

Paolo


