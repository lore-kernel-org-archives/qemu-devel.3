Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE26C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkmhr-000321-66; Fri, 17 Jul 2026 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <listy@localities.work>)
 id 1wkmhq-0002xQ-1t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 13:50:38 -0400
Received: from 089231102037.vcmts-wawpereca-2.vectranet.pl ([89.231.102.37]
 helo=mail.localities.work)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <listy@localities.work>)
 id 1wkmho-0003iq-Eq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 13:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by whale.mine.priv (Postfix) with ESMTP id 87A55EB680
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=localities.work;
 h=content-transfer-encoding:content-type:content-type
 :in-reply-to:content-language:references:from:from:subject
 :subject:user-agent:mime-version:date:date:message-id:received
 :received; s=dkim20251117; t=1784310633; x=1785174634; bh=60uBza
 nhJHqGtQtzBtHGMNrUQU1DOa5lzsXzm+v8cgw=; b=WN69NwNBHFpjr20htJ5TJ5
 VISY0LelQtkLa2v97PXdhZPoTKI3QQ5sDkMkRN0+8lteVJPLPaBw9Xi/+def7vxB
 9V1oZhaAgu7X49yFy+mZda6PpWTstiifIQ8fAdeTLzAmXk1eQixq4naXJuTDGT5B
 BMxhGuqnPuvwwFhGJwR3U=
X-Virus-Scanned: amavis at mine.priv
Received: from whale.mine.priv ([127.0.0.1])
 by localhost (whale.mine.priv [127.0.0.1]) (amavis, port 10022) with LMTP
 id OPPfvqAC4SGc for <qemu-devel@nongnu.org>;
 Fri, 17 Jul 2026 19:50:33 +0200 (CEST)
Received: from [10.3.0.10] (unknown [10.3.0.10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by whale.mine.priv (Postfix) with ESMTPSA id 235EEF1812
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:50:33 +0200 (CEST)
Message-ID: <b228593d-56b7-4081-b7d9-6b351647d447@localities.work>
Date: Fri, 17 Jul 2026 19:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Could not initialize refcount handling:
From: listy <listy@localities.work>
To: qemu-devel@nongnu.org
References: <ff0999dc-df05-4bb0-ac4f-95e481ac6422@localities.work>
Content-Language: en-MW, pl, pl-PL
In-Reply-To: <ff0999dc-df05-4bb0-ac4f-95e481ac6422@localities.work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=89.231.102.37; envelope-from=listy@localities.work;
 helo=mail.localities.work
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=2, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

@devel - this issue I described, stems from "broken" - at 
least in Centos - 10.1.0-24.el10 version.
Use 10.1.0-23.el10 version and issue is no more.

