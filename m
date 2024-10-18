Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F44D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ji5-0000qK-5v; Fri, 18 Oct 2024 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1ji4-0000q1-Fi
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:55:52 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1ji2-0003BN-CV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245351; x=1760781351;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0B1SxBxReOVdgfkmxJDvBJO49pGDK1Sq6zEoGh6xCco=;
 b=Q/Fz2kxPLt66CMGwzOaaId5z6iZKJdKFLUhc+JZ17EOIVoaqy1oa5wM7
 73+awS+LjBcqphR8lWBjwLPTdQU07dQZ5US3QQpsM1nx15AxGrFm/gfyz
 Ono2eNMMsI9fT+A+CX4huCMO/FeaiNJ9RBoaXnog2LYST6aQOY36qRGV/
 f16HkfJdv8Qh+ZX4tlHNsNfkUr3pNgvX1fLfXsuzORZlBrf9SOEi+mQ67
 xdBNYv+YVwGYNONnF5bEnh1dp7mZWsfZ3ZkerOnygLoj8QPCOqSGDOuhl
 MDTpUv8H+C7agfkqx0p2L6WHOSIaP0BiHupIXWs223FPGmMbDKor+7RNH g==;
X-CSE-ConnectionGUID: dvJXH6z9TLWNFx94mbcOwA==
X-CSE-MsgGUID: kr6noWadS7CPut2gsKVFYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="40131131"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="40131131"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:55:48 -0700
X-CSE-ConnectionGUID: 1mhOTXeLQDGXsatr8jznwQ==
X-CSE-MsgGUID: RXQdKrmwRkqgDs/jxkxIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78734851"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 18 Oct 2024 02:55:46 -0700
Date: Fri, 18 Oct 2024 18:12:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 25/31] tests: adapt to new import path for qobject
 data type headers
Message-ID: <ZxI0cqZ3i9Hz/ZKk@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-26-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-26-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

Hi Daniel,

On Thu, Oct 17, 2024 at 12:33:37PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:37 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 25/31] tests: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qtest/adm1266-test.c                |  4 ++--
>  tests/qtest/adm1272-test.c                |  4 ++--
>  tests/qtest/ahci-test.c                   |  2 +-
>  tests/qtest/arm-cpu-features.c            |  4 ++--
>  tests/qtest/aspeed_gpio-test.c            |  2 +-
>  tests/qtest/boot-order-test.c             |  2 +-
>  tests/qtest/cdrom-test.c                  |  2 +-
>  tests/qtest/cpu-plug-test.c               |  4 ++--
>  tests/qtest/device-introspect-test.c      |  6 +++---
>  tests/qtest/device-plug-test.c            |  4 ++--
>  tests/qtest/drive_del-test.c              |  4 ++--
>  tests/qtest/emc141x-test.c                |  2 +-
>  tests/qtest/fdc-test.c                    |  2 +-
>  tests/qtest/hd-geo-test.c                 |  2 +-
>  tests/qtest/ide-test.c                    |  2 +-
>  tests/qtest/isl_pmbus_vr-test.c           |  4 ++--
>  tests/qtest/libqmp.c                      |  4 ++--
>  tests/qtest/libqmp.h                      |  2 +-
>  tests/qtest/libqos/generic-pcihost.c      |  2 +-
>  tests/qtest/libqos/libqos.c               |  2 +-
>  tests/qtest/libqos/pci-pc.c               |  2 +-
>  tests/qtest/libqos/qos_external.c         |  8 ++++----
>  tests/qtest/libqtest.c                    | 10 +++++-----
>  tests/qtest/libqtest.h                    |  4 ++--
>  tests/qtest/lsm303dlhc-mag-test.c         |  2 +-
>  tests/qtest/machine-none-test.c           |  2 +-
>  tests/qtest/max34451-test.c               |  4 ++--
>  tests/qtest/migration-helpers.c           |  4 ++--
>  tests/qtest/migration-test.c              |  4 ++--
>  tests/qtest/netdev-socket.c               |  2 +-
>  tests/qtest/npcm7xx_adc-test.c            |  2 +-
>  tests/qtest/npcm7xx_emc-test.c            |  4 ++--
>  tests/qtest/npcm7xx_pwm-test.c            |  4 ++--
>  tests/qtest/npcm7xx_watchdog_timer-test.c |  2 +-
>  tests/qtest/numa-test.c                   |  4 ++--
>  tests/qtest/pvpanic-pci-test.c            |  2 +-
>  tests/qtest/pvpanic-test.c                |  3 ++-
>  tests/qtest/q35-test.c                    |  2 +-
>  tests/qtest/qmp-cmd-test.c                |  2 +-
>  tests/qtest/qmp-test.c                    |  6 +++---
>  tests/qtest/qom-test.c                    |  4 ++--
>  tests/qtest/qos-test.c                    |  2 +-
>  tests/qtest/readconfig-test.c             |  6 +++---
>  tests/qtest/tco-test.c                    |  2 +-
>  tests/qtest/test-filter-mirror.c          |  2 +-
>  tests/qtest/test-filter-redirector.c      |  2 +-
>  tests/qtest/test-netfilter.c              |  2 +-
>  tests/qtest/test-x86-cpuid-compat.c       |  8 ++++----
>  tests/qtest/tmp105-test.c                 |  2 +-
>  tests/qtest/tpm-emu.c                     |  4 ++--
>  tests/qtest/tpm-util.c                    |  2 +-
>  tests/qtest/vhost-user-test.c             |  2 +-
>  tests/qtest/virtio-net-failover.c         |  6 +++---
>  tests/qtest/virtio-net-test.c             |  2 +-
>  tests/qtest/vmgenid-test.c                |  2 +-
>  tests/qtest/wdt_ib700-test.c              |  2 +-
>  tests/unit/check-block-qdict.c            |  4 ++--
>  tests/unit/check-qdict.c                  |  6 +++---
>  tests/unit/check-qjson.c                  | 12 ++++++------
>  tests/unit/check-qlist.c                  |  4 ++--
>  tests/unit/check-qlit.c                   | 12 ++++++------
>  tests/unit/check-qnull.c                  |  2 +-
>  tests/unit/check-qnum.c                   |  2 +-
>  tests/unit/check-qobject.c                | 12 ++++++------
>  tests/unit/check-qom-proplist.c           |  4 ++--
>  tests/unit/check-qstring.c                |  2 +-
>  tests/unit/test-block-iothread.c          |  2 +-
>  tests/unit/test-blockjob-txn.c            |  2 +-
>  tests/unit/test-blockjob.c                |  2 +-
>  tests/unit/test-char.c                    |  2 +-
>  tests/unit/test-forward-visitor.c         |  4 ++--
>  tests/unit/test-image-locking.c           |  2 +-
>  tests/unit/test-keyval.c                  |  6 +++---
>  tests/unit/test-qemu-opts.c               |  4 ++--
>  tests/unit/test-qga.c                     |  4 ++--
>  tests/unit/test-qmp-cmds.c                |  8 ++++----
>  tests/unit/test-qmp-event.c               | 10 +++++-----
>  tests/unit/test-qobject-input-visitor.c   | 12 ++++++------
>  tests/unit/test-qobject-output-visitor.c  | 12 ++++++------
>  tests/unit/test-replication.c             |  2 +-
>  tests/unit/test-visitor-serialization.c   |  4 ++--
>  81 files changed, 160 insertions(+), 159 deletions(-)
> 
> diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
> index d49d2ba931..c303f1fadb 100644
> --- a/tests/qtest/pvpanic-test.c
> +++ b/tests/qtest/pvpanic-test.c
> @@ -9,9 +9,10 @@
>  
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> -#include "qapi/qmp/qdict.h"
> +#include "qobject/qdict.h"
>  #include "hw/misc/pvpanic.h"
>  
> +

Extral blank line :).

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



