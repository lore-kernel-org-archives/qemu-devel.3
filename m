Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98491CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 05:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoazQ-0005gz-5Z; Wed, 20 Aug 2025 01:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoazO-0005gT-8h
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoazL-0000Ts-R3
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755666234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+7X/FmpQ+doscnF8RxMSdtyJh/W6peTvk7f1zfnCEM=;
 b=dznSPVOvnhxbpy8UE+m2mGnP3CMAeJcd1poYRXzPwjN89EQGdbCU5ZDpfwp2YahpnmNtmM
 Q+nhJeAmb8QZFlTQ56xEMbGS5AnksJxF4KbT75SZP3u2/lZvjgFXI7zX61S6bXPKSaPI1o
 p6X3nIG4Brfbqtw7vAde36L8uWtV544=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-U7ZJkqPzNuONTiJQvczKQQ-1; Wed, 20 Aug 2025 01:03:53 -0400
X-MC-Unique: U7ZJkqPzNuONTiJQvczKQQ-1
X-Mimecast-MFC-AGG-ID: U7ZJkqPzNuONTiJQvczKQQ_1755666232
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24457ef983fso118995925ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 22:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755666231; x=1756271031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+7X/FmpQ+doscnF8RxMSdtyJh/W6peTvk7f1zfnCEM=;
 b=B7iSCEXPEZPNYwnTs0DvU2TaO/giGBiiFhYMrb9f8siEMHF5KdoMTD53IEEC7J75q2
 Zwjbc45DLB867LtF4tyP6bX/Kz2jWNilDdablkOTSNiUs0DZ2a4xuz/YAZdXJGBztf1F
 ntwaqO+89mRsISqylHMd0kzmDWlEOyA7PB6dzyIVBvzEvkJSsdCbr4WJk+LMECuJHJYb
 vCMNfNSL/WIw1d8KSMPG28/3oo5URVJEhTCYgqVfeXyKshj5xTJrfrSNKtB/KygD8Qwf
 vPv3n6LCN1bpQq1mMXxT/AKKec4ipyy/5DfXDPoz0zbfea8eFSx3FyQrm8k82LBLodbe
 LX9g==
X-Gm-Message-State: AOJu0Yznorrrw43LR21wHSrQNqCGFUs70PDvvUfTMjKWEm+RftAAY4pX
 2f4gcC/Qils+yZw0Qj7zCZ6YQgWTJVPTUn/HCpjJ2T27IuqBcr1tiOstI+Spk2aF65HxD1zbRrG
 frk+VVkrz+jHNEeNNicyb1iRwzpsUWp6re+T0/+CWG9KHbsIJvFLp53GePlFmi3F89Y06jtLw7U
 V0mK9qg9uNxcYbWaaXrO4JtjnqjoOu1JVuEhATBm0=
X-Gm-Gg: ASbGnctVeoDfGdfUzGgcet01VOgvLBOiBZdt5O59eG+MPicDpON8ZGFiTXNksuMCM9I
 uFpoRS4ORfT7r2E/E3vUu8/tDn6KiOR72cW/KlwuT88lrihaSlo+OBUJ3mNoIQ7eb5UijyZrE//
 QVq85LW0zeiJ2T///qxmqx21i96srZvXczqhi0G800VpYHq5SXxPL6
X-Received: by 2002:a17:902:d4cb:b0:242:9bca:863c with SMTP id
 d9443c01a7336-245ef25ed13mr21540195ad.54.1755666231269; 
 Tue, 19 Aug 2025 22:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaP6moa5N9eZZCcxepFuX1J8y4s32W9Hz6BHzjyNBhbVpxFL5wckR1lWhYKA7l1dbJXhSX0lQJ5dZxPxmRPk4=
X-Received: by 2002:a17:902:d4cb:b0:242:9bca:863c with SMTP id
 d9443c01a7336-245ef25ed13mr21539935ad.54.1755666230906; Tue, 19 Aug 2025
 22:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-15-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-15-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Aug 2025 01:03:38 -0400
X-Gm-Features: Ac12FXzuB69LFRcNLjGrDP8JyrrwAmyZO-NalyJCeemZFpCGL-1D0QyPtCy4inA
Message-ID: <CAFn=p-a0Rg4qtpSPFwq0UvYbyPpiOibx7gqsqgHiqWUpsav=UQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] iotests/check: always enable all python warnings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> Of most importance is that this gives us a heads-up if anything
> we rely on has been deprecated. The default python behaviour
> only emits a warning if triggered from __main__ which is very
> limited.
>
> Setting the env variable further ensures that any python child
> processes will also display warnings.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks for this one. I sent a PR for the first two patches, I will
stage everything else.

> ---
>  tests/qemu-iotests/check | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 545f9ec7bd..d9b7c1d598 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -21,6 +21,7 @@ import sys
>  import argparse
>  import shutil
>  from pathlib import Path
> +import warnings
>
>  from findtests import TestFinder
>  from testenv import TestEnv
> @@ -137,6 +138,9 @@ def make_argparser() -> argparse.ArgumentParser:
>
>
>  if __name__ =3D=3D '__main__':
> +    warnings.simplefilter("default")
> +    os.environ["PYTHONWARNINGS"] =3D "default"
> +
>      args =3D make_argparser().parse_args()
>
>      env =3D TestEnv(source_dir=3Dargs.source_dir,
> --
> 2.49.0
>


