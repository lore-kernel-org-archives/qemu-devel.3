Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214B606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/JHw9Oo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAzz-0002pQ-Bc; Wed, 25 Nov 2026 06:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAzr-0002e6-Lx
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:17:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAzq-0008UV-2y
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:17:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso40189895e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605424; x=1796210224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDsbr5ve7lstRzCqqwaH7hey2ad4/GX/MTHn8iSlZz4=;
 b=n/JHw9OoQHcgivkY2ZcgsQma+t+9tZeI3kOI7QaAZnGfjhZE3VO+RvXlUpkmZNVVr7
 z1EqYJ5AFwzCyFS9i449YwQqc7zVzWi1sjc9kEDcfaqn3UtrSao/qLCZK/tOZ6pBxahZ
 4WvZRgGSaMW+wgEgHan6S7j0I5kkckrAU2I/hI+OJksbRMgNBsb0Vw+3HRELwjuYPzr4
 sKa7/j2ehTDA3Zh5Zr76X07ejTdznjAbl4Oh6bU/L6Rziny/9wKyaKpeQ32cbL54zueK
 HrcPIZyxLqrR3tK1rQ50DGNNUkinWuu3+fAc1xZw1NGwu8+Pb4zW2WWroYQAG/udQCpv
 xotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605424; x=1796210224;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sDsbr5ve7lstRzCqqwaH7hey2ad4/GX/MTHn8iSlZz4=;
 b=huLnFx659TelhDfdhzfYV8cQTNr6GPxr+ibuQgPvKV6hLDESVA4Pa7H/dbzVy72ZeB
 1W60NMC2BpD3/67WgCCA3j2byqp4GT9TwKMLBBAnYc8dSSSNJZj+hIaiOAGcsXSOm3IB
 L1dvGhlsEK0F89377ZL8C3eoUxAJvYVDdsO7WtcRZZR78VeZSWwuG+u3q+74u0tRC7ZT
 iQ/FXJv3wZpSWJyi2eIKbBvAlnH7trirGdglBJN1XbJEA/5uz//SqAe4s9+cEgRs9cOm
 oGOtW6YfgWKbjCWTflVH80Q5bvK9fFeclCgbM15PXbi8uWEnVt4ZmzGLnenEoYDOGYCZ
 7UAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG/DluZZBgg0m0Ng3Aqer3qbWJX/MAu9EGhn2IhwgpHk+W3jWo1V7qF+3qW/Woe1Eu4rG/7aypW9572@nongnu.org
X-Gm-Message-State: APuU4Z8Lyz0az4plFtyhEQg5JH/bK7gNk3FQpU4b62K+xDkjr+LdYj1a
 qBhj2So3B7qf1Unhi81cjlN3dm2fNHpNatNUKc3rC/BS45WOQHuGwf1K
X-Gm-Gg: AZFdTZdPK4yti/m+F2h+LJRbBn4xr5HDQHbl9MV5x2gCH82khivJaUG5GktLvr8ZI53
 tiqes5A2DN9MkC1WsiNlMfXgQhIKgp651xLukeujXMMThLajeYML7sTC26zbjYEcypZhN24UkED
 4E50hORKmCYdkFW8pg7DFyD1yhB4ducvelNx2XWXEJQqq9x+wmN8KMVfCy4E1bJnfw22SMF+0CS
 uq+j2OsB1KqLz/w/nbgsbpVzak7p/BKOYqC0A88T8Jv6o8vMSB+LNr5RD2jSkGCSgzIV7P7lBYZ
 Lv7544R/njxWEqsCQNOExwRFCdbyDNXbcKgY6tDMg6fNygN2XZkPbHedfH7zQIMwPdnbNZesE6n
 XMZpDAzPtyqSpJnx7BGH/haC7RKrCy0L6ybb6vgZnsdcea4oFPXVzinflL1KPEkT6LsIigQFvL0
 Zs3wTsFFlVCvpEDhSp6D+GFtUgnVDKMMZLrebpQqN6NSj/vJXzV/bV+sYVRhFGRMdsPht1oB3k3
 1Oy7ovcDJthCE/w1NiXz4fijYF2gHcUDIDl5HNozsMabxVtFYlZfTd0xE+zg+2dZQXKruVIoAFw
 1KX1hTqFoaK/FE0PfvRL7L5LEMSndNFzk4uJ5R6L9wX/8TcZf9I/8FE=
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4bb8880988cmr372815065e9.6.1795605424154; 
 Wed, 25 Nov 2026 03:17:04 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm454867055e9.2.2026.11.25.03.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:17:03 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <719ac82d-4638-43c1-b563-af0a33b25d1e@xen.org>
Date: Wed, 25 Nov 2026 11:17:02 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/21] i386/xen: Don't inject event on invalid port in
 qmp_xen_event_inject()
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
 <20261124232247.23169-10-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x330.google.com
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
> qmp_xen_event_inject() reported the invalid port with error_setg() but
> then carried on regardless, passing it to set_port_pending(). Return
> after setting the error.
> 
> Fixes: 507cb64d6e66 ("i386/xen: add monitor commands to test event injection")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

