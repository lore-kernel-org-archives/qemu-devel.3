Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0FD1AD47
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 11:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1237-00084g-No; Wed, 16 Oct 2024 07:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t1235-00084X-4F
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:18:39 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t1233-0002KT-HA
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:18:38 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46094b68e30so2178971cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729077516; x=1729682316; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cmvu3+VMObOGdTc1gFCZlNX1RDGERbNVKFCv5EiaQy8=;
 b=B9Fjf5mD3/KiO5WUe/9junBLwfsGoy9fUiwL9b7v6UuUZV0jsy5LUHnTdfc6/zVkV7
 JkhBeTKtuo7PBeHhIZYJSBcDDlS7bSLvOZILJPGOgoUKvROf/pR++6kfKi1BmmEjRVWt
 eWH06tq6+wspvesW0m/lagbMNFa4hZLWi6nmy4eb9z01vuyg0QOFCU4YUBsW8NKSsKmA
 eA4VF0ZRpDYjmw5PkR88Sd2wcFRte3p2Qwjfc6mZxKK/KYgguoYAWOmNtuNWuSWlRw0E
 pu73IV6nUV48HaNVL/7vCqiDI17Y3ZkDnvQrFNILuleQXXkwSsGHmbZdWb/4HOuuzeEd
 kttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729077516; x=1729682316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmvu3+VMObOGdTc1gFCZlNX1RDGERbNVKFCv5EiaQy8=;
 b=UGcPY+/VIms5ypdaERSp7K7NondDpFDlZ4cGM0avrONVWj0UT3n5WicSUbrHzyCrCV
 uCLt9NMvZiDhmv4UAL+XAv2xCPvHsk27jHYALI5kinYlY3v8oP5HbLvYkS2kmi1S+WOt
 NBxuv/D5qbcrmhqmEYI4gKTSG1fNVgRXhf8owu5wEdX/x/FSEOtNi6B2PUtgCqFjsCJd
 mbgIfUXyQHGQJH6CpJtcbmxGzj1FFgzwvcJnY8B/aI7HPZIkwA3SAHvLSgafxwel1g/p
 O/s3stqHlF3C8TX1rBbGeAFSQywT/EEZNy+vAcee8rBhQR9jrCHzm4wfuUazSUBxVJ2c
 ZxOw==
X-Gm-Message-State: AOJu0Ywjzz433q1cQOsBiiKmuDcv4rhH5LPHtiYSD3NaXKXF8KiN5DYq
 5sT8JOeP7QfGGhUYLcv5oy37/PMs+HUOqEVCIFmbmVTLfAfg7eQPUp+9edKEcNsKSGRMITRxrd5
 2Sj7iDtQsDOq+uEVdc0h9GBOgEuE=
X-Google-Smtp-Source: AGHT+IH8+x3yuSW09BkeCTG2sZI1bg4IsR5ATXVYhU8UfeJgFSHuYFqc3EpnrVFn94remHgtoyY0j7EDKdF9AMvuX4Y=
X-Received: by 2002:ac8:7d8f:0:b0:45d:79af:6a3d with SMTP id
 d75a77b69052e-46058445628mr258746751cf.32.1729077516479; Wed, 16 Oct 2024
 04:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2024 15:18:24 +0400
Message-ID: <CAJ+F1C+MXgWF-k5vVihDePNy9_X2z1H45CQkL-NpMRvChWRHpQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000028b6a50624963b4d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000028b6a50624963b4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 16, 2024 at 3:13=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>
>> This patch implements multiplexing capability of several backend
>> devices, which opens up an opportunity to use a single frontend
>> device on the guest, which can be manipulated from several
>> backend devices.
>>
>> The idea of the change is trivial: keep list of backend devices
>> (up to 4), init them on demand and forward data buffer back and
>> forth.
>>
>> Patch implements another multiplexer type `mux-be`. The following
>> is QEMU command line example:
>>
>>    -chardev mux-be,id=3Dmux0 \
>>    -chardev
>> socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mux-be-id=3Dmu=
x0 \
>>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>>
>
> I am not sure about adding "mux-be-id" to all chardev. It avoids the issu=
e
> of expressing a list of ids in mux-be though (while it may have potential
> loop!)
>
>
(well, the loop can be expressed with an array list as well, and deepen.. I
don't think we have enough sanity check around that, especially at run
time).


--=20
Marc-Andr=C3=A9 Lureau

--00000000000028b6a50624963b4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 16, 2024 at 3:13=E2=80=
=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.c=
om">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D=
"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman=
 Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" target=3D"_blank">r.pen=
iaev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">This patch implements multiplexing capability of several back=
end<br>
devices, which opens up an opportunity to use a single frontend<br>
device on the guest, which can be manipulated from several<br>
backend devices.<br>
<br>
The idea of the change is trivial: keep list of backend devices<br>
(up to 4), init them on demand and forward data buffer back and<br>
forth.<br>
<br>
Patch implements another multiplexer type `mux-be`. The following<br>
is QEMU command line example:<br>
<br>
=C2=A0 =C2=A0-chardev mux-be,id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Ds=
ock0,mux-be-id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \<br></blockquote><div><=
br></div><div>I am not sure about adding &quot;mux-be-id&quot; to all chard=
ev. It avoids the issue of expressing a list of ids in mux-be though (while=
 it may have potential loop!)<br></div><div><br></div></div></div></div></d=
iv></blockquote><div><br></div><div>(well, the loop can be expressed with a=
n array list as well, and deepen.. I don&#39;t think we have enough sanity =
check around that, especially at run time).<br></div><br clear=3D"all"></di=
v><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr"=
 class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000028b6a50624963b4d--

