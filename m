Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209C606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZ4zCUTO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWB1N-0003F1-S2; Wed, 25 Nov 2026 06:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB1M-0003Es-DA
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:18:40 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB1K-0001Ig-Oc
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:18:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-491971ac844so5079646f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605517; x=1796210317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BqDRusDdiLvl1Sf7gFE/D5Bw9nPWlQ6rHY0va4kEHso=;
 b=WZ4zCUTO+dSsYy4Fb2usml0ZBzAGGhzweHc/dcJHtkyl60dwtjdRpBQunYlhxBntnf
 R4YqAH8X+MpnuQifvSqT3tS88Dli7METN0GYYaYKko9q8RVKEsuYsS357tv6rlZJZIZ5
 lde6YCZQx/S9l+KVO1GPbSYGFVSM/70g+iuh6YE8/WdvSRpPS875gkVud0Fzw4Jz2MM4
 tiUx1QTub+jJlRhp8mGJj/j9gmaTyikFE8n38Sy1m1XdWR1WcQhwzKgaVx12ju5RQvlV
 9c20JN9NFVYAoCODasEva2spV/6tjmYR8A/oQYgHAg/RGd34jrHeSLNayxsZ9EnyZcR7
 +xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605517; x=1796210317;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BqDRusDdiLvl1Sf7gFE/D5Bw9nPWlQ6rHY0va4kEHso=;
 b=Y2eR30tn+EqsEaVfECfsSPAuF0Rlt/7FgMqip43w1WdOXbBm109RAvbW7mAzlxi3o1
 /MrnCEvPFEz44XGzqW0232tNcs6pcJb+VCFP4+5zF9tTL15OipmEZGLEnvoYW0c/VMEf
 VbuLo6oH7K9gpFnrmtZx7pAjaSZRnwwsOG1GLDBh2865AUf3v4DnEh5KqAfc9ltBTNu/
 QwNOU3R3spe4p/rK2qzyv9EtRpLu2ilPgPqts1uZlWWpCIt7yK74f6TAgmnhRL1c6ItN
 4F6oGzcwjkBQLCctdjODsalXwRQ04Ay1tWpL3YT2HvvXLi/4E8wSBwRPGR0+rt2/Aa0c
 3rWg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWYqgnOpfr7ScDPckoy8KBfgBXEsqnZnWGgjWtvXLwNC3q5n1QloFSA5OpiAeIwy+7OF6AePZoO75H@nongnu.org
X-Gm-Message-State: APuU4Z9mbQavEaXvyWTQSB/0E+RENN1OaSUjZvt5UJ/nagSslrdiRZ2M
 nBu3xWd2dYOpCuboRie32c5TDjUamawmIsOMoyG0LV2lc8kepOWieTXQ
X-Gm-Gg: AZFdTZelAKwLV3pPcVIsCj7hOnLHcMEhkUdeYi7tZ6ey1lFNNFmhIPVHkW7pAXcioMo
 9awhPD+r2akYjVd6l8dbG8bzIBuF6dmKybhDK9YVE3ujlLc1Y2kTSIirzPwiOuewgx/WWK4xh33
 nMqQwemi9sRQlo+oqnz6QBP6UgIMfhVLDR8pFQhFVhEoQ/MKzeTeK5qzXcaiJ6Yugo7+ZcDl4oQ
 FvJWruZo8H0JEU15fK2LOW7+/PWgf/NLy6+ULU1+HKjaUlPfXThHwc+zKJv4GjRp4fvS3D/M3bs
 k42wvFkL1MnbN5vDaJc2NLWgd6sVLgSEY0YM7LLV2mvqM8iLHHrCRR7Q7ONK22SgB6fWtQeIWZ4
 fq1ppo9S7JbothDvVV/VXA2gm6g/upjUN4MIir6OFQ+M+U25AYweQ1JGk8AydZpooTJ7DeTVbkE
 Vnm1/e0hxGEouOGfM643AptSONqWFtbuNv4evRFEnZcEubIy1HS7082lrxVToSGekIteHXli9wO
 KsmIAHlvEYwLwWb4I7y86L4iin7lXFbfL4e/Tp/D02BwM7pib+GR5Nv8yH9cpLaljPsIj2lPbtp
 P3lVObw8jazC+8TbQF/KNlBGU5DBtTntHw==
X-Received: by 2002:a05:6000:29d6:b0:490:6fbc:9457 with SMTP id
 ffacd0b85a97d-4abb39566e7mr23143727f8f.41.1795605517091; 
 Wed, 25 Nov 2026 03:18:37 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb4341sm33914818f8f.4.2026.11.25.03.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:18:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c4e8c8e0-91a5-4009-b413-de19cf64e661@xen.org>
Date: Wed, 25 Nov 2026 11:18:35 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/21] hw/i386/kvm/xen_evtchn: Reuse existing backend
 port in find_be_port()
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
 <20261124232247.23169-11-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x435.google.com
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
> After a guest soft reset, close_port() clears only the guest side of an
> interdomain port; the backend handle still owns its be_handles[] slot.
> Binding again then allocated a fresh slot each time, leaking the old
> one — and leaving a dangling entry if the handle is later closed. Reuse
> the slot the handle already owns.
> 
> Fixes: 794fba23a53a ("hw/xen: Add backend implementation of interdomain event channel support")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
More soft reset joy...

Reviewed-by: Paul Durrant <paul@xen.org>

