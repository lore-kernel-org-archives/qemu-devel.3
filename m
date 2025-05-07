Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945B1C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXck-00017V-5M; Wed, 07 May 2025 01:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXcZ-000125-R0; Wed, 07 May 2025 01:47:10 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXcX-0004dl-TA; Wed, 07 May 2025 01:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746596826; x=1778132826;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rfEXf68V60C0Th20RXfNRgzyZE6DKAjUx9gYV9PtMA0=;
 b=armuA50AwvqrMufGM3lwSLj5yODSBn1iZfhytpmjqdDw3Ygui9+diL/9
 8JKBXYeaaO8UrCPn1kZqLeaabJq1VGP4FAQis0vW1qKlHbkOh1PSdVOX+
 /m8vpYtSoJkBW9v1gK01ozjuNlxQ4FN65OHQ5uTNTuam86LCY1D2mB+In
 /5UEhWapgWCzWiCPnTmYa2ian1cLK1ubjr3I0us+Hqawe0rPNOh63sK7/
 E5shnfYq+tCvTS1oAqfJqIF41bykC5ubK+O3W5P6VHCkzgQGPcDSOgifr
 lOGI3Z96ChjSF8wQ2Eb7wlbjHnmvM3f9XclGSHuW/llruGRD6PUapPnbn A==;
X-CSE-ConnectionGUID: i/CipE3VRKqvQFE9SvTcLg==
X-CSE-MsgGUID: OgJNukXURxiqKxvWATqwUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="35933181"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="35933181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:47:03 -0700
X-CSE-ConnectionGUID: GOKDtlMBS3K8aVJZ7AKaJg==
X-CSE-MsgGUID: 26p/0bHHSniGzE4sR4N5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140959458"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 06 May 2025 22:46:59 -0700
Date: Wed, 7 May 2025 14:07:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 18/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
Message-ID: <aBr4v4XLlUXQUe7n@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-19-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-19-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:39:04PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:39:04 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 18/19] hw/net/vmxnet3: Remove
>  VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
> X-Mailer: git-send-email 2.47.1
> 
> VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
> We removed all machines using that array, lets remove all the
> code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/net/vmxnet3.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


