Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5336606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRvGigPi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBHn-0004qW-9u; Wed, 25 Nov 2026 06:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBHl-0004pk-HA
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:35:37 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBHj-0001yv-SA
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:35:37 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4d5b2db4bbso1084585966b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606534; x=1796211334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i17fHcvxw+7ZL4SDpaGzZuZ4XTXyMvScmMDjyMswMVw=;
 b=gRvGigPi9bvG6qWVxmvUcO4tfIsfe3v5A53Gk6MbW+t0a1qz8WCkc1D7uDSrzPkVbL
 NWSWZeb4xZ1jfpv+PelPO4ZGTB0R5GTnwBqMnMyDeStMGfupofyU3QwD7qr9Of6M2zrA
 mUbTTd5AICv1GPyzI2G6Sx29CCqEFWJAP+GeQUmkS9MpcXvPq6+CgPbTetBEW68SRT0S
 g20165yixM+SSuI1ZwXMAeEjk/tlk/FF5Nzxmq7mRlMT3m7UmJDAjMrRdVeVFq1JnmVh
 fBsm2Idgsad23j7NnOLkKXTKjkVvq32BMOW6gSdYxqwSlt1HJlL8xTC/9j/qERfG61W8
 I8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606534; x=1796211334;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i17fHcvxw+7ZL4SDpaGzZuZ4XTXyMvScmMDjyMswMVw=;
 b=LrSBe1DedxGR/pkCJwe6fgEtZz5GKMA9T6cUIXhe+HdE7Q9VAu9WdlP+JEQjtswm0c
 DHg/lp4NnSvFBI3LBp+abZC/plcOcK/XnyvENSoJ6d3bqaBF34hptvcQ4NEJv9YzO3i9
 7ZVqLFEcXOUePaQ5a9W0xrHw7olchl/7JKepcxk5Yvay8af3aSI3JQIcbsaKGdulBJiZ
 uDI8eF8xi3FaiNfFWjEAu5EbViN4NhzXj/JHRrBK1YrELhNubwUNT4excJVUAXWouAG9
 5KVk5fU3unRdqqHfqYd1zMLfLuDOre5SuZhZtr8iUT2fntmMQzcjvz1s/7vxZkGWQcBS
 nnvw==
X-Forwarded-Encrypted: i=1;
 AL+hErHa/J6w1ILdasiAP8C8FugDaeAV9DIrQ7Vf7jExCrawh64I+IoXnZ+xttiCdTSoX5zfTgMYP3K/D/1F@nongnu.org
X-Gm-Message-State: APuU4Z9j0iE0zz/+dr3vyeTJ7p9ZZ4X374gUCnw+YMSRBsaJdUQ2Swnz
 /1+MJu1OSC3xtjblto63yf0lHmvefo4lX/OWlRF43o9D7TKxJmnsVZLP
X-Gm-Gg: AZFdTZf/YL9Cn7Hp5jJj+vBR3CrcyerXSNgLtRT8E0TD3cq4J1Cq2hvBqvlzdX9zI9M
 oQEKnMTsNSCL7XDEF/gSvLRXG1j0Al+kvEkBnWPkebhp2C1RH75+X/5uxqxGuEJH+j0vZU7Vnb6
 knbqw+v17m+lX3+rb9X6E2CMW0gN1xs0XSfNftuDpJZGI7bZko97tBWXkenucIBL8ZkGIBcK+6/
 ymYXoKjpxDMqwG1KfUxSSDo77VAT2IjcYtD9ChEN7BkRAwDByh9X5gMeNz8lSxhLnLueVmzkEb/
 a1nIJHFcy4uJgtatN3kav/gefMbGhxN6yYNd/0X8RQiFibxSRY8g1dBLtCT+ikNUZeUhOI7loCa
 z9VTQervUPajfQKCAqbIop1VGI2oxbqxobbanw6Y8AILsiAAq1vx+9EZGl8bQqL8tommxvabeE4
 RPIDYUULDfU/Kt1lqbp4bc7Pl3Y00/qhHM8+1EUwSEf2/yEQ33kFDFp9VZKm70QohECCnwW7Dhs
 5UyiaSKwqtTNXY2+M5L+a2HlePzJQXYyp0BXQX759+bEHaW3DiP0ZaZ+wwbDphSsBzos4xarVEH
 Baqa11RvctTGFK9X1CQFx19LgA5eLTq9yzg=
X-Received: by 2002:a17:906:a158:b0:c3e:d0ca:d30a with SMTP id
 a640c23a62f3a-c513a5e6b79mr1111910166b.4.1795606534265; 
 Wed, 25 Nov 2026 03:35:34 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc42bbsm616068466b.61.2026.11.25.03.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:35:33 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e45e2c3b-7996-4f8f-8b80-2d852e032166@xen.org>
Date: Wed, 25 Nov 2026 11:35:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/21] hw/i386/kvm/xen_evtchn: Hold port_lock for whole
 of bind_pirq_op
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
 <20261124232247.23169-21-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-21-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x631.google.com
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The check for an existing binding read s->pirq[].port before taking
> port_lock, and the allocation wrote it after. The BQL serialises the
> writers in practice, but holding port_lock across the check and the
> allocation is clearly correct and lets Coverity see it too.
> 
> The region now under the lock is pure port_table/pirq bookkeeping.
> The MSI unmask and kvm_update_msi_routes_all() calls must remain
> outside port_lock: they can re-enter via the MSI translate function,
> which takes port_lock itself. The PIRQ→evtchn→GSI delivery paths have
> further BQL/port_lock ordering constraints — see the comments in
> xen_evtchn_set_callback_level() and xen_evtchn_set_gsi().
> 
> Resolves: Coverity CID 1527403
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

