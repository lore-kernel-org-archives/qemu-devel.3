Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E32C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 00:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUxIT-0007Rf-V8; Thu, 26 Jun 2025 20:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uUxIO-0007RC-C2
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:50:25 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uUxIK-00026Z-Lw
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:50:23 -0400
X-ASG-Debug-ID: 1750985404-1eb14e1c391de10001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id zUOfYFMVZuZId9by (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 27 Jun 2025 08:50:04 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 08:50:03 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Fri, 27 Jun 2025
 08:50:03 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 26 Jun
 2025 20:07:07 +0800
Message-ID: <0d038476-e7c6-4e7a-add2-aeb4d715c202@zhaoxin.com>
Date: Thu, 26 Jun 2025 20:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
X-ASG-Orig-Subj: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
CC: Jason Zeng <jason.zeng@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, "Tao
 Su" <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>, Dapeng Mi
 <dapeng1.mi@intel.com>, Tejus GK <tejus.gk@nutanix.com>, Manish Mishra
 <manish.mishra@nutanix.com>, <qemu-devel@nongnu.org>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-6-zhao1.liu@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <20250626083105.2581859-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/27/2025 8:50:02 AM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1750985404
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3379
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.42
X-Barracuda-Spam-Status: No,
 SCORE=-1.42 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085b, PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143446
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.20 PR0N_SUBJECT Subject has letters around special characters (pr0n)
 0.40 BSF_SC0_SA085b         Custom Rule SA085b
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



On 6/26/25 4:31 PM, Zhao Liu wrote:
> 
> 
> From: Manish Mishra <manish.mishra@nutanix.com>
> 
> Add a "x-force-cpuid-0x1f" property so that CPU models can enable it and
> have 0x1f CPUID leaf natually as the Host CPU.
> 
> The advantage is that when the CPU model's cache model is already
> consistent with the Host CPU, for example, SRF defaults to l2 per
> module & l3 per package, 0x1f can better help users identify the
> topology in the VM.
> 
> Adding 0x1f for specific CPU models should not cause any trouble in
> principle. This property is only enabled for CPU models that already
> have 0x1f leaf on the Host, so software that originally runs normally on
> the Host won't encounter issues in the Guest with corresponding CPU
> model. Conversely, some software that relies on checking 0x1f might
> have problems in the Guest due to the lack of 0x1f [*]. In
> summary, adding 0x1f is also intended to further emulate the Host CPU
> environment.
> 
> [*]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/
> 
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> Co-authored-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> [Integrated and rebased 2 previous patches (ordered by post time)]
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Note:
>    This patch integrates the idea from 2 previous posted patches (ordered
> by post time)[1] [2], following the s-o-b policy of "Re-starting
> abandoned work" in docs/devel/code-provenance.rst.
> 
> [1]: From Manish: https://lore.kernel.org/qemu-devel/20240722101859.47408-1-manish.mishra@nutanix.com/
> [2]: From Xiaoyao: https://lore.kernel.org/qemu-devel/20240813033145.279307-1-xiaoyao.li@intel.com/
> ---
> Changes since RFC:
>   * Rebase and rename the property as "x-force-cpuid-0x1f". (Igor)
> ---
>   target/i386/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 08c84ba90f52..ee36f7ee2ccc 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9934,6 +9934,7 @@ static const Property x86_cpu_properties[] = {
>       DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
>                        true),
>       DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
> +    DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
>   };

After applying these patches to QEMU mainline at commit 6e1571533fd9:

$ git am 
patches-from-https://lore.kernel.org/qemu-devel/20250620092734.1576677-1-zhao1.liu@intel.com/
$ git am 
patches-from-https://lore.kernel.org/all/20250626083105.2581859-6-zhao1.liu@intel.com/

and configure && make qemu with:

$ ./configure --target-list=x86_64-softmmu --enable-debug --enable-kvm 
--enable-sdl --enable-gtk --enable-spice --prefix=/usr --enable-libusb 
--enable-usb-redir --enable-trace-backends=simple && make -j32

I ran into this build error:

target/i386/cpu.c:9942:52: error: 'X86CPU' {aka 'struct ArchCPU'} has no member 
named 'force_cpuid_0x1f' ; did you mean 'enable_cpuid_0x1f' ?

I haven't debug it yet, because it seems like a simple mistake, asking you 
directly might be quicker.

> 
>   #ifndef CONFIG_USER_ONLY
> --
> 2.34.1
> 


