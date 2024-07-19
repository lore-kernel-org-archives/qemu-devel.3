Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B82C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUi9A-0007fE-N6; Fri, 19 Jul 2024 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi98-0007dl-L1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi95-0007Ay-U0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721374514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkJSjF2SBMwmsj3bp5qbgAgrXTmr4Oo3A4ewgN6WXmE=;
 b=VL59d58mOZvHoUj7cdoxzQnLOBteAQuS5fclRPwGvMhT6y3qRCckmq80oaTrz4FeM/78n0
 8EZrzpaLOosjBpXYef8rywJpZMWQNZ+WKGVTrH2C5SdpTg+qAt3WAx6k/YEAF1LNqUqi9g
 wO4nX7IwyR9p66PwtY5xJc5YqBWdTZY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-uDaGElv-N72kMWpkQuM3Gw-1; Fri, 19 Jul 2024 03:35:12 -0400
X-MC-Unique: uDaGElv-N72kMWpkQuM3Gw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e032d4cf26aso3771606276.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721374511; x=1721979311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RkJSjF2SBMwmsj3bp5qbgAgrXTmr4Oo3A4ewgN6WXmE=;
 b=sACF/7rXiVbANeMz4Rf+a4a00gHy1Rpvg1bdv51MLk9zK/bTv2uetwkfAKEZasxaDL
 llS0l/rfTBOiH5oCP4wAr2wbHVGwNc6p5D4mos8L2tCJp9Z+yJmry6q6Vwb4ENM1MDOr
 4DkocqBdG5W7PghmgSLdKA3efm2coZBzUxwMRlGiBWYIqYzjWC65y18DPhbhQ7q3OgVN
 hmhTkrz9WdG69mtEcIjesnYPCk5UiGZ7q3wntACxsBGVGNm9vWp4c4yfNaPEww4PE/Ds
 AIdsI7K0MhtjWhA8y49FW6sR/AfWFK54R+jEwARtyiXm2DpSyfCzEiE6Y2wSn63DixH5
 AvoQ==
X-Gm-Message-State: AOJu0Yw/fFb+MCqEjCScD3vnkmOPr30bswrWEnnAI5F9E5IWupF9Qa0R
 MBVZ1sGZdR2gAfGjDrN4To5EY5+5BuruKXOYQBoCYQU1wxUfcCH2acsoDBQtch7/MnFh/U2A5+i
 dCSHTl6RlKfb4auunP9UuRA3sz2eNPMr3uTS728aoLo3SR37lda1TGq3iCjEUUDYGh/XEaOO4YO
 Tdm19UrC60cZ2wXAfHFUWjD+K225HhvkXhq22Unw==
X-Received: by 2002:a05:6902:2082:b0:e05:a187:8bb8 with SMTP id
 3f1490d57ef6-e05fec1f9f0mr6032536276.42.1721374511402; 
 Fri, 19 Jul 2024 00:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnpArEwHkGgA6MeJkbAi+90u28irzaq6SL7zup0W6W35C6R7zXKYWqJwDUDRntbVgvFT3Q2yo3Rh/uws4piS0=
X-Received: by 2002:a05:6902:2082:b0:e05:a187:8bb8 with SMTP id
 3f1490d57ef6-e05fec1f9f0mr6032527276.42.1721374511117; Fri, 19 Jul 2024
 00:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240712132459.3974109-1-berrange@redhat.com>
 <20240712132459.3974109-12-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-12-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 10:35:00 +0300
Message-ID: <CAPMcbCqU38uDmmLdv+6JmmCT-ADCriBF=SzTALUKyg74FFZaVQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/22] qga: conditionalize schema for commands
 requiring linux/win32
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042ccb9061d94bc04"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--00000000000042ccb9061d94bc04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Jul 12, 2024 at 4:25=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Some commands were blocked based on CONFIG_FSFREEZE, but their
> impl had nothing todo with CONFIG_FSFREEZE, and were instead
> either Linux-only, or Win+Linux-only.
>
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the stats and fsinfo commands on
> platforms that can't support them.
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
>  qga/commands-bsd.c   | 24 -----------------------
>  qga/commands-posix.c | 30 ++---------------------------
>  qga/qapi-schema.json | 45 +++++++++++++++++++++++++++-----------------
>  3 files changed, 30 insertions(+), 69 deletions(-)
>
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 17bddda1cf..9ce48af311 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -149,30 +149,6 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>      }
>      return ret;
>  }
> -
> -GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
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
>  #endif /* CONFIG_FSFREEZE */
>
>  #ifdef HAVE_GETIFADDRS
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 09d08ee2ca..838dc3cf98 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1146,12 +1146,6 @@ error:
>
>  #if !defined(CONFIG_FSFREEZE)
>
> -GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
>  GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>  {
>      error_setg(errp, QERR_UNSUPPORTED);
> @@ -1181,25 +1175,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>
>      return 0;
>  }
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
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
> -
>  #endif /* CONFIG_FSFREEZE */
>
>  #if !defined(CONFIG_FSTRIM)
> @@ -1217,10 +1192,9 @@ GList *ga_command_init_blockedrpcs(GList
> *blockedrpcs)
>  #if !defined(CONFIG_FSFREEZE)
>      {
>          const char *list[] =3D {
> -            "guest-get-fsinfo", "guest-fsfreeze-status",
> +            "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> -            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> -            "guest-get-disks", NULL};
> +            "guest-fsfreeze-thaw", NULL};
>          char **p =3D (char **)list;
>
>          while (*p) {
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 79ed4f0e21..9bd5aa53bc 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -870,7 +870,8 @@
>  { 'enum': 'GuestDiskBusType',
>    'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
>              'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi'=
,
> -            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ] }
> +            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>
>  ##
> @@ -888,7 +889,8 @@
>  ##
>  { 'struct': 'GuestPCIAddress',
>    'data': {'domain': 'int', 'bus': 'int',
> -           'slot': 'int', 'function': 'int'} }
> +           'slot': 'int', 'function': 'int'},
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestCCWAddress:
> @@ -907,7 +909,8 @@
>    'data': {'cssid': 'int',
>             'ssid': 'int',
>             'subchno': 'int',
> -           'devno': 'int'} }
> +           'devno': 'int'},
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestDiskAddress:
> @@ -936,7 +939,8 @@
>             'bus-type': 'GuestDiskBusType',
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str',
> -           '*ccw-address': 'GuestCCWAddress'} }
> +           '*ccw-address': 'GuestCCWAddress'},
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestNVMeSmart:
> @@ -973,7 +977,8 @@
>             'media-errors-lo': 'uint64',
>             'media-errors-hi': 'uint64',
>             'number-of-error-log-entries-lo': 'uint64',
> -           'number-of-error-log-entries-hi': 'uint64' } }
> +           'number-of-error-log-entries-hi': 'uint64' },
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestDiskSmart:
> @@ -987,7 +992,8 @@
>  { 'union': 'GuestDiskSmart',
>    'base': { 'type': 'GuestDiskBusType' },
>    'discriminator': 'type',
> -  'data': { 'nvme': 'GuestNVMeSmart' } }
> +  'data': { 'nvme': 'GuestNVMeSmart' },
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestDiskInfo:
> @@ -1012,7 +1018,8 @@
>  { 'struct': 'GuestDiskInfo',
>    'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
>             '*address': 'GuestDiskAddress', '*alias': 'str',
> -           '*smart': 'GuestDiskSmart'} }
> +           '*smart': 'GuestDiskSmart'},
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @guest-get-disks:
> @@ -1025,7 +1032,8 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-get-disks',
> -  'returns': ['GuestDiskInfo'] }
> +  'returns': ['GuestDiskInfo'],
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @GuestFilesystemInfo:
> @@ -1051,7 +1059,8 @@
>  { 'struct': 'GuestFilesystemInfo',
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> -           '*total-bytes-privileged': 'uint64', 'disk':
> ['GuestDiskAddress']} }
> +           '*total-bytes-privileged': 'uint64', 'disk':
> ['GuestDiskAddress']},
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @guest-get-fsinfo:
> @@ -1064,7 +1073,8 @@
>  # Since: 2.2
>  ##
>  { 'command': 'guest-get-fsinfo',
> -  'returns': ['GuestFilesystemInfo'] }
> +  'returns': ['GuestFilesystemInfo'],
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
>
>  ##
>  # @guest-set-user-password:
> @@ -1703,7 +1713,8 @@
>             '*ios-pgr': 'uint64',
>             '*total-ticks': 'uint64',
>             '*weight-ticks': 'uint64'
> -           } }
> +           },
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestDiskStatsInfo:
> @@ -1721,7 +1732,7 @@
>             'major': 'uint64',
>             'minor': 'uint64',
>             'stats': 'GuestDiskStats' },
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @guest-get-diskstats:
> @@ -1734,7 +1745,7 @@
>  ##
>  { 'command': 'guest-get-diskstats',
>    'returns': ['GuestDiskStatsInfo'],
> -  'if': 'CONFIG_POSIX'
> +  'if': 'CONFIG_LINUX'
>  }
>
>  ##
> @@ -1748,7 +1759,7 @@
>  ##
>  { 'enum': 'GuestCpuStatsType',
>    'data': [ 'linux' ],
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>
>  ##
> @@ -1794,7 +1805,7 @@
>             '*guest': 'uint64',
>             '*guestnice': 'uint64'
>             },
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @GuestCpuStats:
> @@ -1809,7 +1820,7 @@
>    'base': { 'type': 'GuestCpuStatsType' },
>    'discriminator': 'type',
>    'data': { 'linux': 'GuestLinuxCpuStats' },
> -  'if': 'CONFIG_POSIX' }
> +  'if': 'CONFIG_LINUX' }
>
>  ##
>  # @guest-get-cpustats:
> @@ -1822,5 +1833,5 @@
>  ##
>  { 'command': 'guest-get-cpustats',
>    'returns': ['GuestCpuStats'],
> -  'if': 'CONFIG_POSIX'
> +  'if': 'CONFIG_LINUX'
>  }
> --
> 2.45.1
>
>

--00000000000042ccb9061d94bc04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 12, 2024 at 4:25=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Some commands were blocked based on CONFIG_FSFREEZE, bu=
t their<br>
impl had nothing todo with CONFIG_FSFREEZE, and were instead<br>
either Linux-only, or Win+Linux-only.<br>
<br>
Rather than creating stubs for every command that just return<br>
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema to<br>
fully exclude generation of the stats and fsinfo commands on<br>
platforms that can&#39;t support them.<br>
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
=C2=A0qga/commands-bsd.c=C2=A0 =C2=A0| 24 -----------------------<br>
=C2=A0qga/commands-posix.c | 30 ++---------------------------<br>
=C2=A0qga/qapi-schema.json | 45 +++++++++++++++++++++++++++----------------=
-<br>
=C2=A03 files changed, 30 insertions(+), 69 deletions(-)<br>
<br>
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
index 17bddda1cf..9ce48af311 100644<br>
--- a/qga/commands-bsd.c<br>
+++ b/qga/commands-bsd.c<br>
@@ -149,30 +149,6 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
-<br>
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
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
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
=C2=A0#ifdef HAVE_GETIFADDRS<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 09d08ee2ca..838dc3cf98 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1146,12 +1146,6 @@ error:<br>
<br>
=C2=A0#if !defined(CONFIG_FSFREEZE)<br>
<br>
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
=C2=A0GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORTED);<br>
@@ -1181,25 +1175,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
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
-<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
=C2=A0#if !defined(CONFIG_FSTRIM)<br>
@@ -1217,10 +1192,9 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpc=
s)<br>
=C2=A0#if !defined(CONFIG_FSFREEZE)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *list[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-fsinfo&quot;, &q=
uot;guest-fsfreeze-status&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-status&quot=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-fsfreeze-freeze=
&quot;, &quot;guest-fsfreeze-freeze-list&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-thaw&quot;,=
 &quot;guest-get-fsinfo&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-disks&quot;, NUL=
L};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-thaw&quot;,=
 NULL};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char **p =3D (char **)list;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*p) {<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 79ed4f0e21..9bd5aa53bc 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -870,7 +870,8 @@<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestDiskBusType&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [ &#39;ide&#39;, &#39;fdc&#39;, &#39;scsi&#39;=
, &#39;virtio&#39;, &#39;xen&#39;, &#39;usb&#39;, &#39;uml&#39;, &#39;sata&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sd&#39;, &#39;unknown&=
#39;, &#39;ieee1394&#39;, &#39;ssa&#39;, &#39;fibre&#39;, &#39;raid&#39;, &=
#39;iscsi&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;sas&#39;, &#39;mmc&#39;, &#=
39;virtual&#39;, &#39;file-backed-virtual&#39;, &#39;nvme&#39; ] }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;sas&#39;, &#39;mmc&#39;, &#=
39;virtual&#39;, &#39;file-backed-virtual&#39;, &#39;nvme&#39; ],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
<br>
=C2=A0##<br>
@@ -888,7 +889,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestPCIAddress&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;domain&#39;: &#39;int&#39;, &#39;bus&#39=
;: &#39;int&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;slot&#39;: &#39;int&#39;, &#=
39;function&#39;: &#39;int&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;slot&#39;: &#39;int&#39;, &#=
39;function&#39;: &#39;int&#39;},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestCCWAddress:<br>
@@ -907,7 +909,8 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;cssid&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ssid&#39;: &#39;int&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;subchno&#39;: &#39;int&#39;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;devno&#39;: &#39;int&#39;} }=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;devno&#39;: &#39;int&#39;},<=
br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskAddress:<br>
@@ -936,7 +939,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bus-type&#39;: &#39;GuestDis=
kBusType&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bus&#39;: &#39;int&#39;, &#3=
9;target&#39;: &#39;int&#39;, &#39;unit&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*serial&#39;: &#39;str&#39;,=
 &#39;*dev&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*ccw-address&#39;: &#39;Gues=
tCCWAddress&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*ccw-address&#39;: &#39;Gues=
tCCWAddress&#39;},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestNVMeSmart:<br>
@@ -973,7 +977,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;media-errors-lo&#39;: &#39;u=
int64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;media-errors-hi&#39;: &#39;u=
int64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;number-of-error-log-entries-=
lo&#39;: &#39;uint64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;number-of-error-log-entries-=
hi&#39;: &#39;uint64&#39; } }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;number-of-error-log-entries-=
hi&#39;: &#39;uint64&#39; },<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskSmart:<br>
@@ -987,7 +992,8 @@<br>
=C2=A0{ &#39;union&#39;: &#39;GuestDiskSmart&#39;,<br>
=C2=A0 =C2=A0&#39;base&#39;: { &#39;type&#39;: &#39;GuestDiskBusType&#39; }=
,<br>
=C2=A0 =C2=A0&#39;discriminator&#39;: &#39;type&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;nvme&#39;: &#39;GuestNVMeSmart&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;nvme&#39;: &#39;GuestNVMeSmart&#39; },<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskInfo:<br>
@@ -1012,7 +1018,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestDiskInfo&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;partition=
&#39;: &#39;bool&#39;, &#39;*dependencies&#39;: [&#39;str&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*address&#39;: &#39;GuestDis=
kAddress&#39;, &#39;*alias&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*smart&#39;: &#39;GuestDiskS=
mart&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*smart&#39;: &#39;GuestDiskS=
mart&#39;},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-disks:<br>
@@ -1025,7 +1032,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-disks&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestDiskInfo&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestDiskInfo&#39;],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestFilesystemInfo:<br>
@@ -1051,7 +1059,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestFilesystemInfo&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;mountpoin=
t&#39;: &#39;str&#39;, &#39;type&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*used-bytes&#39;: &#39;uint6=
4&#39;, &#39;*total-bytes&#39;: &#39;uint64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*total-bytes-privileged&#39;=
: &#39;uint64&#39;, &#39;disk&#39;: [&#39;GuestDiskAddress&#39;]} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*total-bytes-privileged&#39;=
: &#39;uint64&#39;, &#39;disk&#39;: [&#39;GuestDiskAddress&#39;]},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-fsinfo:<br>
@@ -1064,7 +1073,8 @@<br>
=C2=A0# Since: 2.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-fsinfo&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestFilesystemInfo&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestFilesystemInfo&#39;],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-set-user-password:<br>
@@ -1703,7 +1713,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*ios-pgr&#39;: &#39;uint64&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*total-ticks&#39;: &#39;uint=
64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*weight-ticks&#39;: &#39;uin=
t64&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskStatsInfo:<br>
@@ -1721,7 +1732,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;major&#39;: &#39;uint64&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;minor&#39;: &#39;uint64&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;stats&#39;: &#39;GuestDiskSt=
ats&#39; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-diskstats:<br>
@@ -1734,7 +1745,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-diskstats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestDiskStatsInfo&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39;<br>
=C2=A0}<br>
<br>
=C2=A0##<br>
@@ -1748,7 +1759,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestCpuStatsType&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [ &#39;linux&#39; ],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
<br>
=C2=A0##<br>
@@ -1794,7 +1805,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*guest&#39;: &#39;uint64&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*guestnice&#39;: &#39;uint64=
&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestCpuStats:<br>
@@ -1809,7 +1820,7 @@<br>
=C2=A0 =C2=A0&#39;base&#39;: { &#39;type&#39;: &#39;GuestCpuStatsType&#39; =
},<br>
=C2=A0 =C2=A0&#39;discriminator&#39;: &#39;type&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;linux&#39;: &#39;GuestLinuxCpuStats&#39=
; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-cpustats:<br>
@@ -1822,5 +1833,5 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestCpuStats&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39;<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39;<br>
=C2=A0}<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--00000000000042ccb9061d94bc04--


