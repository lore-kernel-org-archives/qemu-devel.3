Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2DFD3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n25-0005ld-5w; Fri, 18 Oct 2024 09:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1n23-0005l0-F8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1n22-0007RH-5G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bjSRQxZk/xaVDJ+RsRoxMIYeCTSvg3PBVo6vj2j3m4=;
 b=FRh/xp4S2kCCPjQn0U+Pv4dYfaUMoSVpSEsijld9hGOFFOw3CgLkLNOdDEUc3WufAu9aCG
 +rcMbVWVPXQFMhKnkCBgcZVdvAblWBGlKVVvss2DF4bv+rQOHSXiaQkhVN8wFI5O4fBrpY
 bzwGdCo6B0DUEAh+pY5q5gPEYz0HFC4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-rYz4bmqwNXOUfAQEVdHiiA-1; Fri,
 18 Oct 2024 09:28:38 -0400
X-MC-Unique: rYz4bmqwNXOUfAQEVdHiiA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795C019560B5; Fri, 18 Oct 2024 13:28:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E190A300019D; Fri, 18 Oct 2024 13:28:31 +0000 (UTC)
Date: Fri, 18 Oct 2024 15:28:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 19/23] hw/block/pflash_cfi01: Prefer DEFINE_TYPES()
 macro
Message-ID: <ZxJifCHvSyWgdKNX@redhat.com>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-20-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005194603.23139-20-shentey@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 05.10.2024 um 21:45 hat Bernhard Beschow geschrieben:
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


