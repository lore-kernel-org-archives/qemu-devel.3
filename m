Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41160CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpxq-0006ti-Cx; Wed, 30 Sep 2026 04:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpxa-0006nR-Ml; Wed, 30 Sep 2026 04:46:44 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpxY-0002DB-G8; Wed, 30 Sep 2026 04:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790758001; x=1822294001;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=z7PXbhljuL5WavjySfOO/jtQioxcKIn9WTW+rzRdMwc=;
 b=R5b0QxuhQ9XFywwWw+ag7k/TZX64eZ7t1TtrYgV1OHx19v1O5FFuvsx/
 gIrKCT9cGFiHEp4qvG+W0iyY4Q+qug2by6qMuR75/IX8kRVdxTc4l1GiF
 3TvFwP/2gQ9g16VLMu/drYhiboJmXvki6Oh1iKaTMtLGDhVXhvpT13ftC
 T4rIAkPOdtyg+Fw1ow+TFpzMdWb6ahXgDLrexYyjJjV0xvUD3opvD4z9Q
 B43hI3O8khLHI7kjmBOjck4FkIP8xJoXlwMom/m/wXPolgp+ISm+7eaZL
 sHUjtOftmId4Aq2SU4+cwxDlOF+JGRA48+D3EIWJP267okYOxhLGTr6ti g==;
X-CSE-ConnectionGUID: uFYTbqcOT8+LvCNUO5nmyA==
X-CSE-MsgGUID: 3Wiuodh4SHi43bDTUIzrPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117019354"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="117019354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:46:38 -0700
X-CSE-ConnectionGUID: O2LEIdIwQLuhV1nNJiAq6w==
X-CSE-MsgGUID: se0ZxeEET8+PTbC+n1iYpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="278972895"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa004.jf.intel.com with ESMTP; 30 Sep 2026 01:46:33 -0700
Date: Wed, 30 Sep 2026 16:46:32 +0800
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
Subject: Re: [PATCH v3 09/10] qapi: return MachineInfo typename from
 query-machines
Message-ID: <arzMaD7ESEh0V3se@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-10-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926081551.29-10-luoyonggang@gmail.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Sat, Sep 26, 2026 at 04:15:49PM +0800, Yonggang Luo wrote:
> Date: Sat, 26 Sep 2026 16:15:49 +0800
> From: Yonggang Luo <luoyonggang@gmail.com>
> Subject: [PATCH v3 09/10] qapi: return MachineInfo typename from
>  query-machines
> X-Mailer: git-send-email 2.52.0.windows.1
> 
> query-machines returned only the -M name, so management apps inferred
> the QOM type as that name plus "-machine". A prefixed type such as
> arm-virt-11.1-machine no longer matches -M virt-11.1. Return the QOM
> type in MachineInfo typename from object_class_get_name() in
> qmp_query_machines(). test_query_machines_typename checks that
> qom-list-properties accepts it.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c |  1 +
>  qapi/machine.json          |  6 +++-
>  tests/qtest/qom-test.c     | 65 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 65 insertions(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


