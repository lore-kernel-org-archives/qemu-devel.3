Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4440606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3Kjuw5z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPxm-0000T8-Bk; Tue, 17 Nov 2026 15:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xTPxk-0000Sr-HS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:39:32 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xTPxi-0003u3-Gz
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:39:32 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4d28f75d62so27220466b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 12:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794947968; cv=none;
 d=google.com; s=arc-20260327;
 b=ASXCwliCV0hMYQmt8AdgWxW5ds0YOWyA3RBGzCCbS9QgHD+SI4xkRCO/2Ts6TXIrOI
 2HdMpyJrcPkTH8McBox9V8Yd9iuFbhw0jzhM3c1Opx/Z77I56Nk4VbpN4GoQSuKfM9nf
 Vc/g+ourWVQXpMWMX+1zijpC5VEYuAgT4tYQ9CKlAMYpC+bg/X+miKPaPcVvbmHXCYEh
 Fx4cWCo8cJLAKbW96r8616QDyIuR1Sn+lSATxOlrFKvy3vtbtSxAe9nrqlPxCcaTXZtY
 GdvKGN1qv29jWtEc1zE8SXApqvkcmaH9ntHconFykY1GHGE2l/B0WJyaP6Jbbe4ZpDtp
 ehwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nuqglsj7S0Oo8qX9BRP8HtzJZtpJNifhet9Oac7fdkg=;
 fh=29/Ntc7ys/VsX3JjAgdGNVdCTIp6b2lYprZJb50Y3UI=;
 b=QV1fMqJEdGgCzYxMhAt/Mf57ZGfCUofrKBj1B1o7GBHEq+/Z88W4zG8F1O8iTT069P
 03L184S4gIKTUn7dZM1lvMy3GTRUZ7bJ9dbNPk6DKvITH5AiAfTFdKolU4cbqL+VZf94
 4s3lq7ciwrDHe8zf+Y0yipnrB/7colpd8XemxHiaSe6YRHv/P1sIS+LNazcab5e/mS36
 WKpwdE+rqEDs+Y5o1Geikpw0Uj49HNysonreGuvo5O8dYfrnKHg1WybWLVWOgLs3QMgf
 2rD8gwR2wKbqJGTz9bgO+4jrWvGsZNXGvyZ8mfzrTm2vpM1zkB/cPHEzsNMsE9S1gzf8
 U1SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794947968; x=1795552768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nuqglsj7S0Oo8qX9BRP8HtzJZtpJNifhet9Oac7fdkg=;
 b=B3Kjuw5zv+vmWBrDqFBB8ClspvNnc1KfjWccVgBsZ2DmhOU8GfksFYcVQoBXmIb/nZ
 hMwxYFIZikZU74Aq2zCPa/ntmK88oGQU7ocDDa6rbCY7KGzPaNgSc6MsMRYF0Wv9nIMb
 3RW2KpVUBcVFZhIFw/JrEB12Sba0CHxX3swYKLZm7gLXXmj9I1wQjipNsu2wXgoP1knr
 rWoZF63TwcdBiHiMtQPRfpLuw0UfkdUrRnZhdpePdX544zhPw3T58rzfZPGg+by1d6uh
 bR6pQAAnzPumhZKExMbXTD95jJp2a1dizBI2nVwgZBEYNje9A7v0b8uarH1sJ3Rw6zzh
 0HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794947968; x=1795552768;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nuqglsj7S0Oo8qX9BRP8HtzJZtpJNifhet9Oac7fdkg=;
 b=nectzeldlGQ7ueP/lT3h+oGNEhfSCoWz4Pd5T7nzkH4EXZDw4U+b/cjqifLlhT8tqw
 53nUKxhEujfjsF2rw/fNfohILir9v0mJ9podeGaVMa5spPsVZlU9gzCaEuTGLAp8qEWX
 uwWFhSmFXriB1YxZFkF/854ZdscyP8pThIg4xRyzUYEFUSLEXQeuBLKvzrRaXkiCmxej
 iZr4X4P+9+fzP9Mi9zWMOweTMlHPd+BaiGmWs7Hlz6UvNavlPI5vU05r7ZIcxLj27hid
 lZWzAn3Srdb5aptiKab4mggg3dSkRRufbKMF0ma7NFElVkeZgQk5YmWgJUWOTpWbEGPm
 jN/A==
X-Forwarded-Encrypted: i=1;
 AL+hErGG0uthrvdtDU3VmA2C+jm6V9s66v0JaLMUv+rpnHVlItyORpaiKa5l3rrGCVl9KR5nFKSJK4KKbbkA@nongnu.org
X-Gm-Message-State: APuU4Z9qca1CgXcHOAQk1Z5CalYb6BEY1UdVj9ml20ozwA5Ii8WQL0FG
 kRL+pwNWF9DcHuevCQJmYSZfZUL5i5o1nFGvOR8n2qwRW5/dOgeC8ZSDEBlL5cZveLloLsz/ZTF
 eIY1hxSoVIxa332WxSeOlGV/fltenOSA=
X-Gm-Gg: AYBFou3uku5dQeU3y4sawYi9+dR3OaMNziJDsL4d2wJ3iQCzgXPVnRehW5lbnV9t4IA
 pmmdr+MmCFUXiGvL+FmhdlD6qEcQS+W7goN9Oo3ThxJpDC44kcTN/gFu2h5yBlPKqMOro4AdVch
 KeLEH2j2tmjZfatbUUIaXeKSawMLiTP2u93VyXe+fu3hZ4vnBz1Ymvxl0fZAS5dumR6mXpevdc+
 iXtR7p9+szvB2IYNU1seNdUXBX5W2XxPWmdECttOexZNcTGfrcusUnzopM44aFUjsOPVuNy7cpc
 +y9d1VgsjccTcBbCs+noirtQ135mWsSubFKC217lJyIA6v91iNOcc9yWfmMwAka0Pvm5NVXOUJh
 kvs8oxE0RNW8SJKyVdZvm71tsVLoAOWMsnJdQxMeUpezA0y2BXvJ+hnIppe5+jPV9d1ar6PTe11
 3EqB+V4+5SGfE4sQ2kz2E=
X-Received: by 2002:a17:906:7953:b0:c2d:bd87:7fa7 with SMTP id
 a640c23a62f3a-c510e379d33mr36915266b.24.1794947968205; Tue, 17 Nov 2026
 12:39:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101150847.29157-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261101150847.29157-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Tue, 17 Nov 2026 21:39:15 +0100
X-Gm-Features: AclHuK-g-EiLZBhVaSob9-DD-NzmLxDpaPvp6lCGuMt1wh2bCKYQBWTM6kvr8gM
Message-ID: <CA+xk8n8vg27FBmsSgTxwOmbRW1eNhjs+QOC8POH4OmP=8A6o4A@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/kvm/xen_evtchn: use lock guards
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=drifabdelmalekmohamedsaid@gmail.com;
 helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,
Just following up on this patch to see if anyone has had a chance to
review it or if any changes are needed.
Thanks,
Drif Abdelmalek Mohamed Said

On Sun, Nov 1, 2026 at 4:08=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> Replace qemu_mutex_lock()/qemu_mutex_unlock() pairs with
> QEMU_LOCK_GUARD()/WITH_QEMU_LOCK_GUARD() in functions with error paths
> and early returns: xen_evtchn_bind_pirq_op(), xen_physdev_unmap_pirq(),
> xen_be_evtchn_bind_interdomain() and xen_be_evtchn_unbind().
>
> No functional change intended.
>
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
>  hw/i386/kvm/xen_evtchn.c | 82 +++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 51 deletions(-)
>
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 9379383e53..c0250cb357 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -1293,20 +1293,17 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pi=
rq *pirq)
>          return -EBUSY;
>      }
>
> -    qemu_mutex_lock(&s->port_lock);
> +    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
> +        ret =3D allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
> +                            &pirq->port);
> +        if (ret) {
> +            return ret;
> +        }
>
> -    ret =3D allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
> -                        &pirq->port);
> -    if (ret) {
> -        qemu_mutex_unlock(&s->port_lock);
> -        return ret;
> +        s->pirq[pirq->pirq].port =3D pirq->port;
> +        trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
>      }
>
> -    s->pirq[pirq->pirq].port =3D pirq->port;
> -    trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
> -
> -    qemu_mutex_unlock(&s->port_lock);
> -
>      /*
>       * Need to do the unmask outside port_lock because it may call
>       * back into the MSI translate function.
> @@ -1919,27 +1916,24 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_p=
irq *unmap)
>      }
>
>      BQL_LOCK_GUARD();
> -    qemu_mutex_lock(&s->port_lock);
> -
> -    if (!pirq_inuse(s, pirq)) {
> -        qemu_mutex_unlock(&s->port_lock);
> -        return -ENOENT;
> -    }
> +    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
> +        if (!pirq_inuse(s, pirq)) {
> +            return -ENOENT;
> +        }
>
> -    gsi =3D s->pirq[pirq].gsi;
> +        gsi =3D s->pirq[pirq].gsi;
>
> -    /* We can only unmap GSI PIRQs */
> -    if (gsi < 0) {
> -        qemu_mutex_unlock(&s->port_lock);
> -        return -EINVAL;
> -    }
> +        /* We can only unmap GSI PIRQs */
> +        if (gsi < 0) {
> +            return -EINVAL;
> +        }
>
> -    s->gsi_pirq[gsi] =3D 0;
> -    s->pirq[pirq].gsi =3D IRQ_UNBOUND; /* Doesn't actually matter becaus=
e: */
> -    pirq_inuse_word(s, pirq) &=3D ~pirq_inuse_bit(pirq);
> +        s->gsi_pirq[gsi] =3D 0;
> +        s->pirq[pirq].gsi =3D IRQ_UNBOUND; /* Doesn't actually matter be=
cause: */
> +        pirq_inuse_word(s, pirq) &=3D ~pirq_inuse_bit(pirq);
>
> -    trace_kvm_xen_unmap_pirq(pirq, gsi);
> -    qemu_mutex_unlock(&s->port_lock);
> +        trace_kvm_xen_unmap_pirq(pirq, gsi);
> +    }
>
>      if (gsi =3D=3D IRQ_MSI_EMU) {
>          kvm_update_msi_routes_all(NULL, true, 0, 0);
> @@ -2078,7 +2072,7 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn=
_handle *xc, uint32_t domid,
>          return -EINVAL;
>      }
>
> -    qemu_mutex_lock(&s->port_lock);
> +    QEMU_LOCK_GUARD(&s->port_lock);
>
>      /* The guest has to have an unbound port waiting for us to bind */
>      gp =3D &s->port_table[guest_port];
> @@ -2095,15 +2089,14 @@ int xen_be_evtchn_bind_interdomain(struct xenevtc=
hn_handle *xc, uint32_t domid,
>              if (kvm_xen_has_cap(EVTCHN_SEND)) {
>                  assign_kernel_eventfd(gp->type, guest_port, xc->fd);
>              }
> -            break;
> +            return ret;
>          }
>          /* fall through */
>
>      case EVTCHNSTAT_unbound:
>          be_port =3D find_be_port(s, xc);
>          if (!be_port) {
> -            ret =3D -ENOSPC;
> -            goto out;
> +            return -ENOSPC;
>          }
>
>          gp->type =3D EVTCHNSTAT_interdomain;
> @@ -2113,24 +2106,16 @@ int xen_be_evtchn_bind_interdomain(struct xenevtc=
hn_handle *xc, uint32_t domid,
>          if (kvm_xen_has_cap(EVTCHN_SEND)) {
>              assign_kernel_eventfd(gp->type, guest_port, xc->fd);
>          }
> -        ret =3D be_port;
> -        break;
> +        return be_port;
>
>      default:
> -        ret =3D -EINVAL;
> -        break;
> +        return -EINVAL;
>      }
> -
> - out:
> -    qemu_mutex_unlock(&s->port_lock);
> -
> -    return ret;
>  }
>
>  int xen_be_evtchn_unbind(struct xenevtchn_handle *xc, evtchn_port_t port=
)
>  {
>      XenEvtchnState *s =3D xen_evtchn_singleton;
> -    int ret;
>
>      if (!s) {
>          return -ENOTSUP;
> @@ -2140,12 +2125,10 @@ int xen_be_evtchn_unbind(struct xenevtchn_handle =
*xc, evtchn_port_t port)
>          return -EFAULT;
>      }
>
> -    qemu_mutex_lock(&s->port_lock);
> +    QEMU_LOCK_GUARD(&s->port_lock);
>
> -    if (port && port !=3D xc->be_port) {
> -        ret =3D -EINVAL;
> -        goto out;
> -    }
> +    if (port && port !=3D xc->be_port)
> +        return -EINVAL;
>
>      if (xc->guest_port) {
>          XenEvtchnPort *gp =3D &s->port_table[xc->guest_port];
> @@ -2164,10 +2147,7 @@ int xen_be_evtchn_unbind(struct xenevtchn_handle *=
xc, evtchn_port_t port)
>
>      s->be_handles[xc->be_port] =3D NULL;
>      xc->be_port =3D 0;
> -    ret =3D 0;
> - out:
> -    qemu_mutex_unlock(&s->port_lock);
> -    return ret;
> +    return 0;
>  }
>
>  int xen_be_evtchn_close(struct xenevtchn_handle *xc)
> --
> 2.47.3
>

