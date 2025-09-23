Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52ECAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0sPg-0000Yn-0l; Mon, 22 Sep 2025 22:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@kubuds.cn>)
 id 1v0sPd-0000YH-2P
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:05:49 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@kubuds.cn>)
 id 1v0sPS-00085Q-95
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kubuds.cn;
 s=reyb2403; t=1758593088;
 bh=/AbnPR+R+isrSTmMzJqlnhqIyh2RbvsFPwL4iVZ2liA=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=oH0GEA01GPS/MhAnNowaQsOiCM15SHXanx1rPEPhsq9ZCkr3+hThkYvBBp33f/2gx
 zYK6d6iSkwDhks+W9oR58ql0hsgjzpmw0xOkarPKDGgtxAr6SO5yVOD3vfX+s81/k9
 /f+tgGvEg27yjE52nvdCT7QUWUruUb1qg133MEWs=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqQ/FTdNJNZZ5kJldjn3TTKGTDiQTNQJo28=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: GNuAIe4AAwcY1N5swqzg8pUKeYIiDanR1Z7WuuGn/KU=
X-Originating-IP: 139.227.152.226
X-QQ-STYLE: 
X-QQ-mid: lv2sz3a-1t1758593082t8e25c4be
From: "=?utf-8?B?5p2O5aiB5aiB?=" <liweiwei@kubuds.cn>
To: "=?utf-8?B?UmljaGFyZCBIZW5kZXJzb24=?=" <richard.henderson@linaro.org>,
 "=?utf-8?B?cGJvbnppbmk=?=" <pbonzini@redhat.com>,
 "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Cc: "=?utf-8?B?a2FzcGVybA==?=" <kasperl@rivosinc.com>,
 "=?utf-8?B?546L5L+K5by6?=" <wangjunqiang@kubuds.cn>,
 "=?utf-8?B?V2VpIFd1?=" <lazyparser@gmail.com>,
 "=?utf-8?B?bGl3ZWkxNTE4?=" <liwei1518@gmail.com>
Subject: Re: Re: [PATCH] accel/tcg: fix self-modify-code problem when modify
 code in a single tb loop
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_68D20039_C9129260_1D3F922C"
Content-Transfer-Encoding: 8Bit
Date: Tue, 23 Sep 2025 10:04:41 +0800
X-Priority: 3
Message-ID: <tencent_55B681D209516B8364F39BD9@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 1756259144
X-BIZMAIL-ID: 16342767215359068385
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 23 Sep 2025 10:04:43 +0800 (CST)
Feedback-ID: lv:kubuds.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NGozucvtNhs93edkWbgeKn9CMtK0SpPl5JRfnFP/WUUg2TvHiRbKpJzm
 8uQjT/l4vN1l0U0c5qlqEfTH3nAB7ljQeF8VYSaMcji0615viVSRrT5UvbabDxzkbzHsLY7
 Doo6bgjIhp0EP33HVhQDZ2SrWLV4A7ELw2UBX58+C8gxXS32ewTGkCj3ambWBExKjpldI2A
 LRblehOHBwqv+MDDh+pk5JQHaNj0kek6K2CYp8ubC8O4NvmAU6EM8bombBCjWp3B+7Xcb68
 TO6p7OjzXEoo/x41GdoFhQqFcObnmrmpuscSpitfFogB1AC5jeFqHUFjinG0ssXu/e5BXcy
 54ZfC+Wi084FDpSQK+tF2PMYUPgn4On3zA9Tp2kQ4luFQFmLvN/tgkCkAh8Bgbyrb53Byv0
 r1Yp+XTEAkCiNwc0NKHKnzSFNggMffh6qLL78+6DfhtwIz+j/oWVQNdYbyzRS/Yfo8U3kzR
 xM/bo5Km8UKi5cvr7d4dJ3FD/vdQxX635uKEacrYuygUu2n6ow77SMT8rQCBIyL81FzYS4n
 tu+6rxMIXmiQ6/njorSBJI6kdJ3fGQCUfJnN4w+zV5H4bRtdeTCPCRTAUKdprTAAJb8DVn1
 LJDYPM/suL79A5zN/yQjniKY7ijyPw+OiHKlUyDT3XB80kZdDWG2TMfIDk0jHuPbYW7AUAS
 7NltVwyNd151h5zhAJ6kv5Y299X/9ZpBYZwbwfyCvxT0XFA1dMM2uy+ye4vH6bD9JZyHiQm
 5PoJS7bWWLycl3UZzjxZBH7R36UzgpuekwNCSqAl+wZsnbsUYQD0GpMvxngphuzY3RQaboj
 UL5oI3dYSxlckpOXFJjdePigiLJlvyfrTzoHveNE3A+rHDjS1hpsTMfMrIPj2D0GHngeViB
 YYdlT3Dk4PaOZD91kXZoMLqt2h5TtPBq8MiSGVR9apiQCdFhVVej76qPID/PTJLzFuv3nHS
 WkX3PM88yJkYwU2TVm/GPnykD03Vu2LjDeyZ5sDCaLuKOtv/OjjqFqRIngMJhIxT2bKaGUR
 jKXrobmh5z/39AtaLA
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.204.34.130; envelope-from=liweiwei@kubuds.cn;
 helo=smtpbguseast2.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.

------=_NextPart_68D20039_C9129260_1D3F922C
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcmZ3Q7IOS6
jjIwMjXlubQ55pyIMjPml6XlkajkuowgMDc6MjLlhpnpgZPvvJoNCiZndDsNCiZndDsgT24g
OS8xNy8yNSAwNTo0NywgbGl3ZWl3ZWlAa3VidWRzLmNuIHdyb3RlOg0KJmd0OyAmZ3Q7IEZy
b206IFdlaXdlaSBMaSA8bGl3ZWl3ZWlAa3VidWRzLmNuJmd0Ow0KJmd0OyAmZ3Q7DQomZ3Q7
ICZndDsgVGhlIHByb2JsZW0gaXMgdHJpZ2dlcmVkIGluIGZvbGxvd2luZyBjb25kaXRpb25z
Og0KJmd0OyAmZ3Q7IC0gdGhyZWFkIDE6DQomZ3Q7ICZndDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDtydW4gc3BpbiBsb29wKGVuZGVkIHdpdGggYSBkaXJlY3QganVtcCkgbGlrZSAiMHgwMDAw
MDA2ZiwgLy8gamFsIHplcm8sICMwIg0KJmd0OyAmZ3Q7IC0gdGhyZWFkIDI6DQomZ3Q7ICZn
dDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtkbyBzb21ldGhpbmcsIGFuZCB0aGVuIG1vZGlmeSB0
aGUgbG9vcCBjb2RlIG9mIHRocmVhZCAxIHRvIG5vcCBpc250cnVjdGlvbiwNCiZndDsgJmd0
OyAmbmJzcDsgJm5ic3A7ICZuYnNwO2ZpbmFsbHkgd2FpdCB0aHJlYWQgMSBleGl0Lg0KJmd0
OyAmZ3Q7DQomZ3Q7ICZndDsgVGhlIGxvb3AgdGIgd2hpY2ggaXMgcGF0Y2hlZCB0byBqdW1w
IHRvIGl0c2VsZiwgd2lsbCBub3QgYmUgdXBkYXRlZCBpbiB0aGlzIGNhc2UNCiZndDsgJmd0
OyBhbmQgd2lsbCBuZXZlciBleGl0Lg0KJmd0OyAmZ3Q7DQomZ3Q7ICZndDsgU2lnbmVkLW9m
Zi1ieTogV2Vpd2VpIExpIDxsaXdlaXdlaUBrdWJ1ZHMuY24mZ3Q7DQomZ3Q7ICZndDsgLS0t
DQomZ3Q7ICZndDsgJm5ic3A7IGFjY2VsL3RjZy9jcHUtZXhlYy5jIHwgOCArKysrKystLQ0K
Jmd0OyAmZ3Q7ICZuYnNwOyAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KJmd0Ow0KJmd0OyBJZiB0aGVyZSdzIGEgcHJvYmxlbSB3aXRoIDEgdGIs
IHRoZXJlJ3MgYWxzbyBhIHByb2JsZW0gd2l0aCAyIHRiIGxpa2UNCiZndDsNCiZndDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGphbCAmbmJzcDsgJm5ic3A7IHplcm8sICM0DQom
Z3Q7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBqYWwgJm5ic3A7ICZuYnNwOyB6ZXJv
LCAjLTQNCiZndDsNCg0KSSB0cmllZCB0aGlzIGNhc2UuIEFuZCBpdCBkaWRuJ3QgaGF2ZSB0
aGlzIHByb2JsZW0uDQpUaGlzIHByb2JsZW0gc2VlbXMgb25seSBleGlzdGVkIGluIHNpbmds
ZSB0YiBsb29wLg0KJmd0Ow0KJmd0OyBCdXQgdW5saW5raW5nIHRoZSB0YiBzaG91bGQgYmUg
cGFydCBvZiBpbnZhbGlkYXRpb24sIHNvIEkgZG9uJ3QgcXVpdGUgc2VlIHdoZXJlIHRoZQ0K
Jmd0OyBwcm9ibGVtIGlzLiAmbmJzcDtZb3UgbmVlZCB0byBleHBhbmQgb24gdGhlIGRlc2Ny
aXB0aW9uIG9mIHRoZSBwcm9ibGVtLg0KJmd0Ow0KDQoNCkkgdGhpbmsgdGhlIHByb2JsZW0g
aXMgdGhlIHNpbmdsZSB0YiBpcyBhbHdheXMgaW4gdXNlJm5ic3A7Jm5ic3A7d2hlbiB0aGUg
c2luZ2xlIHRiIGlzIGxpbmtlZCB3aXRoIGl0c2VsZu+8jA0KYW5kIGl0IGNhbm5vdCBiZSB1
cGRhdGVkIHdoZW4gd2UgdXBkYXRlIHRoZSBjb2Rl44CCDQoNCg0KUmVnYXJkc++8jA0KV2Vp
d2VpIExpDQoNCiZndDsNCiZndDsgcn4=

------=_NextPart_68D20039_C9129260_1D3F922C
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyBsaW5l
LWhlaWdodDogMS40MzsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sIEJsaW5rTWFjU3lz
dGVtRm9udCwgJnF1b3Q7UGluZ0ZhbmcgU0MmcXVvdDssICZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90OzsiPjxkaXYgY2xhc3M9IkFtIGFpTCBhTzkgQWwgZWRpdGFibGUgTFctYXZmIHRT
LXRXIHRTLXRZIiBzdHlsZT0ibWluLWhlaWdodDo4NXB4IiBzcGVsbGNoZWNrPSJmYWxzZSI+
PGRpdiBjbGFzcz0iQW0gYWlMIGFPOSBBbCBlZGl0YWJsZSBMVy1hdmYgdFMtdFcgdFMtdFki
IHN0eWxlPSJtaW4taGVpZ2h0Ojg1cHgiIHNwZWxsY2hlY2s9ImZhbHNlIj48YnI+UmljaGFy
ZCBIZW5kZXJzb24gJmx0O3JpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcmZ3Q7IOS6jjIw
MjXlubQ55pyIMjPml6XlkajkuowgMDc6MjLlhpnpgZPvvJo8YnI+Jmd0Ozxicj4mZ3Q7IE9u
IDkvMTcvMjUgMDU6NDcsIGxpd2Vpd2VpQGt1YnVkcy5jbiB3cm90ZTo8YnI+Jmd0OyAmZ3Q7
IEZyb206IFdlaXdlaSBMaSAmbHQ7bGl3ZWl3ZWlAa3VidWRzLmNuJmd0Ozxicj4mZ3Q7ICZn
dDs8YnI+Jmd0OyAmZ3Q7IFRoZSBwcm9ibGVtIGlzIHRyaWdnZXJlZCBpbiBmb2xsb3dpbmcg
Y29uZGl0aW9uczo8YnI+Jmd0OyAmZ3Q7IC0gdGhyZWFkIDE6PGJyPiZndDsgJmd0OyAmbmJz
cDsgJm5ic3A7ICZuYnNwO3J1biBzcGluIGxvb3AoZW5kZWQgd2l0aCBhIGRpcmVjdCBqdW1w
KSBsaWtlICIweDAwMDAwMDZmLCAvLyBqYWwgemVybywgIzAiPGJyPiZndDsgJmd0OyAtIHRo
cmVhZCAyOjxicj4mZ3Q7ICZndDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtkbyBzb21ldGhpbmcs
IGFuZCB0aGVuIG1vZGlmeSB0aGUgbG9vcCBjb2RlIG9mIHRocmVhZCAxIHRvIG5vcCBpc250
cnVjdGlvbiw8YnI+Jmd0OyAmZ3Q7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ZmluYWxseSB3YWl0
IHRocmVhZCAxIGV4aXQuPGJyPiZndDsgJmd0Ozxicj4mZ3Q7ICZndDsgVGhlIGxvb3AgdGIg
d2hpY2ggaXMgcGF0Y2hlZCB0byBqdW1wIHRvIGl0c2VsZiwgd2lsbCBub3QgYmUgdXBkYXRl
ZCBpbiB0aGlzIGNhc2U8YnI+Jmd0OyAmZ3Q7IGFuZCB3aWxsIG5ldmVyIGV4aXQuPGJyPiZn
dDsgJmd0Ozxicj4mZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogV2Vpd2VpIExpICZsdDtsaXdl
aXdlaUBrdWJ1ZHMuY24mZ3Q7PGJyPiZndDsgJmd0OyAtLS08YnI+Jmd0OyAmZ3Q7ICZuYnNw
OyBhY2NlbC90Y2cvY3B1LWV4ZWMuYyB8IDggKysrKysrLS08YnI+Jmd0OyAmZ3Q7ICZuYnNw
OyAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4m
Z3Q7PGJyPiZndDsgSWYgdGhlcmUncyBhIHByb2JsZW0gd2l0aCAxIHRiLCB0aGVyZSdzIGFs
c28gYSBwcm9ibGVtIHdpdGggMiB0YiBsaWtlPGJyPiZndDs8YnI+Jmd0OyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgamFsICZuYnNwOyAmbmJzcDsgemVybywgIzQ8YnI+Jmd0OyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgamFsICZuYnNwOyAmbmJzcDsgemVybywgIy00
PGJyPiZndDs8YnI+PGJyPkkgdHJpZWQgdGhpcyBjYXNlLiBBbmQgaXQgZGlkbid0IGhhdmUg
dGhpcyBwcm9ibGVtLjxicj5UaGlzIHByb2JsZW0gc2VlbXMgb25seSBleGlzdGVkIGluIHNp
bmdsZSB0YiBsb29wLjxkaXYgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1
NSwgMjU1KTsiPjxicj4mZ3Q7PGJyPiZndDsgQnV0IHVubGlua2luZyB0aGUgdGIgc2hvdWxk
IGJlIHBhcnQgb2YgaW52YWxpZGF0aW9uLCBzbyBJIGRvbid0IHF1aXRlIHNlZSB3aGVyZSB0
aGU8YnI+Jmd0OyBwcm9ibGVtIGlzLiAmbmJzcDtZb3UgbmVlZCB0byBleHBhbmQgb24gdGhl
IGRlc2NyaXB0aW9uIG9mIHRoZSBwcm9ibGVtLjxicj4mZ3Q7PGJyPjxicj48L2Rpdj48ZGl2
IHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5JIHRoaW5r
IHRoZSBwcm9ibGVtIGlzIHRoZSBzaW5nbGUgdGIgaXMgYWx3YXlzIGluIHVzZSZuYnNwOyZu
YnNwO3doZW4gdGhlIHNpbmdsZSB0YiBpcyBsaW5rZWQgd2l0aCBpdHNlbGbvvIw8L2Rpdj48
ZGl2IHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5hbmQg
aXQgY2Fubm90IGJlIHVwZGF0ZWQgd2hlbiB3ZSB1cGRhdGUgdGhlIGNvZGXjgII8YnI+PC9k
aXY+PGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+
PGJyPlJlZ2FyZHPvvIw8YnI+V2Vpd2VpIExpPGJyPjxicj4mZ3Q7PGJyPiZndDsgcn48L2Rp
dj48L2Rpdj48L2Rpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+


------=_NextPart_68D20039_C9129260_1D3F922C--


