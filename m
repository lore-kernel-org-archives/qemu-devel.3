Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC80C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wep5X-0001uo-MX; Wed, 01 Jul 2026 03:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wep5H-0001uI-0M
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wep5D-0006bM-De
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782889802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m+DRPsOZU4yBH0J9zgbY1z0jNe8ZOehkPXimPKTLSl8=;
 b=P6R7UhpPgf+qSjZuLuvKIS/qLk+Xnn0Aih3UHP4URnAn5u/IkD7Z7LN3JeCq9Zap/L57cm
 Qm27I45nBUrvUQBnekcgvItbYJ7Klcm8JBXzmWCeDr3WfpO07m+YDIIeQOsUhhg7cSpx2u
 BShFkjFH1ij7exA+B6V8vMKgUVen5HQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-IN3C4RbcPgWI5mFspB162g-1; Wed, 01 Jul 2026 03:10:01 -0400
X-MC-Unique: IN3C4RbcPgWI5mFspB162g-1
X-Mimecast-MFC-AGG-ID: IN3C4RbcPgWI5mFspB162g_1782889800
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493a6fe9ebdso1719935e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782889800; x=1783494600; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m+DRPsOZU4yBH0J9zgbY1z0jNe8ZOehkPXimPKTLSl8=;
 b=WX4RxYZZrp2Z+yX4aYEiWmlhwuLQD4128fps0zECWNov5OeiqEvUNE3TGlI1KEGWdw
 EmOyrMpQDvYtZbaQ65sBymxzrWDya01q7d2/NfT+COwbvSGXVWxRLGXYFKz/n/OE3hT+
 ccP6FLwBFmCG1bLVoCKG5066xzTD2ufU8qkWRdojS4opg1/HP7smpNDe7EByu5lG8O+R
 iH+L/DKA+RWf4bfWOLIGj6szZ5HqxeuUHZra4f0jDQgTp9eOqrQTQCkRNy06Hz7+GOte
 zK+z1XgEUa4iKI0lJLzIASOEvA5bpMiTAJo5vl14FxJiFYC4ArIeHoJj+pnZjBClXo9g
 Dorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782889800; x=1783494600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+DRPsOZU4yBH0J9zgbY1z0jNe8ZOehkPXimPKTLSl8=;
 b=gWw6W6Moh7KmYm8DYP9/ah3HcPcgbz/fONW0gGwFC0jceS6idwFhqHvSWV7Q1qHX7d
 UetPYjlc0kY0R2Px9xUsVZX1V1LnDQFkjdipE/MH8LctyXkDBdKKPXEsaiTC/iKVcMMu
 MYzmi8L3FRJ9QrGDIbibDu2UryX3/wi6uh9HFV490GRpfaXKRXGJnUdvXdcIw0Fs8TZw
 wtIAyZR4SkPKeGoMALD04/7S7nRgj/i7xfwzqzt0nBGeFhbojuHKes4zX6isuuVDw3IP
 MFom4YDeySrLfu82r7kjV5bDv3cE+oslIrHi0NgvovGtvQE3AdESlVFo3VMXQjVYcVUf
 eTAw==
X-Gm-Message-State: AOJu0YzBk9BKmQXOo0roNAu+mUCl5zlCQFv3WqSaQGRBPMbRkGbHVdWf
 pm9uhhVp8NG2zLl+qJ2JwPzh6g5UD81L3vx6/FdhaSTgMb+JJz5BadTzkRiK3p5Yul4SMblHctK
 /WRb10XcJitXmfAA6ict7NNkYLmcYBhmWbOLse6FODGZ/+/w7F9KV/jlb
X-Gm-Gg: AfdE7cloo6avHbvvEf+jrdXi+cIsmUJ0pqqvqH9V/cNrw1mXkbXIZVCST7cjaES0as9
 0R6nLDraq/ReMMeYM5+0npZ/8IC+e76vOhgoX+2LhesilbPXJpU9Be3EnbxgsCfUXIgPBgM/b1E
 aXTrZ5I8C2Sgx6hQzK4EihoD+t+9G7b3VrTFtYlgEZFr27Egr+gkHFL6QLQsLipkOFn3+UxB/P3
 yDQ1RSsa7ZVaWlmANzz5qGCm0YRE/y5UCMbqPQq/fRVU4F+9t01WVnuOregvP+NPWjXEJ3SuBSL
 6u206kGdFLQX7lgVC53CrDX0rmifMABtqBVRWzPTfusBK/8y9XBH8+3vp5/moEIygrropGXW7nN
 ELmBMVAA5Q41bR51erCbnOzbYp7XoJaMq
X-Received: by 2002:a05:600c:574b:b0:493:bc4a:9547 with SMTP id
 5b1f17b1804b1-493c2ba70e2mr3378425e9.39.1782889799694; 
 Wed, 01 Jul 2026 00:09:59 -0700 (PDT)
X-Received: by 2002:a05:600c:574b:b0:493:bc4a:9547 with SMTP id
 5b1f17b1804b1-493c2ba70e2mr3378045e9.39.1782889799182; 
 Wed, 01 Jul 2026 00:09:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4bfdd5sm92592455e9.1.2026.07.01.00.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 00:09:58 -0700 (PDT)
Date: Wed, 1 Jul 2026 03:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Moeko Tomita <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
Message-ID: <20260701025521-mutt-send-email-mst@kernel.org>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-2-tomitamoeko@gmail.com>
 <20260626062248-mutt-send-email-mst@kernel.org>
 <CAJ+pfRS5A+KMZN+c4SCDxcr1PuqdC1Ci7yiJieAR8Rxgiut=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+pfRS5A+KMZN+c4SCDxcr1PuqdC1Ci7yiJieAR8Rxgiut=HQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 01, 2026 at 02:47:30PM +0800, Moeko Tomita wrote:
> pci_patch_ids() is only called for ROMs flagged rom_need_patch_id
> (only ipxe roms
> and IGD), the scope is still limited and won't potentially impact
> other existing functions,
> it's safe doing it here.
> 
> The fix is targeted on IGD romfile, which can't easily go in vfio.
> vfio_pci_size_rom()
> simply lets PCI core to handle the romfile and never touches or sees the romfile
> itself. Adding a hook in vfio brings extra code duplication and complexity.
> 
> Moeko

IMHO this can all too easily break working setups.
What about multi-image roms, for example?
What about a padded rom file?

If someone gave me a broken rom I would normally just say "so don't do
this". 


If vfio wants to work around broken firmware, it's up to vfio.
Maybe it makes sense, I would not know.
You can keep the patching code in pci, just invoke from vfio
after pci_register_bar.

Not a big deal imho, and safer.

-- 
MST


