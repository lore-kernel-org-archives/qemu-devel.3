Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A265C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 20:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1sus-0008VW-DK; Mon, 07 Apr 2025 16:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u1sum-0008Uv-HO
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 16:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u1suk-0000VI-Ug
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 16:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744057067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGNldgy0s6H6wZHd7VQwrEi89CO3t9E7WRFV51Q63H0=;
 b=Utexs3p1QOj15B3TDj684pjnU3XqtAelYIAbm2leaUf8I89/nNH/jjrWjJKSJNWmMW1hal
 XTJ8FF3QqppW74Eth9B03fqKPkhIiZJ7RT83h8M16wloQTYR+YJk72Bbw412T/5PBW9P9i
 4C0YQ9EbHpphC6ucoIsjAGVpvWVTPic=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-xHk8BD2PMfSBNIqR32DnmA-1; Mon, 07 Apr 2025 16:17:43 -0400
X-MC-Unique: xHk8BD2PMfSBNIqR32DnmA-1
X-Mimecast-MFC-AGG-ID: xHk8BD2PMfSBNIqR32DnmA_1744057062
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-476870bad3bso85375631cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 13:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744057062; x=1744661862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGNldgy0s6H6wZHd7VQwrEi89CO3t9E7WRFV51Q63H0=;
 b=KKa9AEv9E8pSGdDFRgzYWUyiOnqAdBeGQ7zfpmy+kfqeV+gy95Cz/pJiF1IbO5LcLh
 A+lkoBjh75qPr0RelB8l9thCRTGgq1OErG2hwProSReu8STXQWVCN2dy2ncYJt6jTOEA
 0cGkm1pfCsfhOPOVgYTaZWs+WUZn+wPk72nv2S04FwyNF1Iqdp7BVSlg+AZBy+ZtRBco
 JlNbFVaEvxDElIAVBiE3NBqQV7TNIgaUKUmaDsWJ9k81UYzfMylK1oeS1Ci2FfLRvwjZ
 asPhcAuZY08+b5ZcXwo6sOOtSt3dNL/qAhFRC8+QTPrv1GhMSBOCrq3nMUuSTlxTykRy
 gWMw==
X-Gm-Message-State: AOJu0Yw/X8t9Y6jAIlibZMSTAvTYEwPav5JjsF/v9MXHFwI6VtqcHw+o
 2RDuuQygcNhM1rTD2REOB54uvm2qpkLmB4f0l1Pyh4UQXxdtTKwWD6CfzuAZXbt71fjl47FBffy
 Va8BxUl68jioOzIkCp+Lh1o0bvEkwYbiGFOUNW+GAvWn3V01GmFbg/wqThmjNYGM+DCF83q36Y1
 NGxCRjLEDEw5Jaq92xEvZRCjkOt4fXH4qznK+hIw==
X-Gm-Gg: ASbGncsdfryh4CyOTPWU1kDCxHlBQrYr5onheD21e1Vxttmy7SQfR6mG33rwYkC6vl6
 eYQ/P+zFMwBr4aq63GGPfd1aE38CRRXscYqrIsg/juFBQbe7aF029ReNsAEUYAFvXDhcRQxDd//
 0HPms2SO1IrzlwsIs0suC/eZrXZqJSMg==
X-Received: by 2002:a05:622a:19a4:b0:477:1e66:7442 with SMTP id
 d75a77b69052e-4792490fb4bmr227887131cf.5.1744057062012; 
 Mon, 07 Apr 2025 13:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrLiN1tRpgCv6AvWgomktuDPj+Mz0JQz6iOud6MeoAlqY479u+6QKD7f4DgqMDPEjEKRze+d369bIMbToZOOY=
X-Received: by 2002:a05:622a:19a4:b0:477:1e66:7442 with SMTP id
 d75a77b69052e-4792490fb4bmr227886851cf.5.1744057061733; Mon, 07 Apr 2025
 13:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250407105939.1997660-1-dietmar@proxmox.com>
 <20250407105939.1997660-3-dietmar@proxmox.com>
In-Reply-To: <20250407105939.1997660-3-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Apr 2025 00:17:28 +0400
X-Gm-Features: ATxdqUElhfQfPNXsCeHA8Kv84yP0aR16Z1slZInnCLs55t35b8paO6BHyYhMnsg
Message-ID: <CAMxuvay-=cWipdXFz7+wHBQW7MWit0NtEC0Rn_p_ZNf5xX6AHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vnc: h264: send additional frames after the display
 is clean
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Apr 7, 2025 at 3:06=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com>=
 wrote:
>
> So that encoder can improve the picture quality.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 25 ++++++++++++++++++++++++-
>  ui/vnc.h |  3 +++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 2e60b55e47..4ba0b715fd 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3239,7 +3239,30 @@ static void vnc_refresh(DisplayChangeListener *dcl=
)
>      vnc_unlock_display(vd);
>
>      QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
> -        rects +=3D vnc_update_client(vs, has_dirty);
> +        int client_dirty =3D has_dirty;
> +        if (vs->h264) {
> +            if (client_dirty) {
> +                vs->h264->keep_dirty =3D VNC_H264_KEEP_DIRTY;
> +            } else {
> +                if (vs->h264->keep_dirty > 0) {
> +                    client_dirty =3D 1;
> +                    vs->h264->keep_dirty--;
> +                }
> +            }
> +        }
> +
> +        int count =3D vnc_update_client(vs, client_dirty);
> +        rects +=3D count;
> +
> +        if (vs->h264 && !count && vs->h264->keep_dirty) {
> +            VncJob *job =3D vnc_job_new(vs);
> +            int height =3D pixman_image_get_height(vd->server);
> +            int width =3D pixman_image_get_width(vd->server);
> +            vs->job_update =3D vs->update;
> +            vs->update =3D VNC_STATE_UPDATE_NONE;
> +            vnc_job_add_rect(job, 0, 0, width, height);
> +            vnc_job_push(job);
> +        }
>          /* vs might be free()ed here */
>      }
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 7e232f7dac..e1b81d6bcc 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -236,10 +236,13 @@ typedef struct VncZywrle {
>  } VncZywrle;
>
>  #ifdef CONFIG_GSTREAMER
> +/* Number of frames we send after the display is clean. */
> +#define VNC_H264_KEEP_DIRTY 10
>  typedef struct VncH264 {
>      GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
>      size_t width;
>      size_t height;
> +    guint keep_dirty;
>  } VncH264;
>  #endif
>
> --
> 2.39.5
>


