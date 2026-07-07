Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E5AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7fv-0004Bv-GX; Tue, 07 Jul 2026 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wh7fu-0004B9-3U; Tue, 07 Jul 2026 11:25:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wh7fs-0000B3-HR; Tue, 07 Jul 2026 11:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783437924; bh=k95QfvU8HhHhCpnTaQ46v/TIj5c+hrw7BLAsc1XDVj4=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=MuyswEP8OAshdwJQLDbVHnRcmUpqrqRlSToxTebNpZSjF3JhdAgYnDZcqZsyAyAy9
 X68NyGD+yGo6W3ufL1csZ7euv4p03mt6pIy9AvUXw+ppNBR1d825DUYLGP9xiNfxyj
 IdKZSy1abGYqYgI25gHUX0SU9lBAdKxEaBwPRstt+CATNXUKpRDKIVq6dO4mhjxus9
 q9slt92Rysvy+t4SR0nNowr1gtscB4XUBv3jnnInVJN9q/Ll4mmOVArWZlP3+zRRO8
 9kH7/3QdYJkLiqT9SakbNUAF0T4Kyt8vE4S9P6fMpW/p4WhKmPzN7vvGQpDfFz/CTj
 TOcpqUlW1g1ag==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 16AD51BEF9D;
 Tue, 07 Jul 2026 18:25:24 +0300 (MSK)
Message-ID: <c8c320ce-af9f-47ee-b036-b408aa5d60be@tls.msk.ru>
Date: Tue, 7 Jul 2026 18:25:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PULL 44/44] virtio-net: validate RSS indirections_len in
 post_load
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <cover.1783261895.git.mst@redhat.com>
 <32a90850e1e4222091df07b4b46d5f46a8b90d24.1783261895.git.mst@redhat.com>
Content-Language: en-US, ru-RU
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <32a90850e1e4222091df07b4b46d5f46a8b90d24.1783261895.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(Resending with correct new address of Akihiko Odaki.
  Please excuse me for double post).

On 05.07.2026 17:36, Michael S. Tsirkin wrote:
> From: Junjie Cao <junjie.cao@intel.com>
> 
> virtio_net_handle_rss() enforces that indirections_len is a non-zero
> power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> virtio_net_rss_post_load() applies none of these checks to values
> restored from the migration stream.
> 
> A corrupted save file or crafted migration stream can set
> indirections_len to 0.  Even if it also clears redirect,
> virtio_load() calls set_features_nocheck() after the device vmstate
> (including the RSS subsection and its post_load) has already been
> loaded, re-deriving redirect from the negotiated guest features.
> When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
> regardless of the migration stream value.  The receive path then
> computes
> 
>      hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */
> 
> and uses the result to index into indirections_table, which was not
> allocated by the VMState loader when the element count is zero (see
> vmstate_handle_alloc()), resulting in a NULL pointer dereference that
> crashes QEMU:
> 
>    #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
>    #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
>    #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
>    #3  nc_sendv_compat           ../net/net.c:823
>    #4  qemu_deliver_packet_iov   ../net/net.c:870
> 
> The RSS subsection is only loaded when rss_data.enabled is true (via
> virtio_net_rss_needed()), and the command path always produces
> indirections_len in {1, 2, 4, …, 128}, so an unconditional check
> cannot reject a legitimate migration stream.
> 
> Factor the validation into virtio_net_rss_indirections_len_valid()
> and call it from both virtio_net_handle_rss() and
> virtio_net_rss_post_load().
> 
> Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
> Cc: qemu-stable@nongnu.org

...> @@ -3427,6 +3427,13 @@ static int virtio_net_rss_post_load(void 
*opaque, int version_id)
>           n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
>       }
>   
> +    if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
> +        error_report("virtio-net: saved image has invalid RSS "
> +                     "indirections_len: %u",
> +                     n->rss_data.indirections_len);
> +        return -EINVAL;
> +    }
> +
>       return 0;
>   }

Hi!

I tried to pick this one up for 10.0.x stable qemu (LTS) series, and
found out that this series lacks virtio_net_rss_post_load() function
entirely, because it lacks commit 7b6e7e4990 "virtio-net: Retrieve peer
hashing capability" (Cc'ing Akihiko Odaki), and 2 previous commits:

7b6e7e4990 virtio-net: Retrieve peer hashing capability
2deec9ab7d virtio-net: Move virtio_net_get_features() down
14f521f491 net/vhost-vdpa: Report hashing capability

I can introduce new virtio_net_rss_post_load() with just indirection
verification from this patch.  But it looks like I can pick up that
commit for 10.0.x too, and make whole thing closer to what we have in
current master.

It does not seem to change machine types/properties and migration
stream.

What do you think?

Thanks,

/mjt


