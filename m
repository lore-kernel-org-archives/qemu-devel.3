Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B46C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvkc-0004uW-KW; Thu, 25 Jul 2024 06:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWvkU-0004ru-3X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWvkS-0003YW-6j
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721903458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZK9LxFBnm3IoZ/YBJppRyPC+Fm2g1RcmIVHeFzxpPs=;
 b=TClv2EFc784XsJdJH4fya+ZU/WaA9FUBOYVL8cLQ7ajQ42lO11hQXYCVAuGMK4jpewxRoC
 Ou+5RsfBo5JW82BaHQvJjTg4YEpzz8ZxoobTnBOAzkvvnNuIHfgchkvbbggyJsKF17SzuA
 mbml2iZP3ojV4mnJue7IPyP8/NpOApI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-0OFbcQhONRWEss-T_qEvrQ-1; Thu, 25 Jul 2024 06:30:57 -0400
X-MC-Unique: 0OFbcQhONRWEss-T_qEvrQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3687a1a6846so440858f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721903456; x=1722508256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZK9LxFBnm3IoZ/YBJppRyPC+Fm2g1RcmIVHeFzxpPs=;
 b=F6qdvtCjd+KMraGlwMuUzwUoQmhZbf2d41VrMYWTG2vLO+HKEZ0W/v+k9mtZMiT/n0
 JiMgPUd4n5/vcu1yYlTTNfAKJkWVsUhMNVl+wBLhraQ21a+a0Lvmsq0dNpFSqqKxvLsR
 6cjx1tSml1aJm+tpScFtRzRW561CkJ4bKQRQb3NwpJ6jkYSGAu32ZLQYpd8ZV/4Kegpm
 /ndGwYqJTkvR+XfgEeYY9G7bd3ABrBCfHWrIjMFOKLZQOYa11czaR7gECTzLWQB3k9t/
 s3dlqu+u+XqqRsfr3P/DFtAFDfTX2Yo0EsIQqbEVTcyE+wq9fwm6IQOXW8OMWM9HOSvZ
 lUrA==
X-Gm-Message-State: AOJu0YyFs9XyBx7Zoy71VjcDpNY3OYH2/Fjm2bUr5K3jhPxedyL+0hdV
 NmB9b3Uj2q3Xtori7eLD5scnTFjb85A0+bwobCTF96Xo89hJpqCdy//Eyuj+C4Sh1/dkzN0h3ZG
 cwBybzhW3IAX0kPq0wKmevO7UIsvHPsAVTqkoT8e71oyTjhlZFYFA6vsPBT3rd/qpUt4ZNzCcOR
 uGTe/GPAAYjvSqb4UDprwG0VrEz8M=
X-Received: by 2002:adf:a348:0:b0:368:41bd:149b with SMTP id
 ffacd0b85a97d-36b319fadf0mr1678363f8f.34.1721903456035; 
 Thu, 25 Jul 2024 03:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcDutNrvHUFbnn5cdcirSop6Dgf8wv39yfSFcReZgLWsn5XNBVJ1MR9sAVC8qChgeEIuvZJgybvO9bqtXAedw=
X-Received: by 2002:adf:a348:0:b0:368:41bd:149b with SMTP id
 ffacd0b85a97d-36b319fadf0mr1678352f8f.34.1721903455693; Thu, 25 Jul 2024
 03:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-4-pbonzini@redhat.com>
 <CAFEAcA-+BmDLzsjwBdJLHpRobxwUEZhW2M90qYReFkKQdu32Bw@mail.gmail.com>
In-Reply-To: <CAFEAcA-+BmDLzsjwBdJLHpRobxwUEZhW2M90qYReFkKQdu32Bw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jul 2024 12:30:44 +0200
Message-ID: <CABgObfa=-A2oqbpcZ7CQRqvQKxVrCqwyt9Ej6UEEwOkbN-SZXg@mail.gmail.com>
Subject: Re: [PULL 03/11] tools: build qemu-vmsr-helper
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Anthony Harivel <aharivel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 12:28=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> > +    if (r < 0) {
> > +        error_report_err(local_err);
> > +        goto out;
>
> Here we have a check for r < 0 that forces an early exit...
>
> > +    }
> > +
> > +    while (r < 0) {
>
> ...but then immediately we do a while (r < 0). r cannot be < 0
> here because we just checked that, so this while loop will
> never execute and the whole loop body is dead code.
>
> What was the intention here ?

The intention was to have "while (r >=3D 0)" which is effectively an
infinite loop.

Paolo

>
>
> > +        /*
> > +         * Read the requested MSR
> > +         * Only RAPL MSR in rapl-msr-index.h is allowed
> > +         */
> > +        r =3D qio_channel_read_all(QIO_CHANNEL(client->ioc),
> > +                                (char *) &request, sizeof(request), &l=
ocal_err);
> > +        if (r < 0) {
> > +            error_report_err(local_err);
> > +            break;
> > +        }
> > +
> > +        if (!is_msr_allowed(request[0])) {
> > +            error_report("Requested unallowed msr: %d", request[0]);
> > +            break;
> > +        }
> > +
> > +        vmsr =3D vmsr_read_msr(request[0], request[1]);
> > +
> > +        if (!is_tid_present(peer_pid, request[2])) {
> > +            error_report("Requested TID not in peer PID: %d %d",
> > +                peer_pid, request[2]);
> > +            vmsr =3D 0;
> > +        }
> > +
> > +        r =3D qio_channel_write_all(QIO_CHANNEL(client->ioc),
> > +                                  (char *) &vmsr,
> > +                                  sizeof(vmsr),
> > +                                  &local_err);
> > +        if (r < 0) {
> > +            error_report_err(local_err);
> > +            break;
> > +        }
> > +    }
> > +out:
> > +    object_unref(OBJECT(client->ioc));
> > +    g_free(client);
> > +}
>
> thanks
> -- PMM
>


