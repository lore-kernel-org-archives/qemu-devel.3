Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDD606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S7LY9VVr;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oeselNRa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTDwp-0000ev-9Z; Tue, 17 Nov 2026 02:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xTDwj-0000ea-KX
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xTDwh-0008KP-Ps
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794901777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5IVbIIbYnMNhIJwRFxcxOI7b6ywZbXnYivPXhzjsYU=;
 b=S7LY9VVr4brcDPFUT5hhuBs2u98QdpFXOnhsqDBwLGAmOH9T+WN4cMcruNIdhmHwDfckpP
 oinqCLOT14oMjszCHqUfcSTSQZRstFZGIJC63waT7GH0B3b9rfnYc0LWjWlGBi4kor0ryr
 PHHjI+YxKp3JbNtE4F3Qn1evOzU/gu0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-N2yztqUoMhGJbhxYFzz-og-1; Tue, 17 Nov 2026 02:49:36 -0500
X-MC-Unique: N2yztqUoMhGJbhxYFzz-og-1
X-Mimecast-MFC-AGG-ID: N2yztqUoMhGJbhxYFzz-og_1794901776
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-920f8fe046aso16924066d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794901776; cv=none;
 d=google.com; s=arc-20260327;
 b=dC7URI9VfmJVOW/5MAaUHeCNSQJCLamNFMVTHYB9x1uE4LdLEsBwNumb/wCuB2t+SO
 IhlrxXkgbExUe89AIRDNr5YOUQM4zsM9hCHWktHJNMh9ho9NKhOiPRGYtsBQ6c2V0uAq
 UEHl6vM/xcq8+ggRkOCfZI3Dw8btevMeN6khn/w65OW5bJ5hQi5je+n2RYSPX+uB2bn6
 iJ0b4oVT4UWYi7IfBObd/ztBfUmwK4cjHWzge3cFcslBzuz6SCs1ixMYkL6Kl+yqEkY1
 Kgkd9lnmkePsEd+T9XdKSztfHwYSZgNkAPKJVVi77VXutdRJ7Fch2KNmy08714ONzH7x
 1gIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N5IVbIIbYnMNhIJwRFxcxOI7b6ywZbXnYivPXhzjsYU=;
 fh=E/WoE03FZ2fO74I2gCwb7KIzNvpT2pS+OMG9TQxLGs4=;
 b=ZagewkZATCIW8Su3KhkI9O3KsM5sECH1EgNMfJMt/0NKsr1jy0KAEu9635y1QLsS0c
 LngjyJoYgbmWMiYXYkjlbyiM9SZpCYWsj9kLH2D18yPTESYde+J5UP+3jF8zPf8UOqzy
 zAEnCqe2+YfVhA22Fyx2Z4ywRgmPEkE/IkDIMO/keCXbhzppHjOiC0U7Mycbd8ODeMmR
 evvZb/63M+mBp37xugsNBRtII/jwqB6R6Yjs3Sli6B37EFL0F2P0An7Rih7Ei1ayEUuW
 6bo0zjEn1xtr2K77jgjmLP3TXBEbqJppuUkYwFvYokWZWvIHPUbeBkRpwghcO9RlwNRf
 iD0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794901776; x=1795506576; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N5IVbIIbYnMNhIJwRFxcxOI7b6ywZbXnYivPXhzjsYU=;
 b=oeselNRaJaEb+T+OAIErFCgYmBvALECBw3gI9RM9u/1EJccZYkzAdTAFuhQ/fIGGvB
 swGM34kH8+fFPA5Bs43rRUnT+t7JFl6FIb7V8upr0N+RwrS2zBlTdy38pzD4eQsAzN6B
 6R9y8DORB7RcnxyX/WWd4n6f2fg6PpPGVOAjsKsKz2L+CZXpAMJpMiE0lcz7ZaTzzd8/
 RTdu+GVqIbKMbVugxTsgy626TVZ9+dMcyn0yPG2r5PvU3pjmWJ1KMlGpBJz4RFTEI21j
 afHz7Amoz7SjDULvABLnQKLalU6Cw5DkAQf/tNCXLBTzcm8Dq+J+tRG5LHTC7WAqG0dN
 senA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794901776; x=1795506576;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5IVbIIbYnMNhIJwRFxcxOI7b6ywZbXnYivPXhzjsYU=;
 b=keO+Wq8xGUOZew7yXvNGKEsy8JwKE/oiGci+QAorcJjM7tN3KoApz3SdNF4VF5PQO4
 KKj6On/aatOunbjkz+MUrvrzuGy8OAGjrdRCJAt2FBvgOlFJPYBQrmQO+bBbv5sG5lBj
 XFLCHYhUdF3xuoLOTRyTVHDtUgyjvINCQ0hkm94o4vc40482WdxYEIygf/uLHJufo8Rb
 mmWYeIVOnKGZx+z/BwdfeaiSCSC7K5F0Lr6ZS9D0+sCm3C/kQiTW4HmS0aybo+n/EpJ4
 7TxGnCIlEuURDECulr4D2iqVAS/05ejZBmToZJQuJFuW/HOrm0JxASk6ymE7hSQIW+gd
 znMA==
X-Forwarded-Encrypted: i=1;
 AL+hErHt4g9hagFqHFLn1HUpvAckQhgy4kujiAiHrNK4fH1MKArx9CPYpFbSMMe0A1UlYljWnPamXyG7qERY@nongnu.org
X-Gm-Message-State: APuU4Z/LogLowhMLpvIrcNp2AT/0bacdvzq/PR3Ls43nLLyLpl9DEzmY
 YqYTwNUGIOifro2588tGSC2Deus02/KytydLFYCa+bdM8vanaqKNc+/qm/dGez+WIQWMYqHRqlI
 vecGSsHeMQr753B23OA8EjCHvw82cEMu9n7H1V5ccfjDp4Bk3bn9WYyXOJJp3bDXm9OSsmJOKo2
 3lyHE8D1ZDSdRKwj5j3TLwHvgF8MuFpkE=
X-Gm-Gg: AZFdTZeZmpe6e/ODZ/Dk6bxqZzUN1hlYAtdAeIFCUBoM/PtIE6WoiH94AnEXESl9boD
 qTMbiUle1Wh9n3dwgq22IHYmjFKfbYEBLUSgw3Y+hgxee7WwdA03+7UBiFlaq7F3TCAVQsIqfBN
 pCDtnhwVjdIOakZe8tzY4ql/PluIWy1IYlzeWxW4YNTvczBMQBQCse2UkscgDX9SXpMXN2vd6cQ
 fl+j+O6eS0vOX+bwDnOCVRhdqLYMeoInwU1k7ZDKyeeslccvtKq2rhj7ueljD1NqYf5uo8YB0ZH
X-Received: by 2002:a05:6214:3d0e:b0:921:19a:e124 with SMTP id
 6a1803df08f44-921019ae3f1mr16832726d6.36.1794901775479; 
 Mon, 16 Nov 2026 23:49:35 -0800 (PST)
X-Received: by 2002:a05:6214:3d0e:b0:921:19a:e124 with SMTP id
 6a1803df08f44-921019ae3f1mr16832396d6.36.1794901774868; Mon, 16 Nov 2026
 23:49:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116161608.1145725-1-eashurov@redhat.com>
 <20261116161608.1145725-2-eashurov@redhat.com>
 <87eccklznp.fsf@pond.sub.org>
In-Reply-To: <87eccklznp.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Nov 2026 09:49:22 +0200
X-Gm-Features: Aa3M54o1zn4gmdC8qohVv7J4DWLNJ1osJ9zjViZkBl_RACy9p41titY3ukYRyfk
Message-ID: <CAPMcbCoO_axhKym4TU=t0MqEBzMawWzDR1SEYfpykwo1crkWUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] qga: Add guest-get-driver-packages command for
 Windows
To: Markus Armbruster <armbru@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, 
 dholler@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com, 
 kramdoss@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b2b50606607422dc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b2b50606607422dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:50=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Elizabeth Ashurov <eashurov@redhat.com> writes:
>
> > Add a new guest-get-driver-packages command that returns out-of-box
> > driver packages from the Windows Driver Store, enumerated via the
> > DISM API (DismGetDrivers).  Each entry includes the published INF
> > name, original INF name, version, and provider.
> >
> > Load DismApi.dll dynamically with LoadLibraryExW so that its absence
> > does not prevent qemu-ga from starting.  Initialize DISM lazily once
> > per QGA process and open a separate online DISM session for each
> > command invocation, with process cleanup registered through
> > ga_command_state_add.
> >
> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>
> [...]
>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 8cd0ba048b..081c99bc74 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1590,6 +1590,37 @@
> >    'returns': ['GuestDeviceInfo'],
> >    'if': 'CONFIG_WIN32' }
> >
> > +##
> > +# @GuestDriverPackage:
> > +#
> > +# An out-of-box driver package installed in the guest.
>
> Excuse my ignorance: what's an "out-of-box driver package"?  Is this
> established Windows terminology, or something you made up?
>

Inbox drivers and Out-of-Box drivers are MSFT terminology.
Inbox - preinstalled in Windows, built-in
Out-of-Box - OEM, Vendors drivers that should be installed manually


>
> Please use the revised syntax for introductions:
>
>    ##
>    # @GuestDriverPackage:
>    #     An out-of-box driver package installed in the guest.
>
> Same below.
>
> > +#
> > +# @name: published INF name
> > +#
> > +# @original-name: base name of the original INF file
> > +#
> > +# @version: four-part version from the package INF DriverVer entry
> > +#
> > +# @vendor: package provider from the INF metadata
> > +#
> > +# Since: 11.2
>
> 12.0
>
> Same below.
>
> > +##
> > +{ 'struct': 'GuestDriverPackage',
> > +  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
> > +            '*vendor': 'str' },
> > +  'if': 'CONFIG_WIN32' }
> > +
> > +##
> > +# @guest-get-driver-packages:
> > +#
> > +# Retrieve out-of-box driver packages installed in the guest.
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'command': 'guest-get-driver-packages',
> > +  'returns': ['GuestDriverPackage'],
> > +  'if': 'CONFIG_WIN32' }
> > +
> >  ##
> >  # @GuestAuthorizedKeys:
> >  #
>
>

--000000000000b2b50606607422dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 17,=
 2026 at 8:50=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@=
redhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add a new guest-get-driver-packages command that returns out-of-box<br=
>
&gt; driver packages from the Windows Driver Store, enumerated via the<br>
&gt; DISM API (DismGetDrivers).=C2=A0 Each entry includes the published INF=
<br>
&gt; name, original INF name, version, and provider.<br>
&gt;<br>
&gt; Load DismApi.dll dynamically with LoadLibraryExW so that its absence<b=
r>
&gt; does not prevent qemu-ga from starting.=C2=A0 Initialize DISM lazily o=
nce<br>
&gt; per QGA process and open a separate online DISM session for each<br>
&gt; command invocation, with process cleanup registered through<br>
&gt; ga_command_state_add.<br>
&gt;<br>
&gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index 8cd0ba048b..081c99bc74 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1590,6 +1590,37 @@<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @GuestDriverPackage:<br>
&gt; +#<br>
&gt; +# An out-of-box driver package installed in the guest.<br>
<br>
Excuse my ignorance: what&#39;s an &quot;out-of-box driver package&quot;?=
=C2=A0 Is this<br>
established Windows terminology, or something you made up?<br></blockquote>=
<div><br></div><div>Inbox drivers and Out-of-Box drivers are MSFT=C2=A0term=
inology.</div><div>Inbox - preinstalled in Windows, built-in</div><div>Out-=
of-Box - OEM, Vendors drivers that should be installed manually</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Please use the revised syntax for introductions:<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @GuestDriverPackage:<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0An out-of-box driver package installed in=
 the guest.<br>
<br>
Same below.<br>
<br>
&gt; +#<br>
&gt; +# @name: published INF name<br>
&gt; +#<br>
&gt; +# @original-name: base name of the original INF file<br>
&gt; +#<br>
&gt; +# @version: four-part version from the package INF DriverVer entry<br=
>
&gt; +#<br>
&gt; +# @vendor: package provider from the INF metadata<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
<br>
12.0<br>
<br>
Same below.<br>
<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDriverPackage&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*origina=
l-name&#39;: &#39;str&#39;, &#39;version&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vendor&#39;: &#39;str=
&#39; },<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-get-driver-packages:<br>
&gt; +#<br>
&gt; +# Retrieve out-of-box driver packages installed in the guest.<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-get-driver-packages&#39;,<br>
&gt; +=C2=A0 &#39;returns&#39;: [&#39;GuestDriverPackage&#39;],<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @GuestAuthorizedKeys:<br>
&gt;=C2=A0 #<br>
<br>
</blockquote></div></div>

--000000000000b2b50606607422dc--


