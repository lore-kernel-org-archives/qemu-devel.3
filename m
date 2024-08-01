Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7ECC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXZs-0002n9-J6; Thu, 01 Aug 2024 11:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXZq-0002f7-Oj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXZo-0004ty-Uy
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722525528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVxVy3b6V33WthljR6Bt7cM5dUbZoIOtKUfZg4kCmyc=;
 b=GKVkArFQ2xJ/xQBHhYqr3xXc5vynuYEfdTL8p4t0HH91Xf2OfPV+lMKVEBY0Kase0D26RN
 hpwNqourmBMm6ZzEaVwCLTPaA+OVOy52NwDoQh9LpIG3YpFMHVBaSBID3Up7plLo5pI7jl
 q9HwVkCidD61Zb4Z52U47pTPenjd2H0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-JaP7ytPeP32JfFoWkLnPtw-1; Thu, 01 Aug 2024 11:18:46 -0400
X-MC-Unique: JaP7ytPeP32JfFoWkLnPtw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-672bea19c63so154694037b3.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525526; x=1723130326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVxVy3b6V33WthljR6Bt7cM5dUbZoIOtKUfZg4kCmyc=;
 b=l5wC1WN8W4SZ+ytFA9FyEuNLhK1de6fr7riQ5kLFAh2p1NiOLzhQIzd14R/KidICwQ
 R7cVBvm6ELZyJJdmzS4yNiMKISvzVcX0gfXCyPhYSslJOFUmys3IJ/Y7B2PGNmF2q8jH
 yBLOsFQT9iChC+fFuucDXZrnRqcTGb4ZB5pvqVcTSP4BxhXW92lfVkDEbx2LdqpJDucG
 cfDMD4P5jK7/smI00DBndspG3QRVWTupEczIqifX8kZA82SpK1nmLF5cpCDv3jKsZMYs
 bX06dpSG/c1Ch1MeeAlSGx956ednCdmmpIzFbcFuJI7TqnMdeLvlA4zPQhn9lnG/NIn2
 63lw==
X-Gm-Message-State: AOJu0YxvJr10dWVTREIhmDgnwEH+y1z5rWxhFe5tmkvdOTnIHu4+Cwsd
 6NC2sLlCjt3kxqWIatxUHpj9D6Hf9WTxO1Df1N+vSNW2f00V6iurOJveoRA8ljTsDXbCLlcoEX4
 NQ5If7vbwB4BhupgUePTkb4VZ3qYHBsCETHV7ntMEPKuoPqLkhyR9zB823bcFAHA0ZwoOsLTz/h
 zzPYpEd+ZijC3ldXvRBnTvt15jkGM=
X-Received: by 2002:a81:9c0f:0:b0:65f:d82c:af86 with SMTP id
 00721157ae682-68960589ddamr4136957b3.16.1722525526301; 
 Thu, 01 Aug 2024 08:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPbQpozQt07I/tuxDYhb9Y4hIen+QEehNUOnHcwNsaUMUYATiX4RaM/7svtDO6C1bWRm2ZNpuqmvZrduCYmOw=
X-Received: by 2002:a81:9c0f:0:b0:65f:d82c:af86 with SMTP id
 00721157ae682-68960589ddamr4136647b3.16.1722525526042; Thu, 01 Aug 2024
 08:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-11-crosa@redhat.com>
 <a7f2d78a-4de6-4bc6-9d54-ee646a9001fe@linaro.org>
 <CA+bd_6L7o05mENKVuLLfMFK9OF6ckU23ue0xmxiWO5oiT4ZEbw@mail.gmail.com>
 <68710de3-02da-4fa3-936c-62c85197893c@linaro.org>
In-Reply-To: <68710de3-02da-4fa3-936c-62c85197893c@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 1 Aug 2024 11:18:34 -0400
Message-ID: <CA+bd_6JMb-asEgR2qLcdton9uqY8ubg0gL-R-FfaEhEjiirRkw@mail.gmail.com>
Subject: Re: [PATCH 10/13] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 1, 2024 at 8:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> > Also, these patches count on the bump to 103.0 indeed.
>
> Then either mention it in the commit description to avoid wasting
> time to developers cherry-picking / testing this single patch, or
> move it after the version bump, avoiding bisectability issues.
>

You're right.  My bad.

Regards,
- Cleber.

> Thanks,
>
> Phil.
>


