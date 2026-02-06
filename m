Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49CEEB28F1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 08:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voHgm-00028I-Cz; Fri, 06 Feb 2026 03:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1voHgk-00028A-T7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:59:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1voHgh-00083x-5g
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:59:42 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260206085929epoutp0218e5d0f5935f44d1ea9f362bc485105b~RnKblC-Io0754507545epoutp02n
 for <qemu-devel@nongnu.org>; Fri,  6 Feb 2026 08:59:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260206085929epoutp0218e5d0f5935f44d1ea9f362bc485105b~RnKblC-Io0754507545epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1770368369;
 bh=Jvke9zvbXTaw39uxiM8gXNHTpN/AIT4ncR1HxWy+5Hw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pXsCED+M9mRrMifCPJDi6RVibdwn1rPCfgM0yAB11eBQyp+b5bMQ/TqUafBE4+J2E
 p/ZgAXJ0NZhi2oPmyUX1AaqbO6m35gTz3451653OLMJS3IAE74d55jiBH6Pzdvi2/Y
 jKne9VQ/Sap1d33+9xUHRMXNHCAtHvOQ+ZELJwoc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260206085928epcas5p3984bf2dd4e5e8dcdbce9cc73ea0545fc~RnKa1BatH0225102251epcas5p3j;
 Fri,  6 Feb 2026 08:59:28 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4f6p1W2MTTz3hhT3; Fri,  6 Feb
 2026 08:59:27 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260206085926epcas5p4684137d97bcd6516b6cfa5c093b77f53~RnKZgm9ZR0748407484epcas5p4A;
 Fri,  6 Feb 2026 08:59:26 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260206085924epsmtip2bc5fd377bb91d7e3ddd2edee2e12f202~RnKXUWYoF1122411224epsmtip2i;
 Fri,  6 Feb 2026 08:59:24 +0000 (GMT)
Date: Fri, 6 Feb 2026 14:26:27 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Subject: Re: target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <ulnpgqaqirqgt567jgrp4uhpnffd247kn4mnny46ikchxeu3ov@efvk4xxx6lwf>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kV4JmjwmbByYAf5ws7No0HP372cjRWsnH6mbZwvouRw@mail.gmail.com>
X-CMS-MailID: 20260206085926epcas5p4684137d97bcd6516b6cfa5c093b77f53
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----S5vMiqbC9D9faF8YPw-GIekSHdZgzpYrwqcOSnq._zgadq5.=_468a_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260203130603epcas5p4dfde087764b1131e855c39ac9ceb0326
References: <CGME20260203130603epcas5p4dfde087764b1131e855c39ac9ceb0326@epcas5p4.samsung.com>
 <20260203130257.3263336-1-ashish.a6@samsung.com>
 <CAFEAcA-kV4JmjwmbByYAf5ws7No0HP372cjRWsnH6mbZwvouRw@mail.gmail.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ashish.a6@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------S5vMiqbC9D9faF8YPw-GIekSHdZgzpYrwqcOSnq._zgadq5.=_468a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>
>I looked a bit more closely at the SEVONPEND language in the Arm ARM,
>and it says
>
># When SCR.SEVONPEND bit associated with a security state is one, interrupts
># transitioning from the inactive to the pending state that target that
># security state are wakeup events.
>
>So the thing that determines whether we are looking at the S or the NS
>SCR.SEVONPEND is "does this interrupt target S or NS security state?".
>We have a function for that:
> exc_targets_secure(s, irq)
>
>So we can determine which SCR to look at in this nvic_update_pending_state()
>function and we don't need the callers to pass in scr_bank to us.
>
>exc_targets_secure() requires it to be called only for a non-banked
>exception, but we can call it only inside the irq >= NVIC_FIRST_IRQ
>condition, as all interrupts are non-banked.
>
>This should simplify the changes you're making at the callsites.
>
>thanks
>-- PMM
>

Hi Peter,

Thanks for the detailed review! You're absolutely right - determining 
scr_bank inside nvic_update_pending_state() using exc_targets_secure() 
is cleaner and removes the burden from all the callsites. I'll update 
this for v4.

Thanks,
Ashish


------S5vMiqbC9D9faF8YPw-GIekSHdZgzpYrwqcOSnq._zgadq5.=_468a_
Content-Type: text/plain; charset="utf-8"


------S5vMiqbC9D9faF8YPw-GIekSHdZgzpYrwqcOSnq._zgadq5.=_468a_--

