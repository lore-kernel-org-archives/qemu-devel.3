Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA859CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSD2r-0005H0-FU; Wed, 27 May 2026 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSD2p-0005GJ-4A
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSD2n-00007z-1m
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779883645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgMNb9OdOOZkg9BsihMlRa9QlL7yKqeknWm5GDzo7t8=;
 b=Z4p2khbWDSA/WFfGpWu57tIfkDVFR4h1F2hborf8YRraxh60VAS6ODSGnYqfYGGQ2KRIly
 rfnErkA6kkAbwKA5GRV2xOQY5yqDmOKCDG+5ARAoTr/NvT1ffgiXfO3B8G4an1w3QK98Im
 XR6POx5wPb4eN7E65S4XyvUD0CnWqKU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Vh2WcX1sNQq86m7h3dgjxw-1; Wed, 27 May 2026 08:07:23 -0400
X-MC-Unique: Vh2WcX1sNQq86m7h3dgjxw-1
X-Mimecast-MFC-AGG-ID: Vh2WcX1sNQq86m7h3dgjxw_1779883642
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44a52d5e572so8036442f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779883641; x=1780488441; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cgMNb9OdOOZkg9BsihMlRa9QlL7yKqeknWm5GDzo7t8=;
 b=JF0A4sNK9qkVits1t4RHuCcqznnwnjvCqe5NB66QpVB2/vwalQ7XzP0grj97tNvSsI
 Np9nznLWZaYFInPhX1NlFkssu+k1P6qE+rAZggStwDGxFT8zM2y/StIZ8dw9dxETGLUM
 hrAo3YJYMwi0KClJNd7ai/Cm0OEwqqh7ZJAzVUa4RRgnYdIgmbNlSEyTMTmi9L41zgkP
 oBg6jkqT/GeqnaEGGZrUKZ9rBSZdoaAVy6eVkoThP9pr9xk00zgkubixHFrGuuK3a4um
 1oH9+vbnjqG+bZrgJ9IEA4E4hp3E81fhGkBt5lgAJE8283fv5vjjdmtPbmENSaAc9XT4
 4IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779883641; x=1780488441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgMNb9OdOOZkg9BsihMlRa9QlL7yKqeknWm5GDzo7t8=;
 b=flTvg83zd1TZl1WeTizh5tIL+XD8gSr3QBvLTC7ZMnm/Hr+j41YygoJ/CjcT9NvoOg
 LqMNKdVuWLXBK1T2cIlYaW52LVaVQOjeY7KEk5nCuUkvW4AQSOFoRNbDB+hnBKnki7zu
 sdGWSWFueamB9nU/rW0QDtchz569JKf2iIObzRwUmF83Jxt9xEENJblUKTUgThIn9GaR
 t4tIXUY1whyjhdJ+N3Ps8vQ8DPIEN5Lx4SWhWtZMrTLLk4BM4csplTCBWrnfI8SGyKSK
 ieIilqTi9kZi/RgOWVG791oaF8q0PBBbWYLWwCSZ3mVCmvfeVbAYC3vjnUJtwVeoaLT3
 Y4kw==
X-Gm-Message-State: AOJu0YyHIEwXCFf48WhSFb7J9DpYvcjO7yOHF30XIyeGXT5Pr8ICUjsn
 lFq39nJge/YYF7JGB+QcomV38+IIrZ3LQKNNh3UCOSLlig3lMQLZum8dGguoJmHftgVkqhSANiO
 8QXgNuee0XAUdB+m5/5sKxZwS2jSRsPNaI54lhE9/uZ6wWYvfexDG7wOp
X-Gm-Gg: Acq92OHKdMrqUrk8jL7td7RPQSwgDRDKOzC9FSz8mY1SCP7iopGUHmixe7yIJB02vdr
 w/7QNxosPdzc94U4hT9gc3yrvddJoD1B8rlLCdub5HgvJIzvqqu47d8Hh8oJU4iaiMnZ4QhYXQQ
 BPzrbmH5MqDvDcg63SCw3Tm1lCV1ArMy1Kf3YuJnDiUn48xdvwFMbIvevCZHriXUddKav+LTQX6
 ke5flOZbI2BY2H6LI77GPEv5hJvSQBHXa/f1u/cDedr7tL4M+4NIXQfzrzr/Qj0m7UVekAT/KKN
 AGE9PtbvCgTpGte9qtzwmOy0+Et+6pA4CDzRX7gc9CO2smTe33gVEgTbzfTSYuxUo2c2LR7L79E
 eJ/xLHJIGSYa5nB8OYuA2jWtGTrC26MwHkmSgrKS/MDPuZszit6ib+A==
X-Received: by 2002:a05:6000:2dc2:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-45ed6b2e76dmr13413538f8f.34.1779883641093; 
 Wed, 27 May 2026 05:07:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-45ed6b2e76dmr13413454f8f.34.1779883640355; 
 Wed, 27 May 2026 05:07:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm5532349f8f.0.2026.05.27.05.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:07:19 -0700 (PDT)
Date: Wed, 27 May 2026 08:07:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 Yunhe Wang <yunhewwww@163.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] amd_iommu: fix infinite loop
Message-ID: <20260527080701-mutt-send-email-mst@kernel.org>
References: <20260511113923.2478812-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511113923.2478812-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 01:39:22PM +0200, Paolo Bonzini wrote:
> The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
> of two) entries.  Each entries is 16 bytes and the head pointer cycles
> through the set:
> 
> The tail pointer is written by the guest through the COMMAND_TAIL MMIO
> register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
> terminates when head == tail.  If tail is set to a value higher than
> cmdbuf_len * 16, head will cycle through all the elements of the ring
> buffer indefinitely, without ever matching tail.  Fix this by further
> masking tail (and head, for consistency) against the size of the
> ring buffer.
> 
> Reported-by: Yunhe Wang <yunhewwww@163.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

in my tree now.

> ---
>  hw/i386/amd_iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2b..197e452e3c3 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1578,7 +1578,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
>  static inline void amdvi_handle_cmdhead_write(AMDVIState *s)
>  {
>      s->cmdbuf_head = amdvi_readq(s, AMDVI_MMIO_COMMAND_HEAD)
> -                     & AMDVI_MMIO_CMDBUF_HEAD_MASK;
> +                     & AMDVI_MMIO_CMDBUF_HEAD_MASK
> +                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
>      amdvi_cmdbuf_run(s);
>  }
>  
> @@ -1594,7 +1595,8 @@ static inline void amdvi_handle_cmdbase_write(AMDVIState *s)
>  static inline void amdvi_handle_cmdtail_write(AMDVIState *s)
>  {
>      s->cmdbuf_tail = amdvi_readq(s, AMDVI_MMIO_COMMAND_TAIL)
> -                     & AMDVI_MMIO_CMDBUF_TAIL_MASK;
> +                     & AMDVI_MMIO_CMDBUF_TAIL_MASK
> +                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
>      amdvi_cmdbuf_run(s);
>  }
>  
> -- 
> 2.54.0


