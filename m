Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EEDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNMmW-0007yf-Hr; Mon, 16 Dec 2024 20:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pdlgZwYKCh4M84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com>)
 id 1tNMmU-0007yT-Tx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:53:50 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pdlgZwYKCh4M84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com>)
 id 1tNMmT-0004JF-9b
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:53:50 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-218ad674181so18439815ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734400421; x=1735005221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=KTzYjrWXJcMf7xD7/sgDE240NDaU1rTlGzLti0JBz6s=;
 b=zSZxYUvXYJOEOPAIjtA907CIQwtxSZVj3GiPhKSOiehHRVeMF31FS7bGge4ccTN23T
 NtwSJ48GkCd76YgBDFKcDrvut9Ndt1u3fc6HPoZDQA8tD5RUJV+UIPtkOCCYDItqgOEW
 sWoD1cZRbN234uacxBol8F3AyKGQ8u2ONa1UXQUI7aY0pWbulOqrEck3dqDlwCZqw3R6
 Byh+6x+LZ+8pyTD29tVCVZC8fanY8dsgroGDq9E/O+stn3aLFqCeKYp5QMYKthRKYfRC
 zwGMcGeUGxZwUYCt3hWV2J6yTuzqm8DxeK50RceXk1ECZvaKB+gH9OgHL+LIA+kYOObb
 XTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734400421; x=1735005221;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KTzYjrWXJcMf7xD7/sgDE240NDaU1rTlGzLti0JBz6s=;
 b=HP3fo+/zUtToxaLuxUNrkM3qIaELRvAZHHVxUzuQEEcutZPYLpw7qIPs0mSG/Wf4Bk
 A4iztvv1WNe10KbAZK5QqPUGUWNKnqipjsqsSCDr5pxuoiTlVniy7i5rht6WwPKmJJzm
 qiGujmpbl2lJI/hcUIlqnRy/Pai58BC+qLjkS5ohSq7u4jKcecZBBNPqKZs8YZwr6GBY
 Kb87btOgDpCKAW8jEyzhmymEGRe7imHgTBt+EjIygD31wpXSLeJxC3WdKL4Do4biFSHo
 Ea5Mjv8rLBZIhO5XqOkWTQAyxprexJeZWeLOtR+v0kULcfwHOtW8eMigXbwXZFs/Q5cy
 2NRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0f2beFQXpurK59YAgNvF0twKjTPm33gPjjTnxg7jf6OsgGqu2AcaBwdFZBYZRlQFpfutW+BwJWzh3@nongnu.org
X-Gm-Message-State: AOJu0YyKZu669Ygg4cs79kCoyaiRPt65byleh4wUZ+ti9iCcvS2dEDxl
 ypUdH5jcMvWnFCn91VnglHp8V9InsY7tX+YAIek9H9wS9OvlPvY/AO8zUB+nCGYDzOvubvMvC5+
 hyw==
X-Google-Smtp-Source: AGHT+IHv2boA/tZKcg2YKHvyns8uPZgq+Desi9Yft6dkx0kwb1X6UpJKnJ9YbVAAXAi+a9ZwUe/kONiIzFI=
X-Received: from plxm1.prod.google.com ([2002:a17:902:db01:b0:214:bcea:1b7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120e:b0:215:5d8c:7e46
 with SMTP id d9443c01a7336-218c9262f10mr21055695ad.27.1734400421608; Mon, 16
 Dec 2024 17:53:41 -0800 (PST)
Date: Mon, 16 Dec 2024 17:53:40 -0800
In-Reply-To: <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
Mime-Version: 1.0
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
Message-ID: <Z2DZpJz5K9W92NAE@google.com>
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 Kai Huang <kai.huang@intel.com>, 
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, 
 Yan Y Zhao <yan.y.zhao@intel.com>, 
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3pdlgZwYKCh4M84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Dec 10, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-12-10 at 11:22 +0800, Xiaoyao Li wrote:
> > > The solution in this proposal decreases the work the VMM has to do, b=
ut
> > > in the long term won't remove hand coding completely. As long as we a=
re
> > > designing something, what kind of bar should we target?
> >=20
> > For this specific #VE reduction case, I think userspace doesn't need to=
=20
> > do any hand coding. Userspace just treats the bits related to #VE=20
> > reduction as configurable as reported by TDX module/KVM. And userspace=
=20
> > doesn't care if the value seen by TD guest is matched with what gets=20
> > configured by it because they are out of control of userspace.
>
> Besides a specific problem, here reduced #VE is also an example of increa=
sing
> complexity for TD CPUID. If we have more things like it, it could make th=
is
> interface too rigid.

I agree with Rick in that having QEMU treat them as configurable is going t=
o be
a disaster.  But I don't think it's actually problematic in practice.

If QEMU (or KVM) has no visibility into the state of the guest's view of th=
e
affected features, then it doesn't matter whether they are fixed or configu=
rable.
They're effectively Schr=C3=B6dinger's bits: until QEMU/KVM actually looks =
at them,
they're neither dead nor alive, and since QEMU/KVM *can't* look at them, wh=
o cares?

So, if the TDX Module *requires* them to be set/cleared when the TD is crea=
ted,
then they should be reported as fixed.  If the TDX module doesn't care, the=
n they
should be reported as configurable.  The fact that the guest can muck with =
things
under the hood doesn't factor into that logic.

If TDX pulls something like this for features that KVM cares about, then we=
 have
problems, but that's already true today.  If a feature requires KVM support=
, it
doesn't really matter if the feature is fixed or configurable.  What matter=
s is
that KVM has a chance to enforce that the feature can be used by the guest =
if
and only if KVM has the proper support in place.  Because if KVM is complet=
ely
unaware of a feature, it's impossible for KVM to know that the feature need=
s to
be rejected.

This isn't unique to TDX, CoCo, or firmware.  Every new feature that lands =
in
hardware needs to either be "benign" or have the appropriate virtualization
controls.  KVM already has to deal with cases where features can effectivel=
y be
used without KVM's knowledge.  E.g. there are plenty of instruction-level
virtualization holes, and SEV-ES doubled down by essentially forcing KVM to=
 let
the guest write XCR0 and XSS directly.

It all works, so long as the hardware vendor doesn't screw up and let the g=
uest
use a feature that impacts host safety and/or functionality, without the hy=
pervisor's
knowledge.

So, just don't screw up :-)

