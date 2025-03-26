Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9044C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLzc-0003y5-NH; Wed, 26 Mar 2025 04:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLza-0003wN-Tc; Wed, 26 Mar 2025 04:20:07 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txLzS-0001eK-Ra; Wed, 26 Mar 2025 04:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742977199; x=1774513199;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jWdGreIgXjRw3c8y0YYPKKvqxwNUTqDhMUr7HeNRfqc=;
 b=ibg1HjxHCor3cfHmmqIZ2S+tWMJq0l6Dp10hnfpDJz1IcAAOCk/x3M8t
 uyQhu7YSa851I1Pf7EzZNCghR9EGrDpYJSVrrzbxi02IfT2QMxY6tTXUo
 IhIkZ++lJVzpPC9eyy+3aX+q0ALqUnQJPzhpTR3LsMAoFXzW8hIv//QQs
 ONgOgni74xNn6/LyIG6Xso3sBFOdL0p/+mx23vDV4toUXplMKhgEIHNAT
 LNOi4zuqSbA9bDABQykjdVe2U52UOLSTTG6iIRajhMUmR7mwrBocKpN6W
 6BxxKDJfuaAE5tBUGMPWfBXXwCH372EtugKfBoCzbCQ2C8/emcbVZZU+h A==;
X-CSE-ConnectionGUID: agLxqCPySKCwEdUBVOmZDQ==
X-CSE-MsgGUID: rAERZv3WQyGGpALmqy6IOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54901350"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="54901350"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 01:19:55 -0700
X-CSE-ConnectionGUID: xXmwPM7aQmqaWd1u6oa19g==
X-CSE-MsgGUID: sDrmM9XtSpi0hs/I0qCtpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="155579573"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 26 Mar 2025 01:19:51 -0700
Date: Wed, 26 Mar 2025 16:40:07 +0800
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
Subject: Re: [PATCH v3 5/7] target/s390x: Declare
 s390_set_qemu_cpu_model/cpu_list in cpu_models.h
Message-ID: <Z+O9Z+/t0aDfsb1m@intel.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324185837.46506-6-philmd@linaro.org>
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

On Mon, Mar 24, 2025 at 07:58:35PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 24 Mar 2025 19:58:35 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 5/7] target/s390x: Declare
>  s390_set_qemu_cpu_model/cpu_list in cpu_models.h
> X-Mailer: git-send-email 2.47.1
> 
> Both s390_cpu_list() and s390_set_qemu_cpu_model() are
> defined in cpu_models.c, move their declarations in the
> related "cpu_models.h" header. Use full path to header
> in s390-virtio-ccw.c file.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/s390x/cpu.h         | 4 ----
>  target/s390x/cpu_models.h  | 3 +++
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


