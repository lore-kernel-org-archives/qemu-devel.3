Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C3C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnglm-0005Gn-7e; Fri, 22 Mar 2024 11:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rngll-0005E8-2g
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rnglj-0004mT-HV
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711121118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ho7vZmWZXprm4hxYx5nNknfi50O4KZYWA7TyZ73vTmI=;
 b=PHxINBzr9upi8UIQphYtzNuajfE2HF1Xngu+QqjnSMeQNTK6JgfJNif0PZMESIdoKphvQ1
 Z2ZiX8uffx0wcHeV1ccHpMNJsFCqRhWY8RG9aOAcN/0JFRA6Oyn8Y0SbUpBIA/tms8422+
 GGaIDRmcVR4btTTeH2762Oa4QaDzINQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-8mzUIWkZOR25SRpQTiH92Q-1; Fri, 22 Mar 2024 11:25:16 -0400
X-MC-Unique: 8mzUIWkZOR25SRpQTiH92Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cfc2041cdfso1124090a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711121116; x=1711725916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ho7vZmWZXprm4hxYx5nNknfi50O4KZYWA7TyZ73vTmI=;
 b=aoueZC7+7Y7M1F5cApS+lJUpsoWJUzPHSpAkpk2TmozksJuUR4fjfmsF1H4WTZ626L
 5ghxOG6PYt2HbYbTAcXf7mC9TIAI9wcr2f7DOPmnE4aq8oLxAu4ts7Iav1bjvX5HCVkI
 kLwuasyF9/VQXMtuowSoUDldpNSqPp61DdxZXnnQm9oz2/Gjkz4PqYQxCYlwRBiEK9Uv
 GxAZHZ/7EcaYVZ1sLn0C5PDku+r0yGpYJGaT4suLX7LgMPBYVc0qSJXUXspm4mJi0t6y
 ziwHZG/L+2sJacpXYud8A9qkaMCe92cZkkwWv6ZL5Va0QmVbnR0dXWiOVaDtM7nwnNHB
 qw5w==
X-Gm-Message-State: AOJu0YxMt3HoyH4siqWpm6GrpBtIt68+0ivk97y7CF8dWxU3lSJtxlPT
 iw5m/jAOOFtwdDbJFvVZn1tgi3Pb+41rfTba0lliv04QRwbkZ/nOZPxXkYCgKslSMSjlVcmYhfe
 9I2pzCKsZ1DiAWH3oCLKBht08MnlSW5qmPXWyglWmXoYe2jVziEXyrh190vzvxCwolT9hHm5nEi
 gYe4J3YO03SIyqOiQfPrWvuPYU7Ao=
X-Received: by 2002:a17:90a:430b:b0:29b:c3f3:19ac with SMTP id
 q11-20020a17090a430b00b0029bc3f319acmr2628595pjg.37.1711121115842; 
 Fri, 22 Mar 2024 08:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaSH5+cWMapsaGvclL1WsaTz82EtfSpp2xgSDu+f74CihgFc7EdBKbxOpNm65mQJlC3P2dIyVSRESe9OO0SRs=
X-Received: by 2002:a17:90a:430b:b0:29b:c3f3:19ac with SMTP id
 q11-20020a17090a430b00b0029bc3f319acmr2628583pjg.37.1711121115554; Fri, 22
 Mar 2024 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240322135117.195489-1-armbru@redhat.com>
 <20240322135117.195489-4-armbru@redhat.com>
In-Reply-To: <20240322135117.195489-4-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Mar 2024 11:25:03 -0400
Message-ID: <CAFn=p-Y_XzPSJ6xBTkFeCiH1u-vY_==mB3z3dT7sitMvi2tf6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] qapi: Fix bogus documentation of
 query-migrationthreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Daniel Berrange <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042d2570614416e2b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

--00000000000042d2570614416e2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, 9:51=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> The doc comment documents an argument that doesn't exist.  Would
> fail compilation if it was marked up correctly.  Delete.
>
> The Returns: section fails to refer to the data type, leaving the user
> to guess.  Fix that.
>
> The command name violates QAPI naming rules: it should be
> query-migration-threads.  Too late to fix.
>
> Reported-by: John Snow <jsnow@redhat.com>
> Fixes: 671326201dac (migration: Introduce interface query-migrationthread=
s)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/migration.json | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f6238b6980..e47ad7a63b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2419,9 +2419,7 @@
>  #
>  # Returns information of migration threads
>  #
> -# data: migration thread name
> -#
> -# Returns: information about migration threads
> +# Returns: @MigrationThreadInfo
>  #
>  # Since: 7.2
>  ##
> --
> 2.44.0
>
>

--00000000000042d2570614416e2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 22, 2024, 9:51=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">The doc comment documents an argum=
ent that doesn&#39;t exist.=C2=A0 Would<br>
fail compilation if it was marked up correctly.=C2=A0 Delete.<br>
<br>
The Returns: section fails to refer to the data type, leaving the user<br>
to guess.=C2=A0 Fix that.<br>
<br>
The command name violates QAPI naming rules: it should be<br>
query-migration-threads.=C2=A0 Too late to fix.<br>
<br>
Reported-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_b=
lank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
Fixes: 671326201dac (migration: Introduce interface query-migrationthreads)=
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/migration.json | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index f6238b6980..e47ad7a63b 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -2419,9 +2419,7 @@<br>
=C2=A0#<br>
=C2=A0# Returns information of migration threads<br>
=C2=A0#<br>
-# data: migration thread name<br>
-#<br>
-# Returns: information about migration threads<br>
+# Returns: @MigrationThreadInfo<br>
=C2=A0#<br>
=C2=A0# Since: 7.2<br>
=C2=A0##<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div></div></div>

--00000000000042d2570614416e2b--


