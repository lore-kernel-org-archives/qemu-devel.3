Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460EC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQQX-0001s1-Ac; Fri, 07 Feb 2025 10:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xSimZwYKCvImYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com>)
 id 1tgQQM-0001mE-8L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:37:46 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xSimZwYKCvImYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com>)
 id 1tgQQK-00056h-5D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:37:45 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f9c5b046d0so4758400a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738942661; x=1739547461; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jwYTJjiEd1pBTulC56b0xIusdB3gOsGMSwp66kj31EA=;
 b=Cup+T63H7iRL8iAWvYaR4JfsiY9ePHrx3/0xQuTqxFqulELhiM7IsiW16Uq3ZTGhCX
 NmobAALzgHGXyWb1awu7pXjCBe6ZmCm7OABBdO4hYxOeCVKJ4GAM1FXuPuPAXP4gs/Ys
 bpbJynsk2mXx6nqbW89ju9D2VgwjQBbeYUibXpCkwPZMbiXiht+6M2Un6SBVG5U/pcgD
 XYZVw0yYg50uuqDtAAWHM8OoGpt9dYBCYSa+jD1Sjycx8v2kUaXcc8tn1NpbzkhnwWYh
 t/iLa12d6eqrzwuTgCSlgJ8KCeKaUVka3ui16co8RQM5aq/yyUZYJG5Vs3tM4hhSa+Ib
 V2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942661; x=1739547461;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwYTJjiEd1pBTulC56b0xIusdB3gOsGMSwp66kj31EA=;
 b=UC3CU8TssKmnlA0yLZ0Q1BOfGS48WgnpoydwGmSmkhjO/i3JdQN+GxL3UJllAh9zKG
 Gt2HGsvJoS/COP9keHUanlpxhqBdAxfdAZZCdJwx8fVOw0ClPwf60CxZDGOYwgcB2Ici
 rGOJNrZytYpsBbaANiKFha1KkVWdca/z1RzxoW+nEtHZVVlZpKLHjUNltImXhOBNbHVX
 /lRcTXMM+gsztS+h5I/Nl4ZznYhm2Qs80TwKVdaOJ1Kvq2aIoGeeqkI+OLh5dcxt1LDn
 xlkT4FBcGhO3FM2PlQhEcp7henNBhm8OC+XjuEwbOGCh0yoIPCVdr6Jq/Dx6OCQTlhvH
 TKjw==
X-Gm-Message-State: AOJu0YxmyCjAo+aQtT67h0719YJp38iodkWn86LnK3fD0pFuZv90m5ed
 A46skln1XNdlDw06Cjhz/OSau0gqzL21VpbXfw+F/7lRhDJ3Qj5/IeTVWZ25Bqfah7X1m9qK7M7
 CbQ==
X-Google-Smtp-Source: AGHT+IERa+Rywv/H/txubJQW0t0aFsR0oFzWrZg8x4V2aIf7jDbMtfwdY1UmKxioAzFzmBb+WHSzh3ryuv4=
X-Received: from pjm4.prod.google.com ([2002:a17:90b:2fc4:b0:2ea:5613:4d5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b44:b0:2ee:cdea:ad91
 with SMTP id 98e67ed59e1d1-2fa24175d63mr5586623a91.15.1738942661522; Fri, 07
 Feb 2025 07:37:41 -0800 (PST)
Date: Fri, 7 Feb 2025 07:37:40 -0800
In-Reply-To: <20250207143724.30792-1-dwmw2@infradead.org>
Mime-Version: 1.0
References: <20250207143724.30792-1-dwmw2@infradead.org>
Message-ID: <Z6YoxFOaMdNiD_uv@google.com>
Subject: Re: [PATCH 1/2] i386/xen: Move KVM_XEN_HVM_CONFIG ioctl to
 kvm_xen_init_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3xSimZwYKCvImYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 07, 2025, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> At the time kvm_xen_init() is called, hyperv_enabled() doesn't yet work, so
> the correct MSR index to use for the hypercall page isn't known.
> 
> Rather than setting it to the default and then shifting it later for the
> Hyper-V case with a confusing second call to kvm_init_xen(), just do it
> once in kvm_xen_init_vcpu().

Is it possible the funky double-init is deliberate, to ensure that Xen is
configured in KVM during VM setup?  I looked through KVM and didn't see any
obvious dependencies, but that doesn't mean a whole lot.

