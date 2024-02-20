Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A41C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLwj-0004zJ-AY; Tue, 20 Feb 2024 03:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcLwh-0004kQ-5V
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcLwf-0000gv-0d
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jPuMJB1qDzwfABF4hSASK17xcfZK5cZ0zXA5XkAwEsw=;
 b=Ck3QQG/gaeX1jaguhXtWN+2rDGlU4v+hc8fo1GiaV3a+gBru5JTRYv8H4Hz4VKnMu14eHK
 X1v51yD9KxPTIGRFqD1Bs2EbonKZm/pVDCxPHWI5fzQB00LE5ovNr0khQHuHzhVTc7hbyr
 xZtmSEYVQk/oLgFd6c+gCtXlixqcwr8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-mH6eCZphObOI8wjWxcVbYg-1; Tue, 20 Feb 2024 03:57:42 -0500
X-MC-Unique: mH6eCZphObOI8wjWxcVbYg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d05e887307so32884381fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419461; x=1709024261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPuMJB1qDzwfABF4hSASK17xcfZK5cZ0zXA5XkAwEsw=;
 b=TgwVPfaGYP8H/S9P7hdX8ZW1mEX+e+oX6wTM9s11wgNGc71YnOrm/0NLJ2+DaVCpA9
 9MZzYpGUydzeAvXM/0lA3tVSNnK1wSgvLuY8pkOtMlg9wyW7VlZI6DmIR4MWg+D8G5/x
 Rtv50iOBIFYvFwCgLTs5uhWgUMEvjL9HQqYW+PPd64Ap91r1rbki9bt3hBbX/fqrVXkK
 3grQSxc1vI6wBY+2yGbelFlTAV4EYBA8NDDju9pKrs80juhD6cPpn03byQfheFOJaHta
 gJ9MU6ObZFGlzDIIqpAVC8k2KYsNXMmJ9zzlD3wt1B55J1vDSHEyaR2iCWrgz7/HiD8s
 u99w==
X-Gm-Message-State: AOJu0YyQxGZWXAIWMxwf+HppInVwf/yCW8IOUxgM2dgvsmUqiHdqICoH
 gPVx/ZnLiSA4fcMfKis6pwh4Sdq2tBicAgUJBmFaCQgHh69AVq53tL9RDtAiXM3izD40KiiaV8j
 sI40jJB13W1LRTBLvn5xiQXGYKew2Oj8iLpWfWLxgfEVt5MjyV3AfnrS6mVh5LNfeMLd6Gav3lC
 Bx9qZpOlw0TZnpMFGywa4EC7I7MUw=
X-Received: by 2002:a2e:4601:0:b0:2d2:35f0:5dd9 with SMTP id
 t1-20020a2e4601000000b002d235f05dd9mr2062798lja.11.1708419461056; 
 Tue, 20 Feb 2024 00:57:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv5dOpShXYr3oqfIe8MMg7MRF/WWMsd5VhoAmDqP3xbhDTxkSSXuMQgmJ3Lyi5ZUjXqXdN/BK4QyAKiKFTqgY=
X-Received: by 2002:a2e:4601:0:b0:2d2:35f0:5dd9 with SMTP id
 t1-20020a2e4601000000b002d235f05dd9mr2062788lja.11.1708419460720; Tue, 20 Feb
 2024 00:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20240205074709.3613229-1-armbru@redhat.com>
 <20240205074709.3613229-9-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-9-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 20 Feb 2024 10:57:29 +0200
Message-ID: <CAPMcbCpWG3cM086x95JuuJ9yzOr=7iEdmGcegiqueYGSsWXwXA@mail.gmail.com>
Subject: Re: [PATCH 08/15] qga/qapi-schema: Clean up documentation of
 guest-set-vcpus
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
Content-Type: multipart/alternative; boundary="0000000000001597e90611cc67b9"
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

--0000000000001597e90611cc67b9
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
>  qga/qapi-schema.json | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 35bde36a1f..f3d168d542 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -42,8 +42,7 @@
>          'GuestDeviceType',
>          'GuestDiskSmart',
>          'GuestDiskStatsInfo',
> -        'GuestNVMeSmart',
> -        'guest-set-vcpus' ] } }
> +        'GuestNVMeSmart' ] } }
>
>  ##
>  # @guest-sync-delimited:
> @@ -786,14 +785,15 @@
>  # Attempt to reconfigure (currently: enable/disable) logical
>  # processors inside the guest.
>  #
> -# The input list is processed node by node in order.  In each node
> -# @logical-id is used to look up the guest VCPU, for which @online
> -# specifies the requested state.  The set of distinct @logical-id's is
> -# only required to be a subset of the guest-supported identifiers.
> -# There's no restriction on list length or on repeating the same
> -# @logical-id (with possibly different @online field). Preferably the
> -# input list should describe a modified subset of @guest-get-vcpus'
> -# return value.
> +# @vcpus: The logical processors to be reconfigured.  This list is
> +#     processed node by node in order.  In each node @logical-id is
> +#     used to look up the guest VCPU, for which @online specifies the
> +#     requested state.  The set of distinct @logical-id's is only
> +#     required to be a subset of the guest-supported identifiers.
> +#     There's no restriction on list length or on repeating the same
> +#     @logical-id (with possibly different @online field).  Preferably
> +#     the input list should describe a modified subset of
> +#     @guest-get-vcpus' return value.
>  #
>  # Returns: The length of the initial sublist that has been
>  #     successfully processed.  The guest agent maximizes this value.
> --
> 2.43.0
>
>

--0000000000001597e90611cc67b9
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
=C2=A0qga/qapi-schema.json | 20 ++++++++++----------<br>
=C2=A01 file changed, 10 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 35bde36a1f..f3d168d542 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -42,8 +42,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestDeviceType&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestDiskSmart&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GuestDiskStatsInfo&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;GuestNVMeSmart&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-set-vcpus&#39; ] } }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;GuestNVMeSmart&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-sync-delimited:<br>
@@ -786,14 +785,15 @@<br>
=C2=A0# Attempt to reconfigure (currently: enable/disable) logical<br>
=C2=A0# processors inside the guest.<br>
=C2=A0#<br>
-# The input list is processed node by node in order.=C2=A0 In each node<br=
>
-# @logical-id is used to look up the guest VCPU, for which @online<br>
-# specifies the requested state.=C2=A0 The set of distinct @logical-id&#39=
;s is<br>
-# only required to be a subset of the guest-supported identifiers.<br>
-# There&#39;s no restriction on list length or on repeating the same<br>
-# @logical-id (with possibly different @online field). Preferably the<br>
-# input list should describe a modified subset of @guest-get-vcpus&#39;<br=
>
-# return value.<br>
+# @vcpus: The logical processors to be reconfigured.=C2=A0 This list is<br=
>
+#=C2=A0 =C2=A0 =C2=A0processed node by node in order.=C2=A0 In each node @=
logical-id is<br>
+#=C2=A0 =C2=A0 =C2=A0used to look up the guest VCPU, for which @online spe=
cifies the<br>
+#=C2=A0 =C2=A0 =C2=A0requested state.=C2=A0 The set of distinct @logical-i=
d&#39;s is only<br>
+#=C2=A0 =C2=A0 =C2=A0required to be a subset of the guest-supported identi=
fiers.<br>
+#=C2=A0 =C2=A0 =C2=A0There&#39;s no restriction on list length or on repea=
ting the same<br>
+#=C2=A0 =C2=A0 =C2=A0@logical-id (with possibly different @online field).=
=C2=A0 Preferably<br>
+#=C2=A0 =C2=A0 =C2=A0the input list should describe a modified subset of<b=
r>
+#=C2=A0 =C2=A0 =C2=A0@guest-get-vcpus&#39; return value.<br>
=C2=A0#<br>
=C2=A0# Returns: The length of the initial sublist that has been<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0successfully processed.=C2=A0 The guest agent ma=
ximizes this value.<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000001597e90611cc67b9--


