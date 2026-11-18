Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088F606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iHmArvva
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTlok-0004h0-Q7; Wed, 18 Nov 2026 14:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTloj-0004go-2K
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:59:41 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTlof-0006O7-Nl
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795031975; bh=FhMNUbMJVEezlaXNBTNiV1joJwmJ5QaahQyWztNBMSg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iHmArvva//22YB39ZSzhQ/MjntDoy3zRWIyckRkKROJyuCmiNl+1AnxAlMSbIfHod
 eGFH3pB8ANdwPkT59GJ7iGPC6zsuqejSMqMUrHo1bVApvf6g+ZFvvMjNdaOTjUcM9w
 s8Su0kmiwTC48+uhn3aR/c1L6Pskr6bBuYL89dHIkB0E6RCe/EgKtqI1EfgqUg9b2f
 GK5YUdvtSefVs1NfCk2SHz2egxvc/EYS7SxJXFhXsovOp8t1xraMtBXrPxguk0BnEl
 zVquGQDWvB/UmkCNeUdCkacbJEkoa/PqVrVxkovzlfPFltbTCUK7kJKeG2FWlC9CKu
 KCnsVAHgLLiLA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2548A1E7C21;
 Wed, 18 Nov 2026 22:59:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1A05246126F;
 Wed, 18 Nov 2026 22:59:35 +0300 (MSK)
Message-ID: <d206eb87-9f61-4655-9e8c-bc18ce66d376@tls.msk.ru>
Date: Wed, 18 Nov 2026 22:59:34 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pc-bios: rebuild H2 firmware
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
 <20261118171410.3753915-3-brian.cain@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261118171410.3753915-3-brian.cain@oss.qualcomm.com>
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

On 11/18/26 20:14, Brian Cain wrote:
> Rebuild the H2 images with the updated roms/Makefile.
> The H2 sources and build ID are unchanged.

Do we really need this second commit when nothing really changed
besides the way where we're getting the commit ID?

Not that I'm opposing or something, it just feels unnecessary
(the binaries changes that is, not the change to README).

BTW, it looks like the firmware files aren't reproducible too,
just like many other firmware files (since a rebuild makes them
differ).  But it's an entirely different, separate, much larger
question than the scope of this change.

Thanks,

/mjt


