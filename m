Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA7FCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8k5-0003PH-Qe; Mon, 15 Jun 2026 10:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZ8jo-0003NE-15
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZ8jl-00083Z-0F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781535384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztWkk3Xpe+kM9d9WYrvzWIt2WX06LB0jeIufZc3Qy1Q=;
 b=GovBKd8b22FVH5EHwnyZdf/x3BIm5Y9wntiO1csGQjMr08izwcWw5t6NPctHmf6G/121lR
 wsmeq36DJ39ysZ5sTNJSioQsmRAFXjRUbyx60ebmjbv9824V2uYXlo/EK4LQQMDDRPb65y
 hDy7ldy/zNem+rOsxHhFC9JY6kplwuQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-B7s80o19Njmv3Y6zi_CWsw-1; Mon, 15 Jun 2026 10:56:23 -0400
X-MC-Unique: B7s80o19Njmv3Y6zi_CWsw-1
X-Mimecast-MFC-AGG-ID: B7s80o19Njmv3Y6zi_CWsw_1781535382
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-68bc68bc910so4238627a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781535382; x=1782140182; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ztWkk3Xpe+kM9d9WYrvzWIt2WX06LB0jeIufZc3Qy1Q=;
 b=evvQwq8lcz5UMuu/3kdtpHwscYIPy8d5DB+hCjR37eN0FyIAKgrEE8zD7xOQmEiUR/
 hIakEh+RghsA47wcDNoHVi90YJEPQgkj7On0PgBa8DUWqx1ixd9P8w2n3SuXdEyE0WrE
 +bNiZvFMiQYrYmO0ZR4YHE63SThnyeLrP7fGFnpXOru6QIR0J4lXbbrbh1et/kN5fT6/
 3T/lhY9Jy59Rz4Vu9pDLcmflfk9RHhPtIIaQdkqZWCpSdj1dAmlD+8GaAdMCnFtIX8F/
 7sh9VNd9PwWHp8Xjtusradkm49aELz++5ItpZY4s2NLNHKX7XznCz7vOHH1kQSHv8cvE
 3GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781535382; x=1782140182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztWkk3Xpe+kM9d9WYrvzWIt2WX06LB0jeIufZc3Qy1Q=;
 b=UqY6muGrHt1JDVh65/h4xDk8JlkUmywf7CgjE83YABPVG9i5An4zurC02hYqqb6uxg
 dSDHD8eztSPGve8XTmtW0ln/ganReHGZrxEGdAQ/IpfMaimy2ZA4JHB508foxSBv/dV0
 IVI+NqzWcnxgqfKEoebulYUFDb606G3ssClos5ZOf0LWXWLNU10XMCnXmi5HEIoZZ67p
 BNWqRUaCIpT0FY0LnXMcRiZaNjhiruLchvaSL5bEl+xksIb5MYyvsrQJdHDJ/wlnCQpu
 +hf8MBJVUcOUaqs5JhgpuybiAWZNcUiu1Iq6mYOe5Vt5ockrx+NjC4H594GWFoKLa1f9
 x/HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eHPhaiE/7c/rFOSmbjdXXIAbqIr5ln4JbF8ICZhSfRv59Emmg2NftxL+VZhsIrNfAFOdQQTvp2szb@nongnu.org
X-Gm-Message-State: AOJu0YzjgXUae1zKd5VCsfIQYG1N99hl3pU9afcDlOTmfgEAVj/0fXaG
 RUFGwMev6GUE/BAHhnZRL5FZaJYn/10f1hw2xai0FqRzZ+7Mh2vUwkuW79drJwWWinKPPQ80Tzw
 TDIO6WjgFAFW2ZfPTWk1HZoWC9WODW38p1GUqyn6189/RwhTu/CjC0dq3
X-Gm-Gg: Acq92OGj/ivY7BN8LEtKcdU2qrp0Fpv6SbjLpLoSFhGmUpWiTW5zjyd5ud79iUWwwZy
 X91yGk9Hoplqu0RqEq8L7B/hmWg20tuJ9jj8NLtJdGndM9uTlIKLxGuCEvzbPbHLOhp/i22FcvB
 3NY5TB9Q3QNL1uYv8LVOSjs1OBS2VCcW/1FNYVFE655UOJyrPKl5xozkRW38YP9EhJUIHMGRUaX
 qYMaY2SoZrXCPdRoJB2ah0xOPy+k1K1iyaSvcTuQecMJq5v/DvFsie/Mm/Wk+TgLKpACEWBB4LB
 vbx+MzEaLnpYzo7ip4sXcqBY6dgmDKCGErhwEM6astpaOgjQvvh8h0nSoxSwufvjUqP74r7GQlH
 TtraV20utv/+ou7F5AfDZunh9KYOgu1oEkCvntKN8GvU=
X-Received: by 2002:a05:6402:44d7:b0:671:9dec:ba3 with SMTP id
 4fb4d7f45d1cf-69369d7b16emr5140872a12.13.1781535382117; 
 Mon, 15 Jun 2026 07:56:22 -0700 (PDT)
X-Received: by 2002:a05:6402:44d7:b0:671:9dec:ba3 with SMTP id
 4fb4d7f45d1cf-69369d7b16emr5140850a12.13.1781535381579; 
 Mon, 15 Jun 2026 07:56:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-693791de4a6sm3546295a12.9.2026.06.15.07.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:56:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:56:17 -0400
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
Message-ID: <20260615105556-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
> On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
> >
> > All ram device regions were turned to be indirectly accessible by commit
> > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > guest is started by the following command lines, with GH100 GPU card passed
> > from the host.
> 
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index 1417132f6d..5878727d09 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> >  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> >
> >  /* Internal functions, part of the implementation of address_space_read.  */
> > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > +void qemu_ram_move(void *dest, const void *src, size_t n);
> 
> New function prototypes in include headers need documentation comments.
> 
> In particular for these, it's really important that we clearly say
> what semantics we are attempting to provide with them, so that
> (a) when we're reviewing or later updating the implementation we
> know what we are trying to provide
> (b) when we're looking at the callsites we know what the function
> is guaranteeing to us and what it is not, and thus whether it's
> OK to use it or we need something els.
> 
> > +#if defined(__i386__) || defined(__x86_64__)
> > +#define HOST_UNALIGNED_MMIO_OK 1
> > +#else
> > +#define HOST_UNALIGNED_MMIO_OK 0
> > +#endif
> 
> We need to do something better than this. We can't
> just say "oh, we trust that on x86 this works": it is
> neither actually true that the compiler guarantees it

sorry guarantee what?

> even
> on x86, nor is it the case that only x86 can do unaligned
> accesses to normal RAM.
> 
> thanks
> -- PMM


