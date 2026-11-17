Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CB606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=aSFR4/u/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTDi8-0006Qq-81; Tue, 17 Nov 2026 02:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTDi5-0006PN-SR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:34:34 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTDi3-00048K-UW
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794900868; bh=yFq3EJMJlogkY4yx7luiOFa9GlIO6xRqm5aaixEsFQY=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=aSFR4/u/FdqJaeWfqA4ltqukhus18eN/eYrs4BWPX7GaE9rzh7wC4GFwRZzRLX5Yl
 ws1n24h3jtOGDyp3ex561GJR/CWdIql4D0aqJN8HNwydMJK9o0aJG7XCkRz+Azv2w7
 8FVMGsKb6jBQ5afPCgCWe23mqX47kIj4F1DOsl5aXPPf7c6NhooxNOEV5y7WHRKoCr
 C9NNLZycJ0QdTsfsWdJF18wPGD7Olge2vRrKfo9/WxtnXNvNgXgobZAwKv4GHa89hJ
 +8w2/uzUT9Vi1VICXiH5higkTfqv6LVrfGuL36bmiW5eyFmEdHXD5lIfnK8wwzFWpQ
 dYDOn7jEtnnQA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAB131E7479;
 Tue, 17 Nov 2026 10:34:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C014845FFCA;
 Tue, 17 Nov 2026 10:34:28 +0300 (MSK)
Message-ID: <07eec428-7ba8-4b3b-a3cb-01e1402bb5d2@tls.msk.ru>
Date: Tue, 17 Nov 2026 10:34:28 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] roms: record the H2 commit in a file
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
 <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
 <e4a7622f-d87c-42c3-9a36-4e461199fd4b@oss.qualcomm.com>
 <0a20e3fe-74d4-46d2-851c-f14cde22c842@oss.qualcomm.com>
 <987426a9-a3cc-43ca-8dff-4e911a253a68@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <987426a9-a3cc-43ca-8dff-4e911a253a68@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 20:24, Brian Cain wrote:
> On 11/14/2026 9:00 AM, Pierrick Bouvier wrote:

>> and compare content to *git* output.
> 
> Sure - that's fine with me - @Michael do you have a preference?

I don't have any preferences here - it's up to you to make your own life
as simple as possible.

> I just followed what edk2 was doing, assuming it was already satisfactory for the packaging/distro usage.

The original problem (addressing git repo when there's none) is solved either way.
A problem with stale data is a different one :)
This is just a random string which means nothing.  It would be better if it reflected
reality - it might help in debugging for example.  But for packaging it has no meaning
at all.

Thanks,

/mjt

