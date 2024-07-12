Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89257C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBlN-0003ue-CQ; Fri, 12 Jul 2024 04:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBlK-0003fh-HJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBlA-0007dw-61
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2SEYaSGXQe7B2TuNc7ZxR+QGcn50ybL3g8nFTp0u0tk=;
 b=RVWa6e/mmrfrXoQADSySp42MM6yP1Ho71ZfFyCHgZL4Fp0kmLLD3PmAw/ANha8ykY/AUuc
 mTdaZrTWv5EQPz9kpVlSPLRFT4DlXEiOhRZedJBHYeddugiXYM4Domgd3/ACKF8bxNCacr
 MPiOQ2l/ppki8Xovc1qeOl+Jd/bB2+s=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-TUa2B3FjNYClPFrNt_UWyA-1; Fri, 12 Jul 2024 04:36:03 -0400
X-MC-Unique: TUa2B3FjNYClPFrNt_UWyA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-64f30b1f8ecso26982457b3.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773362; x=1721378162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SEYaSGXQe7B2TuNc7ZxR+QGcn50ybL3g8nFTp0u0tk=;
 b=B0CMSJxgdZiTtT0/ar35/b5EA1/tarjNVkyIj9K/PArN0Xv1ArzLV8ctO6oRLOOn8K
 w8h28jzjyJ1HoUC1DtD7/SoY4g6dUihu/jP/zqEnD23zOomHmxuncLLQvFNwb7+4L9uH
 JzKDL7Nis8hRqChSOuJiNsbQN1DR6/D0N0IMOP1aXEEAxqXTl7+OUDDKjZWfmwn8Srzh
 MCfiotG1FIDvrH4idE+DG7hlZsT1ogt9ytg4Y9E9H8gs0q6tqFq8mLHbthU0ldEsJrpQ
 1w07uMbTc0DUSVCz47cbwHuJBr3BEXvT0m4DFZk8xRN/+FqZXOkEzATS6RESx6e2w6bt
 b+eg==
X-Gm-Message-State: AOJu0Yx1r6TJXF9XpzbBQDtWkoFyzefjxwvXlwiji/iaswkxPcY91+i1
 zak8GMxWr+/4dgQeJM5i38LXKOzNIv+53ENTz9RHI6IPCQmR3Yco4ADURARIphP3ne/1u+46HSh
 wDQ6byI4txGjzYH4oOAgHHaLkPvcvJiwWVyewj1WZpsN3Qza55BdiIPJYJnzCM9qEO50VcqKQS0
 hDJSj/j5FBb0+ovTO3Htbhq0GQzcU=
X-Received: by 2002:a0d:ed47:0:b0:64b:6f7f:bc29 with SMTP id
 00721157ae682-65cfddba7b3mr43060557b3.16.1720773362667; 
 Fri, 12 Jul 2024 01:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQlkBJgD0TkPg5CsVTlp4Devtqt7vRiNeKm3s4gEcfHy4g+7IQJHZKJXiyqVm9NZX9P8HHmhdX10THBRO15k=
X-Received: by 2002:a0d:ed47:0:b0:64b:6f7f:bc29 with SMTP id
 00721157ae682-65cfddba7b3mr43060467b3.16.1720773362430; Fri, 12 Jul 2024
 01:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-5-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-5-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:35:51 +0300
Message-ID: <CAPMcbCqisUNXriU2kC6SZyU1UErD3koMRYsT3VtP3TrJnY905w@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] qga: conditionalize schema for commands
 requiring getifaddrs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001cbad061d08c59e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--00000000000001cbad061d08c59e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every comamnd that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the network interface command on
> POSIX platforms lacking getifaddrs().
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
>
>    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
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
>  qga/commands-posix.c | 13 -------------
>  qga/qapi-schema.json | 15 ++++++++++-----
>  2 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 559d71ffae..09d08ee2ca 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1142,14 +1142,6 @@ error:
>      return NULL;
>  }
>
> -#else
> -
> -GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp=
)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
>  #endif /* HAVE_GETIFADDRS */
>
>  #if !defined(CONFIG_FSFREEZE)
> @@ -1222,11 +1214,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
,
> Error **errp)
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -#if !defined(HAVE_GETIFADDRS)
> -    blockedrpcs =3D g_list_append(blockedrpcs,
> -                              g_strdup("guest-network-get-interfaces"));
> -#endif
> -
>  #if !defined(CONFIG_FSFREEZE)
>      {
>          const char *list[] =3D {
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index d164c30ec3..c37c904aae 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -653,7 +653,8 @@
>  # Since: 1.1
>  ##
>  { 'enum': 'GuestIpAddressType',
> -  'data': [ 'ipv4', 'ipv6' ] }
> +  'data': [ 'ipv4', 'ipv6' ],
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
>
>  ##
>  # @GuestIpAddress:
> @@ -669,7 +670,8 @@
>  { 'struct': 'GuestIpAddress',
>    'data': {'ip-address': 'str',
>             'ip-address-type': 'GuestIpAddressType',
> -           'prefix': 'int'} }
> +           'prefix': 'int'},
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
>
>  ##
>  # @GuestNetworkInterfaceStat:
> @@ -701,7 +703,8 @@
>              'tx-packets': 'uint64',
>              'tx-errs': 'uint64',
>              'tx-dropped': 'uint64'
> -           } }
> +           },
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
>
>  ##
>  # @GuestNetworkInterface:
> @@ -721,7 +724,8 @@
>    'data': {'name': 'str',
>             '*hardware-address': 'str',
>             '*ip-addresses': ['GuestIpAddress'],
> -           '*statistics': 'GuestNetworkInterfaceStat' } }
> +           '*statistics': 'GuestNetworkInterfaceStat' },
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
>
>  ##
>  # @guest-network-get-interfaces:
> @@ -733,7 +737,8 @@
>  # Since: 1.1
>  ##
>  { 'command': 'guest-network-get-interfaces',
> -  'returns': ['GuestNetworkInterface'] }
> +  'returns': ['GuestNetworkInterface'],
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
>
>  ##
>  # @GuestLogicalProcessor:
> --
> 2.45.1
>
>

--00000000000001cbad061d08c59e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Rather than creating stubs for every comamnd that just =
return<br>
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema to<br>
fully exclude generation of the network interface command on<br>
POSIX platforms lacking getifaddrs().<br>
<br>
The command will be rejected at QMP dispatch time instead,<br>
avoiding reimplementing rejection by blocking the stub commands.<br>
This changes the error message for affected commands from<br>
<br>
=C2=A0 =C2=A0{&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&qu=
ot;: &quot;Command FOO has been disabled&quot;}<br>
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
=C2=A0qga/commands-posix.c | 13 -------------<br>
=C2=A0qga/qapi-schema.json | 15 ++++++++++-----<br>
=C2=A02 files changed, 10 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 559d71ffae..09d08ee2ca 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1142,14 +1142,6 @@ error:<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-#else<br>
-<br>
-GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)<=
br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
<br>
=C2=A0#if !defined(CONFIG_FSFREEZE)<br>
@@ -1222,11 +1214,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, =
Error **errp)<br>
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-#if !defined(HAVE_GETIFADDRS)<br>
-=C2=A0 =C2=A0 blockedrpcs =3D g_list_append(blockedrpcs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strdup(&quot;guest-network-get-interfaces=
&quot;));<br>
-#endif<br>
-<br>
=C2=A0#if !defined(CONFIG_FSFREEZE)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *list[] =3D {<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index d164c30ec3..c37c904aae 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -653,7 +653,8 @@<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestIpAddressType&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;ipv4&#39;, &#39;ipv6&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;ipv4&#39;, &#39;ipv6&#39; ],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_G=
ETIFADDRS&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestIpAddress:<br>
@@ -669,7 +670,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestIpAddress&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;ip-address&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ip-address-type&#39;: &#39;G=
uestIpAddressType&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;prefix&#39;: &#39;int&#39;} =
}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;prefix&#39;: &#39;int&#39;},=
<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_G=
ETIFADDRS&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkInterfaceStat:<br>
@@ -701,7 +703,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tx-packets&#39;: &#39;=
uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tx-errs&#39;: &#39;uin=
t64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tx-dropped&#39;: &#39;=
uint64&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_G=
ETIFADDRS&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkInterface:<br>
@@ -721,7 +724,8 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*hardware-address&#39;: &#39=
;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*ip-addresses&#39;: [&#39;Gu=
estIpAddress&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*statistics&#39;: &#39;Guest=
NetworkInterfaceStat&#39; } }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*statistics&#39;: &#39;Guest=
NetworkInterfaceStat&#39; },<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_G=
ETIFADDRS&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-network-get-interfaces:<br>
@@ -733,7 +737,8 @@<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-network-get-interfaces&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestNetworkInterface&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestNetworkInterface&#39;],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_G=
ETIFADDRS&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestLogicalProcessor:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--00000000000001cbad061d08c59e--


