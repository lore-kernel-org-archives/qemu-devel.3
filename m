Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32D606A338
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=By+uVYuL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvxt-0004pj-9X; Thu, 05 Nov 2026 06:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOvxn-0004pA-PM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:49:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOvxm-00068m-63
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:49:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so18932235e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793879333; x=1794484133; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fXtCvXzXzAqybf7x/EyP6bJ4wn6IoZqlFm4KJNYCUpI=;
 b=By+uVYuLRjkmRMiLqoQMRLtDnzD+DBuhhz5VJatdFgRV/FvNo5G4D59+ExuHPw9V/o
 mUBvaVWuAy0FSmLbctBKtVgqhygmRUUYnDvsTMdjT5VHJMgQ3guwB2jS865GdGnDmyum
 rYpwZJNDkWMvrvg4TacME+xnMWJlkvdKjct3uTequWjvdAatIg0DXUdkOJKf2GOclSVV
 wb8VgNEG4KKAQnbzy8WkHp+SqgRXmVxMCNIEx/+7gkM/Kfd5tIFQiLzfTNGij9vVg75s
 AbPayljPbsmkDPx5aBI4QZJfuclU81GLBNtjNiKzMRKcqN7QDLs3AZt2G6whnCOZ+9fv
 SKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879333; x=1794484133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fXtCvXzXzAqybf7x/EyP6bJ4wn6IoZqlFm4KJNYCUpI=;
 b=XwzWLAXX/cqnfLlP4zSimNuBPyVI6GKWtngz0RjSLcFhsGGgtqm+OVcTYXMJLmjpoD
 CDqIfD3YEvrLyyt0UJfOiOCohjrDUwO2scHZiwh3UsAENTP15BpOcqbhNDFdydqsXicJ
 miUq5Bxhg11tl4PT3vnB5P/NU3NGI5gQmTDKExuLhqq2FOnARwkLULtiHkfzmwZatzg1
 JUDS0LU0qFodVGL3bHA/1bxmsxk2v0BVO8JIY1fQuyn+irt1hfzv1y3BwWahykSOUicW
 5Vd63dr+h1bMPzDzs6/qy2/35wh0ueYp2HL/FJonqb+dAFTrBW3NE63tUTvN2mDs+OOP
 rAxw==
X-Gm-Message-State: APuU4Z9iWHoAQalGtMbixH5HrcDrZkGiCifT0r6vyuQOmS4MVIqrwPNg
 8UY0oD9Rz9ynnCPLDuWfqkka0nVZqafhHQU6v7koDvVFhxMD+hqsEYK6f4JqvIuDciM=
X-Gm-Gg: AYBFou1265KCKB+aOEO3cFgL20EZbDW5csOkzsTmJ723v/Ma/T/iNEWvNUBCqYXOscH
 e4rgcIHCxAAxdRGJYqVzYnIlXztD7g8kG8eIuXiupOJkk2dWNbszs8ffWcqBhLnlq8tKlpwJqC7
 5a9Qs5yQzwI+n7CqALWu4nJ49JywBJzZVC9C26w4AhXejY/kb5pCY7vuZGvJekJZP48FcNWDGYM
 dIRUOoUeZOrVyWzPk2uEnmDdt6FwryfxgDnNyRb/pVk6K1KxCBA1oXPXg/FBo6MftrbVgdxmHrS
 XpPh7ZipO1nv1uHkRzJa8OPpcJK2dixGXEK9IUuH0rbyoFnTtfey+Zhz3F0qnH0M2ibVsbPqDyB
 J8yT/mD4qFni7JZexmWOELkrQxfg/Y2q6bQc07QAEWB9O1hy7hfB2zQJTEpltMyxc7Akk/eqUMj
 gJsTtRKnYBtoZBOWwHbUctqnpizj+WyJSJejFcDrgXeOjg/368mEMDnNd0t6rbEcl6mhKUy+29o
 CzzGXRnpwCDsgE5NeB4Eyl59j/v/RddOD395gZp2CoQkLmi/+X8s3UVd3D+koETrpiEtbsVYSWX
 Sy1Pb0smy/r8VPpp6OnolojWZRbodu0=
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4ac1709a7bdmr433883885e9.12.1793879333334; 
 Thu, 05 Nov 2026 03:48:53 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:2acb:1209:e24:c9ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm133853235e9.4.2026.11.05.03.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:48:52 -0800 (PST)
Date: Thu, 5 Nov 2026 11:48:51 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] hw/pci: add IDE + TEE capability to PCIe root port
Message-ID: <auxtI9xz2y3tWfl8@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
 <20261104192709.3b260e06@jic23-hlaptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104192709.3b260e06@jic23-hlaptop>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 07:27:09PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Oct 2026 15:05:11 +0000
> Jim MacArthur <jim.macarthur@linaro.org> wrote:
> 
> > From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > 
> > Adds the TEE flag in the legacy config space, and the IDE
> > (Integrity & Data Encryption) extended capability. These
> > will be present when rme-cap=on is specified for the
> > pcie-root-port device.
> > 
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Signed-off-by: Jim MacArthur <Jim MacArthur@linaro.org>
> > ---
> >  hw/pci-bridge/gen_pcie_root_port.c | 21 ++++++++++++++++++++-
> >  hw/pci/pcie.c                      | 19 +++++++++++++++++++
> >  include/hw/pci/pcie.h              |  3 +++
> >  include/hw/pci/pcie_regs.h         |  4 ++++
> >  4 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index 5434d693d9..ab8087da87 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -26,13 +26,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
> >  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> >  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> >          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> > -
> > +#define GEN_PCIE_ROOT_PORT_ACS_END \
> > +        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
> 
> Can't you figure this out from root port class acs offset?
> 
> Or if you want it in a fixed place follow that pattern and stash it
> in the root class during dev_rp_dev_class_init.
> 

There seems to be quite a lot of cases where we're arranging capabilities in
sequential order in memory, but hard-coding the locations. I would rather all
of this be replaced with a dynamic pointer which records the next capability
offset, and it looks like there are attempts to do this with, e.g.
pcie_insert_capability, but that has a lot of caveats and only gets used once.

I'll have another think about this, and in the meantime if anyone knows a good
reason why we do hardcode this, that would be useful.

> > +
> > +    if (grp->rme_caps) {
> Not arm specific. Can't see any harm in using a generic config name
> for this.  Actually I'm not seeing a reason not to always include
> the ide cap. Maybe less so for setting up tee.  Haven't really thought about
> that.
> 

Good point, IDE/TEE could be separate named options quite easily. There might
be more Arm RME things included later, but that can be a third option.

Thanks for the review,

Jim

