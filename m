Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8E606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=e/cYi641
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJTKs-0005Sj-0D; Wed, 21 Oct 2026 06:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJTKq-0005SV-Ph
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:14:16 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJTKn-0001NW-Vl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hzBOZ/RZUsxIkdXnYtiz01k5yJAIyvBTAAcYg1X8IdI=; b=e/cYi641Ay1lk/T
 E1eEfBqPkwc3/Ba+8Tsq3VuSW8UMMleVQ3JR9cn8WYZ83NaAtg7e+YBytK/1+SfUcd7ttGzPzj1ul
 3hv7ez2OeBhpZ+sZoGSe2u0tIiw+5bW1EKg5DXg3elNpcorrcmw5k5nlMSw+Vp2bAI6b5CNXBAy/d
 qo=;
Date: Wed, 21 Oct 2026 12:19:47 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 07/15] hw/hexagon: add the QCS6490 CDSP machine
Message-ID: <atiRcaC23wQoO74a@hive.localdomain>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
 <20261021004145.1693260-8-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021004145.1693260-8-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                               |   1 +
>  include/hw/hexagon/hexagon.h              |   1 +
>  include/hw/hexagon/qcom_dsp.h             |  81 +++++
>  hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc |  65 ++++
>  hw/hexagon/qcom_dsp.c                     | 410 ++++++++++++++++++++++
>  hw/hexagon/qcs6490_cdsp.c                 |  64 ++++
>  tests/qtest/l2vic-test.c                  |   2 +
>  tests/qtest/qcom-dsp-test.c               |  93 +++++
>  tests/qtest/qct-qtimer-test.c             |   2 +
>  hw/hexagon/Kconfig                        |  15 +
>  hw/hexagon/meson.build                    |   2 +
>  tests/qtest/meson.build                   |   3 +-
>  12 files changed, 738 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/hexagon/qcom_dsp.h
>  create mode 100644 hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc
>  create mode 100644 hw/hexagon/qcom_dsp.c
>  create mode 100644 hw/hexagon/qcs6490_cdsp.c
>  create mode 100644 tests/qtest/qcom-dsp-test.c

Reviewed-by: Anton Johansson <anjo@rev.ng>

