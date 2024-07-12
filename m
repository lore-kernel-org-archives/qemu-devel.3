Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB1C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBkM-0007a7-9V; Fri, 12 Jul 2024 04:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBkK-0007UW-Of
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBkD-0007Df-D1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hN08qGJJQ7WGa3kb6ZxWSejdWnYE4cMEuMOBawEWW3Q=;
 b=PoVmw+2E8Wo7PfGulqG2zlNDxpqg140+5TZWKjZf4fEEPICoZCu3tXwhdLFLfjEJH5+VCL
 mtC+kGlpbNYuPcWwEoRlv/ZgtgrA9ZNyyxHypEaExOji5yS1Mv0mcNmOJPIl2Sct5C5S6S
 nN1+1gAk1yNoSd/OSG4Ixtw1cMCotNE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-CVvnQXmNPNmKbzviWJJBTQ-1; Fri, 12 Jul 2024 04:35:05 -0400
X-MC-Unique: CVvnQXmNPNmKbzviWJJBTQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6511c587946so32556327b3.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773305; x=1721378105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hN08qGJJQ7WGa3kb6ZxWSejdWnYE4cMEuMOBawEWW3Q=;
 b=Ud6eb2fAxD/Qa10Xw8Z41pZTxinKbqdqC6yVcW/SKr8zpk4n7mTzhcmdGiyje7xupm
 rW4xh1gx4JzyM61bDn5pcZl4EnckzM6LKkOp780ESdivQ4tusE7aa+lTLlqm89UOLdYB
 Ib07TnrZ3F1CdYStUyLaYBYQ/8iGwiBWru978fTGs+LjKO9wx2YkRRSylmG6WMrImenu
 Lu8sLm5aqR7OPh8VZUKr7HxbCJEe8fiYEzuNEa0Ns6U/XhqNoJm3Ae8sw0M1Hf7YdS9a
 7qOdqdhHhe2CYp+JuRVtnTZaB62CXhdba0LTtBv+4sZgNfEgUszG63/6aYmEt6zYSaXW
 sWEQ==
X-Gm-Message-State: AOJu0YxPFMuwmS63FhZ603tf5akkWI1yiFAxugwxdBA4kYVh9cB/fqTz
 msXT3Zw+SsF48782pMGomrjQoYODnSYGR+Y6W4VPYoiblSPMhhivy0zfVJHQf7ATdbEWJwDoceT
 hFleP3bHdEsCMwZlPsz98cICUIu10/9msOXQ6Pzdwbdy1pxsYuIj3vF1z4ArarzrRA2s5HgJJpj
 2sMMBMMnTQn0K1LsE4uwOKMcDyWb8=
X-Received: by 2002:a05:690c:620c:b0:650:9d94:799f with SMTP id
 00721157ae682-658ef153907mr153050567b3.26.1720773305340; 
 Fri, 12 Jul 2024 01:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6rmbN5tzGJE4osdpjOgjY5n/gd1CvKNwUbxLormKlxev6emn4vzT3DdeRGlZYpKav5VEW5jEo+HpHoffZgk=
X-Received: by 2002:a05:690c:620c:b0:650:9d94:799f with SMTP id
 00721157ae682-658ef153907mr153050497b3.26.1720773305059; Fri, 12 Jul 2024
 01:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-3-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-3-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:34:54 +0300
Message-ID: <CAPMcbCps0VDcT+-BhTrTTDUBRSi4r=H+h-FtpBGQadD+JLOFnQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] qga: conditionalize schema for commands
 unsupported on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000966aaf061d08c1f0"
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

--000000000000966aaf061d08c1f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on Windows.
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
> This also fixes an accidental inconsistency where some commands
> (guest-get-diskstats & guest-get-cpustats) are implemented as
> stubs, yet not added to the blockedrpc list. Those change their
> error message from
>
>     {"class": "GenericError, "desc": "this feature or command is not
> currently supported"}
>
> to
>
>     {"class": "CommandNotFound", "desc": "The command FOO has not been
> found"}
>
> The final additional benefit is that the QGA protocol reference
> now documents what conditions enable use of the command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-posix.c |  2 +-
>  qga/commands-win32.c | 56 +-------------------------------------------
>  qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
>  3 files changed, 32 insertions(+), 71 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 2a3bef7445..0dd8555867 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1280,7 +1280,7 @@ GList *ga_command_init_blockedrpcs(GList
> *blockedrpcs)
>              "guest-get-memory-blocks", "guest-set-memory-blocks",
>              "guest-get-memory-block-info",
>              NULL};
> -        char **p =3D (char **)list;
> +        const char **p =3D list;
>
>          while (*p) {
>              blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 9fe670d5b4..2533e4c748 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1494,11 +1494,6 @@ out:
>      }
>  }
>
> -void qmp_guest_suspend_hybrid(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
> -
>  static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
>  {
>      IP_ADAPTER_ADDRESSES *adptr_addrs =3D NULL;
> @@ -1862,12 +1857,6 @@ GuestLogicalProcessorList
> *qmp_guest_get_vcpus(Error **errp)
>      return NULL;
>  }
>
> -int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error
> **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return -1;
> -}
> -
>  static gchar *
>  get_net_error_message(gint error)
>  {
> @@ -1969,46 +1958,15 @@ done:
>      g_free(rawpasswddata);
>  }
>
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
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -    const char *list_unsupported[] =3D {
> -        "guest-suspend-hybrid",
> -        "guest-set-vcpus",
> -        "guest-get-memory-blocks", "guest-set-memory-blocks",
> -        "guest-get-memory-block-info",
> -        NULL};
> -    char **p =3D (char **)list_unsupported;
> -
> -    while (*p) {
> -        blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> -    }
> -
>      if (!vss_init(true)) {
>          g_debug("vss_init failed, vss commands are going to be disabled"=
);
>          const char *list[] =3D {
>              "guest-get-fsinfo", "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
> -        p =3D (char **)list;
> +        char **p =3D (char **)list;
>
>          while (*p) {
>              blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> @@ -2505,15 +2463,3 @@ char *qga_get_host_name(Error **errp)
>
>      return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
>  }
> -
> -GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b3de1fb6b3..b91456e9ad 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -636,7 +636,8 @@
>  #
>  # Since: 1.1
>  ##
> -{ 'command': 'guest-suspend-hybrid', 'success-response': false }
> +{ 'command': 'guest-suspend-hybrid', 'success-response': false,
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestIpAddressType:
> @@ -806,7 +807,8 @@
>  ##
>  { 'command': 'guest-set-vcpus',
>    'data':    {'vcpus': ['GuestLogicalProcessor'] },
> -  'returns': 'int' }
> +  'returns': 'int',
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestDiskBusType:
> @@ -1099,7 +1101,8 @@
>  { 'struct': 'GuestMemoryBlock',
>    'data': {'phys-index': 'uint64',
>             'online': 'bool',
> -           '*can-offline': 'bool'} }
> +           '*can-offline': 'bool'},
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @guest-get-memory-blocks:
> @@ -1115,7 +1118,8 @@
>  # Since: 2.3
>  ##
>  { 'command': 'guest-get-memory-blocks',
> -  'returns': ['GuestMemoryBlock'] }
> +  'returns': ['GuestMemoryBlock'],
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestMemoryBlockResponseType:
> @@ -1138,7 +1142,8 @@
>  ##
>  { 'enum': 'GuestMemoryBlockResponseType',
>    'data': ['success', 'not-found', 'operation-not-supported',
> -           'operation-failed'] }
> +           'operation-failed'],
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestMemoryBlockResponse:
> @@ -1156,7 +1161,8 @@
>  { 'struct': 'GuestMemoryBlockResponse',
>    'data': { 'phys-index': 'uint64',
>              'response': 'GuestMemoryBlockResponseType',
> -            '*error-code': 'int' }}
> +            '*error-code': 'int' },
> +  'if': 'CONFIG_POSIX'}
>
>  ##
>  # @guest-set-memory-blocks:
> @@ -1187,7 +1193,8 @@
>  ##
>  { 'command': 'guest-set-memory-blocks',
>    'data':    {'mem-blks': ['GuestMemoryBlock'] },
> -  'returns': ['GuestMemoryBlockResponse'] }
> +  'returns': ['GuestMemoryBlockResponse'],
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestMemoryBlockInfo:
> @@ -1199,7 +1206,8 @@
>  # Since: 2.3
>  ##
>  { 'struct': 'GuestMemoryBlockInfo',
> -  'data': {'size': 'uint64'} }
> +  'data': {'size': 'uint64'},
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @guest-get-memory-block-info:
> @@ -1211,7 +1219,8 @@
>  # Since: 2.3
>  ##
>  { 'command': 'guest-get-memory-block-info',
> -  'returns': 'GuestMemoryBlockInfo' }
> +  'returns': 'GuestMemoryBlockInfo',
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestExecStatus:
> @@ -1702,7 +1711,8 @@
>    'data': {'name': 'str',
>             'major': 'uint64',
>             'minor': 'uint64',
> -           'stats': 'GuestDiskStats' } }
> +           'stats': 'GuestDiskStats' },
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @guest-get-diskstats:
> @@ -1714,7 +1724,8 @@
>  # Since: 7.1
>  ##
>  { 'command': 'guest-get-diskstats',
> -  'returns': ['GuestDiskStatsInfo']
> +  'returns': ['GuestDiskStatsInfo'],
> +  'if': 'CONFIG_POSIX'
>  }
>
>  ##
> @@ -1727,7 +1738,8 @@
>  # Since: 7.1
>  ##
>  { 'enum': 'GuestCpuStatsType',
> -  'data': [ 'linux' ] }
> +  'data': [ 'linux' ],
> +  'if': 'CONFIG_POSIX' }
>
>
>  ##
> @@ -1772,7 +1784,8 @@
>             '*steal': 'uint64',
>             '*guest': 'uint64',
>             '*guestnice': 'uint64'
> -           } }
> +           },
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @GuestCpuStats:
> @@ -1786,7 +1799,8 @@
>  { 'union': 'GuestCpuStats',
>    'base': { 'type': 'GuestCpuStatsType' },
>    'discriminator': 'type',
> -  'data': { 'linux': 'GuestLinuxCpuStats' } }
> +  'data': { 'linux': 'GuestLinuxCpuStats' },
> +  'if': 'CONFIG_POSIX' }
>
>  ##
>  # @guest-get-cpustats:
> @@ -1798,5 +1812,6 @@
>  # Since: 7.1
>  ##
>  { 'command': 'guest-get-cpustats',
> -  'returns': ['GuestCpuStats']
> +  'returns': ['GuestCpuStats'],
> +  'if': 'CONFIG_POSIX'
>  }
> --
> 2.45.1
>
>

--000000000000966aaf061d08c1f0
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
fully exclude generation of the commands on Windows.<br>
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
This also fixes an accidental inconsistency where some commands<br>
(guest-get-diskstats &amp; guest-get-cpustats) are implemented as<br>
stubs, yet not added to the blockedrpc list. Those change their<br>
error message from<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;GenericError, &quot;desc&quot;: &qu=
ot;this feature or command is not currently supported&quot;}<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;The command FOO has not been found&quot;}<br>
<br>
The final additional benefit is that the QGA protocol reference<br>
now documents what conditions enable use of the command.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c |=C2=A0 2 +-<br>
=C2=A0qga/commands-win32.c | 56 +------------------------------------------=
-<br>
=C2=A0qga/qapi-schema.json | 45 +++++++++++++++++++++++------------<br>
=C2=A03 files changed, 32 insertions(+), 71 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 2a3bef7445..0dd8555867 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1280,7 +1280,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-memory-bloc=
ks&quot;, &quot;guest-set-memory-blocks&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-memory-bloc=
k-info&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **p =3D (char **)list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char **p =3D list;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*p) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blockedrpcs =3D g_list_appe=
nd(blockedrpcs, g_strdup(*p++));<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 9fe670d5b4..2533e4c748 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1494,11 +1494,6 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void qmp_guest_suspend_hybrid(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-}<br>
-<br>
=C2=A0static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **err=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0IP_ADAPTER_ADDRESSES *adptr_addrs =3D NULL;<br>
@@ -1862,12 +1857,6 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp=
)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return -1;<br>
-}<br>
-<br>
=C2=A0static gchar *<br>
=C2=A0get_net_error_message(gint error)<br>
=C2=A0{<br>
@@ -1969,46 +1958,15 @@ done:<br>
=C2=A0 =C2=A0 =C2=A0g_free(rawpasswddata);<br>
=C2=A0}<br>
<br>
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
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const char *list_unsupported[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-suspend-hybrid&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-set-vcpus&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-blocks&quot;, &quot;gue=
st-set-memory-blocks&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-info&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL};<br>
-=C2=A0 =C2=A0 char **p =3D (char **)list_unsupported;<br>
-<br>
-=C2=A0 =C2=A0 while (*p) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g_list_append(blockedrpcs, g_s=
trdup(*p++));<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!vss_init(true)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_debug(&quot;vss_init failed, vss comman=
ds are going to be disabled&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *list[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-fsinfo&quot=
;, &quot;guest-fsfreeze-status&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-fsfreeze-freeze=
&quot;, &quot;guest-fsfreeze-thaw&quot;, NULL};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D (char **)list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **p =3D (char **)list;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*p) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blockedrpcs =3D g_list_appe=
nd(blockedrpcs, g_strdup(*p++));<br>
@@ -2505,15 +2463,3 @@ char *qga_get_host_name(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);<br=
>
=C2=A0}<br>
-<br>
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b3de1fb6b3..b91456e9ad 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -636,7 +636,8 @@<br>
=C2=A0#<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
-{ &#39;command&#39;: &#39;guest-suspend-hybrid&#39;, &#39;success-response=
&#39;: false }<br>
+{ &#39;command&#39;: &#39;guest-suspend-hybrid&#39;, &#39;success-response=
&#39;: false,<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestIpAddressType:<br>
@@ -806,7 +807,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-vcpus&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;:=C2=A0 =C2=A0 {&#39;vcpus&#39;: [&#39;GuestLogi=
calProcessor&#39;] },<br>
-=C2=A0 &#39;returns&#39;: &#39;int&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;int&#39;,<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskBusType:<br>
@@ -1099,7 +1101,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestMemoryBlock&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;phys-index&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;online&#39;: &#39;bool&#39;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*can-offline&#39;: &#39;bool=
&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*can-offline&#39;: &#39;bool=
&#39;},<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-memory-blocks:<br>
@@ -1115,7 +1118,8 @@<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-memory-blocks&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestMemoryBlock&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestMemoryBlock&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockResponseType:<br>
@@ -1138,7 +1142,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestMemoryBlockResponseType&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [&#39;success&#39;, &#39;not-found&#39;, &#39;=
operation-not-supported&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;operation-failed&#39;] }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;operation-failed&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockResponse:<br>
@@ -1156,7 +1161,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestMemoryBlockResponse&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;phys-index&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;response&#39;: &#39;Gu=
estMemoryBlockResponseType&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*error-code&#39;: &#39;int&=
#39; }}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*error-code&#39;: &#39;int&=
#39; },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-set-memory-blocks:<br>
@@ -1187,7 +1193,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-memory-blocks&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;:=C2=A0 =C2=A0 {&#39;mem-blks&#39;: [&#39;GuestM=
emoryBlock&#39;] },<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestMemoryBlockResponse&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestMemoryBlockResponse&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlockInfo:<br>
@@ -1199,7 +1206,8 @@<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestMemoryBlockInfo&#39;,<br>
-=C2=A0 &#39;data&#39;: {&#39;size&#39;: &#39;uint64&#39;} }<br>
+=C2=A0 &#39;data&#39;: {&#39;size&#39;: &#39;uint64&#39;},<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-memory-block-info:<br>
@@ -1211,7 +1219,8 @@<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-memory-block-info&#39;,<br>
-=C2=A0 &#39;returns&#39;: &#39;GuestMemoryBlockInfo&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestMemoryBlockInfo&#39;,<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestExecStatus:<br>
@@ -1702,7 +1711,8 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;major&#39;: &#39;uint64&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;minor&#39;: &#39;uint64&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;stats&#39;: &#39;GuestDiskSt=
ats&#39; } }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;stats&#39;: &#39;GuestDiskSt=
ats&#39; },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-diskstats:<br>
@@ -1714,7 +1724,8 @@<br>
=C2=A0# Since: 7.1<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-diskstats&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestDiskStatsInfo&#39;]<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestDiskStatsInfo&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;<br>
=C2=A0}<br>
<br>
=C2=A0##<br>
@@ -1727,7 +1738,8 @@<br>
=C2=A0# Since: 7.1<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestCpuStatsType&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;linux&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;linux&#39; ],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
<br>
=C2=A0##<br>
@@ -1772,7 +1784,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*steal&#39;: &#39;uint64&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*guest&#39;: &#39;uint64&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*guestnice&#39;: &#39;uint64=
&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestCpuStats:<br>
@@ -1786,7 +1799,8 @@<br>
=C2=A0{ &#39;union&#39;: &#39;GuestCpuStats&#39;,<br>
=C2=A0 =C2=A0&#39;base&#39;: { &#39;type&#39;: &#39;GuestCpuStatsType&#39; =
},<br>
=C2=A0 =C2=A0&#39;discriminator&#39;: &#39;type&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;linux&#39;: &#39;GuestLinuxCpuStats&#39; } }=
<br>
+=C2=A0 &#39;data&#39;: { &#39;linux&#39;: &#39;GuestLinuxCpuStats&#39; },<=
br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-cpustats:<br>
@@ -1798,5 +1812,6 @@<br>
=C2=A0# Since: 7.1<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestCpuStats&#39;]<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestCpuStats&#39;],<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;<br>
=C2=A0}<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000966aaf061d08c1f0--


