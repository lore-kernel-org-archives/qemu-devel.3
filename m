Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5667EE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 12:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU3cu-00087F-DJ; Sat, 04 Jan 2025 07:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tU3cs-00086g-7r; Sat, 04 Jan 2025 07:51:34 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tU3cp-0007h4-83; Sat, 04 Jan 2025 07:51:33 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id EC9B5A00FD; Sat,  4 Jan 2025 13:51:16 +0100 (CET)
Date: Sat, 4 Jan 2025 13:51:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v5 1/2] memory: Update inline documentation
In-Reply-To: <20250104-san-v5-1-8b430457b09d@daynix.com>
Message-ID: <alpine.LMD.2.03.2501041339480.29930@eik.bme.hu>
References: <20250104-san-v5-0-8b430457b09d@daynix.com>
 <20250104-san-v5-1-8b430457b09d@daynix.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Sat, 4 Jan 2025, Akihiko Odaki wrote:
> Do not refer to "memory region's reference count"
> -------------------------------------------------
>
> Now MemoryRegions do have their own reference counts, but they will not
> be used when their owners are not themselves. However, the documentation
> of memory_region_ref() says it adds "1 to a memory region's reference
> count", which is confusing. Avoid referring to "memory region's
> reference count" and just say: "Add a reference to a memory region".
> Make a similar change to memory_region_unref() too.
>
> Refer to docs/devel/memory.rst for "owner"
> ------------------------------------------
>
> memory_region_ref() and memory_region_unref() used to have their own
> descriptions of "owner", but they are somewhat out-of-date and
> misleading.
>
> In particular, they say "whenever memory regions are accessed outside
> the BQL, they need to be preserved against hot-unplug", but protecting
> against hot-unplug is not mandatory if it is known that they will never
> be hot-unplugged. They also say "MemoryRegions actually do not have
> their own reference count", but they actually do. They just will not be
> used unless their owners are not themselves.
>
> Refer to docs/devel/memory.rst as the single source of truth instead of
> maintaining duplicate descriptions of "owner".
>
> Clarify that owner may be missing
>
> ---------------------------------
> A memory region may not have an owner, and memory_region_ref() and
> memory_region_unref() do nothing for such.

The commit message is longer than the documentation it changes :-) That 
probably means the docs could be more detailed. For example this relation 
to the owner may be mentioned unless it's something to be changed in the 
future to clean this up.

> memory: Clarify owner must not call memory_region_ref()
> --------------------------------------------------------
>
> The owner must not call this function as it results in a circular
> reference.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> include/exec/memory.h | 22 +++++++---------------
> 1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9458e2801d50..cd91fe0c51cf 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1220,29 +1220,21 @@ void memory_region_init(MemoryRegion *mr,
>                         uint64_t size);
>
> /**
> - * memory_region_ref: Add 1 to a memory region's reference count
> + * memory_region_ref: Add a reference to a memory region
>  *
> - * Whenever memory regions are accessed outside the BQL, they need to be
> - * preserved against hot-unplug.  MemoryRegions actually do not have their
> - * own reference count; they piggyback on a QOM object, their "owner".
> - * This function adds a reference to the owner.
> - *
> - * All MemoryRegions must have an owner if they can disappear, even if the
> - * device they belong to operates exclusively under the BQL.  This is because
> - * the region could be returned at any time by memory_region_find, and this
> - * is usually under guest control.
> + * This function adds a reference to the owner if present.

Maybe it's just not clear to me but the title says "Add a reference to a 
memory region" then here it says "adds a reference to the owner" and does 
not say what happens if there's no owner present. Maybe it's better to be 
explicit and say add 1 to the owner's ref count or do nothing if owner is 
not present.

> + * The owner must not call this function as it results in a circular reference.
> + * See docs/devel/memory.rst to know about owner.
>  *
>  * @mr: the #MemoryRegion
>  */
> void memory_region_ref(MemoryRegion *mr);
>
> /**
> - * memory_region_unref: Remove 1 to a memory region's reference count
> + * memory_region_unref: Remove a reference to a memory region
>  *
> - * Whenever memory regions are accessed outside the BQL, they need to be
> - * preserved against hot-unplug.  MemoryRegions actually do not have their
> - * own reference count; they piggyback on a QOM object, their "owner".
> - * This function removes a reference to the owner and possibly destroys it.
> + * This function removes a reference to the owner and possibly destroys it if
> + * present. See docs/devel/memory.rst to know about owner.

In "destroys it if present" it's not clear what "it" refers to as it can 
either be the memory region or the owner. I guess it's the owner but 
better state that to avoid confusion.

Regards,
BALATON Zoltan

>  *
>  * @mr: the #MemoryRegion
>  */
>
> -- 
> 2.47.1
>
>

