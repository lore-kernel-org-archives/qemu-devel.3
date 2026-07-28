Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FE3C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopi9-0004xl-D8; Tue, 28 Jul 2026 17:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1wopi3-0004xU-1Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:51:35 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1wopi1-00037V-J9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:51:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D016543950;
 Tue, 28 Jul 2026 21:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B77A1F000E9;
 Tue, 28 Jul 2026 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785275491;
 bh=elR2l0QZoJ28mB7RrIQTYjyUnyNC+JgahbhILSNr8U8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=goaqZ2YB05MABZLhS5R2XKwI19zybdhOV/GrTa8l5en0wjkbqxg41wIWGTzsasQkH
 d/DdbCMB2dTa9gRxHhITKEC3tZdnNeJE/ITXBFp5ien0G1UHTQs+U5s0feSZtJsYA2
 5AATD3Ano3yncCSuwP9EZyDAH5WrXhc4EB6eMpjq3Eaww6vSkvaDxk0OapAQuyTbRw
 JNUnwqF5L2Yn1Etxfs4t4wX/bWEwkv0p8GfX8GwZMxy/x012dsdz7cZXH/VNCftRLd
 kW7i4kPghF0h1DA3gf8lukBLnyGpVaFIUwS+gEZBDJTJgt0a9WEEuXfG20ure+Oago
 5nRxlg5ss2IwA==
Date: Tue, 28 Jul 2026 14:51:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
Message-ID: <20260728215128.GB3198102@ax162>
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
 <20260722011530.GA2116566@ax162>
 <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
 <4b6f6450-74ce-497f-b487-71fadf97dc3c@ilande.co.uk>
 <20260727231441.GB3783405@ax162>
 <c6bf0bc3-353b-4d61-a6bc-d84e10f7d811@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6bf0bc3-353b-4d61-a6bc-d84e10f7d811@ilande.co.uk>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=nathan@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 09:27:08PM +0100, Mark Cave-Ayland wrote:
> Ah I see the issue now: you're passing -nodefaults on the command line which
> tells QEMU not to plug any default cards into any bus, however the firmware
> is still trying to access the VGA card upon startup causing the failure.
> Possibly this may have only worked before by accident.
> 
> What you also need to do is use -nographic which leaves the machine as-is,
> but configures the NVRAM such that the console is redirected to the serial
> port. The following modified command line works for me, and avoids the large
> pause during boot:

Ah yes, adding '-nographic' to this command appears to resolve this for
me. Thanks a lot for the solution!

-- 
Cheers,
Nathan

