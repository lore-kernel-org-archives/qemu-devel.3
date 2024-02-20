Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2322C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLdI-0004mc-DC; Tue, 20 Feb 2024 03:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcLdH-0004kX-28
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:37:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcLdF-0005E3-6a
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708418259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5zH5xgE2VAb5ZwR78F7Diau66PyAUHwOynR1KXbx7E=;
 b=fPAStalkQWNkQhS/9ZfpheJQHKMxx3O/XeH+AJSTxYGDCB1rOHto0z4pUo2MuacxEdgBbA
 47QR80L+CSSGO7f/3gElgka7pGJC4X0wu1I8H6+zvP9f/E69bsoNerRHZiBCg+OE0NNqkC
 +bW32WDFurVfT1hT48KIijy+m/aedjo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-NO4ciaKIPnaU3hKtzZCoXg-1; Tue, 20 Feb 2024 03:37:37 -0500
X-MC-Unique: NO4ciaKIPnaU3hKtzZCoXg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5116d7eb706so4185042e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708418255; x=1709023055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5zH5xgE2VAb5ZwR78F7Diau66PyAUHwOynR1KXbx7E=;
 b=sf1IL3rZfm2/24p0DTIH5cxYHJklPx/KFm1bYtkpdEYiW6voVtG65nCSb/LaFiW4oI
 6qnucDPMWTipQjGvBqhm4/cSH0EDW5lfoD9TYEizQggf2Xtwnxv7tbnkv2mMQBcLq1St
 V0dN2g8WV3xgttgQ/wWW08UO9dinQ2ai1YRuk8QVD8hN4mKz0KfoibrRVuyQYFTV3G3M
 gcKzaqd2szp0euDQ7OdN6wqe+Zu/Y+LkwyJSMhLMZ55QGIp/83LSPjAztq2ZTIk+6FxU
 lAsgyitQY0J7YYRaeueKKovvysgQDV+cNjtrNljzB4nLa3hw4uw0tJgF8aexrGOYkvdz
 0myg==
X-Gm-Message-State: AOJu0YyTWpieh33wA8qVPwZfWGDhBVKQfKhlq4o9QnDpZqG4PFu1ytAT
 6K6BfIlLSCAHA/2716iKnVQC6FHxIPeSq/7eDPZxsOPToh4F83BBe2mKE5a8Ku9hVV+d6TP9/9S
 cVlsZcNF8wyAIgP/S5jFqtmBFouKc4oOHdLTofaYV08Cr9nOYDhlNuYz1YYFQDzdCCUGBM3JlUh
 omgrNNeEIgSoL0x4ZlFsuVcU9vPtk=
X-Received: by 2002:a05:6512:1190:b0:512:bea2:f002 with SMTP id
 g16-20020a056512119000b00512bea2f002mr1955254lfr.6.1708418255734; 
 Tue, 20 Feb 2024 00:37:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI3lMGNA1stGQRxvBng5Rzii5iqNxsHRHYMgjQP2gbBApychFNvOR2pcZo/bWAmBdacYO4BgkaCszkqoe/kyY=
X-Received: by 2002:a05:6512:1190:b0:512:bea2:f002 with SMTP id
 g16-20020a056512119000b00512bea2f002mr1955220lfr.6.1708418255394; Tue, 20 Feb
 2024 00:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20240205074709.3613229-1-armbru@redhat.com>
 <20240205074709.3613229-8-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-8-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 20 Feb 2024 10:37:24 +0200
Message-ID: <CAPMcbCr3sTG4sXtrdd0sx2kpSxY5HSw-A=azJ0BMeJ83E+hcxQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] qga/qapi-schema: Clean up documentation of
 guest-set-memory-blocks
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, berrange@redhat.com, 
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com, farosas@suse.de, 
 hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us, 
 jonathan.cameron@huawei.com, kraxel@redhat.com, kwolf@redhat.com, 
 lukasstraub2@web.de, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, 
 michael.roth@amd.com, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org, 
 pizhenwei@bytedance.com, qemu-block@nongnu.org, stefanb@linux.ibm.com, 
 wangyanan55@huawei.com
Content-Type: multipart/alternative; boundary="0000000000003dab0f0611cc1fa2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--0000000000003dab0f0611cc1fa2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Feb 5, 2024 at 9:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> The command's doc comment describes the argument, but it's not marked
> up as such.  Easy enough to fix.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b9501c8c81..35bde36a1f 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -43,7 +43,6 @@
>          'GuestDiskSmart',
>          'GuestDiskStatsInfo',
>          'GuestNVMeSmart',
> -        'guest-set-memory-blocks',
>          'guest-set-vcpus' ] } }
>
>  ##
> @@ -1174,14 +1173,16 @@
>  # Attempt to reconfigure (currently: enable/disable) state of memory
>  # blocks inside the guest.
>  #
> -# The input list is processed node by node in order.  In each node
> -# @phys-index is used to look up the guest MEMORY BLOCK, for which
> -# @online specifies the requested state.  The set of distinct
> -# @phys-index's is only required to be a subset of the guest-supported
> -# identifiers.  There's no restriction on list length or on repeating
> -# the same @phys-index (with possibly different @online field).
> -# Preferably the input list should describe a modified subset of
> -# @guest-get-memory-blocks' return value.
> +# @mem-blks: The memory blocks to be reconfigured.  This list is
> +#     processed node by node in order.  In each node @phys-index is
> +#     used to look up the guest MEMORY BLOCK, for which @online
> +#     specifies the requested state.  The set of distinct
> +#     @phys-index's is only required to be a subset of the
> +#     guest-supported identifiers.  There's no restriction on list
> +#     length or on repeating the same @phys-index (with possibly
> +#     different @online field).  Preferably the input list should
> +#     describe a modified subset of @guest-get-memory-blocks' return
> +#     value.
>  #
>  # Returns: The operation results, it is a list of
>  #     @GuestMemoryBlockResponse, which is corresponding to the input
> --
> 2.43.0
>
>

--0000000000003dab0f0611cc1fa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 5=
, 2024 at 9:47=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@re=
dhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The command&#39;s doc comment describes the argu=
ment, but it&#39;s not marked<br>
up as such.=C2=A0 Easy enough to fix.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 19 ++++++++++---------<br>
=C2=A01 file changed, 10 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b9501c8c81..35bde36a1f 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -43,7 +43,6 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestDiskSmart&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestDiskStatsInfo&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestNVMeSmart&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-set-memory-blocks&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;guest-set-vcpus&#39; ] } }<br>
<br>
=C2=A0##<br>
@@ -1174,14 +1173,16 @@<br>
=C2=A0# Attempt to reconfigure (currently: enable/disable) state of memory<=
br>
=C2=A0# blocks inside the guest.<br>
=C2=A0#<br>
-# The input list is processed node by node in order.=C2=A0 In each node<br=
>
-# @phys-index is used to look up the guest MEMORY BLOCK, for which<br>
-# @online specifies the requested state.=C2=A0 The set of distinct<br>
-# @phys-index&#39;s is only required to be a subset of the guest-supported=
<br>
-# identifiers.=C2=A0 There&#39;s no restriction on list length or on repea=
ting<br>
-# the same @phys-index (with possibly different @online field).<br>
-# Preferably the input list should describe a modified subset of<br>
-# @guest-get-memory-blocks&#39; return value.<br>
+# @mem-blks: The memory blocks to be reconfigured.=C2=A0 This list is<br>
+#=C2=A0 =C2=A0 =C2=A0processed node by node in order.=C2=A0 In each node @=
phys-index is<br>
+#=C2=A0 =C2=A0 =C2=A0used to look up the guest MEMORY BLOCK, for which @on=
line<br>
+#=C2=A0 =C2=A0 =C2=A0specifies the requested state.=C2=A0 The set of disti=
nct<br>
+#=C2=A0 =C2=A0 =C2=A0@phys-index&#39;s is only required to be a subset of =
the<br>
+#=C2=A0 =C2=A0 =C2=A0guest-supported identifiers.=C2=A0 There&#39;s no res=
triction on list<br>
+#=C2=A0 =C2=A0 =C2=A0length or on repeating the same @phys-index (with pos=
sibly<br>
+#=C2=A0 =C2=A0 =C2=A0different @online field).=C2=A0 Preferably the input =
list should<br>
+#=C2=A0 =C2=A0 =C2=A0describe a modified subset of @guest-get-memory-block=
s&#39; return<br>
+#=C2=A0 =C2=A0 =C2=A0value.<br>
=C2=A0#<br>
=C2=A0# Returns: The operation results, it is a list of<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0@GuestMemoryBlockResponse, which is correspondin=
g to the input<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000003dab0f0611cc1fa2--


