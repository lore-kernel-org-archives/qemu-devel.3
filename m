Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF71FED9EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2XOB-0008U7-Ni; Tue, 17 Mar 2026 12:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2XO7-0008Qe-Ky
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2XO1-0007dI-IR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773765314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=plkYlmQ7+sEper3SloduPAkwrHkE7lcrEKLBKp6zLnA=;
 b=gJnq31MOlWXyf69gDo3jdAlw9E/8kUDtbNHadRJd/LKo05boZvHWe2xMTXNNZMd3akU1q4
 Vm6HtLPDgwspStYwxW8QTIW0lzKcZSQpwmfBh34qEjGRPqe840M4XrjDI0DqrfZv20NJIX
 td17jbKLnn3EcOW4vlRCBfw9zLyvUr4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Pk8eqH-xNNq_1jmzRM--9w-1; Tue, 17 Mar 2026 12:35:12 -0400
X-MC-Unique: Pk8eqH-xNNq_1jmzRM--9w-1
X-Mimecast-MFC-AGG-ID: Pk8eqH-xNNq_1jmzRM--9w_1773765312
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50917996cfaso33666451cf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 09:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773765312; cv=none;
 d=google.com; s=arc-20240605;
 b=Ny4rxgv20oVk/gQKYrb6yOcKKq8nLbdOgIJbISCgpDI0Yb2TBRQ+1znW/6lVtwC5VQ
 qig2uWcQbEDbGUVYjjFgzhLEp9SBLdQ3HrNQhymsbLqRsjEY5JwqC54Ac6NEwgZInzZa
 x5unD3sZ6Jhqat6SLfT8mCuHVylFmF37vXU6oRL6fFc0nL8jPMXz3DfI+Aj20TW09ktY
 BNEB6LRrNADShHS5yVsLBs5/3vT8V5J787CNeRW34y3Wn/RumjP3/XNYT0bErFEs5fHH
 vZIk4n5AmXsJR1GHCLZZhq3KuPyA8LmuKDmThHxqI8t0VUNV6mRLOds2H5CmfNF9oB+7
 S3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=plkYlmQ7+sEper3SloduPAkwrHkE7lcrEKLBKp6zLnA=;
 fh=dI3bjQR/rBr2AGInAlG0vlomRl3+h/PHXWflVo4NjHY=;
 b=MW5VvrTuoRuqq0mHDCUev9vJvsCQT/uBnsSnuq435P5UTmniW0/4dRDF8vUZKjRPhl
 Z3hCVm3N7ixu0hh9tzbufaMx3pWMMbxvHOXuhjn/rQBz9alCogQ6dB1WGQ8MQNRLpmhm
 xkDsCIRETgs20dglJdNtP4LTueJ8/6hBhmRsYij7jqiqkJEOhiirlJgIxTvX+exYqsuK
 Xy0VTUTEGH7U1qHXomTK+9lb2KyN+7w4Fu2cOxOjqppB94OwoTR9nfcXQm/ohmT0CAcJ
 zG4PwybNQtxW0p9ZcMsUehVN3i2pHYCZAhNuyfC9gKVJ8qiMeKh5rBX0jmjVY/w1tmUT
 JWQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773765312; x=1774370112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=plkYlmQ7+sEper3SloduPAkwrHkE7lcrEKLBKp6zLnA=;
 b=Nfe9dY2fGowpcshVDLQ1RkByii92c/LJOieg713r04Wrwt/O3dXYKRL9HIXeGWq1xq
 dN5aHPWfMLKezttqCNUryevmTANsgKWJSGo1A4dFGLUpTMTJ5nx7HS6eWAKfAYONWSF0
 CXyV8QN2UzmQiZyEj/Eiv59VStWgpHj7BHwJKYefPGcSfTlRVW/MsvUZ0RG73a19nDng
 6Ex6GQGNcEWtuDM+dD7TbovWcHHEgJrPKTOsV3K1CJa9ZpMhMbXdFTyMQfCLsAtePpYN
 cMGYKmn8ND1NT+2dIj2mWPLdBQUsAKSRQiTCJUBd+cK40kTXMfYmdF2dSgB3P1ikRaFL
 qEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773765312; x=1774370112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plkYlmQ7+sEper3SloduPAkwrHkE7lcrEKLBKp6zLnA=;
 b=HwqJFnfUG4/IzyTuB0Lgyw/g5wYtZDDZa0993n1VxWQCO1zjAFJEJ0l1Wr+I3Y6eeF
 8vPT4Ib6jEdMIiAatPOlyOil1p/sKgDtH2KuAlM2kujLdmcKYfUPBURmJDIIcwYWDlK8
 ksfjyayKk4vU0f1MeaxkFinke5hYpwHo/pmDID5Czb14jb2svfhFddB40oi38+yw3zoR
 9g11iaBnZuHv1DWQRLfwL58YnYs7Bi5i0MyhA5GCP7hz9qn7IeVMv95n+A6E45QCECya
 x1AcoOFVvpH2tUvcELykJmbFNiCw/Kk+50CtXi8DViyNcsEtHKXE6zzwLDb5/ME1xkX5
 UwLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiOjBZ3vZbmdvYH5m8xmyYOAAVbA9KTG5mEFAUS9JDBYbTl3DdJ4SSyIAIOxjJPm3D1m2bZ6Izxht+@nongnu.org
X-Gm-Message-State: AOJu0Yzg/NbeOSJxGbmDfqgjPBOpwAVF5KCfx54cg6UOmzTVuTj5/ywm
 C/kWNLsFro/rZ98gTm3WSbIkIcYVogUPLkBzncRV2zWmQ0uYsNNoVTFmGaY8H4nY3afrqKaW6qM
 ZR4Axo0MmuuXKll/JVOR23yX4p+teyU2ed837ykfURulzd1ijFfd+i8fZDjNNfZRxcExp5l9Ulr
 YFxeWh9IMBcCJLE8EFm1DNb0nEgJeA36g=
X-Gm-Gg: ATEYQzxLF531+XMpe+WM0STTqJ2//XIREfVtEVbOoiwvT7cERVZcfXP1Uoub/k8fxGx
 u2OG2VpDK2sX02vOyZhtqthR3MgwiUu00dUuHs6skSQ3Jfxhn7Hrrl5+j5srhp1ZWVQy7MutSBx
 VOlr/zVQm4jnlqc/qpDUIGyipvoKXUIaLIbP9y0kfBrcSnf9EbukYhKCAziXA/tL4xMdn2LOl+u
 nEP/aKL
X-Received: by 2002:a05:622a:1991:b0:509:2414:6f79 with SMTP id
 d75a77b69052e-50957c9dcfemr241156051cf.2.1773765312103; 
 Tue, 17 Mar 2026 09:35:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1991:b0:509:2414:6f79 with SMTP id
 d75a77b69052e-50957c9dcfemr241155521cf.2.1773765311516; Tue, 17 Mar 2026
 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260316123144.1758888-1-eashurov@redhat.com>
 <CAPMcbCr1XmSnHG_KUvDekU=OzKWhuD7=PjHcxB6VmCYrZCqY4Q@mail.gmail.com>
 <ablh_gd57v3vGP6m@redhat.com>
 <CAPMcbCoEL-a_TxCaJO7y7mkPNGR9us-N8mHTQRM=iGiJxTek+w@mail.gmail.com>
 <ablsEcXwDIPlMzZb@redhat.com>
In-Reply-To: <ablsEcXwDIPlMzZb@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 18:35:00 +0200
X-Gm-Features: AaiRm539-_MQsx5tYRWHb81LIlJtGuSyeQlUPeimDub5WZwQOgGdCZcbk9zsTKA
Message-ID: <CAPMcbCohY6Oy8xp7iwf_ftzu_LD-PzPw9_HarXBAhE0J9CFjRQ@mail.gmail.com>
Subject: Re: [PATCH v1] qga: add guest-get-windows-security-info command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004ee2c2064d3aebf1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000004ee2c2064d3aebf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Mar 17, 2026 at 04:45:20PM +0200, Kostiantyn Kostiuk wrote:
> > On Tue, Mar 17, 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrote:
> > > > On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov <
> eashurov@redhat.com>
> > > > wrote:
> > > >
> > > > > Add a new Windows-only QGA command to retrieve Windows security
> > > > > features status including VBS, Secure Boot, and TPM information
> > > > > from the guest.
> > > > >
> > > > > The implementation queries Win32_DeviceGuard and Win32_Tpm via
> > > > > WMI, and reads the SecureBoot UEFI variable through
> > > > > GetFirmwareEnvironmentVariable().
> > > > >
> > > > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > > > ---
> > > > >  qga/commands-win32.c | 404
> +++++++++++++++++++++++++++++++++++++++++++
> > > > >  qga/qapi-schema.json |  56 ++++++
> > > > >  2 files changed, 460 insertions(+)
> > >
> > > snip
> > >
> > > > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > > > index c57bc9a02f..f54fdf942f 100644
> > > > > --- a/qga/qapi-schema.json
> > > > > +++ b/qga/qapi-schema.json
> > > > > @@ -1952,3 +1952,59 @@
> > > > >    'returns': ['GuestNetworkRoute'],
> > > > >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> > > > >  }
> > > > > +
> > > > > +##
> > > > > +# @GuestWindowsSecurityInfo:
> > > > > +#
> > > > > +# Windows security features status.
> > > > > +#
> > > > > +# @vbs-status: VirtualizationBasedSecurityStatus
> > > > > +#
> > > > > +# @available-security-properties: AvailableSecurityProperties
> > > > > +#
> > > > > +# @code-integrity-policy-enforcement-status:
> > > > > +#     CodeIntegrityPolicyEnforcementStatus
> > > > > +#
> > > > > +# @required-security-properties: RequiredSecurityProperties
> > > > > +#
> > > > > +# @security-services-configured: SecurityServicesConfigured
> > > > > +#
> > > > > +# @security-services-running: SecurityServicesRunning
> > > > > +#
> > > > > +# @usr-cfg-code-integrity-policy-enforcement-status:
> > > > > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> > > > > +#
> > > > > +# @secure-boot: Whether UEFI Secure Boot is enabled
> > > > > +#
> > > > > +# @tpm-present: Whether a TPM device is present
> > > > > +#
> > > > > +# @tpm-version: TPM specification version string (e.g. "2.0")
> > > > > +#
> > > > > +# Since: 10.3
> > > > > +##
> > > > > +{ 'struct': 'GuestWindowsSecurityInfo',
> > > > > +  'data': {
> > > > > +      'vbs-status': 'int',
> > > > > +      '*available-security-properties': ['int'],
> > > > > +      '*code-integrity-policy-enforcement-status': 'int',
> > > > > +      '*required-security-properties': ['int'],
> > > > > +      '*security-services-configured': ['int'],
> > > > > +      '*security-services-running': ['int'],
> > > > > +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int'=
,
> > > > > +      'secure-boot': 'bool',
> > > > > +      'tpm-present': 'bool',
> > > > > +      '*tpm-version': 'str' },
> > > > > +  'if': 'CONFIG_WIN32' }
> > > > >
> > > > >
> > > > Let's make this more generic
> > > > command guest-get-security-info
> > > > use 'union' to describe OS specific option like VBS
> > > > { 'tmp_present': false, 'secure_boot': true, 'os': { 'type':
> 'windows',
> > > > 'vbs': false, .... } }
> > > >
> > > > make tmp_present, secure_boot, vbs_status optiononal
> > > > missing =3D unknown - as we can have it unimplemented for some
> POSIX/BSD
> > > OSes
> > > >
> > > > vbs_status is Win10+ only feature, so it can be unknown for Win8
> > >
> > > I wonder if a new command is justifiable / needed.
> > >
> > > Should we consider returning more info with 'guest-get-osinfo' ? It
> > > is slightly different from the info returned there currently, but
> > > at the same time reasonably in scope in the sense that it is
> > > essentially reporting a set of OS "feature flags". They happen to
> > > be security related in this case, but we could have other feature
> > > flags we want to report too in future.
> > >
> >
> > guest-get-security-info can fail due to WMI issue. If we merge this int=
o
> > guest-get-osinfo,
> > it means guest-get-osinfo will fail just because of a Windows component
> > error. Sounds bad.
>
> In what scenarios would WMI fail, and should we treat that as non-fatal
> regardless ? ie indicate that the information is unavailable - that
> already appears to be done for the TPM feature, but not the other
> security features.
>

Simple WMI fail - disable WMI service
From my experience - WMI DB was broken after 3rd-party software
installation / after Windows Update

>should we treat that as non-fatal regardless ?

I am open to discussion.


> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000004ee2c2064d3aebf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue, Mar 17, 2026 at 4:58=E2=80=AFPM Daniel P.=
 Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Tue, Mar 17, 2026 at 04:45:20PM +0200, Kostiantyn Kostiuk wrote:<br>
&gt; On Tue, Mar 17, 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov &l=
t;<a href=3D"mailto:eashurov@redhat.com" target=3D"_blank">eashurov@redhat.=
com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Add a new Windows-only QGA command to retrieve Windows =
security<br>
&gt; &gt; &gt; &gt; features status including VBS, Secure Boot, and TPM inf=
ormation<br>
&gt; &gt; &gt; &gt; from the guest.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The implementation queries Win32_DeviceGuard and Win32_=
Tpm via<br>
&gt; &gt; &gt; &gt; WMI, and reads the SecureBoot UEFI variable through<br>
&gt; &gt; &gt; &gt; GetFirmwareEnvironmentVariable().<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:=
eashurov@redhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 qga/commands-win32.c | 404 ++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 qga/qapi-schema.json |=C2=A0 56 ++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 2 files changed, 460 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; snip<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.jso=
n<br>
&gt; &gt; &gt; &gt; index c57bc9a02f..f54fdf942f 100644<br>
&gt; &gt; &gt; &gt; --- a/qga/qapi-schema.json<br>
&gt; &gt; &gt; &gt; +++ b/qga/qapi-schema.json<br>
&gt; &gt; &gt; &gt; @@ -1952,3 +1952,59 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute=
&#39;],<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_WIN32&#39;] }<br>
&gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +##<br>
&gt; &gt; &gt; &gt; +# @GuestWindowsSecurityInfo:<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# Windows security features status.<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @vbs-status: VirtualizationBasedSecurityStatus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @available-security-properties: AvailableSecurityPro=
perties<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @code-integrity-policy-enforcement-status:<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0CodeIntegrityPolicyEnforcementSta=
tus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @required-security-properties: RequiredSecurityPrope=
rties<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @security-services-configured: SecurityServicesConfi=
gured<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @security-services-running: SecurityServicesRunning<=
br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @usr-cfg-code-integrity-policy-enforcement-status:<b=
r>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0UsermodeCodeIntegrityPolicyEnforc=
ementStatus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @secure-boot: Whether UEFI Secure Boot is enabled<br=
>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @tpm-present: Whether a TPM device is present<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @tpm-version: TPM specification version string (e.g.=
 &quot;2.0&quot;)<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# Since: 10.3<br>
&gt; &gt; &gt; &gt; +##<br>
&gt; &gt; &gt; &gt; +{ &#39;struct&#39;: &#39;GuestWindowsSecurityInfo&#39;=
,<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;vbs-status&#39;: &#39;int&#3=
9;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*available-security-properti=
es&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*code-integrity-policy-enfor=
cement-status&#39;: &#39;int&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*required-security-propertie=
s&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-configure=
d&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-running&#=
39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*usr-cfg-code-integrity-poli=
cy-enforcement-status&#39;: &#39;int&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;secure-boot&#39;: &#39;bool&=
#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;tpm-present&#39;: &#39;bool&=
#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-version&#39;: &#39;str&=
#39; },<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; Let&#39;s make this more generic<br>
&gt; &gt; &gt; command guest-get-security-info<br>
&gt; &gt; &gt; use &#39;union&#39; to describe OS specific option like VBS<=
br>
&gt; &gt; &gt; { &#39;tmp_present&#39;: false, &#39;secure_boot&#39;: true,=
 &#39;os&#39;: { &#39;type&#39;: &#39;windows&#39;,<br>
&gt; &gt; &gt; &#39;vbs&#39;: false, .... } }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; make tmp_present, secure_boot, vbs_status optiononal<br>
&gt; &gt; &gt; missing =3D unknown - as we can have it unimplemented for so=
me POSIX/BSD<br>
&gt; &gt; OSes<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; vbs_status is Win10+ only feature, so it can be unknown for =
Win8<br>
&gt; &gt;<br>
&gt; &gt; I wonder if a new command is justifiable / needed.<br>
&gt; &gt;<br>
&gt; &gt; Should we consider returning more info with &#39;guest-get-osinfo=
&#39; ? It<br>
&gt; &gt; is slightly different from the info returned there currently, but=
<br>
&gt; &gt; at the same time reasonably in scope in the sense that it is<br>
&gt; &gt; essentially reporting a set of OS &quot;feature flags&quot;. They=
 happen to<br>
&gt; &gt; be security related in this case, but we could have other feature=
<br>
&gt; &gt; flags we want to report too in future.<br>
&gt; &gt;<br>
&gt; <br>
&gt; guest-get-security-info can fail due to WMI issue. If we merge this in=
to<br>
&gt; guest-get-osinfo,<br>
&gt; it means guest-get-osinfo will fail just because of a Windows componen=
t<br>
&gt; error. Sounds bad.<br>
<br>
In what scenarios would WMI fail, and should we treat that as non-fatal<br>
regardless ? ie indicate that the information is unavailable - that<br>
already appears to be done for the TPM feature, but not the other<br>
security features.<br></blockquote><div><br></div><div>Simple WMI fail - di=
sable WMI service<br></div><div>From my experience - WMI DB was broken afte=
r 3rd-party software installation / after Windows Update<br><br>&gt;should =
we treat that as non-fatal=C2=A0regardless ?</div><div><br></div><div>I am =
open to discussion.=C2=A0</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--0000000000004ee2c2064d3aebf1--


