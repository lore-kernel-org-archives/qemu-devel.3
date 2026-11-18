Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49739606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=APUsRL1j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTZX7-0003NK-CO; Wed, 18 Nov 2026 01:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingbozhang@linux.alibaba.com>)
 id 1xTZX1-0003Mt-Dl
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:52:35 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingbozhang@linux.alibaba.com>)
 id 1xTZWv-0003L3-8I
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794984717; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
 bh=XXbX9V79LDgKov47/Bpnh0nHKqDw4OfPe3O3TBgkpLc=;
 b=APUsRL1jcn3XV0t+9FRPtgq7mOmhvaH4U3lHUaR3Bl//Ee8N3AfsT8H9ac6134opC4HLYn+bT0MAP/Iz3/HvZfN7XpXw/ydxHuxGHKngW++DUciOGhifnYPJSv4XzxRvcUpY2uAyMt4tuE4R3ZcKm+8Be2ekjxLChRpGQHDNGI0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=qingbozhang@linux.alibaba.com; NM=1; PH=DW; RN=8; SR=0;
 TI=W4_0.2.3_v5ForWebDing_21448500_1794984678601_o7001c1192; 
Received: from WS-web
 (qingbozhang@linux.alibaba.com[W4_0.2.3_v5ForWebDing_21448500_1794984678601_o7001c1192]
 cluster:ay36) at Wed, 18 Nov 2026 14:51:50 +0800
Date: Wed, 18 Nov 2026 14:51:50 +0800
From: "QingboZhang" <qingbozhang@linux.alibaba.com>
To: "pbonzini" <pbonzini@redhat.com>
Cc: "philmd" <philmd@oss.qualcomm.com>,
 "richard.henderson" <richard.henderson@linaro.org>, "mst" <mst@redhat.com>,
 "jan.kiszka" <jan.kiszka@siemens.com>,
 "mohamed" <mohamed@unpredictable.fr>,
 "QingboZhang" <qingbozhang@linux.alibaba.com>,
 "qemu-devel" <qemu-devel@nongnu.org>
Message-ID: <a9edee93-9820-4da2-aadf-c2271e950021.qingbozhang@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gaHcvaTM4Ni92YXBpYzogZml4IGEgZGVhZGxvY2sgYmV0d2VlbiB2?=
 =?UTF-8?B?YXBpY193cml0ZSgpIGFuZCBtYWNoaW5lIHJlc2V0?=
X-Mailer: [Alimail-Mailagent revision 204205][W4_0.2.3][v5ForWebDing][Safari]
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20261026162118.60423-1-QingboZhang@linux.alibaba.com>,
 <a692e4b9-16a5-48a9-8d0d-78b989704874.qingbozhang@linux.alibaba.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_NjATW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEuMSBTYWZhcmkvNjA1LjEuMTU=XQ
In-Reply-To: <a692e4b9-16a5-48a9-8d0d-78b989704874.qingbozhang@linux.alibaba.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=qingbozhang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Reply-To: QingboZhang <qingbozhang@linux.alibaba.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUGFvbG8sCgpQaW5nLiBDb3VsZCB5b3UgdGFrZSB0aGlzIHRocm91Z2ggeW91ciB0cmVlLCBv
ciBsZXQgbWUga25vdyBpZiBpdApzaG91bGQgZ28gZWxzZXdoZXJlPwoKaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyNjE2MjExOC42MDQyMy0xLVFpbmdib1poYW5nQGxp
bnV4LmFsaWJhYmEuY29tLwoKVGhhbmtzLApRaW5nYm8=

