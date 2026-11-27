Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA8606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qngBMslZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvzl-0007eb-4J; Fri, 27 Nov 2026 08:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWvzi-0007e2-Nz
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:28:06 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWvzg-0004cC-GU
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:28:06 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so9369574d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795786083; cv=none;
 d=google.com; s=arc-20260327;
 b=RuxtLtuw61PwHcdD4Rgt0+QehtuV3P6IBjeQ2hVvHU/QbHeF2iPcVQjfi0VfWzpniO
 ysz2gLcoNizoezVxJmta8IVsDdmiotzMINSWDjBQybcsWTyscmyPrrPYRTBmCK6DQb4x
 4SCUsK39QDZFw0RS9sUFJcuNQvGhkcPQCkZx1/J+2qUxkJDj74pYJSVkGN6bvkv1Ivqk
 ATDBeDRbL6XWNKp7MIYa0/Cs1cqMZIQfXH8eRIgckfjIztAXo/sFVa7hh5dW8l4bsEw9
 N6z24I8u0CqF/GhpbHNktztimempCzv0G1YV4DTGGXkxFq2+aYL9AgUWLw4dMgL7vGeH
 Wm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RiIny8Q+zsJR8qlDU8jJJw5A2vkVGDu9dq9CcIFuqis=;
 fh=SFxUURFPv1FWWDTrQPJm0QHj4JAxq2KxeMsdDIY0mXE=;
 b=Igs+QuiCCzzfbWGqcXohUD/tJ5ebayQTM1VXSmFWis0aq2joKNybPEAZIpbNiknrhR
 4ngzf2iakIvhQAqwXSV3RU27PPvsIzI6IVlDp7qtczvjcXfln8iiNv8csHVQ/IUMy+Vj
 o4dMONkf77t7yvlkAikaTcjqDljn9algUw+VfS1YtEydzhsydzOHZSiB7s7zXPu8N5WJ
 fBAfhwNRDjot+c2hDuSqf76zu3Wi9DdUPD2eAztJwGBPnkhkydVQEVDTYxrPDsRM4xjC
 m5z3/S31ulbOOB19bb3BxDwuRb0Mpo068pO/z/ibPdD4jx7gDmKo+K0iXBYwpH1n8mNo
 g1BA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795786083; x=1796390883; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RiIny8Q+zsJR8qlDU8jJJw5A2vkVGDu9dq9CcIFuqis=;
 b=qngBMslZeROpHOgj4BFfJvwU64Brg4H0h/BmBtq4ashrNXGRfbft+kjQQm53S/B7oL
 aTBnA0OJUp6qLx8SQX5NMJXgtyzp22SXTIcU1xyuMsQDv3QIMfZvArW9WPG+Z01lLJCX
 p+tyKt33oQSLkAZGtyPU8Ut91t84m6hfM+K89LE3ASJeyQVMSovda3jPPcQDXyTI1Cbu
 hfKH5z689A2Li0wMJ+VRa7xerY2OyMBClYznpcC0DCEf24Dnpw5Xa50tRM79qBTecYXU
 0GzvP5edzkdfrMxGp1/13ox6+QFkX2+9f4MTCQ23OPiXeKLeQWA027uXlMx2OtfFf/CC
 oyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795786083; x=1796390883;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RiIny8Q+zsJR8qlDU8jJJw5A2vkVGDu9dq9CcIFuqis=;
 b=R0Z0aX3xfwgpDaWD8xBSzQGJVskU+1JZZTUBiNDovqoQQKOuBkHm2KX0QXdaI4IJ90
 cJQ7VHZWBdQHm2/U3JSievY+4ZPfh86309zUZyKS5LX3env2nZbIj2/zF8nKyQNbb2Je
 +GtAYvlo2OrdfzYmhWogb//tQFlDpaOw4PMzZVk0Uf/0NdZgCzg7SKFjNSNbzDzClTt3
 G986TfZNf1zg9peKODmGr3W46KpyIYCtBRai9bblI8T0+Fq/iBEZwKyV79el2Rkw7r6V
 5IPWMPEjRvOHvekpUJZNZZe1Sk7nUg6foUpbgcnBJiFaWXibEALlVjuhBTSNmKFwmMXe
 DZag==
X-Gm-Message-State: APuU4Z9xj8W4tVJjgoCetvXgn/4yqhpl/LijKHn2Sp+TdMLlF+3YwD4H
 7FwH872HQBTqWrRGg0E9xtNb52GYjKCiaKKasyLPv7ukXGmzZ5wpoSFeConxyP1lVgc6H8iTzcz
 07j/GBrn+julSCfyI0xkxxpxOVbBCJJeoOJndwehAlQ==
X-Gm-Gg: AZFdTZfLFN3RClBvnll3tLDzJrCuLV/kpAHmStLI2YPqc30uYJhE7Be9dXp4PzIYLIJ
 P1CqdaJDtJcj//4WAtu/nuyn7uoYeTVsWHkX1/z6lZzrL6Vuxv+tp33y8EUbL8nX+e6/ge+vhST
 zeLlPtB6D13QObMQvvF7TGw/3kNjulDoGV+CKfK9u/Ljp4YWUuBZlahru8xmqjUHwypDKY1RHlT
 4kuVDgxWPlP5RoAaIPd4QPxHtzzmKQtXL78RE2I+CqsRaUBbFv3oTi54cG8nugs+KUa6cPyACcZ
 XZKtBZUTxGE330DEnDVugvFmjYhoe4QluQBDZxp6RFvfE1WWiQlpR5EMDOd0QPmrIiuthwP7rWM
 6B34L0nax3NaIOdHqYYlmUv3LwWDzOLGPRvRVdlL12WdVuS9vsTHR6uwBA8c+cBCPFsx1297E7I
 3aAuKZrGcqf052+zGVdQTN
X-Received: by 2002:a05:690e:1487:b0:67c:50d:aaad with SMTP id
 956f58d0204a3-67df4487d6dmr9731544d50.65.1795786083130; Fri, 27 Nov 2026
 05:28:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106200309.122830-1-den@openvz.org>
 <20261106200309.122830-3-den@openvz.org>
In-Reply-To: <20261106200309.122830-3-den@openvz.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 13:27:51 +0000
X-Gm-Features: Aa3M54qHORIuEILBiSU_ZoFT8S8Fq98G-Vj6gyai3tDNEoVLUFxFIvG1z-WhBBA
Message-ID: <CAFEAcA8QmziJnGGaf42=ybZGSfDwAczbUMwimg4+oUQA0Q13dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/tap: fix busy loop in tap_send() after the tap
 device is deleted
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 20:03, Denis V. Lunev <den@openvz.org> wrote:
>
> From: Denis V. Lunev <den@openvz.org>
>
> When the tap device is deleted on the host while QEMU still holds its
> fd, poll() reports EPOLLERR on the fd every time and read() fails with
> EBADFD. tap_send() just breaks out of its loop with the handler still
> registered, the main loop wakes up again at once and QEMU spins at full
> CPU until the VM is destroyed. Every tap netdev is affected, single
> queue or multiqueue. With vhost-net the spin starts once vhost stops,
> e.g. on guest reboot, since vhost removes the handler while it runs.
>
> Stop read polling on EBADFD and report it. Other read errors are left
> alone: tun fails a read with EINVAL for a single packet it cannot
> convert, e.g. an unsupported GSO type, and the next read succeeds.
> EBADFD only exists on Linux and Solaris, hence the #ifdef. Anything
> that turns polling back on later, a vhost stop or the delivery of a
> queued packet, hits EBADFD once and stops it again.
>
> The test deletes a single queue tap through netlink under a running
> guest and checks that the CPU time of QEMU stays low afterwards.
> Deleting the device needs CAP_NET_ADMIN, so the test is skipped
> without it.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Jason Wang <jasowangio@gmail.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  net/tap.c                     |  8 ++++
>  tests/qtest/virtio-net-test.c | 70 +++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/net/tap.c b/net/tap.c
> index 9bce0d088f..8274aebda6 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -265,6 +265,14 @@ static void tap_send(void *opaque)
>          size_t min_pktsz = sizeof(min_pkt);
>
>          size = tap_read_packet(s->fd, s->buf, sizeof(s->buf));
> +#ifdef EBADFD
> +        if (size < 0 && errno == EBADFD) {
> +            error_report("tap: device is gone, stop polling: %s",
> +                         strerror(errno));
> +            tap_read_poll(s, false);
> +            break;
> +        }
> +#endif

Why is EBADFD special here ? Most errors on read are not going
to go away, so I think we should say "allow continuing to poll
for specific errors that we know will be transient" and stop for
any others.

>          if (size <= 0) {
>              break;
>          }

-- PMM

