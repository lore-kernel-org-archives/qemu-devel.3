Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD8CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDP2r-0006hn-Pt; Fri, 09 May 2025 10:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uDP2p-0006ha-Ea
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:49:47 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uDP2n-000261-Ij
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:49:47 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-476ac73c76fso24307881cf.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746802184; x=1747406984; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amIBs7+NO/jZ6NNNkfbVzMigRhMOvpUrUqPpx38w5tc=;
 b=eB+gsQ4Bz7kQCg34qD6P/ncYe6vVBP2S6OUKFx9mXxcpANiXG/xEq+gusANHBGXCH0
 n8sJApFkQBFO2WspTf8hjCjRfcwbFsLS20fCd5djCeWHBowYwiIZdzN4MPnxlGnq7maD
 9i97NQrx2V/kjzeTFDLtchdz6GhPs2L5yNLA9mRxyKiOox2HdtsSzchA6tZrWVxj3Yd8
 ceEzSgJMo543OmQR2pwC1KIeuTg+gdSkKfhnq0wZ5kulhSdYPzh7h62EC1yewSG9EDjF
 /fMsJxTAgVlvyFWuWpIQtw4jq5Tewnv+vcK5qy/cWec+6u96g9GfiBFj+jNHVl38rr2c
 EO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746802184; x=1747406984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amIBs7+NO/jZ6NNNkfbVzMigRhMOvpUrUqPpx38w5tc=;
 b=LsHN7t01lMqSDxq+6fX2hF0JO0Tk28Gs1bMzUC6tD/ZL8PjgDbUManHN8Yw0Y35kJY
 kVMsVBqQh4kdbV7Z3w8tysELZZGwTG651tJmnzw9wZZS0pVbw1vBz9g8/ooorqkrg8rq
 +HNszC1OoaOFFZAUy1aRmPz8pDX05tWb/BwzTKmhxWKpAhKmfDjPy9eCmeaDqp9yCBT1
 XDJsbXEfgBy4zFNamP2ZZlGdum1Z/oqOE+m2+fbThk5GaznjbSwDZdv/M+aJXKGVTG9c
 X7ggp0jOZZwwRQ0LVxKNLyy3s/gdgmGLSqdZGYrXv5sjxe6OA4W3Pea0ajGT9Lg8pRU8
 S+kA==
X-Gm-Message-State: AOJu0Yz1k2rOvhLV0InQtuSXOvs9LiUQWBEsNbeocIwyQQDNlYJpnP6x
 KRVOwc8brJSAl92AR7lEaXOUE8xDMThMlAB/M5LG+vme/ApJLwa4KHxRUx9aLilAkrUMJv5GxwM
 CAKAEBZFo7zsMJwwkrATfP/OPlCk=
X-Gm-Gg: ASbGncskBFBQaI1OnIIVwrT5ZBJkkDjExviWVEPk3Tolw5Y2TCJmzcfYow7bS/NzNIu
 H7fNz3EVi3qD9z/C/URCt+e5JBpXIbr4/l4y/8F0pPuwWYWE5ehoe+ABeGx+mEqSah8TcCCJgEP
 xThtg/3/Tg8sdiQYRr/aPRV9s=
X-Google-Smtp-Source: AGHT+IG5KjuzRe5fUI1BHIDE+cdvqo9EeWnT9H89C8KHX0fove4yl3axIpMCRVRjO0IQToQt3IgwZt5tXfo2bS/XoqY=
X-Received: by 2002:a05:622a:178e:b0:476:77ba:f7 with SMTP id
 d75a77b69052e-494527f3caemr38144181cf.34.1746802183784; Fri, 09 May 2025
 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
 <20250311155932.1472092-7-marcandre.lureau@redhat.com>
 <aB3nc9Dd0HDAFbTQ@redhat.com>
In-Reply-To: <aB3nc9Dd0HDAFbTQ@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 9 May 2025 18:49:32 +0400
X-Gm-Features: ATxdqUEMM8PBNhr0HAqbJKA3c-T1kWmg5BliQviDVI--bhG7cish43bZFHgTdIE
Message-ID: <CAJ+F1CLct2nbad7Y_fmMN71ZdSOLAoQO=8Ub6KGjbGCgLmKYOg@mail.gmail.com>
Subject: Re: [PATCH for-10.1 06/10] ui/vdagent: replace Buffer with GByteArray
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Fri, May 9, 2025 at 3:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Mar 11, 2025 at 07:59:28PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Buffer is slightly more advanced than GByteArray, since it has a
> > cursor/position. But vdagent code doesn't need it. This simplify a bit
> > the code, and migration state.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/vdagent.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/ui/vdagent.c b/ui/vdagent.c
> > index 724eff972f..ddd8990318 100644
> > --- a/ui/vdagent.c
> > +++ b/ui/vdagent.c
>
> > @@ -177,9 +177,8 @@ static void vdagent_send_msg(VDAgentChardev *vd, VD=
AgentMessage *msg)
> >          if (chunk.size > 1024) {
> >              chunk.size =3D 1024;
> >          }
> > -        buffer_reserve(&vd->outbuf, sizeof(chunk) + chunk.size);
> > -        buffer_append(&vd->outbuf, &chunk, sizeof(chunk));
> > -        buffer_append(&vd->outbuf, msgbuf + msgoff, chunk.size);
> > +        g_byte_array_append(vd->outbuf, (void*)&chunk, sizeof (chunk))=
;
>
> nit-pick, QEMU style doesn't usually have a space between 'sizeof' and '(=
'

indeed, and it didn't pass checkpatch! thanks

>
> > +        g_byte_array_append(vd->outbuf, msgbuf + msgoff, chunk.size);
> >          msgoff +=3D chunk.size;
> >      }
> >      vdagent_send_buf(vd);
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

