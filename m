Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C4606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MklEpioM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YMBZ74UX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNGQ-0005GM-IA; Tue, 17 Nov 2026 12:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNGP-0005GD-7p
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNGN-0003v3-Hk
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794937592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w57ByeZ/+V9X+bMer2TMnJk8VF8FzruIqxDs/1tK9F4=;
 b=MklEpioMQ2B+3uVBYDPzUJuELQSFma3ez4ng04piTI9dFd3n6MzAqABlup1bNgAzJ+oynN
 64tWy94cla2v7ahvAkNjaQX0QhaLRQB4g/zXI6aVlJP75WWNzOFlXGVXPBW9lZXiaYk4Lr
 /xwb76UyIVr4hqHU69PVUx74pQBYc6o=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-OH4voYOKNdaHKEdm4Om52g-1; Tue, 17 Nov 2026 12:46:31 -0500
X-MC-Unique: OH4voYOKNdaHKEdm4Om52g-1
X-Mimecast-MFC-AGG-ID: OH4voYOKNdaHKEdm4Om52g_1794937591
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67c1c64551bso8060378d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937591; cv=none;
 d=google.com; s=arc-20260327;
 b=gNpibZ3a7XH1OHONIoyOsNpF7Pq54cBPvYdNvmPaDwJBY/cOfVEvsRdKOFpU1K1rZ1
 FgROXqCPmTx9X5eqDQJcQkFpJO6eRnKRetpIwpdo3dN4T3WQnWvGq4czJ2TS1OZJaatH
 KI2/R7/dVP26VBkvvRHsgKmPpDNxrS7gVZr7FvtkUfWlxuvHgUyceViL2zN8f/sTEQym
 6wfURKl7kYeHP1KDehjcAXF4gm8wkUrg1Z2mzT3FZLbksm5vcIxprFCmYqzhhFpaPjJc
 Oq73PMzFRoYovzgwqI3zj6RlFvqd88tX6/RW2bPokKG7xig+N1cLJKKeTPnL0ZAk+kd3
 hh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w57ByeZ/+V9X+bMer2TMnJk8VF8FzruIqxDs/1tK9F4=;
 fh=P34Hj870BWRSFvmnJEXTdTiM6mh8yRDRVvi24Yf/SDg=;
 b=aft+2UNEYJCzUia5TeHgGU6F+OsA4T//CDpEc98tibjBmCjcsQIc2wRl15XTKhcAkj
 0ARjWJzXGs3A7HmOg5d3Eq6pzM6Wd5Xyidu7RxcepvTd4liph1cckx5CxDbR4fsP00MT
 XLbmQmsy3i0P2zFuVBeY8o2yGk9IloDqAcpZ7epYDn3XKpOI5GCsaRPohs6XZTB+4xh0
 RzQTZopU11cbStE6PGtENHHlCEg/i6TcWDCzkLcT5yaSUn8Ei8sOL2w3vKIvDe16J+4Z
 k8tkMQ40IN06PM5IVz8FJ1zyQwBR9xnBhDE88AJFPnjGotOXnccZIfGhVvEIQqKcQpCQ
 2AXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794937591; x=1795542391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w57ByeZ/+V9X+bMer2TMnJk8VF8FzruIqxDs/1tK9F4=;
 b=YMBZ74UXyQ2Jfe17P/MJFy0H6IsHBvzX4jyKLEQYsu83QHuschsnS6RUJnix7I91OS
 RH9DkRfO+hd0XPpwe+2wv2kmQnnsze33/W+1ryWCl3fK9UsaC2BAZrGUlmkG4jkxfz+d
 cgOHulxsDT02quzYKS7LriRMcsAXvuHxOm4GPGt4gb62/TwJBSJ4SwDKYQ6IBr3mlt3L
 kJAAQjb0MEUbePnUeDo7og0B79VpelEwyuRj9iWywxfq95MwObmXK0pR5/iFB29Kdx13
 9AefkbeanIJRgBug2FUrOL286YFUqxgy3ulpPDRrxutwgnk3qYHObOl4QkvZlD+y6Ti2
 7edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937591; x=1795542391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w57ByeZ/+V9X+bMer2TMnJk8VF8FzruIqxDs/1tK9F4=;
 b=l9xcBdco9SNj9mc3Wh2c6EXoTHmTPWQ5TFwVC7xAyp/NPTklssGFdPQWu9kN0yTqSO
 fkhoHrtinOWZCI0s5hiC7q2gqK1qTeqB/52RT1ee0I3H10v5JP3Ei0MQCGluSH8zq3Km
 Vp11yUb2NU5GFpsrnaNhabYvuozxYLcoQTSUB37Pv/MH/D0EPd+Vu6zKPzuKqDvsrBCE
 6tnDsaWCPPl4NlnI5JXSkZYmpXrBOE3lm6lwx3OSgYFvalvlqVM2Ov5eLRFV0GIIn3q+
 RTnN2cPVvUO+yJTlqygZXu3+QglbwScPXOdhgQhXp27RSUxQnPz74vPVp8gMZLAg9pZZ
 MWxQ==
X-Gm-Message-State: APuU4Z94UC4YecK45mgLmxx65F3le8wk/YLgXqccOT8HcPwCrm6FmIbj
 VeIv7FTYDW4wP8//Mj8H0LyALlKQy1EVRtjbzCSxBe6EzNNg0d8h5ImHdshi6DvAUKprFUAYomw
 t+diDZ0bVcIWddr99j+3XNA7WRVwKVUFZMUOOleAk76EX5cLMAUrOIA87D1daDZ4OQmJV4dOCd+
 mO5H11QIqnH8DpW0xBCYBgnejZ9ScDwy91Dw75t7I=
X-Gm-Gg: AZFdTZffJGlnPeaKV7fbyYgYoVOnf0L2PurXWO9s2teI+/45Wf9oXNXUW6MxTUEQUA3
 2aGcqvOsC8p109l0eF/3w04zxti4SbK+xXoeoLfLpnWkWNz/Hd7ozvngm1o36RtmmbPKakDak7G
 yt0402UxWH4OWrowjhx4GnyIs28tx3FdmM9aFF3/xXCOetkF9/4IuQ5xDWC/Z496l+ukXKX1sdS
 Dx4VPogV49BaHsG
X-Received: by 2002:a05:690e:12cc:b0:67d:ad36:d42c with SMTP id
 956f58d0204a3-67dd3cfd3d3mr233954d50.15.1794937590632; 
 Tue, 17 Nov 2026 09:46:30 -0800 (PST)
X-Received: by 2002:a05:690e:12cc:b0:67d:ad36:d42c with SMTP id
 956f58d0204a3-67dd3cfd3d3mr233935d50.15.1794937590054; Tue, 17 Nov 2026
 09:46:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116183045.118241-1-jsnow@redhat.com>
In-Reply-To: <20261116183045.118241-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:46:19 -0500
X-Gm-Features: AclHuK_Rkn4j1LPon8cWdq2LnEIx7d-tCvieXPlKeDLM1rNfegjEUOV5Gx00l9A
Message-ID: <CAFn=p-ZSkfi-SGWFuh7=v-oota-1rK4M6VuuQFqT-Biwu2qNAg@mail.gmail.com>
Subject: Re: [PULL 0/2] Python patches
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 1:30=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394=
d5:
>
>   Merge tag 'pull-nbd-2026-11-10-v2' of https://gitlab.com/ebblake/qemu i=
nto staging (2026-11-13 08:44:16 -0700)
>
> are available in the Git repository at:
>
>   git@gitlab.com:jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 8ff6cd65b6e4a9944e54dd27aa3a72ebef8f93d4:
>
>   python/utils: fix accelerator detection with annotated -accel help (202=
6-11-16 11:53:21 -0500)
>
> ----------------------------------------------------------------
> python: pull request for-11.2
>
> ----------------------------------------------------------------
>
> John Snow (1):
>   python: add support for Python3.15
>
> Marc-Andr=C3=A9 Lureau (1):
>   python/utils: fix accelerator detection with annotated -accel help
>
>  configure                              | 2 +-
>  tests/docker/dockerfiles/python.docker | 5 ++---
>  python/Makefile                        | 4 ++--
>  python/qemu/utils/accel.py             | 5 +++--
>  python/setup.cfg                       | 3 ++-
>  5 files changed, 10 insertions(+), 9 deletions(-)
>
> --
> 2.56.1
>

For posterity, my refreshed gpg key with an expiration in 2028 was
pushed to the ubuntu keyserver.

--js


