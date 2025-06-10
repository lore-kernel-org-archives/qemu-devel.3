Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF4C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5iM-000450-Kb; Tue, 10 Jun 2025 16:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uP5iJ-00044p-01
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:36:55 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uP5iG-0002yp-Sr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:36:54 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 5E259240101
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 22:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
 s=1984.ea087b; t=1749587809;
 bh=nMjv/i2FqitgZdqx61texRIZlmwRybcZBOG+RzmR430=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:From:To:Subject:From;
 b=bOpqUX+34/4R17WGQRhchNnIrFnwTtnMmcvTbrMtdMBGksU01vDbsODqM3L0Y7QN6
 gs/GgpRR5/+gzr5OIO70cREjQLsbaOUIykIjkbh58I66pNSco3gggZCf4CjZXD9LfK
 rB3J6Y03w56zVJQJ4/SB2zn9wa/vuv4+iNZpO7Cq1oVxBdK8uRQVL0lIs3e8HKDZS+
 omJF+yaw5ELUIp5wP8NyhP3dfa9FSvBN8/xDmQKVN/lriagrsGYiD5ZNwOAXomN7Gk
 P2Cef93Yn9RdUFJPTMv8H73oLEzOAXWK3AaHzbudwTCMO3LDWC/nS5IF8M+XeJYXih
 IW882LD4vbx+AuaXwiMBG4tSkKwJOxztG534Ll5Xx/yW1mITAdoz5CS31cmdAnvwh9
 WRdBlFmZHbOfCOf4jENmQtq3OWTcAi+3nv6x1DsPJmAF2Vp0TfpofTA2F5gRr54LA3
 VqUbb1u6GfmP5yUJJcb0+U2Vj9m7pMDzq3/OF9ip4UnRx92q5np
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bH0vN5rscz6txq;
 Tue, 10 Jun 2025 22:36:48 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 20:36:48 +0000
Message-Id: <DAJ547978XGV.3LNJ0SI0X7GXD@posteo.net>
From: "Sertonix" <sertonix@posteo.net>
To: "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH] pc-bios/s390-ccw: link statically
References: <DAJ1QOSAP9LS.342SQSM0UZU80@posteo.net>
 <4c8bb61a-d919-411b-afeb-eed15c4b2ab9@tls.msk.ru>
In-Reply-To: <4c8bb61a-d919-411b-afeb-eed15c4b2ab9@tls.msk.ru>
Received-SPF: pass client-ip=185.67.36.66; envelope-from=sertonix@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue Jun 10, 2025 at 10:32 PM CEST, Michael Tokarev wrote:
> On 10.06.2025 20:58, Sertonix wrote:
>>=20
>> Adding -pie to LDFLAGS caused s390-ccw.img to become dynamically linked.
>
> Why do you think -pie causes it to become dynamically linked?
>
> /mjt

The documentation (at least for gcc) states that the -pie option produces
a *dynamically* linked position independent executable. (And I verified
that the patch changes the resulting binary from dynamically linked to
statically linked).

Ref https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html#index-pie

