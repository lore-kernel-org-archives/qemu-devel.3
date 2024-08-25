Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918E9C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 11:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siBWG-0001Ls-0P; Sun, 25 Aug 2024 07:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pupq=PY=zx2c4.com=Jason@kernel.org>)
 id 1siBW8-0001As-BP
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 07:34:48 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pupq=PY=zx2c4.com=Jason@kernel.org>)
 id 1siBW4-0006wP-Ea
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 07:34:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 131F3CE093A;
 Sun, 25 Aug 2024 11:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DAC32782;
 Sun, 25 Aug 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="BspQ7zA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1724585668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFLgD/pMGkXY8t/WJxrIEO2AHf+T5Ke8CpL5kW4cNfg=;
 b=BspQ7zA5u4Mnd1FNeZwddaQzMdi0IQJMVxIRYk5YP40GTf95dIc89F1B2KS6/ejPW1CDCt
 XRQfsMDxm7fW1ESFxGithnpQ8C6xiI9VMYqmtCdsWxENeJTB3MKdl672j1xvywfnzf8ZQr
 s4Gn2R8ctgh1AuVJ5JQdWx+j4MtTYVc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf08fb83
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 25 Aug 2024 11:34:27 +0000 (UTC)
Date: Sun, 25 Aug 2024 13:34:17 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-devel@nongnu.org,
 openrisc@lists.librecores.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZssWudpcVotQWr45@zx2c4.com>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsgsG_WL7TNcM1_l@antec>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=SRS0=pupq=PY=zx2c4.com=Jason@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> Also, I will wait to see if Jason has anything to say.

So long as this doesn't change the assignment of the serial ports to
device nodes in Linux, I don't think this should interfere with much.
You might want to try it, though.

Jason

