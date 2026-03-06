Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7257FCB632
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYca-0002i4-TJ; Fri, 06 Mar 2026 12:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vyYcT-0002hF-DP; Fri, 06 Mar 2026 12:05:45 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vyYcR-0001Cx-Kl; Fri, 06 Mar 2026 12:05:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B6B143B64;
 Fri,  6 Mar 2026 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDF3C4CEF7;
 Fri,  6 Mar 2026 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772816739;
 bh=oAOBGS8ThhxfMlEfD/AfT4Ubf4P/3Q27waESkJl8AqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bExdCqxVR3vqGvVmA84xXavA2Hx8NCwfMzzLr8L1YSCfdAz+PYkDu2rtCiuGIxyc7
 FMAJg+FEO11g8qtnsOSJlfyHKpvqjEQebJUluy3YKsv5aiqDliiYjmlvSX1YXdXgxx
 IkE5An6RCWiV8USJCTgnDTZcDn/vss2KjEZcriioqlBhs+6G9bkJq10kylfTO966HU
 B5qe24IyFZ6uS+YZVky3OnO2HcOYxMn+caT7Vi6F531INlqAoipbPTsBgNb+EIX00E
 8cS/v7Ky1YwvDOJ4/be2pTOsAmqYny7PnfjBakf/6QK6YWFn+MEBzgXzs8D8ZOOCmF
 89mf3sMhZulKw==
Date: Fri, 6 Mar 2026 10:05:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Avi Kivity <avi@scylladb.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
Message-ID: <aasJYeR9JRcb83Rb@kbusch-mbp>
References: <20260306165717.3360110-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306165717.3360110-1-berrange@redhat.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kbusch@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 06, 2026 at 04:57:13PM +0000, Daniel P. Berrangé wrote:
> The pre-existing serial field should also be length checked to
> detect & report invalid user input instead of silently truncating.

Generally fine with that, but worried about user regressions from
unknowingly relying on the truncation behavior. Could these overflow
conditions just emit a truncation warn_report instead of failing to
start?

