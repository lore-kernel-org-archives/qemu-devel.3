Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C80C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBmX-0000Ac-0R; Fri, 12 Jul 2024 04:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBmS-0008T8-Ug
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBmQ-0007zv-R6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+ZDgzhszmal6LsuAs5HfC46PYu4+F9HFndS4+iBkO0=;
 b=haLqKToCqhHUClVbPMb5Sb76GUBOQhoOGZMFG07xxMm1zi+RFbkIwNVUeY6SSl27MHvygq
 GOYGRkXw6OWAnnottTlovWiGjMuPs1M9yN4eIYeeMU1UsVPeuHTpM0bWhBn/N9LWE0Kez7
 dbuVcvuNIM24j1qcgBAHoPuu4Zf7iXw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-yNBeIja1O0iTQD-t4R5oHA-1; Fri, 12 Jul 2024 04:37:22 -0400
X-MC-Unique: yNBeIja1O0iTQD-t4R5oHA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-651a0aa7463so30070497b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773442; x=1721378242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+ZDgzhszmal6LsuAs5HfC46PYu4+F9HFndS4+iBkO0=;
 b=GEfPbWH10bg9NqSQYwMNd4SnkDhFvvwBCGAVXwW/+xXick5loQTVVBEfCgD8i1biut
 T3KmzfIeEzbxvMYnZux3hRXQ7iiEl3TVZkOc2UO2ElvI1CJhIV+sc5qRLHbq+BAmDMP4
 gVQlcEMUEqwb6IMLrh+MveCm0+Y1K83HDqOG4B8HBozgOXH7HtFrWH+pOquC24SoQwrV
 ngdN6RR2K24ZcVzLvfAztdsTokqb2V/53VwQ/dKeOwmsrhzYe2nFt7pmF24M6i31s39t
 mpjRik5Zz2uBaUdXMCLLpxti5hLqfuWVZJ4bzlbMwDENl2OYRHmIRiFbOfxNtERKsBVY
 bwUg==
X-Gm-Message-State: AOJu0YyB7auX0NbyjKA9ZohfTwatu7AHp5KeHgd13E1GGC+bRarMCHHI
 XgiRs3fsh0wxRV0Xcf1D6IiH+3eD6h9hrRvalkR2018v3yRM14MQWp08Z0TfV0BatAezLLZoH9o
 oGve9AXIxEBWbYc3FRMd485Xb8Z45AZjHreBiejEvRat3VO+PI0f9saynyEOrheP+7vq8141sNP
 VeA017HpPYXVqJcAYFzTvtURd+Aw4=
X-Received: by 2002:a05:690c:e05:b0:64b:2cf2:391c with SMTP id
 00721157ae682-658eed5e9abmr134558547b3.18.1720773441834; 
 Fri, 12 Jul 2024 01:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7fb/vfWfpOYyW12G4gfKMIbLRCZ4lLZeMzwmxJktBuFVUZR3OBA0rCVB34LjV69L+N9mZlZ1IyGCRLvMROM=
X-Received: by 2002:a05:690c:e05:b0:64b:2cf2:391c with SMTP id
 00721157ae682-658eed5e9abmr134558387b3.18.1720773441603; Fri, 12 Jul 2024
 01:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-7-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-7-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:37:10 +0300
Message-ID: <CAPMcbCqiQub1HjKEdL1e-BE4A1cKbELr3Na-b2cofu0xNb3EHw@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] qga: conditionalize schema for commands only
 supported on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9df65061d08c930"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b9df65061d08c930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on non-Windows.
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
>
>     {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
>
> to
>
>     {"class": "CommandNotFound", "desc": "The command FOO has not been
> found"}
>
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-posix.c |  9 ---------
>  qga/qapi-schema.json | 15 ++++++++++-----
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 838dc3cf98..b7f96aa005 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1207,8 +1207,6 @@ GList *ga_command_init_blockedrpcs(GList
> *blockedrpcs)
>      blockedrpcs =3D g_list_append(blockedrpcs, g_strdup("guest-fstrim"))=
;
>  #endif
>
> -    blockedrpcs =3D g_list_append(blockedrpcs,
> g_strdup("guest-get-devices"));
> -
>      return blockedrpcs;
>  }
>
> @@ -1419,13 +1417,6 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>      return info;
>  }
>
> -GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return NULL;
> -}
> -
>  #ifndef HOST_NAME_MAX
>  # ifdef _POSIX_HOST_NAME_MAX
>  #  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 700c5baa5a..2704b814ab 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1527,7 +1527,8 @@
>  # @pci: PCI device
>  ##
>  { 'enum': 'GuestDeviceType',
> -  'data': [ 'pci' ] }
> +  'data': [ 'pci' ],
> +  'if': 'CONFIG_WIN32' }
>
>  ##
>  # @GuestDeviceIdPCI:
> @@ -1539,7 +1540,8 @@
>  # Since: 5.2
>  ##
>  { 'struct': 'GuestDeviceIdPCI',
> -  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
> +  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' },
> +  'if': 'CONFIG_WIN32' }
>
>  ##
>  # @GuestDeviceId:
> @@ -1553,7 +1555,8 @@
>  { 'union': 'GuestDeviceId',
>    'base': { 'type': 'GuestDeviceType' },
>    'discriminator': 'type',
> -  'data': { 'pci': 'GuestDeviceIdPCI' } }
> +  'data': { 'pci': 'GuestDeviceIdPCI' },
> +  'if': 'CONFIG_WIN32' }
>
>  ##
>  # @GuestDeviceInfo:
> @@ -1574,7 +1577,8 @@
>        '*driver-date': 'int',
>        '*driver-version': 'str',
>        '*id': 'GuestDeviceId'
> -  } }
> +  },
> +  'if': 'CONFIG_WIN32' }
>
>  ##
>  # @guest-get-devices:
> @@ -1586,7 +1590,8 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-get-devices',
> -  'returns': ['GuestDeviceInfo'] }
> +  'returns': ['GuestDeviceInfo'],
> +  'if': 'CONFIG_WIN32' }
>
>  ##
>  # @GuestAuthorizedKeys:
> --
> 2.45.1
>
>

--000000000000b9df65061d08c930
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Rather than creating stubs for every command that just =
return<br>
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema to<br>
fully exclude generation of the commands on non-Windows.<br>
<br>
The command will be rejected at QMP dispatch time instead,<br>
avoiding reimplementing rejection by blocking the stub commands.<br>
This changes the error message for affected commands from<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;Command FOO has been disabled&quot;}<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;The command FOO has not been found&quot;}<br>
<br>
This has the additional benefit that the QGA protocol reference<br>
now documents what conditions enable use of the command.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c |=C2=A0 9 ---------<br>
=C2=A0qga/qapi-schema.json | 15 ++++++++++-----<br>
=C2=A02 files changed, 10 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 838dc3cf98..b7f96aa005 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1207,8 +1207,6 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs=
)<br>
=C2=A0 =C2=A0 =C2=A0blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(&qu=
ot;guest-fstrim&quot;));<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(&quot;gu=
est-get-devices&quot;));<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return blockedrpcs;<br>
=C2=A0}<br>
<br>
@@ -1419,13 +1417,6 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
<br>
-GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
=C2=A0#ifndef HOST_NAME_MAX<br>
=C2=A0# ifdef _POSIX_HOST_NAME_MAX<br>
=C2=A0#=C2=A0 define HOST_NAME_MAX _POSIX_HOST_NAME_MAX<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 700c5baa5a..2704b814ab 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1527,7 +1527,8 @@<br>
=C2=A0# @pci: PCI device<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestDeviceType&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;pci&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;pci&#39; ],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDeviceIdPCI:<br>
@@ -1539,7 +1540,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestDeviceIdPCI&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;vendor-id&#39;: &#39;uint16&#39;, &#39;devic=
e-id&#39;: &#39;uint16&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;vendor-id&#39;: &#39;uint16&#39;, &#39;devic=
e-id&#39;: &#39;uint16&#39; },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDeviceId:<br>
@@ -1553,7 +1555,8 @@<br>
=C2=A0{ &#39;union&#39;: &#39;GuestDeviceId&#39;,<br>
=C2=A0 =C2=A0&#39;base&#39;: { &#39;type&#39;: &#39;GuestDeviceType&#39; },=
<br>
=C2=A0 =C2=A0&#39;discriminator&#39;: &#39;type&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;pci&#39;: &#39;GuestDeviceIdPCI&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;pci&#39;: &#39;GuestDeviceIdPCI&#39; },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDeviceInfo:<br>
@@ -1574,7 +1577,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*driver-date&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*driver-version&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*id&#39;: &#39;GuestDeviceId&#39;<br>
-=C2=A0 } }<br>
+=C2=A0 },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-devices:<br>
@@ -1586,7 +1590,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-devices&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestAuthorizedKeys:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000b9df65061d08c930--


