Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF81DCD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDMC-0007vE-Dy; Mon, 15 Jun 2026 15:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDM2-0007tU-D8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDM0-0006kL-DR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781553134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iW2O3Arlf3qHNxDiahWee/RaVc7qOF9kDwfA1DqcqEQ=;
 b=hqHlgRK+uSW7jQ9c8ahk3EDaLWLMb55j71WN6lRHfBOikbGeWvVsuWyF/QEWJzQYnnKTHh
 Pjj8emBwrueDYogOqEaW5vCtb8S93illXOyQ2FAkbKp8cuFsAwYRqLgWvibgR5cZnxtVMK
 6jKTOKHksHj8pp75W8oGTckEKpBWUWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-2-tKs51ONme2sxbv1TnAQw-1; Mon, 15 Jun 2026 15:52:13 -0400
X-MC-Unique: 2-tKs51ONme2sxbv1TnAQw-1
X-Mimecast-MFC-AGG-ID: 2-tKs51ONme2sxbv1TnAQw_1781553132
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso36473295e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781553132; x=1782157932; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iW2O3Arlf3qHNxDiahWee/RaVc7qOF9kDwfA1DqcqEQ=;
 b=L4Iaz6DuDQi2tGgWzmyTqL6UQTzMjk7WXVzfXH0MxQDhd+QXw7fLiiRvUf5mfbpK2X
 UGzzZnKIHqXEjbwXYnNbDtNZdPbCkVB3NjoFvy5bmZy7w7w+m2cG5wyls5lIQigsvlM5
 tG0mfZ1wdxRq3fkgsI3qakLtBK4j0bc9Z7z32+8R0JAfrsQ6yy4hg4mikuRbpU+5Kmdj
 DPBEGaCxp4VGeznKfANoYSwyHGlEFhuy/Gf7mTZ2OjLYu4aEPBGtI5GIUHD5HyiAKNFT
 D6vDgRwraRYFeVzqb+7PeAntAd9O94FDqO/Cfq0ZON3sqQUDGx04kz1er33fn/UG7Z6C
 Wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781553132; x=1782157932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iW2O3Arlf3qHNxDiahWee/RaVc7qOF9kDwfA1DqcqEQ=;
 b=ec1IfNVBIZbPSng2OtPsGf9lQMWJnLAe8I0+eWpBPPmtFx2YCX9ZTngpGW5Eh4sHg9
 fx6vJDNy+65GFM2BE6/W2iINlZNqx7J6dteGQ0e7rIu/e836TZn1qaI/aquFNDuH3+MU
 eji/j3fSfb/szshZ+gAeC3Tqo0xAmzsWov+8+kKdIcPn/9VWokCKQbmKeq/Cxs9ey2XA
 Bce9qON4kTibDmx5I6c+TEqXmXnx6fOV24QxDvWS9lqm2xXRtLToec3svnft80lmcONy
 /UMM2EMk9g7zma2YqiSRdDmjC61yztrytqGe9rBnYcc3wdcQkIe8/nz8RPBQ/xBV/LGV
 yVww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cKUKddYuUk9vxbuhz6eGANlTtwMmKat2/CgapikVZoFCKYKvzQXDYsODrN4orY/8bMcbWO5mMyo6s@nongnu.org
X-Gm-Message-State: AOJu0YyWXxzizuWHhdnPgmabO4QL5n60j42wyiD1Yxw0iLJaaQEnNaD8
 R7zTVi27MtHX1hTEliuFeH26PTxJcahSvqFbK16TPpNe6I8BNNMS69K9p+krgqpll9oV+gf/OLj
 dy/3YwPvaZMibvFGIlpJHocJI+UwM7liA+mToEbymwIMiwJRGM+7Sxlpn
X-Gm-Gg: Acq92OFbJh/ib4/vplbMMY2+pULG/aUjyuZlY9Ysz0l25Hiaj4NMKmxvf/E7KG8uKCp
 xPl1URddjXwS8WcmSPH0pAC9so25LYMvh6QiFIkYI3Ei1GWAwmLzRcv3cNm5lsU3QoHPGmxM4cW
 rc22hoTyUprRH4dZSdhUqICOCSSVbf+071n3b66LodkSgpv/ntVFlUWDJWYFScRtbKhOab6+CRs
 Hk/Jn6f64rIFRHoLxJIWKeATpf21NrsYjt6VFpSNBx7o434w+3DXhNdvlrmNmNJMsdr/NsK+R1n
 /jPCaO6JMA/Ragr2Un4HCDA3lR0NJBdA1iI/abwhGWx3HWGWCfUAlahy1yVMRP70Gm0Qluv31g7
 aMHeRzPtSj3lbg1YD2S/WsRqs35wWsOhspeL+55F4UGI=
X-Received: by 2002:a05:600c:4215:b0:490:bb3e:30b0 with SMTP id
 5b1f17b1804b1-490ec4c0ce3mr127252265e9.4.1781553131643; 
 Mon, 15 Jun 2026 12:52:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4215:b0:490:bb3e:30b0 with SMTP id
 5b1f17b1804b1-490ec4c0ce3mr127252025e9.4.1781553131229; 
 Mon, 15 Jun 2026 12:52:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm37889839f8f.8.2026.06.15.12.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:52:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:52:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260615154913-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 15, 2026 at 04:12:40PM +0100, Peter Maydell wrote:
> On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
> > > On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
> > > >
> > > > All ram device regions were turned to be indirectly accessible by commit
> > > > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > > > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > > > guest is started by the following command lines, with GH100 GPU card passed
> > > > from the host.
> > >
> > > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > > index 1417132f6d..5878727d09 100644
> > > > --- a/include/system/memory.h
> > > > +++ b/include/system/memory.h
> > > > @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> > > >  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> > > >
> > > >  /* Internal functions, part of the implementation of address_space_read.  */
> > > > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > > > +void qemu_ram_move(void *dest, const void *src, size_t n);
> > >
> > > New function prototypes in include headers need documentation comments.
> > >
> > > In particular for these, it's really important that we clearly say
> > > what semantics we are attempting to provide with them, so that
> > > (a) when we're reviewing or later updating the implementation we
> > > know what we are trying to provide
> > > (b) when we're looking at the callsites we know what the function
> > > is guaranteeing to us and what it is not, and thus whether it's
> > > OK to use it or we need something els.
> > >
> > > > +#if defined(__i386__) || defined(__x86_64__)
> > > > +#define HOST_UNALIGNED_MMIO_OK 1
> > > > +#else
> > > > +#define HOST_UNALIGNED_MMIO_OK 0
> > > > +#endif
> > >
> > > We need to do something better than this. We can't
> > > just say "oh, we trust that on x86 this works": it is
> > > neither actually true that the compiler guarantees it
> >
> > sorry guarantee what?
> 
> Well, that's part of my point about "we need a doc comment":
> what exactly are we trying to guarantee ?

we are trying to guarantee that host transaction sizes match what
guest requested as closely as possible.

> But whatever it is,
> "hardcoded ifdef that privileges x86" is definitely the wrong
> answer.
> 
> -- PMM

why is it "definitely a wrong answer" if a specific host architecture 
supports originating transactions that other host architectures lack?
should we intentionally break setups that could initiate unaligned
accesses and work fine just because some other setups have hardware that
simply can not initiate unaligned accesses?

-- 
MST


