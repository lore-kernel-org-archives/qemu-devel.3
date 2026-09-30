Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440DBCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpvT-0002oB-FQ; Wed, 30 Sep 2026 04:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpvR-0002lY-6J; Wed, 30 Sep 2026 04:44:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpvP-0001kk-Ml; Wed, 30 Sep 2026 04:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790757868; x=1822293868;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=W/cyKse5vPVvpluI9iDUWQZZ4qWcuFfM4eos5ymyOVw=;
 b=FN9crNcr7Ub8v6DNEfhVnnnWysS+yIxvfLG9mscK69kBpc5k8tW+UpKp
 r2P4K0vDMT56nXlHq0j67PRR5h5TSyQDQmlt7R2pCvXx8Tl4QL/HjMgUh
 LASx43HeoDqp3LrdnARe5ELY0AWHX8i0+SOPXmx4gkxbhZbi5QXWaWQq/
 CInB4idogruQNISUrjua6P6dSs0znWKlOrSjA+ZE14dr0j0vK5TouZgit
 96Gws1xRASyTa3OtTBzhRiX7Lyc+cadL6PH8UyL0cwAJ4jyfbciCurrzj
 JgDfDMJUPdQK+jPaEjMSkYeod4CAlsiwCX02hiFBbkcuMsyPuJ/XrpXx1 A==;
X-CSE-ConnectionGUID: mhkQPnqwRE60Wsp+0on1RA==
X-CSE-MsgGUID: 1WY+OW0IQEqdOMHg+LpybA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="113276760"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="113276760"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:44:25 -0700
X-CSE-ConnectionGUID: kaRU2zZ6SceLmM8+0IfcSg==
X-CSE-MsgGUID: iuate2o+QRi/IRJOBQQk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="280372803"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2026 01:44:19 -0700
Date: Wed, 30 Sep 2026 16:44:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>
Subject: Re: [PATCH v3 02/10] hw/riscv/virt: use unique QOM name
Message-ID: <arzL4ky3JT+z1boV@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-3-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926081551.29-3-luoyonggang@gmail.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 26, 2026 at 04:15:42PM +0800, Yonggang Luo wrote:
> Date: Sat, 26 Sep 2026 16:15:42 +0800
> From: Yonggang Luo <luoyonggang@gmail.com>
> Subject: [PATCH v3 02/10] hw/riscv/virt: use unique QOM name
> X-Mailer: git-send-email 2.52.0.windows.1
> 
> Use TYPE_RISCV_VIRT_MACHINE so the RISC-V virt QOM type does not
> collide with ARM virt in a combined qemu-system binary. Keep the
> -M / help / migration name as virt via machine_class_set_name().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/riscv/virt.c         | 3 ++-
>  include/hw/riscv/virt.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


