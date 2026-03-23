Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBEF4611B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fmE-0006Z7-6I; Mon, 23 Mar 2026 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w4fm5-0006XQ-8z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w4fm3-0006gC-8w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774274213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrE0W8UV9/iBeosIIXKEXofArqR2IbKfAMs8uE4S2rE=;
 b=Ej6dfwv8TDWy0H3PoIowHsInBfupuuceV9IGpM4EOwakC9/zgyp+hTAbcKjWF37I1UQJt2
 ohzT5jioDr/B88np/EGhHkZMv588pGWsXkqqxlGCI5UFnZQFSery6hpxZA4iVjoTnIFXpa
 RB1lQY6/OrvOkplfvbS0zsN5ue9SCgQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-PhMW2lmfNYaOuUWyggzJKA-1; Mon, 23 Mar 2026 09:56:52 -0400
X-MC-Unique: PhMW2lmfNYaOuUWyggzJKA-1
X-Mimecast-MFC-AGG-ID: PhMW2lmfNYaOuUWyggzJKA_1774274211
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b7ec737c1so417606f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774274210; x=1774879010; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zrE0W8UV9/iBeosIIXKEXofArqR2IbKfAMs8uE4S2rE=;
 b=HmjG0iYSAkRygc6gYMOXUCcnXdIGyRwqMMJIOGLMq31HHlQt1VuqYUJZuWJ9SrrkG8
 hoHSJlMrRq5Mt3Y1Nn9jTy6eNLRxM4vb7oi6TtJUZ9s1NX6sy0ciWyWdA0UO0jOzFRBj
 /lbgOym/PPYAFsiaP9/q+Qzv104RxhP+0nWfVyHPtwjLFa0mUxpbrCNbGRYwo/1QHK/t
 UkXu66FpIFzS5hefXjKn2heMFAx93ehrFFoVd1dduOrZWN9CZ65i9uCn5P1+xoAAx5s6
 W+QQkRMtMuDkKeMQCMDCI+quOeMt0caAKgIET1NK7iTNdIBvrstFshuWekXOH0Jn4Q1j
 e3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274210; x=1774879010;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrE0W8UV9/iBeosIIXKEXofArqR2IbKfAMs8uE4S2rE=;
 b=Rag7x1ppiWiTUgUUs6qkojdM1UJo3LnVb37V6/z/Y0qi9suzy63OZ7kJNk/WcX5x5B
 lHnJsnrJfGTriU8Zh6k8f+bfM3jeOQyxCGfmxuQSHgO8Vu3DzkxH9Fdn+k2clgzkZ/Rb
 f5sBnUJfX3vhc/Pg62xXNhqP9MPzxdymybr/5NUjO87YKHvE+mZUbzluL3nbS+JWzolH
 2x9FhNAzhVnl1o7gcfrqUoW1UIBzrmiMl+UAj+rrIqv1vhywS7ohYFpBMWAWJbqkD13T
 gAqNr8kQD+r7OCE3rxotCOCa/rnzMAHfXBqCVtjOWD6+qydo9sE10FBi10ZwoR5kENTB
 HPcQ==
X-Gm-Message-State: AOJu0YxVlhrEIYmQKjzX0IffoUNqJ9cCzBoRhm1H08YTZzPV9wtGBGrU
 daFgQgqDpt6QjCdNbp6O5VdFcAwRtcehyrpxp+uxOlS/fGiTCvTEHN5OS/zKYUtaVorl0fpAxDx
 B5UCOOz+qCTU0rQpAgInbI0SLPAUj+4Mdc7CzAWgnMQ7dN1t/L2xGXkPw
X-Gm-Gg: ATEYQzy0PUWk16N+eXeVFVlDOmjOxN9Eo34zIa4v+jnwE1Zvg+7mxBDiDOaq5s2M0b/
 cwF7rluZGsc4F/5XYRTHEGUy+kJiNO+r1y7zat410Y4InGfnAOcKqlxwal21YLRDMDQy3YY8kP6
 ykZOrnk2eooU1Tp8iA6wZ2uAGZC2hOAZ0mqUIQhd5rA1R4duFEjlEXzKJSEzPkbYjtSEG/C4BY/
 aEytjD2vymzyBFjv44YtKNZx2tXSFbYHvApbgPwi5vwI9CdeNHIZjnPncPOyW4D0o1nxkNJGiaS
 rVADiD3Uf5/MM17+EDLVmRg7nqmm67qE1LcTSom+9PG/hWx/DsLYujIbOHRwdXoI0eBUQYxMTuH
 khJzWed37a6+Pq8jv
X-Received: by 2002:a5d:5d13:0:b0:439:caf7:a5e5 with SMTP id
 ffacd0b85a97d-43b6427d3b7mr18318654f8f.31.1774274210140; 
 Mon, 23 Mar 2026 06:56:50 -0700 (PDT)
X-Received: by 2002:a5d:5d13:0:b0:439:caf7:a5e5 with SMTP id
 ffacd0b85a97d-43b6427d3b7mr18318613f8f.31.1774274209605; 
 Mon, 23 Mar 2026 06:56:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bf1c5sm32662889f8f.14.2026.03.23.06.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:56:48 -0700 (PDT)
Date: Mon, 23 Mar 2026 09:56:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, yuri.benditovich@daynix.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Message-ID: <20260323094940-mutt-send-email-mst@kernel.org>
References: <20260323131531.1976-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323131531.1976-1-junjie.cao@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> virtio_net_handle_rss() enforces that indirections_len is a non-zero
> power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> virtio_net_rss_post_load() applies none of these checks to values
> restored from the migration stream.
> 
> A crafted migration stream can set indirections_len to 0.  Even if it
> also clears redirect, virtio_load() calls set_features_nocheck() after
> the device vmstate (including the RSS subsection and its post_load) has
> already been loaded, re-deriving redirect from the negotiated guest
> features.  When VIRTIO_NET_F_RSS was negotiated, redirect is set back
> to true regardless of the migration stream value.  The receive path
> then computes
> 
>     hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */
> 
> and uses the result to index into indirections_table, which was not
> allocated by the VMState loader when the element count is zero (see
> vmstate_handle_alloc()), resulting in a NULL pointer dereference that
> crashes QEMU:
> 
>   #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
>   #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
>   #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
>   #3  nc_sendv_compat           ../net/net.c:823
>   #4  qemu_deliver_packet_iov   ../net/net.c:870
> 
> The RSS subsection is only loaded when rss_data.enabled is true (via
> virtio_net_rss_needed()), and the command path always produces
> indirections_len in {1, 2, 4, …, 128}, so an unconditional check
> cannot reject a legitimate migration stream.
> 
> Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>


Thanks for the patch!
Yet something to improve:

> ---
>  hw/net/virtio-net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..3038836098 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3427,6 +3427,15 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
>          n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
>      }
>  
> +    if (n->rss_data.indirections_len == 0 ||


not needed since it's included in is_power_of_2 check below?

> +        n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN ||
> +        !is_power_of_2(n->rss_data.indirections_len)) {

with == 0 removed, the logic is duplicated from
virtio_net_device_realize.
How about factoring it out to a helper?

> +        error_report("virtio-net: saved image has invalid RSS "
> +                     "indirections_len: %u",
> +                     n->rss_data.indirections_len);
> +        return -EINVAL;
> +    }
> +
>      return 0;
>  }
>  
> -- 
> 2.43.0


