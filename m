Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5036DC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 22:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uboCu-0007nU-On; Tue, 15 Jul 2025 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uboCr-0007lx-15
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 18:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uboCl-0001mf-Ly
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 18:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752618773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L+zWH41/kVVYU2F581MvBSQTlSqxuROH0CuwVA1QLJI=;
 b=GfIBfQLHgyd3/TOYpgokumd0zmC2wh3z1I+vG7BHBS20LkuEOBXo32n1kOW7n4WPelCMtg
 jijoaKpds6ZXSdhFzfvqz/tGu/SnV3Wn66X99ZcVgfQL3GXn9xC4ir2/5YP+OEbLBqxTLE
 74bdKy/VSp/JZPJ0fuMG0YlbjORWBr0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Lx4Mayu0PESv0E_V9jc38A-1; Tue, 15 Jul 2025 18:32:51 -0400
X-MC-Unique: Lx4Mayu0PESv0E_V9jc38A-1
X-Mimecast-MFC-AGG-ID: Lx4Mayu0PESv0E_V9jc38A_1752618770
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235f77f86f6so56371465ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 15:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752618769; x=1753223569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+zWH41/kVVYU2F581MvBSQTlSqxuROH0CuwVA1QLJI=;
 b=gERbRE9JSNUwvc2QgxeQfbwqaPk1HgGBQGIburMgnIU0m+L/c1rGVPFEW3FTc055YX
 whzjVMmDrcwpknZKkvaW2LdWPqeql7PgV/4Nh8IKCDo7B2sq3mt9ehIu9H98kRpFnJq7
 wxJsYXoh4MZHAyChIvx+HaQpjDyqlHmU4wZ9QxBLMylk329lSGet/E+I5MRqQiB6VXcd
 CSFTelXilOXEcvV+lbZk7Axg6plymlIhsMoKBCqE9qJZhlcUSDEnq+4kV2rfzUqfkDv3
 eGvK++O9id0qbww1iAg8l6nc+Ts8UKg7Ei4YdTqHjffTiHIL9MphU2RJU2mV9skdw0Ws
 bqQQ==
X-Gm-Message-State: AOJu0YwWIT016BoyUeXF9J0+/W/nWAF9Mk+J9LnzRrVyZAR+54qNzPBM
 jtz4O3v3uAYkuRgkeZr/qBImWpeJ+wJnq0UjoDoKTclnq4dRvjOHd8Q9D3rFJv9VgW6CytGFocc
 lyVDMZ0sLFfllQ0hvqBmeDUGY3gkS7epNQM9HAakWiXZVVa6nJWhFYgQ1bEk9Eb+5ZwKa5tQz1x
 zd4Uqsutu7Ib1ni6wQ130u83Hi/QlBC4Ve1LXJn4M=
X-Gm-Gg: ASbGncviaDAhwEHEYzcqFvTmSMJXbtg1GGGQ0xA0PKqgdidyZzZtiQMYgw1nFVU37me
 8tx5X/fUH1hlDmrdldx/5GuKDnBvAorDHNX9bRMI2nPxcUKz8MzCwhR/85JU0Xk6Ye80CWBhQoa
 NM6kainN5PyIl+nES+EcgasSG1gE/kxa1YWA1EUDrBHmn3xzAcSdRn
X-Received: by 2002:a17:902:c949:b0:235:f70:fd44 with SMTP id
 d9443c01a7336-23e256ca838mr6417575ad.21.1752618769296; 
 Tue, 15 Jul 2025 15:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpQ6ABfLeu9iy6mU3cnhcQ65o/avVRx2srL8CatHQgazZddv+d1ZhcUI5/oS9rF7K+uhkoOHSzBHVEtfnvOY0=
X-Received: by 2002:a17:902:c949:b0:235:f70:fd44 with SMTP id
 d9443c01a7336-23e256ca838mr6417315ad.21.1752618768896; Tue, 15 Jul 2025
 15:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250715222548.198888-1-jsnow@redhat.com>
In-Reply-To: <20250715222548.198888-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jul 2025 18:32:36 -0400
X-Gm-Features: Ac12FXxtjJ980JOg72gqCefiyaMqnDyFKVmOMWE9RBOZeolagdOA35ZDq1CVk_k
Message-ID: <CAFn=p-bkR+s_O5KOdteq2iBYu4-2pfFiao_J4w05WfQ+BpyPGw@mail.gmail.com>
Subject: Re: [PATCH] python: fix editable installs for modern pip/setuptools
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000025bf140639ff5bcc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000025bf140639ff5bcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025, 6:27=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> The way editable installs work has changed at some point since Fedora 40
> was released. Generally, we should be opting to use pyproject.toml
> installs (PEP517/518) - but those are not fully supported until v61 of
> setuptools, and CentOS Stream 9 ships v53.
>
> Until that time, we can make use of a transitional feature in
> pip/setuptools to use "legacy" editable installs, which is enough to fix
> "make check-dev" on modern local workstations for now.
>
> By using the environment variable approach to configure pip, we avoid
> any problems for older versions of pip that don't recognize this option,
> so it's harmless. The config-settings option first appeared in v23 of
> pip. editable_mode was first supported by setuptools in v64.
>
> (I'm not currently precisely aware of when the default behavior of '-e'
> switched away from 'compat', but it appears to be a joint effect between
> setuptools and pip versions.)
>
> Version information for supported build platforms:
>
> distro              python3  pip     setuptools  sphinx
> --------------------------------------------------------
> centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3
> ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
>
> ** pyproject.toml installs supported as of here **
>
> freebsd             3.11.13  23.3.2  63.1.0      5.3.0
> debian_12           3.11.2   23.0.1  66.1.1      5.3.0
> ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6
> centos_stream_10    3.12.11  23.3.2  69.0.3      7.2.6
> fedora_41           3.13.5   24.2    69.2.0      7.3.7
> alpine_3_19         3.11.13  23.3.1  70.3.0      6.2.1
> alpine_3_20         3.12.11  24.0    70.3.0      7.2.6
> alpine_3_21         3.12.11  24.3.1  70.3.0      8.1.3
> ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
> fedora_42           3.13.5   24.3.1  74.1.3      8.1.3
> ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3
> macports            3.13.5   25.1.1  78.1.1      8.2.3
> openbsd             3.12.11  25.1.1  79.0.1      8.2.3
> alpine_3_22         3.12.11  25.1.1  80.9.0      8.2.3
> homebrew            3.13.5   ---     80.9.0      8.2.3
> pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/python/Makefile b/python/Makefile
> index 764b79ccb23..32aedce4137 100644
> --- a/python/Makefile
> +++ b/python/Makefile
> @@ -68,7 +68,7 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate:
> setup.cfg tests/minreqs.tx
>                 echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
>                 $(PIP_INSTALL) -r tests/minreqs.txt 1>/dev/null;        \
>                 echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";             \
> -               $(PIP_INSTALL) -e . 1>/dev/null;                        \
> +               PIP_CONFIG_SETTINGS=3D"editable_mode=3Dcompat" $(PIP_INST=
ALL)
> -e . 1>/dev/null;     \
>         )
>         @touch $(QEMU_MINVENV_DIR)
>
> @@ -103,7 +103,7 @@ check-dev: dev-venv
>
>  .PHONY: develop
>  develop:
> -       $(PIP_INSTALL) -e .[devel]
> +       PIP_CONFIG_SETTINGS=3D"editable_mode=3Dcompat" $(PIP_INSTALL) -e
> .[devel]
>
>  .PHONY: check
>  check:
> --
> 2.50.0
>

For what it's worth, I think this patch is safe to include in an early rc
as it should effect only testing - but if we don't feel it is safe, it's
also a very work-aroundable problem.

>

--00000000000025bf140639ff5bcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 15, 2025, 6:27=E2=80=
=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The way editable insta=
lls work has changed at some point since Fedora 40<br>
was released. Generally, we should be opting to use pyproject.toml<br>
installs (PEP517/518) - but those are not fully supported until v61 of<br>
setuptools, and CentOS Stream 9 ships v53.<br>
<br>
Until that time, we can make use of a transitional feature in<br>
pip/setuptools to use &quot;legacy&quot; editable installs, which is enough=
 to fix<br>
&quot;make check-dev&quot; on modern local workstations for now.<br>
<br>
By using the environment variable approach to configure pip, we avoid<br>
any problems for older versions of pip that don&#39;t recognize this option=
,<br>
so it&#39;s harmless. The config-settings option first appeared in v23 of<b=
r>
pip. editable_mode was first supported by setuptools in v64.<br>
<br>
(I&#39;m not currently precisely aware of when the default behavior of &#39=
;-e&#39;<br>
switched away from &#39;compat&#39;, but it appears to be a joint effect be=
tween<br>
setuptools and pip versions.)<br>
<br>
Version information for supported build platforms:<br>
<br>
distro=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3=C2=A0 pip=C2=
=A0 =C2=A0 =C2=A0setuptools=C2=A0 sphinx<br>
--------------------------------------------------------<br>
centos_stream_9=C2=A0 =C2=A0 =C2=A03.9.23=C2=A0 =C2=A021.3.1=C2=A0 53.0.0=
=C2=A0 =C2=A0 =C2=A0 3.4.3<br>
ubuntu_22_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.12=C2=A0 22.0.2=C2=A0 59.6.0=
=C2=A0 =C2=A0 =C2=A0 4.3.2<br>
<br>
** pyproject.toml installs supported as of here **<br>
<br>
freebsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.11.13=C2=A0 23.3.2=
=C2=A0 63.1.0=C2=A0 =C2=A0 =C2=A0 5.3.0<br>
debian_12=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.11.2=C2=A0 =C2=A023.0.1=
=C2=A0 66.1.1=C2=A0 =C2=A0 =C2=A0 5.3.0<br>
ubuntu_24_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.12.3=C2=A0 =C2=A024.0=C2=A0 =C2=
=A0 68.1.2=C2=A0 =C2=A0 =C2=A0 7.2.6<br>
centos_stream_10=C2=A0 =C2=A0 3.12.11=C2=A0 23.3.2=C2=A0 69.0.3=C2=A0 =C2=
=A0 =C2=A0 7.2.6<br>
fedora_41=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.13.5=C2=A0 =C2=A024.2=
=C2=A0 =C2=A0 69.2.0=C2=A0 =C2=A0 =C2=A0 7.3.7<br>
alpine_3_19=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.11.13=C2=A0 23.3.1=C2=A0 70.=
3.0=C2=A0 =C2=A0 =C2=A0 6.2.1<br>
alpine_3_20=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.12.11=C2=A0 24.0=C2=A0 =C2=
=A0 70.3.0=C2=A0 =C2=A0 =C2=A0 7.2.6<br>
alpine_3_21=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.12.11=C2=A0 24.3.1=C2=A0 70.=
3.0=C2=A0 =C2=A0 =C2=A0 8.1.3<br>
ubuntu_24_10=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.12.7=C2=A0 =C2=A024.2=C2=A0 =C2=
=A0 74.1.2=C2=A0 =C2=A0 =C2=A0 7.4.7<br>
fedora_42=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.13.5=C2=A0 =C2=A024.3.1=
=C2=A0 74.1.3=C2=A0 =C2=A0 =C2=A0 8.1.3<br>
ubuntu_25_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.13.3=C2=A0 =C2=A025.0=C2=A0 =C2=
=A0 75.8.0=C2=A0 =C2=A0 =C2=A0 8.1.3<br>
macports=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.13.5=C2=A0 =C2=A025.1.1=
=C2=A0 78.1.1=C2=A0 =C2=A0 =C2=A0 8.2.3<br>
openbsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.12.11=C2=A0 25.1.1=
=C2=A0 79.0.1=C2=A0 =C2=A0 =C2=A0 8.2.3<br>
alpine_3_22=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.12.11=C2=A0 25.1.1=C2=A0 80.=
9.0=C2=A0 =C2=A0 =C2=A0 8.2.3<br>
homebrew=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.13.5=C2=A0 =C2=A0---=C2=
=A0 =C2=A0 =C2=A080.9.0=C2=A0 =C2=A0 =C2=A0 8.2.3<br>
pkgsrc_current=C2=A0 =C2=A0 =C2=A0 3.12.11=C2=A0 25.1.1=C2=A0 80.9.0=C2=A0 =
=C2=A0 =C2=A0 8.2.3<br>
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
---<br>
=C2=A0python/Makefile | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/python/Makefile b/python/Makefile<br>
index 764b79ccb23..32aedce4137 100644<br>
--- a/python/Makefile<br>
+++ b/python/Makefile<br>
@@ -68,7 +68,7 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: set=
up.cfg tests/minreqs.tx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;INSTALL =
-r tests/minreqs.txt $(QEMU_MINVENV_DIR)&quot;;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(PIP_INSTALL) -r t=
ests/minreqs.txt 1&gt;/dev/null;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;INSTALL =
-e qemu $(QEMU_MINVENV_DIR)&quot;;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(PIP_INSTALL) -e .=
 1&gt;/dev/null;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PIP_CONFIG_SETTINGS=
=3D&quot;editable_mode=3Dcompat&quot; $(PIP_INSTALL) -e . 1&gt;/dev/null;=
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @touch $(QEMU_MINVENV_DIR)<br>
<br>
@@ -103,7 +103,7 @@ check-dev: dev-venv<br>
<br>
=C2=A0.PHONY: develop<br>
=C2=A0develop:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(PIP_INSTALL) -e .[devel]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PIP_CONFIG_SETTINGS=3D&quot;editable_mode=3Dcom=
pat&quot; $(PIP_INSTALL) -e .[devel]<br>
<br>
=C2=A0.PHONY: check<br>
=C2=A0check:<br>
-- <br>
2.50.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">For what it&#39;s worth, I think this patch is safe to include in an =
early rc as it should effect only testing - but if we don&#39;t feel it is =
safe, it&#39;s also a very work-aroundable problem.</div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"></blockquote></div></div></div>

--00000000000025bf140639ff5bcc--


