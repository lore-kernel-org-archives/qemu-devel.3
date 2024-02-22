Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0616FC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCLV-0002sD-4M; Thu, 22 Feb 2024 11:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdCLU-0002rl-4R
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:54:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdCLS-0004s6-KD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:54:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so39266795ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708620889; x=1709225689; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=csa0J0V6+LFxDu/YR9wQBUMQygQKV7FR3Ss/i1Z/wf0=;
 b=W706JDey6vwVOa5wbMhVl1lMg1oXUYUJO1j39kG6PEsdNCL49TzbMX5YKZCiShNebJ
 Dz2WHFALZaVhtScofwzsVWlwJ1BQtvrdHjjaj/7x6FCr4cB8vzEuqUFmcMu4bmn2qYC2
 nt5LNzRMHlMG/FuYTljpnUTvsth8wBUxp1u94h+/XyU7zwenuc7XAc7FQAA7hFGnuysu
 lSolfxxJmbRwhh59Hfn8JU+5jjGhlKH3E0ub0m/FXJSIxXlKHJvSWjli+VE6XsdOBOTM
 4WwaajV3ZDDe4107QgDP/kvgdemqyAETMIafEdjuqU/g1A+4gd+w7sMpJr2+qjhzfBn5
 pKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620889; x=1709225689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csa0J0V6+LFxDu/YR9wQBUMQygQKV7FR3Ss/i1Z/wf0=;
 b=p1mWNeTJe9e0mgXNxUsD36wx5U10EwexkMz0FtNd7m3XKYLYoQ4U0EAswzINrUCbPE
 NERu6IZ0GmURa0pSSaSYwp1LM0Rkhi6E98Wn11KtgXegfwMxgO91HPr2qEe1B4dssnei
 jH33gWzGdkBIEUxs2y7ebiECpv5M6KCUe4ZcTR1+Hg2uH6Jojo82IPgfiQ7M40ds8sIN
 Y3gCfR7O7p43DYGmmzyytwddBqTjGxNXothTr4tmsNyr+VONj5ShLvbEMGgNszg0JvlY
 HtGV5tiZx7buMmD1qTTjOzb3+tXf1tGUt/r+HpxUsyXPIqCwpwDX57h0LWVIZJnH/Zg/
 Q9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZuMDkJpvKLnBFa8X8+xGFzWya0pUUnWhIFaPVB2EP88r1dpVBCgOg0DH5heMDzH0AwDo+BuE4VlWeKPADk8SZAXP6zpg=
X-Gm-Message-State: AOJu0YyWAWv/aZzbt5ff/D0PJNR67bUZWEtEfZDQ5MaLw4ekJFc9xqv6
 TDrRpNAN3pQs2ZlbLQqnAKunn98z2uDIG792cGuZZBez8Nc3Kk80
X-Google-Smtp-Source: AGHT+IHbMfXTG1dtFPimRpl1wfxBamgRiDiQPfpcwamC/Z152FCaKxp4v/HWD0LQvC1NcRJkILrTkA==
X-Received: by 2002:a17:902:700c:b0:1dc:2f63:dfc6 with SMTP id
 y12-20020a170902700c00b001dc2f63dfc6mr5085045plk.53.1708620889083; 
 Thu, 22 Feb 2024 08:54:49 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a170902761700b001db8f7501b1sm4676735pll.2.2024.02.22.08.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 08:54:48 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 08:54:25 -0800
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 Jim Harris <jim.harris@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <Zdd8QZk_fDUs1S6E@debian>
References: <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182126epcas2p1b684f9239e4262f17ff484939658a382@epcms2p1>
 <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 04:45:25PM +0900, Wonjae Lee wrote:
> On Wed, Feb 21, 2024 at 10:15:55AM -0800, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> >
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  16 ++++++
> >  2 files changed, 126 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ba1d9901df..88e3b733e3 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -22,6 +22,7 @@
> >
> 
> [snip]
> 
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    /*FIXME: need to set valid values in the future*/
> > +    stq_le_p(&extra_out->num_extents_supported, 0);
> > +    stq_le_p(&extra_out->num_extents_available, 0);
> > +    stq_le_p(&extra_out->num_tags_supported, 0);
> > +    stq_le_p(&extra_out->num_tags_available, 0);
> 
> Hello,
> 
> It's a trivial comment and doesn't have any impact yet, but shouldn't it
> be stl_le_p()?
> 
> Thanks,
> Wonjae

Hi Wonjae,

Thanks for the review. You are right, will fix in the next version.

Fan

