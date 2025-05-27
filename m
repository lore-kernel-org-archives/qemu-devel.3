Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E43FC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 18:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJyg1-0004pA-RF; Tue, 27 May 2025 14:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uJyfr-0004oh-Ms
 for qemu-devel@nongnu.org; Tue, 27 May 2025 14:05:16 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uJyfq-0006Kh-1O
 for qemu-devel@nongnu.org; Tue, 27 May 2025 14:05:15 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so20620781cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748369112; x=1748973912; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+2k/8Znizkb8hgO2S4nj+hwaYXmmgyB//kiTkJb/As=;
 b=mvSS27lsjANsYBVVsP6x8LuFY7lo4WlDlLJxsYAB8z1MO92bLzpkANPBiAlaftbtO6
 91EYU6QHBNjdAKJ5xBN4O+mQRg+wK+zLpLrorFFsIb1v7OVmf85QnnTMSq+FzFVWsnW/
 apJPZAus+M5a0zoERlWC7mzA2jRr+gFmjmiZtq+035Wd/eZ0WMuRAgPLTnwlHEEFNWLn
 qOKkcny6rU85CzsglYOTxK71ciujzWDgcijE4VgvRVaaD72JmvYT+FcNzh4+uvtW8k3D
 s12nFgOP3JyNiRvGko4H7iaDyHfFbCzewJNdJJkkRHVntjRC6ShGmFh1bVMwWh2xsMJP
 BGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748369112; x=1748973912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+2k/8Znizkb8hgO2S4nj+hwaYXmmgyB//kiTkJb/As=;
 b=vbq7hRWluzcoEJPI/R2uhDhTrK8EiJOP3OsFkvuN3zrEhj+lyqAg2pSLGWWduPBD/a
 9dqwIA3Hf207Yw+gglOZH7gbuOVLm96Ub+IcfGJQjvjMZUuTXC/8QLhAIo28fiGFq3hS
 Cut41bxUZKt7623u0jx/mIdOuHvo8CPvdqvWYYuJwaaPz+QWY3yUCbYIPTKnXyz9ONFl
 UUJOXsDIdlP2jLmT+R/oAueSjd4cKFZeVQNs3RSc/f3fFHpUE0zggPdUxCse1NYLmRmy
 unk8RGF0gYZLj6Tu9bwN3inLntXuwjk/RD4cvam1RBFFc1LodzEJcXPAcnCUoT54hhgp
 hMNg==
X-Gm-Message-State: AOJu0Yz6OVvx4BYYg0j3jRozqEujyURJePOfjsmrQ7SfxSPvzqTNPceG
 uEmLfxWBUmmcron6upU2PXW3KrKRxlkQr3J0nuW0/wehPW+ljKlbnmCWteTIUeDUfuTbL/5gQoc
 A03Uyg2zB4Bi+6/3NirjZmEh6ck+5UFQYixjZ34jLxw==
X-Gm-Gg: ASbGncsulHMhMImKNDSOmT0eSJquTtx2Fefd91Du8d+XRfV7HVJIkKaaoSNCp29kQvL
 NVZVb/mMWz370Mqy7kfVm2C1Kb/c1yhPWYj4+/gCG0BNgHmtCjoJbzNCO8JZb7GXDCv4u9J7/yY
 hH0AgmYxa1190Um4c0YYld/+LvLbeyXTidAMY=
X-Google-Smtp-Source: AGHT+IE3ELvHrvD+3R35QJdJtReyV7xoqA66rLg72KZne2LwnUzDhxAe3KVd7Lc20uKWMshcpHmpmK3+SwX636ZRaYE=
X-Received: by 2002:a05:622a:4c83:b0:476:a949:ceb6 with SMTP id
 d75a77b69052e-49f480c8ea6mr259663301cf.44.1748369111812; Tue, 27 May 2025
 11:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250521151616.3951178-1-jmarcin@redhat.com>
In-Reply-To: <20250521151616.3951178-1-jmarcin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 May 2025 20:04:46 +0200
X-Gm-Features: AX0GCFtoG1BbnlbSC9b7P4JpaIa81ngp1o2qGv4pAXvHlexvLRbXsEkQIDkXdXA
Message-ID: <CAJ+F1C+wEgf8dVF40wJqBWN0vGCNYBv6wx=F3MkF4ua7WTBnbQ@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Wed, May 21, 2025 at 5:18=E2=80=AFPM Juraj Marcin <jmarcin@redhat.com> w=
rote:
>
> From: Juraj Marcin <jmarcin@redhat.com>
>
> If a virtual machine is paused for an extended period time, for example,
> due to an incoming migration, there are also no changes on the screen.
> VNC in such case increases the display update interval by
> VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> to VNC_REFRESH_INTERVAL_MAX (3000 ms).
>
> When the machine resumes, it can then take up to 3 seconds for the first
> display update. Furthermore, the update interval is then halved with
> each display update with changes on the screen. If there are moving
> elements on the screen, such as a video, this can be perceived as
> freezing and stuttering for few seconds before the movement is smooth
> again.
>
> This patch resolves this issue, by adding a listener to VM state changes
> and changing the update interval when the VM state changes to RUNNING.
> The update_displaychangelistener() function updates the internal timer,
> and the display is refreshed immediately if the timer is expired.
>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 12 ++++++++++++
>  ui/vnc.h |  2 ++
>  2 files changed, 14 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9e097dc4b4..32f8bfd1f9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3384,6 +3384,16 @@ static const DisplayChangeListenerOps dcl_ops =3D =
{
>      .dpy_cursor_define    =3D vnc_dpy_cursor_define,
>  };
>
> +static void vmstate_change_handler(void *opaque, bool running, RunState =
state)
> +{
> +    VncDisplay *vd =3D opaque;
> +
> +    if (state !=3D RUN_STATE_RUNNING) {
> +        return;
> +    }
> +    update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
> +}
> +
>  void vnc_display_init(const char *id, Error **errp)
>  {
>      VncDisplay *vd;
> @@ -3420,6 +3430,8 @@ void vnc_display_init(const char *id, Error **errp)
>      vd->dcl.ops =3D &dcl_ops;
>      register_displaychangelistener(&vd->dcl);
>      vd->kbd =3D qkbd_state_init(vd->dcl.con);
> +    vd->vmstate_handler_entry =3D qemu_add_vm_change_state_handler(
> +        &vmstate_change_handler, vd);
>  }
>
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index acc53a2cc1..3bb23acd34 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -185,6 +185,8 @@ struct VncDisplay
>  #endif
>
>      AudioState *audio_state;
> +
> +    VMChangeStateEntry *vmstate_handler_entry;
>  };
>
>  typedef struct VncTight {
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

