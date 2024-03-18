Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A2EC54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7wB-0003iK-UC; Mon, 18 Mar 2024 04:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm7wB-0003hx-1R; Mon, 18 Mar 2024 04:01:39 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm7w9-0001T7-Ln; Mon, 18 Mar 2024 04:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710748897; x=1742284897;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fZpPZsS9Ek2UYqxKvyku5IJyzfot+3YHcbSDRPzsy1A=;
 b=VC5CTuSIzjAO40yr8nb3MvYQphSODXXX194FER/Iy542vnl6F7huH55n
 AaTw1QzVouztFmUTHXWdMxKh/Sa0+r8PX1zocEchJsE8otpNq/VyLmAta
 2t66BUavowjrfvDPmq+PVGJmGMGUN6zGU3aDMqQRzk1ImJGtA06iLpoCd
 9c9pavPH0wJUBraZ8sGOM6CZ5MsRdzaUaIHWCdMzvj+o7pHocE8jpE39Q
 saILL+D2KBEvooglIOrgBIcKQ8dDN2UCZvm9tt4lYOU0ZlcWerQWsaRDb
 niprhifna3dppaQmOV3j21HQPuzrOCJbNf1jido6peaYzK5Swey/mnNUm A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="30982351"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="30982351"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 01:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13487922"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Mar 2024 01:01:27 -0700
Date: Mon, 18 Mar 2024 16:15:19 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH-for-9.1 03/21] target/ppc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Message-ID: <Zff4F3xCiP7x95wF@intel.com>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315130910.15750-4-philmd@linaro.org>
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 02:08:51PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 15 Mar 2024 14:08:51 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 03/21] target/ppc: Declare CPU QOM types using
>  DEFINE_TYPES() macro
> X-Mailer: git-send-email 2.41.0
> 
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> In few commits we are going to add more types, so replace
> the type_register_static() to ease further reviews.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231013140116.255-16-philmd@linaro.org>
> ---
>  target/ppc/cpu_init.c | 52 +++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 29 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


