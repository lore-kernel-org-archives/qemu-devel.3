Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39383D2C561
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3G8T-00077w-2X; Tue, 22 Oct 2024 10:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3G8N-00073p-Th
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:45:20 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3G8K-0000iU-TR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729608317; x=1761144317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=S6MBMjJ2N2EXgvrAo/JrbK5lxLqIJx4tC3P69bnXXww=;
 b=ZFglwkv+MrWFRhYQLmlds4xG4YC2go9JjGgFLVHk0X1wsc44kgSZ9IqO
 n2alMrxWcrLHUnGBh1swPD9sFdARXBYIrP05LMFUz7qh1TUBzfDzGsOBw
 hiDaKofCgFRUDVv8xopRqZkWqiG0fJKilITlNFgT2tSjmUyCrYbqYvvZu
 xKpCf0haAvB2VpnOmPLLQ9GYn9Ss6rGJhbHHHQObejUSVB3HYhz1dEEEG
 UEPhiRzIxQn/iAmnC/c8xc8pqkwHVCmfZamc25yea6f0pyskxs/WIiRPD
 psQdrhJjOruYpDC1PO3vDavN2wrYc25qOzSeMXUUcoV4MHAR3Cl28/LCU w==;
X-CSE-ConnectionGUID: 3Fe5M/5qRqKc4TGKfyvLbQ==
X-CSE-MsgGUID: sdZKwAFNQUS3F6ARl59vRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16775126"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="16775126"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 07:45:14 -0700
X-CSE-ConnectionGUID: hfsQmgbHRveLzsq30iZLTQ==
X-CSE-MsgGUID: JS2GXUg8RE2so2ytPavvIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="84710655"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 22 Oct 2024 07:45:12 -0700
Date: Tue, 22 Oct 2024 23:01:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <Zxe+SZmtJ7XJ49IY@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
 <ZxZ2KS6hi3Y2HdtC@intel.com>
 <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.519, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Mon, Oct 21, 2024 at 05:47:05PM +0100, Peter Maydell wrote:
> Date: Mon, 21 Oct 2024 17:47:05 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Mon, 21 Oct 2024 at 16:25, Zhao Liu <zhao1.liu@intel.com> wrote:
> > My initial confusion stemmed from seeing the private comment and
> > noticing that there are many direct accesses to parent_obj/parent_class
> > in QEMU (which I could list in my reply to Daniel). Now I understand
> > that these examples are only valid within the class/object
> > implementation or in QOM code.
> >
> > For instance, an example in KVM is a misuse:
> >
> > accel/kvm/kvm-all.c:4285:                        cpu->parent_obj.canonical_path,
> > accel/kvm/kvm-all.c:4377:            if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {
> >
> >
> > At the same time, I¡¯ve been thinking that the current C implementation
> > seems to have no way to prevent such misuse.
> 
> Mmm. We rely on code review to catch major misuses (and let
> some minor misuses slide because we don't care enough to put
> in the effort to provide a proper API to access the information
> or because we don't want the performance overhead of a QOM cast).
> 
> In a previous iteration of QEMU's design the device's state
> struct was purely private to the implementation source file,
> and code that used the device always did so via a pointer.
> But at some point we decided we wanted to allow users to
> embed the device struct inside their own device struct, which
> needs them to have access to the struct definition (though
> strictly they only need to know the size and alignment
> requirements of it).

Thank you for taking me through this history, I see the intent of
designing the embedded device structure in this way!

> I did a decade ago write a proof-of-concept for marking
> fields in the C struct as "private" such that you could get
> a compile error for touching them:
> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg01846.html
> which (mis?)uses GCC's __attribute__((deprecated("reason")))
> to arrange that touching the struct field from outside the
> implementation is a compile error. But we never took up the idea.

Very cool! May I ask a few more questions? :-) The feedback on this
series looks very positive, and it seems you were almost close to merge
it at the time. What ultimately led you to decide against it? If we
revisit the issue of Rust's private/pub visibility, I'm curious if we
would face the same dilemma again.

Regards,
Zhao


