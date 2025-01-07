Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E8AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCTK-0002sI-Ih; Tue, 07 Jan 2025 11:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tVCTH-0002mp-T0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:30:24 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tVCTE-0003Rf-VL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:30:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62617D29AF;
 Tue,  7 Jan 2025 19:29:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C80BF19641A;
 Tue,  7 Jan 2025 19:30:08 +0300 (MSK)
Content-Type: multipart/mixed; boundary="------------iIQV94jrbnATO1hU8R08znQH"
Message-ID: <9b64bbe0-473d-4f6b-a673-356e74517fb4@tls.msk.ru>
Date: Tue, 7 Jan 2025 19:30:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Language: en-US, ru-RU
Cc: qemu-devel <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: A few patches for u-boot-sam460ex
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
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

This is a multi-part message in MIME format.
--------------iIQV94jrbnATO1hU8R08znQH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

For some time, qemu package in debian carries several patches for roms/u-boot-sam460ex,
fixing a number of issues.  It'd be nice to have them in the official repository.

Thanks,

/mjt
--------------iIQV94jrbnATO1hU8R08znQH
Content-Type: text/x-patch; charset=UTF-8;
 name="u-boot-sam460ex-mstring.patch"
Content-Disposition: attachment; filename="u-boot-sam460ex-mstring.patch"
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KU3ViamVjdDogdS1ib290
LXNhbTQ2MGV4OiByZW1vdmUgb2Jzb2xldGUgLW1zdHJpbmcgZ2NjIG9wdGlvbgpEYXRlOiBT
dW4gT2N0IDIyIDIzOjM1OjQ1IDIwMjMgKzAzMDAKCk1vZGVybiBnY2MgY29tcGxhaW5zIGFi
b3V0IGl0LgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5y
dT4KCmRpZmYgLS1naXQgYS9yb21zL3UtYm9vdC1zYW00NjBleC9hcmNoL3Bvd2VycGMvY3B1
L3BwYzR4eC9jb25maWcubWsgYi9yb21zL3UtYm9vdC1zYW00NjBleC9hcmNoL3Bvd2VycGMv
Y3B1L3BwYzR4eC9jb25maWcubWsKaW5kZXggOGY0N2M5YjcyOC4uY2Y0NDE0Y2VlNiAxMDA2
NDQKLS0tIGEvcm9tcy91LWJvb3Qtc2FtNDYwZXgvYXJjaC9wb3dlcnBjL2NwdS9wcGM0eHgv
Y29uZmlnLm1rCisrKyBiL3JvbXMvdS1ib290LXNhbTQ2MGV4L2FyY2gvcG93ZXJwYy9jcHUv
cHBjNHh4L2NvbmZpZy5tawpAQCAtMjQsMyArMjQsMyBAQAogUExBVEZPUk1fUkVMRkxBR1Mg
Kz0gLWZQSUMgLW1lYWJpCi1QTEFURk9STV9DUFBGTEFHUyArPSAtRENPTkZJR180eHggLWZm
aXhlZC1yMiAtbXN0cmluZyAtbXNvZnQtZmxvYXQKK1BMQVRGT1JNX0NQUEZMQUdTICs9IC1E
Q09ORklHXzR4eCAtZmZpeGVkLXIyIC1tc29mdC1mbG9hdAogCg==
--------------iIQV94jrbnATO1hU8R08znQH
Content-Type: text/x-patch; charset=UTF-8; name="u-boot-sam460ex-fdi.patch"
Content-Disposition: attachment; filename="u-boot-sam460ex-fdi.patch"
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KU3ViamVjdDogdS1ib290
LXNhbTQ2MGV4OiBmZGkgZml4CkRhdGU6IFNhdCBBcHIgMSAxNzozNDowOSAyMDIzICswMzAw
CgpGaXggdGhlIG1pc3NpbmcgZXh0ZXJuIGluIGEgdmFyaWFibGUgZGVjbGFyYXRpb24sCnJl
c3VsdGluZyBpbiB0aGlzIHZhcmlhYmxlIGJlaW5nIHJlcGVhdGVkIGVhY2ggdGltZQp0aGlz
IGhlYWRlciBpcyBpbmNsdWRlZCwgc28gdGhlIGxpbmsgd2l0aCBtb2Rlcm4gZ2NjCmZhaWxz
LgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KCmRp
ZmYgLS1naXQgYS9yb21zL3UtYm9vdC1zYW00NjBleC9ib2FyZC9BQ3ViZS9jb21tb24vdmVz
YS5oIGIvcm9tcy91LWJvb3Qtc2FtNDYwZXgvYm9hcmQvQUN1YmUvY29tbW9uL3Zlc2EuaApp
bmRleCBhNmMzMmMzYzJjLi45OTY3MmFhNjdiIDEwMDY0NAotLS0gYS9yb21zL3UtYm9vdC1z
YW00NjBleC9ib2FyZC9BQ3ViZS9jb21tb24vdmVzYS5oCisrKyBiL3JvbXMvdS1ib290LXNh
bTQ2MGV4L2JvYXJkL0FDdWJlL2NvbW1vbi92ZXNhLmgKQEAgLTQsNyArNCw3IEBACiBleHRl
cm4gdm9pZCAqRG9WZXNhKGludCBhcmdjLCBjaGFyICphcmd2W10pOwogZXh0ZXJuIHZvaWQg
KnNldF92ZXNhX21vZGUoaW50IG1vZGUpOwogCi1zdHJ1Y3QgRnJhbWVCdWZmZXJJbmZvCitl
eHRlcm4gc3RydWN0IEZyYW1lQnVmZmVySW5mbwogewogICAgICAgICB2b2lkICpCYXNlQWRk
cmVzczsKICAgICAgICAgdW5zaWduZWQgbG9uZyBYU2l6ZTsK
--------------iIQV94jrbnATO1hU8R08znQH
Content-Type: text/x-patch; charset=UTF-8; name="u-boot-sam460ex-build.patch"
Content-Disposition: attachment; filename="u-boot-sam460ex-build.patch"
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KRGF0ZTogU2F0LCAwMyBB
dWcgMjAyNCAxMToxODo1OCArMDMwMApTdWJqZWN0OiB1LWJvb3Qtc2FtNDYwZXg6IGJ1aWxk
IGZpeGVzCgpGaXhlcyBvciB3b3JrcyBhcm91bmQgbnVtZXJvdXMgYnVpbGQgaXNzdWVzIGFu
ZCBvbmUgcmVhbCBidWcuCgpNb3N0IGFyZSBkdWUgdG8gbmV3IGRlZmF1bHRzIGluIGdjYyAo
aW4gZGViaWFuKSwgbGlrZQogLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bnMgKHRoZXJlIGFyZSBhIGxvdCBvZiBtaXNzaW5nIGRlY2xzKQogLVdlcnJvcj1pbmNvbXBh
dGlibGUtcG9pbnRlci10eXBlcyAoZnVuY3Rpb24gdHlwZXMgbWlzbWF0Y2hlcykKIC1XZXJy
b3I9aW50LWNvbnZlcnNpb24gKGZyZWUgaW50IDw9PiBwb2ludGVyIGNvbnZlcnNpb24pCgpC
dWctRGViaWFuOiBodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMDc1NDI4ClNpZ25lZC1vZmYt
Ynk6IE1pY2hhZWwgVG9rYXJldiA8bWp0QHRscy5tc2sucnU+CgpkaWZmIC0tZ2l0IGEvcm9t
cy91LWJvb3Qtc2FtNDYwZXgvYm9hcmQvQUN1YmUvU2FtNDYwZXgvU2FtNDYwZXguYyBiL3Jv
bXMvdS1ib290LXNhbTQ2MGV4L2JvYXJkL0FDdWJlL1NhbTQ2MGV4L1NhbTQ2MGV4LmMKaW5k
ZXggNGQ1Yjk1M2MwMi4uNWVjZjE2ZGJlMiAxMDA2NDQKLS0tIGEvcm9tcy91LWJvb3Qtc2Ft
NDYwZXgvYm9hcmQvQUN1YmUvU2FtNDYwZXgvU2FtNDYwZXguYworKysgYi9yb21zL3UtYm9v
dC1zYW00NjBleC9ib2FyZC9BQ3ViZS9TYW00NjBleC9TYW00NjBleC5jCkBAIC04NDMsNyAr
ODQzLDcgQEAgaW50IGxhc3Rfc3RhZ2VfaW5pdCAodm9pZCkKIAkvLyBjbGVhbnVwIGxhc3Qg
OCBieXRlcyBvZiB0aGUgUlRDIHJlZ2lzdGVycyBiYW5rIC0tLS0tCiAJCiAJY2hhciBhcnJb
OF0gPSB7IDAgfTsKLQlpMmNfd3JpdGUoMHg2OCwgMHgwOCwgMSwgJmFyciwgOCk7CisJaTJj
X3dyaXRlKDB4NjgsIDB4MDgsIDEsIGFyciwgOCk7CiAJCiAJLy8gVVNCIEluaXQgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCmRpZmYgLS1naXQgYS9y
b21zL3UtYm9vdC1zYW00NjBleC9jb21tb24vdXNiLmMgYi9yb21zL3UtYm9vdC1zYW00NjBl
eC9jb21tb24vdXNiLmMKaW5kZXggMjAzYzlmNzc5NS4uZDY0NWQzNmM4ZSAxMDA2NDQKLS0t
IGEvcm9tcy91LWJvb3Qtc2FtNDYwZXgvY29tbW9uL3VzYi5jCisrKyBiL3JvbXMvdS1ib290
LXNhbTQ2MGV4L2NvbW1vbi91c2IuYwpAQCAtOTU3LDcgKzk1Nyw3IEBAIHZvaWQgdXNiX3Nj
YW5fZGV2aWNlcyh2b2lkKQogCQlwcmludGYoIiVkIFVTQiBEZXZpY2UocykgZm91bmRcbiIs
IGRldl9pbmRleCk7CiAJCQogI2lmZGVmIENPTkZJR19TQU00NjBFWAotCXN0YXRpYyBhdHRl
bXB0cyA9IDA7CisJc3RhdGljIGludCBhdHRlbXB0cyA9IDA7CiAJCiAgICAgaWYgKGRldl9p
bmRleCA8IDMpIHsgIAogICAgICAgICB1MTYgZnBnYV92YWwgPSBpbl9iZTE2KCh2b2lkICop
Q09ORklHX1NZU19GUEdBX0JBU0UgKyAweDJFKTsKZGlmZiAtLWdpdCBhL3JvbXMvdS1ib290
LXNhbTQ2MGV4L2NvbmZpZy5tayBiL3JvbXMvdS1ib290LXNhbTQ2MGV4L2NvbmZpZy5tawpp
bmRleCBiY2RhNzc2MTFhLi45OTI4ZjVmNGM2IDEwMDY0NAotLS0gYS9yb21zL3UtYm9vdC1z
YW00NjBleC9jb25maWcubWsKKysrIGIvcm9tcy91LWJvb3Qtc2FtNDYwZXgvY29uZmlnLm1r
CkBAIC0xOTEsNiArMTkxLDExIEBAIGVuZGlmCiAKIENGTEFHUyArPSAkKGNhbGwgY2Mtb3B0
aW9uLC1mbm8tc3RhY2stcHJvdGVjdG9yKQogCisjIHRoaXMgdS1ib290IGlzIGFuIG9sZCBi
YWQgY29kZQorQ0ZMQUdTICs9ICQoY2FsbCBjYy1vcHRpb24sLVduby1lcnJvcj1pbXBsaWNp
dC1mdW5jdGlvbi1kZWNsYXJhdGlvbikKK0NGTEFHUyArPSAkKGNhbGwgY2Mtb3B0aW9uLC1X
bm8tZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXMpCitDRkxBR1MgKz0gJChjYWxs
IGNjLW9wdGlvbiwtV25vLWVycm9yPWludC1jb252ZXJzaW9uKQorCiAjICQoQ1BQRkxBR1Mp
IHNldHMgLWcsIHdoaWNoIGNhdXNlcyBnY2MgdG8gcGFzcyBhIHN1aXRhYmxlIC1nPGZvcm1h
dD4KICMgb3B0aW9uIHRvIHRoZSBhc3NlbWJsZXIuCiBBRkxBR1NfREVCVUcgOj0K

--------------iIQV94jrbnATO1hU8R08znQH--

