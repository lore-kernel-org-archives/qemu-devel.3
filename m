Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC6606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CE7zBIXU;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AOixFwbl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzKL-0004Po-7q; Wed, 28 Oct 2026 04:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzKI-0004PZ-EX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzKF-0001Wp-NQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793177281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+9aLvB1RuuxII+0zo8NEgsU3gsl4dq3skplawlMP7Q=;
 b=CE7zBIXUdjuKM0Mu+vhQQVPLkrRDJ6bfZPYTDBkuw7Map+8bdrJuAPYIy8qX2yYQpJN9tq
 R9GLNR03ureULsZaPwVIZO/fYey+9o3/eFQjAZ+UFFXIGpVaZ8H6dxENdJKzTPnSTFdxd1
 P3GG2OLXS5ucZHP51Y2c4MCw79bdEFA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-kVZDjtVtNfacnSGL9TQ_Uw-1; Wed, 28 Oct 2026 04:47:59 -0400
X-MC-Unique: kVZDjtVtNfacnSGL9TQ_Uw-1
X-Mimecast-MFC-AGG-ID: kVZDjtVtNfacnSGL9TQ_Uw_1793177279
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c046843f1so21768676d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177279; cv=none;
 d=google.com; s=arc-20260327;
 b=pZh3WV39QuzFXd9Sqx7Jsk6KH5BDS7uLH4tTP4KR5wf/7lIvXhSW/J9NJDjFeOV10d
 jof4Bd5fiS/9NIN+PFcSS9kZMV2AznQCdjIHZmsO8RzDrv0VnlXyNPhPaP8KqnMJXIv0
 UGDdwBJOXU5UYRpN5J6YjZ8IymFn74IsAugTPjlvpJSJ86wXgZiRWGmIwTw7cJiBgdrD
 M9Uz9W+fAOSWTAXBIGpGIcnqLvDVlJIiqaprzFCkEVtM/AEynoaCoWA//3Iir22WWW+q
 8qU5fNZ4vKwYmDQa9Eq9lG34QatgK1MQkl6uhJ98fUMMhfQNqzAOeSfdVXoJ5TbT5de/
 0TYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X+9aLvB1RuuxII+0zo8NEgsU3gsl4dq3skplawlMP7Q=;
 fh=M3lwqBfPj8IpPPJDfKNS3GIiHKlZXgAdyJBNlClwCT4=;
 b=GgIS/ABMBMO1QKwDCyw8Q4TE1g9FtsOoU5Akc03WiLM4Rd++LJmOUE22476PIipAq4
 9lwaj3bXHQVJhly38ZJ3VO8LGaytOx7K4T8qc97jmmzT3EKfMKunV2UCbwb9Ob+cgRzv
 0xvWa6a1VsGh9ULaX/myrZElEyL1viZ9TXKpVaQ7ZmEGK1sIB1/5uFKCkmPEt+N7IRzk
 VQkf1YHbFy0LCY7LFpCaZnIDbTNUuYMGvIoMKupoMnuse/2SNpWLMlOiXSNlrxrxuKAB
 7NgYF8iabu2VKRisldlAQRU6FDsT84OVhQjJpBWR2zHw07dScXtg/xtDe+FIKFDe+ePI
 1T0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793177279; x=1793782079; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X+9aLvB1RuuxII+0zo8NEgsU3gsl4dq3skplawlMP7Q=;
 b=AOixFwbl37YsTR0Un//xto8tD+3sjGQnCzwHJE7ielx865sJuVROrTiu8/WmrL4VGl
 EHjNJFh0eVKlvLDRCiwsuKDsmW5WGNnyKQWykF0IK4CUUI0Ww41ntk7ls4CgB2bOjbnp
 dpPUV8DUNrlQ7dwd7OHPsvV1PcdIvI1Uss2AnstWIyE+FPe+d06bEdHC75UGpA+o3o/V
 prafuKIuNH7csB67yQg/ELKUnoFU1AFhWXPAHFnOMwTn5TEhJ25NZnOZmJoIR6f8FxW2
 67r2gl+BJ06pMBB61Lvoc2Vx5OxXDViqrBcKPKjECNlW9t/87MmkeXtIpjjNs02ioBqb
 i/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177279; x=1793782079;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X+9aLvB1RuuxII+0zo8NEgsU3gsl4dq3skplawlMP7Q=;
 b=sH+wjRb3x1aTUotnXNc7yM8B4uwFsWLbHaK6eHuFvS+ULCZWR2kM0YZfcyVH7L2LgI
 Wfn1hpXpt20V5s7ApO4o3eCqQmYjsSP6USZUFOtrqkI5xpxfnCoQHOjmt4EYc8AHP0/l
 ZBB/ARSNqStMrRo+vmtDeVPmval7sZaIMjWj3qvA1G5C45cj0RfBgnP9RWyigJXlPJyh
 uz6nvy5LBY8lpJ/W751XkcWouAmzK98U/npQ4zkhncFqEVhO5+upPF308eLwgqPeORyr
 Nq59msUFD2jqKXVLc6XkNMhfuDB04cLLyx6pSakl+Fe6o4X4YYUyktsVeNzGH5+WloWF
 p/iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxCSC8I9Z9HM9T8P9wg3UQpWq+Kzrxe6nbh5xvGB5vxvSgPOTgrL7Sji2hPQ8hUVUZiOLmwp+owly0@nongnu.org
X-Gm-Message-State: AFq9FYIbMK4TwpiPckykuP6Cs6yLEtSYm9gPy51iUNYRTv/0Qstnsm5P
 YU8w0qD0a18zimiXAi0J1K7r2en8gSQKOcwKGBvGhfm/InSERkvuehk4nRxIofUQwQByAnFePnY
 8V34wL9B4LcFCQ3gQFbTFz+yiQU+EgffedUV4XMdF76yUvMupZJ7bHPmBqb1+vosJKz9kjZ5C88
 xZzpO0P1zeniSwEq4U6z7nPmjbp2MqtLs=
X-Gm-Gg: AYBFou22MWXOuPkJ9wvI7y+ZELUXgFuIJIBADcV2t6ekbEVOoai1cBA4tT3u4vgrfYt
 f6GfZ+3qLLBP5pjxT3qukwZBT50Q/6eKGmn8s4gpufA+Yx5hLx5P1arpKlNUpX0CErssd2NezYi
 wdyUvNjq2zyxeOfAXjp0Yh/ASF4Fz0x7sMJ9jHOeNdYwyF6zzRR4ukF9A3O3auqlcf7P71aK5A/
 HPgFxBk+/GMO5pWn0U=
X-Received: by 2002:a05:6214:3007:b0:90e:8221:f1c7 with SMTP id
 6a1803df08f44-91c7ce0e8camr27903536d6.1.1793177279042; 
 Wed, 28 Oct 2026 01:47:59 -0700 (PDT)
X-Received: by 2002:a05:6214:3007:b0:90e:8221:f1c7 with SMTP id
 6a1803df08f44-91c7ce0e8camr27903236d6.1.1793177278518; Wed, 28 Oct 2026
 01:47:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261009-qga-file-read-typo-v1-1-40c462aefe12@proxmox.com>
 <4259329e-f503-453a-87d2-fac5da4ce3c9@oss.qualcomm.com>
In-Reply-To: <4259329e-f503-453a-87d2-fac5da4ce3c9@oss.qualcomm.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 10:47:47 +0200
X-Gm-Features: AclHuK_FgL2I2rTmi-b9B7TJDYaEUMsWBYJpSDkfwD4ybCorTHNbt5mrtOkhXN0
Message-ID: <CAPMcbCo3vnMrz+xUVPZNtLchiGmXKbYPjhT1VnkBEpqw64XVrQ@mail.gmail.com>
Subject: Re: [PATCH] qga: fix typo in guest-file-read warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b4a57f065ee29eee"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b4a57f065ee29eee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Fri, Oct 9, 2026 at 1:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> On 9/10/26 11:16, Fabian Gr=C3=83=C2=BCnbichler wrote:
> > seems to have been transformed from "read" to "write" during a refactor=
.
> >
> > Fixes: ead83a136d54 "qga: Extract qmp_guest_file_read() to common
> commands.c"
> >
> > Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> > ---
> > Stumbled upon this while browsing through the code for unrelated
> reasons..
> >
> >   qga/commands.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>
>

--000000000000b4a57f065ee29eee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, O=
ct 9, 2026 at 1:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/10/26 11:16, Fabi=
an Gr=C3=83=C2=BCnbichler wrote:<br>
&gt; seems to have been transformed from &quot;read&quot; to &quot;write&qu=
ot; during a refactor.<br>
&gt; <br>
&gt; Fixes: ead83a136d54 &quot;qga: Extract qmp_guest_file_read() to common=
 commands.c&quot;<br>
&gt; <br>
&gt; Signed-off-by: Fabian Gr=C3=BCnbichler &lt;<a href=3D"mailto:f.gruenbi=
chler@proxmox.com" target=3D"_blank">f.gruenbichler@proxmox.com</a>&gt;<br>
&gt; ---<br>
&gt; Stumbled upon this while browsing through the code for unrelated reaso=
ns..<br>
&gt; <br>
&gt;=C2=A0 =C2=A0qga/commands.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.q=
ualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000b4a57f065ee29eee--


