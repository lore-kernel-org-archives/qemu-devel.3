Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E482C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETHq-00086I-VG; Mon, 12 May 2025 09:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uETHd-00082G-Fd; Mon, 12 May 2025 09:33:33 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uETHY-0001Fd-Mg; Mon, 12 May 2025 09:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747056804; x=1778592804;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=F7j3cep47puNwkdI95QJzzsEY4MpzPeMA6iUkercExs=;
 b=ltjgigwPGhNecNl3qwhyHjADaNy7vGrWjftbd6o933Z08RRFl8YHr88i
 tBgqMMemMHcde+Jrj6xAgIWG2zVo/YMaMZHBsABMEOKM31o6ZsqyVnFO5
 usGHAwzOH/vZwOGKCZOa6azfKZr+I/hHjEyIIp6PK7Ibo+SZbSbm9auxD
 eJj2KwrCGPIRNi7v+Ieskp+SbN8khq/36y2NCwwTxYdLGR9wh1voJ1X1Y
 eTpgxZBBzDpRn+ikxSy8bGsAlaDVr1Qzx1etBYAJ1uh9omZiBhmXKmPbo
 IB9zEPtWNMqi3UCHePSy4eDS9u4EG574ytNqBupqFbGki5/hkfxQ8mPof w==;
X-CSE-ConnectionGUID: A4uO4SfmRrqsz2dVHa247w==
X-CSE-MsgGUID: PTnCD1tPQaO9V97pSBCUWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="47960748"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="47960748"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 06:33:17 -0700
X-CSE-ConnectionGUID: 8a8HyKboSVah4ASvPQPnYQ==
X-CSE-MsgGUID: zzCrsy+8RXOjD7uwBo8uaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="137081420"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 06:33:10 -0700
Message-ID: <e5a305cc-4c8b-48df-99fe-539ebd9b72f9@intel.com>
Date: Mon, 12 May 2025 21:33:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to mark internal properties
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com> <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87jz6mqeu5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/2025 6:54 PM, Markus Armbruster wrote:
> Daniel P. Berrangé<berrange@redhat.com> writes:
> 
>> On Mon, May 12, 2025 at 09:46:30AM +0100, Peter Maydell wrote:
>>> On Fri, 9 May 2025 at 11:04, Thomas Huth<thuth@redhat.com> wrote:
>>>> Thanks for your clarifications, Zhao! But I think this shows again the
>>>> problem that we have hit a couple of times in the past already: Properties
>>>> are currently used for both, config knobs for the users and internal
>>>> switches for configuration of the machine. We lack a proper way to say "this
>>>> property is usable for the user" and "this property is meant for internal
>>>> configuration only".
>>>>
>>>> I wonder whether we could maybe come up with a naming scheme to better
>>>> distinguish the two sets, e.g. by using a prefix similar to the "x-" prefix
>>>> for experimental properties? We could e.g. say that all properties starting
>>>> with a "q-" are meant for QEMU-internal configuration only or something
>>>> similar (and maybe even hide those from the default help output when running
>>>> "-device xyz,help" ?)? Anybody any opinions or better ideas on this?
>>> I think a q-prefix is potentially a bit clunky unless we also have
>>> infrastructure to say eg DEFINE_INTERNAL_PROP_BOOL("foo", ...)
>>> and have it auto-add the prefix, and to have the C APIs for
>>> setting properties search for both "foo" and "q-foo" so you
>>> don't have to write qdev_prop_set_bit(dev, "q-foo", ...).

> If we make intent explicit with DEFINE_INTERNAL_PROP_FOO(), is repeating
> intent in the name useful?

+1 for DEFINE_INTERNAL_PROP_FOO(). I have the same thought.

We need something in code to restrict the *internal* property really 
internal, i.e., not user settable. What the name of the property is 
doesn't matter.

