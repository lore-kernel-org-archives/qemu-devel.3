Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC71CD2C55D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Fnx-0007qX-He; Tue, 22 Oct 2024 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t3Fnv-0007qO-9l
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:24:11 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t3Fnt-0006If-3f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:24:10 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460c1ba306bso24113701cf.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1729607046; x=1730211846; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
 b=uReam37GFgtfCAhy1r4vX38MwkfZ0Mx3avPc3nYRUjfXBSyqZJsyXUaq34b8/xWb/Z
 U17Usju1kc/eVjZMwCWWi9udb80rCbGYMkpjiMFDR6S5wSoSDqi6eFHLV1moKrUzARKE
 WaqlIHdBAvKBZ+kY6ONmiCuSmwcVuvqP1kvwK7zahuj5dSZRmPhTS6WAn4COmL8G4r6+
 sFK/YyL29eCWr8VB45XAXbAh23pw5ezUUXi7GZrMUzW1oX/SzcOIibMw1KVCsagGGL+u
 ifMieXctwlCAfJkhJA7bkw9JYyGi32lbdkchPuqqypH4rymlMy9anOraAt4jyuz7lcXx
 aVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729607046; x=1730211846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
 b=nrtU5y3JM+wAqIDBFMS9djJYpxTCEfn4a1VNUxPORC8NRUhGidtynXnfK/fbnZZL8j
 vX+TFJrKr++LFdh6XWFBUTs2y5tjQWzBtWoCmbclMRi1o9f/KLrcB0Z+PGybcPqUGpM0
 F3lzoZPxrJKOaFPmScMdflgDwJwNLqsj3vwnX8wBeXPoUqvhcExWFtHVw3ma3vpDUanH
 fim5of7SQ5XQZqFiIy8SCC8fESxmX/iDadDyKr1Nm9au1dODON5copKTDCiboMcuLN7w
 jdzui7CVbXB6s9v3hTGIJEAiFP9ld0r7dGwTwNdqB/6EEmgAo7hQeS6FiMWEGlqgQYyI
 ILGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSICxl57uXVaYGNnArk44jA/gQBf8vTz9z8HKyewhMf72a3CmF13xzcyRy5SRMPDeOTJgLCjo2/klS@nongnu.org
X-Gm-Message-State: AOJu0YwN+oE14Kf3Pf+SLO3slahSgp428AxqELoIyTyyyANTRKDV7PQQ
 hkMdMt59Ih8Jz2lZEdE80BdvyHKP4vN62isEUhVwHLRnON8cnhkzc2wgj3a20nw=
X-Google-Smtp-Source: AGHT+IF5fbaOto1AQAWktpGH/+6Tqp835/6zpFVXMyPZpiyi3+BOxKZkfPeAjgw/eug8GyrAW4p2RQ==
X-Received: by 2002:ac8:5f07:0:b0:460:8f9a:9760 with SMTP id
 d75a77b69052e-460aed02689mr228595451cf.2.1729607046421; 
 Tue, 22 Oct 2024 07:24:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3d70a6bsm29593711cf.63.2024.10.22.07.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:24:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:24:07 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
 Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 =?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <Zxe1h8-E-OcO9cG3@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
 <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x82b.google.com
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

On Tue, Oct 22, 2024 at 11:33:07AM +0200, David Hildenbrand wrote:
> On 20.09.24 11:06, Gregory Price wrote:
> 
> > The only concern is when insufficient ZONE_NORMAL exists to support
> > ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
> > can be mitigated w/ existing mechanisms.
> 
> It might be worthwhile looking at
> Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory
> onlining polciy. It might not fit all sue cases, though (just like
> ZONE_MOVABLE doesn't)
> 

I managed to miss auto-movable in my last pass through there. Though for
our use-case, forcibly preventing ZONE_NORMAL for all CXL is the preferred
option in an effort to keep as much kernel resources out of high latency
memory.

So I think we're just going to end up using memhp_default_state, and that'll
be mostly fine.

> > 
> > Manually onlined capacity defaults to ZONE_MOVABLE.
> > 
> > It would be nice to make this behavior consistent, since the general opinion
> > appears to be that this capacity should default to ZONE_MOVABLE.
> 
> It's much easier to shoot yourself into the foot with ZONE_MOVABLE, that's
> why the default can be adjusted manually using "online_movable" with e.g.,
> memhp_default_state.
> 
> It's all a bit complicated, because there are various use cases and
> mechanisms for memory hotplug ... IIRC RHEL defaults with its udev rules to
> "ZONE_MOVABLE" on bare metal and "ZONE_NORMAL" in VMs. Except on s390, where
> we default to "offline" (standby memory ....).
> 
> I once worked on a systemd unit to make this configuration easier (and avoid
> udev rules), and possibly more "automatic" depending on the detected
> environment.
>

Appreciate the additional context, thanks!

~Gregory
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

