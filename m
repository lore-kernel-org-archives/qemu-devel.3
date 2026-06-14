Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D03BCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 07:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYfVZ-0007vB-HK; Sun, 14 Jun 2026 03:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1wYfVT-0007uc-8X; Sun, 14 Jun 2026 03:43:47 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1wYfVP-0002eF-V9; Sun, 14 Jun 2026 03:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=lNpv0sS3usIf3m7BPM7qAaSCxe2b/G2hgmPbZumyEPU=; b=h
 DhDO/RF9HZmM3jsdQ6xQU62kQKWHmEJY53VQGl3cqmyki5Z0NxqoGi6gk2Kgw1RJ
 3O+/s2eRNW5uKdMHKrI2jQZThkysgrxOBWx0ReGa4SrdWoWkyLw7KRxtSUZ1ug6q
 9MIo3qBQU1U0d5y2xgDY/EEvuHCGfRdloJ3YY0jRhI=
Received: from alanosong$163.com ( [59.173.202.243] ) by
 ajax-webmail-wmsvr-40-148 (Coremail) ; Sun, 14 Jun 2026 15:38:18 +0800
 (CST)
X-Originating-IP: [59.173.202.243]
Date: Sun, 14 Jun 2026 15:38:18 +0800 (CST)
From: "Alano Song" <alanosong@163.com>
To: "Joel Stanley" <joel@jms.id.au>
Cc: "Alistair Francis" <alistair.francis@wdc.com>,
 "Chris Rauer" <crauer@google.com>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Andrew Jones" <andrew.jones@oss.qualcomm.com>,
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>,
 "Chao Liu" <chao.liu.zevorn@gmail.com>,
 "Michael Ellerman" <mpe@kernel.org>,
 "Joel Stanley" <jms@oss.tenstorrent.com>,
 "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>,
 "Portia Stephens" <portias@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 "Hao Wu" <wuhaotsh@google.com>,
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>,
 "Corey Minyard" <cminyard@mvista.com>
Subject: Re:[PATCH v8 10/12] hw/i2c: Add DesignWare I2C Controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260603065859.592063-11-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-11-joel@jms.id.au>
X-NTES-SC: AL_Qu2TA/iZvU4i7iGabOkcm0wQgOk5XsCwu/wk3YNec+AGhTHd9j8gYnxaD2PV+vulEiSCmT60bgJO8/V6Tatkz4ylV05GVp9S4ZuFEU3ypg==
Content-Type: multipart/alternative; 
 boundary="----=_Part_17696_213908844.1781422698137"
MIME-Version: 1.0
Message-ID: <5f8cf79a.10b9.19ec5112e99.Coremail.alanosong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lCgvCgDnD+dqWi5qZ_4IAA--.11676W
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0wrW6mouWmpKDwAA3U
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------=_Part_17696_213908844.1781422698137
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CkF0IDIwMjYtMDYtMDMgMTQ6NTg6NTQsICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5hdT4g
d3JvdGU6Cj5Gcm9tOiBDaHJpcyBSYXVlciA8Y3JhdWVyQGdvb2dsZS5jb20+Cj4KPkFkZCBhIG1v
ZGVsIGZvciB0aGUgU3lub3BzeXMgRGVzaWduV2FyZSBBZHZhbmNlZCBJMkMvU01CdXMgQ29udHJv
bGxlcgo+d2l0aCBzdWZmaWNpZW50IGZ1bmN0aW9uYWxpdHkgdG8gYmUgdXNlZCBieSB0aGUgTGlu
dXggRGVzaWdud2FyZSBJMkMKPnBsYXRmb3JtIGRyaXZlci4KPgo+VGhpcyBJUCBpcyB1c2VkIGlu
IHRoZSBUZW5zdG9ycmVudCBBdGxhbnRpcyBSSVNDLVYgU29DIGFuZCB3aWxsIGJlCj5hZGRlZCB0
byB0aGUgUUVNVSB0dC1hdGxhbnRpcyBtYWNoaW5lLgo+Cj5bbnBpZ2dpbjogY2hhbmdlbG9nLCBj
b2RlIGNsZWFudXBzIGFuZCBmaXhlcyBhcy1wZXIgYmVsb3cgbGlua10KPgo+UmV2aWV3ZWQtYnk6
IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT4KPlNpZ25lZC1vZmYtYnk6IENocmlzIFJhdWVy
IDxjcmF1ZXJAZ29vZ2xlLmNvbT4KPkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjAyMjAxMTAyMTQ3NTUuODEwMzQzLTItdmVudHVyZUBnb29nbGUuY29tCj5bam1zOiBy
ZWJhc2UgYW5kIG1pbm9yIGJ1aWxkIGZpeGVzIGZvciBjbGFzc19pbml0IGFuZCByZXNldCBjYWxs
YmFja10KPkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA1MDcx
MjA1MjQuMTExMDU2LTEtbnBpZ2dpbkBnbWFpbC5jb20KPlNpZ25lZC1vZmYtYnk6IE5pY2hvbGFz
IFBpZ2dpbiA8bnBpZ2dpbkBnbWFpbC5jb20+Cj5BY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgo+UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZKimIDxwaGlsbWRAbGluYXJvLm9yZz4KPkFja2VkLWJ5OiBDb3JleSBNaW55YXJkIDxjbWlu
eWFyZEBtdmlzdGEuY29tPgo+VGVzdGVkLWJ5OiBBbGFubyBTb25nIDxBbGFub1NvbmdAMTYzLmNv
bT4KPlNpZ25lZC1vZmYtYnk6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+CgoKUGluZyBm
b3IgY29kZSByZXZpZXcgOikKCgpBbGFuby4KCg==
------=_Part_17696_213908844.1781422698137
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PHByZT48
YnI+QXQgMjAyNi0wNi0wMyAxNDo1ODo1NCwgIkpvZWwgU3RhbmxleSIgJmx0O2pvZWxAam1zLmlk
LmF1Jmd0OyB3cm90ZToKJmd0O0Zyb206IENocmlzIFJhdWVyICZsdDtjcmF1ZXJAZ29vZ2xlLmNv
bSZndDsKJmd0OwomZ3Q7QWRkIGEgbW9kZWwgZm9yIHRoZSBTeW5vcHN5cyBEZXNpZ25XYXJlIEFk
dmFuY2VkIEkyQy9TTUJ1cyBDb250cm9sbGVyCiZndDt3aXRoIHN1ZmZpY2llbnQgZnVuY3Rpb25h
bGl0eSB0byBiZSB1c2VkIGJ5IHRoZSBMaW51eCBEZXNpZ253YXJlIEkyQwomZ3Q7cGxhdGZvcm0g
ZHJpdmVyLgomZ3Q7CiZndDtUaGlzIElQIGlzIHVzZWQgaW4gdGhlIFRlbnN0b3JyZW50IEF0bGFu
dGlzIFJJU0MtViBTb0MgYW5kIHdpbGwgYmUKJmd0O2FkZGVkIHRvIHRoZSBRRU1VIHR0LWF0bGFu
dGlzIG1hY2hpbmUuCiZndDsKJmd0O1tucGlnZ2luOiBjaGFuZ2Vsb2csIGNvZGUgY2xlYW51cHMg
YW5kIGZpeGVzIGFzLXBlciBiZWxvdyBsaW5rXQomZ3Q7CiZndDtSZXZpZXdlZC1ieTogSGFvIFd1
ICZsdDt3dWhhb3RzaEBnb29nbGUuY29tJmd0OwomZ3Q7U2lnbmVkLW9mZi1ieTogQ2hyaXMgUmF1
ZXIgJmx0O2NyYXVlckBnb29nbGUuY29tJmd0OwomZ3Q7TGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDIyMDExMDIxNDc1NS44MTAzNDMtMi12ZW50dXJlQGdvb2dsZS5j
b20KJmd0O1tqbXM6IHJlYmFzZSBhbmQgbWlub3IgYnVpbGQgZml4ZXMgZm9yIGNsYXNzX2luaXQg
YW5kIHJlc2V0IGNhbGxiYWNrXQomZ3Q7TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI2MDUwNzEyMDUyNC4xMTEwNTYtMS1ucGlnZ2luQGdtYWlsLmNvbQomZ3Q7U2ln
bmVkLW9mZi1ieTogTmljaG9sYXMgUGlnZ2luICZsdDtucGlnZ2luQGdtYWlsLmNvbSZndDsKJmd0
O0Fja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzICZsdDthbGlzdGFpci5mcmFuY2lzQHdkYy5jb20m
Z3Q7CiZndDtSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkqKYgJmx0O3BoaWxtZEBs
aW5hcm8ub3JnJmd0OwomZ3Q7QWNrZWQtYnk6IENvcmV5IE1pbnlhcmQgJmx0O2NtaW55YXJkQG12
aXN0YS5jb20mZ3Q7CiZndDtUZXN0ZWQtYnk6IEFsYW5vIFNvbmcgJmx0O0FsYW5vU29uZ0AxNjMu
Y29tJmd0OwomZ3Q7U2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5ICZsdDtqb2VsQGptcy5pZC5h
dSZndDsKCjwvcHJlPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij5Q
aW5nIGZvciBjb2RlIHJldmlldyA6KTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250
LWZhbWlseTogbW9ub3NwYWNlOyI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTogbW9ub3NwYWNlOyI+QWxhbm8uPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2Pg==
------=_Part_17696_213908844.1781422698137--


