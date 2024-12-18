Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86041E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Ip-0004qT-3d; Wed, 18 Dec 2024 16:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tO1Im-0004nd-BZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:09:52 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tO1Ik-0005pA-F7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:09:52 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so113141a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734556188; x=1735160988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUa/Lipn/tg7d+VNJwdnQrVC6z+81dvheJ3nA/tND8Q=;
 b=cq5jyqNuIAVpdBmJTvu57F6jyjI+afZDe8z/uycHhWcFjCrww9SLc84XhYmW2XQJlQ
 6exErE18E+bIGiqtRYWW82CadFwA2KjijMf58NLQs69dLnurGjDyBTpZMeZ1IoI/T0pu
 Ec0C5JZigLnpws6WSf1uQ1+TAYWi9AAyayJBRtQ9LKVFN7AIuUUybpYVV4fo5+q3tPtF
 2yWjnT0XtyRFB1MgchQLCl+u9671fXOlP6V8sbws9rKThumZXRAlzXcx/vYgGG5FgQ3/
 DUFw4ZsjB9ypRKMg16G6RlBF9TBdxBUSAFuaKgaVPZ/YU86RL2PZcTV+CG9EH89g+T/5
 xmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734556188; x=1735160988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUa/Lipn/tg7d+VNJwdnQrVC6z+81dvheJ3nA/tND8Q=;
 b=k+KXOldlWy+5R6atwtQIoQd4fmdcNngd7CW3cqyamsgDgetfi5agHhku2H9o6DENj+
 jWgODau+tsp2q7hwZnXwz4lgeXXE7i7AO4FRDUYbejM0eVWKVWa8flETeQjDXZ4BtG7k
 y2Y17VoUSRwpyx4qcZSLf0bPERs3TK84sZcpFK2A02reiSGJw63Yn89RJTwJ0yWH0CzC
 fUzK5xSt9no68FFZr5BawtjbxPEqhcT6umz6mtdJlmsGi0a+cfsZsKc8IzczJImhR2rY
 euDNQsudp/tO32mzsGyvoLqajp/mPBjb4gSeOklmY0pEXp5UrCe+UFKTc8lrepQgznxz
 JLZw==
X-Gm-Message-State: AOJu0YyJhbg8+D6KFFv+o5QONCU6dDhKr1K5zBYg2fvcQEZyFjlSXRTK
 UwUPSiwuYxxTx8XDIUUzuYx4VmiEMZTUJJM5J/Jv0r4wHeKWxmLOZ5QlzzNVNmHRpVIIzRt7OFU
 K8xV0wAb9fUPagEcWwJL9qrb/1I4=
X-Gm-Gg: ASbGnctsWH9qFMltHhJSag2lkqEc385araSFW8lcTzZH05aUTWb0zvyn7s9SkGuRAer
 PfV8UmE06WPEoLptRsBTIMAp9G7ZD/TZZJfGW
X-Google-Smtp-Source: AGHT+IGFO+VeMedL+P4E/Eg//MJIAu71juokDJsngoxJqQuYQP/0BOSt88dGVk0nyGewWGzOg9t2IhbGDQ+cLUTVE9M=
X-Received: by 2002:a05:6402:2345:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d802669266mr647260a12.31.1734556187494; Wed, 18 Dec 2024
 13:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20241218105303.1966303-1-david@redhat.com>
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 18 Dec 2024 16:09:35 -0500
Message-ID: <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com> wrote:
>
> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
>
>   Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/davidhildenbrand/qemu.git tags/mem-2024-12-18
>
> for you to fetch changes up to eb5c5f1ab479e9311d8e513e3eeafaf30f2b25b3:
>
>   s390x: virtio-mem support (2024-12-18 09:50:05 +0100)
>
> ----------------------------------------------------------------
> Hi,
>
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Fixup handling of virtio-mem unplug during system resets, as
>   preparation for s390x support (especially kdump in the Linux guest)
> - virtio-mem support for s390x
>
> ----------------------------------------------------------------
> David Hildenbrand (15):
>       virtio-mem: unplug memory only during system resets, not device resets
>       s390x/s390-virtio-ccw: don't crash on weird RAM sizes
>       s390x/s390-virtio-hcall: remove hypercall registration mechanism
>       s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
>       s390x: rename s390-virtio-hcall* to s390-hypercall*
>       s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to machine code
>       s390x: introduce s390_get_memory_limit()
>       s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
>       s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory layouts
>       s390x/s390-skeys: prepare for memory devices
>       s390x/s390-virtio-ccw: prepare for memory devices
>       s390x/pv: prepare for memory devices
>       s390x: remember the maximum page size
>       s390x/virtio-ccw: add support for virtio based memory devices
>       s390x: virtio-mem support

Please take a look at the following s390x-related CI failures:

https://gitlab.com/qemu-project/qemu/-/jobs/8679972861
https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
https://gitlab.com/qemu-project/qemu/-/jobs/8679972894
https://gitlab.com/qemu-project/qemu/-/jobs/8679972931

If you find that this pull request caused the issue, please send a new
revision of the pull request. Thanks!

Stefan

>
>  MAINTAINERS                        |   5 +
>  hw/s390x/Kconfig                   |   1 +
>  hw/s390x/meson.build               |   6 +-
>  hw/s390x/s390-hypercall.c          |  85 ++++++++++++++
>  hw/s390x/s390-hypercall.h          |  25 ++++
>  hw/s390x/s390-skeys.c              |   6 +-
>  hw/s390x/s390-stattrib-kvm.c       |  67 +++++++----
>  hw/s390x/s390-virtio-ccw.c         | 165 ++++++++++++++++++---------
>  hw/s390x/s390-virtio-hcall.c       |  41 -------
>  hw/s390x/s390-virtio-hcall.h       |  25 ----
>  hw/s390x/sclp.c                    |  17 +--
>  hw/s390x/virtio-ccw-md-stubs.c     |  24 ++++
>  hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++++++++
>  hw/s390x/virtio-ccw-md.h           |  44 ++++++++
>  hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw-mem.h          |  34 ++++++
>  hw/virtio/Kconfig                  |   1 +
>  hw/virtio/virtio-mem.c             | 107 ++++++++++++------
>  include/hw/s390x/s390-virtio-ccw.h |   4 +
>  include/hw/virtio/virtio-mem.h     |  13 ++-
>  target/s390x/cpu-sysemu.c          |  15 ---
>  target/s390x/cpu.h                 |   2 -
>  target/s390x/kvm/kvm.c             |  18 +--
>  target/s390x/kvm/pv.c              |   2 +-
>  target/s390x/tcg/misc_helper.c     |   7 +-
>  25 files changed, 866 insertions(+), 227 deletions(-)
>  create mode 100644 hw/s390x/s390-hypercall.c
>  create mode 100644 hw/s390x/s390-hypercall.h
>  delete mode 100644 hw/s390x/s390-virtio-hcall.c
>  delete mode 100644 hw/s390x/s390-virtio-hcall.h
>  create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
>  create mode 100644 hw/s390x/virtio-ccw-md.c
>  create mode 100644 hw/s390x/virtio-ccw-md.h
>  create mode 100644 hw/s390x/virtio-ccw-mem.c
>  create mode 100644 hw/s390x/virtio-ccw-mem.h
> --
> 2.47.1
>
>

