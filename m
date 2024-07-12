Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFF0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBkh-0000kK-9k; Fri, 12 Jul 2024 04:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBkf-0000cT-8L
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBkc-0007M1-9n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXsmtHxh2kWFzzHWd55rjAYaR0iUOFFF7ndBpZsOL2w=;
 b=QJKDa4s0k7AUV2JZlkcTTq5VIMcC4qyt2eq4c821qKRbW9Ae4c+1Wxjtlql3CMvYbpun03
 Z2iaubdf3mbqKLl97/mC4Z13Z4yGzuG2Q9FXeTVLDXy5368Gv035OuN9OdMYNmWN17X9pK
 Cwx3e9t787ZY/DkQGtILcLzfwD3S+4k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-s4eJG3FAM_SF6E1O288owQ-1; Fri, 12 Jul 2024 04:35:28 -0400
X-MC-Unique: s4eJG3FAM_SF6E1O288owQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6522c6e5ed9so35681127b3.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773328; x=1721378128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXsmtHxh2kWFzzHWd55rjAYaR0iUOFFF7ndBpZsOL2w=;
 b=AzXCRAOInexnwnh3KKnsEMncBEqU/5ZkgmEbovK4HEC+Hh36n+lXYIpnw93cbGYj53
 3AmoqP5Y+TRuiwtb/Sy+BzLog11LfaFEPxnApS6mqUkkfmyCe28cOWDl4tzz2qCW1DzP
 U6EHiURJCXRN+gaxRmyQvT/Sn/GZ/dCaIv1v04H6BuOOMt5JlCJxVbl9r72Usdm9/Npt
 K6hahi8QQ/FL0Oy6X//17l/ddIq4xVv7pCghkyksKhJ4FvjiihPtxrOCQl0/z5Ok+aHd
 QVltpBOLwuzaoxDiwTcKPNIKzt7aANT6b9jhnxAhVhqAbAcZa5F4a0aCS1XAgJ55cicq
 bjqA==
X-Gm-Message-State: AOJu0Yw++Mlv0EOdMGJUsuEseQlMlCBIJDyE3Q+YWOQ1Plk7tVJfpAxu
 DSL1ZlNzZMzQzNKRrT69kJlmwiuE/hE5/Gk1151Ltr2iqsSHrGHw6T1Jgft2q05igySZT4LJdI3
 1mR36rp+XANbsnIdZ8m9mYUeN/v8xbhwa0nRQMTuiZbjKrP1YTUwMxjZw0CPkecf8MaHsASgbXt
 vli/dQ5onIyijMX6MyoDmujkSs0Wc=
X-Received: by 2002:a05:690c:a87:b0:64a:4161:4f91 with SMTP id
 00721157ae682-658eed5df43mr147127697b3.14.1720773328371; 
 Fri, 12 Jul 2024 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES7nhtLMmZy7rsPDkLqKrBGL0wiOyOecRYkHaB1dCvxLXswks2Msb/hH3C7HnKMPZsspjWslIn50gQ2c2aA20=
X-Received: by 2002:a05:690c:a87:b0:64a:4161:4f91 with SMTP id
 00721157ae682-658eed5df43mr147127627b3.14.1720773328063; Fri, 12 Jul 2024
 01:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-4-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-4-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:35:17 +0300
Message-ID: <CAPMcbCoS9aD1KkBN=GzYFaO6yWDtwUxm4bMgN=_a4GarDGFSCA@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] qga: conditionalize schema for commands
 unsupported on non-Linux POSIX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f5649f061d08c217"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000f5649f061d08c217
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on non-Linux POSIX
> platforms
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
>  qga/commands-posix.c | 66 --------------------------------------------
>  qga/qapi-schema.json | 30 +++++++++++---------
>  2 files changed, 17 insertions(+), 79 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 0dd8555867..559d71ffae 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -887,56 +887,6 @@ void qmp_guest_set_user_password(const char *usernam=
e,
>  }
>  #endif /* __linux__ || __FreeBSD__ */
>
> -#ifndef __linux__
> -
> -void qmp_guest_suspend_disk(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
> -
> -void qmp_guest_suspend_ram(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
> -
> -void qmp_guest_suspend_hybrid(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
> -
> -GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error
> **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return -1;
> -}
> -
> -GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockResponseList *
> -qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp=
)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -#endif
> -
>  #ifdef HAVE_GETIFADDRS
>  static GuestNetworkInterface *
>  guest_find_interface(GuestNetworkInterfaceList *head,
> @@ -1272,22 +1222,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
,
> Error **errp)
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -#if !defined(__linux__)
> -    {
> -        const char *list[] =3D {
> -            "guest-suspend-disk", "guest-suspend-ram",
> -            "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus"=
,
> -            "guest-get-memory-blocks", "guest-set-memory-blocks",
> -            "guest-get-memory-block-info",
> -            NULL};
> -        const char **p =3D list;
> -
> -        while (*p) {
> -            blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> -        }
> -    }
> -#endif
> -
>  #if !defined(HAVE_GETIFADDRS)
>      blockedrpcs =3D g_list_append(blockedrpcs,
>                                g_strdup("guest-network-get-interfaces"));
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b91456e9ad..d164c30ec3 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -565,7 +565,8 @@
>  #
>  # Since: 1.1
>  ##
> -{ 'command': 'guest-suspend-disk', 'success-response': false }
> +{ 'command': 'guest-suspend-disk', 'success-response': false,
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
>
>  ##
>  # @guest-suspend-ram:
> @@ -601,7 +602,8 @@
>  #
>  # Since: 1.1
>  ##
> -{ 'command': 'guest-suspend-ram', 'success-response': false }
> +{ 'command': 'guest-suspend-ram', 'success-response': false,
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
>
>  ##
>  # @guest-suspend-hybrid:
> @@ -637,7 +639,7 @@
>  # Since: 1.1
>  ##
>  { 'command': 'guest-suspend-hybrid', 'success-response': false,
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestIpAddressType:
> @@ -750,7 +752,8 @@
>  { 'struct': 'GuestLogicalProcessor',
>    'data': {'logical-id': 'int',
>             'online': 'bool',
> -           '*can-offline': 'bool'} }
> +           '*can-offline': 'bool'},
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
>
>  ##
>  # @guest-get-vcpus:
> @@ -765,7 +768,8 @@
>  # Since: 1.5
>  ##
>  { 'command': 'guest-get-vcpus',
> -  'returns': ['GuestLogicalProcessor'] }
> +  'returns': ['GuestLogicalProcessor'],
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
>
>  ##
>  # @guest-set-vcpus:
> @@ -808,7 +812,7 @@
>  { 'command': 'guest-set-vcpus',
>    'data':    {'vcpus': ['GuestLogicalProcessor'] },
>    'returns': 'int',
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestDiskBusType:
> @@ -1102,7 +1106,7 @@
>    'data': {'phys-index': 'uint64',
>             'online': 'bool',
>             '*can-offline': 'bool'},
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @guest-get-memory-blocks:
> @@ -1119,7 +1123,7 @@
>  ##
>  { 'command': 'guest-get-memory-blocks',
>    'returns': ['GuestMemoryBlock'],
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestMemoryBlockResponseType:
> @@ -1143,7 +1147,7 @@
>  { 'enum': 'GuestMemoryBlockResponseType',
>    'data': ['success', 'not-found', 'operation-not-supported',
>             'operation-failed'],
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestMemoryBlockResponse:
> @@ -1162,7 +1166,7 @@
>    'data': { 'phys-index': 'uint64',
>              'response': 'GuestMemoryBlockResponseType',
>              '*error-code': 'int' },
> -  'if': 'CONFIG_POSIX'}
> +  'if': 'CONFIG_LINUX'}
>
>  ##
>  # @guest-set-memory-blocks:
> @@ -1194,7 +1198,7 @@
>  { 'command': 'guest-set-memory-blocks',
>    'data':    {'mem-blks': ['GuestMemoryBlock'] },
>    'returns': ['GuestMemoryBlockResponse'],
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestMemoryBlockInfo:
> @@ -1207,7 +1211,7 @@
>  ##
>  { 'struct': 'GuestMemoryBlockInfo',
>    'data': {'size': 'uint64'},
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @guest-get-memory-block-info:
> @@ -1220,7 +1224,7 @@
>  ##
>  { 'command': 'guest-get-memory-block-info',
>    'returns': 'GuestMemoryBlockInfo',
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestExecStatus:
> --
> 2.45.1
>
>

--000000000000f5649f061d08c217
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
fully exclude generation of the commands on non-Linux POSIX<br>
platforms<br>
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
=C2=A0qga/commands-posix.c | 66 -------------------------------------------=
-<br>
=C2=A0qga/qapi-schema.json | 30 +++++++++++---------<br>
=C2=A02 files changed, 17 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 0dd8555867..559d71ffae 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -887,56 +887,6 @@ void qmp_guest_set_user_password(const char *username,=
<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ || __FreeBSD__ */<br>
<br>
-#ifndef __linux__<br>
-<br>
-void qmp_guest_suspend_disk(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-}<br>
-<br>
-void qmp_guest_suspend_ram(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-}<br>
-<br>
-void qmp_guest_suspend_hybrid(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-}<br>
-<br>
-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp=
)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return -1;<br>
-}<br>
-<br>
-GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestMemoryBlockResponseList *<br>
-qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)<=
br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-#endif<br>
-<br>
=C2=A0#ifdef HAVE_GETIFADDRS<br>
=C2=A0static GuestNetworkInterface *<br>
=C2=A0guest_find_interface(GuestNetworkInterfaceList *head,<br>
@@ -1272,22 +1222,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, =
Error **errp)<br>
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-#if !defined(__linux__)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *list[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-suspend-disk&quot;, =
&quot;guest-suspend-ram&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-suspend-hybrid&quot;=
, &quot;guest-get-vcpus&quot;, &quot;guest-set-vcpus&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-blocks&qu=
ot;, &quot;guest-set-memory-blocks&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-inf=
o&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char **p =3D list;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (*p) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g_list_append(bl=
ockedrpcs, g_strdup(*p++));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-#endif<br>
-<br>
=C2=A0#if !defined(HAVE_GETIFADDRS)<br>
=C2=A0 =C2=A0 =C2=A0blockedrpcs =3D g_list_append(blockedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_strdup(&quot;guest-network-get-inte=
rfaces&quot;));<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b91456e9ad..d164c30ec3 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -565,7 +565,8 @@<br>
=C2=A0#<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
-{ &#39;command&#39;: &#39;guest-suspend-disk&#39;, &#39;success-response&#=
39;: false }<br>
+{ &#39;command&#39;: &#39;guest-suspend-disk&#39;, &#39;success-response&#=
39;: false,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-suspend-ram:<br>
@@ -601,7 +602,8 @@<br>
=C2=A0#<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
-{ &#39;command&#39;: &#39;guest-suspend-ram&#39;, &#39;success-response&#3=
9;: false }<br>
+{ &#39;command&#39;: &#39;guest-suspend-ram&#39;, &#39;success-response&#3=
9;: false,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-suspend-hybrid:<br>
@@ -637,7 +639,7 @@<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-suspend-hybrid&#39;, &#39;success-res=
ponse&#39;: false,<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestIpAddressType:<br>
@@ -750,7 +752,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestLogicalProcessor&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;logical-id&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;online&#39;: &#39;bool&#39;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*can-offline&#39;: &#39;bool=
&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*can-offline&#39;: &#39;bool=
&#39;},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-vcpus:<br>
@@ -765,7 +768,8 @@<br>
=C2=A0# Since: 1.5<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-vcpus&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestLogicalProcessor&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestLogicalProcessor&#39;],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-set-vcpus:<br>
@@ -808,7 +812,7 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-vcpus&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;:=C2=A0 =C2=A0 {&#39;vcpus&#39;: [&#39;GuestLogi=
calProcessor&#39;] },<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;int&#39;,<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskBusType:<br>
@@ -1102,7 +1106,7 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;phys-index&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;online&#39;: &#39;bool&#39;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*can-offline&#39;: &#39;bool=
&#39;},<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-memory-blocks:<br>
@@ -1119,7 +1123,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-memory-blocks&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestMemoryBlock&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockResponseType:<br>
@@ -1143,7 +1147,7 @@<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestMemoryBlockResponseType&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [&#39;success&#39;, &#39;not-found&#39;, &#39;=
operation-not-supported&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;operation-failed&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockResponse:<br>
@@ -1162,7 +1166,7 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;phys-index&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;response&#39;: &#39;Gu=
estMemoryBlockResponseType&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*error-code&#39;: &#39=
;int&#39; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;}<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39;}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-set-memory-blocks:<br>
@@ -1194,7 +1198,7 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-memory-blocks&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;:=C2=A0 =C2=A0 {&#39;mem-blks&#39;: [&#39;GuestM=
emoryBlock&#39;] },<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestMemoryBlockResponse&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockInfo:<br>
@@ -1207,7 +1211,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestMemoryBlockInfo&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;size&#39;: &#39;uint64&#39;},<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-memory-block-info:<br>
@@ -1220,7 +1224,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-memory-block-info&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;GuestMemoryBlockInfo&#39;,<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestExecStatus:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000f5649f061d08c217--


