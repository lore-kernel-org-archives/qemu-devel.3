Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316F3CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uveXf-0001J0-EG; Mon, 08 Sep 2025 12:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uveXK-0001E4-5y
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:16:17 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uveXE-0002om-0o
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XSQ0JBnQjPPmzxj8jwlIRybqtbsZYC3dhO/GSppf4yg=; b=lPOc6sseWQYgbAPesB6MAehkvr
 H9juV09yQIwgWd/aML7TbM1IHUm345cFggL8kxrJkfGxYvAuA5LbNa1s30GC16SAsIaHks7sZ5sx0
 +4rpJ+Tdaxd76oORB9ihfq/6ig5UkHXWR9axt6NFSVqjGZ1Qr98BCjwuQDEe3+er8WBY3IR9TtyTy
 66v5iIJRLZAz98ip3n83ybhvltxGxftYUTdqzZQpcc0wJtS5kW19GuQR0+kyw7JViM/mmRTmV3qqJ
 /80RvRloEP6WJ9Apq4XpTCLKHybJb9ybJBbCFTNNUwiudpdqzt1uF4FzPpEn6wPrc9/kgkkuLmS7j
 diVB/NiCRH2vIEMLGupmp1kvSSieDlDkJEdV4UJZH+g/bT1DpdNd1WaOP1Jw4OqrvA/A0J4utzGoE
 L8EOb1SB4pNNZUcYF8nKrHAtDjHIZfS4SDKism5I8CdAyHuvizEWPCC6s+MqEuvSEgEMnxBIVM7Xo
 KfajeFbN+7kWCie09T/gVkTE/i2HbUHGsQKFCHEPvDgg50/lx8Kkj7JEEP+niufXF3q8sTiMWXN22
 Yj+zvE2Ex13H84iNVDwqHA9evCsIvrg+t+pl4nOFMYeuOqBeAkB2mIvlqfwilvkxo0fQhAOF+FtHM
 3QTL1O+00ntCWp7jxrXBScyVy77j59cqn/V8BoM84=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, pbonzini@redhat.com, nabihestefan@google.com, 
 Peter Foley <pefoley@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Stop including gstrfuncs.h
Date: Mon, 08 Sep 2025 18:15:42 +0200
Message-ID: <4676136.LvFx2qVVIh@silver>
In-Reply-To: <20250905-9p-v2-1-2ad31999684d@google.com>
References: <20250905-9p-v2-1-2ad31999684d@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, September 5, 2025 5:17:11 PM CEST Peter Foley wrote:
> gstrfuncs.h is not intended to be included directly.
> In fact this only works because glib.h is already included by osdep.h.
> Just remove the include.
> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



