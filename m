Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E2EC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLeB-0007jX-Kt; Wed, 26 Mar 2025 03:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLdD-0006Np-PL; Wed, 26 Mar 2025 03:57:00 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLd7-0006k4-FB; Wed, 26 Mar 2025 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742975814; x=1774511814;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FDnGlzJRelMoGPD574y/7BHjFIC4a2BtkJqEkxA4qwI=;
 b=HJK8TjtJ3LmHLPLFbyKuy8rhyrnkUAHQGO+Z/ktn/MaC+Cwl1pJLNwm1
 uUvsmNvT1dmJIEadf4Gv3n+1VQ1GD0qebZFgmC4PJQVaI+yzrkDVUxuDo
 pdQ+6ppYTRFJmjTOaPitoVcAxicVJELP0FI4CvyenJpXD1tIViWynsJMu
 yRiiKb9waBQVbuEOjoZFmJdGAiqXDAmAO6qvygwbIiIJOxh7L5HqSP92e
 VUvjevdcp5l1nR0dWC7IcbGX/Gg3CPnH7NuoRgVZcVsyH64ZHgqINm4k3
 KvyI3lIYTw7X7eTviAl7wDrVM0ZwzMaistyKoCZkNCUSldkpZAF4tyBLE A==;
X-CSE-ConnectionGUID: dSo9y1VXTAm+18IcxL/IKg==
X-CSE-MsgGUID: qD5yRsRCRYaqBImTio6RKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="66707310"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="66707310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 00:56:51 -0700
X-CSE-ConnectionGUID: SUO1pp4kQlGfwqado8LRkw==
X-CSE-MsgGUID: YrUoENDaT5GcnK1KGzRVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="129528659"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Mar 2025 00:56:46 -0700
Date: Wed, 26 Mar 2025 16:17:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 3/7] target/ppc: Register CPUClass:list_cpus
Message-ID: <Z+O3/7zqBa1h3V8l@intel.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324185837.46506-4-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Mar 24, 2025 at 07:58:33PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 24 Mar 2025 19:58:33 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 3/7] target/ppc: Register CPUClass:list_cpus
> X-Mailer: git-send-email 2.47.1
> 
> Register ppc_cpu_list() as CPUClass:list_cpus callback.
> Reduce its scope and remove the cpu_list definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu.h      | 4 ----
>  target/ppc/cpu_init.c | 3 ++-
>  2 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


