Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3A60A262B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWLg2EfK;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VrS8Gu/8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRV23-0000fB-23; Thu, 12 Nov 2026 08:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRV1X-0008ID-Nr
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRV1V-00026w-Ql
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NILj5bb2Nn1aI8eODnT9FcRGCzgPWojm49BJ6cezxF0=;
 b=VWLg2EfK+YL0w3JhO+mZkX1H/dsDgV2nl5U40eOxQ7AvMa+4aT6SMLpk9fQ80L98zDnfAR
 gxV2w3GfSIWibe25lLFGKNE/T86euI+yj95/x4qTZxPuOTFlwleCMcA+qOg5JWwiH8HsBx
 FV1U6hz2wAYcVP9T+Ok6cj+FpXyoja4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-eth96f65OJyukY63laXAOw-1; Thu, 12 Nov 2026 08:39:26 -0500
X-MC-Unique: eth96f65OJyukY63laXAOw-1
X-Mimecast-MFC-AGG-ID: eth96f65OJyukY63laXAOw_1794490766
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e9995cea88so39929425ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490766; cv=none;
 d=google.com; s=arc-20260327;
 b=nl0kn4BJekm57F5d1IHp8CQUvlm4Rvptov2HDfZw/TSmgbPJO5uM8a+temXqbLy/ig
 bwqErsMLIclq1I11imjaq1njvOkfLhVLrg/6Jq+Kdi/7w8onHPRplQw5md4r6xvLisfX
 /GbXmPc3Le5ea5ohbaUAWw1wL5Kj+/TU9VrJ3c5JJ7KYn8IFsldWxuKsVOylVpd2Qd3a
 QPRV2XIPKCl8rsTGYDrNhlaXixWUQDQ996BEZbw2bYM8ag2PP57HCeT52P452vbWRiOk
 wkKruiRYc4YfkKDirRsOYsyKHCGm+gKpf5A6k2vuFxAHnMS1RnhCb2m9OOgtEwBkQNUD
 UAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NILj5bb2Nn1aI8eODnT9FcRGCzgPWojm49BJ6cezxF0=;
 fh=6KN3gJI+IDvs7KnrTvUIdbZOaA+eVltlqMU3GB3Fgis=;
 b=qFLvqW9J41v5icnUm4sV1SkOKtWgrjG+SVEL5qBg8henOcs5u9N8CdaHIo4q++LkRa
 W0iD2mPnCTt3kOfb9dx9RXglyC+S6U+sC7zg8IOyHh/HiBF7X0DIeAaZgTrY+De8ABVo
 WdBx/FSoe0km/OmoYB/SA/TQeztNY0Ie7Nczl1sfzVY80IaTBYk+yvwSAC4EV7n0qGp0
 ptTjyYzvs6iZ9vv34xf38ECUrij+Tjw1aGRzcWicllf2lRiCIUzY3GDmwvJybMXtL2co
 hgq3fB+IuH1lhljieRolzHofzYFIDks7MNm1od1W3fGDfG1ozCo+nJNtvv68a9WV56dn
 rqqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794490766; x=1795095566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NILj5bb2Nn1aI8eODnT9FcRGCzgPWojm49BJ6cezxF0=;
 b=VrS8Gu/8KIuklXJeW0E6yz3FrI0kPrkCC8afmeXpFz821gmmzAyuYpUoNu3qU+awzK
 t5kNddFHSk20NEjNvOb+EthHnUFpvdxOOp4mIezLTZN9zuONKPXZXXJe/ofwt6pf2ISC
 09jpygDoCr0ewIwWDSaUHp4XNKmXabRV9d5v0g3NV5XgGMWaIXi8lvj2iUbtfLMQSEF7
 2CnhOg24PIfsr4pf+dnZu+9Ru5ZYlPwQHx7zTsmCnSuhgOkfhNwVsTiTu4K4IjEneZD6
 R6jRnQh71qRh1TBAIAgTX/ScclMJl6w4LjhDbk7+uzyQ/ibapKAekTxdXfQZe8JAvBON
 kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490766; x=1795095566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NILj5bb2Nn1aI8eODnT9FcRGCzgPWojm49BJ6cezxF0=;
 b=ARq1EpjW3t9KwFdCmm6XOTAgvIuIC5lMVreIXK+J66kPs30YRUMj3sbFjVPFV+trW1
 tDL1Z7MNXq+KCRFiEZSWLNAG8MFM0W0VCMv99kTUD5j4CJOUuxKKq8C2HyoFRj8RYvhQ
 JVqS7xAJC657o7yutCXMMgIAqkSYMGVF9GfAYxQxRd98CeyOF/fUH7+6QcuKWpJ6Rlq9
 LHiAPWYb8bfXzHotFyDvrflOExz9QTXl1WLXTecmVQq0XxQQ7rqRlj7zdN2kIPedgbrk
 F++a/R8x7jTsKlWdLTG4iumhqVojiMb6022tJ6O1HpIe+XlozzEh0AvVnQ5rHJEWOw1q
 grEQ==
X-Gm-Message-State: APuU4Z9eSZDXmB2BvhRUYpxoJ0GgXcUGkwzvn5p+PPYgjoYcmkrjkf3R
 gxQr3Ie7itaXoncPVGWoqtaXIZI8/QxgBsnndQeyQTNPhIyTQLHtp6lx0BWtgXBGpH+iX6//Uq3
 e2m7ijmqDLuPA33rLBTTGZiGjj67CbmJDbFu4MzEFN7ye/FWjGQZ0L527Y/799T1vhb01vRGlP6
 3t9rYf5AjOlMLw7SEfg/ZCxZuVXO2mdo4=
X-Gm-Gg: AYBFou0+Vf6RrHhzmr3x5tuRu+BGeDg9aeUXI3XqEhrgRgtwNa2yxhRJf7XiX22Jro4
 DcOkEbd7Ubw1qX4D5sHdbFl9cbF/5bHgzjMWX6Xht9C1x4UfbC/FhnCvfhSMBP/jDssfyXmbYz8
 P3gFvJ2yO1z3rRY14uTa+W2Rc1JgqMipamR9m2oKGh4l+9aTiDjZS8Yk4cUfdfxN7ZcWCHony/1
 5VFNeb4gA111Xb+TloioDwZpIZjgLbmdPeMjHJV7Y5QeTqh0o+lPrMwmh1s2VdWtWWTW+BY2Y96
 jA==
X-Received: by 2002:a17:903:9ce:b0:2e9:6645:e99e with SMTP id
 d9443c01a7336-2edd772348bmr62876075ad.28.1794490765536; 
 Thu, 12 Nov 2026 05:39:25 -0800 (PST)
X-Received: by 2002:a17:903:9ce:b0:2e9:6645:e99e with SMTP id
 d9443c01a7336-2edd772348bmr62875775ad.28.1794490765017; Thu, 12 Nov 2026
 05:39:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109203817.1683717-1-peter.maydell@linaro.org>
In-Reply-To: <20261109203817.1683717-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Nov 2026 17:39:13 +0400
X-Gm-Features: AclHuK8TdBXsow9syqIkx08C1uKNPt-7B8oatm1dXkgqjCwVje7Zl5VWTBTdKHM
Message-ID: <CAMxuvazBp_CX3GR1JAiuB1zWeTdSjhPM54FUd_rP7XcC8b=UEg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/ccid-card-emulated: Use QemuSemaphore rather than
 QemuCond
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:38=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> The emulated CCID card uses a QemuMutex and QemuCond to communicate
> with its helper thread, but all it's trying to do here is "make the
> helper thread loop wait until is signalled that it has more work to
> do".  The existing code functions correctly, but "wait until the
> other thread signals you" is more simply implemented with a
> QemuSemaphore.
>
> This avoids a Coverity complaint that we're not using the condition
> variable in the standard
>
>    lock mutex;
>    while (!some_predicate) {
>        cond_wait(condvar, mutex);
>    }
>    do stuff;
>    unlock mutex;
>
> pattern.
>
> Resolves: Coverity CID 1547639
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> I've tested this with a functional test that exercises the
> "use certificates stored in files" setup from the documentation,
> but I still need to arrange to have the official tuxrun guest
> kernel/images updated with the extra config necessary, so in
> the meantime I'm just posting this patch, and hope to post
> the functional-test as a separate patch later this week.
> The issue has been floating around in Coverity for years and
> the existing code is not incorrect, so there's no strong
> urgency to get this into 11.2.
>
> PS: there is no maintainers entry for the ccid-usb code;
> would somebody (I guess from RedHat as the original
> contributors of it) like to take it on? Or if it's really
> "orphan" that would be worth documenting.
>
> ---
>  hw/usb/ccid-card-emulated.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 6c8eec39faa..c504c52a7cd 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -129,8 +129,7 @@ struct EmulatedState {
>      VReader *reader;
>      QSIMPLEQ_HEAD(, EmulEvent) guest_apdu_list;
>      QemuMutex vreader_mutex; /* and guest_apdu_list mutex */
> -    QemuMutex handle_apdu_mutex;
> -    QemuCond handle_apdu_cond;
> +    QemuSemaphore handle_apdu_sem;
>      EventNotifier notifier;
>      int      quit_apdu_thread;
>      QemuThread apdu_thread_id;
> @@ -149,9 +148,7 @@ static void emulated_apdu_from_guest(CCIDCardState *b=
ase,
>      qemu_mutex_lock(&card->vreader_mutex);
>      QSIMPLEQ_INSERT_TAIL(&card->guest_apdu_list, event, entry);
>      qemu_mutex_unlock(&card->vreader_mutex);
> -    qemu_mutex_lock(&card->handle_apdu_mutex);
> -    qemu_cond_signal(&card->handle_apdu_cond);
> -    qemu_mutex_unlock(&card->handle_apdu_mutex);
> +    qemu_sem_post(&card->handle_apdu_sem);
>  }
>
>  static const uint8_t *emulated_get_atr(CCIDCardState *base, uint32_t *le=
n)
> @@ -238,9 +235,7 @@ static void *handle_apdu_thread(void* arg)
>      EmulEvent *event;
>
>      while (1) {
> -        qemu_mutex_lock(&card->handle_apdu_mutex);
> -        qemu_cond_wait(&card->handle_apdu_cond, &card->handle_apdu_mutex=
);
> -        qemu_mutex_unlock(&card->handle_apdu_mutex);
> +        qemu_sem_wait(&card->handle_apdu_sem);
>          if (card->quit_apdu_thread) {
>              card->quit_apdu_thread =3D 0; /* debugging */
>              break;
> @@ -496,8 +491,7 @@ static void emulated_realize(CCIDCardState *base, Err=
or **errp)
>      QSIMPLEQ_INIT(&card->guest_apdu_list);
>      qemu_mutex_init(&card->event_list_mutex);
>      qemu_mutex_init(&card->vreader_mutex);
> -    qemu_mutex_init(&card->handle_apdu_mutex);
> -    qemu_cond_init(&card->handle_apdu_cond);
> +    qemu_sem_init(&card->handle_apdu_sem, 0);
>      card->reader =3D NULL;
>      card->quit_apdu_thread =3D 0;
>      if (init_event_notifier(card, errp) < 0) {
> @@ -556,8 +550,7 @@ static void emulated_realize(CCIDCardState *base, Err=
or **errp)
>  out2:
>      clean_event_notifier(card);
>  out1:
> -    qemu_cond_destroy(&card->handle_apdu_cond);
> -    qemu_mutex_destroy(&card->handle_apdu_mutex);
> +    qemu_sem_destroy(&card->handle_apdu_sem);
>      qemu_mutex_destroy(&card->vreader_mutex);
>      qemu_mutex_destroy(&card->event_list_mutex);
>  }
> @@ -571,13 +564,12 @@ static void emulated_unrealize(CCIDCardState *base)
>      qemu_thread_join(&card->event_thread_id);
>
>      card->quit_apdu_thread =3D 1; /* stop handle_apdu thread */
> -    qemu_cond_signal(&card->handle_apdu_cond);
> +    qemu_sem_post(&card->handle_apdu_sem);
>      qemu_thread_join(&card->apdu_thread_id);
>
>      clean_event_notifier(card);
>      /* threads exited, can destroy all condvars/mutexes */

I'd drop that stale comment

> -    qemu_cond_destroy(&card->handle_apdu_cond);
> -    qemu_mutex_destroy(&card->handle_apdu_mutex);
> +    qemu_sem_destroy(&card->handle_apdu_sem);
>      qemu_mutex_destroy(&card->vreader_mutex);
>      qemu_mutex_destroy(&card->event_list_mutex);
>
> --
> 2.43.0
>


