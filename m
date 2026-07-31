Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C237C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphXf-0000ii-6h; Fri, 31 Jul 2026 03:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wphXc-0000iK-A1
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:20:24 -0400
Received: from [115.124.28.101] (helo=out28-101.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wphXZ-0006YQ-Nn
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:20:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1750312|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0595643-0.0109835-0.929452;
 FP=9219851515287299419|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033068016216;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.ia839jW_1785482282; 
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ia839jW_1785482282 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 15:18:03 +0800
Message-ID: <29ac3889-5268-4676-ac6e-4078ba69ae3e@open-hieco.net>
Date: Fri, 31 Jul 2026 15:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-6-zhang_wei@open-hieco.net>
 <amw4x/BFXEJMwbI9@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amw4x/BFXEJMwbI9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.101 (deferred)
Received-SPF: pass client-ip=115.124.28.101;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-101.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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



On 7/31/2026 1:55 PM, Zhao Liu wrote:
> To unify similar checks, how about we abstract them into the "PMU vendor
> family"?

Yes, this makes sense. This is a PMU architecture/layout compatibility
check, not a raw CPU vendor identity check. I'll update this in the next
version.


Thanks,
Tina


