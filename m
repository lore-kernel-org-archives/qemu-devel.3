Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3266CC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 00:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKwz-0003Ou-JI; Thu, 05 Jun 2025 20:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKwy-0003Oh-Cl
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 20:28:48 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKww-0005j1-HC
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 20:28:48 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b2efa17ed25so2326447a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749169725; x=1749774525; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i3TxrRqR0I76iLnt2ucZkJXg4dmyNRw//DeN8cjiWKA=;
 b=Y0rF5Ibnq6ltA8KHZJjkQKSYsttBOyOriTWGihHWJKeQuxU4FU9ZHRXkfXHMCpdBdK
 q9qRupOkw3PM3q+QWEqd1EKojCzWQQ0odXJCiNBAKyeLHtSG8w/WpsScKeA+4YkSyieX
 63CGNgV0yDtF/B1zPkvU+j+dZRLhiAO73goMREJ3S9zJha+RBh7aeAqkCB/GkBnSgymw
 1E/3/925rQgTDP5YAb1ylCdIYVfmP3JbFGuG3Vhu1LZciqp6vSH+555LeKczOKQQc9rc
 ZeaqIdqF9VcQwOdMayDXHANj0kbNaU+3bamWvOeSFHU5HpG0/2RXjF3g2G1hQYfLIc9c
 EkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749169725; x=1749774525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3TxrRqR0I76iLnt2ucZkJXg4dmyNRw//DeN8cjiWKA=;
 b=b77kHJDz6XrQbHOB9irJqeiAPI+2CAHnTj7WW2iF1YBfL+vbFT5ZSoUFCZGD98r9FZ
 R0BzMk8oI2ltA0zkiQ+2qF78OdESPc9ycJGSq44Mln0fsmJ/J9RfSCxp9L087QYtUo5P
 cJeILYn4/M13TaaWg3Nu+UpvTO536QIJP1ZtDGnsryvnddi+feffBsP3hcnyJp7CmG4b
 jmTKvD/Eaz4fKbkEB1sGhTEmJHtfgEON2GGQzcoiQ7jBRfz1X/vWr1ddZDY4sJCLUypd
 d5/4V2oGmWG+T6U0SwuChOCfTup83ZfaJhfRVAuPSewEBvwau3HmtGcNe7fjHur539gx
 L/LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkBNASFXStHU+/K8djgx1Qpw07G4hRJu83ojRdCNs838Zp6AhUg8j/h1SA4JYk1OzG1zDavJapdJGj@nongnu.org
X-Gm-Message-State: AOJu0YxsaBvx6Q9IhS3rMJ7bng3m0Mojv6mrbfBVJhG6+3oy6+PbD2Qx
 OTu3t+2mhpIQ9Y8fQX3Hsd/Q0kTSVCiruTslegPIS268pIkuT01c5Om+
X-Gm-Gg: ASbGncvNqh4wOGjLiEuJrsboCLJsSzPkJnz3PbSoSVK8yyouC88RBiBNI7W+EVPyPbM
 NRFAzWiy7c0t9+xXIDK2e72se5VtLj6fkuMew/4lZR0nWYF1iRVRqOm5+0dxQuY1DTUWucO4ifL
 BQceyfoJi8Jxkdfn5SJJh21TlvNqWEiZUfd3MzUpA6fsKuNM8bDFZzSLDAXXZdiAPuGgrOVCnFx
 uyDyi7Z9xpk36l/zz76ZLhXvSnNmzHvRAbTrUxzL1giEG1dor4B7f7wa9XaeunYCgT96uwnhkz9
 AXvOZdKf2EG2RMu9j0E/8O5ksJJCl481SCWmeWeH+aF2P7IU7NzVWKeQF4aBn2fyR354YPEEkWE
 DVi/yek8Tuv4W
X-Google-Smtp-Source: AGHT+IHhXDTTL9IQxG6AeE/7Rhc+nTeeWJszgfYp5mAP+Tad2iQqBJ0bjydFNuMUl8FB8KiS/+Y1pg==
X-Received: by 2002:a17:90b:1a8b:b0:30e:9b31:9495 with SMTP id
 98e67ed59e1d1-3134cfc9fd0mr624175a91.9.1749169724848; 
 Thu, 05 Jun 2025 17:28:44 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603506d4dsm1778845ad.235.2025.06.05.17.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 17:28:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 00:28:42 +0000
To: Anisa Su <anisa.su887@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron via <qemu-devel@nongnu.org>, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Message-ID: <aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250520143947.00000337@huawei.com>
 <20250530152655.00007132@huawei.com>
 <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=anisa.su887@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jun 02, 2025 at 05:46:57PM +0000, Anisa Su wrote:
> On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:
> > On Tue, 20 May 2025 14:39:47 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
> > > On Thu,  8 May 2025 00:00:56 +0000
> > > anisa.su887@gmail.com wrote:
> > > 
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
snip 
> > Anisa,
> > 
> > Ideally I'd like to get the majority of this upstream once you post
> > a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> > These commands are equally valid via a switch-cci (and that path to the
> > fm owned ld_mctpcci is already upstream).
> > 
> > If you could send it as two series. One of which sits on upstream and
> > doesn't include the i2c_mctp part and the other of which is applied once
> > that support is available in my tree that would be great. I'll squash
> > the i2c_mctp part into the patch that adds support for that in the
> > first place.
> > 
> > I'll deal with rebasing needed for other command introductions etc.
> > 
Hi Jonathan,

I applied the v3 patches (which are based on ToT master) on your latest
published branch cxl-2025-03-20 + Fan's patch fixing dc extent tracking
and then edited the first patch to add the i2c_mctp stuff and rebased
the remaining patches on top.

Would it be easier for you if I send you those?

Let me know, thanks!
Anisa

> > There are just enough open questions in this series that I haven't done
> > this rework directly (though I did start doing it - hence the missing
> > include note in one of the patches).
> > 
> > Thanks,
> > 
> Sounds good, will do :)
> 
> Thanks,
> Anisa
> > Jonathan
> > > 
> > > Jonathan
> > > 
> > > 
> > > 
snip
> > > > Anisa Su (10):
> > > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > > >     DC event types
> > > >   hw/cxl_type3: Add DC Region bitmap lock
> > > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > > 
> > > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > > >  hw/mem/cxl_type3.c           |  41 ++-
> > > >  include/hw/cxl/cxl_device.h  |  24 ++
> > > >  include/hw/cxl/cxl_events.h  |  15 +
> > > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > >   
> > > 
> > > 
> > 

