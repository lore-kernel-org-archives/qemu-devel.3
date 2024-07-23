Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252B9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDI2-0003sA-Rs; Tue, 23 Jul 2024 07:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDHt-00036k-0V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDHr-0003MI-8V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IT1q+ndAF7/G1yTMy+JX4lYogGoMzMPsKs7/eXYu52g=;
 b=bPun50pW6x7W6gxCFvbB26CSt6y2OqQMBc1n5eXIAiQQNxY2vgL/4pbYiRZhBTtupwoRkj
 7UJlY3ofAVZOusAXGLRwUYAtjtCjYBywmv3TZJHQQ7Hml2EbFwc8htpmazn2U3T2fKdkAt
 S43FEtu1GHjO0ywmQ4S36bbBUS3IXgU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-17mg-QhqMQaLMhF_3Nm5Zw-1; Tue, 23 Jul 2024 07:02:29 -0400
X-MC-Unique: 17mg-QhqMQaLMhF_3Nm5Zw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77c9c6bdadso49664966b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732548; x=1722337348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT1q+ndAF7/G1yTMy+JX4lYogGoMzMPsKs7/eXYu52g=;
 b=xSUa+jupLeX3CUUjwnkSXVnGDbc/remrO6m7zlboIjlgbITJc/XsZP66BwlGiNT0ty
 Tu4i8sIEdULO6mQoLW5BiqCpm4TjWc45VzDmQjf+h3vSKHouEVGqLPeEJp//kQ7XHI6O
 xjgzOefbMGCdbuvmt5l1Z+Xq7l+eTWxfWyRUh5P+UAuacAiOJW94meecK0Em0V+aFxof
 RhpCqogy+IbCLFe5WLaNG7qHdh1qb59sRiSc0yLzzr8Hb3kMVWICq+CjjlyIV9gNp8kz
 W3XFDRYRHHcIkPYWKBZ7U8Qmey9J6lQ5W57WsZC/MImghe+6Pm4Cd2LhedA1l+aUtH8h
 151g==
X-Gm-Message-State: AOJu0Yx2Uf2KDB1xTV+efA+llQrhWXqHNflsjQodhd8GXK+W6L+1PIMs
 18EpV1KH14oG1UiIZNi2bN/pRcWSXfIG+9y7rHds92zYyqSIh8Iu68sqhsE8w4C3/P7hMtwlX09
 aiUjV1QvZJxmZW+avayXUpGHLhPBaEzbtINmA1ih/37S2BL7SYtDL
X-Received: by 2002:a17:907:940e:b0:a7a:a33e:47b8 with SMTP id
 a640c23a62f3a-a7aa33e4e08mr42086066b.66.1721732547880; 
 Tue, 23 Jul 2024 04:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhFFUtGXOCyf2FNeZea+Pgsi+CNp6azqhJ3uoZljEIBV4nLiVhV95J7Bk1JUioBRC6Kp2qbw==
X-Received: by 2002:a17:907:940e:b0:a7a:a33e:47b8 with SMTP id
 a640c23a62f3a-a7aa33e4e08mr42083866b.66.1721732547257; 
 Tue, 23 Jul 2024 04:02:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7e7871sm530553566b.96.2024.07.23.04.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:02:26 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:02:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 34/61] virtio-net: Implement SR-IOV VF
Message-ID: <20240723070146-mutt-send-email-mst@kernel.org>
References: <cover.1721731723.git.mst@redhat.com>
 <c2d6db6a1f39780b24538440091893f9fbe060a7.1721731723.git.mst@redhat.com>
 <a034545a-287e-4320-8bb3-57937f431cbe@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a034545a-287e-4320-8bb3-57937f431cbe@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 23, 2024 at 08:00:57PM +0900, Akihiko Odaki wrote:
> On 2024/07/23 19:58, Michael S. Tsirkin wrote:
> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > A virtio-net device can be added as a SR-IOV VF to another virtio-pci
> > device that will be the PF.
> 
> This does not work without patch "hw/pci: Do not add ROM BAR for SR-IOV VF"
> because virtio-net-pci has a ROM file. Sorry, I should have noted that.
> 
> Regards,
> Akihiko Odaki

right, but it's harmless since sriov is off by default -
so you can just send a patch on top.


