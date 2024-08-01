Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8096DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 03:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZMWb-0001XD-3u; Wed, 31 Jul 2024 23:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMWZ-0001VC-J3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMWY-0007pr-4D
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722483041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRnIoxhtmS04LUR5Fr2AhObq2Vi0UowFWVOhiKEXTVQ=;
 b=Q8P7oVqy3q1j3v/9p4t/aJs/+RB2SbRoCXyMu0xun/y+Zbw33ScJVvd+Kqvn+lYkuUnuSb
 KGPWZghXGO23bFrioiDO+PpIr7cFoQLrnpU701Js7hh+lRjY7m5/imJtRWxXfWiRwDZFkr
 ZyXoPVoFmoF/nOCMhBJOOG4M7ec9470=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-FR0daI1RNMS-sHm8KehuTw-1; Wed, 31 Jul 2024 23:30:39 -0400
X-MC-Unique: FR0daI1RNMS-sHm8KehuTw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-664bc570740so28551677b3.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 20:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722483038; x=1723087838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRnIoxhtmS04LUR5Fr2AhObq2Vi0UowFWVOhiKEXTVQ=;
 b=Urh3mYlR+n+V9sXMS7y7Dh0glMgLeS4xNS/VX8jHPQczvBMhT8Jl+APY1as+dBh+i0
 40XC8aC8fiC7EDdKAoAlQihbosXAttRL78le0kQ5LZEoHRhiNIQul3YNQWHMIhRKIZTD
 5J2CRaJsZpGKOm11HhaJ32G1PB6XdnN6y06BaZhvvrlqOaNB9NzaT6DUnSrDBga7Wd9X
 1gnSXQTp+HikvT/ikVpVhY0OpTD1/31uHO+d/dEeOFt+1ldUyE/uh0Oesi7TX+pe2Goe
 k9dMVxXwpw5ChoSar48P0n90D8R9zsNxA/XtmCEGE5bTAlwW20gIga2wOcT/p2H7DaMt
 kRiA==
X-Gm-Message-State: AOJu0YxgJu2tn6ffee6EGzcI5VYNmtoGjkOJ7SHQUd5ZTYuQP3Ox5ky5
 qeo5jM8bG/6vKksDtCIwa25/F5+UiA8T9osgprbl7+VR5Y9H9Kv8mR1K9uL49wS7vnvdy7+NVag
 3ug7i7ni6iApmlWzkUcKWJKM/3HWUzpSnF1jl25Yn0+bRV+KL2EvH1HxBkwkDWERrlvOWRM21Os
 5Sto6nF3H62Fbi9QabgfXRDUrqmWA=
X-Received: by 2002:a0d:e944:0:b0:640:aec2:101c with SMTP id
 00721157ae682-68741ef40fdmr8392007b3.2.1722483038631; 
 Wed, 31 Jul 2024 20:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEc+0R+0iZI0YY0geNnyOpj9rwwTrXQrSh9z23VQ/Gn0T+AatmnUkFA7gwngv+CD5YcR7Jqfteif4Li0UMq2M=
X-Received: by 2002:a0d:e944:0:b0:640:aec2:101c with SMTP id
 00721157ae682-68741ef40fdmr8391817b3.2.1722483038348; Wed, 31 Jul 2024
 20:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-7-crosa@redhat.com>
 <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
In-Reply-To: <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 23:30:27 -0400
Message-ID: <CA+bd_6K5S9yrD6hsBsTmW4+eJpPsquE8Ud9eHZzptUwDrHcpeQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, kvm@vger.kernel.org, 
 qemu-arm@nongnu.org, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 11, 2023 at 11:32=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 8/12/23 20:09, Cleber Rosa wrote:
> > Some of these tests actually require the root filesystem image,
> > obtained through Avocado's asset feature and kept in a common cache
> > location, to be writable.
> >
> > This makes a distinction between the tests that actually have this
> > requirement and those who don't.  The goal is to be as safe as
> > possible, avoiding causing cache misses (because the assets get
> > modified and thus need to be dowloaded again) while avoid copying the
> > root filesystem backing file whenever possible.
>
> Having cache assets modified is a design issue. We should assume
> the cache directory as read-only.
>

I agree those files should not be modified, but I wonder if you
thought about any solution to this? Given that the same user writes
(downloads) those files, do you think setting file permissions between
the download and the use of the files should be done?

That can make the management of the cache (such as pruning it) either
require undoing the restriction or being done by a super user.

Anyway, just curious.

Regards,
- Cleber.


