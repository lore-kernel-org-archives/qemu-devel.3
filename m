Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D50C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfXC-0006qb-Nv; Tue, 16 Jul 2024 06:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTfXA-0006pA-Jo
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:35:48 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTfX7-0001cr-Uy
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:35:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b447c51bfso6939075a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721126144; x=1721730944; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V56vDIqVAmmofi4MPaP03VMccsDzzQeV+azCpJzQJvU=;
 b=lGmylZVk3CaKMHaLmG1JYwQRQJqcdLkSLPkhGzZnasmgr/m/dsGNszTA2SJWxApVab
 5ieOfcMBzEVleviHWoF0yfDCFwXVtKniZZ5hB+brt9phFZMDZr8owSM6Y+wIIQlVFjIv
 fV5iVJJTlGTB4VF0fElBP/y7XtrfAoZXghsCIVNxzr/y8rbdKcAYv8bC/t8UqptysXty
 E86UrnfXxKNoIdVHZQtFFUIZis52SY7FAHYiKYSusJeZORb5f76x+nCCugzKH2g4HdsK
 YC6nU/D6fWPpKSzCBkPr7aETp1QMLf9QItP5fc9H9KkpJlCBbQ+myBPiPDgFWm4vsK7K
 bOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721126144; x=1721730944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V56vDIqVAmmofi4MPaP03VMccsDzzQeV+azCpJzQJvU=;
 b=YZqXt3DVulyrwJ8PkClWvuAShMYEyxRGSEmfDRtKMcK+sIHiO87HssLH7bq6Bp2mjR
 uAkQnGzbgj7icApncSpnQ9ZPr6gd54oqSmBMwOiLGH5JqlVWRddgeXxAXQv1/Dk2eVkR
 yNpzPF4+1pH0cTGW75BtwUCqdKJqW6PaHWUH2akSwVFC+u2PMAG4tdmNjkNUNIL7tXyB
 LyS4nEhtnSGySih9okf50uoPuOLwAHFkRfNvRcDm48UvhVVlT9djMjEryj01xMJ2cr1V
 y6zIrAjUJxESB9mCxfjaxXv1E2FBAZAuzQSEcc52ZyTG2HDA33fMBODUUH9KzqjnMRfV
 mdhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxZdMP1vSpn/WvoVK/K4ROjbCbbZ/jAeR58MQnGa99JRY/bMGZL0GCumVM1cbesLGvB59VmEodAwSjzyRzh6Y+x2Xpcts=
X-Gm-Message-State: AOJu0YwptiNAfWhJleDt0XfzV9G9FRxM5FKTvCu1rYax1GHt8pbBxwlL
 QZQI7RucfxgxBYZ4rjuOhQKv/rqLv+QDhZpa26FR79UfLCdYtmtbS/MjcxBMOx1g07kD83CMP3E
 yTQsxqFyreXNSEPpPYsHmmwB2r5jvN8Dtw3DVmw==
X-Google-Smtp-Source: AGHT+IEsNBulhfo7eC0OVSbKQrVkkjGDI0nJ9vBZooB97e6aIydoxIT7pIfv9rG+WxLfIefjqZMbiFlk1zucM/Ae1wk=
X-Received: by 2002:a05:6402:4581:b0:58b:9e7c:bcbf with SMTP id
 4fb4d7f45d1cf-59ef0ad1232mr1083461a12.36.1721126143538; Tue, 16 Jul 2024
 03:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240713160353.62410-1-me@samjakob.com>
In-Reply-To: <20240713160353.62410-1-me@samjakob.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 11:35:32 +0100
Message-ID: <CAFEAcA82m+8K8rWDMBehPp=NGUezHZPn1LVoyU3DJ3LWq+ZnAw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/bcm2835_fb: fix fb_use_offsets condition
To: SamJakob <me@samjakob.com>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 13 Jul 2024 at 17:04, SamJakob <me@samjakob.com> wrote:
>
>         It is common practice when implementing double-buffering
>         on VideoCore to do so by multiplying the height of the
>         virtual buffer by the number of virtual screens desired
>         (i.e., two - in the case of double-bufferring).
>
>         At present, this won't work in QEMU because the logic in
>         fb_use_offsets require that both the virtual width and
>         height exceed their physical counterparts.
>
>         This appears to be unintentional/a typo and indeed the
>         comment states; "Experimentally, the hardware seems to
>         do this only if the viewport size is larger than the
>         physical screen". The viewport/virtual size would be
>         larger than the physical size if either virtual dimension
>         were larger than their physical counterparts and not
>         necessarily both.
>
> Signed-off-by: SamJakob <me@samjakob.com>

Thanks for this bugfix; I've applied it to my target-arm.next
queue and it should get upstream within a week or so.

-- PMM

