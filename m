Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F0EC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNfV-0001n1-A8; Thu, 18 Jul 2024 05:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1sUNfS-0001Y9-SH; Thu, 18 Jul 2024 05:43:18 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1sUNfQ-00078y-D9; Thu, 18 Jul 2024 05:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID;
 bh=ur27+PZ4q+21qbdQxHpKSV98KfAioDOHdSymytlbitU=; b=eHIk97kkIoSk2Ev7eX5AHo2Om7
 r0c3pTq1ALdf6E478tuVWNCDZDPglGPwEEfaZ8cyzvRb7bwISv64NVjxVeF6ssNtvCJ2YsSR6hU3X
 6pz1U4wj4Wq7REgLKYPKaqXV9eKpxIg63deWFfrwiE+R32nKwj/3jMuyKwixQWkrrgZQ=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1sUNfK-0005NE-Ai; Thu, 18 Jul 2024 09:43:10 +0000
Received: from gw1.octic.net ([88.97.20.152] helo=[10.0.0.211])
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1sUNfK-0006Br-0n; Thu, 18 Jul 2024 09:43:10 +0000
Message-ID: <5684927d-d890-42be-841c-ece681502503@xen.org>
Date: Thu, 18 Jul 2024 10:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
Content-Language: en-GB
To: eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
 <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
From: Julien Grall <julien@xen.org>
In-Reply-To: <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
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

Hi Eric,

On 17/07/2024 18:43, Eric Auger wrote:
> Hi Peter, Richard,
> 
> On 7/17/24 17:09, Jean-Philippe Brucker wrote:
>> On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
>>> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
>>> but not nested instances.
>>> This patch series adds support for nested translation in SMMUv3,
>>> this is controlled by property “arm-smmuv3.stage=nested”, and
>>> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)
>> For the whole series (3-9, 11, 12, 15, 16, 18):
>>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> (and I think patch 16 is missing Eric's R-b)
> 
> Jean-Philippe and I have followed up the progress of this series,
> Mostafa took into account all our comments and all the patches were
> reviewed. It seems to be in a pretty decent state so if you don't have
> any objection, please consider pulling it for 9.1.
> 
> On my end I did some testing in non nesting mode with virtio-net/vhost
> and I have not noticed any regression.
> Would be nice if someone could send his T-b for the nested part though
> (Julien?).

I haven't yet tried the latest version. I will do that in the next 
couple of days.

Cheers,

-- 
Julien Grall

