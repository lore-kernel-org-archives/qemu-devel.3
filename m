Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B019C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDxT-0007f3-10; Thu, 03 Jul 2025 03:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXDxQ-0007eY-3S
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:02:08 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXDxN-00027j-VJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526126; x=1783062126;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=izXQPFn4gHIErNXGZmehAqyjiHuG5GdICgyo1y0O5rU=;
 b=AytfB5BEEV9eEiq5at+4WQr3HepUZpxd8u1JD58godA966vA2Mk11ood
 i6/X77SV6gtfjucgNXG+FZcIdzgGYhj5sx5Uhi1EQqh6cLvGq83xPqBmI
 Y+JTQyMuku+2twLKcTY8qh5vR0+D0EjCArrX6GldDrjSELYoSQauQq1Md
 jRsDCJiBuC7qu2xjLao4cgXeX55W8zGFNvo5RawKape8fEL1KojKJjrVu
 8tooAbvLw7r/SYnNWIwLHzEbPF9XHmB5cb/oTleikxSMEUMJv88ZBv5u/
 7ZJECMJMVZw+vRqTmv+dw4DMzuJFApRxcC2RY93NVuRXiySCDdFentHCm A==;
X-CSE-ConnectionGUID: cVhMYzzES4yZ23csWjaq2w==
X-CSE-MsgGUID: ZfQV3gZzSH2DyjaKXKzbzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64535840"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64535840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:02:02 -0700
X-CSE-ConnectionGUID: 19/ZRvQ7TSCdPdj6a0h9eA==
X-CSE-MsgGUID: 7GLtwbwSTESupKnFXGnasg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158649359"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 03 Jul 2025 00:01:58 -0700
Date: Thu, 3 Jul 2025 15:23:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 21/65] hw/core/machine: Display CPU model name in
 'info cpus' command
Message-ID: <aGYv7HyDOB2mDsKW@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-22-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 08:52:43PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:52:43 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 21/65] hw/core/machine: Display CPU model name in 'info
>  cpus' command
> X-Mailer: git-send-email 2.49.0
> 
> Display the CPU model in 'info cpus'. Example before:
> 
>  $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>  QEMU 10.0.0 monitor - type 'help' for more information
>  (qemu) info cpus
>  * CPU #0: thread_id=42924
>    CPU #1: thread_id=42924
>    CPU #2: thread_id=42924
>    CPU #3: thread_id=42924
>  (qemu) q
> 
> and after:
> 
>  $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>  QEMU 10.0.50 monitor - type 'help' for more information
>  (qemu) info cpus
>  * CPU #0: thread_id=42916 (cortex-a72)
>    CPU #1: thread_id=42916 (cortex-a72)
>    CPU #2: thread_id=42916 (cortex-r5f)
>    CPU #3: thread_id=42916 (cortex-r5f)
>  (qemu)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  qapi/machine.json          | 3 +++
>  hw/core/machine-hmp-cmds.c | 3 ++-
>  hw/core/machine-qmp-cmds.c | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)

It's useful!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

And tested on x86 platform,

Tested-by: Zhao Liu <zhao1.liu@intel.com>


