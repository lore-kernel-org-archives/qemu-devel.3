Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B1BD5A6D9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 03:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFmfL-0008U4-PG; Mon, 25 Nov 2024 22:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFmfI-0008T8-9F
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 22:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFmfG-0006vK-N6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 22:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732593301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41VeTf95S8wFsZoIdCwmCRAAO43sxmp+0bRFB6ore5o=;
 b=Av+2J1MgL09vvlnyzzKFIRIhbzX2LXc43N6uujnrh2cgnSDoR2VThFwKCxMArhQzz3gvuc
 VK/FwZPzUaRw7ah7Or5dftZanRxBGKBok4gsQ5mch8XbSCdixDZOCsdrYifI/g2zcrxb7L
 ZkChWPlI+uQrFSMgyjb1ailtgBEoV1A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-YcNZJ2GNPK61Y9WDJmF_PA-1; Mon, 25 Nov 2024 22:53:02 -0500
X-MC-Unique: YcNZJ2GNPK61Y9WDJmF_PA-1
X-Mimecast-MFC-AGG-ID: YcNZJ2GNPK61Y9WDJmF_PA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa538575f0fso189717266b.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 19:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732593181; x=1733197981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41VeTf95S8wFsZoIdCwmCRAAO43sxmp+0bRFB6ore5o=;
 b=pjsLFc1tffInOW9GsEECoEj1HYaMPWyzhJ67a+p5SgMDOOGAPTxSXE3yJUQXuO+o3/
 fuRv9m6ttBQ1wEvu8OX4rxv+23+jAXyT2oVM1NgNXF8BgTnXRmT1V6ImrMX+2TA20meD
 RacpWkpxmM0qHo4X36KYQKfRXrrW4CYyXPujnMB+1Cg/os2DbnjuGbYU2qwqxRbMZsrp
 Wes3VkNaHCtSVW2W/ppBj+bFKTgxSmBwmerNfss85+nekg451tqPfi+DmIqMvPms8gfF
 VfR+i1Z4y8a11ZvlAFigurGbCMdSuvU9OOFnaqfGcKv3aVhczfrERTMBmgrHwyKnMMU0
 1v5A==
X-Gm-Message-State: AOJu0YwXlfspwNPx9u5x6tSlY00BzQWBd6sjcPiEfWintQOLhVUBbSVE
 6sUyfpNKQaEi9Q1yUzY0DYyltHa8bK0h/r4ilLfCmn+6A8qG2uJ3Qps1Htl4eoQ7xuRJzFOKWNj
 PETjjiPL/AFS2I4sAa2iBqIc9kIVgheW8/FrVK7SW9OtbdYVFtmU3bhp7ZNSSUsKZjkIAhlG5xE
 sCEGDpJ9zKO43fTtiPM4DOflRwhZU=
X-Gm-Gg: ASbGnctg0zW459De3v0jvhv1MQ2XzhnvIjw5/ZbudZxZKgLNeREX8tRzF8LugPxRttC
 afRTBaP+27oVfkpLKo4yE0mORY+djMGE=
X-Received: by 2002:a17:907:3d93:b0:a9f:508:5f5a with SMTP id
 a640c23a62f3a-aa509d3fb54mr1676868066b.40.1732593181405; 
 Mon, 25 Nov 2024 19:53:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyn+ilEOkXmV/VJW9gGCMOr5B1ak4D0mnl0dCLFODQfNG0eUDUE3cmAKP9ZsI2i3iDZB45szUQQujfjcWiXM=
X-Received: by 2002:a17:907:3d93:b0:a9f:508:5f5a with SMTP id
 a640c23a62f3a-aa509d3fb54mr1676867066b.40.1732593181061; Mon, 25 Nov 2024
 19:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
 <20241125152105.2100395-8-alex.bennee@linaro.org>
In-Reply-To: <20241125152105.2100395-8-alex.bennee@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 26 Nov 2024 09:22:49 +0530
Message-ID: <CAK3XEhNWsCzCLotDFr_VDzVXGe+n+3NrHtw=Q_MpCTS-gwzaAQ@mail.gmail.com>
Subject: Re: [PULL 07/28] tests/functional: remove comments talking about
 avocado
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 25, 2024 at 8:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The first comment is still relevant but should talk about our own test
> harness instead. The second comment adds no value over reading the code
> and can be removed.

I know I am late in the party (been away from QEMU for a bit) but ...

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> Message-Id: <20241121154218.1423005-8-berrange@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20241121165806.476008-8-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_a=
cpi_bits.py
> index ee40647d5b..4c192d95cc 100755
> --- a/tests/functional/test_acpi_bits.py
> +++ b/tests/functional/test_acpi_bits.py
> @@ -196,11 +196,12 @@ def copy_test_scripts(self):
>          for filename in os.listdir(bits_test_dir):
>              if os.path.isfile(os.path.join(bits_test_dir, filename)) and=
 \
>                 filename.endswith('.py2'):
> -                # all test scripts are named with extension .py2 so that
> -                # avocado does not try to load them. These scripts are
> -                # written for python 2.7 not python 3 and hence if avoca=
do
> -                # loaded them, it would complain about python 3 specific
> -                # syntaxes.
> +                # All test scripts are named with extension .py2 so that
> +                # they are not run by accident.
> +                #
> +                # These scripts are intended to run inside the test VM
> +                # and are written for python 2.7 not python 3, hence
> +                # would cause syntax errors if loaded ouside the VM.
>                  newfilename =3D os.path.splitext(filename)[0] + '.py'
>                  shutil.copy2(os.path.join(bits_test_dir, filename),
>                               os.path.join(target_test_dir, newfilename))
> @@ -399,8 +400,6 @@ def test_acpi_smbios_bits(self):
>
>          # biosbits has been configured to run all the specified test sui=
tes
>          # in batch mode and then automatically initiate a vm shutdown.
> -        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at=
 par
> -        # with the avocado test timeout.
>          self._vm.event_wait('SHUTDOWN', timeout=3DBITS_TIMEOUT)
>          self._vm.wait(timeout=3DNone)
>          self.logger.debug("Checking console output ...")
> --
> 2.39.5
>


