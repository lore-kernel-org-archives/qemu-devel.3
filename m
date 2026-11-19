Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB971606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DU4+vzbN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ApS+AB+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU522-0004Jx-De; Thu, 19 Nov 2026 11:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xU520-0004Jk-Gw
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xU51y-0007j5-MD
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795105836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YqhSGVi8Bxogl+OLtqw69YcvrfoPc+1YKhLni3gsA00=;
 b=DU4+vzbN/bHCEssCeoq28gdevUicHyvKkZcW2HQQKX53xHUu/6KK+GZ5OcLTBuUPBA9swN
 IMuMOZoZvUSiHY25Ajji3kjw50nI0fV9sfBRfwTgYzimZzQLlSk7s7dOuXti07u2jSrfhU
 KNcyfi9X/u6SbX3thkPSj4GEnmNK8HQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ce5Bf2AxN-KmVdET55gUkQ-1; Thu, 19 Nov 2026 11:30:32 -0500
X-MC-Unique: ce5Bf2AxN-KmVdET55gUkQ-1
X-Mimecast-MFC-AGG-ID: ce5Bf2AxN-KmVdET55gUkQ_1795105830
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4a82fb7e71eso971885f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795105830; x=1795710630; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YqhSGVi8Bxogl+OLtqw69YcvrfoPc+1YKhLni3gsA00=;
 b=ApS+AB+uce+SEU9yiDow5UYeOV1mPFGnsXYIH6vptj48Z/e09UIzyCb8aBuBEwvEEf
 mS9vbFeFiC1c0hp90T9mW5eOkXa1eT87iYAGwBnh5Hk+7ne1DCyrEiAkJ9Dxs4fVs2fJ
 jDcl+nq8zwN3MXU7oP6afrXeTN88EXA1nt0z+4muqJrGwwWSFDjhebaJKWVdP70+6ioH
 BhMQOfJQjCfDB3N8vafPJlpYJrUMPClWHHsfGlSsw7K/OLNt2w9xrPekmaomQv9HHtxd
 HIH5ot7PI6Z2vVBbDtrUwrtrDiQrxSu75976LzqOSaXG/hZz6bKr34f8oRASZj1co4oh
 YVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105830; x=1795710630;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqhSGVi8Bxogl+OLtqw69YcvrfoPc+1YKhLni3gsA00=;
 b=o+e9CkKVRg4iR2Bm7ZJCF8+ntBo1W0aWvHNfijCpCnM2K2ii7L7xn2xak0d0mZ3XwE
 IRsx4Byg6iqL7PSv3/IVbNCcprcQk0a8topygPxhgUatYV4fHfPCoM4Zk0DUFg01CC5X
 S9aaZF/K4KcFYWSzUymRppXgV7Rz9RjG72pft6PJodydI0rVdVq5z4FgM8/aDeKBlvlQ
 ED5j0UnnVie1KPnRJ6/+KLx36rG1cy/oBH3FfFm19/XWxc85uUlPsfgfj+VWxbBM8Tki
 COr/gwE//EzBx0mZsw/0iVod7F9cYku287As2D0zImItYNKXZVWTMmnOsZnYeOhrD531
 93ag==
X-Forwarded-Encrypted: i=1;
 AL+hErGkA1LUPJfBI1uYnUb6fRXZjxoCwx4d8gf0HtePnqz8mdJ8AB8ZC6n72rB0HRX6F29CML/yColUWeca@nongnu.org
X-Gm-Message-State: APuU4Z+j1gMdaL3HckLzo2ufOtMkqz4x+CIcbODT+DWjCAdVZXLrfzPd
 9TI+nMhx0CQKDjaXkZ4I2sQdwiWEZfsrNg02OBdcJ1ZVsDmw03I6EDkrKG4y6IltsZGsOtajT59
 6+GCihZePajklsLP+oUSMzjIEBoT957ued+d9ssqO23DAhLKZTAvrssqb
X-Gm-Gg: AYBFou2E48JfLy7llY5S6tU46VNnQtQh4T0IBf9FMt7d6P05bz1aau/J2bm6b8V4ScF
 N3tIko3w5PTXbM0JEaeG0JPhdo2A3vMy146uFuis9boCnj7GSjJFjPTzYNAw7JIjhBB1ZdVRUUv
 HkAhOUQAQL+DNZkh/IeJumbHTkJV6RbuQZgMDcCLLtDVzK/thn+GxKcvi8CqWuWLoLGolzyMK12
 8+iqPDjCrwRPPzCVAJ3hETNyybkQBIDET0fMv0elW4znM6kXO5tOU6OLxhTarnqv3lOFxlDRAHp
 HCZNgUd+1jiANEdeZfzznJ2DGZlHw7C9FHksHbwUDDRKXio3PFO9vCbbtiY3ra/UPlBFR9T1R1w
 IltfjzxkYPc/KSjTNSNExJr+7oSMc0WRVT+mI/01bvg==
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb8882432bmr213095e9.25.1795105829757; 
 Thu, 19 Nov 2026 08:30:29 -0800 (PST)
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb8882432bmr212135e9.25.1795105829176; 
 Thu, 19 Nov 2026 08:30:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm75574525e9.4.2026.11.19.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:30:28 -0800 (PST)
Date: Thu, 19 Nov 2026 11:30:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: dongli.zhang@oracle.com, qemu-devel@nongnu.org, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, joe.jin@oracle.com
Subject: Re: [PATCH v3 0/5] amd_iommu: Bugfix and Cleanup for IO Page Fault
Message-ID: <20261119113001-mutt-send-email-mst@kernel.org>
References: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
 <e9298e9d-7f89-4324-9fdb-dcaa1e5bd514@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9298e9d-7f89-4324-9fdb-dcaa1e5bd514@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:55:08AM -0500, Alejandro Jimenez wrote:
> Hi Michael,
> 
> Following up on this series, since it contains bug fixes and it has not
> been included in the recent pull requests. Do you have any concerns that we
> need to address?
> 
> Thank you,
> Alejandro


Nope. sorry lost it in one of rebases. will add in the next pull.

> On 10/29/26 8:38 PM, Alejandro Jimenez wrote:
> > Hi Michael,
> > 
> > I am re-sending Dongli's series after reviewing and addressing the comments from
> > his earlier v2 submission:
> > v2: https://lore.kernel.org/qemu-devel/20260724223216.108667-1-dongli.zhang@oracle.com/
> > 
> > The series has been rebased on top of:
> > b574eaf640f0 ("Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")
> > 
> > Please queue it for your next pull request, whenever it is convenient.
> > 
> > Also available at:
> > https://github.com/aljimenezb/qemu/commits/amdvi-dongli-fixes-2026/
> > 
> > Changes since v2:
> >  - Rebased onto b574eaf640f0.
> >  - Patch 3: Applied suffix LOG for consistent EVTLOG/PPRLOG/GALOG naming, updated
> > the existing macros and all their call sites. I preferred the use of LOG since
> > GA by itself is generally used to refer to Guest Virtual APIC support in the docs.
> >  - Patch 4: Minor change in commit message, code unchanged from v2.
> >  - Patch 5: added GALOG_RUN to the RO mask [Sairaj].
> >  - Added Reviewed-by and Signed-off trailers as appropriate.
> > 
> > Thank you Dongli and Sairaj for your work on these fixes. Please let me know if
> > I missed any of your proposed changes.
> > 
> > Thank you.
> > Alejandro
> > 
> > Dongli Zhang (5):
> >   amd_iommu: Do not create duplicate MSI capability
> >   amd_iommu: Use full BDF when reporting page faults
> >   amd_iommu: Define MMIO register masks
> >   amd_iommu: Make extended feature register read-only
> >   amd_iommu: Do not latch unsupported GA log status bits
> > 
> >  hw/i386/amd_iommu.c | 47 +++++++++++++++++++++++++++------------------
> >  hw/i386/amd_iommu.h | 25 ++++++++++++++++++++----
> >  2 files changed, 49 insertions(+), 23 deletions(-)
> > 
> > 
> > base-commit: b574eaf640f02c4edf28cbee6417378f0d79cda0


