Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D58C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUb9-0001wn-Um; Thu, 01 Feb 2024 05:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVUb4-0001wQ-6b
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVUb2-0007gl-2e
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706784422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGsC+FrLvjUHeTKZgghHDH6XUJmz4zk7ctAf8fgtkeo=;
 b=aGpS9uBDo0jVA6vHLgd1tqn48F0VdE74F7nl+bCQO9yJEOyHCeqnFCmXMHZp8z5d2ZmcAn
 fPyICM7xPphSgWpu04cxm2yQdBwtlITMYYJ6pZUTuO07cK35zhNf3GYKma3CAM7vkI3lts
 qJZTMWL6Ec1V+U95dhWg9FxpqSgR/ek=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-B27hbrmuOpW7l2PzwXnDXQ-1; Thu, 01 Feb 2024 05:47:01 -0500
X-MC-Unique: B27hbrmuOpW7l2PzwXnDXQ-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4bddd10a870so1808855e0c.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706784421; x=1707389221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGsC+FrLvjUHeTKZgghHDH6XUJmz4zk7ctAf8fgtkeo=;
 b=dC0eXU7qPn/jqlAp99MMuvf1OADA3Qb7JFSBC3qcZS6VeglCvQypiIk2pcmcVUoOX+
 SwAU6+rQoOB9d3/GOvlGk5tnXOar/gUeW2U43lHF7qIBJfB2vNkGXP6bRbjgAcspc/oo
 G0pEPmb/rovqFESxw3A6QKa05DATLFCb+R1qvsSbGLClLYVedXkrXNHXh3HpmZcucMAu
 5q66PLHRb7DkOf0H2q7khuaFbwjNae/20bNVArplAK1m4HwS1PI8XkVrpLL8te46ptHd
 hHIcQLBvkyDCkL5LmO/b2UN7Jzl4lDUq13J3+22iqc+cq0+o/JRtso3iYleXdhBv67DF
 jv4Q==
X-Gm-Message-State: AOJu0YwdeiJtYf+HlgyqM2eIiXpmgPSSUlo+tpRPBRi65snxI/xVd8oM
 eZRYQPUwKwuaxOpdYOynnPlBhoThizTXgYSWZY0GzHXRuMayCtXtNORniqCkMfCL+PJyKEUWqhJ
 BsFIJczOjW02QtLwj1Zzg6hQfvv82RmvbT81NoKCFvbx2uGM0Itt8tLdJIEKkfQ0IZxOeQFGNof
 l/tH/SGHZZRxBJygBGgEh5T+ze6wU=
X-Received: by 2002:a05:6122:4494:b0:4b8:7a16:b757 with SMTP id
 cz20-20020a056122449400b004b87a16b757mr3937392vkb.5.1706784420936; 
 Thu, 01 Feb 2024 02:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpnRWERAQgiGk1VTWs6UFB2PL1KoEDd291tJESNm5CxffBdUknYKZivi5DfvoK/93OAy8KTF+BpTiPp/On/fc=
X-Received: by 2002:a05:6122:4494:b0:4b8:7a16:b757 with SMTP id
 cz20-20020a056122449400b004b87a16b757mr3937384vkb.5.1706784420619; Thu, 01
 Feb 2024 02:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Feb 2024 11:46:48 +0100
Message-ID: <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
Subject: Re: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu, thuth@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 12, 2024 at 1:55=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Invert the logic so that the end of DMA transfer check becomes one that c=
hecks
> for TC =3D=3D 0 in the from device path in do_dma_pdma_cb().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/scsi/esp.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index fecfef7c89..63c828c1b2 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
>              return;
>          }
>
> -        if (esp_get_tc(s) !=3D 0) {
> -            /* Copy device data to FIFO */
> -            len =3D MIN(s->async_len, esp_get_tc(s));
> -            len =3D MIN(len, fifo8_num_free(&s->fifo));
> -            fifo8_push_all(&s->fifo, s->async_buf, len);
> -            s->async_buf +=3D len;
> -            s->async_len -=3D len;
> -            s->ti_size -=3D len;
> -            esp_set_tc(s, esp_get_tc(s) - len);
> -            return;
> +        if (esp_get_tc(s) =3D=3D 0) {
> +            esp_lower_drq(s);
> +            esp_dma_done(s);
>          }

I'm only doing a cursory review, but shouldn't there be a return here?

Paolo

>
> -        /* Partially filled a scsi buffer. Complete immediately.  */
> -        esp_lower_drq(s);
> -        esp_dma_done(s);
> +        /* Copy device data to FIFO */
> +        len =3D MIN(s->async_len, esp_get_tc(s));
> +        len =3D MIN(len, fifo8_num_free(&s->fifo));
> +        fifo8_push_all(&s->fifo, s->async_buf, len);
> +        s->async_buf +=3D len;
> +        s->async_len -=3D len;
> +        s->ti_size -=3D len;
> +        esp_set_tc(s, esp_get_tc(s) - len);
>      }
>  }
>
> --
> 2.39.2
>


