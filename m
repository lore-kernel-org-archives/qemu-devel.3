Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972FAC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxiD-000856-Tt; Tue, 12 Mar 2024 04:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rjxhw-00081F-Nt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:42:01 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rjxht-0004Q2-3x
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710232917; x=1741768917;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=V6Os8SmQXBSZd5ELwP1fKDyD/NsnEn/30+m6ZXbQILs=;
 b=GFjcGxD0VIm5bb+7LZ+VuTW13sdgVFMyIRcR7ZJKMlZR2eCBOh/yiJTJ
 jf15eF2B0XdEYsTpvth2cUwyYGc3gkZ12cnzyjQZYmHK3YSe9IHC7CjjP
 XRr0R+2kIly/+K+zexxP5V3UtjzAZhqkv7m/yXGeq+6ZwYIHrmcnA0gib
 o2pArXo/bcsOMRTQ0KZ3mpmMGBCn0q2M9VHB4fNzmpsMSfzl8AnyOPX5d
 3E6pKI7qH92qSogC0qu6m1u6XCMxZvg1Wr7SAjA4LFcrZPcmMBq6/LgSf
 8HmCYBTot9qTVk4MFgBDxqvt0mgzh8hpyoWWiJ3st2NqDvakNMTxn/K0I g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8692635"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="8692635"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 01:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="12054369"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 12 Mar 2024 01:41:50 -0700
Date: Tue, 12 Mar 2024 16:55:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <ZfAYiiShWcMsW4Hd@intel.com>
References: <20240228143351.3967-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228143351.3967-1-anisinha@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 08:03:51PM +0530, Ani Sinha wrote:
> Date: Wed, 28 Feb 2024 20:03:51 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v5] pc: q35: Bump max_cpus to 4096 vcpus
> X-Mailer: git-send-email 2.42.0
> 
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vcpus when MAXSMP is
> enabled in the kernel. At present, QEMU has been tested to correctly boot a
> linux guest with 4096 vcpus using the current edk2 upstream master branch that
> has the fixes corresponding to the following two PRs:
> 
> https://github.com/tianocore/edk2/pull/5410
> https://github.com/tianocore/edk2/pull/5418
> 
> The changes merged into edk2 with the above PRs will be in the upcoming 2024-05
> release. With current seabios firmware, it boots fine with 4096 vcpus already.
> So bump up the value max_cpus to 4096 for q35 machines versions 9 and newer.
> Q35 machines versions 8.2 and older continue to support 1024 maximum vcpus
> as before for compatibility reasons.
> 
> If KVM is not able to support the specified number of vcpus, QEMU would
> return the following error messages:
> 
> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: kraxel@redhat.com
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


