Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01BBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Khe-0005mq-LC; Thu, 02 Oct 2025 10:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v4Khc-0005lc-Ad
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:54:40 -0400
Received: from lin1.islenet.com ([45.33.68.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v4KhU-00087d-2q
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:54:39 -0400
Received: from localhost (localhost [IPv6:::1])
 by lin1.islenet.com (Postfix) with ESMTP id 31BBBF5914
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=islenet.com; h=
 mime-version:user-agent:content-transfer-encoding:content-type
 :content-type:references:in-reply-to:date:date:from:from:subject
 :subject:message-id:received:received; s=default; t=1759416862;
 x=1760280863; bh=7PRQ13fnVPgsqc9sv5pjCnZSNc56NIXeYcmvuSEAci0=; b=
 nhYlgsXuShGvBr0VCaN7ahTN2s1F1VNKS0GOcsffiG+GRkO0hpXFMBfNIkviHdpZ
 gkwkZ/zn4QNxne7qYojGY7yZClU+q+au0yuEBE/aHDtuu9YNKS/tfHQPaj6JiLkF
 +OGnw8tsviG+JKg0JB9yX31E9dmdluhCdP5/QkKUrWG8LpnmLaRkbkxBbzgGLobC
 KY64ldMugsQwhOzYZOSYGtzWEF/KahSCOU1rWgxKfCtc5yzzXof6YK/SqAeJ1BAw
 BoFLWGiBUsM5p3JgJ8/LxQ5dYDjd1uZQWnk1HsKjm3ZVCM3f6/nywnHMIp3Gkwdv
 ZgYjUWFTsh9i2P/jy167tg==
X-Virus-Scanned: amavis at islenet.com
Received: from lin1.islenet.com ([IPv6:::1])
 by localhost (lin1.islenet.com [IPv6:::1]) (amavis, port 10026) with LMTP
 id 9FqfnuRHnUqd for <qemu-devel@nongnu.org>;
 Thu,  2 Oct 2025 10:54:22 -0400 (EDT)
Received: from venus.islenet.com (unknown [IPv6:2601:985:300:a441::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lin1.islenet.com (Postfix) with ESMTPSA id DEFC3F5889
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:54:21 -0400 (EDT)
Message-ID: <30c9712977931c6c94e2bbcc63a99d5b8cff4c0b.camel@islenet.com>
Subject: Re: DOS 6.22 with LIM 4.0 Expanded Memory
From: "Daniel L. Srebnick" <dan@islenet.com>
To: qemu-devel@nongnu.org
Date: Thu, 02 Oct 2025 10:54:21 -0400
In-Reply-To: <69de1286-0750-47d1-bac6-26512a339018@linaro.org>
References: <ebb4d277d49d53e55d9c0d56375df29981631c3e.camel@islenet.com>
 <69de1286-0750-47d1-bac6-26512a339018@linaro.org>
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=45.33.68.68; envelope-from=dan@islenet.com;
 helo=lin1.islenet.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Certainly I'm not the right person to ask about DOS and i386 machines,
> but I'm curious: why 0xD800 (54k)? Shouldn't the EMS window be in the
> 640K-1M range?

D800 (used as the EMM386 frame parmameter) actually refers to D800:0000.  S=
o yes,
the window is in the upper memory space.


