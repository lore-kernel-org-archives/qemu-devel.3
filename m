Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB5EC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLRA-0007qI-0b; Wed, 08 Jul 2026 02:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1whLR8-0007q0-7P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:07:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1whLR5-0003pw-3Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:07:09 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66866uCq034227
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 8 Jul 2026 15:06:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qB7O9u8CVnCkiLzPZX4rPSnzB4T/RgM+DEwAthJ41WU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1783490816; v=1;
 b=vxts6c0MnUN4N8Rt4PwNoksHBzCvOzI+3C1DpW6hwEyx2mii/kAEZu2h19ZntH8y
 EzM5ZDQgdgdg0CKb2MMRJmeK0mo8DIgTXwmON9P2azhGm9CAW5mFT1QV6huc16iM
 xAnRfC2pwKz0MEwa4ejBx0TbZ4Y2fiSNgUpsOKEQLB0LDUdcLh4EQ4eMQ92zTXXD
 oYQAaqN6HWFHB2cMttHn3P0Jvyp8wzkISOKbOGLsKOg69dWgMuakbdc9nUepzO2y
 0udddiMC1BUYp+EYjh0UZ7KuSv8otgL8WxJ83KjUZPHRW45JlFWR0ofGsaGR+aYX
 ZPgxJdfQaPaNSgbyof54lA==
Message-ID: <696787d3-dc6f-49c9-bdb0-479f25eb4e96@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 8 Jul 2026 15:06:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 44/44] virtio-net: validate RSS indirections_len in
 post_load
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jason Wang <jasowangio@gmail.com>
References: <cover.1783261895.git.mst@redhat.com>
 <32a90850e1e4222091df07b4b46d5f46a8b90d24.1783261895.git.mst@redhat.com>
 <c8c320ce-af9f-47ee-b036-b408aa5d60be@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c8c320ce-af9f-47ee-b036-b408aa5d60be@tls.msk.ru>
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

On 2026/07/08 0:25, Michael Tokarev wrote:
> (Resending with correct new address of Akihiko Odaki.
>   Please excuse me for double post).
> 
> On 05.07.2026 17:36, Michael S. Tsirkin wrote:
>> From: Junjie Cao <junjie.cao@intel.com>
>>
>> virtio_net_handle_rss() enforces that indirections_len is a non-zero
>> power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
>> virtio_net_rss_post_load() applies none of these checks to values
>> restored from the migration stream.
>>
>> A corrupted save file or crafted migration stream can set
>> indirections_len to 0.  Even if it also clears redirect,
>> virtio_load() calls set_features_nocheck() after the device vmstate
>> (including the RSS subsection and its post_load) has already been
>> loaded, re-deriving redirect from the negotiated guest features.
>> When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
>> regardless of the migration stream value.  The receive path then
>> computes
>>
>>      hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int 
>> promotion */
>>
>> and uses the result to index into indirections_table, which was not
>> allocated by the VMState loader when the element count is zero (see
>> vmstate_handle_alloc()), resulting in a NULL pointer dereference that
>> crashes QEMU:
>>
>>    #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
>>    #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
>>    #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
>>    #3  nc_sendv_compat           ../net/net.c:823
>>    #4  qemu_deliver_packet_iov   ../net/net.c:870
>>
>> The RSS subsection is only loaded when rss_data.enabled is true (via
>> virtio_net_rss_needed()), and the command path always produces
>> indirections_len in {1, 2, 4, …, 128}, so an unconditional check
>> cannot reject a legitimate migration stream.
>>
>> Factor the validation into virtio_net_rss_indirections_len_valid()
>> and call it from both virtio_net_handle_rss() and
>> virtio_net_rss_post_load().
>>
>> Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and 
>> hash report")
>> Cc: qemu-stable@nongnu.org
> 
> ...> @@ -3427,6 +3427,13 @@ static int virtio_net_rss_post_load(void 
> *opaque, int version_id)
>>           n->rss_data.supported_hash_types = 
>> VIRTIO_NET_RSS_SUPPORTED_HASHES;
>>       }
>> +    if (!virtio_net_rss_indirections_len_valid(n- 
>> >rss_data.indirections_len)) {
>> +        error_report("virtio-net: saved image has invalid RSS "
>> +                     "indirections_len: %u",
>> +                     n->rss_data.indirections_len);
>> +        return -EINVAL;
>> +    }
>> +
>>       return 0;
>>   }
> 
> Hi!
> 
> I tried to pick this one up for 10.0.x stable qemu (LTS) series, and
> found out that this series lacks virtio_net_rss_post_load() function
> entirely, because it lacks commit 7b6e7e4990 "virtio-net: Retrieve peer
> hashing capability" (Cc'ing Akihiko Odaki), and 2 previous commits:
> 
> 7b6e7e4990 virtio-net: Retrieve peer hashing capability
> 2deec9ab7d virtio-net: Move virtio_net_get_features() down
> 14f521f491 net/vhost-vdpa: Report hashing capability
> 
> I can introduce new virtio_net_rss_post_load() with just indirection
> verification from this patch.  But it looks like I can pick up that
> commit for 10.0.x too, and make whole thing closer to what we have in
> current master.
> 
> It does not seem to change machine types/properties and migration
> stream.
> 
> What do you think?

I would not pull the peer hashing capability series into 10.0.x just to
backport this.

It is not only a refactoring dependency. Commit 7b6e7e49905d 
("virtio-net: Retrieve peer hashing capability") bumps the virtio-net 
RSS subsection from version 1 to 2 and adds supported_hash_types to the 
migration stream. It also changes the guest-visible supported_hash_types 
value for vhost-vdpa based on backend capability. That is broader than 
the RSS validation change and is not migration-stream neutral.

For 10.0.x, the safer backport is to add a small 
virtio_net_rss_post_load() to the existing version-1 RSS subsection and 
keep the subsection version unchanged. The hook only needs to reject 
restored indirections_len values that the command path cannot produce: 
zero, values above VIRTIO_NET_RSS_MAX_TABLE_LEN, or non-powers of two. 
That fixes the crash without pulling in the vhost-vdpa hash capability 
behavior change.

Regards,
Akihiko Odaki

