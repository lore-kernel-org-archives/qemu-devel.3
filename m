Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB7DCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1A9t-0003qZ-JU; Tue, 23 Sep 2025 17:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1v1A9r-0003qJ-PS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:02:43 -0400
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1v1A9m-0005IP-Tq
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:02:43 -0400
Message-ID: <83566cc2-476d-4cc1-b6ef-ef89b10daddd@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1758661344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOdFgwWxa58s/IjGej6iJxKRmyywqaee1wpdNeZrhK0=;
 b=M3K8k10NV68tFXclwPrnAoOlbjWrhjN0eIvPB733B+eWUgNMYkY6aJ3yvKkkDaLegaBzit
 pfqP++zywuPzrAmkkhJHcBJaUANfDAmYPpyipBPezPVwgm2ov9krbZvcgbw8BF4tn5YWp9
 0yWe05mYTAc9//sy2UYxPxtIjAYF7Qs=
Date: Tue, 23 Sep 2025 23:02:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/12] rust/qdev: Refine the documentation for QDevProp
 trait
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
 <20250920160520.3699591-7-zhao1.liu@intel.com>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Stefan Zabka <git@zabka.it>
In-Reply-To: <20250920160520.3699591-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170; envelope-from=git@zabka.it;
 helo=out-170.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

At the risk of being terribly annoying:

On 20/09/2025 18:05, Zhao Liu wrote:> From: Manos Pitsidianakis 
<manos.pitsidianakis@linaro.org>
> 
> Refine the documentation to clarify:
>   * `unsfae` requires that `VALUE` must be valid.

I'm assuming this is a typo. If so, is it important enough to be fixed 
or is it fine, since it's "only" the commit message?

