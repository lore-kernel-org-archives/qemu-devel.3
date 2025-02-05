Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263DCC02193
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 00:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfTAW-0006na-Uj; Tue, 04 Feb 2025 19:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1tfTAU-0006nD-Hm; Tue, 04 Feb 2025 19:21:26 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1tfTAS-0007bo-Lt; Tue, 04 Feb 2025 19:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=PFss5dzGnXGQw4YqN/Tb8LWsX1MHL2f3VoIIEgRF7Y8=; b=KSuFD05+zyWEiU6
 saQGYG3CO8CSQ7EDMcA+kuN+S5L721VsPX/dygIQTfL8Zi9VfHSxsRvvvbhTy1JJEipSRPWftttXb
 CSCQN5EVeUDHfzo3gZYpV7lcNrexJEAm1Epo/NZmO/EF7uu4zYYxGRJlPUVRgNNO0X0Sq5BaZajhm
 Ew=;
Date: Wed, 5 Feb 2025 01:21:12 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v3 10/17] hw/arm/xlnx-zynqmp: Use &error_abort for
 programming errors
Message-ID: <habifz773dkqbagma6uwrgfio5bxi4hxab72fteyjci2e6bjni@jc33nwzmfq4r>
References: <20241108154317.12129-1-philmd@linaro.org>
 <20241108154317.12129-11-philmd@linaro.org>
 <34a2d961-738b-423b-9ef1-5f4a85915e67@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a2d961-738b-423b-9ef1-5f4a85915e67@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 04/02/25, Philippe Mathieu-Daudé wrote:
> ping for trivial review?
> 
> On 8/11/24 16:43, Philippe Mathieu-Daudé wrote:
> > When a property value is static (not provided by QMP or CLI),
> > error shouldn't happen, otherwise it is a programming error.
> > Therefore simplify and use &error_abort as this can't fail.
> > 
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   hw/arm/xlnx-zynqmp.c | 44 ++++++++++++++------------------------------
> >   1 file changed, 14 insertions(+), 30 deletions(-)
> > 

Makes sense!:)

Reviewed-by: Anton Johansson <anjo@rev.ng>

