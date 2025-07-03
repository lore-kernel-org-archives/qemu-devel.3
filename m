Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BDFC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEC0-0006ze-9x; Thu, 03 Jul 2025 03:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEBy-0006zJ-KX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:17:10 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEBv-0006zS-Vd
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751527028; x=1783063028;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FKARZY7CsmsxWAOOzUTp75oHFn/qz7dtYMYywXdXkO8=;
 b=OSrzfqOASJ+GcZEVXJplZwq5ORh/G7GXh8VbkXOeZb/+HpysYMvvgkRE
 Ux+GbF7AyTIoIOxm4efU2PpJ7LG5/Z3S548eFtrGFQiEBDPouconfJZXT
 hw2Rt5cjL4FzYsbTtHxNIdc9EH+ssVs/KSskqAZFqeu+egepE0coQ/UDN
 t0ieNtCNA01D0Iwcd6z0qsD7CQ5q4evvCv2Ou4qH7CPtV22Zr8h/ru4af
 YDRbJcpLhIcvMaAK7o6+0WsQMjAachhjUaPn5IowVQt23dJ8ehZrVQdVV
 r6w4KEmnkl1ZDyQzARoYNyornWlDdSIi392q0HXsH4J59Ok3944FtWBbJ w==;
X-CSE-ConnectionGUID: ZtTMzD9dT5i3k/u+yuvOKA==
X-CSE-MsgGUID: 8cZDZPfSRIKEi6t+b9jNsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53935808"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53935808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:17:05 -0700
X-CSE-ConnectionGUID: V5wKbvZBTV6Fqy2m/ghA5w==
X-CSE-MsgGUID: chQ9cZvYQUu91pO2sXBRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154370223"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 03 Jul 2025 00:17:01 -0700
Date: Thu, 3 Jul 2025 15:38:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 01/16] i386/cpu: Refine comment of
 CPUID2CacheDescriptorInfo
Message-ID: <aGYzcgbyJglePNHF@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-2-zhao1.liu@intel.com>
 <4fde6b82-0d13-48d8-898a-e105b9a79858@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fde6b82-0d13-48d8-898a-e105b9a79858@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > +    /*
> > +     * Newer Intel CPUs (having the cores without L3, e.g., Intel MTL, ARL)
> > +     * use CPUID 0x4 leaf to describe cache topology, by encoding CPUID 0x2
> > +     * leaf with 0xFF. For older CPUs (without 0x4 leaf), it's also valid
> > +     * to just ignore l3's code if there's no l3.
> 
> s/l3/L3/g

Sure!

> Others look good to me. 
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
 
Thanks!


