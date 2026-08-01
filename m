Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0FEC55173
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 13:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq9tB-0001EW-KT; Sat, 01 Aug 2026 09:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wq9t7-0001D1-W5; Sat, 01 Aug 2026 09:36:30 -0400
Received: from nx202.node02.secure-mailgate.com ([192.162.87.202])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wq9t5-0002IS-Un; Sat, 01 Aug 2026 09:36:29 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wq9sz-009D0j-H3; Sat, 01 Aug 2026 15:36:22 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1785591381;
 bh=+EpPwxgZ1BiGvMYfZMLjSt59XRe4MBhlP6hJKXqy/+M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eIVt1S67jd4XFMgBrFp5HCBiOj7cUw8iHW/YpEhBcckIrJfG9+Tva0dFlA3/moTfS
 3Vs+bRHr9C+KXU1xqfXhCsEM0DXq85paQQjn+6Wr+3hGEVt90ePIu3qOQMeXqrkmwF
 WzN20shUYMN7qTXu0MIeK+hk62AK7uSlXxMPnoYg=
Received: from [192.168.0.157] (p57b2f3b8.dip0.t-ipconnect.de [87.178.243.184])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 82E41282A6B;
 Sat,  1 Aug 2026 15:36:20 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
Message-ID: <59377ca6-c21b-458f-84c6-ae4781cbe540@quante.one>
Date: Sat, 1 Aug 2026 15:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Update cc_op for SAHF
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Language: en-US, de-DE
From: Christian Quante <christian@quante.one>
In-Reply-To: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <178559138106.368429.3118729187368931475@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUBzC3/bPOBhjJPNoIUlIPmxfU4DcARFTTh
 sI3x69cTDCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aG0P+NT3qOhDErudGOV0PdS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RP03zt/uIJZZTqIXbpPFcINdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEn8+k2dKItdKf9qXia+OrIYlkNeH/b+
 FIrFB9gGCVkWfUILc079rO4CdPx1wiTqWUO8Oygfo/G28VkQmrVqjYo3k0x81Q83pBiRuWPxaE4S
 jq7oQAaAI+jxcvCGsIZDAlVKTnmZuN/XgpugWxfxnwJ/apbFFODMsjAgM+pD0raPMvs3HYoxZ2A8
 CL74A8BpRjZUFwK9mUPAFTBeP9/cZuIuC7pHmeuzwSMy7+bss7GERiL3g9ZGqqDl/bOPQLPC3/ZY
 ZKd2Pd97TEghBdfyQQ6fFtrq65CC106N5MI3o/dUqQ64rFepq19s/orQmObs0JMBIkUL/j1Y48Gv
 meURQjjEkwT/NsT7x5Dg6qAh5xrUx5iLYsZY/6Q+SccAt8GACsC8RgkF2DKHi7TCJTp61JYdId5H
 D9oB33/YxWowfWcq9PJ0Z4wY1aFhj3s8/WC/a7t/f8F2KUEkvKxCmnEt4yphbAyeTqRmo8yvsuqp
 7tk0Zpb68ZDHb2joNnN4RK58qT33Y80OmAux3oN13+ztUzne8YtockoBvYVtifPVHsH6G7rScPQU
 KBbu2cYoWKj27d1z3X7rBiKw6Qppq7o4COGx2agYVEnq6tQxKkBsYnv3tzrB6sx5E4nJtVFREhET
 IKxEvU1hIy8rnxnhv7TVvTk59R/2gMGq0KWAzmMf+ibVDsJ5fIvar9fCqnQMebfP1xLNHdHPcrYi
 Mp3swMe2Vaj/r5uv/o7dV7Aeqz5gWWc5qxqXSHvjdU6ko1j7gyOKOKHHfmr+XKw7SC7L17m0/qbU
 Rw+EezLuxuJrExlaS5v+dcW4wqceJ/s7S4v3shz3Ha0=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.202; envelope-from=christian@quante.one;
 helo=nx202.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

QW0gMDkuMDYuMjYgdW0gMDI6Mjggc2NocmllYiBSaWNoYXJkIEhlbmRlcnNvbjoNCj4gUmVtb3Zp
bmcgdGhlIGNhbGwgdG8gZ2VuX2NvbXB1dGVfZWZsYWdzIG1lYW50IHdlIG5vIGxvbmdlcg0KPiB1
cGRhdGVkIGNjX29wIGFmdGVyIGNvbXB1dGluZyBFRkxBR1MuDQo+DQpJIHJhbiBpbnRvIHRoaXMg
cmVncmVzc2lvbiB3aXRoIHJlYWwgZ3Vlc3RzOiBzaW5jZSB0aGUgY2hhbmdlIGluIHYxMS4wDQp0
aGUgUEMgRE9TIDcgaW5zdGFsbGVyIGFib3J0cyB3aGlsZSBjb3B5aW5nIGl0cyBmaXJzdCBmaWxl
LCBhbmQgV2luZG93cw0KMy4xIHNldHVwIGZhaWxzIHRoZSBzYW1lIHdheSAoSSByZXBvcnRlZCBp
dCBhcyAjMzk1OSwgd2hpY2ggd2FzIGNsb3NlZA0KYXMgYSBkdXBsaWNhdGUgb2YgIzM1MzcpLg0K
DQpUZXN0ZWQgdGhpcyBwYXRjaCBvbiB0b3Agb2YgY3VycmVudCBtYXN0ZXIgKGUxNzA1YTI1YWYs
IHYxMS4xLjAtcmMyKS4NCkJvdGggcnVucyB1c2VkIHRoZSBzYW1lIHNjcmlwdCwgdGhlIHNhbWUg
ZmlybXdhcmUgYW5kIGEgZnJlc2hseSBjcmVhdGVkDQo1MDAgTUIgZGlzayBpbWFnZTogYm9vdCB0
aGUgR2VybWFuIFBDIERPUyA3IENELCBydW4gU0VUVVAgdG8gdGhlIGVuZCwNCnRoZW4gaW5zcGVj
dCB0aGUgcmVzdWx0aW5nIGltYWdlIGZyb20gdGhlIGhvc3Qgd2l0aCBtdG9vbHMgYW5kIGZpbmFs
bHkNCmJvb3QgdGhlIG1hY2hpbmUgZnJvbSB0aGF0IGltYWdlLg0KDQogwqAgbWFzdGVyIHVucGF0
Y2hlZDrCoCDCoCBTRVRVUCBzdG9wcyB3aXRoICJJTlNUQUxMQVRJT05TRkVITEVSIC4uLiBEaWUN
CiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGF1ZmdlbGlzdGV0ZSBEYXRlaSB3
dXJkZSBuaWNodCBrb3BpZXJ0LiBGZWhsZXINCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJlaW0gU2NocmVpYmVuIC0tPiBDSEtEU0suQ09NIiBbaW5zdGFsbGF0aW9uDQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJvciAuLi4gdGhlIGxpc3RlZCBmaWxl
IHdhcyBub3QgY29waWVkOyBlcnJvcg0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgd3JpdGluZyBDSEtEU0suQ09NXS7CoCBUaGUgaW1hZ2UgaG9sZHMgdGhyZWUNCiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZpbGVzIC0tIElCTUJJTy5DT00sIElCTURPUy5D
T00sIENPTU1BTkQuQ09NIC0tDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBh
bmQgbm8gXERPUyBkaXJlY3RvcnkuwqAgKEl0IGRvZXMgYm9vdCBpbnRvIGENCiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJhcmUgRE9TLCBzaW5jZSB0aG9zZSB0aHJlZSB3ZXJl
IHdyaXR0ZW4gYmVmb3JlDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0aGUg
aW5zdGFsbGVyIGdhdmUgdXAuKQ0KDQogwqAgbWFzdGVyICsgdGhpcyBwYXRjaDogU0VUVVAgcnVu
cyB0byBjb21wbGV0aW9uIGFuZCByZWJvb3RzIHRoZSBtYWNoaW5lDQogwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBieSBpdHNlbGYuwqAgVGhlIGltYWdlIGhvbGRzIDE1NyBlbnRy
aWVzLCBhbW9uZw0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGhlbSBcRE9T
XENIS0RTSy5DT00gLS0gdGhlIGZpbGUgdGhlIHVucGF0Y2hlZA0KIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcnVuIGZhaWxzIG9uLsKgIEJvb3RpbmcgdGhhdCBpbWFnZSBjb21l
cyB1cCBhcyBhDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmdWxseSBpbnN0
YWxsZWQgc3lzdGVtOiBDT05GSUcuU1lTIGFuZA0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgQVVUT0VYRUMuQkFUIGFyZSBwcm9jZXNzZWQsIHRoZSBkcml2ZXJzIGxvYWQsDQog
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhbmQgVkVSIHJlcG9ydHMgIlBDIERP
UyBWZXJzaW9uIDcuMDAgUmV2aXNpb24gMSIuDQoNCkdpdmVuIHRoZSBDYzogcWVtdS1zdGFibGUs
IGl0IHdvdWxkIGJlIGdvb2QgdG8gc2VlIHRoaXMgaW4gMTEuMS4NCg0KVGVzdGVkLWJ5OiBDaHJp
c3RpYW4gUXVhbnRlIDxjaHJpc3RpYW5AcXVhbnRlLm9uZT4NCg0K

