Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDAFE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 22:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVbL-0000N4-AJ; Wed, 11 Dec 2024 17:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLVbI-0000MZ-VE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLVbG-0000Rz-OT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733957672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok0oy60I7XJpzKdSAh2EJYjdJbwe+pyyu2UMlis/MLw=;
 b=d6S1aOPScfy12VfV2TZdY0Eo0bZOBqmfXER1pNaUUoEh5cC4JKWiedEmO8SV6TbXzlH4v9
 Oa7o2iMG1a85jbW9g+QCLWrJ8ViHELOfVm1ktIrqlIX+01TMZaCqVRloC/LyPpy23TSd7V
 Y4YjJEW/dJs/LMjfMQvdKE9ATuTsDUk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-lRoAZgtBPUq0vrte3psHpA-1; Wed, 11 Dec 2024 17:54:29 -0500
X-MC-Unique: lRoAZgtBPUq0vrte3psHpA-1
X-Mimecast-MFC-AGG-ID: lRoAZgtBPUq0vrte3psHpA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8860ab00dso138276d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 14:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733957669; x=1734562469;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ok0oy60I7XJpzKdSAh2EJYjdJbwe+pyyu2UMlis/MLw=;
 b=YSXGQylBf16Dks5Pqi67xsv1Q1so1DTuf80k4bNh/iUNXxxerNHRwCE773Bpl9E4Uv
 fCrAuFaqbK4JyuvnBse8pxiEkZAEueUsbXPfFK9BAwsrM6qfPSWJFL8ErBjJ7WBb1Ip+
 nsTZsBFs8l70s1Y7zDRtTsLBFAGPIChgQ1YGFWyuQlB1Q6TUEhnvanIK1zoXpnfi+n1Y
 cCxB8ARmg0Eset812yf32K+9ZKSdYtvSfkhAq0UkSwcOAJRuanPHGNyfnR5s2iQQULuC
 udbgoXXu19idzoPnLKUaXkMeBrweqMzzhyBykxNgWFWywQvU/BZ55TQsDzzpZ/9crV+2
 Wssw==
X-Gm-Message-State: AOJu0Yx+79LwPE5ZXJnNNziZY88shZbzUInukKzTh2EKh6EXevqo6Knd
 OnustXH8TNLHANMbCujZOmJv0U6abghNqfp1+Djnfg3a+PbBaTS5O5s1x/3CcjuUAnaVmPn5oi3
 XQ7BQ6xm9v9+Xy6uQEWkYbBTR1QCueE8L27iUUfmO1OdTUJYglJUM
X-Gm-Gg: ASbGncvGgM2sGHVDhLigFT168MnRzd2eFo//pJYUf4kaVOMpcO86d1b4tf6QPtWjwS5
 go3/8laVQTY7OWWgXvysUOBpt6jZbZ0zIFIixGg4DGyV1jggmuEe9xi0jegOdjVXLtJQb1VbHO8
 YYay6kQ1KGEXThLPg47S5YOZRQyHB7bqErFQp2fcNlXhc+BXUBIs8KQZXJdx9GLXqudT3E2vxkB
 s5ORTEsnxstHkhyZZ0w3UMmd/BexPgEYMwKjOCR3+wmlfENTPdFuvZbj+JRtA8z/1IF3RSItQq4
 90lKmEjx2yNF3Wo=
X-Received: by 2002:a05:6214:1249:b0:6d8:8f14:2f5b with SMTP id
 6a1803df08f44-6dae391c144mr19412056d6.19.1733957669254; 
 Wed, 11 Dec 2024 14:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFys4iuR7newMRPgjlbLRiGz5J7uRasMtUKhF0xPOhaRM1lGRz+84VHOvt9V61nMsNCRucDsg==
X-Received: by 2002:a05:6214:1249:b0:6d8:8f14:2f5b with SMTP id
 6a1803df08f44-6dae391c144mr19411726d6.19.1733957668887; 
 Wed, 11 Dec 2024 14:54:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da696aa2sm75276026d6.42.2024.12.11.14.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:54:28 -0800 (PST)
Date: Wed, 11 Dec 2024 17:54:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z1oYIn5cMZeA4tes@x1n>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
 <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
 <Z1MpY7ZIAAoBDbZU@x1n>
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 11, 2024 at 06:35:57PM +0900, Tomoyuki HIROSE wrote:
> Sorry for late reply.
> 
> On 2024/12/07 1:42, Peter Xu wrote:
> > On Fri, Dec 06, 2024 at 05:31:33PM +0900, Tomoyuki HIROSE wrote:
> > > In this email, I explain what this patch set will resolve and an
> > > overview of this patch set. I will respond to your specific code
> > > review comments in a separate email.
> > Yes, that's OK.
> > 
> > > On 2024/12/03 6:23, Peter Xu wrote:
> > > > On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
> > > > > The previous code ignored 'impl.unaligned' and handled unaligned
> > > > > accesses as is. But this implementation could not emulate specific
> > > > > registers of some devices that allow unaligned access such as xHCI
> > > > > Host Controller Capability Registers.
> > > > I have some comment that can be naive, please bare with me..
> > > > 
> > > > Firstly, could you provide an example in the commit message, of what would
> > > > start working after this patch?
> > > Sorry, I'll describe what will start working in the next version of
> > > this patch set. I'll also provide an example here.  After applying
> > > this patch set, a read(addr=0x2, size=2) in the xHCI Host Controller
> > > Capability Registers region will work correctly. For example, the read
> > > result will return 0x0110 (version 1.1.0). Previously, a
> > > read(addr=0x2, size=2) in the Capability Register region would return
> > > 0, which is incorrect. According to the xHCI specification, the
> > > Capability Register region does not prohibit accesses of any size or
> > > unaligned accesses.
> > Thanks for the context, Tomoyuki.
> > 
> > I assume it's about xhci_cap_ops then.  If you agree we can also mention
> > xhci_cap_ops when dscribing it, so readers can easily reference the MR
> > attributes from the code alongside with understanding the use case.
> > 
> > Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
> > can be changed to 2 (together with additional xhci_cap_read/write support)?
> > 
> > Note that I'm not saying it must do so even if it would work for xHCI, but
> > if the memory API change is only for one device, then it can still be
> > discussed about which option would be better on changing the device or the
> > core.
> > 
> > Meanwhile, if there's more use cases on the impl.unaligned, it'll be nice
> > to share together when describing the issue.  That will be very persuasive
> > input that a generic solution is needed.
> OK, I understand. I will try to describe 'xhci_cap_ops' and related topics.

Thanks.

> Currently, the actual 'xhci_cap_ops' code is as follows:
> 
> ```
> static const MemoryRegionOps xhci_cap_ops = {
>     .read = xhci_cap_read,
>     .write = xhci_cap_write,
>     .valid.min_access_size = 1,
>     .valid.max_access_size = 4,
>     .impl.min_access_size = 4,
>     .impl.max_access_size = 4,
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
> ```
> 
> According to the above code, the guest can access this MemoryRegion
> with 1-4 bytes.  'valid.unaligned' is also not explicitly defined, so
> it is treated as 'false'. This means the guest can access this MR with
> 1-4 bytes, as long as the access is aligned. However, the xHCI
> specification does not prohibit unaligned accesses.
> 
> Simply adding '.valid.unaligned = true' will not resolve this problem
> because 'impl.unaligned' is also 'false'. In this situation, where
> 'valid.unaligned' is 'true' but 'impl.unaligned' is 'false', we need
> to emulate unaligned accesses by splitting them into multiple aligned
> accesses.

Correct.

> 
> An alternative solution would be to fix 'xhci_cap_{read,write}',
> update '.impl.min_access_size = 1', and set '.impl.unaligned = true'
> to allow the guest to perform unaligned accesses with 1-4 bytes. With
> this solution, we wouldn't need to modify core memory code.
> 
> However, applying this approach throughout the QEMU codebase would
> increase the complexity of device implementations. If a device allows
> unaligned guest access to its register region, the device implementer
> would needs to handle unaligned accesses explicitly. Additionally,
> the distinction between 'valid' and 'impl' would become almost
> meaningless, making it unclear why they are separated.

I get it now, let's stick with the core memory change.

> 
> "Ideally", we could consider one of the following changes:
> 
> 1. Introduce an emulation mechanism for unaligned accesses using
>    multiple aligned accesses.
> 2. Remove either 'valid' or 'impl' and unify these functionality.
> 
> Solution 2 would require extensive changes to the codebase and memory
> API, making it impractical. 

Why it is impractical?  Let me explain my question..

Firstly, valid.unaligned makes perfect sense to me.  That describes whether
the device emulation allows unaligned access at all.  So I do think we need
this, and yes when xHCI controller supports unaligned access, this is the
flag to be set TRUE instead of FALSE.

However, impl.unaligned is confusing to me.

From literal POV, it says, "the MR ops implemented unaligned access".

If you check my initial reply to this patch, I had a similar question: from
such definition, whenever a device emulation sets impl.unaligned=true, I
think it means we should simply pass over the MR request to the ops, no
matter if it's aligned or not, especially when it's not aligned memory core
shouldn't need to do any trick on amplifying the MR access, simply because
the device said it supports unaligned access in its implementation.  That's
the only meaningful definition of impl.unaligned that I can think of so far.

However, after I try to read more of the problem, I don't think any MR ops
would like to implement such complicated logic, the norm should be like
xHCI MR ops where it supports only aligned access in MR ops, then the
memory core is hopefully always be able to convert an unaligned access into
one or multiple aligned access internally.

IOW, it makes more sense to me that we keep valid.unaligned, but drop
impl.unaligned.  Would that make sense to you (and Peter)?  That kind of
matches with the comment you quoted below on saying that unaligned access
is broken - I'm not 100% sure whether it's talking about impl.unaligned,
but it would make sense if so.

Meanwhile, I do see that we already have two impl.unaligned=true users:

hw/pci-host/raven.c:    .impl.unaligned = true,
system/ioport.c:    .impl.unaligned = true,

I actually have no idea whether they're working at all if accesses can be
unaligned internally, and how they work, if at least impl.unaligned seems
to be totally broken.

> Solution 1 seems to align with QEMU's
> original intentions. Actually, there is a comment in 'memory.c' that
> states:
> 
> `/* FIXME: support unaligned access? */`
> 
> This patch set implements solution 1. If there is a better way to
> resolve these issues, I would greatly appreciate your suggestions.

I think if my above understanding is correct, I can kind of understand your
solution now.  But then I wonder whether we should already drop
impl.unaligned with your solution.

Also, I don't think I am 100% sure yet on how the amplification of the
accessed (as proposed in your patch) would have side effects to the device
emulation.  For example, read(0x2, 0x4) with impl.access_size_min=4 now
will be amplified to two continuous:

  read(0x0, 0x4)
  read(0x4, 0x4)

Then there will be side effects of reading (addr=0x0, size=0x2) portion,
and (addr=0x6, size=0x2) portion, that is not part of the request.  Maybe
it's as simple as: when device emulation has such side effect, it should
always set valid.unaligned=false already.

Thanks,

-- 
Peter Xu


