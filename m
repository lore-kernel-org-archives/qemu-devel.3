Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3ABC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJO0-0000jO-4F; Wed, 12 Mar 2025 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1tsJNe-0000hE-G3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:11 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1tsJNV-0001h4-An
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6IDSRLLAZjG7wnkAfEMR3ODc1wE4j+5StOKqB4tCXo8=; b=FkgiYnJoY0w8oQ4zc3V/9ztZUr
 g6g2NHI4esyc0Kq1rHZneBi0GZ6NQ3Dc0ae84CRA0k2wd4rdeshCidbzLDycuUGqREdbIbPldSHZU
 eGqCnzB1pFlOwzNlaDIkNkXQ2EUYmQZ7czrlif8ompB++CdTsQouiPVrOXiHpCrVKq/qjQyCrjUSt
 1sYf6AwJaKcythkM7+JQQuWAgBj6c1xJPoAdPHazdTfxlhJsBdZPwraWZ97dlUClUuZphNR/DeRxI
 /V5SCBGOvK76VPEMBsAsVtaGETeqrn8ZKKvxKY0fBxZB8x4dlGg+Z4InwyvfStgR32QGPblw7M3FQ
 nz2u6ejw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tsJN2-007Zpo-J8; Wed, 12 Mar 2025 11:31:34 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1tsJN6-00CZjC-M9; Wed, 12 Mar 2025 11:31:34 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1tsJN6-0089Qw-1g;
 Wed, 12 Mar 2025 10:31:32 +0000
From: Alberto Garcia <berto@igalia.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: wencongyang2@huawei.com, zhanghailiang@xfusion.com,
 arei.gonglei@huawei.com, xiechanglong.d@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com
Subject: Re: [PATCH] qapi/block-core: Improve x-blockdev-change documentation
In-Reply-To: <20250311131715.1296101-1-armbru@redhat.com>
References: <20250311131715.1296101-1-armbru@redhat.com>
Date: Wed, 12 Mar 2025 11:31:32 +0100
Message-ID: <w51tt7y1qwr.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue 11 Mar 2025 02:17:15 PM +01, Markus Armbruster wrote:
> The description of feature @unstable is three paragraphs.  The second
> and third became part of the description by accident in commit
> 9fb49daabfb (qapi: Mark unstable QMP parts with feature 'unstable').
>
> The second paragraph describes a defect in terms of the
> implementation.  Fine, but doesn't belong into user-facing
> documentation.  Turn it into a TODO section.
>
> Rewrite everything else for clarity and completeness.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

