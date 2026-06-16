Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D358FCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXdN-0006Ov-D1; Tue, 16 Jun 2026 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZXdK-0006OD-KI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZXdJ-0004de-6w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781631088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWc8XpFSVDFqkdh9JRMAyyd+HTlraBz0TXBtpxzGEaY=;
 b=RjCtsuHAMqzKrlzaO4Amt3BhMQRDJH4P2dFt+nB1nNgSwhQuUkjDjhsccTFZ0KTRE/5ac6
 RmW1Z3TwNj/nLdyTolrQjbDARZns+CZ2QmDmSos8MXvR0zIqioepUjG6VZMSiwwWNpaP5G
 Bu2ZE3ZFn88Zd9Iqsz0ze6DEvhUwIf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TMeeUT3qMH2ulHGuUwZKbA-1; Tue, 16 Jun 2026 13:31:26 -0400
X-MC-Unique: TMeeUT3qMH2ulHGuUwZKbA-1
X-Mimecast-MFC-AGG-ID: TMeeUT3qMH2ulHGuUwZKbA_1781631085
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso48429315e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781631085; x=1782235885; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWc8XpFSVDFqkdh9JRMAyyd+HTlraBz0TXBtpxzGEaY=;
 b=QcLvNJBNg7omZvnuAA95gIb1flpcxF4bDy/JCNqmskQlBFVtOLxO1dMZE0Njmc+82c
 q9UlSMZhnhU/13l+vB+xM9A8+V9mkKHbfJNOouNj+Vt59YM5GF/Qp2ve+owKjs2mO0tp
 uN0tR5xm5fo8im/OoY/vYUpSb3l//PXnqLFO7SbF0eDD+5s65zc0w7vtiPNLe7yhaRN8
 /yI/likGW7xDomzvAn8hZCdQYL79IQMv4yrcEFf/iAjbuE4DLVBPacEYV4kWH1jBeLjE
 OUlj/izhwjb4KoY9VhsbSjtVTmPsdZXtOeAaT5t2P/Y35Ruvqemw3xZKq4EvK6/ndjsb
 h8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631085; x=1782235885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWc8XpFSVDFqkdh9JRMAyyd+HTlraBz0TXBtpxzGEaY=;
 b=gCFsqmA4HTdUx1GDg3Y/iQo8AGVwrMuJwRNABobKcdbRZMfaVxDoTKBsLOawv2lrYC
 IMrCQav1pzLxdM3fNEBHCgFGaLBaZFmIZr8MLw/79xvSZaPW1vcJMeQUXH4X0uR0FPLV
 ChYgSDd17v24M7RXOMuM/UgXjvaRpSHgwoXANAJrhOUb4iVBcG+/T8eO7xQq59IS7MOP
 NI9YoWECyQr0iQZZHUnijZ0XeRP/YvwD+8KzpWMBvSuRTGmP4X8U4GqvQbxOectr/4qs
 hp3QHuqZTrf7WSLTJE76TWcyTVRIPfcvudEq13oHCo01akiE7MlFf41JpuT28IhIBSzg
 f8cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yke1moTzSkIzOaEZMIiHBombbaQXA0v8WYBWsgfC99Ma/2wZtTTEGhl85vA5ddoTuq0ZNcqIkSW3o@nongnu.org
X-Gm-Message-State: AOJu0YxUaUBpfCzIOiAPKdTzRYSEispbmZvpPNJ0bu7Gln1PRmzG28np
 XGXjugwaLgAKr0Vp1lVl5nflYrbSq8stMZq3g1dq15RW0KB+qzvwdi9aHyBRcZXqqi/uFcaKXs3
 ZZefRRKPMMo1u1kYi7Ny75r/KDBE1UOWzw2a5H+y2CKCB5vMxp8A7ZC72
X-Gm-Gg: Acq92OFmZDB8qEmHm57RG7+LiY/cGpg+J0nYEuoYHlBMF94AbmHYxZfU7mV1Wjiavk5
 /0MesnfhFdTezbM/DPMCgz2qoy4x1b4chnnvOiIFQlN+76mfuXzKw2Ag9avpkncdKJgsNMvxddv
 DB0kelXvLuHtzZ0CCD5dC0t64laX1vmmPGfLGdpZph4u0+IX7+It53aA2QH4fiF5XlEJ/ybUF8z
 TEs8MZCmdY7l3xv03xSVVh0LG/lnYABQuNtL2T0/f3q2Kyeg/JH0NFcaffq9P/Rm0G/jiAQ6nMn
 QxgIDqmxWj3mkkLnGcYB382uA4hHCtnzRcZtX+9EAZLs4w+cTz5eMEB/A71d5kB5avz9Uk/aZsU
 J47oGess3Fojtmc0gkxwbsBJq+GZH1Yplr3SpGVVOr1A=
X-Received: by 2002:a05:600d:8496:20b0:490:e913:656a with SMTP id
 5b1f17b1804b1-492333d8ae7mr6321215e9.27.1781631085382; 
 Tue, 16 Jun 2026 10:31:25 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:20b0:490:e913:656a with SMTP id
 5b1f17b1804b1-492333d8ae7mr6320565e9.27.1781631084806; 
 Tue, 16 Jun 2026 10:31:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923343cb75sm3583875e9.0.2026.06.16.10.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:31:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:31:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thierry Escande <thierry.escande@vates.tech>, qemu-devel@nongnu.org,
 Alexey Gerasimenko <x1917x@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 3/4] q35: Fix incorrect values for PCIEXBAR masks
Message-ID: <20260616133032-mutt-send-email-mst@kernel.org>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <20260313164649.794591-4-thierry.escande@vates.tech>
 <46238511-ed5d-4f2d-881d-87120e4a408d@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46238511-ed5d-4f2d-881d-87120e4a408d@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 16, 2026 at 07:25:52PM +0300, Michael Tokarev wrote:
> On 13.03.2026 19:47, Thierry Escande wrote:
> > From: Alexey Gerasimenko <x1917x@gmail.com>
> > 
> > There are two small issues in PCIEXBAR address mask handling:
> > - wrong bit positions for address mask bits (see PCIEXBAR description
> >    in Q35 datasheet)
> > - incorrect usage of 64ADR_MASK
> > 
> > Due to this, attempting to write a valid PCIEXBAR address may cause it
> > to shift to another address, causing memory layout corruption where
> > emulated MMIO regions may overlap real (passed through) MMIO ranges. Fix
> > this by providing correct values.
> 
> I'm not sure about the implication of this issue, - is it qemu-stable
> material?
> 
> Thanks,
> 
> /mjt

I think yes generally, but it worries me this has a high risk for
breaking migration if I missed something.


