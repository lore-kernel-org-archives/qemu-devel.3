Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F16C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tseSn-0002YN-B7; Thu, 13 Mar 2025 05:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tseSm-0002W7-6M
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:02:48 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tseSk-0007w0-2q
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:02:47 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 6A08245206;
 Thu, 13 Mar 2025 10:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741856561;
 bh=1er8NBInoxsLMeWMbPnxACNAJRQB6ra6zyNwJG4kYC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xSraHP9ptKZxQeqvrwauJ6WWlc09MfjFPyynF4HQwwxOrBpU+fEWecX6CijHQddrA
 UkvaN/D1eh3DS4JXOl8qcIZ0UOzr9StbMpM2uhsmvXD10gV0OiTv3kTvATgTQ7QMXX
 kunU/NvPdTHgshpazqQx4WHIHatJdyjr1or26tOMBnKYWupJ4yamglP7NNqWSHAnMr
 UFhwJnnQttvkoxHTHKkS33UF2xFwWZXO8CRr1sPNpAfgoszUHrDXqLLbU5aBbhH5zP
 zs7Tuvs8bmqABIQG6z5HWSEUTJAjX2n9obHwk6p4oFAGPrfYUG+VAEqKC26o3RQqDU
 MbO4SUUs5A3eQ==
Date: Thu, 13 Mar 2025 10:02:40 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9KfMPKr9Tsz-psi@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214153443.159889-1-anisinha@redhat.com>
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Ani,

On Fri, Feb 14, 2025 at 09:04:07PM +0530, Ani Sinha wrote:
> VM firmware update is a mechanism where the virtual machines can use their
> preferred and trusted firmware image in their execution environment without
> having to depend on a untrusted party to provide the firmware bundle. This is
> particularly useful for confidential virtual machines that are deployed in the
> cloud where the tenant and the cloud provider are two different entities. In
> this scenario, virtual machines can bring their own trusted firmware image
> bundled as a part of their filesystem (using UKIs for example[1]) and then use
> this hypervisor interface to update to their trusted firmware image. This also
> allows the guests to have a consistent measurements on the firmware image.

We discussed the implications of the vmfwupdate mechanism as currently
proposed in yesterdays SVSM Development Call[1]. The reason this came to my
attention was a request to support a non-IGVM boot protocol in
COCONUT-SVSM, so I started to look into the vmfwupdate.

I do not claim to have a full picture yet, but what I'd like to better
understand is how the proposed update mechanism plans to guarantee
predictable launch measurements for confidential VMs, especially since
the measurements depend on the exact order of setup calls for the TEE
and data the vmfwupdate mechanism can currently not pass on to the
state-after-reset. Can you please share some details on that?

Regards,

	Joerg

[1] https://github.com/joergroedel/svsm-governance/blob/main/Meetings/devel-call-2025-03-12.md

