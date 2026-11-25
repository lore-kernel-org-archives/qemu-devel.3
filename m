Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E48606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sg6t43Y+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBIn-0005T9-Rq; Wed, 25 Nov 2026 06:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBIh-0005Si-U8
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:36:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBIg-00021v-E2
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:36:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so57943025e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606592; x=1796211392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7fOIsGrjGNi6CskIGWATs2FBSxpHu/NcffK3/zRtoLs=;
 b=Sg6t43Y+SYdBTJ4XjeMqceJeW5EPnSOJ4JCUerewrfGZOQZ0QLu+JNBnkwdMGEq/H6
 r39oEjF5MI1EpJGtSicyZRCvx0ud0S6RWor3k/81/wg4k+LLtFDdeqWAGPrlx0h2IdwE
 7+54aDVv58FE/JlV0NWqND8PfTzLYePU7MPRdu5+dtcNbB3AxBla0W9Q7sw/ZMTrleFx
 kO/KQY9EnIAG9e0i0vYzOYVY5PMrXRJxgIK6BRviyhjX2UVRzn9BAWFYZTownnmHNHEA
 VxcFrwRWa53zyCkUeoJbQQFnLyZfC0yvenwkJSRrayOcLNTbqNaVCPYHK7/iq2VBv894
 +wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606592; x=1796211392;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7fOIsGrjGNi6CskIGWATs2FBSxpHu/NcffK3/zRtoLs=;
 b=MS5oRLma9govPuZNblhSfWGd4RL1aVfI6QM7vpouPP8JM635QXWtuUqaLBhKfKviwh
 O4h+BfDaViM1GPdG2056YBDDvocdr9+TxFl62EkOgLwI5939B4bEQEElzDXyF+u4jB0p
 yW+hjzAMVoygIL4DVzda9jnNuWeIp7lUIrA2zc3RGkBY7Of9HgIWbVWr+P3h5GanxwQG
 IQZSOKKjOdXasHBd6KtrAeIpV4yRK6g2ggOsaCZJRrpmfZi1wF2Iy9Pfjw790omTWx8i
 1xEe1oaOPnPBgNFFp2u+9Fs6vHqUwwsBTFps0X1nzrDG9BO5ajr6GoT61HJqplmBh7Qr
 ac8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFSw8mnUG+vG+9Z7kGxRsmbUttu/6s3sNHMcqdwThS0KvDk8ikqr5tsUCOT/tJwc6+twDfN0LGXrAOB@nongnu.org
X-Gm-Message-State: APuU4Z+G7ZIbVGdFU+kvZJk2Mjrq3m/Ussii4gjrSoHlp4b/eL/hu9N5
 ZCgyigxhbSLBru4CDu1J0qD4weitc9BRvAmpBK99rRX0L3dYJwzoGEIQ
X-Gm-Gg: AZFdTZdTVhfXA7oqNGXtK9Vh2A4ZP6Yt62AE0RSL7BYn0iuPCdN4q8YnVR/Zk6rvLeG
 sD0KGK5H4LSTiDpcCxc2i7J32KHxlqq58cmjV59WwEcbm8aFD+R8zjupFqg/biV/5jGl6kWwJqy
 i4584CiU51fCEZb6FL9yrwBYmVX2CPgoAbqauXvjS91NaUDF+BDKzNhaFYU2wW039wVXS03OpCA
 ZqzVahyfWaUDU4v0dDNUyFuhppfYKvOJNiRmJ9ozLzXeZ1ViT9rCh+L8jEuRrEADqjgnTnssWE1
 pb7NzXSw2QXQwovt4+5dcqmAOfvVVnLx/cJUkx4SEaRoFnrSI3I9cB6xJ5N7jgtixC7P+DOdYGI
 OSP961ruhva+rlLg5MziVKjsPNRAospKJqneZDFyVT2z7S5ns3Vp3LuL52O0rzgzIdiU0mUsthx
 UvslvDSaU37f2Z8BeQMvcWreQ+Wk6QSJZFDTnrgTD+y6/HKe6UqTirYRYoF3IafeuWAKoRl1L+R
 OOrA/XjuI/OC1GpntH4wHLJfk6WvpTIb5/C8QGcGtbyCj9e63R4XaRykmU+Wpu3viGuM4EUB0qz
 XrnEggmICl4zr1Lstnt9zjnGXdDAwZVk26g=
X-Received: by 2002:a05:600c:8b83:b0:4bb:60da:56af with SMTP id
 5b1f17b1804b1-4bb8893053dmr316762505e9.25.1795606592489; 
 Wed, 25 Nov 2026 03:36:32 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm498592465e9.6.2026.11.25.03.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:36:32 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bc0399a9-d768-4503-b499-157d5478fc69@xen.org>
Date: Wed, 25 Nov 2026 11:36:30 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 21/21] hw/i386/kvm/xen_evtchn: Allow unmapping an
 emulated MSI PIRQ
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
 <20261124232247.23169-22-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
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
> The "unmap GSI PIRQs only" check rejected every negative gsi, which
> includes IRQ_MSI_EMU, so the later IRQ_MSI_EMU branch that flushes the
> KVM MSI routes was unreachable and guests could never unmap an MSI
> PIRQ. Xen permits it: physdev_unmap_pirq() on a domain with HVM pirqs
> routes emulated-IRQ pirqs through unmap_domain_pirq_emuirq(), which
> succeeds for MSI emuirqs. Let IRQ_MSI_EMU through; the existing
> unreachable branch then does the route flush as originally intended.
> 
> Resolves: Coverity CID 1507603
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

