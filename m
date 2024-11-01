Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9920E67493
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 02:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6hEe-0008Ep-Ho; Thu, 31 Oct 2024 22:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6hEb-0008EK-Fu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:17:57 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6hET-0004Ti-7O
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730427469; x=1761963469;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6ooPQhm53VX9qB17TDVsMifOx9rBOzRULxkeKvrnBuA=;
 b=IzW/Qlhj2FPQLDdR7lNZsxcLYyUXAP67IJtyjak7t7Y4FdOt8hbTe3RI
 dHKtpgfy9tGhkkOIpDRAnY2TTdH0scl/OHq/onu1sua+CQuufrW3VO+u1
 Qt9O2hikn7PIGtno+wQOp/u6PMjVCLZ7r4DicImEfE52xjnCiFUqLH8lX
 TqreH0WkzOt23npZSujcy6pmJK1XSdGPICbjJislgTTcsLDv2vGbOoGrz
 XANu7BAJIOQfUFLa5ZXWAlHA9qWhyafEC8LX6nz8HcwGNg5W6WA9L9/+c
 rrj7xR7cjf7iErqZ39ArxVSoJzqBWdQT6I8w6s2Q65j5b8j+fRKHEiB6B w==;
X-CSE-ConnectionGUID: fHDdVCUBTZKj4oXTOGMCSA==
X-CSE-MsgGUID: Ctv28hviSqWh/yzDfiBprw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41583981"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="41583981"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 19:17:46 -0700
X-CSE-ConnectionGUID: WWBj5JdgRB6+wzodPsBzYw==
X-CSE-MsgGUID: IBo4H9+QR+ayfsUxbjEY0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="113667856"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 19:14:17 -0700
Date: Fri, 1 Nov 2024 10:09:11 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyQ4RzWX4oJB3vP0@linux.bj.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
 <20241031085233.425388-5-tao1.su@linux.intel.com>
 <ZyO1vL0o0SxgcW8q@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyO1vL0o0SxgcW8q@intel.com>
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 01, 2024 at 12:52:12AM +0800, Zhao Liu wrote:
> > @@ -7578,7 +7607,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> >          }
> >      }
> >  
> > -    return x86_cpu_have_filtered_features(cpu);
> > +    have_filtered_features = x86_cpu_have_filtered_features(cpu);
> > +
> > +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> > +        x86_cpu_get_supported_cpuid(0x24, 0,
> > +                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
> > +        uint8_t version = ebx_0 & 0xff;
> > +
> > +        if (version < env->avx10_version) {
> > +            if (prefix) {
> > +                warn_report("%s: avx10.%d. Adjust to avx10.%d",
> > +                            prefix, env->avx10_version, version);
> > +            }
> > +            env->avx10_version = version;
> > +            have_filtered_features = true;
> > +        }
> > +    } else if (env->avx10_version && prefix) {
> > +        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> > +        have_filtered_features = true;
> > +    }
> 
> prefix is just used to print warning. So here we should check prefix
> for warn_report.
> 
> +    } else if (env->avx10_version) {
> +        if (prefix) {
> +            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> +        }
> +        have_filtered_features = true;
> +    }
> 

Yes, thanks for pointing out! But I see this patch set is already pulled,
not sure whether it is easy to change...

