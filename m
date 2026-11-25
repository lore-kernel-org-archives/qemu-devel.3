Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F87606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8VPd7W/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWD65-0002XD-DB; Wed, 25 Nov 2026 08:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWD5n-0002V2-C7
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:31:23 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWD5l-0007OH-Om
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:31:23 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c516a1623d0so572439666b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795613480; x=1796218280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1getO31TbpMrHD3IyKxKUohDsUND4FeywjJ/UyT4N5c=;
 b=G8VPd7W/c4hUGym0MQ72Z9j9sAumOTaUcYddcqUlRXjeY4SsjJJsDiCyWxIuDczXyh
 zURihiNNSDXBgn3NuJ09T4ZK2/BBczydKvNYyoptMLvb2K1V29q9CPi053g21N1yodKK
 koRTdGMBNFs7Zk7gNo4wr3QISOPkFIve7U8WaAKw839jDuogXoZKWx/wbKLa5N25X8RF
 DoLgD29Lxor1646oMvpzVxaWfm5Cq5AKLxE5tFZL8Bt0tEW9NKW2f5x5o7r6NimB87Hj
 9n44pJcCxj1UfK5uW1cLgCzX7q5OZ6o+yG5uHsJRAp/xMp4V+hcVtaUW0KdWRLxAD3Nz
 L4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613480; x=1796218280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1getO31TbpMrHD3IyKxKUohDsUND4FeywjJ/UyT4N5c=;
 b=y61XxzgYUo6oNPrTwQus7yf210kZu7424+HOqhHnPUfOBO10NCuNVnaSpJslWz1qdI
 L9jo2bnJIsCqXdAVVobpqumgd87K/vtZzh7MrNfp8YbH1rws96+Dh7RCRQ/s5+nOVjqT
 i/rjfMsEP1on06KTWdJoDXvA680BjZQ2I6uIR5kqzuP78De0XdRDLYOF/3FYG9uX72LC
 udvmMaHYS43x5vs//g6VXd4gkkmPiol5HN9DTf9/DIOpv9iC5oKi28ZFlOBT/SyvBqsf
 1UZtzzCkUMOb2KC0aDOA7TBQ9rjq9eQHR8BjcjQVJAS8cW4zyl0y7glPdyRLNmrVUKGz
 TJzg==
X-Forwarded-Encrypted: i=1;
 AL+hErHWu7/+iQfiroxJlvlgp9Vj/AtO/KBOeipFZFIe/s8ZPvjVIPXLRPO1AnhkHCPmb9t/XRcp9MtEEJlD@nongnu.org
X-Gm-Message-State: APuU4Z/LlZHVug9ziSzsz1QQuVsbjUKuPqHNmKLwUJplrXBhBiaOfQab
 udcJy+irqF/kJCHRA+VkJI1aVbhwj0tEcrqkUi3kK3/vjMjvQ7S0JYOE
X-Gm-Gg: AZFdTZe/TfhxPPJw/Y4qKPkSTS94y1tFsVfEajSjI2UTb6e9MPgOV14dm2CWLveDMXY
 66iQ0y/wELrgXzah1fC8fTJ8rwO75dQJlTikTDEqx5fyXKFSuKyApMbIdt77uRRJTCIhrZE70MY
 p3s5IoFLcwlsqym231xXfWukmMTGifY5JYWjjjWQ4MY7jkc63CSnLbVbfC91rHcA7gk2Nz1h7Om
 PhyXFez0qRIjO93tmdrn7KYMBrnQ0R8BPlQgXzY5eDLPeoTdhaK7Dq0AGsQr1bgaDZyihbMT5RU
 8KFILyzC3BIKxN0OKViDRDGHBtDzZG7+kn1WgCRtG+k1/viJ/RZGJlxZunMzQXE501Re/07Pc4o
 lxGnzgcRZyJwEMbiTDy1P/Sc2FF/HbpCS3puiujzuNdRxEVCNytSKUYfsjqd/XDjoVT53IjdRiw
 o8Y6BwRRgNJ7/unLsJWm4nbUHMX0KcO+x4gZ0KQvRtIxPKPEM5eSIWrlRdZCfjnWku81zHGO9Lt
 0RO/1MZqZSXmF9KGU0VVONZE0ePFzBL+jY6el3Og+BmmfscVSCqUSIKuBSXGc1NK5Pvo0wcf74Q
 4VxePZDO5YlYBzZmPsdQWa6y8z9lvivt2Hc=
X-Received: by 2002:a17:907:4d0:b0:c51:f6:216a with SMTP id
 a640c23a62f3a-c513aaa8eebmr1221466566b.37.1795613479877; 
 Wed, 25 Nov 2026 05:31:19 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm639987366b.21.2026.11.25.05.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 05:31:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <7bdf9aad-dea6-4073-97eb-1c5d2535c9ae@xen.org>
Date: Wed, 25 Nov 2026 13:31:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/21] hw/i386/kvm/xen_evtchn: Fix off-by-one in
 do_remove_pci_vector()
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant
 <xadimgnik@gmail.com>, qemu-devel@nongnu.org
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
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-9-dwmw2@infradead.org>
 <8e8fa5ae-f30a-4e38-8aa8-cd46e3b4ca31@xen.org>
 <51d6301de00d83468af889fd4eda0e9cadf23ec4.camel@infradead.org>
Content-Language: en-US
In-Reply-To: <51d6301de00d83468af889fd4eda0e9cadf23ec4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x630.google.com
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 05:03, David Woodhouse wrote:
> On Wed, 2026-11-25 at 11:16 +0000, Paul Durrant wrote:
>>
>> I guess I'm missing a subtlety here, but the test only fires if pirq is
>> a multiple of 64... so why is advancing to the next word by adding 64
>> not correct?
> 
> You're missing the same subtlety that I missed when I wrote it in the
> first place: the loop *itself* does pirq++ every time, so when we do
> 'pirq += 64; continue;' we end up adding *65*.
> 
>      for (pirq = 0; pirq < s->nr_pirqs; pirq++) {
>          /*
>           * We could be cleverer here, but it isn't really a fast path, and
>           * this trivial optimisation is enough to let us skip the big gap
>           * in the middle a bit quicker (in terms of both loop iterations,
>           * and cache lines).
>           */
>          if (!(pirq & 63) && !(pirq_inuse_word(s, pirq))) {
>              pirq += 63;
>              continue;
>          }

Gah! Recoding as a while loop where the increment is either 1 or 64 
would make this much less fragile.

