Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18030C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebpt-0002ai-Ah; Mon, 26 Feb 2024 09:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebpq-0002Uy-HV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:20:02 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebpl-0003bu-Ea
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708957198; x=1740493198;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KLP3B+wCxwfRglhatYPIhzy08cQ/1bNM9k1WtUV5ytY=;
 b=kNX/NkviIWbwTHs/cPoIMlsuRidatJEW+8XhJlc0HFrJzeiqhVeGu65g
 VMlrRLj5hbxONpnUl9VJwXLL40x+ar+7CKlwxtU0qRdyfT61g1542x5v7
 CH6NJ+C5BLhEBT3eEbu40JhMycoP9tpPbH1nnyvFzd0KXanW07yk5jE8H
 Uu3KbftvuGl+JOapQYP7ZkyWd30BvDaRMHx+ENoaxGIsNnCOjtjKHYLG6
 mSYmSEYAHu1mFRJ4vJ9ob6sORJfBe2j/UDVOc1pTGMBOYuDf+ve7ve/DO
 h1c8uQP9x510lCNoP2EvqUMAOjQAOtx9ObavYHJyE8n16pBmNs2BnGgNe Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20691629"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="20691629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 06:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7221671"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 06:19:52 -0800
Date: Mon, 26 Feb 2024 22:33:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 04/10] include/qom/object.h: New
 OBJECT_DEFINE_SIMPLE_TYPE{, _WITH_INTERFACES} macros
Message-ID: <ZdyhPvj4LK8OaHg2@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220160622.114437-5-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 04:06:16PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:16 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 04/10] include/qom/object.h: New
>  OBJECT_DEFINE_SIMPLE_TYPE{, _WITH_INTERFACES} macros
> X-Mailer: git-send-email 2.34.1
> 
> We have an OBJECT_DEFINE_TYPE_EXTENDED macro, plus several variations
> on it, which emits the boilerplate for the TypeInfo and ensures it is
> registered with the type system.  However, all the existing macros
> insist that the type being defined has its own FooClass struct, so
> they aren't useful for the common case of a simple leaf class which
> doesn't have any new methods or any other need for its own class
> struct (that is, for the kind of type that OBJECT_DECLARE_SIMPLE_TYPE
> declares).
> 
> Pull the actual implementation of OBJECT_DEFINE_TYPE_EXTENDED out
> into a new DO_OBJECT_DEFINE_TYPE_EXTENDED which parameterizes the
> value we use for the class_size field.  This lets us add a new
> OBJECT_DEFINE_SIMPLE_TYPE which does the same job as the various
> existing OBJECT_DEFINE_*_TYPE_* family macros for this kind of simple
> type, and the variant OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES for
> when the type will implement some interfaces.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/qom.rst   |  34 +++++++++++--
>  include/qom/object.h | 114 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 117 insertions(+), 31 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


