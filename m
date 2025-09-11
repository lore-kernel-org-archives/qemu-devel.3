Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3226FCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwcf8-0004Wg-BH; Thu, 11 Sep 2025 04:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uwcf4-0004W3-K7; Thu, 11 Sep 2025 04:28:10 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uwcey-0002Iq-Ft; Thu, 11 Sep 2025 04:28:09 -0400
Received: from xb$ultrarisc.com ( [192.168.100.1] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 11 Sep 2025 16:28:54
 +0800 (GMT+08:00)
X-Originating-IP: [192.168.100.1]
Date: Thu, 11 Sep 2025 16:28:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6LCi5rOi?= <xb@ultrarisc.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com, qemu-riscv@nongnu.org,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: =?UTF-8?Q?Re:_Re:_[PATCH_v6_for_v10.0.0_0/2]_t?=
 =?UTF-8?Q?arget/riscv=EF=BC=9AFix_riscv64_kvm_migration?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240625(a75f206e) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8cc425bc-7df6-4523-bb46-a48cc1a964e6-ultrarisc.com
In-Reply-To: <9e0c71fe-55fb-4ca9-aac4-40d38a77e07a@tls.msk.ru>
References: <20250910093529.614305-1-xb@ultrarisc.com>
 <9e0c71fe-55fb-4ca9-aac4-40d38a77e07a@tls.msk.ru>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: iOob5GZvb3Rlcl90eHQ9MTA0MDo4NDA=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <49f382e6.10fb.19937e45190.Coremail.xb@ultrarisc.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBXxM5GiMJovvwsAA--.2097W
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQABB2jA1vAALAATs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgTWljaGFlbO+8jAoKWWVzLCB0aGUgcGF0Y2ggc2VyaWVzIGlzIGludGVuZGVkIHRvIGJlIGFw
cGxpZWQgdG8gdGhlIG5leHQgZGV2ZWxvcG1lbnQgcmVsZWFzZSwgMTAuMi4gIApBZGRpdGlvbmFs
bHksIHdlIHdhbnQgdG8gY2hlcnJ5LXBpY2sgaXQgdG8gdGhlIHN0YWJsZSAxMC4wLnggYW5kIDEw
LjEueCBzZXJpZXMgYXMgd2VsbC4KCkJlc3QgcmVnYXJkcywKWGllIEJvCgoKPiAtLS0tLeWOn+Wn
i+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTWljaGFlbCBUb2thcmV2IiA8bWp0QHRscy5tc2su
cnU+Cj4g5Y+R6YCB5pe26Ze0OjIwMjUtMDktMTAgMTc6NTM6MTQgKOaYn+acn+S4iSkKPiDmlLbk
u7bkuro6ICJYaWUgQm8iIDx4YkB1bHRyYXJpc2MuY29tPiwgcWVtdS1kZXZlbEBub25nbnUub3Jn
Cj4g5oqE6YCBOiBham9uZXNAdmVudGFuYW1pY3JvLmNvbSwgcWVtdS1yaXNjdkBub25nbnUub3Jn
LCBwYm9uemluaUByZWRoYXQuY29tLCBhbnVwQGJyYWluZmF1bHQub3JnLCBhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20sIHJrcmNtYXJAdmVudGFuYW1pY3JvLmNvbSwgcGFsbWVyQGRhYmJlbHQuY29t
LCB4aWFteUB1bHRyYXJpc2MuY29tCj4g5Li76aKYOiBSZTogW1BBVENIIHY2IGZvciB2MTAuMC4w
IDAvMl0gdGFyZ2V0L3Jpc2N277yaRml4IHJpc2N2NjQga3ZtIG1pZ3JhdGlvbgo+IAo+IE9uIDEw
LjA5LjIwMjUgMTI6MzUsIFhpZSBCbyB3cm90ZToKPiA+IFRoaXMgc2VyaWVzKHY2KSByZXBsYWNl
cyB0aGUgZWFybGllciBzZXJpZXMgcGF0Y2giW1BBVENIIHY1IGZvciB2MTAuMC4wIDAvMl0KPiA+
IHRhcmdldC9yaXNjdjogRml4IHJpc2N2NjQga3ZtIG1pZ3JhdGlvbiIuCj4gCj4gSGkhCj4gCj4g
WW91J3JlIHRhcmdldHRpbmcgcWVtdSAxMC4wLCB3aGlsZSB3ZSBhbHJlYWR5IHJlbGVhc2VkIDEw
LjEsCj4gYW5kIHRoZSBuZXh0IHJlbGVhc2UgaXMgMTAuMi4KPiAKPiBEb2VzIGl0IG1lYW4geW91
ciBwYXRjaHNldCBzaG91bGQgYmUgYXBwbGllZCB0byAxMC4yLCBhbmQKPiBjaGVycnktcGlja2Vk
IHRvIHN0YWJsZSAxMC4wLnggYW5kIDEwLjEueCBzZXJpZXM/Cj4gCj4gVGhhbmtzLAo+IAo+IC9t
anQKDQoNCl9fX19fX19fX19fX19fX19fX19fX193d3cudWx0cmFyaXNjLmNvbQ0K6YeN6KaB5o+Q
56S677ya5pys6YKu5Lu25YyF5ous6ZmE5Lu255qE5YaF5a655piv5Y+X5rOV5b6L5L+d5oqk55qE
5L+d5a+G5L+h5oGv77yM5aaC5p6c5oKo5LiN5piv5oyH5a6a5pS25Lu25Lq677yM6K+356uL5Y2z
5bCG5pys6YKu5Lu25Yig6Zmk77yM5rOV5b6L56aB5q2i5Lu75L2V6Z2e5rOV55qE5oqr6Zyy44CB
5aSN5Yi244CB5Lyg5pKt5oiW5Lul5Lu75L2V5pa55byP5L2/55So5pys6YKu5Lu244CC5pys6YKu
5Lu25Lit5YyF5ZCr55qE5oSP6KeB44CB5bu66K6u5piv5Z+65LqO5oiW5Y+X5Yiw5oiR5pa56KGo
6L6+5ZKM5a6a5LmJ55qE5p2h5qy+5Y+K5p2h5Lu255qE6ZmQ5a6a77yM5aaC5peg5oiR5pa555qE
5q2j5byP5Lmm6Z2i5r6E5riF5oiW5o6I5p2D77yM5LiN5Y+v6KKr5Y2V54us5L2c5Li65Lu75L2V
5oOF5b2i5LiL55qE6K+B5o2u5oiW5L6d5o2u44CC5oSf6LCi5oKo55qE55CG6Kej5LiO6YWN5ZCI
44CC54mI5p2D5omA5pyJ44CCSU1QT1JUQU5UIE5PVElDRTogVGhpcyBlbWFpbCwgaW5jbHVkaW5n
IGl0cyBhdHRhY2htZW50IGlmIGFueSwgaXMgY29uZmlkZW50aWFsLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgZGVsZXRlIGl0IGZyb20geW91ciBjb21wdXRl
ciBpbW1lZGlhdGVseS4gQW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIG9yIGRpc3RyaWJ1dGlvbiBv
ZiB0aGlzIG1lc3NhZ2UsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGJhc2VkIG9uIGl0IGlzIHN0
cmljdGx5IHByb2hpYml0ZWQuICBBbnkgb3BpbmlvbnMgYW5kIHN1Z2dlc3Rpb25zIGNvbnRhaW5l
ZCBpbiB0aGlzIGVtYWlsIGFyZSBzdWJqZWN0IHRvIHRoZSB0ZXJtcyBhbmQgY29uZGl0aW9ucyBl
eHByZXNzZWQgYW5kIGRlZmluZWQgYnkgdXMgYW5kIHNob3VsZCBub3QgYmUgcmVsaWVkIHVwb24g
dW5jb25kaXRpb25hbGx5IHVuZGVyIGFueSBjaXJjdW1zdGFuY2VzIHVubGVzcyB0aGV5IGFyZSBj
b25maXJtZWQgaW4gb2ZmaWNpYWwgd3JpdHRlbiBjbGFyaWZpY2F0aW9uIG9yIGF1dGhvcml6YXRp
b24gZnJvbSB1cy4gIFRoYW5rIHlvdSBmb3IgeW91ciB1bmRlcnN0YW5kaW5nIGFuZCBjb29wZXJh
dGlvbi5BbGwgcmlnaHRzIHJlc2VydmVkLg==

