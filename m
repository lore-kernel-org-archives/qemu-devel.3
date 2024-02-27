Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A451C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reurq-00014K-80; Tue, 27 Feb 2024 05:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reurn-00013I-4n; Tue, 27 Feb 2024 05:39:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reurl-00088U-MC; Tue, 27 Feb 2024 05:39:18 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dca160163dso18322215ad.3; 
 Tue, 27 Feb 2024 02:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709030356; x=1709635156; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WifOITY4yoOvSHFaeC9BU+JT/W0uRx7p58Mw6VK+b5E=;
 b=GKgXcDhtcPXIONtKBz4TS5sGGUWWWBvoFHqmZYLJUgV8EuFSMs2+M5Pbxuv1GUrnxQ
 wtRd5zL/9FFE3l4XxDrjVnrqtAL0iX2ZR3gn6cOoyJWNsSqazGaO0Dr5kmX2B9ncKkai
 RDhdiKsMw0RRn919q95KQXEO3F69ocowJabofmwz56WPffK0QI3csZwcUQ23C9l+wQ5R
 g+WMkd/8WI+kfSc75X5d4XMB6A36yzI0PRz5CgdPfnqNKIKWPS18y/6nKYH2JwuIdl5r
 DgcXobA37XPZ94EJMJlKMj5YF9PwY/9yie4A+A6/oWiw9g/3ksMlg37MTxdQeIjt/qBE
 lNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709030356; x=1709635156;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WifOITY4yoOvSHFaeC9BU+JT/W0uRx7p58Mw6VK+b5E=;
 b=BF+j5uGRsdfJUzp/gRZMH91LHu2dM3EdQAXJ0wkdTqf4t+B1XPBVTIUMVNO3K5R5dP
 mMe7mPotvIzEnR3J7m4WWJ+QHDWbzBU+hcHPCLo9BcOIWYvVa9E8PxQcSSVCbHWeJmEb
 NMO+dfq3rQqu+IW43cdsyOukcGBfXmU9PJlVVyAgGn7+QitUrluB4mUzr9X2E8Z3E+8e
 0HRW2zb/VyD4AnTgoZpc3WB7BCFV9INrjIKuzAzy7XJIqfYHBs6PprARgZAuw+Osm/pZ
 QCJzlJcI2RxZS/I8zB0ZSxHrESfePTXy+Nt6+EeidDmgnlygUjn9jjBsRIdxzR765kt8
 be1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUREmbA+hwYo+DOqnaM26L5N+x1eTQm3aAHBBQwPcLlqzebfMzcDMMjt1kw7gXfNS9c9jHwXlTtZ/JLa6ODNAn+ujNTczlmOOmbRpadE52krsP8Cwv4AuEWaLc=
X-Gm-Message-State: AOJu0YznwJ0CoG/zlHJPFkZoXP8T+pT+jKfMoJvEThwxyScYCmsaJxkd
 1OmtjPxkEuhozvlgqC1/1xAwzWhCXg7gYL2NgEevmpVlz6Xhtqrr
X-Google-Smtp-Source: AGHT+IF8ZopsnYCDEanYzpl3ZPC+qPhYe268INOJEGtGfeQ56v2qzD+kSqauYibtpIGiGblTrZYMXA==
X-Received: by 2002:a17:903:489:b0:1db:cbff:df15 with SMTP id
 jj9-20020a170903048900b001dbcbffdf15mr9222594plb.9.1709030355938; 
 Tue, 27 Feb 2024 02:39:15 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 bb5-20020a170902bc8500b001dcc09487e8sm577722plb.50.2024.02.27.02.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:39:15 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:39:08 +1000
Message-Id: <CZFSP3JYT0C5.140WKB17N0IQG@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 05/15] spapr: nested: Document Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-6-harshpb@linux.ibm.com>
 <CZFR7EN29EWC.EK4AP0CCTQJI@wheely>
 <8b71d5a6-7ed1-428f-8b08-dddf4fd09870@linux.ibm.com>
In-Reply-To: <8b71d5a6-7ed1-428f-8b08-dddf4fd09870@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Tue Feb 27, 2024 at 7:31 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 2/27/24 14:59, Nicholas Piggin wrote:
> > On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
> >> Adding initial documentation about Nested PAPR API to describe the set
> >> of APIs and its usage. Also talks about the Guest State Buffer element=
s
> >> and it's format which is used between L0/L1 to communicate L2 state.
> >>
> >> Signed-off-by: Michael Neuling <mikey@neuling.org>
> >> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >=20
> > v2 is upstream in Linux now, I suppose you could reference that too?
> >=20
> Yes, upstream Linux commit is mentioned in the doc at the end.

The API doc commit is mentioned as a reference. I would expect something
following the comments under the Existing Nested-HV API heading for the
New PAPR API.

Oh, is it lifted directly from linux.git docs? Sigh, in that case never
mind, it's better to stick with them. Although could be just a link or
reference.

Thanks,
Nick

