Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B85C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 21:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfi2-0006EW-Mr; Mon, 24 Feb 2025 16:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tmfi1-0006EI-AW; Mon, 24 Feb 2025 16:09:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tmfhz-0000Rj-7f; Mon, 24 Feb 2025 16:09:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 92068F17F2;
 Tue, 25 Feb 2025 00:09:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 389F41BE06C;
 Tue, 25 Feb 2025 00:09:35 +0300 (MSK)
Message-ID: <3e847ae0-8dfc-440e-92f7-6eaa89818837@tls.msk.ru>
Date: Tue, 25 Feb 2025 00:09:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ru-RU
To: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 9.2.2 Stable released
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kMDeJbQkaobm0DNsUVaEf4jL"
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kMDeJbQkaobm0DNsUVaEf4jL
Content-Type: multipart/mixed; boundary="------------IlIVclQfNi2jCjV0jjwQRW4u";
 protected-headers="v1"
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <3e847ae0-8dfc-440e-92f7-6eaa89818837@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 9.2.2 Stable released

--------------IlIVclQfNi2jCjV0jjwQRW4u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgZXZlcnlvbmUsDQoNClRoZSBRRU1VIHY5LjIuMiBzdGFibGUgcmVsZWFzZSBpcyBub3cg
YXZhaWxhYmxlLg0KDQpZb3UgY2FuIGdyYWIgdGhlIHRhcmJhbGwgZnJvbSBvdXIgZG93bmxv
YWQgcGFnZSBoZXJlOg0KDQogICBodHRwczovL3d3dy5xZW11Lm9yZy9kb3dubG9hZC8jc291
cmNlDQoNCiAgIGh0dHBzOi8vZG93bmxvYWQucWVtdS5vcmcvcWVtdS05LjIuMi50YXIueHoN
CiAgIGh0dHBzOi8vZG93bmxvYWQucWVtdS5vcmcvcWVtdS05LjIuMi50YXIueHouc2lnIChz
aWduYXR1cmUpDQoNCnY5LjIuMiBpcyBub3cgdGFnZ2VkIGluIHRoZSBvZmZpY2lhbCBxZW11
LmdpdCByZXBvc2l0b3J5LCBhbmQgdGhlDQpzdGFibGUtOS4yIGJyYW5jaCBoYXMgYmVlbiB1
cGRhdGVkIGFjY29yZGluZ2x5Og0KDQogICBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9q
ZWN0L3FlbXUvLS9jb21taXRzL3N0YWJsZS05LjINCg0KVGhlcmUgYXJlIDE0IGNoYW5nZXMg
c2luY2UgdGhlIHByZXZpb3VzIHY5LjIuMSByZWxlYXNlLg0KDQpUaGFuayB5b3UgZXZlcnlv
bmUgd2hvIGhhcyBiZWVuIGludm9sdmVkIGFuZCBoZWxwZWQgd2l0aCB0aGUgc3RhYmxlIHNl
cmllcyENCg0KL21qdA0KDQpDaGFuZ2Vsb2cgKHN0YWJsZS05LjItaGFzaCBtYXN0ZXItaGFz
aCBBdXRob3IgTmFtZTogQ29tbW1pdC1TdWJqZWN0KToNCg0KZWEzNWE1MDgyYSBNaWNoYWVs
IFRva2FyZXY6DQogIFVwZGF0ZSB2ZXJzaW9uIGZvciA5LjIuMiByZWxlYXNlDQpkNjJmNGI2
ZDBkIGYxNDFjYWEyNzAgTWljaGFlbCBUb2thcmV2Og0KICBuZXQvc2xpcnA6IGxpYnNsaXJw
IDQuOS4wIGNvbXBhdGliaWxpdHkNCjlhNTE2NTA0MTkgN2E3NGU0NjgwOCBNaWthZWwgU3py
ZWRlcjoNCiAgdGFyZ2V0L3NwYXJjOiBGaXggZ2Ric3R1YiBpbmNvcnJlY3RseSBoYW5kbGlu
ZyByZWdpc3RlcnMgZjMyLWY2Mg0KNWFmYjgzN2UzYyA4MDdjM2ViZDFlIE1pa2FlbCBTenJl
ZGVyOg0KICB0YXJnZXQvc3BhcmM6IEZpeCByZWdpc3RlciBzZWxlY3Rpb24gZm9yIGFsbCBG
KlRPeCBhbmQgRnhUTyogaW5zdHJ1Y3Rpb25zDQpkZmZlYzJkZGQwIDRiN2IyMGEzYjcgRmFi
aWFubyBSb3NhczoNCiAgZWxmbG9hZDogRml4IGFsaWdubWVudCB3aGVuIHVubWFwcGluZyBl
eGNlc3MgcmVzZXJ2YXRpb24NCmFlYWQ5NWM3ZmEgOTM3ZGY4MWFmNiBQZXRlciBNYXlkZWxs
Og0KICBody9uZXQvc21jOTFjMTExOiBJZ25vcmUgYXR0ZW1wdCB0byBwb3AgZnJvbSBlbXB0
eSBSWCBmaWZvDQo0YjFiMzRjMWU3IGI3OWIwNWQxYTAgTWljaGFlbCBSb3RoOg0KICBtYWtl
LXJlbGVhc2U6IGRvbid0IHJlbHkgb24gJENXRCB3aGVuIGV4Y2x1ZGluZyBzdWJwcm9qZWN0
IGRpcmVjdG9yaWVzDQo2MTY4MTRjZDAwIDRkYWZiYTc3OGEgVm9sa2VyIFLDvG1lbGluOg0K
ICB1aS9zZGwyOiByZWVuYWJsZSB0aGUgU0RMMiBXaW5kb3dzIGtleWJvYXJkIGhvb2sgcHJv
Y2VkdXJlDQpkNDdmNDE4ZWExIDdiM2Q1Yjg0Y2IgWmhlbnpob25nIER1YW46DQogIHZmaW8v
aW9tbXVmZDogRml4IFNJR1NFViBpbiBpb21tdWZkX2NkZXZfYXR0YWNoKCkNCmZlMjFkOTMy
ZjIgNjZhMWI0OTkxYyBUaG9tYXMgSHV0aDoNCiAgZ2l0bGFiLWNpLmQvY2lycnVzOiBVcGRh
dGUgdGhlIEZyZWVCU0Qgam9iIHRvIHYxNC4yDQoxOGIwZDcyZmRkIDFlM2Q0ZDlhMWEgTGF1
cmVudCBWaXZpZXI6DQogIHFtcDogdXBkYXRlIHZob3N0LXVzZXIgcHJvdG9jb2wgZmVhdHVy
ZSBtYXBzDQozNGZlYmIyODMxIDI3YThkODk5YzcgS2hlbSBSYWo6DQogIGxpbnV4LXVzZXI6
IERvIG5vdCBkZWZpbmUgc3RydWN0IHNjaGVkX2F0dHIgaWYgbGliYyBoZWFkZXJzIGRvDQoz
N2ZmMDdlYTEyIDEwN2M1NTFkZTAgUGV0ZXIgS3JlbXBhOg0KICBibG9jay1iYWNrZW5kOiBG
aXggYXJndW1lbnQgb3JkZXIgd2hlbiBjYWxsaW5nICdxYXBpX2V2ZW50X3NlbmRfYmxvY2tf
aW9fZXJyb3IoKScNCmQ3YjhiMDcxOTcgMjNlYTQyNWMxNCBGYWJpYW5vIFJvc2FzOg0KICBi
bG9jazogRml4IGxlYWsgaW4gc2VuZF9xbXBfZXJyb3JfZXZlbnQNCjIzNzgzMWY5YWQgMTMx
YzU4NDY5ZiBQYW9sbyBCb256aW5pOg0KICBydXN0OiBhZGQgLS1ydXN0LXRhcmdldCBvcHRp
b24gZm9yIGJpbmRnZW4NCg==

--------------IlIVclQfNi2jCjV0jjwQRW4u--

--------------kMDeJbQkaobm0DNsUVaEf4jL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZKoqtTHVaQM2a/75gqpKJDselHgFAme84AoACgkQgqpKJDse
lHh/bA//XNrhohelfXnPCfKFn3nFK9B30v9oeTn/Crji8I9WuUZjs4BmLaxcrK62
zAzYsMv6r8zDVYMiWceJSefvmvy26b/mKldTeRIoGI207HGCokGxuB5HrIfkpOS/
X8qc0R1grgeZPZTqPAlWQh3+m2JX74HadM8zjBSlCV8tqUmdRwB2RooFz+eXledu
DILlyJXc42gw6zEt8uemgbbBBF18OLX4nKYp0qXDk3pjQWCQ7W+YCyTaU5EIq7J5
yjH4lclsnnpqehv2EO0X4ZORjv07S4kwU4xvh8o+4tQ14cM0Fkgv6/qPzqnuEGqR
pQoEyuFHuApTtQrafG3w9jCRF1lewI/LhnrTbVrPPnbaFaa62sASdJxXRxld5cgN
vw/DZLTDjBAe7Zw9Lku36nixdbptoZjineiTp0lpRc4/V5QXNDQhQVBaW90Sr+ZG
nucvZKbydwZfEXN/eFMrRF/NjF955M4mTWqVajp39wS51/5HS6VeRocOYwGVj42A
QyvBAyhfWMHLEHvyNLNxEKYTQAA+EvRQFTHPfQIoPLGkERwF3+iKG8PYo3stVhIy
Oap8oCEVl1hnahHwKeIYQUMnV8O55CL91t4nHVMjwI77/qnebfBO7cBONwjkLovM
2rQQHrUzvQ/9kCZkEdgduL2Gie9nJ6chr8AjNqLD7x5PQUZqp1E=
=HMxe
-----END PGP SIGNATURE-----

--------------kMDeJbQkaobm0DNsUVaEf4jL--

