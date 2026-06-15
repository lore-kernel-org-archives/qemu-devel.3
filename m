Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B126ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ61g-0003jg-Dg; Mon, 15 Jun 2026 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ61X-0003iK-U9; Mon, 15 Jun 2026 08:02:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ61U-0000Y1-FK; Mon, 15 Jun 2026 08:02:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65FC2D1N056721
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 21:02:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p8rXig4gDHxPTyqB9Cd84YNxjr7q6srB9SzLAnhnxK4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781524933; v=1;
 b=TvjnA/rHehIH7xJVK+6+5qmWRVbx+UuoF1ncudfuHG+X+1SjD7W8ak6Mh1m5gnOs
 MyiA6KXWwtxYgEkY8bUCmFmMwmINA/ftVIgct4WrAhSwFvRSYGtBqhgcuzp29OWc
 1QpgPPSTAyFh58tLregyLv5AboIlrTHo0i4pHBVQO/6PZIfzOfDGwdNhioWbXIpS
 5GhLopCnQR9khlcspN1X7B3NUbfxpLnBUkHHkVf+DnyAeG+tAtejG/RCIXFCBlxe
 AGe9Rxp2cBdyFuy/iIGo4OE4Vrpj9/bto9ChqmPpVKRD2KWUyMveqva8xdOsJtNw
 Vpgf1q6f+F69KhEc4ftqZw==
Message-ID: <48a2ec70-8995-40c5-8224-aa82f267e9dc@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 21:02:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai_bEg7Qo_6kQ2Zq@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ai_bEg7Qo_6kQ2Zq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/15 19:59, Daniel P. Berrangé wrote:
> On Mon, Jun 15, 2026 at 01:11:07PM +0900, Akihiko Odaki wrote:
>> One concrete case is qemu-xhci: XHCIPciState embeds XHCIState as a
>> child object, and the embedded XHCIState owns the MemoryRegion used for
>> PCI BAR 0. When memory core references that region, memory_region_ref()
>> references the embedded XHCIState owner, but that does not keep the
>> containing XHCIPciState storage alive across runtime unplug.
> 
> Taking this example and looking at the patch,
> 
> Immediately after XHCIPciState is allocated, we'll have the
> following XHCIPciState QOM state:
> 
>     free == object_free
>     storage == <undefined>
>     ref == 1
>     storage_ref == 1   <up-ref from XHCIState>

It should be:

     ref == 0
     storage_ref == 1

Please see "[PATCH 1/2] qom: Reject temporary object resurrection" for 
the context. `Object::ref` stores the logical reference count minus one, 
so `ref == 0` means one reference remains.

`storage_ref` follows the same convention for non-embedded storage. 
Here, `storage_ref == 1` means two storage references: the storage's own 
lifetime reference, plus the reference held via the embedded XHCIState.

> 
> Meanwhile XHCIState is embedded and so after construction it
> has
> 
>     free == <undefined>
>     storage == ptr<XHCIPciState>
>     ref == 1
>     storage_ref == UINT32_MAX

`ref == 0` here too.

> 
> 
> The simple scenario, no 3rd party refs on XHCIState, then we
> have a flow that looks like this:
> 
>    object_unref(XHCIPciState)
>     => ref == 0

This makes `ref == UINT32_MAX`; that marks the object as being finalized.

>         => object_finalize(XHCIPciState)
>             => object_unref(XHCIState)
> 	       => ref == 0

This also makes `XHCIState.ref == UINT32_MAX`.

> 	       => object_storage_unref(XHCIState)
> 	            => obj = obj.storage
> 	            => XHCIPciState.storage_ref--
> 	            => XHCIPciState.storage_ref == 0

Yes. At this point there is still one storage reference left, represented
as `storage_ref == 0`: the storage's own lifetime reference, held by the
XHCIPciState finalization path itself.

>                      => object_free(XHCIPciState)

`obj->free()` does not happen when `XHCIPciState.storage_ref == 0`.

>         => Remainder of ...object_finalize(XHCIPciState) is
>            using free'd mem now...

The free happens only after `object_finalize(XHCIPciState)` reaches its
own final `object_storage_unref(XHCIPciState)`. That decrements
`XHCIPciState.storage_ref` from `0` to `UINT32_MAX`, and only then calls
`obj->free()`.

> 
> This doesn't seem to work AFAICS ?
> 
> Now lets consider something took a reference on XHCIState
> first.
> 
>    object_ref(XHCIState)
>    object_unref(XHCIPciState)
>     => ref == 0
>         => object_finalize(XHCIPciState)
>             => object_unref(XHCIState)
> 	       => ref == 1
>         => object_storage_unref(XHCIPciState)
>            => storage_ref--
>            => storage_ref == 0
>                => object_free(XHCIPciState)
> 
>    object_unref(XHCIState)
>     => ref == 0
>     => object_storage_unref(XHCIPciState)
>        => storage_ref == -1
> 
> Again this doesn't seem to actually work as billed ?

With the minus-one representation, this becomes:

     object_ref(XHCIState)
       => XHCIState.ref goes from 0 to 1

     object_unref(XHCIPciState)
       => XHCIPciState.ref goes from 0 to UINT32_MAX
       => object_finalize(XHCIPciState)
           => object_unref(XHCIState)
              => XHCIState.ref goes from 1 to 0
              => XHCIState is not finalized yet
           => object_storage_unref(XHCIPciState)
              => XHCIPciState.storage_ref goes from 1 to 0
              => no free yet

     object_unref(XHCIState)
       => XHCIState.ref goes from 0 to UINT32_MAX
       => object_finalize(XHCIState)
           => object_storage_unref(XHCIState)
              => follows XHCIState.storage to XHCIPciState
              => XHCIPciState.storage_ref goes from 0 to UINT32_MAX
              => object_free(XHCIPciState)

So the containing storage is not freed until both finalizers have
completed.

> 
> 
> For the sake of argument though, lets say this storage_ref
> was handled correctly such that we delay free'ing the
> XHCIPciState memory  until *both*  XHCIPciState and
> XHCIState have hit ref == 0, and both their finalize
> methods are completed.
> 
> I'm still not convinced this would actually be safe.
> 
> This patch is delaying the free'ing of the memory that
> XHCIState is embedded in, but is the embedded XHCIState
> still functional enough when its parent and all sibling
> objects will have been finalized already ? That is not
> obviously ok to me. The "XHCIPciState" will have been
> finalized, but all its fields are mostly pointing to
> data that has been deinitialized. Can we really assume
> there are no dependencies between the embedded objects ?

That concern is valid. Keeping the containing storage allocated does not 
by itself guarantee that the embedded object remains fully functional 
after its parent has started finalization. That is also why the Rust 
wrapper for `object_ref()` remains unsafe.

I think this is orthogonal to the storage lifetime problem this patch 
solves. The same functional-lifetime problem can exist even if XHCIState 
is not embedded and is allocated with `object_new()`, because it may 
still depend on state owned by the parent or by sibling objects.

This patch prevents freeing the memory backing an externally referenced 
embedded object. It does not claim that every object implementation is 
safe to operate after the parent has begun unrealize/finalization.

> 
> 
> Conceptually it feels like finalization of XHCIPciState
> ought to be an all-or-nothing affair, rather than
> finalizing XHCIPciState and some of its embedded children
> but arbtirarily keeping other children alive. I'm not
> sure how to arrange that though - its essentially a need
> for a circular reference, but then how/when do you break
> it.

I agree that all-or-nothing finalization is attractive conceptually, but 
I do not think it gives enough semantics once objects can refer to each 
other. We still need to define an ordering: for example, if a parent and 
an embedded child refer to each other, either the child is finalized 
first and must not be accessed by the parent afterwards, or the parent 
is finalized first and the child must not access the parent afterwards.

So the practical rule cannot just be "finalize the aggregate as one 
unit". We need explicit ordering and state transitions. In the case 
where the parent is finalized before an externally referenced child, the 
child may remain allocated, but it must treat the parent-side state as 
gone and avoid accessing it.

In the MemoryRegion case described in the commit message, one possible 
higher-level fix is exactly this kind of ordering rule: once the device 
is being unrealized, accesses through the device's memory regions should 
be forbidden or should fail gracefully. The MemoryRegion object may 
remain referenced for a while, but late accesses should not rely on the 
parent device still being operational.

Regards,
Akihiko Odaki

