Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B98CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 20:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5V7Y-0007mz-4j; Sun, 05 Oct 2025 16:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v5V7W-0007mg-Kc
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:14:14 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v5V7U-0004hy-Rl
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:14:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1759695249; x=1759702449; 
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject:
 Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender:
 Sender; bh=I+ChIouOVga1P030P3JkAbcqIwL7GH8IrTstjppXFgk=;
 b=oB49LHMQLBwLZIDPWo7Hz/wV8OzQaVQzOXPEw0FGiwS8hb1fzwOomZZpQ7bfOx6YeooQPM6MVOFYEdx85zmV++gsbNq/C17xYVo9VQzM7ztYpoUbXZjH5h4X7o9Nob5TwYvjoKtmiro69PzFYySjQC4NCqpvecH8AM7X9YmfjapTiSpJk8ocJTP8KeWVZ688SqglofWjUy8fCJ45/bzrjmMPwWNUmx0i87CNbV82Aa9S7E2YBQJVjoyV1zkycojqld7vNA5NiS34qFNxH8cGMVBS0pisAKF0zKzQDRIEpoLosh29WHslUGuaPklBBrwzTVe6qsJjeVLr0cH50Cd5eQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by
 77ac684261ec405a7a643a236bc29c3c26774436f831b2c9af494d6a3cfd20bf with SMTP id
 68e2d19158e35fe37ba5c56a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 05 Oct 2025 20:14:09 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso1568269d50.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 13:14:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX6m6Sj9KwV7xjq30AguZ5zVit4iBvc1ZkpRNyKmNDko3nj4Gt6GZ0ZJiNky2mMDNmbk+Dxs0o5Y0cg@nongnu.org
X-Gm-Message-State: AOJu0YxWHhbpJJoz4Tj6jFv0VDyobyMIh2E+exei5s2ZekVXaxdnTr+o
 2I0r5Uq5wTOl83XR3frRku3fPyfT1gH6H6HH/fsG9Q3Q8mwwZ3u8zOi5R4RKyBQEaCBK4vDHBrj
 kwHpkypOrIxCDMMZ/Jt3UZJv6+b+JJTE=
X-Google-Smtp-Source: AGHT+IF6NTB7C1J+sc5gwU09D6vTTEgQsjhGgjC0gkdmRcIaMTw5vF0hSyBdo0glo5NFxqdiep4ByU4Q6w6ugaMM3Rk=
X-Received: by 2002:a05:690e:1590:20b0:635:4ecd:5fcb with SMTP id
 956f58d0204a3-63b9a0f36f3mr8506491d50.40.1759695248605; Sun, 05 Oct 2025
 13:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1759691708.git.mst@redhat.com>
 <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
In-Reply-To: <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Sun, 5 Oct 2025 22:13:57 +0200
X-Gmail-Original-Message-ID: <CAKiXHKeXZBS3Zhn+snXi3sxG0r0cmoUW-ekeXHrQS64T10FJPQ@mail.gmail.com>
X-Gm-Features: AS18NWDFzXrVB7gra8EDF1ZJ_lc9gSReJ9d7HjXxEX_DpWfsl36i4L1BzAR8hkg
Message-ID: <CAKiXHKeXZBS3Zhn+snXi3sxG0r0cmoUW-ekeXHrQS64T10FJPQ@mail.gmail.com>
Subject: Re: [PULL 49/75] virtio: Add function name to error messages
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@redhat.com>,
 Alessandro Ratti <alessandroratti@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, 5 Oct 2025 at 21:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Alessandro Ratti <alessandro@0x65c.net>
>
> Replace virtio_error() with a macro that automatically prepends the
> calling function name to error messages. This provides better context
> for debugging virtio issues by showing exactly which function
> encountered the error.
>
> Before: "Invalid queue size: 1024"
> After:  "virtio_queue_set_num: Invalid queue size: 1024"
>
> The implementation uses a macro to insert __func__ at compile time,
> avoiding any runtime overhead while providing more specific error
> context than a generic "virtio:" prefix.
>
> Also remove manual __func__ usage in virtio-balloon to avoid duplicate
> function names in error messages.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20250915162643.44716-2-alessandro@0x65c.net>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio.h | 4 +++-
>  hw/virtio/virtio-balloon.c | 2 +-
>  hw/virtio/virtio.c         | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index d97529c3f1..695bb56186 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -253,7 +253,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_=
id, size_t config_size);
>
>  void virtio_cleanup(VirtIODevice *vdev);
>
> -void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINT=
F(2, 3);
> +#define virtio_error(vdev, fmt, ...) \
> +    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
> +void virtio_error_impl(VirtIODevice *, const char *fmt, ...) G_GNUC_PRIN=
TF(2, 3);
>
>  /* Set the child bus name. */
>  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name=
);
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index db787d00b3..e443f71c01 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -697,7 +697,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithRetu=
rn *n, void *data,
>      case PRECOPY_NOTIFY_COMPLETE:
>          break;
>      default:
> -        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reaso=
n);
> +        virtio_error(vdev, "%d reason unknown", pnd->reason);
>      }
>
>      return 0;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index de89e8104a..0f33ca5d90 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3968,7 +3968,8 @@ void virtio_device_set_child_bus_name(VirtIODevice =
*vdev, char *bus_name)
>      vdev->bus_name =3D g_strdup(bus_name);
>  }
>
> -void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fm=
t, ...)
> +void G_GNUC_PRINTF(2, 3)
> +virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...)
>  {
>      va_list ap;
>
> --
> MST
>
>

Hi Michael,

Thanks for picking this up.

It seems that the version currently queued is actually the initial
submission, which had previously been rejected following feedback from
Markus Armbruster.
I later submitted a corrected version ([v3]) which:

* Addresses all the feedback (including from Markus Armbruster and
Daniel P. Berrang=C3=A9).
* Has Daniel=E2=80=99s formal Reviewed-by:

Patch: https://lore.kernel.org/qemu-devel/20250924093138.559872-2-alessandr=
o@0x65c.net/
Reviewed-by: https://lore.kernel.org/qemu-devel/aNO7J7Y6wsk1-wyw@redhat.com=
/

Would you mind updating the queue to reflect this version instead?

Thanks again for your time and all the work you do maintaining virtio!

Best regards,
Alessandro

