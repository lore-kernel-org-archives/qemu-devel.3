Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB5606A335
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lInpV4nN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLQ4-0003dC-Fk; Mon, 26 Oct 2026 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingbozhang@linux.alibaba.com>)
 id 1xLLQ1-0003cy-6p
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:11:21 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingbozhang@linux.alibaba.com>)
 id 1xLLPw-0002ZD-KE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1793023856; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
 bh=5D6p2tf1I6OrDzN9uWry2RB8tFV194S8Vc9zbZ3bC4E=;
 b=lInpV4nNe9DMT+pE12OrCVujKPjViS9t0rwrH4tNfBXEHzT1cKRNNAQ/z8W+vGqDWe3DI7TE20KFFYgRNlxoWMCcr3uPl51bjy/QcHIZ3yoN4gtcyleDygUmx/ozqDsDL3Tn36C9y+Rwrz0Ge6DBg3fKkLjP0hfKTbtucuKy3d8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=qingbozhang@linux.alibaba.com; NM=1; PH=DW; RN=7; SR=0;
 TI=W4_0.2.3_v5ForWebDing_21250D67_1793023825822_o7001c1504; 
Received: from WS-web
 (qingbozhang@linux.alibaba.com[W4_0.2.3_v5ForWebDing_21250D67_1793023825822_o7001c1504]
 cluster:ay36) at Mon, 26 Oct 2026 22:10:50 +0800
Date: Mon, 26 Oct 2026 22:10:50 +0800
From: "QingboZhang" <qingbozhang@linux.alibaba.com>
To: "=?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@oss.qualcomm.com>, 
 "qemu-devel" <qemu-devel@nongnu.org>
Cc: "pbonzini" <pbonzini@redhat.com>,
 "richard.henderson" <richard.henderson@linaro.org>, "mst" <mst@redhat.com>,
 "jan.kiszka" <jan.kiszka@siemens.com>, "mohamed" <mohamed@unpredictable.fr>
Message-ID: <99666107-a0ea-44e2-bf99-f7738dc38cdb.qingbozhang@linux.alibaba.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSBody9pMzg2L3ZhcGljOiBmaXggYSBkZWFkbG9jayBiZXR3ZWVu?=
 =?UTF-8?B?IHZhcGljX3dyaXRlKCkgYW5kIG1hY2hpbmUgcmVzZXQ=?=
X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][v5ForWebDing][Safari]
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20261026100933.12715-1-QingboZhang@linux.alibaba.com>,
 <3b1e0087-fd62-4149-b8dc-273885ee9e14@oss.qualcomm.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_NjATW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEuMSBTYWZhcmkvNjA1LjEuMTU=XQ
In-Reply-To: <3b1e0087-fd62-4149-b8dc-273885ee9e14@oss.qualcomm.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=qingbozhang@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUGhpbGlwcGUsCgpUaGFua3MgZm9yIHRoZSByZXZpZXchICBCcmllZiByZXBsaWVzIGlubGlu
ZS4KCk9uIDI2LzEwLzIwMjYgMTE6NTcsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOgo+
PiBGaXggdGhpcyBieSBwYXRjaGluZyBvbiB0aGUgY3VycmVudCB2Q1BVIHZpYSBhc3luY19zYWZl
X3J1bl9vbl9jcHUoKSBbLi4uXQo+IE1heWJlIHdvcnRoIGNpdGluZyBzaW1pbGFyIFRDRyBmaXgg
aW4gY29tbWl0IGNiNThhNmQzNjExYi4KCkNpdGVkIGluIHYyLgoKPj4gK3N0YXRpYyB2b2lkIGRv
X3ZhcGljX25vcF9wYXRjaChDUFVTdGF0ZSAqY3MsIHJ1bl9vbl9jcHVfZGF0YSBkYXRhKQo+IFJl
bmFtZSBhcyBkb19wYXRjaF90cmlnZ2VyX25vcD8gQW5kIG1lbnRpb24gdGhpcyBydW5zIGluIGV4
Y2x1c2l2ZSBzZWN0aW9uPwoKRG9uZSBpbiB2MiAocmVuYW1lZCwgYW5kIG5vdGVkIGl0IHJ1bnMg
aW4gYW4gZXhjbHVzaXZlIHNlY3Rpb24pLgoKPj4gKyAgICB0YXJnZXRfdWxvbmcgYWRkciA9ICh0
YXJnZXRfdWxvbmcpZGF0YS50YXJnZXRfcHRyOwo+IFByZS1leGlzdGluZywgcGF0Y2hfYnl0ZSgp
IHNob3VsZCB0YWtlIGEgdmFkZHIsIHRoZW4gdGhpcyBjYXN0IGlzIG5vdCBuZWVkZWQuCgpBZ3Jl
ZWQuICBJJ2xsIGFkZHJlc3MgaXQgaW4gYSBzZXBhcmF0ZSBmb2xsb3ctdXAgY2xlYW51cCBwYXRj
aC4KCj4gRm9yIG5vbi14ODYgZXhwZXJ0czogIC8qIDItYnl0ZSBOT1AgKi8KCkFkZGVkIGluIHYy
LgoKPj4gKyAgICAgICAgICAgIGFzeW5jX3NhZmVfcnVuX29uX2NwdShjdXJyZW50X2NwdSwgZG9f
dmFwaWNfbm9wX3BhdGNoLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJV
Tl9PTl9DUFVfVEFSR0VUX1BUUihpcCkpOwo+IFdoeSBjaGFuZ2Ugb24gY3VycmVudF9jcHUsIGNh
bid0IHdlIHNpbXBseSB1c2UgQ1BVKGNwdSk/IE90aGVyd2lzZToKPiBSZXZpZXdlZC1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgoKSW5kZWVkLCBz
d2l0Y2hlZCB0byBDUFUoY3B1KSBpbiB2Mi4gIEknbGwgY2FycnkgeW91ciBSZXZpZXdlZC1ieSB0
aGVuOwpwbGVhc2UgdGVsbCBtZSBpZiB5b3Ugd291bGQgcmF0aGVyIEkgZHJvcCB0aGUgdGFnLiAg
SSdsbCBwb3N0IHYyIHNob3J0bHkuCgpUaGFua3MsClFpbmdibw==

