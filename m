Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F8C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aSo-0008H8-N4; Thu, 10 Sep 2026 04:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aSn-0008Gs-7B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:48:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aSl-000808-ML
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:48:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13B3E419D8;
 Thu, 10 Sep 2026 08:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1C41F000FF;
 Thu, 10 Sep 2026 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030134;
 bh=XFAPhwROlzPr08hhF85NQT+D07mkiDaK67hqe7hr9I4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RlF1IuZRFrrLuOLIxECDiGRaqQi9gwF0jUbjgBLMl6VA1ZYaAAyB3T4kRNaETL3Kk
 v4QpkQmwfUzExLOJtwDWPKlSqwwRhr6C3LKJpP6/+SqsfjvflbKengDjv0Oqv8JUUF
 oa1blGazLDEBFZV1YmeNCg98lRyMNiM2PLWAS0SPERPXjhW9458IAo16fq9xhJox5P
 ujnv8qL4Pmffu0h7MM/60XEDyrre4WpJcF6CT6rsioraC3R57D+aOv66dayzDzBUpe
 uzn4rIZ0C4xypOQE/RhnmWjXBDN1gh94CLCjuqnE2b1EiEdYzwHCytzsBdjnxy6Yxa
 HVRkLdAUnjHZA==
Message-ID: <354a3d65-38df-49fd-b54d-d9255cdeac1c@kernel.org>
Date: Thu, 10 Sep 2026 10:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-4-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-4-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/8/26 15:30, Michael Roth wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> So that there will be a verbal string returned when kvm not enabled, or
> kvm not compiled.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---

Reviewed-by: David Hildenbrand <david@kernel.org>
-- 
Cheers,

David


