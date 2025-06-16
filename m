Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AC9C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9Iy-0007Zp-6B; Mon, 16 Jun 2025 08:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uR9Ii-0007Un-PP; Mon, 16 Jun 2025 08:51:01 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uR9Id-000171-NE; Mon, 16 Jun 2025 08:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750078214;
 bh=5OerMBMFu7JIClIJYPRzM84o7dQo4G9lyXWL80e5oYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DPxhi76eBDC83zU19tK7MlIKqZpfGVQyh6rYbz4x2MRmY7G2WmgUlOWH0KOeFEJlV
 rTDBrDA48OTwi4A+VVvmLSWvIIZAhjra7S+yJWdA7hZFt4PMhrBxX50YrW5yZWsYEF
 ogUHXdkNnI26xn3lnvd08ilmFLm0ilX56ShjCJoKpd5Pv6hdIM7Yx/vhuunqrVPApB
 axAFPbUkcO+X9FVb6zNgQEAqp3oooTtAJyYBnVIg/MPNNZv9ajoFum9ODWp+GKdM90
 ekhLEMghEQJ3DoxmLyeqZ9e7QjaIBY2I/9C7ynjlQ8x1P1j58gG2TlBr0EN4gv8zNv
 dp8bELAuBv8Ow==
Received: from [192.168.0.214] (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id D4C05178A;
 Mon, 16 Jun 2025 20:50:09 +0800 (CST)
Message-ID: <4b381b19-0cd2-4036-b9bc-6954869eca28@sean.taipei>
Date: Mon, 16 Jun 2025 08:49:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] include/hw: replace FSF postal address with
 licenses URL
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.05@sean.taipei>
 <3aa8de03-911e-4906-a0c5-5b8ea269ad28@kaod.org> <aE_D5zVzf3qHRP-2@redhat.com>
 <accf0fab-782d-4e0a-9f13-f6a940fc86a1@kaod.org> <aE_ML3jtVgweJMid@redhat.com>
 <63d1cb84-7e65-4c60-a718-92a2807e53ea@kaod.org>
Content-Language: en-US
From: Sean Wei <me@sean.taipei>
In-Reply-To: <63d1cb84-7e65-4c60-a718-92a2807e53ea@kaod.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-512; boundary="------------ms040504060801010204020809"
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is a cryptographically signed message in MIME format.

--------------ms040504060801010204020809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ8OpZHJpYyAmIERhbmllbCwNCg0KT24gMjAyNS82LzE2IDM6NTUgQU0sIEPDqWRyaWMg
TGUgR29hdGVyIHdyb3RlOg0KPiBPbiA2LzE2LzI1IDA5OjQ3LCBEYW5pZWwgUC4gQmVycmFu
Z8OpIHdyb3RlOg0KPj4gT24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgMDk6Mjk6MzVBTSArMDIw
MCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+Pj4gT24gNi8xNi8yNSAwOToxMywgRGFu
aWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+Pj4gT24gU2F0LCBKdW4gMTQsIDIwMjUgYXQg
MDc6Mjk6MDlBTSArMDIwMCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+Pj4+PiBIZWxs
byBTZWFuLA0KPj4+Pj4NCj4+Pj4+IE9uIDYvMTMvMjUgMTg6NDQsIFNlYW4gV2VpIHdyb3Rl
Og0KPj4+Pj4+IFNvbWUgb2YgdGhlIEdQTHYyIGJvaWxlci1wbGF0ZSBzdGlsbCBjb250YWlu
ZWQgdGhlDQo+Pj4+Pj4gb2Jzb2xldGUgIjUxIEZyYW5rbGluIFN0cmVldCIgcG9zdGFsIGFk
ZHJlc3MuDQo+Pj4+Pj4NCj4+Pj4+PiBSZXBsYWNlIGl0IHdpdGggdGhlIGNhbm9uaWNhbCBH
TlUgbGljZW5zZXMgVVJMIHJlY29tbWVuZGVkIGJ5IHRoZSANCj4+Pj4+PiBGU0Y6DQo+Pj4+
Pj4gaHR0cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFNlYW4gV2VpIDxtZUBzZWFuLnRhaXBlaT4NCj4+Pj4+DQo+Pj4+PiBJbnN0
ZWFkLMKgIEkgd291bGQgcmVtb3ZlIHRoZSBsaWNlbnNlIGJvaWxlciBwbGF0ZSBhbmQgYWRk
IDoNCj4+Pj4+DQo+Pj4+PiDCoMKgwqAgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb3ItbGF0ZXINCj4+Pj4NCj4+Pj4gVGhpcyBpcyAqTk9UKiBzb21ldGhpbmcgd2UgYXJl
IGRvaW5nIGZvciBleGlzdGluZyBjb2RlIHNvdXJjZXMsDQo+Pj4+IHVubGVzcyB0aGUgcGVy
c29uIHJlbW92aW5nIGl0IGlzIHRoZSBleGNsdXNpdmUgY29weXJpZ2h0DQo+Pj4+IGhvbGRl
ciBvbiB0aGUgZmlsZS4NCj4+PiBBaC4gU28gSSBtaXN1bmRlcnN0b29kLg0KPj4+DQo+Pj4g
SG93IGlzIGxpY2Vuc2UgYm9pbGVyIHBsYXRlIGRpZmZlcmVudCBmcm9tIHRoZSBTUERYIGlk
ZW50aWZpZXIgdGFnID8NCj4+DQo+PiBJdCBhY2hpZXZlcyB0aGUgc2FtZSBhaW1zLCBidXQg
bm90aWNlIEdQTCBjbGF1c2UgMQ0KPj4NCj4+IMKgwqAgImtlZXAgaW50YWN0IGFsbCB0aGUg
bm90aWNlcyB0aGF0IHJlZmVyIHRvIHRoaXMgTGljZW5zZSBhbmQNCj4+IMKgwqDCoCB0byB0
aGUgYWJzZW5jZSBvZiBhbnkgd2FycmFudHk7Ig0KPj4NCj4+IGFuZCB5ZXMsIHNvbWUgcHJv
amVjdHMgaGF2ZSBub25lIHRoZSBsZXNzIGRvbmUgYSB3aG9sZXNhbGUgcmVwbGFjZW1lbnQg
b2YNCj4+IGJvaWxlcnBsYXRlLiBJIGRvbid0IGtub3cgaG93IHRoZXkgcmF0aW9uYWxpemVk
IGlnbm9yaW5nIHRoaXMgbGljZW5zZQ0KPj4gcmVxdWlyZW1lbnQuIEl0IGlzIHNpbXBsZXIg
dG8ganVzdCBwcmVzZXJ2ZSBib2lsZXJwbGF0ZSBhcy1pcyB0aGF0IHRvDQo+PiBkZWJhdGUg
dGhlIGxlZ2FsIG51YW5jZXMgb2YgdGhpcy4NCj4gT0suIFRoZW4sIGxldCdzIGZvcmdldCBh
Ym91dCB0aGlzIHJlcGxhY2VtZW50Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoN
ClRoYW5rIHlvdSBib3RoIGZvciB0aGUgY2xhcmlmaWNhdGlvbiEgVG8gYXZvaWQgYW55IGNv
bnRyb3ZlcnN5LCBJIHdpbGwgDQprZWVwIHRoZSBwYXRjaCBpbiBpdHMgb3JpZ2luYWwgZm9y
bSwgb25seSByZXBsYWNpbmcgdGhlIGRlcHJlY2F0ZWQgRlNGIA0KYWRkcmVzcyB3aXRoIHRo
ZSBjYW5vbmljYWwgR05VIGxpY2Vuc2VzIFVSTC4NCg0KQ8OpZHJpYywgY291bGQgeW91IHBs
ZWFzZSB0YWtlIGFub3RoZXIgbG9vayBhbmQgbGV0IG1lIGtub3cgaWYgZXZlcnl0aGluZyAN
Cmxvb2tzIGdvb2Q/IElmIHNvLCBJJ2QgYmUgZ3JhdGVmdWwgaWYgeW91IGNvdWxkIGFkZCBh
IFJldmlld2VkLWJ5IHRhZy4gDQpUaGFua3MhDQoNCkFsbCB0aGUgYmVzdCwNClNlYW4gV2Vp
DQoNCg==

--------------ms040504060801010204020809
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ITAfBgNVBAoMGEFzc2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEcMBoGA1UEAwwTQ2VydHVtIFNN
SU1FIFJTQSBDQTAeFw0yNDAyMjAxMDI0NTRaFw0yNjAyMTkxMDI0NTNaMDgxFzAVBgNVBAMM
Dm1lQHNlYW4udGFpcGVpMR0wGwYJKoZIhvcNAQkBFg5tZUBzZWFuLnRhaXBlaTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAMgBdqaX8wyudsaj+2/4E0Nrcn9H5D2ux8KpjEef
D7+Ae9mK/borSr7JTszEFurh3f5N+nXg0X6rr37yfXYvqWvov+Ci8PgexSPXyYLlndbsVcCO
Ca4Y+ikG1FtswWHPkXiwsIK8VPHXQvLUgUJWKPtYxc9/wFwMupX9Ziv1V3+gzxqVfqahy+x9
rZnpdqGvy/ITMTvrKW2qYJqp6GAQzlWlmu/VeTDN+rh4gUAKaLsJkhvDeNy44SEwX1WOqRWD
N3RlrDj5tmlC1Ew02HbeN3T33s/KG5qN9nimo4oJXHMSrivarkIsRqLhnm+jixqTpw5I2kUK
aE0k7O/nIZPRG3RtKhc6szZVGmqZrW3S0OJS2UpRC3CGdgmwF2jr1zC7xL11RWYQwyTMZLOr
9vY0yz9zemNHVNlI0aEKsFqcWw81/2zi56qkl/G9veaPST4UjsMomj5zvYiUT14lpJAut25V
rW/Q/gouSfGHtprks+FiNBBYh8qmqESJPYNT3KAhdFkQUwqwd2HVCCkstmv8+M+w+fJhSRKr
FPCXg/Ermms7fK1kl+i9l/uOgDwVMkGV+y0BGHUUkI6XdehBpillzMkPvRWBfHBEEl6StNKn
wKiJb70wKivclWSFnlEc+GaErKlZuGo5r3IrYKV20RpwdCOFtDlaPV7dH4CqsQt+j7jTAgMB
AAGjggGzMIIBrzAMBgNVHRMBAf8EAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jc21p
bWVyc2FjYS5jcmwuY2VydHVtLnBsL2NzbWltZXJzYWNhLmNybDCBgwYIKwYBBQUHAQEEdzB1
MC4GCCsGAQUFBzABhiJodHRwOi8vY3NtaW1lcnNhY2Eub2NzcC1jZXJ0dW0uY29tMEMGCCsG
AQUFBzAChjdodHRwOi8vY3NtaW1lcnNhY2EucmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3NtaW1l
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
--------------ms040504060801010204020809--

