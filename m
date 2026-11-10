Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A764606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PVho1Y/M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQo90-0003Vv-Tq; Tue, 10 Nov 2026 10:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo8w-0003Rk-Vo
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:52:19 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo8v-0007Je-AZ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:52:18 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b30477a320so16783417b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325936; cv=none;
 d=google.com; s=arc-20260327;
 b=MLWjsmoNQ4RdSX+vC8t7aAOieCNsfWZ2RjRoxAPVz2JlW3N2dP+DTs7L6iUCbLhAAZ
 X/AFamNi12tm14+E3DHHyufV3qjGZ7NjO4XDlc3OkmClakt/PVwqgyczPalHjzfq1LD8
 BAHJPgo/U21Z8H0arS6Tfuhyg1URFTCCjSniEbAhAhKmShphQD3CtZXg4LEsTpTWSrT0
 kCHt6MjcI3vuwmNXu3FwbgiNdcZjLLyVv+5CB7CVsq5jNTUnbT7dscLNJ7EIXdcX5RcG
 HX1Ye6p1g/AXINBF7SFq927ifVMsCdZZgvwfHiU3fKYTRmDjcHkp+x4+Jd3nWcdZt5lj
 7BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=khyYSLKp+FxDlSwdiNUD+/3iy7rno2m8BCebe2Xy0wo=;
 fh=SUjHPGGYmDAnB9LsuGgE4tGQaLdLLaUv/MU9OLOvf8k=;
 b=Swou6IwRBhSM15wR1kAY6RLNGCD67uNWOnweAG6zACtHHyZYF6blMueW7KrvYrM01i
 Sg1tmousIzoWkquRytvyjXbCLE3+704Rc0ebW1B3xVY4cQgwlPdFH7TvxNYMmbhFQbeh
 6aFF81GC49u1OdjGXQ0ECrV7WS9nF0esaHq0kpdiK+Mqmw/rB6Oo0VsrtR0TKGW7aT4n
 UpsG244iXjzgzTX5/oVeK593a7TnMPqRh0l9s8qct8++VyP7yTj07p9fEXVL4vXRMR2d
 8fhrTxlCDX8lD8nMwQ7dEY1U2V1hJmnlQXAqLpESaDws3mpfRHoRXpfLiJmMwDIybiHF
 8l4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794325936; x=1794930736; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=khyYSLKp+FxDlSwdiNUD+/3iy7rno2m8BCebe2Xy0wo=;
 b=PVho1Y/MNVRPnE7YXwyp9QAfSfauNYSaa92sgcRu8Uox/Kgx00PPtnhWOBvEB5YMw4
 UV/w3+J47fcwsqpDyDoL/835O77LBxC+t1c8BT0xeYdDHZVBLZwTcXl3oVhi8V4LeVIU
 4r2UPksNT/XknUDjYyKb6OPhlftJJg10FQpRL4bW6eJfxTD5n2K143WdZc18H1Cinx9X
 e3BzMPKdx/78i2mK6T2KhyA0uUu80YsgDIri/LzY8oSAL8w3Mt3rusSpe36Cwr0zRT80
 TPB5RIaZUPPktV0UcG0PHmoGaerhENyFQeZHOx7LSBpD0i5qvnolft7GMKKgbEBxqmGU
 N34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325936; x=1794930736;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=khyYSLKp+FxDlSwdiNUD+/3iy7rno2m8BCebe2Xy0wo=;
 b=jTeb0jKVmqbQxGfOB1VfMitpDOn1dnsZbWsPJtTV+dBFYxeIlUs8Ptiym9DVORlktR
 3DiRfbRuKno/wKEpSXND0LNWeqkyrKrvDOpze+wTTuupFtIZw/MwLr1uLQyHC4mPncMw
 IFZmjWmHgQJ0/yLJc7n0khEz9mbFO2HNXvT8e2cIW7ZdIFU+pv0qx1U4CpYJ2K0RpcGk
 xQuj9s1I8a5MkEsy+ZFocGxaSl1EtoYW8ACIpzMd5h3Sji/pJzRC89Ox/NRPy1Cysx+y
 +oo8f92eAh+7tVz92ognpqlhmianRwHnq9nc7/P18QPfQR5A3nLBnfj3zPaD1YSvlOjh
 k/gg==
X-Gm-Message-State: APuU4Z+3TvN7CcXD1UZpsGEkmcmQgNWxQ9h/SH0WSV+385WpWN6Kk8QS
 EDz4YUx3X0T0MpQXyNES9XxjrsXG3PeZb1efvrdfpIphnv/ri1c4X5gXhun+1np7LMwFcZ/0wrR
 k8p7vGG6Njxg2R4AHKNUq1QeoFIfWVbfYQYWym4Vn3A==
X-Gm-Gg: AYBFou2fKD6VXQ71LGSfbp9a7hQhoVxzM+VhH4Sne9ZkUzBki4pVSurXi2dl2xmXsEb
 pWtSjRPcwof8O6dn7jW9WamPK3prE/s5rzSj7YMWmnUYhJo90Qw+sbWxaBm3Vg04pbcE/Ze6E+u
 UMcHgmk7CYmltyGiLMhL4ii7vqo3UqqrLLnOVUgUHajk/KtLJ1C8UkECg7QF3bJDb7qw/G8T5qT
 8QtEapwjeLXiMptcR4j6VEzvGL7jX1dYqIa99BdW4dyteuHv7r5HNi8+DpkD/Y/Nmko+u+oaZ+S
 cAkb/Bx+WNVKzetY6DDhUhJTJ+lWTLtmRrrA1If2wKKlGUrV88nFW63xWHxZJrZJKRIK5JkRv1x
 5gnxODHyIvuEu+aYl64NurHW8r16mOdAjha1g6sizvkm9DWzu4f/tYLd3bWobDRVHcBbLJfk11F
 DSY929k8/jEtPAym/uzauEZ+StWK1wGFzVV3SCaKjmh4Y=
X-Received: by 2002:a05:690e:144c:b0:677:b426:5072 with SMTP id
 956f58d0204a3-67c56736634mr1428218d50.47.1794325934358; Tue, 10 Nov 2026
 07:52:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <20261109-eth-v2-4-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-4-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:52:02 +0000
X-Gm-Features: AclHuK9vZNjivjPdFOl6W4QSu4qolcv9F3esHXyuP4C-KUV8S6CE40cWTl53kpA
Message-ID: <CAFEAcA9z_t+8Hufz_iHr3yOp=pc06FcfGPjLLbfSh4Xw-1saFg@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] net/eth.c: In eth_get_protocols(), don't report
 TCP data offset off end of packet
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> eth_get_protocols() already rejects some out-of-bounds offsets found in
> packets. Add a missing check for TCP data offset.
>
> Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  net/eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

