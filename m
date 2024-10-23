Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00867D0BB46
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 23:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ko7-0006Mo-9V; Wed, 23 Oct 2024 19:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp@absolutedigital.net>)
 id 1t3ko5-0006MZ-FD
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 19:30:25 -0400
Received: from mx2.absolutedigital.net ([50.242.207.105])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp@absolutedigital.net>)
 id 1t3ko2-0005nF-P4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 19:30:24 -0400
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.18.1/8.18.1) with ESMTPS id
 49NNWFR8004216
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Wed, 23 Oct 2024 19:32:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.18.1/8.18.1) with ESMTPS id
 49NNULPf029411
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 23 Oct 2024 19:30:21 -0400
Date: Wed, 23 Oct 2024 19:30:21 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Markus Armbruster <armbru@redhat.com>
cc: qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo (addtl)
In-Reply-To: <87ldyfweso.fsf@pond.sub.org>
Message-ID: <86d16a-aa9d-d534-99f3-fda47296e0ab@absolutedigital.net>
References: <619777e8-2238-81f-1d61-185dfcd1ac4e@absolutedigital.net>
 <87ldyfweso.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=50.242.207.105;
 envelope-from=cp@absolutedigital.net; helo=mx2.absolutedigital.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 23 Oct 2024, Markus Armbruster wrote:

> I posted the same fix, and it's in a pull request now:
> 
>     Subject: [PULL 07/14] crypto/hash-afalg: Fix broken build
>     Date: Tue, 22 Oct 2024 16:24:08 +0100
>     Message-ID: <20241022152415.1632556-8-berrange@redhat.com>
>     https://lore.kernel.org/qemu-devel/20241022152415.1632556-8-berrange@redhat.com/
> 
> Thanks!
> 

Ah, thank you!

-- 
Cal Peake


