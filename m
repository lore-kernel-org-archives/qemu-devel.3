Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301C3C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3PN-0002QD-Mj; Thu, 06 Feb 2025 10:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg3PC-0002Oo-U5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:03:05 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg3PA-0004me-O3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:03:02 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dcea56d6e2so1833794a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738854178; x=1739458978; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLdJi4U7fEVnSaHGWLoixI2X9/Q9WTKa8jI/Sbrxh44=;
 b=b/XeSTJF70TyeNn63GYsfhVTpnqRqF0QvPa0f1oOrXVl8ocZoNE4mx2T++CkQcXKHU
 1nx4f6ymWdAHIHtpA8GEkShOnYWo/haRluckHAxAgBkbc44huQXhD1sjMX54QybSUIoi
 myXOp5oBcqiO3o2hbumdgDzWZP2muaD2W1QCAtveUkl3wqXhzxY9KOnZz5HULUP5/eRA
 aJejqAbc7sYwCBp3z4AcBSvMr7A0be3A978UQu8Uzfxzpl47vQzOgzvm5poQkUcfTDk9
 nugLQDkcWnbk5wQAgTzONbcARs6mF4wAC/9tLoEIX7boJRDrniu3B+DgivF4e23v5jmR
 HBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854178; x=1739458978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLdJi4U7fEVnSaHGWLoixI2X9/Q9WTKa8jI/Sbrxh44=;
 b=kCeXDcwVLOWIEpEyQsXhUTY6cYDaHeB2bBNF8L9rojmdQIzbqhiGewM1nBOabGoZ0S
 EZALc+wXKajoO2BaH0R4pay/LhBcV4zTLxVqoAQ3xAIDGg+/MIztXIP/26Q5IoS/i9SG
 /+swBr4mhZLFpn5tU0m7USj8zXJ2MqfpW1Th89DVm4CEnRvayAqNV0xR5mXa7pe2HPsS
 Z6IgNfnZHcH/vS8dXVHSbVpNPFvyZ7KnhtbxogjkeRhFeOMwSoUpHiWBwzEhSw748obx
 VLLKGmy46CqQBqevb0TzAyI7/DGF7QreJ8t9n9MywHYdeXI6az1uaO+tkCf8FKQGLVeo
 isOg==
X-Gm-Message-State: AOJu0YwjqK/fB7F94i4GZxMXEC/HyB8eIqPjQehxZnv9JL7d6F4/IMDy
 HCw+Cw8wPAocMD4UGqOJhlPKVu+Mk+6bKfO/H6pcsZNAxQmTDuEk8YHcHCi9YcwyBVH4oH7IOPK
 QzSyzC+yFyQz1zYJ8pVCyYkzdJhE=
X-Gm-Gg: ASbGncueu6w+pcJ6ZWWm6g7XjpIqlIHN0ZZ3oJLzO3xcq+Je7prD+kl2/8cgEJTHzYS
 1+8GOEugCwhBupwxari5t5ZKGlfuWFDgw7zMgiuD5yD8cZvm/CdeDLlnasqNhp60PN709wBo=
X-Google-Smtp-Source: AGHT+IFm3GZYMklSVL3KfRyfhQSdqu4mPlu/ASReyOBylKB4YfAePVKqrCnIUT2NLo00mffp/qOCDzTSCafbDCYvREA=
X-Received: by 2002:a05:6402:35cd:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5dcdb775245mr7038055a12.25.1738854175491; Thu, 06 Feb 2025
 07:02:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <Z6SCGN+rW2tJYATh@fedora>
In-Reply-To: <Z6SCGN+rW2tJYATh@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 6 Feb 2025 10:02:43 -0500
X-Gm-Features: AWEUYZnABPAiNQnHAuAcUp5oMT6n8P_YdJatgdJcAJweLCH27C-YEAxaw0sIwpg
Message-ID: <CAJSP0QXHG8Vj1EomaRRTfQWykR=9mWQ3SDWn0pCG-b_8rJuKcg@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, felisous@amazon.com, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Feb 6, 2025 at 4:34=E2=80=AFAM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
> =3D=3D=3D Adding Kani proofs for Virtqueues in Rust-vmm =3D=3D=3D
>
> '''Summary:''' Verify conformance of the virtqueue implementation in
> rust-vmm to the VirtIO specification.
>
> In the rust-vmm project, devices rely on the virtqueue implementation
> provided by the `vm-virtio` crate. This implementation is based on the
> VirtIO specification, which defines the behavior and requirements for
> virtqueues. To ensure that the implementation meets these
> specifications, we have been relying on unit tests that check the output
> of the code given specific inputs.
>
> However, writing unit tests can be incomplete, as it's challenging to
> cover all possible scenarios and edge cases. During this internship, we
> propose a more comprehensive approach: using Kani proofs to verify that
> the virtqueue implementation conforms to the VirtIO specification.
>
> Kani allows us to write exhaustive checks for all possible values, going
> beyond what unit tests can achieve. By writing Kani proofs, we can
> confirm that our implementation meets the requirements of the VirtIO
> specification. If a proof passes, it provides strong evidence that the
> virtqueue implementation is correct and conformant.
>
> During the internship, we propose the following tasks:
> - Get familiar with Kani proofs written for Firecraker
> - Finish current PR that adds a proof for the notification suppression
>   mechanism (see [2])
> - Port add_used() proof (see [5])
> - Port verify_prepare_kick() proof (see [6])

add_used(), verify_prepare_kick(), and notification suppression are
explicitly named. Firecracker's queue.rs has proofs for a number of
other proofs as well. Would it be possible to work on them if there is
time remaining, or is there a reason why only the proofs you mentioned
can be ported?

I'm asking because a 12-week internship is likely to leave enough time
to tackle more than 3 proofs.

Stefan

>
> '''Links:'''
>   * [1] Kani source code - https://github.com/model-checking/kani/
>   * [2] Notification suppression mechanism PR -
>     https://github.com/rust-vmm/vm-virtio/pull/324
>   * [3] LPC Talk about how we may check conformance in the VirtIO
>     specification - https://www.youtube.com/watch?v=3Dw7BAR228344
>   * [4] FOSDEM'25 talk current effort to use Kani -
>     https://fosdem.org/2025/schedule/event/fosdem-2025-5930-hunting-virti=
o-specification-violations/
>   * [5] https://github.com/firecracker-microvm/firecracker/blob/4bbbec06e=
e0d529add07807f75d923cc3d3cd210/src/vmm/src/devices/virtio/queue.rs#L1006
>   * [6] https://github.com/firecracker-microvm/firecracker/blob/4bbbec06e=
e0d529add07807f75d923cc3d3cd210/src/vmm/src/devices/virtio/queue.rs#L966
>
> '''Details:'''
>   * Skill level: intermediate
>   * Language: Rust
>

