Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E1AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAslk-0003kM-DW; Fri, 02 May 2025 11:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uAsli-0003iJ-Ji
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:57:42 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uAslg-0002B1-Nu
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:57:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso2288887b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746201459; x=1746806259; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SKI/MbhgySCmhrgKFtZDoE5nt+OFW0JQ0ZIGxBLEsXI=;
 b=QdpZTSrM+9Tg8J+pj33sl710xtcz2F/4njIZaHuAJWBbKGkKKbSckihdnr8yV6yCJC
 NtTOujStYK+f2aNCwyvDhrBs/u6TPO0Z5W4koyUuk7hxs8IvyrACxdAKkI8ELY7B57bw
 jQLDok+tZJ0TJ/57vTl43m9FlyREWHjI9QQy3yhRrk8TfqCqyiliIQVZgpiwWir39h87
 9c1ZtE68/8ZBmw4zD9pKoAESl9q6j1jqxqj5yyW7Pcy7nVCsVduxN6hhWYQtWXL7bnXk
 CpAyyRgKtpecvRTjQEoCZ6TI+0BAoIHkK6KwnHertwIksWCiHs6pP1nhWSSIG+VJZpvq
 AsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746201459; x=1746806259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKI/MbhgySCmhrgKFtZDoE5nt+OFW0JQ0ZIGxBLEsXI=;
 b=sUSuS9Gt9wxlY4wTwen/y94mSPD5ii9lx4Fv3IU8fECf/THGu3FmLNqnHmV/1t2dB9
 Fa7RBpYj9zCDe3jJVlovJ1xFrv/im9EbS6d8d1PNrpPHaO4LkID8js8R+vlO2E6MAyEF
 Wm92TwbYLVUlp0gySl1NbovKvIJgxWdxR80A8+ahhy4ptq9QdIe+nBRaRxyfSKivU+sr
 Ia/0+lWEvrD91TFcE0F4PV/hc7jhgMId9sRzuDLr43tDnCkUgAIw3Kms0AZ9Wz1APW/w
 WWZAwToUakLTY7uu77XNO58QAYGKdC6ZueMKUV29UbNgUSGJ7QtjHKpkUgp6pLdtdI3T
 c8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwN61dotSbKu843WMruHNEZHmtzuQ+lmG0bi299dHx+s+tXtgYqqJQ/k1qoPybjpqPTidEdgTpvy2r@nongnu.org
X-Gm-Message-State: AOJu0YxkRUlcatbhsUFtvCbVO1VMvspnjfnSBlS0aBsPZ9bDba7Z4EiS
 AYTTnPJAoeJQ+9Wd2tqpUBDrWqNV9rrOO4ebICV/TTrAo5IoF/El
X-Gm-Gg: ASbGnctIUH5Xum8jPgeZcVCZ6jPq1FEwD17AHvfa3zDKYpbgwCjWi2syNe/jLXm2L3c
 ws3A5qPHI8PVZAmkmXPEAqW6CPs0pcGBE6RDVkM3BbUPRCOs8lYdOYGbjne/zW8I09xfhYFv8Ar
 y26n+8XWSz/E8oC2z2bMxilqvv7aGoq75YAqKSBMTFCwkxqJcuFGE6Oedw8uLluAdDegcXlLpiE
 hcgSqQ6C109GbvL8XwPkURXuw61Q7oyzJXDLa4JW8aP3vA8Ec+42A6uU+R4MW9xtJGlN/9wmHcS
 TbQfw7kqRwwFdYvXNcmE0tlNC8lCI2She7A=
X-Google-Smtp-Source: AGHT+IEcEsQw6DDjDO1IrU3xSR2eU71FKhRhOXQq20kZDhL5FaIBZhp0SpvhObynBb6E3jhHc0QyGA==
X-Received: by 2002:a05:6a00:1d9d:b0:73c:3060:d53 with SMTP id
 d2e1a72fcca58-74058afcf0fmr4676786b3a.18.1746201458921; 
 Fri, 02 May 2025 08:57:38 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590616ffsm1791307b3a.140.2025.05.02.08.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:57:38 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 2 May 2025 08:57:36 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, anisa.su887@gmail.com,
 qemu-devel@nongnu.org, dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aBTrcAa9yt8lGHJO@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
 <20250424114259.000000a0@huawei.com>
 <aBPV80J9TULzRslk@fanair.local>
 <20250502100155.00003bfa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502100155.00003bfa@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 02, 2025 at 10:01:55AM +0100, Jonathan Cameron wrote:
> On Thu, 1 May 2025 20:21:56 +0000
> Fan Ni <nifan.cxl@gmail.com> wrote:
> 
> > On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:
> > > On Mon, 17 Mar 2025 16:31:30 +0000
> > > anisa.su887@gmail.com wrote:
> > >   
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
> > > > Add dsmas_flags field to DC Region struct in preparation for next
> > > > command, which returns the dsmas flags in the response.
> > > > 
> > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > ---
> > > >  hw/mem/cxl_type3.c          | 2 ++
> > > >  include/hw/cxl/cxl_device.h | 1 +
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > index 731497ebda..452a0c101a 100644
> > > > --- a/hw/mem/cxl_type3.c
> > > > +++ b/hw/mem/cxl_type3.c
> > > > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > > >                                            ct3d->dc.regions[i].len,
> > > >                                            false, true, region_base);
> > > >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > > > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > > > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;  
> > >   
> > Hi Jonathan,
> > Thanks for the feedback.
> > > This is relying to much on the ordering of creating fields in
> > > ct3_build_cdat_entries_for_mr().  
> > I am not sure whether I understand this clearly.
> > In current qemu implemtation, each mr (ram,pmem or dc region) will have the
> > whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
> > to the right table entry, we can get the table correctly.
> > What do you mean "the ordering of creating fields"?
> 
> It is an implementation detail only that the first bit of that table is
> the DSMAS entry.  I think we shouldn't rely on that.
> 
> > > 
> > > I'd rather you just stored the information flags is built from in CXLDCRegion
> > > and then built the field that is wonderfully called 'Note' in the DC region  
> I got distracted by the spec oddity :)
> 
> > This sentence is kind of broken for me, not totally clear what you are
> > suggesting :-(. Can you explain more?
> > Are you suggesting not directly take dsmas->flags as dsmas_flags, but
> > use bit op to generate the value used in Table 7-66 in cxl spec 3.2?
> 
> No. Just store the various  bools etc that become dsmas->flags in the
> CXLDCRegion structure directly rather than reading back from dsmas->flags.
> Probably as explicit bools etc not a single value.
> 
> Then pass those in to  ct3_build_cdat_entries_for_mr() .  Mostly they overlap
> with current true / false parameters that are hard coded.

OK. Since some flags are not support yet, can we hard coded them for now?

Fan
> 
> 
> > > configuration in 6.2 spec.   I've sent a mail to see if we can clean that  
> > 6.2 spec???
> > > 'what is the field called' question for future spec releases.
> > > 
> > > Whilst the flag definitions cross refer the CDAT spec, the actual locations
> > > of those flags matches, but doesn't cross refer so maybe in the future
> > > we will have other flags in here and locations might not match.  
> > For the flags stored in dsmas table, do we expect there can be more than those
> > defined in Table 7-66 in spec 3.2?
> 
> Not for now. Though I'm sure something will come along at some point.
> The comment is about there being particular reason the flag locations should match
> between CDAT and what we report via the commands being added here.  The definitions
> of individual bits cross refer between specs, the register as a whole does not.
> 
> Jonathan
> 
> > 
> > Fan
> > 
> > >   
> > > >  
> > > >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> > > >              region_base += ct3d->dc.regions[i].len;
> > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > > index bebed04085..81b826f570 100644
> > > > --- a/include/hw/cxl/cxl_device.h
> > > > +++ b/include/hw/cxl/cxl_device.h
> > > > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> > > >      uint8_t flags;
> > > >      unsigned long *blk_bitmap;
> > > >      uint64_t supported_blk_size_bitmask;
> > > > +    uint8_t dsmas_flags;
> > > >  } CXLDCRegion;
> > > >  
> > > >  typedef struct CXLSetFeatureInfo {  
> > >   
> 

