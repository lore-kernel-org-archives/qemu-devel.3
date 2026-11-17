Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VIPQwyJb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aWXDR86a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFr0-0001GW-3r; Tue, 17 Nov 2026 04:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTFqw-0001G9-Mc
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTFqu-00072d-NO
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794909105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfDsNP59E+DGbFUSt8JrPmYtbBI6V08U5HwKJ40uL4=;
 b=VIPQwyJb2bJzICm8TxWhhWE/kwZAVWnrKilggDu1qr7H6Ed7VuuXuxAYKFnr2MY7tqU7aa
 L8bMqtpWsCAygHBNaulb6bH7tJFqC+tYNzmoAl4udKZToZHXWco+rxI8GCEukZlzGqbv8N
 824LRaTZVHR7ZDIuE+L/amR733lU+RQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-rbhpzSj1NByqGvrQIwejXg-1; Tue, 17 Nov 2026 04:51:43 -0500
X-MC-Unique: rbhpzSj1NByqGvrQIwejXg-1
X-Mimecast-MFC-AGG-ID: rbhpzSj1NByqGvrQIwejXg_1794909102
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ab3c13806bso16767341fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794909102; cv=none;
 d=google.com; s=arc-20260327;
 b=jVvGxEDJRLRScwVulczAyCXCclG11/EZvoXTq4dTV5TAd/1Ay2JVnwmkuR/WcvHxwD
 CfxcqZ5iNltbpkd5BRsXB2B+fvPmWQjpUE1+0Z6XdHb2oNL2ky2sZEe8I8Mm0othI1Bn
 FyzgL04HON2P4MrS9e3mqgMd5LDEAAkJCPfoNp6zU95ApvF+Fd9hXaDw16ZlK1oinGQS
 OjnFRHTnZZCctNKdYqZ3wIH5XAx/lk4DTQyxMjYFwWsO5ahCIRMKmug4g8t2IsV3KJ5h
 AqBKcHp/b8WJChokCK2KrpGS8x5yWQMk+EeLZH2HGqlyfSyrN097lK/MBKRqr8ycGVG7
 IMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nYfDsNP59E+DGbFUSt8JrPmYtbBI6V08U5HwKJ40uL4=;
 fh=11UpUA1LSWV17iKazw9WH0X+uR6JzqsiXiAlS1NWwm0=;
 b=AL/VXDKn1wGrFHz4Coc5OP/gbI+MjiidP8skNgtsIwMyGzFGqVaqcxxt43cHtRinhj
 784LNTzFM6tx8gDUqaDnbdFHt9pVJhDl0ZhSNJ618fsFaUjFZSWappM0cfi1IH2qTKGk
 Z7SgF4QeublzZtI4RDwIxlbEQViaNyMvMTJ0/IdjO2CHIpuGq3PGfMGuHhdhtEKIWB9K
 BOsME/0U9L8q6QFj7MoMQyfghUTCtPGIJ+mQ/EyEoTtr/axiTMfs2JyyerumNkajWK63
 yOIpr/0/1b2suZMak7FNl1ky+dPtiHQ3hKGow2H7k87Hon6j8De6UwJimDHT8pho2z0A
 B2sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794909102; x=1795513902; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nYfDsNP59E+DGbFUSt8JrPmYtbBI6V08U5HwKJ40uL4=;
 b=aWXDR86ayUjXwtDEWDxf1R1QjHb/21zIxf+XCmviA2dF1bcdG++BaHdRx1huCACk4c
 kBfBPMMeBQATV0M6EPFVlsRXOX1uoqOQPnsed8nIKk86Uq8VKX9EYNc2QaaA9QCJSngY
 gvg3IFWEESmI53PyH0vBJoWOB7DGbI4cNUZjH0g4Q+CQM5enDUB43AXGU9wTwZWXvmo3
 NasGSsVN5bFANgEtr7QpzsNElxm/tQ+LEnbdwWwDZHrDsubZM0w3S2cT/OPbv7GCzDO2
 VQGF32+CEZ/U5z2H3VzA+6FnNf3VwIg5lxFsgzOoISElejSvziG9b0JCtBdQeZmGDzcE
 Xj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909102; x=1795513902;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nYfDsNP59E+DGbFUSt8JrPmYtbBI6V08U5HwKJ40uL4=;
 b=DOz0zvPRlyUqvNowo2WOOZu4PZRAYWoY7ijIQLnV1YbH5jDTty0Z1GcBpOJStdTm/3
 kSbKBVsrvZPg2FF+QFwYIyv1rvFMXpMb6Dpit4O4prDjFvGD54p2QHaVg9hTWBkWlenJ
 YPM7D4DZXt+9oCZonWjTUuop+hAb8KQdZSTFBrFbv7mROiaZKMO33njZoKOaFHWtq5fM
 1zlRsBb/GjRTKBC+DI36SU0P1MxdcINu1wwdqjIZIOPfh2kMCQ/7V2+3BOm7xt81iFIP
 ejf10Qw98legcSqXp5OaVLRxGWbk/xFgUVCz0q0hu/RTrmegzowLqWdGWlh+rYy9rl8d
 dbhg==
X-Forwarded-Encrypted: i=1;
 AL+hErFXn40u75L1wz3JraHwxPb2lPTPVqBaWsYEfYzIlz9If4mrcz6eD0cEZdRwc/MxpsnQVfG3RVIUCKKD@nongnu.org
X-Gm-Message-State: APuU4Z9kEazQTsperPGqQz21Vzskzb7mD18rbljl3NvjTRih5WNIBFgV
 S+6Q1bWUdHn8LXZcN1UApW/coD2uOQ+SZe4W1Bntc4NbipEnWzdu7V9A0YoP43E9kXbPFjKD+mh
 H7HDLkRyJOrkR8VHLwMOY/l4GnGpJtYgLrx8YduJ/bpfVx1TC7ZSu20AWVFxt3lAVl9atyAfEnN
 GL3w9bpZGn8YKv9t1gCWu3iZLtFHLSdDs=
X-Gm-Gg: AYBFou0Z5Xx9LiZuZ4i5FlqYJki+MgkQiDP2IxiqNOuhldYI6EfOSNYmYULxnwH6gTD
 c76wh7f5jHf2kL+n/D0J8zmQeBhuFiJb46UCU6uf8ibJBccI8gxgu4g0uf7PXzRP2LvDuZfeeR1
 bu90FzsvUJeP426UMUUSRqq7ohRMoQk5ehjarfQfMpry8iwx8DEXgg+pZwLQ==
X-Received: by 2002:a05:651c:154c:b0:3ab:1525:60ae with SMTP id
 38308e7fff4ca-3ae2b66dfe7mr37978081fa.18.1794909101839; 
 Tue, 17 Nov 2026 01:51:41 -0800 (PST)
X-Received: by 2002:a05:651c:154c:b0:3ab:1525:60ae with SMTP id
 38308e7fff4ca-3ae2b66dfe7mr37978031fa.18.1794909101453; Tue, 17 Nov 2026
 01:51:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116161608.1145725-1-eashurov@redhat.com>
 <20261116161608.1145725-2-eashurov@redhat.com>
 <87eccklznp.fsf@pond.sub.org>
 <CAPMcbCoO_axhKym4TU=t0MqEBzMawWzDR1SEYfpykwo1crkWUQ@mail.gmail.com>
In-Reply-To: <CAPMcbCoO_axhKym4TU=t0MqEBzMawWzDR1SEYfpykwo1crkWUQ@mail.gmail.com>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Tue, 17 Nov 2026 11:51:30 +0200
X-Gm-Features: AclHuK9p0I6LFRezoBlFZozUZ1XGH9_7HCU1iCysrS6hNQOu02bq6_K54i4i2jQ
Message-ID: <CAK957kE=AGaDw2L1PNxDHksERdVNcq6i3w0Ac_+q2vCm642eLg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] qga: Add guest-get-driver-packages command for
 Windows
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, 
 dholler@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com, 
 kramdoss@redhat.com
Content-Type: multipart/alternative; boundary="0000000000006585b1066075d7f4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000006585b1066075d7f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As Kostiantyn mentioned, this is indeed Microsoft terminology. I'll add a
brief explanation in v4.

Thanks for the review!

On Tue, Nov 17, 2026 at 9:49=E2=80=AFAM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

>
>
> On Tue, Nov 17, 2026 at 8:50=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
>
>> Elizabeth Ashurov <eashurov@redhat.com> writes:
>>
>> > Add a new guest-get-driver-packages command that returns out-of-box
>> > driver packages from the Windows Driver Store, enumerated via the
>> > DISM API (DismGetDrivers).  Each entry includes the published INF
>> > name, original INF name, version, and provider.
>> >
>> > Load DismApi.dll dynamically with LoadLibraryExW so that its absence
>> > does not prevent qemu-ga from starting.  Initialize DISM lazily once
>> > per QGA process and open a separate online DISM session for each
>> > command invocation, with process cleanup registered through
>> > ga_command_state_add.
>> >
>> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>>
>> [...]
>>
>> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> > index 8cd0ba048b..081c99bc74 100644
>> > --- a/qga/qapi-schema.json
>> > +++ b/qga/qapi-schema.json
>> > @@ -1590,6 +1590,37 @@
>> >    'returns': ['GuestDeviceInfo'],
>> >    'if': 'CONFIG_WIN32' }
>> >
>> > +##
>> > +# @GuestDriverPackage:
>> > +#
>> > +# An out-of-box driver package installed in the guest.
>>
>> Excuse my ignorance: what's an "out-of-box driver package"?  Is this
>> established Windows terminology, or something you made up?
>>
>
> Inbox drivers and Out-of-Box drivers are MSFT terminology.
> Inbox - preinstalled in Windows, built-in
> Out-of-Box - OEM, Vendors drivers that should be installed manually
>
>
>>
>> Please use the revised syntax for introductions:
>>
>>    ##
>>    # @GuestDriverPackage:
>>    #     An out-of-box driver package installed in the guest.
>>
>> Same below.
>>
>> > +#
>> > +# @name: published INF name
>> > +#
>> > +# @original-name: base name of the original INF file
>> > +#
>> > +# @version: four-part version from the package INF DriverVer entry
>> > +#
>> > +# @vendor: package provider from the INF metadata
>> > +#
>> > +# Since: 11.2
>>
>> 12.0
>>
>> Same below.
>>
>> > +##
>> > +{ 'struct': 'GuestDriverPackage',
>> > +  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
>> > +            '*vendor': 'str' },
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> > +##
>> > +# @guest-get-driver-packages:
>> > +#
>> > +# Retrieve out-of-box driver packages installed in the guest.
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'command': 'guest-get-driver-packages',
>> > +  'returns': ['GuestDriverPackage'],
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> >  ##
>> >  # @GuestAuthorizedKeys:
>> >  #
>>
>>

--0000000000006585b1066075d7f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>As Kostiantyn mentioned, this is indeed Microsoft termi=
nology. I&#39;ll add a brief explanation in v4.</p><p>Thanks for the review=
!</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Nov 17, 2026 at 9:49=E2=80=AFAM Kostiant=
yn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 17, 2026 at 8:50=E2=80=AFAM=
 Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blan=
k">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt; writes:<br>
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
</blockquote></div>

--0000000000006585b1066075d7f4--


