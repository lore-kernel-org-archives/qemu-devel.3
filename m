Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28660C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLzr-00041G-1L; Wed, 26 Mar 2025 04:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLzo-00040a-4s; Wed, 26 Mar 2025 04:20:20 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLzm-0001rp-3Z; Wed, 26 Mar 2025 04:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742977218; x=1774513218;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yEpjO2HxjOOqhqJIP3u4s3xa7PeM0c4U9zr19DDNV0M=;
 b=Oor33Ch/Ykyv8aWcMHHIBkfpqtX5MiEssgszF/KGiTRbsoKC5jEbHGi/
 2MxEWi6aQd74kbZ5w3Tugt6UQqGS3iO57H8dfVS3EH5wWAkB98o2W8ksB
 xVyZVmcghjgwfi4vrckylqbqyjVb0p0E5Y1erfGYmqFZXJwC6pE7h2+aN
 Wka6FFPHkc22EdoMtV897+dvLDCDpUyuQp3LPzmGTwDYSGHBEftrBm7+5
 h0qvHcEIggppAbkDzE4MoWpkSwjevjOVpGzaq+UzgZm9fSh0UaYFzg4u/
 WpmjdoAhGopwLZs1eRaJrKfuMi8NsbkhVFJ72elC4iRIbfjujRBq1gdli Q==;
X-CSE-ConnectionGUID: jCYFWpr3SHm+AdunVbCZ4A==
X-CSE-MsgGUID: StjSYHmiRX2s7KSprXWZGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54901370"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="54901370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 01:20:15 -0700
X-CSE-ConnectionGUID: VXOfiFR8T4ONMkhbodxnHw==
X-CSE-MsgGUID: v+MX+OECTZWw6/2U5It8bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="155579620"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 26 Mar 2025 01:20:11 -0700
Date: Wed, 26 Mar 2025 16:40:28 +0800
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
Subject: Re: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
Message-ID: <Z+O9fGj2W0KpxXxU@intel.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324185837.46506-7-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 24, 2025 at 07:58:36PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 24 Mar 2025 19:58:36 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
> X-Mailer: git-send-email 2.47.1
> 
> Register s390_cpu_list() as CPUClass:list_cpus callback
> and remove the cpu_list definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/s390x/cpu.h | 3 ---
>  target/s390x/cpu.c | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


