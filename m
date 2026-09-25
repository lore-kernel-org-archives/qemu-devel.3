Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98198C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA69Z-00018W-5q; Fri, 25 Sep 2026 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1xA69Q-00017t-V0; Fri, 25 Sep 2026 09:39:45 -0400
Received: from [115.124.28.219] (helo=out28-219.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1xA69M-00072h-2x; Fri, 25 Sep 2026 09:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1790343314; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
 bh=40NzqZh+P3xDOTy3FGdFZhM/2oRCM6/11oSxn0ynVuo=;
 b=dF6djM02ILvRXd0Nbg/pWttAhDXVs3SKMjRxjKdnT1QSnr3JsZgCdR9Lje6hp21qIbhR1qHVfDeJaHskedENsz2vI9hqhpvoSjbf8yfDVaZ4+7kXZx+s3p+gm3cs53uW/CN132wJSzPaW/o9Z6VkQ41a+HjfMH35K3qLK7foT1dkG6xmO/chsQIYqMwyTAPOzS9LnHeAVw1SH6wd6ZbHmYmgQqSipUZmHMclq3fbp7O/6a6EIC9cnroy1Sp9Zgk2rqvUnwJTJdHh/t2aDYLyMx5uY+eTI3m3lWPVZZ0ny4b7sip6ZrvJ3EW9sVabL/iXEq4dZVjdGKxVVRVyNaj1tg==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3949704|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_news_journal|0.0237082-0.000434327-0.975857;
 FP=3275181920546764027|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032062159;
 MF=hushunchao@bosc.ac.cn; NM=1; PH=DW; RN=9; RT=9; SR=0;
 TI=W4_0.2.3_v5ForWebDing_21251695_1790342993068_o7001c149k; 
Received: from WS-web
 (hushunchao@bosc.ac.cn[W4_0.2.3_v5ForWebDing_21251695_1790342993068_o7001c149k]
 cluster:ay29) at Fri, 25 Sep 2026 21:35:07 +0800
Date: Fri, 25 Sep 2026 21:35:07 +0800
From: "=?UTF-8?B?6IOh6aG66LaF?=" <hushunchao@bosc.ac.cn>
To: "Chao Liu" <chao.liu@processmission.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>,
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "qemu-riscv" <qemu-riscv@nongnu.org>, "Tianze Wu" <wutianze@ict.ac.cn>
Message-ID: <e57c4ef9-8120-4793-8b10-7c7e882e9584.hushunchao@bosc.ac.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdGFyZ2V0L3Jpc2N2OiBhZGQgaGdhdHAtc3BlY2lmaWMgV0FSTCBsZWdh?=
 =?UTF-8?B?bGl6YXRpb24=?=
X-Mailer: [Alimail-Mailagent revision 70576][W4_0.2.3][v5ForWebDing][Unknown]
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn>,
 <arIUSjCzSzp5jcrg@MacBook-Pro-4.local>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_cuMTW96aWxsYS81LjAgKFgxMTsgQ3JPUyB4ODZfNjQgMTQ1NDEuMC4wKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTUyLjAuMC4wIFNhZmFyaS81MzcuMzY=1M
In-Reply-To: <arIUSjCzSzp5jcrg@MacBook-Pro-4.local>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.219 (deferred)
Received-SPF: pass client-ip=115.124.28.219;
 envelope-from=hushunchao@bosc.ac.cn; helo=out28-219.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Reply-To: =?UTF-8?B?6IOh6aG66LaF?= <hushunchao@bosc.ac.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBTbyBrZWVwaW5nIHRoZSBvbGQgTU9ERSBpcyBhIHZhbGlkIGNob2ljZSwgYnV0IG5vdCB0aGUg
b25seSBvbmUuIENvdWxkIHdlIG1ha2UKPiB0aGUgY29tbWVudCBhIGJpdCBtb3JlIG5ldXRyYWw/
CgpBZ3JlZS4gS2VlcGluZyB0aGUgb2xkIG1vZGUgdmFsdWUgaXMganVzdCBvbmUgdmFsaWQgY2hv
aWNlLkknbGwgcmV3b3JkIHRoZSBjb21tZW50CmFjY29yZGluZ2x5IGluIHYyLgoKVGhhbmtzLApT
aHVuY2hhbwo=

