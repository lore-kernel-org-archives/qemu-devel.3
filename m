Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA87EE57C2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 23:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaikp-0001md-L3; Tue, 30 Dec 2025 18:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaikn-0001mE-VS
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 18:03:49 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaikm-0002dN-A5
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 18:03:49 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-888bd3bd639so140482556d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1767135827; x=1767740627; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4s6l3szhQkyW8pfKtYhr1C560ByRfEOgMLHpdScMCg8=;
 b=jOEZOzWNEfvJLqhZNTWwRqmCBwsdIas4mHHHPAmmkh07SjVe9O4MY68yEryRj5est3
 Hfdp5FlhVA9dOQnDjYX8r05eypseAooeLqTk8kQXIFdlzxIUy2Nj2subqLvpTjgl8Lth
 /ey9ixToE0/YTtXO2M6KeMVf85PLd0m0wxdffALqhd6pEVH05Z97m4sSG8eJJ1ECwsBo
 P+EB43STLS+e4ohi/alwoSSmQfFJbEYOkhjXpa6CvhhzGSqOYw73NXGa/wQybVw8Aohr
 oFugJpeNWfXI8+AXZ56d+xtLxctLnuXC4m/MsRn09fV2wdwz3O62kRA3uaLCNKSgVLX5
 +VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767135827; x=1767740627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4s6l3szhQkyW8pfKtYhr1C560ByRfEOgMLHpdScMCg8=;
 b=LbhIbFV8TdFwOQvY3dTAFUiRHEPUCkTILhc1ipglKvEJvLxvAWk1NcPtZ/snRWf+Z6
 K+uu51i/tLCfLyZyCOXJptBrnV1couydC42SSByW1IKoF6gsESCUottMmbGA80qJ6xeD
 GZnzd5HHQMCu0Lfqk5YtnI/NHglQdZ7RzUe9ZWrUw+TITcj1dvCzQgpyP9a90XD3cVoi
 IwiTU+6DhitwQ/vLMbPvzxrFMo/jltY2QGEeYok2zTb8ugmXBZlyYEE+QXhOsxCOlZHz
 uzfpQWqozUjMXu+vjWqiJNgETP7Eo3wxOycIefaGfQen84XQeC28il3MrN7Oa5KzYeF/
 K1Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX53wpOAS3mikf6MdK7hNKLNFE00v1pXYLBsQiOoCV17Z+7Y+KCVTqxyjf1HfMNeVWGV5PHRklAQEiM@nongnu.org
X-Gm-Message-State: AOJu0YwDy8vyVyKdbQSNKL95M1VLgi9E2YkwR6tK+60JYeVO6z3vvRs8
 CZHb77/irO4xj+WTSFuWaeShvjwMO0BGWMuA1c8o3MmdDfN4EhZ+N3i7eS73lhSh5tY=
X-Gm-Gg: AY/fxX6SVflhypHQ5X5R9xVCVLaV6EOLucr5xa8JprptG747R2yvGMzLU6t3aW3F7qU
 F+M6g0VshYEs+2OKVgRDIelZp/rcAABUxuNKoovcy9AslRVA6eew1kUhY9e9r3nTV5qCmAo7t7T
 oyeZ797Mrd5UjJ3TYoWVEoQRXG3linD3cnNOhjk2OUhLjrOsPrD5eqv3Nh+u+n3JwbyHjoyQPtq
 TTvghfozv1gcJZWX2XFZhOYLP9f8ObpetesMAKvDKWr9yWKU/N5c/BjCeGGpcVZEH4iX6TkO6O+
 8hgNtQKKqXeBLO2XGjEH0OPZCtJ5PkF8AJeb7oZt1b/hKs94aaOoshwMvcj4F1sUXCrsd6287YX
 y5/mOV/tSQAmtQIVddNv6qs8nzweJN3tZFAAKuGZ5md+gey9aMURx4uH2DV0R5swsOKFJ6X/BfU
 qKvx1Og+Ohmdh1Gqz+zZcFCRQqq/dAcVV+1CIUVFQJjoIbrhdNIX2dj+f353eGGT2hOkEQkA==
X-Google-Smtp-Source: AGHT+IHFBTf8PJcPt8trwM1NPnjnRxV6I/2yfCbkTmbK3ECHkETMY14yHZXXXMqpHvLgOAIK4mO8sw==
X-Received: by 2002:a05:6214:19e8:b0:88a:4266:bba8 with SMTP id
 6a1803df08f44-88c5204b09bmr627034606d6.19.1767135826522; 
 Tue, 30 Dec 2025 15:03:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0971ed98dsm2711802085a.31.2025.12.30.15.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:03:46 -0800 (PST)
Date: Tue, 30 Dec 2025 18:03:11 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 qemu-devel@nongnu.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <aVRaL3KjYwXksxRs@gourry-fedora-PF4VCD3F>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
 <8123efd8-73cc-4dfa-9f1e-6d9a95f66984@amd.com>
 <aVPcT_APo6SgRrGU@gourry-fedora-PF4VCD3F>
 <55ed0c12-222f-4474-a21f-ac0703d2b77c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ed0c12-222f-4474-a21f-ac0703d2b77c@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf2c.google.com
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

On Tue, Dec 30, 2025 at 09:15:34PM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/30/25 15:06, Gregory Price wrote:
> 
> And given we don't have a boot memory device, the idea was to set it for the
> Node, where it means "all boot memory is SPM". And we only allow one type of
> boot memory (one memory backend) per node in QEMU.
> 
> The tricky question is what happens with memory hotplug (DIMMs etc) on such
> a node. I'd argue that it's simply not SPM.
>

...

+++ .../docs/whatever

+ Don't do that.

:]

> > 
> > ---
> > 
> > bit of an aside - but at LPC we also talked about SPM NUMA nodes:
> > https://lore.kernel.org/linux-mm/20251112192936.2574429-1-gourry@gourry.net/
> > 
> > Would be cool to be able to detect this in the drivers and have hotplug
> > automatically mark a node SPM unless a driver overrides it.
> > (MHP flag? Sorry David :P)
> 
> :)
> 
> If it's a per-node thing, MHP flags feel a bit like "too late". It should be
> configured earlier for the node somehow.
> 

just a clarification, the flag would be an override to have mhp mark a
node N_MEMORY instead of N_SPM.

As it stands right now, a node is "online with memory" if N_MEMORY is
set for that node.

https://elixir.bootlin.com/linux/v6.14-rc6/source/mm/memory_hotplug.c#L717

I imagine hotplugged N_SPM would operate the same.

So mhp code would look like

if (node_data->is_spm && !override)
	node_set_state(node, N_SPM)
else
	node_set_state(node, N_MEMORY)

Basically would allow SPM nodes to operate the same as they did before
when hotplugged to retain existing behavior.

(Sorry i'm think waaaaaaaaaaaaay far ahead here)

~Gregory

