Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD946C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 22:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubo2Y-0000oW-Af; Tue, 15 Jul 2025 18:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubo0y-0000Ap-6F
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 18:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubo0u-0007YD-RG
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752618036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9R0UdxLrSuN9jPKUmxzkaad7Cd160hgWJUn1VR7GGKY=;
 b=QzjB5gsJH+2l3rMEohSiYakF+gTQcq3yfw57tZadQ+DaYQ65DxFRepC2tMNLHs/To5vlKJ
 DSs7iXdGl8FZu7DzTYilsO0OOqrH5UiZn56CAHMR878watBsZsZe38nXcf+/E3lNUDksnJ
 ciiBNIHvtG5iU2hjFhrlelCwSCX9V6Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Evkdc5eDPDa3wTDZtnaFpg-1; Tue, 15 Jul 2025 18:20:35 -0400
X-MC-Unique: Evkdc5eDPDa3wTDZtnaFpg-1
X-Mimecast-MFC-AGG-ID: Evkdc5eDPDa3wTDZtnaFpg_1752618034
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2363bb41664so2414955ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 15:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752618034; x=1753222834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9R0UdxLrSuN9jPKUmxzkaad7Cd160hgWJUn1VR7GGKY=;
 b=GbS8elAx+vYmOWS1SbseJ6xoBF7nb7QefIjYFs6GWypUyHFS0xFJJmMRJm9L4WHfS3
 ERxvdqmiHdnW6AE99NyvhLsu/oodKTouFdm6HHj+bIQl5LaUMbet0yp8GMxe4fzZ5rM8
 Y40RA9PeKo34n5F/SlEtZOlT7bNiaunCfRtI97ukCTubrg8YldLSJUiwJjEtQ6QbUAJs
 /1AB6iZ39T5SAGuJEZCI5YIeHUD5PgGH7SU7HV9wD19IBNYhA+GILncXXILB7N+j1s1k
 vG9JIwO6HM+cytKW1Vcp9rudShxYBbxKUR/oC0HRD3p0DKCb0ZTeSQtaporb8D9d9UhF
 8iXA==
X-Gm-Message-State: AOJu0YzsPh/JW8b6lLQsBMp1JZUiUti4M6TQEVOHwhPed555oGwH2fHn
 ezT0BYkLonRpd9C4CWHM/ch664uJgbBsmEKWX1s/urunZ4+ihOe8qFuTT/UDr4z4fvOFU5vKysk
 oVGjsvsAl8U27/emCtltK4wv+KRr3LrjTYBh02VW6gwwuQtNf8EuWFhP0iTQhsWyhK63XCu8LwR
 q6LwzobdOLvuWoA44hkeaLuQWBMVoOBH2e8jIgzNk=
X-Gm-Gg: ASbGncv/O6JtzPYEW37D6Rkw39JgaEJbYx/Rehj1vualwEBFx5ZOj42+daR9GnJfi6n
 LuXRtHe4ZWc7dbjEoEk0vlUuVfYYU7ridAtXY4ibS89TSTlkKTaKwlUDpjdD4euQPuVDW0yYzmo
 GEaSWb6Z5mzsoXW4AV7fbjITcS0GVvYi0+OfalDlrEBl5cJx2+191b
X-Received: by 2002:a17:902:9009:b0:231:e413:986c with SMTP id
 d9443c01a7336-23e1a4497c6mr61060025ad.11.1752618033952; 
 Tue, 15 Jul 2025 15:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZURA1hWiI0mF/vUu+T2poucIeRfvU3d+NleBfYw0uKulT+10meJnbcGOn98Z4EDo8ZWUYBu5ZbweQgJwnJp0=
X-Received: by 2002:a17:902:9009:b0:231:e413:986c with SMTP id
 d9443c01a7336-23e1a4497c6mr61059865ad.11.1752618033521; Tue, 15 Jul 2025
 15:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250715212848.171879-1-jsnow@redhat.com>
In-Reply-To: <20250715212848.171879-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jul 2025 18:20:21 -0400
X-Gm-Features: Ac12FXyuByxZh_2_lM7PN_ORIeVIeT8RkGzEAKRBCEQpkF0i-JimQPhap3gqp10
Message-ID: <CAFn=p-bZBok_n-evUwjm6cdCmr+4ofjTRbVRJ+DNxft9gV4PpA@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs, python: bump sphinx preferred version
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

fwiw, I think this is important enough / harmless enough to sneak into
the rc releases, if possible.

On Tue, Jul 15, 2025 at 5:28=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> CI: https://gitlab.com/jsnow/qemu/-/pipelines/1928836481
>
> Unlike the previous series, this series only adjusts the *preferred*
> sphinx version to be higher, leaving the accepted version at 3.4.3, the
> version that CentOS Stream 9 still ships with.
>
> Unfortunately, this means we can't cut out the compatibility code for
> sphinx we're still carrying around just yet, but we'll await that
> glorious moment to arrive on some future day.
>
> Sphinx 6.2.1 is being chosen as the new default because it still offers
> support for Python 3.8+, but is new enough to support Python 3.13+.
>
> Distro version information for supported platforms as of 2025-07-15:
>
> distro              python3  pip     setuptools  sphinx
> -------------------------------------------------------
> alpine_3_19         3.11.13  23.3.1  70.3.0      6.2.1
> alpine_3_20         3.12.11  24.0    70.3.0      7.2.6
> alpine_3_21         3.12.11  24.3.1  70.3.0      8.1.3
> alpine_3_22         3.12.11  25.1.1  80.9.0      8.2.3
> centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3
> centos_stream_10    3.12.11  23.3.2  69.0.3      7.2.6
> debian_12           3.11.2   23.0.1  66.1.1      5.3.0
> fedora_41           3.13.5   24.2    69.2.0      7.3.7
> fedora_42           3.13.5   24.3.1  74.1.3      8.1.3
> freebsd             3.11.13  23.3.2  63.1.0      5.3.0
> homebrew            3.13.5   ---     80.9.0      8.2.3
> macports            3.13.5   25.1.1  78.1.1      8.2.3
> openbsd             3.12.11  25.1.1  79.0.1      8.2.3
> pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3
> ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
> ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6
> ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
> ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3
>
> Akihiko Odaki (2):
>   docs: Bump sphinx to 6.2.1
>   MAINTAINERS: Add docs/requirements.txt
>
>  MAINTAINERS           | 1 +
>  docs/requirements.txt | 4 ++--
>  pythondeps.toml       | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> --
> 2.50.0
>
>


