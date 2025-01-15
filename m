Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC1C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3W0-0007Lr-Jo; Wed, 15 Jan 2025 08:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tY3Vz-0007Ku-Dl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tY3Vx-0005L4-DM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736947974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDdgoOGs3Q5Ss9ynoB2S+9JxEp57xcwinijLEkBmjmA=;
 b=L91PO79pkD5XLl+gGfjXiYIl8wOnqONVMVtZM+zDcp7UHPtS164qgZq44gwevw3/4zqa94
 6u34y7jBtZvQYSIxp1F3SkpLI0w8VflHV6Ugpp2wwMTM2x1QtAt7kb6QVOdrgR4lcBu6NV
 wzGQkom9AG73GhyjSjy5ojHcC1+tVR8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-EdqykUeZPmO_-rTjTCCFIg-1; Wed, 15 Jan 2025 08:32:51 -0500
X-MC-Unique: EdqykUeZPmO_-rTjTCCFIg-1
X-Mimecast-MFC-AGG-ID: EdqykUeZPmO_-rTjTCCFIg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6ee0af16dso1131862285a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947970; x=1737552770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDdgoOGs3Q5Ss9ynoB2S+9JxEp57xcwinijLEkBmjmA=;
 b=m5tRlzPKN0vtXpPC1JWNAC48QU+SnkRrhg/nITbBDOWrncQ2b+iyxw6R+lJTkXlZ6u
 Z6liAa9UK4icZRuOy3WCYPObW0SeSkFm7MF086FxVtCCnOvA0dUQ9tNTqL7dq9JI5O9v
 JIj7RS4/vUasvZzdURUMAiqpt8zawDXN+/gUT2fcEJUFyS25qrezjcrBy0YcYzsa13GE
 F4yJ0iCCt10D6hL0219FRNnwlm94SkXbLK59X2hEN3PVCBAX2i+IVNRuWyBNMUjiCrOl
 mca4l/Vb++xexf/cKw1NUp5Q32BWUoVjClGEtrk0rjC0hirEXlHfySFw5DmbruxULIfW
 XX7w==
X-Gm-Message-State: AOJu0YwrU71PtkIwkrLvqslFpUrkbzxfrLgj5/sez0Bs8FA+NwaJq6KU
 2L00gTClEMxm9jQqwd3GiEWacyGo6UmIIU+vd21229Fuf80tJYAUV2t1tYv76b2xrQklpABVpOg
 7JyAtinCAXlpnwroomWGGq7kYjLRAer5ZK+GQQdTDwQunn/c1O1GKHCJxl6LSUHTBdCc/OVmypI
 e4NeCkyjIAGBkHbKcQbHjeNMbB8tja+97o96g=
X-Gm-Gg: ASbGnctYY7zEO3d+PrQHmJ8VUjSKdEWBVPI3kNqwIiixKMtMuYRWzySKwagu0FdhMyz
 yeOndphE8Bae0ZE+TuqoUwS8V3SpEjoIp3GEM871/
X-Received: by 2002:a05:620a:1b89:b0:7b6:f6ac:60e with SMTP id
 af79cd13be357-7bcd979c8f2mr5269196885a.36.1736947970012; 
 Wed, 15 Jan 2025 05:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWxyO9lL0KXTtZqRgKHIr2rkcKQLB5HkXmSDK6x1UMQioeSEZf+Nuy8+V4dRwQRDW/Ba52oK8NzJzB/p6JPno=
X-Received: by 2002:a05:620a:1b89:b0:7b6:f6ac:60e with SMTP id
 af79cd13be357-7bcd979c8f2mr5269193985a.36.1736947969797; Wed, 15 Jan 2025
 05:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20241216154552.213961-1-kkostiuk@redhat.com>
 <20241216154552.213961-2-kkostiuk@redhat.com>
 <CAPMcbCrP4Y3uXYWzEQ3FpD_0Tm-Of6HJs7L8SEfwVxz1omO82g@mail.gmail.com>
In-Reply-To: <CAPMcbCrP4Y3uXYWzEQ3FpD_0Tm-Of6HJs7L8SEfwVxz1omO82g@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 15 Jan 2025 15:32:39 +0200
X-Gm-Features: AbW1kvakQ13Tx3kPwYUdMfFkrRLzTl9g2RZNdGaJl5Saqs6IZRIdblXZ4RiLNME
Message-ID: <CAPMcbCpehnLsQUzs+BgFE8qwdgg7XqqLyrRM7u7a9tXQkuEwig@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] qga: Add log to guest-fsfreeze-thaw command
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bbc10e062bbeb64f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000bbc10e062bbeb64f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Mon, Jan 6, 2025 at 11:37=E2=80=AFAM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> ping
>
> On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redh=
at.com>
> wrote:
>
>> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>> ---
>>  qga/commands-posix.c | 2 ++
>>  qga/commands-win32.c | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 636307bedf..359a56be81 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>      int ret;
>>
>>      ret =3D qmp_guest_fsfreeze_do_thaw(errp);
>> +
>>      if (ret >=3D 0) {
>>          ga_unset_frozen(ga_state);
>> +        slog("guest-fsthaw called");
>>          execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
>>      } else {
>>          ret =3D 0;
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 038beb8cfa..7d8e260e1f 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>      qga_vss_fsfreeze(&i, false, NULL, errp);
>>
>>      ga_unset_frozen(ga_state);
>> +
>> +    slog("guest-fsthaw called");
>> +
>>      return i;
>>  }
>>
>> --
>> 2.47.1
>>
>>
>>

--000000000000bbc10e062bbeb64f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>ping<br></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 6, 2025 at =
11:37=E2=80=AFAM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.c=
om">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr">ping<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16, 2024 at 5:4=
7=E2=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" =
target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Signed-off-by: Konstantin Kostiuk &lt;=
<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.co=
m</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 2 ++<br>
=C2=A0qga/commands-win32.c | 3 +++<br>
=C2=A02 files changed, 5 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 636307bedf..359a56be81 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qmp_guest_fsfreeze_do_thaw(errp);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_THAW,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 038beb8cfa..7d8e260e1f 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0qga_vss_fsfreeze(&amp;i, false, NULL, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
+<br>
+=C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return i;<br>
=C2=A0}<br>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div>
</blockquote></div></div>

--000000000000bbc10e062bbeb64f--


