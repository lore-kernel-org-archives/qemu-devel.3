Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D6C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 13:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWafm-000546-QG; Tue, 01 Jul 2025 09:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWafi-000527-6S
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWafg-0001ZT-9Q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751375108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41EXXjsLW0bLv6oTUIdi6IkrVBQSOASHsVY5f4FWQCM=;
 b=DCvGdn9zwdXJUw6fc33OBlzi0FIaNLHQ1QwupmnfDT7BMVtiWNQ/RFV98iuJklpQN1Noxv
 O2JVQR+Ar2dW34igH6Z8u4j8SGrwbd1NMzN81W1k9yOrPQRsmtDFogzdsfNaur6KPs50nZ
 64GXEc3KxqmISo7O6/hX3mmlOaTljUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-3mcWRC9BPdu1xtGWw7XTPw-1; Tue, 01 Jul 2025 09:05:07 -0400
X-MC-Unique: 3mcWRC9BPdu1xtGWw7XTPw-1
X-Mimecast-MFC-AGG-ID: 3mcWRC9BPdu1xtGWw7XTPw_1751375105
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so24585525e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 06:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751375105; x=1751979905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41EXXjsLW0bLv6oTUIdi6IkrVBQSOASHsVY5f4FWQCM=;
 b=sexb0z5Hw8vLlMVMxWaDV42zdWT5GKLFIM5sXDFgUuAcE0kT9QCMoif7TJ0jc13Z5z
 b8nHRy+Ha6l6+elWYSczjKzpMuF11DsLmwcKfAF+lpbgCCSxYjVdll9SuodekPXpwdIM
 lT9nZQ1/PEuHA07uy7zxWJ4gfPyo4GZOWFiaXcMbo7lIZx1mA9XSCyvq5cCv2Tc3e7ue
 yQOqys8w6GUVSGpZ8jXCNkIFUQzDnItjpSfil5yiPPKJRWqtMidoWTRpiSfG21+q0Ueb
 ehRDAyZsE+TX/Z98DL108LGdfK0iOyJpHDLf8qsyeatJ1mpCEkrt8EQTdGi1HVm2Qbox
 Mciw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc+vBj/rznXf9/c0sXfOJMFN7JpP0vXgK6gswO+0ShfKR5K+Q79Ojt/lXfO47xaWvho999sAKV/DlE@nongnu.org
X-Gm-Message-State: AOJu0Yzd8Tsj9ngjR7SZnrigDnTWmKp8qLyVu/plAm88e0xs4qTAqSJ/
 mo3p7+WYgyOKM3ab3KMY0wZqsKztcOkN6S3qo3/x9fGRnGGLH6JDQr5kjg8FVJjYtyOMudi45iM
 K+bBsR7Ca1CUxkuQFJI0GVowANCg2sWsZSxCug2d1nKTzxmi95+iNqvhE
X-Gm-Gg: ASbGncumaT5u8KbpO8jvBTs3jsEK/ZudshjJgKyV8K9fkXKdFKbVKidQIxeSDRzFTkz
 qCDEKq/OQgXKJbAaubBljONQW4DY1QJgFSNu3aAYkMm0k2WW6lFTC0+fIu2IHBAKFtvXcGyFSm4
 bSCwsUOncOB1M//KdziJG+ti2vupB9a9GnxrCr+2aFkF2kBrx8FCnhH/UAdJcX+s2LxkT8V9/pY
 +9TJHP1/CJNOVZKPf6OWA2P3krXKuaqo8ALZq0kuCPqjodvt+3x1nL7Ca/h9Z8s9TdHJjaYrFqM
 3T4F9uka8Blr
X-Received: by 2002:a05:600c:3f14:b0:453:b44:eb69 with SMTP id
 5b1f17b1804b1-4539d797842mr103011325e9.13.1751375104376; 
 Tue, 01 Jul 2025 06:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZrAeqRbvPFsp3eqfgd8dac460wn5yOs+TSAJzTayg7uOwbIpnr2TYBNQv2q2RQVYQFGT/eg==
X-Received: by 2002:a05:600c:3f14:b0:453:b44:eb69 with SMTP id
 5b1f17b1804b1-4539d797842mr103010415e9.13.1751375103421; 
 Tue, 01 Jul 2025 06:05:03 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390bf8sm168812485e9.4.2025.07.01.06.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:05:02 -0700 (PDT)
Date: Tue, 1 Jul 2025 15:05:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Alexandre Chartre
 <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org, pbonzini@redhat.com,
 qemu-stable@nongnu.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <20250701150500.3a4001e9@fedora>
In-Reply-To: <aGPWW/joFfohy05y@intel.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 1 Jul 2025 20:36:43 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Tue, Jul 01, 2025 at 07:12:44PM +0800, Xiaoyao Li wrote:
> > Date: Tue, 1 Jul 2025 19:12:44 +0800
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised
> >  on AMD
> > 
> > On 7/1/2025 6:26 PM, Zhao Liu wrote:  
> > > > unless it was explicitly requested by the user.  
> > > But this could still break Windows, just like issue #3001, which enables
> > > arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
> > > turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
> > > value would even break something.
> > > 
> > > So even for named CPUs, arch-capabilities=on doesn't reflect the fact
> > > that it is purely emulated, and is (maybe?) harmful.  
> > 
> > It is because Windows adds wrong code. So it breaks itself and it's just the
> > regression of Windows.  
> 
> Could you please tell me what the Windows's wrong code is? And what's
> wrong when someone is following the hardware spec?

the reason is that it's reserved on AMD hence software shouldn't even try
to use it or make any decisions based on that.


PS:
on contrary, doing such ad-hoc 'cleanups' for the sake of misbehaving
guest would actually complicate QEMU for no big reason.

Also
KVM does do have plenty of such code, and it's not actively preventing guests from using it.
Given that KVM is not welcoming such change, I think QEMU shouldn't do that either.


> Do you expect software developers to make special modifications for QEMU
> after following the hardware spec? Or do you categorize this behavior as
> paravirtualization?
> 
> Resolving this issue within QEMU is already a win-win approach. I don't
> understand why you're shifting the blame onto Windows.
> 
> > KVM and QEMU are not supposed to be blamed.  
> 
> I do not think I'm blaming anything. So many people report
> this bug issue in QEMU community, and maintainer suggested a solution.
> 
> I totally agree on this way, and provide feedback to help thoroughly
> resolve the issue and prevent similar situations from happening again.
> 
> That's all.
> 
> Thanks,
> Zhao
> 
> 
> 


