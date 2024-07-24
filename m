Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B4C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWRMf-0000ki-Nc; Tue, 23 Jul 2024 22:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sWRMa-0000k9-Ka
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:04:21 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sWRMX-0002Zy-EH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:04:20 -0400
X-ASG-Debug-ID: 1721786631-1eb14e4056969b0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id I6AMgsLmGBtq0PJ1 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 24 Jul 2024 10:03:51 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 10:03:51 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 10:03:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <a8f89526-5226-4859-98ef-5342c360d7db@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Tue, 23 Jul 2024 22:03:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting
 for backward compatibility
CC: Xiaoyao Li <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <mtosatti@redhat.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20240624095806.214525-1-ewanhai-oc@zhaoxin.com>
 <ZnqSj4PGrUeZ7OT1@intel.com>
 <53119b66-3528-41d6-ac44-df166699500a@zhaoxin.com>
 <ZnrPdZdgcBSY1sMi@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ZnrPdZdgcBSY1sMi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1721786631
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1991
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128040
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Dear Maintainers and Paolo,

I hope this message finds you well. I am writing to inquire about the 
status of
the patch I submitted a month ago. Could you please provide any updates or
addtional comments regarding its review?

Thank you for your time and assistance.

Best regards,
Ewan

On 6/25/24 10:08, Zhao Liu wrote:
>>> Additionally, has_msr_vmx_vmfunc has the similar compat issue. I think
>>> it deserves a fix, too.
>>>
>>> -Zhao
>> Thanks for your reply. In fact, I've tried to process has_msr_vmx_vmfunc in
>> the same
>> way as has_msr_vmx_procbased_ctls in this patch, but when I tested on Linux
>> kernel
>> 4.19.67, I encountered an "error: failed to set MSR 0x491 to 0x***".
>>
>> This issue is due to Linux kernel commit 27c42a1bb ("KVM: nVMX: Enable
>> VMFUNC
>> for the L1 hypervisor", 2017-08-03) exposing VMFUNC to the QEMU guest
>> without
>> corresponding VMFUNC MSR modification code, leading to an error when QEMU
>> attempts
>> to set the VMFUNC MSR. This bug affects kernels from 4.14 to 5.2, with a fix
>> introduced
>> in 5.3 by Paolo (e8a70bd4e "KVM: nVMX: allow setting the VMFUNC controls
>> MSR", 2019-07-02).
> It looks like this fix was not ported to the 4.19 stable kernel.
>
>> So the fix for has_msr_vmx_vmfunc is clearly different from
>> has_msr_vmx_procbased_ctls2.
>> However, due to the different kernel support situations, I have not yet come
>> up with a suitable
>> way to handle the compatibility of has_msr_vmx_procbased_ctls2 across
>> different kernel versions.
>>
>> Therefore, should we consider only fixing has_msr_vmx_procbased_ctls2 this
>> time and addressing
>> has_msr_vmx_vmfunc in a future patch when the timing is more appropriate?
>>
> I agree this fix should focus on MSR_IA32_VMX_PROCBASED_CTLS2.
>
> But I think at least we need a comment (maybe a TODO) to note the case of
> has_msr_vmx_vmfunc in a followup patch.
>
> Let's wait and see what Paolo will say.
>
> -Zhao


