Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD57606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGMDZM+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBGT-0003gF-Ko; Wed, 25 Nov 2026 06:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBGP-0003ff-Ls
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:34:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBGN-0000yg-TF
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:34:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso58655385e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606450; x=1796211250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yl/4IscYRRIYoDrOcOqnAZtQEjR1B47TFUIpt05puco=;
 b=GGMDZM+lFcbIQx+aMcHQRcw0TCmBI3w4bFTHznIkEc65DbS99or44tX/1BzNl1D96A
 ufOtKnMuVtJddCg73CANfxD7txtBGX7Qf64b5hW+1aRzgHZ77mNu40evcp1q78RpeGoB
 P5IitLCx+FKrRZrnzuinQ8le8nDuJGLSM8goGeU4EggAPRl1BOOcSP0F7jZr12Vq9yad
 v3IGPfAwnmglJkIWGwwMca2OVeDSZ3EbIi+AhRGfaCKqBOHvOi2o2UOzeKCGKKmLhxoo
 5AStGsgEfnhYE5NbuxZO6FaHQzhhpHu0WZ7zvcCIJBOq7oEbctyN99QsdqnoTq7+NQDn
 GCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606450; x=1796211250;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yl/4IscYRRIYoDrOcOqnAZtQEjR1B47TFUIpt05puco=;
 b=WnGegcpd3pJmUP6r6UbDw+P3bm6/eVfcoOVMn5plEAYTdX/CRBl0i/1tr3L31f+5qt
 8qmSqg7G85et5y6CxRqPL5StnwlEAGYaFpj137++MaD4V5ZmAGE7DCe6r8M7mZQczUHW
 HXFRq/7LzuG7ErdyVSPQzMXVAj+Ptt2Tl7oJ/9bqGwHw+jW73cMhP7pvi969hxxm5tqg
 rM295fFjqXVqs8zxEuUv8FTl35UCOogzarqZYxXkkX8lP2GYjIxM2vhZxXR4hjcCimeM
 H31xv65AfAaE7ZS62I1XRZ7wioZoo1oDO8n+2E361HFBn2TDsshmzrAn3KKjLJ3HvVfh
 DipQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGB04mBqyA+Up7TXglIw9IeBHhze7zA78AQcbTBCzgJ3CiZe+q0xXdP7FTj0eB9sd0xDcAqnAC+UI/t@nongnu.org
X-Gm-Message-State: APuU4Z/XLZNjBUFJ7V1Q0NbOLTUrUVlusw4ZRuX2BHmhb70FT5+hPJPE
 HtMFQMIZmk/yMCQJohBQxoeCnxxvMWz5sClJozm8PJ4ZOWz6m7s2S8Vw
X-Gm-Gg: AZFdTZeP+33ROCoXIcjZ1WWbQ1/Kp+Z2zOih0Y97IijybhlJh9/pyoY1RKbzII6Lts+
 QMGPRhvdYuKXRkG2DsJjJIvR2x6Bsa2iruXL/T4nEgNMtur/udsi9QbfioldMtkOPAUetNo9TAF
 bgxp6Ojlq/OVBSedvpKTnALgTXe6nLFZXcD1WohuuS/zxEvBwc/cuubPRyjr/qEumI1nSeLyoS9
 7SLy8nJyy66JsvnboRwx/rHtSR89MgpEvibU3CopOjBmuf5L9rPWLfBHNdWlvRqySwfimfXLq0T
 UuLgRtyWx53Q1JrUE8WsT/lELUxhBY8T2gzlvsGRWTNonaJzWIE3RgJeZ449wEMQmC31Y5cA5Yj
 dcyJoFgXFYWwa2Ljigi3Yz9ksSeru0+ee2cavIfhEhIejeGF6+K/Y/0Qrtk7z6B7gIUYJO9jQQS
 a0yfJ+a6Ghg7Wa5ZRlxvtBp1+ydJBQIw0/kSa0sKx9A2r0HkFSTmuo/qFr9jiTWyBGVSDCFTx7m
 asPTQOOw75fNJLJXC3eF/he1Tg9yl0RVDYEPZQCbw1MbYeV84d1ZB/1/GmuG45rlfE8xblN6ByJ
 V+063PFcc05C9S2EX72Fg0blYY8RvnxUsmU=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb887c3428mr360008895e9.1.1795606449726; 
 Wed, 25 Nov 2026 03:34:09 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm542185355e9.8.2026.11.25.03.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:34:09 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2787d40-0b72-4f37-b132-dfdf49d2ef04@xen.org>
Date: Wed, 25 Nov 2026 11:34:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/21] hw/xen: Bound the rep count of PIO and MMIO
 ioreqs
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-20-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-20-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> cpu_ioreq_pio() and cpu_ioreq_move() iterated req->count times with no
> upper bound, so a count of UINT32_MAX kept the vCPU handler thread
> spinning through four billion iterations. Xen's instruction emulator
> clips a rep batch to at most 4096 repetitions (hvmemul_virtual_to_linear()
> and hvmemul_linear_to_phys() both apply that bound before an ioreq is
> sent), so reject larger counts as malformed, and reject a zero size, as
> the other framing checks here already do.
> 
> Fixes: 9ce94e7c8a99 ("xen: Initialize event channels and io rings")
> Reported-by: Feifan Qian <bea1e@proton.me>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3756
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-hvm-common.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

