Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74DC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkiM-0005D2-Jc; Tue, 16 Jul 2024 12:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkiE-0004oB-Pd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkiA-00027T-2q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOcHz3RLFBS6q02plrZ2zcfz1xOB1yAGTa16NUYQd0c=;
 b=IeoQZLAelkBCtPmBhDiYJZ8TqvxqhBBvLSQYxUpjGqiB2h5mYAb1v71VF510wUsvt0lbis
 MDu/ZTO+ta3zrIosmgJs5euf4POd+67ayc5GtVWS2RqyJsTIeVvTdFVWj17me2lnjnRixb
 2Bz0cHMeU7BAF1Zx7KeAgVsO/H0bZe8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-2qkVGXiSOxup-HMez11asw-1; Tue, 16 Jul 2024 12:07:27 -0400
X-MC-Unique: 2qkVGXiSOxup-HMez11asw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7876e1a04faso3713352a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146046; x=1721750846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOcHz3RLFBS6q02plrZ2zcfz1xOB1yAGTa16NUYQd0c=;
 b=Y0Bm/2b6c07JtkceXOCfApzBT8VcMFMMAo8G82cAJshqyo15fQE3EQgPY3YBnfO5z8
 dRl6Uyv8uj7Nnio5evGQlLDUcUtTOL0wv3h7wuNG14SgZOBKG3Alx5dMX9neLEc0E4jq
 LM5v2es0fe4H+hWnVoc1z7f6mwnzRHplhC4cN/dqwDYbQBNSkEQoXKXw3yxsxsOYnlsW
 Gndbm+aoWznh734kLKDnWRym7e35dk+gziCTi+e+3wq8uh1PRy78Mprv3D6hFWUB2a97
 /fDqDxYqg39v062ZIA3tDq2hYNe38aEaW5wa3rEazSMk949LHXqNxerRmjEcVD8ZdOxS
 QOqw==
X-Gm-Message-State: AOJu0YyBj46Pey66N/hVzjM0sPFTLCNqMs660TU/3gTOGrHh9ZIIVElk
 /fUdNcvx5gU0CFd+AYy66dDKkhUyYYB9dEEls4jieNSA7qht4DWw3frGkY438Z0uhp+qvDkDeFC
 bJ9WZvdWqKgK5/hRAhZdGj4HWv4U6tggFNV/2EC5VhO/CCpSoYcaBZNbKvtue0wCf59Yizvz9eD
 be5sqgWAqCH2dKj0MK21Y7xFjo5b0=
X-Received: by 2002:a05:6a21:7898:b0:1c0:e5d1:619e with SMTP id
 adf61e73a8af0-1c3f1220134mr3240523637.18.1721146046186; 
 Tue, 16 Jul 2024 09:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1r3+lJWDL7Xs6x5PQBbEDAyb8Ti5rDD2y4YazMWqBb3Elbc7qTkytH8wk2km8fO5ACYe2xLwwyq89N7dBFwo=
X-Received: by 2002:a05:6a21:7898:b0:1c0:e5d1:619e with SMTP id
 adf61e73a8af0-1c3f1220134mr3240484637.18.1721146045821; Tue, 16 Jul 2024
 09:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-2-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:07:13 -0400
Message-ID: <CAFn=p-bRkqOeuLTD5MhPyuFYur2GUCs=NWat6Qs-6eRt_g88iA@mail.gmail.com>
Subject: Re: [PATCH 1/5] qapi/pci: Clean up documentation around PciDeviceClass
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ab1269061d5f8abb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000ab1269061d5f8abb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> PciDeviceInfo's doc comment has a note on PciDeviceClass member @desc.
> Since the note applies always, not just within PciDeviceInfo, merge it
> into PciDeviceClass's description of member @desc.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/pci.json | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/pci.json b/qapi/pci.json
> index 8287d15dd0..97179920fb 100644
> --- a/qapi/pci.json
> +++ b/qapi/pci.json
> @@ -93,7 +93,8 @@
>  #
>  # Information about the Class of a PCI device
>  #
> -# @desc: a string description of the device's class
> +# @desc: a string description of the device's class (not stable, and
> +#     should only be treated as informational)
>  #
>  # @class: the class code of the device
>  #
> @@ -146,9 +147,6 @@
>  #
>  # @regions: a list of the PCI I/O regions associated with the device
>  #
> -# .. note:: The contents of @class_info.desc are not stable and should
> -#    only be treated as informational.
> -#
>  # Since: 0.14
>  ##
>  { 'struct': 'PciDeviceInfo',
> --
> 2.45.0
>
>
>

--000000000000ab1269061d5f8abb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:24=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">PciDeviceInfo&#39;s doc comment ha=
s a note on PciDeviceClass member @desc.<br>
Since the note applies always, not just within PciDeviceInfo, merge it<br>
into PciDeviceClass&#39;s description of member @desc.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/pci.json | 6 ++----<br>
=C2=A01 file changed, 2 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qapi/pci.json b/qapi/pci.json<br>
index 8287d15dd0..97179920fb 100644<br>
--- a/qapi/pci.json<br>
+++ b/qapi/pci.json<br>
@@ -93,7 +93,8 @@<br>
=C2=A0#<br>
=C2=A0# Information about the Class of a PCI device<br>
=C2=A0#<br>
-# @desc: a string description of the device&#39;s class<br>
+# @desc: a string description of the device&#39;s class (not stable, and<b=
r>
+#=C2=A0 =C2=A0 =C2=A0should only be treated as informational)<br>
=C2=A0#<br>
=C2=A0# @class: the class code of the device<br>
=C2=A0#<br>
@@ -146,9 +147,6 @@<br>
=C2=A0#<br>
=C2=A0# @regions: a list of the PCI I/O regions associated with the device<=
br>
=C2=A0#<br>
-# .. note:: The contents of @class_info.desc are not stable and should<br>
-#=C2=A0 =C2=A0 only be treated as informational.<br>
-#<br>
=C2=A0# Since: 0.14<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;PciDeviceInfo&#39;,<br>
-- <br>
2.45.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000ab1269061d5f8abb--


