Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B27606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FS7x94YS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBAV-0008RJ-37; Wed, 25 Nov 2026 06:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBAT-0008Qo-9i
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:28:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBAQ-00084w-18
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:28:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so72586245e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606080; x=1796210880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EN7GUMRzh20SUucnfQTtq8uiWe0qYvrM5Jkr0GomWl0=;
 b=FS7x94YSbl75W0E30MkMAIPMp9/GWF+iDmZ4/58DBeIe/dMTgwSzJJocmmvIlh8LIk
 NvPJHfeEX/cBI0koAkNYlkO9kGfI83kxwkznOW6cyKu7/rRy1IK1tg/9ayaWjzkiooaB
 7IvxWA1L8buP/bIIhqgrBF4y1WdMvitHN3+TY3UnkHfGA7JgHgWVWx8iHYLRcltNN3C5
 1LkONOZymp8ZPupCftNnEIIn9eDnTU2hkk9NOhfVnsG+uMI9vOwwVzDhkj9K8jFqGZsh
 dRD0GqfurtF2lkSQsMuw1wbFIWylYvvQdur/SdRKz/9lxA30yBk9n7RxDciTi5d7ipeE
 Sg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606080; x=1796210880;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EN7GUMRzh20SUucnfQTtq8uiWe0qYvrM5Jkr0GomWl0=;
 b=Hl5vgc/N23QbPMmUWkhK+MRNC0ReiMgPSRkj3dd33ShFPigvQCfzDxhogp8AdYebyZ
 OAEZ5dNnWY3fnDc30U3hm8J8ZGAu2gRGGdJbGl7YsGR5iXlx+4Yn+ouHTSZIoWBF1DEy
 R8XvfjjKaaYYcBXAUTD+OVFGMnsZiIKqC+zaI3nBh/liiHmH9JE9THr8ZT9vwSO1N7YR
 vdj+fUa0ocn3zvQlZrg0YE6oJhTH9AXM8udY0ZjNjfuuwa+0smcOjSj5WOLFgj3+mvG5
 4lYYMhdUqhxqh9cRquC3u9RBj5aSkQpURXxc4AbQ1jOsN5ddhH3axmISiaRxFGD4fufw
 ZsYw==
X-Forwarded-Encrypted: i=1;
 AL+hErETr+7MHF+bplnx1L6DHSEGSa9//6ACJVFSdfFWdbV6XpJ7t4sQ2djitN9sZX3YaCUmL0XGmtW2X572@nongnu.org
X-Gm-Message-State: APuU4Z9CkbjUHucmEC0UKc3qwAfYKdCM2H3SClSc882vYT3Djq/HMuGv
 cYGA7i4dFiykrxFFqqGoHfUqlIBwlo4yIQc1D2jkaKVMaP4Uh8zLyGU0
X-Gm-Gg: AZFdTZfO1SRv67TWr3m4jU+5hymNXvT6QFBIUHiUs0yKCe3iOzRux31LVLKfMgYXv/7
 mh0JyPFZzfwxDzdUELKP3EY8YqeDzDveqYAKQ7fI0NNySZrLR/VoJaWYehRjE8biz6jSaUC/OcY
 Fw/iH5NNCJukG57RsMMUZsLsFYUp4gcCyIZ5cCMZD5Bp1kcXjx5Dzk5OUiDseYJR+uvN6PkZ0oy
 gMQG8QwH7Wps4xQq0mubTPcr1LImlmOlB+lw4auQpIKA6kbRDl5au91NEyDzURQHu9UkbVvMrqE
 Rg0BEHPga6vhfVZ9HmFPwAy54ubew6CfeKoh9HTrwpEFet1mlOzpEldik1DakJcwqvPLRjhM4f6
 3WvW7LOZS2oHa4UeB4C9OKKpTS+JSXygMHFSGpdcfvrfKXWcjaiHVCemLQnaVIR8aGAX9FoxtAh
 czesw5suhJe+J2cxC1zTjP8DyP1B/RG6TQbE6Tq0pKIt6C2j6+ee+9rDI/uzo3WFx+GUNKvhWi+
 upT+1u1uw23FehPjKtYYTsqYe+1AhGSrO6YgE/tj4xDl1dd+WlXW8m8OqwpJofA5UNL7suz3Qhg
 9GO6vgOZcGIeFhMh+Ri7I13r/qOHZc+PQERT6VBV19k4Z9IRiNARmAU=
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr340385915e9.12.1795606080223; 
 Wed, 25 Nov 2026 03:28:00 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm460692465e9.9.2026.11.25.03.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:27:59 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d0e3be64-58d8-4d4e-b90b-f37ca4dc5e3d@xen.org>
Date: Wed, 25 Nov 2026 11:27:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/21] hw/9pfs/xen-9p-backend: Validate the request
 header size field
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
 <20261124232247.23169-16-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
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
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A request whose header declares a size smaller than the header itself
> was accepted, submitting a zero-length PDU and advancing nothing, to be
> re-processed on every ring kick. Reject it instead. Set inprogress only
> once a request is accepted, so returning early on a half-arrived or
> malformed request no longer wedges the ring until disconnect.
> 
> Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
Reviewed-by: Paul Durrant <paul@xen.org>

