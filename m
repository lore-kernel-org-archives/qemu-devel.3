Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887FC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6m78-0004uC-0R; Tue, 14 May 2024 02:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s6m71-0004u0-LX
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:58:11 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s6m6x-0001if-El
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:58:11 -0400
Received: from mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:7329:0:640:a02c:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 511B560C15;
 Tue, 14 May 2024 09:57:59 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c10:3386:0:640:f7b4:0
 [2a02:6b8:c10:3386:0:640:f7b4:0])
 by mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id NvYpaH2jRiE0-OgrOaNd5; Tue, 14 May 2024 09:57:59 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1715669879;
 bh=qG6GF+PUGmPqr/hBRrEsIKPBzhe533+5A6TIVo2/JAc=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=oNw2vincj/iUajydzgPWq3IJ3jYr8NU96BwTPYw7uGbsmX4WGW4nN2WPrFcqeRMmV
 iXxZrbxF090AmbB/q5YzLHk5LBPqtbOOUZG2pq/8/vx9cXY+P0VgVB+N3UaQH2mbgN
 XMrdAPwHi9UXHUR8b+39h3QjGhyFZhIe4K+2pIjQ=
Authentication-Results: mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from mail-sendbernar-corp-main-90.vla.yp-c.yandex.net
 (mail-sendbernar-corp-main-90.vla.yp-c.yandex.net
 [2a02:6b8:c15:2e85:0:640:fe53:0])
 by mail-nwsmtp-mxback-corp-main-88.vla.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id hrYIkX6iOW20-vHZ15QEo
 for <d-tatianin@yandex-team.ru>; Tue, 14 May 2024 09:57:49 +0300
Received: by mail-sendbernar-corp-main-90.vla.yp-c.yandex.net with HTTP;
 Tue, 14 May 2024 09:57:48 +0300
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <20240506083420.557726-1-d-tatianin@yandex-team.ru>
References: <20240506083420.557726-1-d-tatianin@yandex-team.ru>
Subject: Re: [PATCH v3] mc146818rtc: add a way to generate RTC interrupts via
 QMP
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 14 May 2024 09:57:59 +0300
Message-Id: <123481715669864@mail.yandex-team.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PGRpdj5waW5nIDopPC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+MDYuMDUuMjAyNCwgMTE6MzQsICJE
YW5paWwgVGF0aWFuaW4iICZsdDtkLXRhdGlhbmluQHlhbmRleC10ZWFtLnJ1Jmd0Ozo8L2Rpdj48
YmxvY2txdW90ZT48cD5UaGlzIGNhbiBiZSB1c2VkIHRvIGZvcmNlLXN5bmNocm9uaXplIHRoZSB0
aW1lIGluIGd1ZXN0IGFmdGVyIGEgbG9uZzxiciAvPnN0b3AtY29udCBwYXVzZSwgd2hpY2ggY2Fu
IGJlIHVzZWZ1bCBmb3Igc2VydmVybGVzcy10eXBlIHdvcmtsb2FkLjxiciAvPjxiciAvPkFsc28g
YWRkIGEgY29tbWVudCB0byBoaWdobGlnaHQgdGhlIGZhY3QgdGhhdCB0aGlzIChhbmQgb25lIG90
aGVyIFFNUDxiciAvPmNvbW1hbmQpIG9ubHkgd29ya3MgZm9yIHRoZSBNQzE0NjgxOCBSVEMgY29u
dHJvbGxlci48YnIgLz48YnIgLz5TaWduZWQtb2ZmLWJ5OiBEYW5paWwgVGF0aWFuaW4gJmx0Ozxh
IGhyZWY9Im1haWx0bzpkLXRhdGlhbmluQHlhbmRleC10ZWFtLnJ1IiByZWw9Im5vb3BlbmVyIG5v
cmVmZXJyZXIiPmQtdGF0aWFuaW5AeWFuZGV4LXRlYW0ucnU8L2E+Jmd0OzxiciAvPi0tLTxiciAv
PjxiciAvPkNoYW5nZXMgc2luY2UgdjA6PGJyIC8+LSBSZW5hbWUgdG8gcnRjLWluamVjdC1pcnEg
dG8gbWF0Y2ggb3RoZXIgc2ltaWxhciBBUEk8YnIgLz4tIEFkZCBhIGNvbW1lbnQgdG8gaGlnaGxp
Z2h0IHRoYXQgdGhpcyBvbmx5IHdvcmtzIGZvciB0aGUgSTM4NiBSVEM8YnIgLz48YnIgLz5DaGFu
Z2VzIHNpbmNlIHYxOjxiciAvPi0gQWRkZWQgYSBkZXNjcmlwdGlvbiBiZWxvdyB0aGUgUU1QIGNv
bW1hbmQgdG8gZXhwbGFpbiBob3cgaXQgY2FuIGJlPGJyIC8+wqDCoHVzZWQgYW5kIHdoYXQgaXQg
ZG9lcy48YnIgLz48YnIgLz5DaGFuZ2VzIHNpbmNlIHYyOjxiciAvPi0gQWRkIGEgJ2Jyb2FkY2Fz
dCcgc3VmZml4LjxiciAvPi0gQ2hhbmdlIHRoZSBjb21tZW50cyB0byBleHBsYWluIHRoZSBmbGFn
cyB3ZSdyZSBzZXR0aW5nLjxiciAvPi0gQ2hhbmdlIHRoZSBjb21tYW5kIGRlc2NyaXB0aW9uIHRv
IGZpeCBzdHlsaW5nICZhbXA7IGV4cGxhaW4gdGhhdCBpdCdzIGEgYnJvYWRjYXN0IGNvbW1hbmQu
PGJyIC8+PGJyIC8+LS0tPGJyIC8+wqBody9ydGMvbWMxNDY4MThydGMuYyB8IDIwICsrKysrKysr
KysrKysrKysrKysrPGJyIC8+wqBpbmNsdWRlL2h3L3J0Yy9tYzE0NjgxOHJ0Yy5oIHwgMSArPGJy
IC8+wqBxYXBpL21pc2MtdGFyZ2V0Lmpzb24gfCAxOSArKysrKysrKysrKysrKysrKysrPGJyIC8+
wqAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyk8YnIgLz48YnIgLz5kaWZmIC0tZ2l0
IGEvaHcvcnRjL21jMTQ2ODE4cnRjLmMgYi9ody9ydGMvbWMxNDY4MThydGMuYzxiciAvPmluZGV4
IDMzNzlmOTI3NDguLjJiMzc1NGY1YzYgMTAwNjQ0PGJyIC8+LS0tIGEvaHcvcnRjL21jMTQ2ODE4
cnRjLmM8YnIgLz4rKysgYi9ody9ydGMvbWMxNDY4MThydGMuYzxiciAvPkBAIC0xMDcsNiArMTA3
LDExIEBAIHN0YXRpYyB2b2lkIHJ0Y19jb2FsZXNjZWRfdGltZXJfdXBkYXRlKE1DMTQ2ODE4UnRj
U3RhdGUgKnMpPGJyIC8+wqBzdGF0aWMgUUxJU1RfSEVBRCgsIE1DMTQ2ODE4UnRjU3RhdGUpIHJ0
Y19kZXZpY2VzID08YnIgLz7CoMKgwqDCoMKgUUxJU1RfSEVBRF9JTklUSUFMSVpFUihydGNfZGV2
aWNlcyk7PGJyIC8+wqA8YnIgLz4rLyo8YnIgLz4rICogTk9URTo8YnIgLz4rICogVGhlIHR3byBR
TVAgZnVuY3Rpb25zIGJlbG93IGFyZSBfb25seV8gaW1wbGVtZW50ZWQgZm9yIHRoZSBNQzE0Njgx
OC48YnIgLz4rICogQWxsIG90aGVyIFJUQyBkZXZpY2VzIGlnbm9yZSB0aGlzLjxiciAvPisgKi88
YnIgLz7CoHZvaWQgcW1wX3J0Y19yZXNldF9yZWluamVjdGlvbihFcnJvciAqKmVycnApPGJyIC8+
wqB7PCEtLSAtLT48YnIgLz7CoMKgwqDCoMKgTUMxNDY4MThSdGNTdGF0ZSAqczs8YnIgLz5AQCAt
MTE2LDYgKzEyMSwyMSBAQCB2b2lkIHFtcF9ydGNfcmVzZXRfcmVpbmplY3Rpb24oRXJyb3IgKipl
cnJwKTxiciAvPsKgwqDCoMKgwqB9PGJyIC8+wqB9PGJyIC8+wqA8YnIgLz4rdm9pZCBxbXBfcnRj
X2luamVjdF9pcnFfYnJvYWRjYXN0KEVycm9yICoqZXJycCk8YnIgLz4rezwhLS0gLS0+PGJyIC8+
KyBNQzE0NjgxOFJ0Y1N0YXRlICpzOzxiciAvPis8YnIgLz4rIFFMSVNUX0ZPUkVBQ0gocywgJmFt
cDtydGNfZGV2aWNlcywgbGluaykgezwhLS0gLS0+PGJyIC8+KyAvLyBVcGRhdGUtZW5kZWQgaW50
ZXJydXB0IGVuYWJsZTxiciAvPisgcy0mZ3Q7Y21vc19kYXRhW1JUQ19SRUdfQl0gfD0gUkVHX0Jf
VUlFOzxiciAvPis8YnIgLz4rIC8vIEludGVycnVwdCByZXF1ZXN0IGZsYWcgfCB1cGRhdGUgaW50
ZXJydXB0IGZsYWc8YnIgLz4rIHMtJmd0O2Ntb3NfZGF0YVtSVENfUkVHX0NdIHw9IFJFR19DX0lS
UUYgfCBSRUdfQ19VRjs8YnIgLz4rPGJyIC8+KyBxZW11X2lycV9yYWlzZShzLSZndDtpcnEpOzxi
ciAvPisgfTxiciAvPit9PGJyIC8+KzxiciAvPsKgc3RhdGljIGJvb2wgcnRjX3BvbGljeV9zbGV3
X2RlbGl2ZXJfaXJxKE1DMTQ2ODE4UnRjU3RhdGUgKnMpPGJyIC8+wqB7PCEtLSAtLT48YnIgLz7C
oMKgwqDCoMKga3ZtX3Jlc2V0X2lycV9kZWxpdmVyZWQoKTs8YnIgLz5kaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9ydGMvbWMxNDY4MThydGMuaCBiL2luY2x1ZGUvaHcvcnRjL21jMTQ2ODE4cnRjLmg8
YnIgLz5pbmRleCA5N2NlYzBiM2U4Li5lOWRkMGY5YzcyIDEwMDY0NDxiciAvPi0tLSBhL2luY2x1
ZGUvaHcvcnRjL21jMTQ2ODE4cnRjLmg8YnIgLz4rKysgYi9pbmNsdWRlL2h3L3J0Yy9tYzE0Njgx
OHJ0Yy5oPGJyIC8+QEAgLTU2LDUgKzU2LDYgQEAgTUMxNDY4MThSdGNTdGF0ZSAqbWMxNDY4MThf
cnRjX2luaXQoSVNBQnVzICpidXMsIGludCBiYXNlX3llYXIsPGJyIC8+wqB2b2lkIG1jMTQ2ODE4
cnRjX3NldF9jbW9zX2RhdGEoTUMxNDY4MThSdGNTdGF0ZSAqcywgaW50IGFkZHIsIGludCB2YWwp
OzxiciAvPsKgaW50IG1jMTQ2ODE4cnRjX2dldF9jbW9zX2RhdGEoTUMxNDY4MThSdGNTdGF0ZSAq
cywgaW50IGFkZHIpOzxiciAvPsKgdm9pZCBxbXBfcnRjX3Jlc2V0X3JlaW5qZWN0aW9uKEVycm9y
ICoqZXJycCk7PGJyIC8+K3ZvaWQgcW1wX3J0Y19pbmplY3RfaXJxX2Jyb2FkY2FzdChFcnJvciAq
KmVycnApOzxiciAvPsKgPGJyIC8+wqAjZW5kaWYgLyogSFdfUlRDX01DMTQ2ODE4UlRDX0ggKi88
YnIgLz5kaWZmIC0tZ2l0IGEvcWFwaS9taXNjLXRhcmdldC5qc29uIGIvcWFwaS9taXNjLXRhcmdl
dC5qc29uPGJyIC8+aW5kZXggNGUwYTY0OTJhOS4uN2QzODhhMzc1MyAxMDA2NDQ8YnIgLz4tLS0g
YS9xYXBpL21pc2MtdGFyZ2V0Lmpzb248YnIgLz4rKysgYi9xYXBpL21pc2MtdGFyZ2V0Lmpzb248
YnIgLz5AQCAtMTksNiArMTksMjUgQEA8YnIgLz7CoHsgJ2NvbW1hbmQnOiAncnRjLXJlc2V0LXJl
aW5qZWN0aW9uJyw8YnIgLz7CoMKgwqAnaWYnOiAnVEFSR0VUX0kzODYnIH08YnIgLz7CoDxiciAv
PisjIzxiciAvPisjIEBydGMtaW5qZWN0LWlycS1icm9hZGNhc3Q6PGJyIC8+KyM8YnIgLz4rIyBJ
bmplY3QgYW4gUlRDIGludGVycnVwdCBmb3IgYWxsIGV4aXN0aW5nIFJUQ3Mgb24gdGhlIHN5c3Rl
bS48YnIgLz4rIyBUaGUgaW50ZXJydXB0IGZvcmNlcyB0aGUgZ3Vlc3QgdG8gc3luY2hyb25pemUg
dGhlIHRpbWUgd2l0aCBSVEMuPGJyIC8+KyMgVGhpcyBpcyB1c2VmdWwgYWZ0ZXIgYSBsb25nIHN0
b3AtY29udCBwYXVzZSwgd2hpY2ggaXMgY29tbW9uIGZvcjxiciAvPisjIHNlcnZlcmxlc3MtdHlw
ZSB3b3JrbG9hZC48YnIgLz4rIzxiciAvPisjIFNpbmNlOiA5LjE8YnIgLz4rIzxiciAvPisjIEV4
YW1wbGU6PGJyIC8+KyM8YnIgLz4rIyAtJmd0OyB7ICJleGVjdXRlIjogInJ0Yy1pbmplY3QtaXJx
LWJyb2FkY2FzdCIgfTxiciAvPisjICZsdDstIHsgInJldHVybiI6IHt9IH08YnIgLz4rIzxiciAv
PisjIzxiciAvPit7ICdjb21tYW5kJzogJ3J0Yy1pbmplY3QtaXJxLWJyb2FkY2FzdCcsPGJyIC8+
KyAnaWYnOiAnVEFSR0VUX0kzODYnIH08YnIgLz4rPGJyIC8+wqAjIzxiciAvPsKgIyBAU2V2U3Rh
dGU6PGJyIC8+wqAjPC9wPi0tPGJyIC8+Mi4zNC4xPGJyIC8+wqA8L2Jsb2NrcXVvdGU+

