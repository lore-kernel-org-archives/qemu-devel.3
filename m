Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD90606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dor/md5B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWB3N-0003k4-FK; Wed, 25 Nov 2026 06:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB3M-0003jq-Bh
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:20:44 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB3K-0002ub-ML
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:20:43 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6bb06dc1fffso2328355a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605641; x=1796210441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0TEzX8owPDEFylfafKACLODZUkHUsBKXKTlKA6Xs3c=;
 b=Dor/md5BbfcTkBmrOJndptXpW1aKV4HrBz8HrjWJ+7VxqcVGOy0IR34VY49CojDqZO
 o6Q6N1sEB3aeAmSQci7ttvZi29YegHQsZc1UA3Q+ltsbeAgkw8NQEn6s992t/pVRFISa
 +gf2MZAHfeBATbL/jjFj11JJkRL4pVytJypQZ+ckHCUJGvLk5Zhn5/LEIUKYuVXY2PHg
 3lTc3qsTHc3cKnpWR2svWp/4aOuLW+MqMB9mQo6zZ7OF4KvUOsjHj+yFbtbCPmIhu6iL
 qjLG0TtOD1tZ6aHmVTk6eiNbsnqdR3U+to0xCJ2GpCq2k1v+zkXWgR4TcJaZWCanUBWH
 XW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605641; x=1796210441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F0TEzX8owPDEFylfafKACLODZUkHUsBKXKTlKA6Xs3c=;
 b=FjAe75P+ybrwszQxqW/PlaD7s36t0IJ0TSdq6cokzW3ZBcJ1BXfjyyJdlSagb1N2ta
 iPLhMiHZCJ/FhYQFEb7QJ49QDWznAjBDAmBkUVg13GMGj103RHjqZfpMV/ri9K06MAbE
 JNIcZfAJnKALiW9tlRSgvyMHrocKGoB7ad0TZL6ugbQXEZ3Q4H1i7kLRvZLbrFAgNNO1
 rDpIuxwittp86v7tEloI9BbnIUZrBWbwBPQBEP52+4UuKgADxdMMi8+QoDf9fDH+9p2X
 SBCUHl1c45YHaK0l6T/xuv50jGLZ2qYezfcP6A8GEq2bBUgyS2iydb2dMnVsuqbkOjH4
 hNUw==
X-Forwarded-Encrypted: i=1;
 AL+hErGqQ3SFdE6Fjfnh5Ks6oiLyCYBk6emwOn14Or8rLc6Sea48dFwoEeF8dkDD4cUEeuH38z+RdkGVSMlC@nongnu.org
X-Gm-Message-State: APuU4Z8gjDIy885o+oQimM3AM4N8FScJWCzycSMc9/ywF2GvgTShzlkF
 OEqerpBNik0qd0KMTwSQ+CKdCxVM7vrsrKyMtxZr6zXPEKiSvWBFfwC8
X-Gm-Gg: AZFdTZfnVpFWMtS4pRMdgVqypkuliyehV+C1tdTs0YrhknDWkGInLSqZ3tAhWUfPm16
 dRjZwK1WittVoFk1cVwuU9do+ScRd60Yof7cBVKjg6lr6a386lDFUWIO8z4bvwXOtcKLZdgX0jb
 pjQDdWtmfQjf/2sh+zOpwl2rmx8iHqZyRoJeKzFIMZZRjfP+dQQvP87wZ/J1sZGk5aiP6Xo0kPe
 BWLD9elbaUGyOqkd11Cg9kSC2oVs2QvauOrWCMuwiz8oMtd+S6RVdZa/jPKTFQ7nZpfDKThws08
 MKURQoKsdFIFe0mdoZM/cfFSKpgn2BwwBgczNOKChLvVYiIszkiYNlnpN7k5Hs7A7/mhrgoukhp
 C85MN+BlKHGk0NB/fGmufCVcZp+amF+ClspZoE3xQKTNVbEufUCLGIsNzROkrHWNSWlxB94oZ6t
 gSLSkYl23iFEX87TCDTWZZXu7ydXL3KwYPzElQnD1J4RuJY6Q7wdy1fFzrMPH1ou49OzKPg1TQu
 VXtarWgoXLPD9l6dCsf6nlSy0rjHPMXvqVqcxvetrSPOfHyHt0jQlkukHeJKKzmH3s0Mp2kqOIq
 bLMl+u/lVa03L2TttxyE12ePEN2BT9VprdE=
X-Received: by 2002:a17:907:fd15:b0:c40:9e84:942a with SMTP id
 a640c23a62f3a-c513aade153mr1470090466b.48.1795605640666; 
 Wed, 25 Nov 2026 03:20:40 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc244asm618232266b.55.2026.11.25.03.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:20:40 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e8d79c86-324d-427d-90fa-5a662b4815a3@xen.org>
Date: Wed, 25 Nov 2026 11:20:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/21] hw/i386/kvm/xen: Don't leak gnttab handle on
 reset
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
 <20261124232247.23169-12-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x52c.google.com
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
> xen_xenstore_reset() and xen_primary_console_reset() open a new gnttab
> handle without closing the previous one, leaking it and its mappings on
> each guest soft reset. Close the old handle first; closing unmaps any
> remaining refs.
> 
> Fixes: d05864d23b1a ("hw/xen: Map guest XENSTORE_PFN grant in emulated Xenstore")
> Fixes: a72ccc7fc449 ("hw/xen: add support for Xen primary console in emulated mode")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_primary_console.c | 3 +++
>   hw/i386/kvm/xen_xenstore.c        | 3 +++
>   2 files changed, 6 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

