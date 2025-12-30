Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD201EE4998
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 20:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vag89-0000kH-8b; Tue, 30 Dec 2025 15:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vag86-0000jv-9I
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:15:43 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vag84-0002ZX-KL
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:15:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0862B60017;
 Tue, 30 Dec 2025 20:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77299C4CEFB;
 Tue, 30 Dec 2025 20:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767125738;
 bh=opQfLCIYNafdoLf23V7iyJK7TLZMf+tBXDvDpvOItRY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X26bijJRNSfgCfnlTGLO29hkDKAN10XBlT2RFv8D4aE4ruuh1VurfJmz191oxAqQm
 9tsOxI2jAYqEuGZ6ktEu5KAYCQikP8v5ka74mP43FXevmmkl7xw/XEDpZ9vK7Zoi1t
 s0BL3wJb4McdINH5z3yPrJ01XrmUqxlrDH/sk+7el2DACJH94z+xGrevwwuMdhax4r
 QXdiCQl+we6PkzI9p6n7bBGVCb6hKnpx7H5bamj7umjac9s4SpWYZY+RubX/e9Ihsh
 jNOtcHYtT3XmAjNoXe/aepYFkO4EEBSy777Jbwk1sAQk17O9KYLsou8XBPyuozTp84
 Cab1jhchAEGxw==
Message-ID: <55ed0c12-222f-4474-a21f-ac0703d2b77c@kernel.org>
Date: Tue, 30 Dec 2025 21:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
To: Gregory Price <gourry@gourry.net>,
 "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, jonathan.cameron@huawei.com,
 Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
 <8123efd8-73cc-4dfa-9f1e-6d9a95f66984@amd.com>
 <aVPcT_APo6SgRrGU@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aVPcT_APo6SgRrGU@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/30/25 15:06, Gregory Price wrote:
> On Tue, Dec 30, 2025 at 10:55:02AM +0800, Huang, FangSheng (Jerry) wrote:
>> Hi Gregory,
>>
>>> Sorry i've missed prior versions, is numa the right place to put this,
>>> considering that the node is not necessarily 100% SPM on a real system?
>>>
>>
>> The decision to add `spm=` to NUMA rather than the memory backend was based
>> on
>> earlier feedback from David during our initial RFC discussions.
>>
>> David raised a concern that if we put the spm flag on the memory backend, a
>> user
>> could accidentally pass such a memory backend to DIMM/virtio-mem/boot
>> memory,
>> which would have very undesired side effects.
>>
> 
> This makes sense, and in fact I almost wonder if we should actually
> encode a warning in linux in general if a signal NUMA node contains
> both normal and SPM.  That would help drive consistency between QEMU/KVM
> and real platforms from the direction of linux.

Yeah, in theory we would have a "memory device" for all boot memory 
(boot DIMM, not sure ...) and that one would actually be marked as "spm".

It's not really a thing of a memory backend after all, it's only how 
that memory is exposed to the VM.

And given we don't have a boot memory device, the idea was to set it for 
the Node, where it means "all boot memory is SPM". And we only allow one 
type of boot memory (one memory backend) per node in QEMU.

The tricky question is what happens with memory hotplug (DIMMs etc) on 
such a node. I'd argue that it's simply not SPM.

> 
>>> (in practice it should be, but not technically required to be)
>>
>> You're right that on a real system, a NUMA node is not technically required
>> to
>> be 100% SPM. However, in AMD's use case, the entire NUMA node memory (backed
>> by
>> memdev) is intended to be SPM, and this approach provides a cleaner and
>> safer
>> configuration interface.
>>
> 
> I figured this was the case, and honestly this just provides more
> evidence that any given NUMA node probably should only have 1 "type" of
> memory (or otherwise stated: uniform access within a node, non-uniform
> across nodes).

That makes sense.

> 
> ---
> 
> bit of an aside - but at LPC we also talked about SPM NUMA nodes:
> https://lore.kernel.org/linux-mm/20251112192936.2574429-1-gourry@gourry.net/
> 
> Would be cool to be able to detect this in the drivers and have hotplug
> automatically mark a node SPM unless a driver overrides it.
> (MHP flag? Sorry David :P)

:)

If it's a per-node thing, MHP flags feel a bit like "too late". It 
should be configured earlier for the node somehow.

> 
>>>
>>> ~Gregory
>>
>> Please let me know if you have further concerns or suggestions.
>>
> 
> I'll look at the patch details a bit more, but generally I like the
> direction - with an obvious note that I have a biased given the above.


Thanks for taking a look!


-- 
Cheers

David

