Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F02606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ou2QYUi8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoM1-0003RF-8U; Tue, 24 Nov 2026 06:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVoLz-0003R3-Rk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:06:27 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVoLy-0003sb-9p
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:06:27 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67dae7d3f7dso5104412d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795518385; cv=none;
 d=google.com; s=arc-20260327;
 b=gCQDOt8zyY539ZD8SFnQQd+amKjpnQYfkDnc+pAK5l/ZM65Np9H05F8bwdcDCAeBpG
 y1tiPkYrGjE68FaWyQUrLwFEWnfR+rAWC5WZBwbEGUMN0GMk9gRcApOSzmIB7lWNTrUy
 DH/Npv+ZGH8Dnko261V0Ewmw4Szq6BtMQRhaNXJWivse9IKU3r9Z8xXe5oIUuaQ/p/+9
 8gEMh9EXsddG6OwG1XLoYtSzxIi8ifYFQb8AiWPRxGdohMMDfzzRaFbexwACQhpJ/0bO
 EqmzffUSPm2tA5e2AFYqjG/fFFtpozOjSJx/YKuy0LAznfGH0VE+0xyfBbaBCyDUM+tp
 654Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cBgeVjoqvdnSXa7fAAFeSaYbndoV9wYpbRfnRHvXy2M=;
 fh=7BEaqYZ8iuPFZ5YyJ096lw/mvD+raxD+LHDACGXjJYw=;
 b=MitK8FRPq4C52WFx2Suu62fmPzWdA1O1ASIC3BBXMPO60daWy6LZ0H9X7R8sIiXb/l
 mHfSseqD3hsBNhayiupZMsNYsQBNM6lAvyCT0JX3e51XTOTBnRWDuCF1Dbi+Wzql688m
 FuIm2Vwxv6wUAaGFGWhwXqI1ERmt6IBU43/PL3Thc9Jwtxlulb2H9szNMkwwWNxcJBUZ
 zmUZLi0hmCv3N3lbbYy33cvYq0LHbzXQfELWrxq/yMpOS/5rmQdtIl8Lvc78nXB706DT
 kYCH+qoJimXJgpDVejK/KxDnCUt/ygi4OKVHFXhZGXJYfOD86BHYCXk6jKt6LEkQ/WUY
 droQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795518385; x=1796123185; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cBgeVjoqvdnSXa7fAAFeSaYbndoV9wYpbRfnRHvXy2M=;
 b=ou2QYUi8uEyGz+VsQ5LtOUYmPNnMAIHkpRVrZtiR2xxSFaG9cZQV8s8aTbhn3IAYQh
 cb7Gw1AUqFJiC+cIZ14RYtcMBIA/rDYWEfRQElnbcutIKx50OiwKNZr7TXyfNojXp1BL
 T5KD7+d+xTbh8faD7Nakzj3ZIXdD0LP92S8dQm1VfHLmE2fW7tsMSyyP4ElMzRbPNuEd
 IdM9VTNssyPrqQnY3aP2P7Ah9AkTRdA3Ukn1rDdpeeGHxRMQMxRBE4VjUanSYXrDnX5X
 4rz5WyilNFFw4J23nVXoQ8D9WxoPlg+SXoS1D9bOsQkd0bfyz24Y5+g8V1m9jXZbNb0u
 00eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795518385; x=1796123185;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cBgeVjoqvdnSXa7fAAFeSaYbndoV9wYpbRfnRHvXy2M=;
 b=ADtieU5Ifd/fWJv/bEPvKQQELyPjw5CrEpfPjhHBrjPdviQIeBeDAppwszohgzYl2o
 sSZnOL5v+Awo0u27GcJRNwkKgOmO6UItJOHYY2ewywsMRkiPXhhwIVXroio/mtSewJSK
 HcI0oxKDn13Si5XLqcssr2cYeeXjVARlw4rwksIxaTxu9YMDCBmyN0B+F89rfqFDZ4yB
 Hkz98+U7zm/hCjuvzKAJ2HhzXTQMsX88v+bci0QcYJ7wPubdyKwMt/SnQylNmaiS1hr6
 y1W7BW/hRJduzRL+bIqatQNw2XH1y8fBQc8awDpL3K/+HMkfsCMH6EvFgAYfb17lPqXA
 +6rQ==
X-Gm-Message-State: APuU4Z81tBQeqm9eQcqg8/GNU4quz1RlfQa4m2wDIi2THDKzoycsAzhn
 z32fP/6fJXU2Wknil2lDJ5/qnETtooDUfdQ8dDfM3J3S2F39ag/oqHk9pY07LkgfVhrqoOr69e5
 z3KWEQPf0P5WnH2GVPqFlWWHJpPW7lUlk3apfgNq58w==
X-Gm-Gg: AZFdTZfbY1jiQgDVjiCiXaLzU6+WCZyOIpLUcjlx5JzSV/otmAzr4sO9/W4YcLXS8WI
 1CCp0VcI+5FOKX1EWYjpnLSSv4Z7X7c/LIToGI1lRSoYphzku/+KLTh8H4PyV9iBZYcoo5UfT90
 I37UUjaOtDWXZvNOBMVSGrG8d3XkRFdXGh89Q7MJvlFhxiHnUyxL7ygKIVGiUhHsPW0kMTyUuam
 QmcMi44gr2vrNTgJyjZmkv58GihvWSM3hNWWVWIiR+OxYht9E1xctkPA6K9UJ708GkLL5ALgdew
 h9j50eizk7xMfWrEQU/DCHwdnZjvwSuT+ww9XHAB2ek7v1VY5k44QpvXP3x1/BWLdkzlAHTItL3
 fWNJE5i76XsSea0S6VK6R3c8oypvxsD+behr9tsmkxMuIEEND6xi3eVZ9t+j3p8evz3iMQ7RKNc
 JJ66K9UxsM+oqe8TRT0MfA
X-Received: by 2002:a05:690e:440d:b0:67d:b94b:6021 with SMTP id
 956f58d0204a3-67df44beeb3mr2313600d50.143.1795518384930; Tue, 24 Nov 2026
 03:06:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
In-Reply-To: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:06:12 +0000
X-Gm-Features: Aa3M54oHftfUJZOuQ61ToPKXQZAp66NiJuX71i-csMhJVvHZuRO8HIMezMKGxIU
Message-ID: <CAFEAcA9bTiprK0J13YiXgA81Tpe16NuYU5ShFWGghc4bmd-Y_Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net: always validate the interrupt index of the first
 RX descriptor
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 03:34, Andrew Nguyen <xmphyr@gmail.com> wrote:
>
> Made it so that vmxnet3_validate_interrupts will always validate
> s->rxq_descr[0].intr_idx.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
> ---
> This is a resolution for issue #4729: https://gitlab.com/qemu-project/qemu/-/work_items/4729.
> From the report, I got the impression that rxq_descr[0] will always "exist" even if the value
> of rxq_num is 0. This is because RXQ_IDX is 0. Therefore, my solution is to always validate
> rxq_descr[0].intr_idx.

I think the problem here is that we shouldn't be allowing
rxq_num or txq_num to be 0 in the first place. I don't think
it makes any sense for the guest to configure the device with
zero tx queues or zero rx queues. So we should fix this by
having vmxnet3_validate_queues() insist that txq_num and rxq_num
are at least 1, in the same way they already check that they're
not larger than the maximum valid value.

I'm not super familiar with this device, and unfortunately there's
no public spec for it, but Linux at least doesn't try to program
zero queues. Also our code in vmxnet3_activate_device() has a
simple loop from 0 to rxq_num where it's setting up the RX
queue data structures and doesn't special case "0 always exists".
So I'm fairly sure that 0 isn't supposed to be special.

thanks
-- PMM

