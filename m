Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17F0E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 08:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWtFq-0006jO-9a; Sun, 12 Jan 2025 03:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tWtFn-0006jE-Ly
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 03:23:28 -0500
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tWtFl-00009Q-GO
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 03:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a7/gASoT0ZHqP0rryQINhkX7xT0jqZkvupgril0VPQw=; b=CEQZlwG3NdHSCfIBiQN1Fh5z6a
 Ww3FwmwWoc7VojOfj23ZTdfMQjk5WuWb+n/EEVEAQjL7RCHdGI9dtVGW5TjR1TEIswvqx8MEAa1X9
 fOFKbAd29yggbBQYBU6UjT+1ZUL2h8xnKBpMAv79HxAJ7fqqBfNP3TPwocOvRj10myGA=;
Date: Sun, 12 Jan 2025 09:23:06 +0100
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] hw/tricore/triboard: Remove use of &first_cpu
Message-ID: <hkxall6nvolwvjy2zjgmaamnhkgfodefb66eaa3lf4tj2l77iq@erlqlaonqogm>
References: <20250110180909.83165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110180909.83165-1-philmd@linaro.org>
X-IMT-Source: Intern
X-IMT-rspamd-score: -25
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), BAYES_HAM(-2.99), TO_MATCH_ENVRCPT_ALL(0.00),
 MID_RHS_NOT_FQDN(0.50), MIME_GOOD(-0.10), NEURAL_HAM(0.00),
 RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00), RCVD_COUNT_ONE(0.00),
 MIME_TRACE(0.00), TO_DN_SOME(0.00), MISSING_XM_UA(0.00),
 RCPT_COUNT_THREE(0.00),
 Message-ID: hkxall6nvolwvjy2zjgmaamnhkgfodefb66eaa3lf4tj2l77iq@erlqlaonqogm
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Fri, Jan 10, 2025 at 07:09:09PM +0100, Philippe Mathieu-Daudé wrote:
> triboard_machine_init() has access to the single CPU via:
> 
>   TriBoardMachineState {
>     TC27XSoCState {
>       TriCoreCPU cpu;
>       ...
>     } tc27x_soc;
>   } ms;
> 
> Pass it as argument to tricore_load_kernel() so we can
> remove the &first_cpu global use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/tricore/triboard.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

