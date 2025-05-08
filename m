Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2D1C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzjp-0007IR-6R; Thu, 08 May 2025 07:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCzjn-0007II-57
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:48:27 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCzjl-0006tX-7u
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746704905; x=1778240905;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1uyG16FIdzJvVtC7hjq7yIsugtDMo+Kie/Zj81E2f+o=;
 b=NQE5ftqmCXkSm+jk8RPsIxEX4TSNlqhvVY4MiIlNedzCRAgg2dMwv3ki
 iwQtnIuzUjfaQyvNOVWFAJ82m88I9H5k/quNvZOwB6fUzHvB9j5KuoQ1e
 Q+lRosK0B6Y/lgmCOZ00dQ5Dfi/aSwZpYE01/SflNsfCft8okCb1T4deL
 W2dr1WEL5nPWJ+W0EeCrY5a1MmgnkSBFE3kiVLDH2V+nyee8M1xMEaCId
 mtpU1Cu9pty12JtvYqJiix6C2MOP9MwPpy7z1ZJQlp21gQtWPe/EF0GRR
 J5zQIBQGPj5/OBWqeKBQBRBDBOwADaeNgyvB7BMsg5uOhikw7tC+F46hK A==;
X-CSE-ConnectionGUID: YuAnA2RhTrKA72+iIzSn5Q==
X-CSE-MsgGUID: oOMsr1DmSGmI4vkkyf0wTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="66014855"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="66014855"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:48:05 -0700
X-CSE-ConnectionGUID: eRixBp4XTQ6mft2czjJcfA==
X-CSE-MsgGUID: 41jMWdpNQNK1SdyI89EKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="137260064"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 08 May 2025 04:48:00 -0700
Date: Thu, 8 May 2025 20:09:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v3 12/19] hw/i386/pc: Remove pc_compat_2_7[] array
Message-ID: <aBye3pzw6LLJ1rgt@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-13-philmd@linaro.org>
 <2e2f4b39-d7f1-4817-947f-106558c1621c@redhat.com>
 <1bd065b9-32ff-46d9-8131-b06e75017243@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bd065b9-32ff-46d9-8131-b06e75017243@linaro.org>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 08, 2025 at 12:40:35PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 8 May 2025 12:40:35 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v3 12/19] hw/i386/pc: Remove pc_compat_2_7[] array
> 
> Hi Thomas,
> 
> On 8/5/25 09:55, Thomas Huth wrote:
> > On 02/05/2025 20.56, Philippe Mathieu-Daudé wrote:
> > > The pc_compat_2_7[] array was only used by the pc-q35-2.7
> > > and pc-i440fx-2.7 machines, which got removed. Remove it.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > ---
> > >   include/hw/i386/pc.h |  3 ---
> > >   hw/i386/pc.c         | 10 ----------
> > >   2 files changed, 13 deletions(-)
> > > 
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 4fb2033bc54..319ec82f709 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
> > >   extern GlobalProperty pc_compat_2_8[];
> > >   extern const size_t pc_compat_2_8_len;
> > > -extern GlobalProperty pc_compat_2_7[];
> > > -extern const size_t pc_compat_2_7_len;
> > > -
> > >   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
> > >       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
> > >                                                    const void *data) \
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 7573b880905..ee7095c89a8 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
> > >   };
> > >   const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
> > > -GlobalProperty pc_compat_2_7[] = {
> > > -    { TYPE_X86_CPU, "l3-cache", "off" },
> > > -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
> > > -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
> > > -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
> > > -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
> > > -    { "isa-pcspk", "migrate", "off" },
> > > -};
> > > -const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
> > 
> > I'd really appreciate if you could provide clean-up patches for
> > TYPE_X86_CPU, too. Otherwise I'm pretty sure we'll forget that there is
> > some clean up possibility here.
> 
> Well TBH it is too exhausting to keep rebasing these patches without
> feedback from maintainers. I'll respin a v4 with Zhao and your comments
> addressed but without touching the TYPE_X86_CPU properties. If
> maintainers prefer to remove dead code in one go -- something I
> certainly understand from a maintainer PoV -- I'll let someone else
> do it, taking over my series.

Hi Philippe, I think I could volunteer help you to revisit the history
of these properties (they're also too old for me :-)), and help identify
if these properties should be removed or at least list the potential
issues. Hopefully I can do this.

Thanks,
Zhao


