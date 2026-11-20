Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5B606A895
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ugqzz27lmzb6znw3q24nussc6m.protonmail2 header.b=edJupmeq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTBf-0004zs-48; Fri, 20 Nov 2026 13:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xUTBJ-0004xK-IW
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:17:55 -0500
Received: from mail-106119.protonmail.ch ([79.135.106.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xUTBI-0001O0-9s
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=ugqzz27lmzb6znw3q24nussc6m.protonmail2; t=1795198659;
 x=1795457859; bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=edJupmeqI3DunoOfPhTx/0DYtxziUIetbN3rj4Dt62GFcL+DU2UUxO8M7zTG6sGL7
 m1pAMOlKspJE5kTAIOrfP19bGITXqerLQ9hoOxLa/O/apIgGN7246h3eEGA0FQJcjg
 ayXLnIlgyI8HN36nhoV2wEV5rs7yygCHadEBtbEr0vb//0ady0TyrCJWDIJlGMU2UW
 nw6Z0L1cje5pXHR9mrz9+ClcluT24TcWX8pAs4SwgngolK6gZsaESeBOsP7f2VzFPa
 kIxADOy0kgbyJD1vaLwtB2stCbFnMqRKM0hJbvLAaGPNAT1kyCLu7Ll44McIEORHdI
 XbFnfam3u0aNQ==
Date: Fri, 20 Nov 2026 18:17:33 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: Christian <christianslima@proton.me>
Subject: Re: [PATCH 0/2] Change mstatus bits to read-only based on modes
Message-ID: <o-18TH9eryVkgR2WpDfeE7FFRRPxJSWu7ZS9-PtQo_zmDjvdzHu-XeJG6R9r_g4Nep8NANcmg1E0lHTM0mJUfF0SiIsgTzJZL5_Hi61KnT4=@proton.me>
In-Reply-To: <20261113214854.40425-1-christianslima@proton.me>
References: <20261113214854.40425-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: c25c02edfd90b1429323634485d8a92c86a3e767
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.119;
 envelope-from=christianslima@proton.me; helo=mail-106119.protonmail.ch
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping.

