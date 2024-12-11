Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6130FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 22:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVAE-0005hk-Gx; Wed, 11 Dec 2024 17:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLVAC-0005hT-T5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLVA9-0004h0-Jc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733955992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4OBSRcA341eBbpA+t8MBxEIuKLU+BN+0WubwMMZDLMM=;
 b=fqMpv0JgDHHco1wpvI+hhVN7jrOQmmWMyeFYrS60+agGY4XnGAXHRgEKa1HWKbzCzuuw8a
 eW554O2J8ByTLthLIUfqQUcUyd88lwlXmesgSS6d7HEV5Drul6XHNhuq7v19nySu5O0krp
 9zFprpqvg1Q7/IGOxi7WjH2bMuQl+QA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-XEqoE62zPKSFlIdPElcLYQ-1; Wed, 11 Dec 2024 17:25:22 -0500
X-MC-Unique: XEqoE62zPKSFlIdPElcLYQ-1
X-Mimecast-MFC-AGG-ID: XEqoE62zPKSFlIdPElcLYQ
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1b036e9so172085a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 14:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733955922; x=1734560722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OBSRcA341eBbpA+t8MBxEIuKLU+BN+0WubwMMZDLMM=;
 b=e5v5ODRYt7Ys9OcpDSzX2xifHqQBrSgOdjwjmCVk/kbnblEwYmEKB37v07qgk26PD0
 ZGHVCFfabM3hv3oTmKb09mDeNfZgBDe/49YG+IbC/H3Wl5zh1KnJl9EUPbpT0Wu2qXUh
 4w1rWaXRAxSoVj1g5l1L3O7h5TV+sk9WFGenL6/KcnykYwe2g0TqlTUltH9K+/lBW/Sq
 DK/YmOTMGykfW3W9gKQB2caQ/5K98VjFSGQxDjyMDyNLCr6oeMYSbrecRaBJmVdeVgyR
 KhKgvM2unNmLkrvPasFshOO1l5inQQFIyxSuOLaMzzzrQcXzVvSOEZRx9DFLrf0O9uaD
 P1NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcIL3TIF0QnDmObJtiTNLeXWG8pCvBACLgsSwDPt+UM3B1kd+1LDx5P3zS/7uSz5mFXRxVG08kf8qm@nongnu.org
X-Gm-Message-State: AOJu0YwX9NhMQjWCZGbIOYZEcNJTjJQDWoiUdefVKLekE3TqXYCvhamY
 rJYmTjISgqCgCyLUkAby7q3X82HqaF9mKI+bUgce2hKtV/Se8+1bw902FMzNSYEfDPjS7RiwpgU
 f/vsvX5G9VlCiv3tRjoyx7OvcCRejvOKj/CesyVx6S2aaYVJ6bSU7
X-Gm-Gg: ASbGnct4eVZ1l1Lcb58GVT7S/Rlb0pzKZk/Tre9+NtJ6E2s9Z5/SPdXmvkuNWTmsjCC
 mEqRja0WrZ5BEog+CliEqd8ZpxVFeKvCa8YPxDSqDCXq/I5dm8lpVBYgfE6C/ykpgx8gydlvUPJ
 OKW3BjbU7BkUpzvWJoxUW1arUxLJZkA7flpk36eraqddhgoi8SkhWl/AF4RmQvI/Vqb1SBnc2Gn
 +lWaG7t7YjMiuES6gNUEOBV7EkztygmSMmzGvU2xq5yEmoNQ0ZXtY0E8q6Q1yUTASvOyKmxoLex
 G3mvC4bnEjb2tyQ=
X-Received: by 2002:a05:620a:8801:b0:7b6:d1f6:3df with SMTP id
 af79cd13be357-7b6f25382bemr167654685a.21.1733955922340; 
 Wed, 11 Dec 2024 14:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ1ReQ7PYxLgtH5PChq8CyC157fY1QPOpt5/91ygGjA81gRty+VyLvkArWG0vkBm8FTqglyg==
X-Received: by 2002:a05:620a:8801:b0:7b6:d1f6:3df with SMTP id
 af79cd13be357-7b6f25382bemr167652785a.21.1733955922073; 
 Wed, 11 Dec 2024 14:25:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f10661f1sm48812285a.8.2024.12.11.14.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:25:21 -0800 (PST)
Date: Wed, 11 Dec 2024 17:25:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z1oRTipSYMq3WvmZ@x1n>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
 <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
 <Z1MpY7ZIAAoBDbZU@x1n>
 <CAFEAcA-6KksbRmL7V0dm_0KJ_zgsaJqCkuTpswbbefyjdVeFCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-6KksbRmL7V0dm_0KJ_zgsaJqCkuTpswbbefyjdVeFCw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 11, 2024 at 09:56:21AM +0000, Peter Maydell wrote:
> On Fri, 6 Dec 2024 at 16:43, Peter Xu <peterx@redhat.com> wrote:
> > I assume it's about xhci_cap_ops then.  If you agree we can also mention
> > xhci_cap_ops when dscribing it, so readers can easily reference the MR
> > attributes from the code alongside with understanding the use case.
> >
> > Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
> > can be changed to 2 (together with additional xhci_cap_read/write support)?
> >
> > Note that I'm not saying it must do so even if it would work for xHCI, but
> > if the memory API change is only for one device, then it can still be
> > discussed about which option would be better on changing the device or the
> > core.
> 
> I think the memory system core has been broken in this area
> for a long time -- it purports to support impls which only
> do a subset of what the valid operations are, but it actually
> does buggy and wrong things in some cases. So far
> we have effectively worked around it by avoiding defining
> MemoryRegionOps that try to use the buggy areas, but I
> think it's much better to fix the code so it really does
> what it's theoretically intended to do.

Thanks, Peter.  I assume it means there're a lot of devices that can use
this model.  Then it makes perfect sense to do it in memory core.

Though I do have some confusion on why we needed impl.unaligned at all.  I
see that Tomoyuki raised similar question, even if not exactly the same
one.  I'll try to continue the discussion there.

-- 
Peter Xu


