Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D2C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WBu-0001JA-CM; Mon, 13 May 2024 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1s6WBq-0001G3-B6; Mon, 13 May 2024 09:58:08 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1s6WBi-0003ji-6R; Mon, 13 May 2024 09:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID;
 bh=+VNh/kHYnh/7Z34zKfP/vR99iIquYdkKDu1MTgWSTIo=; b=6oAI7d+slUEQimBzi7y3XdyGeq
 vfL8Ia5DQmgyFsMsP573P40VjC1GJdGxwH5YvQma0ZKDRu9QayBg6HsybJ5w0JkwqlaKRTmiNG/sY
 PK26o0dpNvGvoSvd0ogEmyXI+m4YRI9GCGG8f/SDuwxtdwgmxusvFFnwo7xzUzIaMjG0=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1s6WBX-0005GJ-6w; Mon, 13 May 2024 13:57:47 +0000
Received: from gw1.octic.net ([88.97.20.152] helo=[10.0.0.211])
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1s6WBX-0007Bh-00; Mon, 13 May 2024 13:57:47 +0000
Message-ID: <b537180b-56b6-4d9c-adea-b3d57d188404@xen.org>
Date: Mon, 13 May 2024 14:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/18] SMMUv3 nested translation support
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
From: Julien Grall <julien@xen.org>
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=julien@xen.org;
 helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hi Mostafa,

On 29/04/2024 04:23, Mostafa Saleh wrote:
> Future improvements:
> =====================
> 1) One small improvement, that I don’t think it’s worth the extra
>     complexity, is in case of Stage-1 TLB miss for nested translation,
>     we can do stage-1 walk and lookup for stage-2 TLBs, instead of
>     doing the full walk.
> 
> Testing
> ========
> 1) IOMMUFD + VFIO
>     Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/
>     VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-smmuv3-emulation-support
> 
>     By assigning “virtio-net-pci,netdev=net0,disable-legacy=on,iommu_platform=on,ats=on”,
>     to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.
> 
> 2) Work in progress prototype I am hacking on for nesting on KVM
>     (this is nowhere near complete, and misses many stuff but it
>     doesn't require VMs/VFIO) also with virtio-net-pci and git
>     cloning a bunch of stuff and also observing traces.
>     https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/android15-6.6-smmu-nesting-wip
> 
> I also modified the Linux driver to test with mixed granules/levels.

We have tested the series as well:

Tested-by: Julien Grall <jgrall@amazon.co.uk>

Cheers,

-- 
Julien Grall

