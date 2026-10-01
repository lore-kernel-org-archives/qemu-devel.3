Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D37DCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOPy-0004sS-LJ; Thu, 01 Oct 2026 17:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30tG-agsKCs0v74C764xF1Bz77z4x.v759x5D-wxEx4676z6D.7Az@flex--coltonlewis.bounces.google.com>)
 id 1xCOPv-0004ql-UG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:34:15 -0400
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30tG-agsKCs0v74C764xF1Bz77z4x.v759x5D-wxEx4676z6D.7Az@flex--coltonlewis.bounces.google.com>)
 id 1xCOPu-0007ZT-6k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:34:15 -0400
Received: by mail-oi1-x246.google.com with SMTP id
 5614622812f47-4b26d8d2498so10805015b6e.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790890451; x=1791495251; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bZc4ogm5/WT7GTGjXs62z4TP6S2W3GOrNVtANWpbLNc=;
 b=lI2Acj7wC/cv+CKzyqu1uHbXtj0tncW+6bQMWXYkP/N7QjXLD1tVD8rkfjfhKAt+7G
 1J9EfS3ifBD93/mhVi48W0yyD15Sc2RwvTBRtXWCY920OxLhiG2hKsMgoV5vhI+T6MjR
 b0ZWNK1X5srGI1Gj8r7LTVY2w7dB+0HLfle/6MF/SIAX0lqPxT0LovFvAAukqARIJDhw
 4m2RvxmqMMvEoLksAeYZ36G4wjqAwDMiiy3l/amcTzhyG9DvfYTHCpRk71EIa9/kMq6y
 PPzhr9FWjQiCc4+TdZqUJmURVYDt332q8W1/YgMt8qmwhPLAWr/k7Db51oFxhU+NdIoy
 /TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790890451; x=1791495251;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZc4ogm5/WT7GTGjXs62z4TP6S2W3GOrNVtANWpbLNc=;
 b=un6v/SZPBaTRdrP/hI36GuABEd84+M6SDPMH+a65kh3i/oyoXiY86HDvziWRN65IOC
 WbxsTg1G9w5PToDn1ZdHm5rMbRdMDlTsdFyAaHhcDIcP5goXNRELtwAc9KjjSxQgRi+Y
 rRvrBN6M/TeRakq4fZe5FJn9gb4kwjfHC5K2poF8babZn3QzeD3NqEwu5oaP97yjNljx
 HAV+BRn3jyu4+4TgI2akKn7KOZGu0GMhu+gc3Uk6+pmLW+RoX1tLoFART++jJgWxPNNF
 O37KHam9CpmRAcZMtVieaPftJzeowkx6UAeEi4QJC3fhd6f9gfGgoD+5KsmSyMYoIzco
 SxfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeqtipQbaPJCQy09HHTOH96rrfwdj0rdKq1zXG08wwS45kYhXUWyq3Wp6mj/PLDwm/jLgCEylcQrmh@nongnu.org
X-Gm-Message-State: AFuF++l8D97z7jmoNrKpxx/sxJsR7U2ZiAn+c4IP2TRkX/N3AS9AH0PI
 nQ/MZMv4B3sgkS35FCAIHeAsgBjEQhcrxHKmyUe5kg+6ZsCZkeBT/pnPGlHXCxj5l3zoHEnl2MM
 bAD8piH6+isH2x4aTvtPHP/j60g==
X-Received: from iou20.prod.google.com ([2002:a05:6602:64d4:b0:9c7:5697:9ad7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1583:b0:4c5:12a4:ec8a with SMTP id
 5614622812f47-4f52aa86098mr422937b6e.36.1790890450368; 
 Thu, 01 Oct 2026 14:34:10 -0700 (PDT)
Date: Thu,  1 Oct 2026 21:34:09 +0000
In-Reply-To: <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com>
 <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
 <20260929212102.3659389-1-coltonlewis@google.com>
 <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001213409.2090008-1-coltonlewis@google.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::246;
 envelope-from=30tG-agsKCs0v74C764xF1Bz77z4x.v759x5D-wxEx4676z6D.7Az@flex--coltonlewis.bounces.google.com;
 helo=mail-oi1-x246.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On Wed, Sep 30, 2026 at 12:35:02PM +0100, Peter Maydell wrote:
> On Tue, 29 Sept 2026 at 22:21, Colton Lewis <coltonlewis@google.com> wrote:
> > For the counter limit property, would you prefer that it also live in
> > kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
> > keep "pmu-num-counters" general so TCG can also use it to override
> > PMCR_EL0.N in reset_pmcr_el0?
>
> If it can reasonably easily be implemented (or potentially implemented)
> for TCG, then I guess the general name makes most sense.

Sounds good. I will keep "pmu-num-counters" general (and wire it up to
override PMCR_EL0.N for TCG as well) and move the partitioning toggle
into kvm_arm_add_vcpu_properties() as "kvm-pmu-partition" in RFC v2.

Thanks,
Colton

