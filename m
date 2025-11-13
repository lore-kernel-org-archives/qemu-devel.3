Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1FBCD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJfFX-0001DK-E7; Thu, 13 Nov 2025 16:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJepR-0004lc-Tr
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJepP-0006Tn-0H
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763069156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yacu2kAq6mCxGDCoRrig1a9AYc/bVZMxL2WjwmoFmGE=;
 b=OgKgp89MVRId357o8yI1ToVLbHGuwxnWlz6qu0WAsFn93+fMjI9r4pMJ3+3PC5D0Mfo/qK
 u/6z1onl87uDDpjcGTUg39pP+oosmWLgGMKZFgg4v9Yam8O8+lS+9+xI1SbzzFb4hyHhE6
 dxdQhPzOK09whyLy3DBYhQ4seyB91cE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-vyCSkW2eMRGJJ0k30g1u6Q-1; Thu, 13 Nov 2025 16:25:55 -0500
X-MC-Unique: vyCSkW2eMRGJJ0k30g1u6Q-1
X-Mimecast-MFC-AGG-ID: vyCSkW2eMRGJJ0k30g1u6Q_1763069154
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed6ceab125so36915111cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763069154; x=1763673954; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yacu2kAq6mCxGDCoRrig1a9AYc/bVZMxL2WjwmoFmGE=;
 b=hnqcPKcqbJ9oVXFMwBrp0xi3uuzsgir5L0sueIRpsw3IORAo/CgST81Hpgtu0MozAO
 cqAadBSvoi9qLI4w4a9ozl5plr9xFY/GBBr0E/3x/J8PbDeZzj605jD5Aow0+U13jIo7
 Qv2X1St+lsAwISPwLOP2BEqA7jNak4O4Jak0b+3z2RUWrDwzuQDK5cEEP5oDYVj2fT1h
 x6p/+R1QW0/ER8V6AOdtIGnANufv3/YknG05pFh9zLjUpmLt4QtHfOH/LqZTC63kRsVA
 /vX3n25bjAf1VouxujOOtYkB4pnWKOTDvwdDwV1LJTKrzTDvZoLU2n0WKeqDBxkq33X/
 7PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763069154; x=1763673954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yacu2kAq6mCxGDCoRrig1a9AYc/bVZMxL2WjwmoFmGE=;
 b=VCats6AfCwAW+3C+r73V1voNPFu0aRdK5IbGulyKFG5kk1fO1zHXpTsjmHsLQrQ8y4
 bRE1ebXZsk8wKqjaT8MRPmuHaboXnvJLRDNwFPLGkqVk48DGAt3xXy59WAxtuScTVI1d
 TAQnP6ADXiLa2I3z3C93t0DosC/FAgMKP9aPjKAIXzVDaUR929Z0onkWl04eR9S6fATv
 2sPzP4OACmc+cucEL7qYnfcA6SEBXtkyc2l6Tkeuvu48c0LuV8h63SmLV/ukS3YlAbCi
 tYXAR6kYI+D9GKKV6xEp77og1/t8OUYow56EfBGIbRVwTnjkmgmVEdhtnnV/ys5DywgS
 qyIw==
X-Gm-Message-State: AOJu0YwYoXTE//Om+Fc4vEyWWPHK1B5U4ZpgWgOYtt5ytG6XfWYbi4NK
 l4hBHSfE/YV5aE8i7WIRJiNT70tJm49d8JZ++wFcQegPvIaugSJgRMCN/3kDi+mJDJurUFun1J1
 MuyRDw2IumR6y8Ww3XOx7A974Y9n+fYgYXwQTq5TdjPMNGtrvzcKDxqck
X-Gm-Gg: ASbGncvuhH66OPv9OPESriwf0b2IlX4NU1Y3x53jD8D302jLaP1Zu4olw3zNehkVuN5
 Aok+wQIm0bY891gjpEpn9CNhkPvSMN00iZZv+uxw2GLvl5dJ9V0DH8SUDziQCeDSpWBfdRdrdZu
 KSs5lTcT/SM7kap/8tWJR4XzOuZz6yCWrCyHHHNPJRxU1F5MLEciSzRNrDrLGVVMDoK+s3xswfZ
 sML+ZJFcXlZ7WMlMD7KnANrfUgyOQsl7oWGLV0u0nHK7BjM9idFj3lltXPSX33SU8YjPtx8FC+F
 W31mC1B+dE3USKDC+6oRdiRPPu5nLTONMn4aI8Km6nrvwSZ5JTaB4K+AuSBZvxzeXaZkAseLMMo
 DAw==
X-Received: by 2002:ac8:5888:0:b0:4ed:bbca:fdec with SMTP id
 d75a77b69052e-4edf2048486mr20166311cf.16.1763069154397; 
 Thu, 13 Nov 2025 13:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG7adQ+To1sVTkWH9kHmWTxIW7v+qGjRIswi48je30/xk/DlGdUNhUX3w4qos3uFEoeFPyIQ==
X-Received: by 2002:ac8:5888:0:b0:4ed:bbca:fdec with SMTP id
 d75a77b69052e-4edf2048486mr20165981cf.16.1763069153946; 
 Thu, 13 Nov 2025 13:25:53 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aef2fa3bsm204086285a.36.2025.11.13.13.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:25:53 -0800 (PST)
Date: Thu, 13 Nov 2025 16:25:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 4/8] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Message-ID: <aRZM3TyRU_kqcpVl@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-5-peterx@redhat.com>
 <872f9349-7d3d-4b7b-9ba9-bcbc44c9afe5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <872f9349-7d3d-4b7b-9ba9-bcbc44c9afe5@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 24, 2025 at 05:17:20PM +0800, Xiaoyao Li wrote:
> On 10/24/2025 2:59 AM, Peter Xu wrote:
> > This name is too generic, and can conflict with in-place guest-memfd
> > support.  Add a _PRIVATE suffix to show what it really means: it is always
> > silently using an internal guest-memfd to back a shared host backend,
> > rather than used in-place.
> > 
> > This paves way for in-place guest-memfd, which means we can have a ramblock
> > that allocates pages completely from guest-memfd (private or shared).
> 
> It's for patch 4-7. Regarding the rename. How about:
> 
> - RAM_GUEST_MEMFD => RAM_PRIVATE_MEMORY
> - backend->guest_memfd => backend->private_memory
> - machine_require_guest_memfd() => machine_require_private_memory()
> - cgs->require_guest_memfd => cgs->require_private_memory
> 
> For CoCo VMs, what they require is the support of private memory, while the
> guest_memfd is how linux provides private memory support. But with mmap
> support added to guest memfd, it can serve as shared/non-private memory as
> well. Futher, in the future when in-place conversion support is implemented,
> a single guest memfd can serve as both shared and private in different
> parts. So guest_memfd_private will be confusing at that time.

That's more or less a valid point.

Said so, I think PRIVATE_MEMORY is confusing too v.s. RAM_PRIVATE.  See:

commit 6169f1193657d0ba630a2ce33cef639ae918bce4
Author: Steve Sistare <steven.sistare@oracle.com>
Date:   Wed Jan 15 11:00:31 2025 -0800

    memory: add RAM_PRIVATE

Not to mention its possible confusion against mmap(MAP_PRIVATE) which is
even more well known (where here RAM_PRIVATE is exactly about it).

It'll not be a concern until private gmemfd will start to back shared
memories, even if it happens (I believe it will, a matter of time..) IMHO
it's still fine to use guest_memfd_private, because here private describes
that the fd is a private FD (not the memory is private).  It's private
because it's hidden inside each ramblock that matters.  Then a fd that is
private can still back shared memories.

Would you mind I keep everything as-is for now?

Thanks,

-- 
Peter Xu


