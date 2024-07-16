Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B580C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkk1-0003zx-Lc; Tue, 16 Jul 2024 12:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkjs-0003WV-99
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkjo-0002MN-4b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LecRcGY9GuLupOCQZH+4gCgRYmLod7Sz5h+UvWv2CjQ=;
 b=V8twKhWqeuL2/PkAP0zUF8DQRnboelQjGEFQHdfiRWvRHwuSEzI6Q6c1xb8VeYmRRWLfBy
 q2Jr2lLFqhPmxV6Vy1rXpm7eNGEPtn6yZwDPd/qrPdH4Wq/eqdhMq4wua4S2t4tGjujYgA
 zbxge53cURxFc4bJ8WhLBU0ABLjQnHk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-urEZOKYkNiuukCiNO6ttIA-1; Tue, 16 Jul 2024 12:09:07 -0400
X-MC-Unique: urEZOKYkNiuukCiNO6ttIA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-78e08ce33d0so2298425a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146146; x=1721750946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LecRcGY9GuLupOCQZH+4gCgRYmLod7Sz5h+UvWv2CjQ=;
 b=MpVJT7JjSH9U+9PoFBXota8GEKVa7CiFkOBXwBWn9eNZcCHy9ZTULkezMW+tKA0My6
 5hCIsJMRXyUQ6VfxRebdpVH8SBNfYkluyBfeezm49e8uQS+yZVpT8HdeEx8sIk6iSsq2
 KETQwELfZ7089PBQjUpH6NAhpYamldnvlqL4AJsGTq3F1QWuMYMohPYkQreePwrFmREE
 1scyH6yCLpAa1E+vm91+6tN5fNHgyP0Cu4tlFHz1PVHaAGe8KEIUqioPxs0dnCxkMa6w
 dRp5rhav9GMd6CBuQ7bQSs4zLbFBSJzyrqQeX0LA3vUYrkrpwsjG6cooKpDYaSJ2Rc3L
 WbGw==
X-Gm-Message-State: AOJu0Yxrq4ENrRTY4o0NSn3fqWUxLpCNV/5o6aXq1GSh09oRZonyxQqb
 6lCIG0mbsjrafZkO2Pm59yu3x9PvA7gdAQ5RGWpexIp3OPBgfXTq8tHqeDb5ZYSt3/IRHileai8
 SiBc3BbNp65WEuidtYZomD/UJNKZatUaVjULD+cTGt11w3DwbDSaUrcLy73wqnvaI44//x6OcFk
 su+emAhALiZWSQd9OmIKt3LuFeRwM=
X-Received: by 2002:a17:90a:f490:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2cb373fffc0mr1867776a91.7.1721146146282; 
 Tue, 16 Jul 2024 09:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhVs1h4j328WbOb1qZuOjO+gUW403PT1nCeeeZmPoZcxfznLPDVi49zF9S0TwBKgtKDNrwAD84quwUXT9/yxk=
X-Received: by 2002:a17:90a:f490:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2cb373fffc0mr1867757a91.7.1721146145905; Tue, 16 Jul 2024
 09:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-3-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-3-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:08:54 -0400
Message-ID: <CAFn=p-Y9E=QyaNa_okNpdzLVonp-TBuK+w57i1Jicy-JyZO-Ug@mail.gmail.com>
Subject: Re: [PATCH 2/5] qapi/machine: Clean up documentation around
 CpuInstanceProperties
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a23eda061d5f90aa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--000000000000a23eda061d5f90aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> CpuInstanceProperties' doc comment describes its members as properties
> to be passed to device_add when hot-plugging a CPU.
>
> This was in fact the initial use of this type, with
> query-hotpluggable-cpus: letting management applications find out what
> properties need to be passed with device_add to hot-plug a CPU.
>
> We've since added other uses: set-numa-node (commit 419fcdec3c1 and
> f3be67812c2), and query-cpus-fast (commit ce74ee3dea6).  These are not
> about device-add.
>
> query-hotpluggable-cpus uses CpuInstanceProperties within
> HotpluggableCPU.  Lift the documentation related to device-add from
> CpuInstanceProperties to HotpluggableCPU.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/machine.json | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index f15ad1b43e..50ff102d56 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -960,9 +960,7 @@
>  ##
>  # @CpuInstanceProperties:
>  #
> -# List of properties to be used for hotplugging a CPU instance, it
> -# should be passed by management with device_add command when a CPU is
> -# being hotplugged.
> +# Properties identifying a CPU.
>  #
>  # Which members are optional and which mandatory depends on the
>  # architecture and board.
> @@ -996,9 +994,6 @@
>  #
>  # @thread-id: thread number within the core the CPU  belongs to
>  #
> -# .. note:: Management should be prepared to pass through additional
> -#    properties with device_add.
> -#
>  # Since: 2.7
>  ##
>  { 'struct': 'CpuInstanceProperties',
> @@ -1020,7 +1015,8 @@
>  #
>  # @type: CPU object type for usage with device_add command
>  #
> -# @props: list of properties to be used for hotplugging CPU
> +# @props: list of properties to pass for hotplugging a CPU with
> +#     device_add
>  #
>  # @vcpus-count: number of logical VCPU threads @HotpluggableCPU
>  #     provides
> @@ -1028,6 +1024,9 @@
>  # @qom-path: link to existing CPU object if CPU is present or omitted
>  #     if CPU is not present.
>  #
> +# .. note:: Management should be prepared to pass through additional
> +#    properties with device_add.
> +#
>  # Since: 2.7
>  ##
>  { 'struct': 'HotpluggableCPU',
> --
> 2.45.0
>
>

--000000000000a23eda061d5f90aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">CpuInstanceProperties&#39; doc com=
ment describes its members as properties<br>
to be passed to device_add when hot-plugging a CPU.<br>
<br>
This was in fact the initial use of this type, with<br>
query-hotpluggable-cpus: letting management applications find out what<br>
properties need to be passed with device_add to hot-plug a CPU.<br>
<br>
We&#39;ve since added other uses: set-numa-node (commit 419fcdec3c1 and<br>
f3be67812c2), and query-cpus-fast (commit ce74ee3dea6).=C2=A0 These are not=
<br>
about device-add.<br>
<br>
query-hotpluggable-cpus uses CpuInstanceProperties within<br>
HotpluggableCPU.=C2=A0 Lift the documentation related to device-add from<br=
>
CpuInstanceProperties to HotpluggableCPU.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/machine.json | 13 ++++++-------<br>
=C2=A01 file changed, 6 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index f15ad1b43e..50ff102d56 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -960,9 +960,7 @@<br>
=C2=A0##<br>
=C2=A0# @CpuInstanceProperties:<br>
=C2=A0#<br>
-# List of properties to be used for hotplugging a CPU instance, it<br>
-# should be passed by management with device_add command when a CPU is<br>
-# being hotplugged.<br>
+# Properties identifying a CPU.<br>
=C2=A0#<br>
=C2=A0# Which members are optional and which mandatory depends on the<br>
=C2=A0# architecture and board.<br>
@@ -996,9 +994,6 @@<br>
=C2=A0#<br>
=C2=A0# @thread-id: thread number within the core the CPU=C2=A0 belongs to<=
br>
=C2=A0#<br>
-# .. note:: Management should be prepared to pass through additional<br>
-#=C2=A0 =C2=A0 properties with device_add.<br>
-#<br>
=C2=A0# Since: 2.7<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;CpuInstanceProperties&#39;,<br>
@@ -1020,7 +1015,8 @@<br>
=C2=A0#<br>
=C2=A0# @type: CPU object type for usage with device_add command<br>
=C2=A0#<br>
-# @props: list of properties to be used for hotplugging CPU<br>
+# @props: list of properties to pass for hotplugging a CPU with<br>
+#=C2=A0 =C2=A0 =C2=A0device_add<br>
=C2=A0#<br>
=C2=A0# @vcpus-count: number of logical VCPU threads @HotpluggableCPU<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0provides<br>
@@ -1028,6 +1024,9 @@<br>
=C2=A0# @qom-path: link to existing CPU object if CPU is present or omitted=
<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0if CPU is not present.<br>
=C2=A0#<br>
+# .. note:: Management should be prepared to pass through additional<br>
+#=C2=A0 =C2=A0 properties with device_add.<br>
+#<br>
=C2=A0# Since: 2.7<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;HotpluggableCPU&#39;,<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--000000000000a23eda061d5f90aa--


