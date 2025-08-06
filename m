Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00245C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYiq-0005Xs-0l; Wed, 06 Aug 2025 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujYio-0005Wi-Fi; Wed, 06 Aug 2025 03:38:02 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujYim-0006H4-L5; Wed, 06 Aug 2025 03:38:02 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4b0739c6557so41615451cf.3; 
 Wed, 06 Aug 2025 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754465878; x=1755070678; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0oOmYw020zvDZR8cSot3uR3BkTtInrvHC5409G4zdo=;
 b=USwF26oucGz2SvOXlWuhRS8h4cgabLZa0O+N5XCyAZm1eQLwapB5ZPDFnhE0uOey4U
 8QOVOj2Eek5JQ9f4S6aF4sN8T3E0mMpgZbRsE4orgOW6Qwa3C/J8niOC/yX0XPeIOlJn
 IeH/UHEljg4yp3tZ1G9pGdZgbLmaDCcJ+Vh+5YZB1w6YAIUnGzpii990v+hpXkKcG4SR
 Ow4teZtHTDRuwKJ97p4HBFTqSaD51kMbx28MXA0RKxUrDUz3B2KisRD6hNDjAkPYtG8m
 JnFDF5hD0nXjPAyt5EsqCa6cCDy18gcVt6/1rWWfSAebAz5eD0rQdCgSmsvTJo2l2D1z
 o/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465878; x=1755070678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0oOmYw020zvDZR8cSot3uR3BkTtInrvHC5409G4zdo=;
 b=N6AgCWQdjjxlfxiNr7eJ7/yDXk71JsD+BfHLK7yemnT8WbepQwVLW1vX7/2X6YOQZ9
 0mLtl3tUUHhhhVNzkOjtq2OVCTIAHnZ2HpqGkk1iHzCcpHgk7p+UHNpo0UCcead3zs0I
 wK4vqj0iy+RRq4DRTGyYRqdY5X+TZa1E7dt+uL+WxGlVX7XoDPVeIaZwzCbyjxjRqgiJ
 1V7Ly54wUaoNCtg8Fpw0r1cDKv4bCRHWLFDAdCrOzPNz8ngW+Gy6oF3byustXdiEdlHW
 rkFZY840nHiz8MzpGJXcT5VKiW6wvb+2UhYYvcWoFlXCIXgO0/u6iYtR+QWaJyeVA8qL
 K4Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1XLxQiJOGHDCObukHKs8FCjmZeM7Z7cUWtNcAFgQKy0TwwcjrO4L8LzwbkQCXYR1j5ffmZu16gg==@nongnu.org,
 AJvYcCUthmBPwe/brzitPDrKM/oz6xMCpHTL1KSdaS/5RvMRIgPwUdcNBz1uGq1+wKQDv5D/da50aoaC5V8hpg==@nongnu.org
X-Gm-Message-State: AOJu0YyIQrWsOgOYWk4RJ4KZ2WgV8sW6Z93b1NjkFaXAuxqdqctjYl6u
 YR5mXjGR4viXtl3De1QXYcB3OboRrlxVPkPBoNLHJsf2eOiitGbXmS7cupgTaNr2B7AaDqCh6ZL
 WYzyo9mqvFIZfmIE/7dLsscd6LDps+GY=
X-Gm-Gg: ASbGncstefZ13pp3VNE/7qzRjnJY+Lfpxz3NZIqQhFKY7xJTpaDacVDgV6OrJdrw7rQ
 pXjScjn+Z33L4Ok8UeTkFVrlGY6x0Jry3qyz+U7uaEPFC6EjHqeTWlK9122B+8hZrnS/2NN3eRX
 LdMpQ92B4Aj6VEZ6le/nd+rcv4S3vHa4clDis/hUn/b+Xnbd0aJ+XPyZDyq48SrLqMGn9d3kuVF
 KphUxmb1+LcKZcx39Nb1fo+sY87auT18Fspc3LB
X-Google-Smtp-Source: AGHT+IHAR5I3ZUNgzsVV+VeApufzDXaEeW6gmswMIpFNyTtVj6nHebQJuYyH8buLNwrlhXdohUEo/1AABZMwMbF5bns=
X-Received: by 2002:a05:622a:5906:b0:4ab:6e71:3c58 with SMTP id
 d75a77b69052e-4b0915c430emr30131251cf.41.1754465878409; Wed, 06 Aug 2025
 00:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-10-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-10-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Aug 2025 11:37:46 +0400
X-Gm-Features: Ac12FXz_VQY84CqD2M6XdMrlgNz5_Ctz1N911MKnLsQf6lLHkoU5O34ZVK_hgrs
Message-ID: <CAJ+F1CJUeCA33xPb0-w2vJgujh92h4H=Ai=hu_OSnG-BH2BJzg@mail.gmail.com>
Subject: Re: [PATCH v9 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
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

On Tue, Aug 5, 2025 at 11:03=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:
>
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_section_start_full() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  migration/savevm.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ad3dd9b172afc541f104d2187a79bafa8e380466..e337e3c61e7627f09b853bf5e=
9b845c38cb5f082 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2722,8 +2722,9 @@ static bool check_section_footer(QEMUFile *f, SaveS=
tateEntry *se)
>  }
>
>  static int
> -qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> +qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
>  {
> +    ERRP_GUARD();
>      bool trace_downtime =3D (type =3D=3D QEMU_VM_SECTION_FULL);
>      uint32_t instance_id, version_id, section_id;
>      int64_t start_ts, end_ts;
> @@ -2734,8 +2735,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>      /* Read section start */
>      section_id =3D qemu_get_be32(f);
>      if (!qemu_get_counted_string(f, idstr)) {
> -        error_report("Unable to read ID string for section %u",
> -                     section_id);
> +        error_setg(errp, "Unable to read ID string for section %u",
> +                   section_id);
>          return -EINVAL;
>      }
>      instance_id =3D qemu_get_be32(f);
> @@ -2743,8 +2744,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>
>      ret =3D qemu_file_get_error(f);
>      if (ret) {
> -        error_report("%s: Failed to read instance/version ID: %d",
> -                     __func__, ret);
> +        error_setg(errp, "Failed to read instance/version ID: %d", ret);
>          return ret;
>      }
>
> @@ -2753,17 +2753,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type)
>      /* Find savevm section */
>      se =3D find_se(idstr, instance_id);
>      if (se =3D=3D NULL) {
> -        error_report("Unknown savevm section or instance '%s' %"PRIu32".=
 "
> -                     "Make sure that your current VM setup matches your =
"
> -                     "saved VM setup, including any hotplugged devices",
> -                     idstr, instance_id);
> +        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu=
32". "
> +                   "Make sure that your current VM setup matches your "
> +                   "saved VM setup, including any hotplugged devices",
> +                   idstr, instance_id);
>          return -EINVAL;
>      }
>
>      /* Validate version */
>      if (version_id > se->version_id) {
> -        error_report("savevm: unsupported version %d for '%s' v%d",
> -                     version_id, idstr, se->version_id);
> +        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
> +                   version_id, idstr, se->version_id);
>          return -EINVAL;
>      }
>      se->load_version_id =3D version_id;
> @@ -2771,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>
>      /* Validate if it is a device's state */
>      if (xen_enabled() && se->is_ram) {
> -        error_report("loadvm: %s RAM loading not allowed on Xen", idstr)=
;
> +        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", id=
str);
>          return -EINVAL;
>      }
>
> @@ -2779,10 +2779,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>
> -    ret =3D vmstate_load(f, se, NULL);
> +    ret =3D vmstate_load(f, se, errp);
>      if (ret < 0) {
> -        error_report("error while loading state for instance 0x%"PRIx32"=
 of"
> -                     " device '%s'", instance_id, idstr);
> +        error_prepend(errp,
> +                      "error while loading state for instance 0x%"PRIx32=
" of"
> +                      " device '%s': ", instance_id, idstr);
>          return ret;
>      }
>
> @@ -2793,6 +2794,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>      }
>
>      if (!check_section_footer(f, se)) {
> +        error_setg(errp, "Reading footer section of instance "
> +                   "0x%"PRIx32" of device '%s' for version_id: %d failed=
",
> +                   instance_id, idstr, version_id);
>          return -EINVAL;
>      }
>
> @@ -3097,7 +3101,7 @@ retry:
>          switch (section_type) {
>          case QEMU_VM_SECTION_START:
>          case QEMU_VM_SECTION_FULL:
> -            ret =3D qemu_loadvm_section_start_full(f, section_type);
> +            ret =3D qemu_loadvm_section_start_full(f, section_type, errp=
);
>              if (ret < 0) {
>                  goto out;
>              }
>
> --
> 2.50.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

