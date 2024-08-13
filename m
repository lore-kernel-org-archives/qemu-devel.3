Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1D6C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdySc-0000pL-Gd; Tue, 13 Aug 2024 16:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdySa-0000fb-Eb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdySY-0001fh-Uv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723582178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jyXx+wKOQOxU2ecyqA2iwoYFri7dVNuVaZYwSPMvZE=;
 b=HtE+sUdzlq+GAErZhfM0hi8LWBKHR+s1Bh1KafdewgCYAs6/+M/qAxIAVbdCZkPznSnUUK
 p9dRYnPVPVyTkHWvyFwLU68ttIijtVZ5sXK2hqhZubC81Xn7A27Sbap/YuvUnYhM+72iY7
 7Jo3AybT17NMgmRp7mr8vFk+JCT3skk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-SXSc05suP72mVWyES-HmiQ-1; Tue, 13 Aug 2024 16:49:36 -0400
X-MC-Unique: SXSc05suP72mVWyES-HmiQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a534faa028so4189580a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723582176; x=1724186976;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2jyXx+wKOQOxU2ecyqA2iwoYFri7dVNuVaZYwSPMvZE=;
 b=gMTksiBU7gyjWUd1+lJymTbI4KBWoU/nsUq/PL0xR9L1dSmXyyrx8m55O/m+7M8PVv
 8TLgsfRRJROcm/UUUpsHLyLDRuaWmIH1ilSMPL2Jipa2urzzNplGyLbUBx7kVORSDnmN
 diVFOSQ2t2gcKRQUjZ7vKVD22TVIAGLecCvBFYJgLR44rd/+dS/5SMX+WWfBFmM2K0z/
 j7vtkF5AfnKtrfKg3ArSoAO2zjGeTZiPsrUgSIyqNMevpnVsQxIJynQB/KBX50LZQXam
 pPAsgsEfsaIxmotJamA+Y2oXFoLgSNnC9ZZ6czJaRirBAFVg2knAhbzSHfWF50+4j+ML
 lDSw==
X-Gm-Message-State: AOJu0YyW/UdZe8FuobPCxnZ44aCAH0N39VBcQrVmMSnGjFwpClNaw6++
 SbDMAEpdWLBfSqKlNkKW22ZFN70E1wg193L0mpDpWegTagyFtnAAinTCCsJ9SLirDjQ3lPb0Pkq
 N87uMo9jSyAtIZtuSr4+1yVnSGFfbzqycTX1Ia529QE7nIy/1/lLH
X-Received: by 2002:a05:6402:354d:b0:5a2:eeeb:9470 with SMTP id
 4fb4d7f45d1cf-5bea1c7d55cmr495880a12.18.1723582175640; 
 Tue, 13 Aug 2024 13:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOThsCAJZvMWhFXkmvc33CnN7/gHIhcFcd6plNLIQ7t1uElLb+9qnrCat3ar5DTPcCAzlaCA==
X-Received: by 2002:a05:6402:354d:b0:5a2:eeeb:9470 with SMTP id
 4fb4d7f45d1cf-5bea1c7d55cmr495846a12.18.1723582174803; 
 Tue, 13 Aug 2024 13:49:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a602115sm3148299a12.96.2024.08.13.13.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:49:34 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:49:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 17/21] virtio-net: Use virtual time for RSC timers
Message-ID: <20240813164916-mutt-send-email-mst@kernel.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-18-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813202329.1237572-18-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 09:23:25PM +0100, Alex Bennée wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Receive coalescing is visible to the target machine, so its timers
> should use virtual time like other timers in virtio-net, to be
> compatible with record-replay.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Message-Id: <20240813050638.446172-10-npiggin@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 10ebaae5e2..ed33a32877 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2124,7 +2124,7 @@ static void virtio_net_rsc_purge(void *opq)
>      chain->stat.timer++;
>      if (!QTAILQ_EMPTY(&chain->buffers)) {
>          timer_mod(chain->drain_timer,
> -              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
>      }
>  }
>  
> @@ -2360,7 +2360,7 @@ static size_t virtio_net_rsc_do_coalesce(VirtioNetRscChain *chain,
>          chain->stat.empty_cache++;
>          virtio_net_rsc_cache_buf(chain, nc, buf, size);
>          timer_mod(chain->drain_timer,
> -              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
>          return size;
>      }
>  
> @@ -2598,7 +2598,7 @@ static VirtioNetRscChain *virtio_net_rsc_lookup_chain(VirtIONet *n,
>          chain->max_payload = VIRTIO_NET_MAX_IP6_PAYLOAD;
>          chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
>      }
> -    chain->drain_timer = timer_new_ns(QEMU_CLOCK_HOST,
> +    chain->drain_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                        virtio_net_rsc_purge, chain);
>      memset(&chain->stat, 0, sizeof(chain->stat));
>  
> -- 
> 2.39.2


