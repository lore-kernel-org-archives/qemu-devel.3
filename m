Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB6CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFau-0007iG-7E; Mon, 04 Mar 2024 16:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1rhFao-0007hW-EF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:11:26 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1rhFal-0006sA-MU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:11:26 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-21fdf31a154so2734463fac.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 13:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709586681; x=1710191481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Hqb1C+XYVn3thuSGrZUtKLKE9O91b1Ym1bO374eQt0=;
 b=jjNDGPba7VAwH17WKKUVg+n58YRgzMBHNTkm0RhSz8xAvroKfah+F/OgJ7IZFCD/uo
 72pcove1bfIdfDc7pTjYDRxaWAr/6cfYqkMM49MXEopm5WWbA485jtLlzWWsFGHnVuxX
 QCZpJ3Ac0XCB2mglOv9POHOh97ZfZwGFjVYvPsG2BM1yT1U09VBrxLS/0OrsL4TK75jA
 ooumNdXAMMeJHmnFsSExqdyDkQg7EdJbPa0IG7Dx5oYV/+5QyfTJYiEbQCw+U5H69/5q
 2hhRMHlIdlaKw7iH3Y9s8wQ8MhmfSRvHfWmer2Ud43p4bg9F2OoHP6slvsnTwkDl/h/3
 4QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709586681; x=1710191481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Hqb1C+XYVn3thuSGrZUtKLKE9O91b1Ym1bO374eQt0=;
 b=i0v0b+LucGbYJWeYJfoeVqmammyLC9e7mLJRO65E5Wp51yPZPN3jt9qSTXA8MHaD7K
 O0gzhSe32gwfFyZwaGEDASS349lDmdAgwdw3p0EIFMV9PTFuNk/qfc+M4C09MPWeJLke
 xqtFkg2fz6acQQpHboGASPE13LWq3YAgKjoVcSmoVI+GHJJYlABedlflp2Yl/b5eRdtg
 N/0Ol+EVc6le37Hw9wokBUy5QOIWB3PVDmtRZ9+WNxJdZ6UrZcZ1KG7iVhpCx3gw0ZTI
 dVMZNDlz3CejkyHioVraA6NqRVkNP1SkDZD/h0cPUL2kU/Ty5ALsDB5KEWWxkkGzg0sV
 MkgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9OirW8bGLlcOxqtYudhyWmddJK8S/acYKvLsaFoNSk0+xZnmyWzvjc4bZnScGPMs5g6r9D1lSY1SG0GbAk2TxJOQxI30=
X-Gm-Message-State: AOJu0YzZEBI5N4MLM5yIOOwXhZhYLk2yT6Jyr/uWAhoVOmPckU0DDTVt
 PvgbQt0w9e6U+PuLykriMRrVJTrxT6O+4NSGbnGjRlTMB/jHava+PX/PaZ/4hZA9EwRe31Gig67
 CV1b9hP9Zbb1MhHZxdG0DF/kDVazb4/O3ehzV
X-Google-Smtp-Source: AGHT+IHbdurqtwEQIkOOm1yuieitXLJA+NYVfOJxd/RWPNmfq5pU+X62B9dpDuyk0XY6ImCrZJLP230hakQETu9sJgw=
X-Received: by 2002:a05:6870:1645:b0:220:a0b0:6d4a with SMTP id
 c5-20020a056870164500b00220a0b06d4amr12339900oae.57.1709586681421; Mon, 04
 Mar 2024 13:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20240221170027.1027325-1-nabihestefan@google.com>
In-Reply-To: <20240221170027.1027325-1-nabihestefan@google.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 4 Mar 2024 13:11:09 -0800
Message-ID: <CA+QoejU3y=0k3-hMQzzmOV-RxkxTe1pnSVpU-xv=B0WLHq3n4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] SMBIOS type 9 descriptor implementation
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, mst@redhat.com, 
 imammedo@redhat.com, anisinha@redhat.com, flwu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=nabihestefan@google.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Friendly ping on review for this patchset!

It's been ~2 weeks since it was sent out, please let us know if
there's any changes that should be done to upstream it!

Thanks,
Nabih Estefan

Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574



On Wed, Feb 21, 2024 at 9:00=E2=80=AFAM Nabih Estefan <nabihestefan@google.=
com> wrote:
>
> This patch series implements SMBIOS type 9 descriptor, system slots.
> For each system slot, we can assign one descriptor for it if needed.
> In versions later than 2.6, a new PCI device field was added to make sure=
 the
> descriptor is associated with a certain device, if provided.
> For ease of usage, qemu-options.hx was updated.
>
> Felix Wu (2):
>   Implement base of SMBIOS type 9 descriptor.
>   Implement SMBIOS type 9 v2.6
>
>  hw/smbios/smbios.c           | 142 +++++++++++++++++++++++++++++++++++
>  include/hw/firmware/smbios.h |  17 +++++
>  qemu-options.hx              |   3 +
>  3 files changed, 162 insertions(+)
>
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

