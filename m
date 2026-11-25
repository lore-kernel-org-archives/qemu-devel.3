Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66F606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0BeUBq/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAk7-0002DD-4Q; Wed, 25 Nov 2026 06:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAk5-0002Br-3m
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:00:49 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAk3-0003f0-7b
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:00:48 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c506a231b88so764112166b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604445; x=1796209245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WH6OCX8O2rHrDc+AjcgOmeRyCyW9QUyc1yx5oWf9qtI=;
 b=Q0BeUBq//mpkZZFvAmQaR045fDdn3BltwkGrnMOUNbPMxFAeFwKGwdmau86USoWUYg
 m3p3ZakNXCdebf56Eh7UvFiM4312DTInt2j7ACRcofKpin61V8sBM73TJmxGz7uM0kRj
 GTVkgxjQ29daepvbC/CLH1nnq+PypuXYSIy+7Yzh5dkpCMkkDs+cFS8bvQ8gnE7jr2CY
 9viiZKZwqAJQSrZfftfmJoZGfYedtFdL6TWO3iAWt6jYxnGmLZ3nCScYyt9JpX3ufaZD
 M1nezsFmR7zL3I87wEk9/I+CGmbwUyzQqcx39I8cKQMXro4tkUoa4Dty7O9TiR5NWBWm
 d2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604445; x=1796209245;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WH6OCX8O2rHrDc+AjcgOmeRyCyW9QUyc1yx5oWf9qtI=;
 b=QtfrEXPj1rhtj3JQR8aYsSj7zVdQgL6VoeLATdzPQm8FK6aCbx6WhQSTzSUmqmg4yV
 r8HUV5fOtT7ptCHrqNSMkJApq04jaW/TVpJHLwWL5Fg65c6CsoV44+cx/8DbN/cJy16e
 VLoMUxIePSj0IRKt+ToCUzroBLZXd0Xw+MWp/0dwjqa6rkEjY14Uq91WNkHkxB1CYlXc
 BD+q5b+Im08IbLg7Wyo+dC4928PAUCY8mHaLuvOpUR/nUYCTw3k9b9SCwgNjkwLuAULY
 srSQU7HM0ki0+kwQfPVPjY7UJS8NfHm+IHGv/jRLniB0Vy4kgsQ/rTt1I4MEUy0nGAN6
 LOdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHkyH26Eh3A86GvsnDp/+4eDbETbInqNlPDcPz1xv0KahjflOhlhTYdbmt7ZwGf/AGjvJwG+2rKbl2p@nongnu.org
X-Gm-Message-State: APuU4Z+raD+rA7agtOwaZqfF7ujx6nxgskMqCFtyTycqlVNlRBDyxjeR
 RpbR2K39btdy4eaq+KNgfpHv/spjeirtmhasH0YjQ2YWmplUhvuiPHPy
X-Gm-Gg: AZFdTZdZV3SkyVt5aBjRzdE9g16vwUPR8T7ojLKjzviRjk4O0BKFMA8J4CCG8AxqJJm
 Set6v54nvazPH3ucuDIhV7IeR/8Bz3KxtEebSp2FDJnAQYmnwvvMgv0/iv8H4pyo8NW9EjiN119
 EzrbTKAx5XMG4/ghUZQFmoty63ypccN5DenXHmXmMDDwyhfAkiQ3DD6jxVY8+G4Rl601tmKzfOf
 y0C/kJsGphwcpQWSEoyelG96tGAFiu87xhByR1p2nwgfuTfq7IKJ6+IoVttYD2Te5Kzgj6IKuL2
 CzDxcyNI8weo6BWDloqECwqECBeTStP7IGkRiIkoTHceJKiMS8Xu1v2Gs+zL+qBk/B8h1PJLY6U
 XIiI3osJd9g3+8ytc42iQ31iFW4GxiC5aWIrQcJbbq3+0ViYmqJAKYWG7EMTszJAtPxmCTL6asM
 B8FVfEzju9c+lemkC9agv8fZZaIEImR1v3tp83SqxxL4nfycfJn/Y1LBIWyq3/dX8TAaOt7VpFN
 NmeUrQWGV425ql6pPqitrK/9FaeAGTcn78ZCbssE71El9bUE7f6xlBnuG2fM0feeEJDk6bePaEG
 kAE8ysRG7VhzGlg4uLVHtAd6Wj9PGSR0R3X4
X-Received: by 2002:a17:907:6eaa:b0:c46:d837:b358 with SMTP id
 a640c23a62f3a-c513a4355afmr1482828466b.3.1795604445261; 
 Wed, 25 Nov 2026 03:00:45 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afe01a0sm626673666b.68.2026.11.25.03.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:00:44 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3739cc8a-04a6-4d17-96f0-db70833c700a@xen.org>
Date: Wed, 25 Nov 2026 11:00:43 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/21] i386/xen: Free Xen vCPU timers when a vCPU is
 destroyed
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
 <20261124232247.23169-4-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x62a.google.com
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
> kvm_xen_init_vcpu() allocates the per-vCPU timers with the CPUState as
> callback opaque, and nothing freed them on vCPU destruction. So a guest
> could arm the periodic timer for a vCPU (VCPUOP_set_periodic_timer
> always reaches QEMU; the kernel doesn't handle it) and eject that vCPU
> via ACPI hotplug, leaving the armed timer pointing at a freed X86CPU.
> 
> Free both timers in kvm_xen_destroy_vcpu(), called from
> kvm_arch_destroy_vcpu(). That runs under the BQL, as do the timer
> callbacks, so it cannot race an in-flight callback. It *can* race a
> timer hypercall from another vCPU — hypercalls don't take the BQL,
> which is why xen_timers_lock exists — so clear the pointers under that
> lock and have the periodic timer paths return -ENOENT when the timer is
> gone, as for a nonexistent vCPU. The singleshot ops act only on the
> calling vCPU, so cannot race its destruction.
> 
> Also move the timer_del() in do_set_periodic_timer() inside the lock,
> where it should have been all along.
> 
> Fixes: CVE-2026-123069
> Fixes: b746a779264f ("i386/xen: handle PV timer hypercalls")
> Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4098
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/kvm.c     |  6 ++++++
>   target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++++++++++--
>   target/i386/kvm/xen-emu.h |  1 +
>   3 files changed, 41 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>

