Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3EECCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvpi-0007T5-TO; Thu, 23 Oct 2025 09:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBvpg-0007SE-Co
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBvpe-0005Mr-Hp
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx62NDlEv3VoFzkfIgYd/pr8wULtIcfjNxlC6XKphy0=;
 b=i1ku3C9li4o1IeUEv48CmtHUV3CcUvoaK7iDroDM8LmszMM5BcqUkqFytx1QCALuQrMkQ5
 RZIE8ny658+Q8xfk1YZhL90jCMK8M3NJCJQ6g/UxWBW4YdgHRaYEumBUn79db/X/mEIK+G
 7BZ9wKTiWn/Vx8BdIA11juBdyVLcw7M=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-JZg1aEzVPDmaFM2UZZqNRw-1; Thu, 23 Oct 2025 09:58:18 -0400
X-MC-Unique: JZg1aEzVPDmaFM2UZZqNRw-1
X-Mimecast-MFC-AGG-ID: JZg1aEzVPDmaFM2UZZqNRw_1761227898
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e13b766dbso981669d50.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227898; x=1761832698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx62NDlEv3VoFzkfIgYd/pr8wULtIcfjNxlC6XKphy0=;
 b=Iv+8PmoSBt25cdHqNOVdPXRZ2meQjJdI09LU9avFcNX/e/lX2wD1AzYflyZBujM6a+
 7cprOsq36+9zNG3PgGaw0wceeHsjo4QVnPRV3hwLjYipVqewFftGZIZJkvE2hD3Dc6SY
 L5P3cavAIjY7FJCPABpUGc8wHN+1KPyZjh7Sar6q6JLUAwBlXbv2JzMV/CnuE0JvhFI7
 /tPd8RTeKZphGKXnDtYoLFZ0Lw2E0J2XK+PyQfKfiD2gKjZjHLIQvmsxGvzM9agnSV2P
 DsclEGolejINfqqAnHVfEkyhTxGe4+gOR0lEDNT72o5fGuWhFdmuNJA9nkUQPQBGFJRm
 OgGA==
X-Gm-Message-State: AOJu0YxFMPGe+ZPcFETQf8SbKWszIlElbjZlw/SuoeAr0cA72Ge3kSpq
 eShPslGjL/fFAdbVMlLreVCthFX7xdkZUtIBJ+7TFFf3SDp6iOG19tKX+rIxQx+RJ/547LPw3ay
 NChFVKouIK4Fht6fMUICagAITEUmAJfDIecDh5j5erBP5+4ra4XmsbdwnP0D7v5k5Bl4cLCty2L
 ymOO7oVkEu0FC3CoH7uQIp/H3f/wPGlWM=
X-Gm-Gg: ASbGnctYzFx07/oVlx0J/dczerXSPCBVnhNKw5GoDbKhP43/o+K0F0JCKZ+olmlDHDL
 g9QC5qzk5rZMNYYTDcbdedwz0zM/uriarGGu/tn6KwSqUTEzUJziy4EKyCE2vSyiA+nUrgGcf5i
 pfzUn+RSnk8vQhAGEF8A2FV3Jpk6Trw76BHFeg/j+HcI2tDjCCkJIGrGI1o2TWiuB2jlHaiNQeE
 jEfHau55A/KNjs=
X-Received: by 2002:a05:690e:1907:b0:63e:2f0e:6727 with SMTP id
 956f58d0204a3-63e2f0e6a9fmr12362762d50.42.1761227898094; 
 Thu, 23 Oct 2025 06:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbeW0AO6QwwllMaIwNhqcxYjwW48azFmH7jckfELZGkQhzdodmH8pSx4cSWPCC5GxxZEdk/IAOu6DtU9M4aPE=
X-Received: by 2002:a05:690e:1907:b0:63e:2f0e:6727 with SMTP id
 956f58d0204a3-63e2f0e6a9fmr12362748d50.42.1761227897756; Thu, 23 Oct 2025
 06:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251022213109.395149-1-jsnow@redhat.com>
 <f7817d99-f2cb-453a-8d3d-e28b592fa93d@redhat.com>
In-Reply-To: <f7817d99-f2cb-453a-8d3d-e28b592fa93d@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Oct 2025 09:58:06 -0400
X-Gm-Features: AS18NWB_to9UaPcSUa_4MvqxnhTAL_nxRjkyly44qs-Ee9IavK_8s99NAOneYR0
Message-ID: <CAFn=p-atgVAiqa9OY+CS1GRijVdF=MQyEKfq-iwTrgvNPwsPWw@mail.gmail.com>
Subject: Re: [PATCH] scripts/device-crash-test: fix spurious EOFError messages
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 23, 2025 at 3:01=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 22/10/2025 23.31, John Snow wrote:
> > When the QMP library was updated to match the standalone repository in
> > 094ded52, I neglected to update the logging filter(s) in
> > device-crash-test, which allowed the spurious messages to leak through.
> >
> > Update the log filter to re-suppress these messages.
> >
> > Fixes: 094ded52
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   scripts/device-crash-test | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> > index 1ecb9663ae8..c1576e8b966 100755
> > --- a/scripts/device-crash-test
> > +++ b/scripts/device-crash-test
> > @@ -527,7 +527,7 @@ def main():
> >           # Async QMP, when in use, is chatty about connection failures=
.
> >           # This script knowingly generates a ton of connection errors.
> >           # Silence this logger.
> > -        logging.getLogger('qemu.qmp.qmp_client').setLevel(logging.CRIT=
ICAL)
> > +        logging.getLogger('qemu.qmp.protocol').setLevel(logging.CRITIC=
AL)
> >
> >       fatal_failures =3D []
> >       wl_stats =3D {}
>
> Thanks, that silences the messages, indeed!
>
> Tested-by: Thomas Huth <thuth@redhat.com>

The library is designed to be very vocal about connection failures so
that tests don't silently fail even when there's no output expected,
but for a test where we're intentionally trying to see if QEMU crashes
over and over, it's not really so helpful :)

thanks for the report!


