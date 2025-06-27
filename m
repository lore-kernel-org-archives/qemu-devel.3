Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F8C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5SE-0003Vm-LX; Fri, 27 Jun 2025 05:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Rx-0003S3-L1
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:32:52 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Rt-0007ry-Bg
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:32:49 -0400
X-ASG-Debug-ID: 1751016755-1eb14e1c381f990001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id IH3OK6T2MqlSMejE (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 27 Jun 2025 17:32:35 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 17:32:35 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Fri, 27 Jun 2025
 17:32:35 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 14:48:06 +0800
Message-ID: <22fe027d-b426-4682-aec5-dca12fa15bdb@zhaoxin.com>
Date: Fri, 27 Jun 2025 14:48:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Jason Zeng <jason.zeng@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>, Yi Lai
 <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, Tejus GK
 <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 <qemu-devel@nongnu.org>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-6-zhao1.liu@intel.com>
 <0d038476-e7c6-4e7a-add2-aeb4d715c202@zhaoxin.com>
 <aF4Kjf7iGhEORMSL@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aF4Kjf7iGhEORMSL@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/27/2025 5:32:33 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1751016755
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1087
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.72
X-Barracuda-Spam-Status: No,
 SCORE=-1.72 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085, PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143463
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.20 PR0N_SUBJECT Subject has letters around special characters (pr0n)
 0.10 BSF_SC0_SA085          Custom Rule SA085
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/27/25 11:05 AM, Zhao Liu wrote:
> 
> 
>> After applying these patches to QEMU mainline at commit 6e1571533fd9:
> 
> Ah, I forgot I've rebased these patches...Now you can rebase all the
> patches at the latest master branch.
> 
> Or, you can try this repo - I just created it to make it easier for you:
> 
> https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025
> 

I cloned the repo and then ran:

$ git am 20250620_zhao1_liu_i386_cpu_unify_the_cache_model_in_x86cpustate.mbx

The *.mbx is got from b4 tool.

That applied several patches successfully, but on patch #11 I got this error:

error: patch failed: target/i386/cpu.c:7482
error: target/i386/cpu.c: patch does not apply
Patch failed at 0011 i386/cpu: Select legacy cache model based on vendor in 
CPUID 0x2
hint: Use 'git am --show-current-patch=diff' to see the failed patch

This error also occured on qemu master when I do 'git am 
20250620_zhao1_liu_i386_cpu_unify_the_cache_model_in_x86cpustate.mbx'.

Have you run into this before, or did I miss any steps?



