Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A51E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVauK-0002Fg-11; Wed, 08 Jan 2025 13:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tVauI-0002FD-04
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:35:54 -0500
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tVauD-0002iU-Q9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:35:53 -0500
Message-ID: <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1736361342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWwZFxiDJfU19HGsgOxN59edRsE8tFUnL8RnCegrPbg=;
 b=InPyuIHIPt+/ogdDjySMY5/fIVgoSRn+VK8HILnsZTZ/BcdwIER+rNiOPd+SKoiP/bapTR
 T2alAq19GmR5ewRMhNgXYgJ5ihX7YdmeXVOlb7vPCPJ50h0fiA4dzfH2Z/ENB7ooDdAMja
 LAHf81mBYM1tkYbdd/XgOg+Y0nC5wQ4=
Date: Wed, 8 Jan 2025 19:35:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Stefan Zabka <git@zabka.it>
In-Reply-To: <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b0; envelope-from=git@zabka.it;
 helo=out-176.mta1.migadu.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

On 21/12/2024 15:55, David Hildenbrand wrote:
 > Let's wait for opinions from others first.

<https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored> 
states that two weeks is a reasonable amount of time for follow-up.

Should I also ping the original patch? I thought pinging the thread
would be more appropriate, as it contains relevant information.

