Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8950C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChAD-00074m-3v; Thu, 30 May 2024 10:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_5JYZgYKCsAykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com>)
 id 1sChAB-00073E-IN
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:53:55 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_5JYZgYKCsAykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com>)
 id 1sChA9-0001zu-Dx
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:53:55 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1f310201aefso5654325ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717080831; x=1717685631; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jDFh9DV1iQ7IoQP7cwbUiBwgbeEBHHfO94vEinmwZas=;
 b=isDFx+P8PucUhEz+NKyjtT2z7EIDZz8UE8+M53B77HliwQ8qEOw6Bd3+KNZG8V+FTO
 Sg6G054P08eQgVR1lFSSakv/hzOWNUjLJqFB64rx/29ufztpULEcQo01WLXNbm8H0phd
 FVrvoZZLINWu4caBPu+P4Ge7BofZTr8YhwtMXNfu8WOlhjFbvCbtOr6zZ5P7QXWzNRiV
 qtaLk6iely7e6S7JDkvw01cSXfsKBjaCaSkdAbjnw1ioQyuY9kDXOSSmrvTkCNi9NgJL
 F483KztKTIQEujgiDn745D3MKu8I+FWxbM3f9680o/gHaujw42PFOfppeWLkxQ2BoKuw
 CtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080831; x=1717685631;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jDFh9DV1iQ7IoQP7cwbUiBwgbeEBHHfO94vEinmwZas=;
 b=w1NW70PcT/uaok0I64+VelGm6xKGT2S5hhJW+pre6JOBXRbbgwE/bFtiB6OvvODolR
 lMKNqN2mgsk2x7l5nJgvrdoLi0kf7lwXQChdSzzeOu4E1qxOvxQMIfN0WJn2s9CaS5hx
 KU70NW4NeuERfbGPn5mibTxTR850NAKfcRZbNuE2K2AV9ZTYOa13Wop6olpK0vixj5w+
 DhVjjk/SUQmk4Dw4vyd0oXcCB6kGsKiUssk/RMJU7hF2xo+5PpgrPeidpbhEVi3Jz2yR
 UMUY6RWPfXaT7oV1Ijo8b8HDKuKq880ayblqFsGizBIwU5wnSe2mwXGU2LzoKwkZdMx6
 649w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+rWvi8vhIcvTlx7oRhfCBwTOelplkzYaq+uD+d1W8fILPoqkTsAP83lxX9h2o4Rzf8apniCH1cmbs3w6dqua+jKOMqFc=
X-Gm-Message-State: AOJu0Yz+Tv8DrSrQt4BahBsLRxe5BJzq0t/Xgxi/UFWLBHuoTjdPJYyd
 497KW4NVLh8ca1/62v1vxQxOQsywertzDaiqk3yLPT7yJ1Ecwt5S59wA0IEFFZMjiMQnVXAuOmw
 ndA==
X-Google-Smtp-Source: AGHT+IEoQ0Suo1g2nGZt0Gk7LRXwn+aXuq+ZBSpXZ0L9iP+Gt/BOm4z2WR0gUU1ErFUnVDjNQKxevC/MlrQ=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e742:b0:1f2:ffb2:894b with SMTP id
 d9443c01a7336-1f61972e289mr1061785ad.9.1717080831123; Thu, 30 May 2024
 07:53:51 -0700 (PDT)
Date: Thu, 30 May 2024 07:53:49 -0700
In-Reply-To: <20240530163455.0c70edcc@imammedo.users.ipa.redhat.com>
Mime-Version: 1.0
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
 <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
 <20240529144634.40aa597f@imammedo.users.ipa.redhat.com>
 <898effa1-1a5b-42c0-9305-8db8d5febbf5@intel.com> <ZliFJyRhnSVlNOYQ@intel.com>
 <20240530163455.0c70edcc@imammedo.users.ipa.redhat.com>
Message-ID: <ZliS_RJZfAyQtjUP@google.com>
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
From: Sean Christopherson <seanjc@google.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Zide Chen <zide.chen@intel.com>,
 qemu-devel@nongnu.org, 
 pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de, 
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3_5JYZgYKCsAykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Thu, May 30, 2024, Igor Mammedov wrote:
> On Thu, 30 May 2024 21:54:47 +0800 Zhao Liu <zhao1.liu@intel.com> wrote:

...

> > > >> following, CPUID_EXT_MONITOR is set after x86_cpu_filter_features(), so
> > > >> that it doesn't have a chance to check MWAIT against host features and
> > > >> will be advertised to the guest regardless of whether it's supported by
> > > >> the host or not.
> > > >>
> > > >> x86_cpu_realizefn()
> > > >>   x86_cpu_filter_features()
> > > >>   cpu_exec_realizefn()
> > > >>     kvm_cpu_realizefn
> > > >>       host_cpu_realizefn
> > > >>         host_cpu_enable_cpu_pm
> > > >>           env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> > > >>
> > > >>
> > > >> If it's not supported by the host, executing MONITOR or MWAIT
> > > >> instructions from the guest triggers #UD, no matter MWAIT_EXITING
> > > >> control is set or not.  
> > > > 
> > > > If I recall right, kvm was able to emulate mwait/monitor.
> > > > So question is why it leads to exception instead?

Because KVM doesn't emulated MONITOR/MWAIT on #UD.

> > > KVM can come to play only iff it can trigger MWAIT/MONITOR VM exits. I
> > > didn't find explicit proof from Intel SDM that #UD exceptions take
> > > precedence over MWAIT/MONITOR VM exits, but this is my speculation.

Yeah, typically #UD takes priority over VM-Exit interception checks.  AMD's APM
is much more explicit and states that all exceptions are checked on MONITOR/MWAIT
before the interception check.

> > > For example, in ancient machines which don't support MWAIT yet, the only
> > > way it can do is #UD, not MWAIT VM exit?  

Not really relevant, because such CPUs wouldn't have MWAIT-exiting.

> > For the Host which doesn't support MWAIT, it shouldn't have the VMX
> > control bit for mwait exit either, right?
> > 
> > Could you pls check this on your machine? If VMX doesn't support this
> > exit event, then triggering an exception will make sense.
> 
> My assumption (probably wrong) was that KVM would emulate mwait if it's unavailable,

Nope.  In order to limit the attack surface of the emulator on modern CPUs, KVM
only emulates select instructions in response to a #UD.

But even if KVM did emulate MONITOR/MWAIT on #UD, this is inarguably a QEMU bug,
e.g. QEMU will effectively coerce the guest into using a idle-polling mechanism.

