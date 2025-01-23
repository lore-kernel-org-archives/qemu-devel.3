Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01825C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 15:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taz3R-0000ku-Nr; Thu, 23 Jan 2025 10:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1taz3P-0000kk-L8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 10:23:35 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1taz3N-0000RR-UP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 10:23:35 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46901d01355so10184751cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1737645812; x=1738250612; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjEaypsuz30K7ptqs1a56KzoE/dpYJ3kzMwZ+SzZO90=;
 b=o7RalN/6LgEbzVDTr5fSqgZjfkFlmbafMdOteSzynGtAzaMt2x1c0JjDiedmThbmh5
 9E+F9gJPvILhGDlFsqOidthfwJtKsF2ctuR1Z6FuDh0z2lEDawk3OmSyLSyEUOtJlJPW
 g54Q2/OqtHVfZAnASowmwgHEJVN5P9OYxSefe2r4WSzl3Sit7H/jv9j01I3Qv+U7inVG
 F9WA1KuA+iJelBArxfboaDeb85fJBJhrC023SY+SLJCGmzEuTMDCHmcGge/yRm/sRVlJ
 r18JHrzCkcrDC6F1VS3tYm4pcIFWQBsOElSEQfdnHwM5scN3jJVzf9w76DWafxZP2Upc
 joeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737645812; x=1738250612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjEaypsuz30K7ptqs1a56KzoE/dpYJ3kzMwZ+SzZO90=;
 b=rHWrOJXuinwj2A1HiCmrWzMOZmQyO6ainPa8D9ZX1UD4ecug4HbFqNb36F6MBJmRA8
 wYMVHBwm2bSzOpBI7JBVZEiUJJqno1Ukqo8+dnUiKpBXDAAtDZl1bXdIKb79w8BzoEej
 pP0ruJodcJS9rRYhJc5JF+dUZYXLgdU/Jy4U+xDBnEilPUC51wwFyThksLo9PKfZIqTA
 1QI4xFpOZYlxkgREmgdK0M89zADYnkgOVX+WI67nSxi5iPvVFyO9uOC53ssSDxa8rvlX
 CtPhrvZqN0yBBUzxXc4JhNYwrC2NDOVQ6J0SR9XfbFqqpadyUSaj4D4giA90vActHqJd
 wqrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoF4Yqf5rEbXOug3uoqe008s+HtvvrGGIrbkg7Ugh0aqFxhQKlrFzgEtKtQIuAdiPZ5ZQdWflmF6Zq@nongnu.org
X-Gm-Message-State: AOJu0YxxWfJXvJYb+2rH5R+vuhDGjl5hut9UONiXfFHh8q2ySI8aDdQ6
 yfi74AHG2QMkpmArlioG/iTbTLToWtBDjjYAunaZKYmI62flsJrUBt3/BsN09DA=
X-Gm-Gg: ASbGncv9T57QwNjFzBZaYTg0bEtA0pVTybwkFqmNrSw8fURDx0UwJ9nuBa65EA08YVh
 uNyVWKuAYw8TQp7A4egeOXwxbHVCC33lcnQz7aNQvafIAkKaKApYa1qI3kjV8dIlSb9qY2QF9qQ
 F9bsxFm5+Z0mO/vnvlaRkBx06QspGROW8BITL3CrzlQPiQSemp2aaG6hkfCu2C3mbr9+YqHivwV
 dOfYxTWsGwqjD+RTT7VTHlXogJMU1JKRjOYVhbPlhfVP7qnjPXGMUN8wmY6Oifrz9HF7XEjl/f8
 NlqhpBo/6+FfjAezpPa8N0q+0ckk9YCPu9/uonijLY5hzCDFaXtaoexXhG9heJg=
X-Google-Smtp-Source: AGHT+IH0KcoGKqmDsUgTF05dHZJcCCc30ZfWfCukf4fZycbhyLEokFwxuPHzWPHV33Tlg8kQ38x5Sw==
X-Received: by 2002:a05:622a:292:b0:467:b7de:da8a with SMTP id
 d75a77b69052e-46e12a2c4e7mr401054231cf.6.1737645812180; 
 Thu, 23 Jan 2025 07:23:32 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e2f67ea89sm49249971cf.10.2025.01.23.07.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 07:23:31 -0800 (PST)
Date: Thu, 23 Jan 2025 10:23:30 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hongjian Fan <hongjian.fan@seagate.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <Z5Je8gZb_7pTQ1RW@gourry-fedora-PF4VCD3F>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
 <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
 <20241224151315.0000068e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224151315.0000068e@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Dec 24, 2024 at 03:13:15PM +0000, Jonathan Cameron wrote:
> On Tue, 10 Dec 2024 14:13:29 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> > > Hi Jonathan,
> > > 
> > > I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.  
> > 
> > This should not be how this is done.
> Agreed, but...
> 
> It sounds like a pre DCD boot time only pooling solution?
> 
> What is the path to adding memory?
>
> > 
> > The ACPI tables should report the maximum possible size, and the DCD
> > infrastructure should enable physical regions that have been added to the host.
> > 
> This isn't the ACPI bit, it's just the device reporting.  Can have a huge
> CFMWS and tiny devices.
> 

If the device is booted as a 0-memory device, how is the CFMWS populated
with the capacity needed to back it? It's all coming from the same
tables.

You poked the right spot in their post - we need more information about
how the memory is added.

If the intent is to just increase/decrease the capacity of the device
on the surface, then the only method I can see here is "tear the device
device down and re-initialize it". At least then - I think? - the driver
will go off and create the appropriate resources.  I've played with this
in QEMU previously in the past, so I *think* that works?

If it doesn't do that, then they'll need to go off and basically
re-invent DCD for their device in the driver (or via fwctl? yikes).



Side note, after thinking about it: a 0-memory device at least lets you
poke all the control bits without having to care about the actual memory
piece, so maybe that's useful regardless.

~Gregory

