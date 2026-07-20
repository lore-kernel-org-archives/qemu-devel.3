Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117FDC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlstp-0003dJ-PJ; Mon, 20 Jul 2026 14:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlsto-0003cn-Ir
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlstm-0003Cj-Ic
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784572768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOQc1Ve5iHTP6lmQw+owENmPuyoaLkDbKfLor1f7Kgc=;
 b=ONrOQJjV5kzf1SdsQxxqHGqqTh9FzzuDqJPO3CGhMABmd+aybosTjDoX26ifYATgtNj6QD
 pzGFGNt4gYfEITFN/d9E2MxMhBN4SLsP+oGTiIutKYzdrw3izvAw4RNnTemXMA+Xhc5FJS
 M4pLPH/vfjMd7Hnf3R3wmjWFdwen8aY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-iSQ1jo5hMjuPEcSuq4ygrQ-1; Mon, 20 Jul 2026 14:39:23 -0400
X-MC-Unique: iSQ1jo5hMjuPEcSuq4ygrQ-1
X-Mimecast-MFC-AGG-ID: iSQ1jo5hMjuPEcSuq4ygrQ_1784572763
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso283382811cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784572763; x=1785177563; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MOQc1Ve5iHTP6lmQw+owENmPuyoaLkDbKfLor1f7Kgc=;
 b=jDnwWcua4teM0xF5zU/AAjwRgIm23xbCCQ25J7jCEm33zWfzBB/7y2+yMtHS+HcutB
 x4Jf6PpYUDRdoBi3IzGmQUahkBfg0PbBcqBLWSPXC8bExKhTqYx6uuNjg5hsQDsUvdnM
 ycAsW8H/qR95y7J4XhH8yS5AWjP/ebc6a6LeLVq+eZLVk2Cance+a1fPGwNyEq8ZZ2Sq
 i6ki/l/l5qLt5EyAWog1xO27138qFGG4SkxdAAUZWYopQGHfDgnoz0Vie5IsXoQVEkgZ
 i8/MUSTh26cuJKfo3GHc5kEt+hVJTzrwUPpmkVcB6zVJQOQXQhoDUrbCgj39zwgf22Mm
 Py9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784572763; x=1785177563;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOQc1Ve5iHTP6lmQw+owENmPuyoaLkDbKfLor1f7Kgc=;
 b=NAWX/QZ4XvPUeK/FirXPXPYEau+zYj6kczWnXH94667N/oW6G16X1cpfW12glwBKRl
 ZwWAkSV4f+s8m6E4JUotuv2DCc7A9OGMMQGz40P3Tnf9FApKP7HwExq5T0w88Hf+Yt8x
 gHvQmrteca1JZZVW2+uJzHGX9DOTLdPnamSKqzu6C/VfyF6HnDL55MoYaTfY8ZQVfy9t
 Hc6iO0f1Ru1sQaM5Pk81MgN40DCGWWmUR5eY0sefXJGC6YtKYwgIl6vJHxMtNTnp9SPh
 Jl9Ibkf1XtNIT0A15kcqWZdw8vuajLDdgsVEJbaS2JYSM6u3wEGS8izmgaWea8W55+Fo
 eXLw==
X-Gm-Message-State: AOJu0YzcfMDbohnHuBnApoL2ImFGwVB3BTtXk30pqQSjof0+UkjuoMR5
 wfaC8HYDLo3G4iLcdNvhTSE1RTKvNUl/2HvBv0Yj/Owzm32M8qPq32dr+X84eti5P0zaumuZC5H
 ID3/vjQ3DoUSAT2CxJXOvE9E3laAIf/zK/+e/+BEODWaUmDiCIBInmGBf
X-Gm-Gg: AfdE7clp9/lM/0dP5Uc1RK0IODYxt9ttJ8lOgPlAWziKbMy9hG+rOp1UC5KPukRVEU5
 ZUKB8hP/WOgh2DRelieIX6QKK7LtD+7RP2leKQa+PzrkbXALXL8/I2sGnFG6Vb5PHGi1Z3OaC1g
 Z5H8L4a2QH1qDcGWd4BgqYv2pzM/8ULiZBTeKgsiqhb00NvYmbL1ba0rx1ATUmpid1/vX182fCw
 /drv+vifaFkqOFWvnxFoKcOKpMDp2vY+lHYhXVZbp5G9JpR+RElP81S4fHw9ldYiQ8A9d43Q0R3
 3uZhTcIUO7cGlG/gNoAq5GBGW4sdocE5LX/3gihI4b634WHmB6kiJgXRhJKEUOpcLp3S
X-Received: by 2002:a05:622a:909:b0:51c:99b:d668 with SMTP id
 d75a77b69052e-5213e28f16dmr152832581cf.49.1784572763057; 
 Mon, 20 Jul 2026 11:39:23 -0700 (PDT)
X-Received: by 2002:a05:622a:909:b0:51c:99b:d668 with SMTP id
 d75a77b69052e-5213e28f16dmr152832221cf.49.1784572762573; 
 Mon, 20 Jul 2026 11:39:22 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907785972aesm101727886d6.22.2026.07.20.11.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 11:39:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:39:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 06/11] migration: add RAMBlock field and helper for
 fast snapshot load
Message-ID: <al5rTdgBKxKOMCEt@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-7-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-7-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:42PM +0530, Aadeshveer Singh wrote:
> +static void ramblock_pending_bmap_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        assert(!rb->pending_bmap);
> +        size_t size = rb->max_length >> qemu_target_page_bits();

I forgot one thing here: I think it should use qemu_ram_pagesize(), for
huge pages when the fault thread or eager load thread want to figure how
who to do the work, it should always be in host psize, not guest-psize,
because that's the granule userfaultfd's UFFDIO_COPY/ZEROPAGE uses.

> +        rb->pending_bmap = bitmap_new(size);
> +        bitmap_set(rb->pending_bmap, 0, size);
> +    }
> +}

-- 
Peter Xu


