Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C3EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDpU-0003RQ-Ue; Tue, 23 Jul 2024 07:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDpO-0002xI-5O
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDpM-00033v-Eb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721734627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxf1bTDu6w/FxpF0cOkbAjuoIxzxxrzNuJk3P/6Ak3k=;
 b=cM7wTYHPvCUeT0Bx/+LY+ohHyCPEtssg9oux6c2UXWs4HrhhE8byCoEEafTyl7rRRROYPA
 jXlp6+3k+zVRGGSnYNlWvKtwlCZuPLMomb7BDYV77YMH016ffWQZIaAvbFT1iLu26xpb1H
 bJ5l18MP9DvbwAxYw79IlBMhmV82X5w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-dM2mh1mROcim6yhhJn7jWQ-1; Tue, 23 Jul 2024 07:37:06 -0400
X-MC-Unique: dM2mh1mROcim6yhhJn7jWQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef62acc9ffso16477681fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721734624; x=1722339424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxf1bTDu6w/FxpF0cOkbAjuoIxzxxrzNuJk3P/6Ak3k=;
 b=iEWt4jQl3tiqDW56mAV4j/ZQqBh7YE03nBUMwRwwxuG3R35E3LXkbjxpAp+NWCQQll
 XC4PshkxgDl9xI3Ip5RmQwTC4AzFkT/52AkSV1wOMD1KfCU2iKgoyLoWpLq8VNyT9qrK
 u+j5wsLKbcwKHIP1Dmw2zqcH7E6nTN6YO+mAZd1iKSiC1rVJ+M38YXJupV4rIUMZ4Oah
 C0awTujm0MaC3te9THcCvM7hTnTWS7faQ1gXx4838W3Wwx1LicLjaA4t/xFMrl8+cNko
 M+2pBAlA9ROVDEpOapU0NmaT71BTlkbDo81yoPCX+8igESWtRqKCLMb/2+uBL5KhJ0Jz
 2v0A==
X-Gm-Message-State: AOJu0YyFlPViYs0umhqvmEgP5EiLn+3rhlxwUbUYC1L189FUeIjQ8aJy
 5QXOu7KU1nIyI+nsjrqgRQz3MuxyJwTxcBgEcFo11VgpXhPC0/0kAv3Gj0+gDiY/iz+9Y+ikOmI
 2BCPV+W6Hozal/6cSSw9wEx1oCOalzXhjTWevn0KZSYrLvJPdpuyWNcoNasuj
X-Received: by 2002:a05:651c:222:b0:2ef:2bac:bb50 with SMTP id
 38308e7fff4ca-2f01ea5566fmr19587461fa.11.1721734624551; 
 Tue, 23 Jul 2024 04:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZEVzX0coT0ei6pBkmmO+FQK4Jl9lYiIhWYCR3Uy/kDX+Pv9tRJVFWzds6UdpIxUoIEwFCRg==
X-Received: by 2002:a05:651c:222:b0:2ef:2bac:bb50 with SMTP id
 38308e7fff4ca-2f01ea5566fmr19587271fa.11.1721734623801; 
 Tue, 23 Jul 2024 04:37:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878811899sm11231440f8f.116.2024.07.23.04.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:37:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
Message-ID: <20240723073600-mutt-send-email-mst@kernel.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
 <20240722201719-mutt-send-email-mst@kernel.org>
 <891bb4d1-b6f1-40e8-b0d0-8f0ab1826901@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891bb4d1-b6f1-40e8-b0d0-8f0ab1826901@linaro.org>
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

On Tue, Jul 23, 2024 at 10:44:36AM +1000, Richard Henderson wrote:
> On 7/23/24 10:20, Michael S. Tsirkin wrote:
> > > Fails ubsan testing:
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
> > > 
> > > ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access within
> > > null pointer of type 'struct vhost_net'
> > > 
> > > 
> > > r~
> > 
> > Thanks! this is just make check under ubsan build, right?
> 
> Yep.  For avoidance of doubt, the configure line is at the top of the log.
> 
> 
> r~

I wonder why I see a ton of other ubsan errors btw. But anyway, sent v2
with a couple of patches dropped.


