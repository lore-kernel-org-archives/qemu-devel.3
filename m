Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E364C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQad-0002lE-Nz; Wed, 10 Jul 2024 02:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRQac-0002kU-U5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRQab-0007AH-DT
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROJclNC9vTiIqL+/uBAN7yosMldTLVHEhyrJJaaZ058=;
 b=RW0P0IwpaCmRsjD7Wv1etV6Bm/8nxdjLYqcujxQcl19lDqWbfjsdTD2Ot5MFqXnuJok2I0
 ZtUDEzBBRZfms+DYQbuzbgNQKuLu2Nl59GGaPMa6o5ygTKUIRFYuctSdh8F394VA0J6m5X
 f66NvBo2VQ6ELGjHeA5Dfn6L8y0khQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-HhQzvVXZM6O1ciHEGC7foQ-1; Wed, 10 Jul 2024 02:14:00 -0400
X-MC-Unique: HhQzvVXZM6O1ciHEGC7foQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso222135f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592039; x=1721196839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROJclNC9vTiIqL+/uBAN7yosMldTLVHEhyrJJaaZ058=;
 b=Xjz9XSnw37reWddA41vNVuYWWZzb/MKGE9gS0uFQ/602+qy4rBhjxPeHCeBcpQZ0gg
 xTFQzqFU2VpYpEgAxk7aUBx0rWK630/bgIjMIQgPV5+UStghMNopZLGDMLzjPDFQTjUM
 D/CAg6Zhei1yoG9n7wW11TzU0Xm0O5lBIWW3kAWlpiiSYxcMZkW6xYV/h9iX/TMk/zlz
 D9ffqxWhy/PFeH1vX5TbI3VP6m+fLEC8hjr+ovRQuiBspUSICpp2HJSDlU601QOm7e5J
 ZvS/p5cjugVsMTjAPifjAQ+r9jVx6RG13fJJ26ClgaWJ2/cZVUDeGRLDq0cNghXVhG3a
 b31Q==
X-Gm-Message-State: AOJu0YwgxnTl/fwMpW9TZfuLXROkZq6Tbf6CxWukFl8FDkOiCVRnci70
 bp5ZwsUTDywt8AgyNakSFe9YkEXduYSM2GkTjmKI40qmdcrVAenctVDQW5kxicAfbq5LsxKNmTG
 1LYltM8nvUGar6yZW9NkEEsbueamvoUIhpQxZ7gmZnNIyrJ76EdhJ
X-Received: by 2002:a5d:6943:0:b0:367:938f:550 with SMTP id
 ffacd0b85a97d-367d2e6ad38mr3606316f8f.25.1720592039444; 
 Tue, 09 Jul 2024 23:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkXDsRmxmSF/Z/x32Z1YpbYzNZxZiRnabMxSfG6iIJr8Z4JJEszxKEhaMMwuuzjrpQzAO6RQ==
X-Received: by 2002:a5d:6943:0:b0:367:938f:550 with SMTP id
 ffacd0b85a97d-367d2e6ad38mr3606286f8f.25.1720592038878; 
 Tue, 09 Jul 2024 23:13:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5f25sm68444365e9.26.2024.07.09.23.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:13:58 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:13:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH RFC] virtio-balloon: make it spec compliant
Message-ID: <20240710021321-mutt-send-email-mst@kernel.org>
References: <8de2d4a6407d796d4d793975fc88e2f929f6025d.1720128585.git.mst@redhat.com>
 <6f99d0dc-8cad-435c-ad58-ffa69f44b2c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f99d0dc-8cad-435c-ad58-ffa69f44b2c0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 05:15:18AM +0200, David Hildenbrand wrote:
> On 04.07.24 23:30, Michael S. Tsirkin wrote:
> > Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
> > VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
> > gets number 3 while spec says it's number 4.
> > It happens to work because the linux virtio pci driver
> > is *also* out of spec.
> > 
> > To fix:
> > 1. add vq4 as per spec
> > 2. to help out the buggy Linux driver, in the above configuration,
> >     also create vq3, and handle it exactly as we do vq4.
> > 
> > I think that some clever hack is doable to address the issue
> > for existing machine types (which would get it in user's hands
> > sooner), but I'm not 100% sure what, exactly.
> > 
> > This is a simpler, straight-forward approach.
> > 
> > Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > I don't think I'll stop here, I want to fix exiting machine types,
> > but sending this here for comparison.
> > I'll send a Linux patch later.
> 
> The downside is that new machine types will stop working with mainline Linux
> / major distros in that feature combination, right?

The should keep working, that's why I put in part 2. above.

> What's the approach that you are thinking of?
> 
> -- 
> Cheers,
> 
> David / dhildenb


