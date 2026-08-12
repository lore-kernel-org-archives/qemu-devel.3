Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033A9C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAo2-0007un-Cn; Wed, 12 Aug 2026 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAo0-0007uE-KO; Wed, 12 Aug 2026 11:23:48 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAny-0000w5-JK; Wed, 12 Aug 2026 11:23:48 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id C64C0EC0259;
 Wed, 12 Aug 2026 11:23:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786548225; x=1786634625; bh=JIWzJz4058WbK+18iXWMe1I8kBX0SdRP
 SnPbfJGH8tM=; b=biG/ZcH/Y0WVxorvpyxh17nBxlFWZ1AcVo3/n+Auit1THzqF
 60QxZd16cwOEXxof6S6YBa98EPE6zH4HprjMwwq4OCMJ1GmSYmVZd2WueEEPcu4p
 zFUwhFXqzAgU1/3lNtIl01RUhe3Ywc5dgkLxg6IQ+4HnU8aLUROP/wU7slp5FxGj
 GboAB0Ra4UDIuHYGwuGmPYRScvGAoKrsWqRwzpZGbwCpR8la193va1RhNz5tYhpU
 2gtPJiVK4LMenwxmQ5bs5m58hSfo6ZQJY6xfTR1OqrLSDQIZyvuKtSpJavQobySQ
 4uymr0msubXaatoGmPMopE7bmmu8DVBirMqMJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786548225; x=
 1786634625; bh=JIWzJz4058WbK+18iXWMe1I8kBX0SdRPSnPbfJGH8tM=; b=D
 HHKC1dG8kKinHvB7TVEohEQDJxWyF+DLSf3Zpq4XAsKjcyH6nKq/Ebxna16RHtaZ
 +mSbWpA5MF9sP6kGj5nUXRTBTCUZ5g6Ib+n7rZ8hTC5hU5TRwnjV11fYelgc52jX
 iMHohasOgESdu3/4oIeTVVrUqMPMLeV8on9EwKoFR4zVOClOMpYBUAD1qcvfPao3
 gGIlRtUeTBrG7888JeDPrX0XMHOtRCWBb9dk7LUZDzjdQjVSC9yDbTM2EjwA9V7Z
 AQxYXDzfuFixN608qe8BG8N0d6zw3j1MYy1EsOD5TlrxGPoo2ZCd+IOHwLw7MM+C
 wBKolLxPph4m6jZjtMjgQ==
X-ME-Sender: <xms:AZB8av7TNLDoeJVh2hsYUC61CY_PhqR0WpJ76OtC1BK0SgXEvMTjCQ>
 <xme:AZB8ajL9lJHqp7_d1_q4LaNzMnpsZ-UiUeTwll8_JswtbgYgKE9jGSW61h-jrUsHM
 pvrml4kulcncRgCQZdOrfeS2By_h4PVPt0KB2Tla0sX5Zfv8IximBVJ>
X-ME-Received: <xmr:AZB8avz9UJVd4DnzjPr-PWYKPH148a9_vUMy_VevI8yF3hSjUshKNY6_cVmbmgLkOTnTuw>
X-ME-Proxy-Cause: dmFkZTGHT5WWGKHA/EciKtRCxkDf4RdfQJzcOI+gHZk5fuwy0VaUrpZWO10Of88uANv0Bs
 uPd84AfSrOu84aArQwBLDI5r5wXHvUhfeETrMB6JlSkIjQk/wgUQ4P2agY8zps6e470QI/
 BzkI9YkDRs91BhBYXLtX/m9hsYRp+hfVTXDMKO5IciSNUwF/VMtDgIdjMZtGC/OGb0bV/j
 hG484qRgrb+AbhwtHTH5cDbHtF0+dCYYJEg3Aq2HDaLyvuJ5UkKw+5WG4sv42fLcImLLkS
 5hIorTHWtWHw0kV8zNLCbeRT52Wveiil+L41lhTAl7zMLIAgse7YyVVOZtqqZHUFGclvWA
 +AepideJuh0mFMf4Gjg9+s63setZsIAnScG5ndVRTMrFHvGUR9Rel8UhfbVVOIxmGOb4Jn
 AhiRDAZaxH52o2YXrD7diIdqLMNsIyh8C4eXjlpqJYRogsMV2yUGEBpLhcJqmHjEHnaDZ3
 +z9BFsCUXfO3xgMzBT+7Xmbf2YsuoNbChyNVv+YspRN8ZcF6zlXS6bMCpyYLZrDA7LENk7
 JRcSx55NdXWrREsJhZFE9LodtE7Pf7TmJxlh2GjK8GDLjVQaLfI2NLn5Cuj9oW3ittG5io
 1LMR8jdktx3wDW6lq8z+HUtMMvJ8N1ueyyg939wiUGTezWKA12dNUMutiXrw
X-ME-Proxy: <xmx:AZB8ajJf4fpMOrN-v8RXdJUA-k78Cu3SYd71kHOAqX3HApZHPzFK_A>
 <xmx:AZB8amWPXzt62k_dOp1BBXTmqtvFUlH1f756i9RGGikwfKsohft0EA>
 <xmx:AZB8auY20qZL1l1RfHOBRcyXtXEL3vLF32HlglFY1PBTAsGfZGZQjA>
 <xmx:AZB8alw9Lb2oyf6otvXTx1VHVQ65qAaTw5TeY8hgiz0Q8Fwwva8_aQ>
 <xmx:AZB8anyjOqrTC2eJT5tVcKdoX6I-nrYTi3Vo-Jh0JDxI1Xd67s3lD02e>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:23:43 -0400 (EDT)
Message-ID: <9a5a18af2083b90e2f1b58c72f538e647eaf30ed.camel@alistair23.me>
Subject: Re: [PATCH 02/26] hw/riscv: pfsoc: Map the L2 zero device window
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, Chao Liu	
 <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>, Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt	 <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,  Weiwei Li
 <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Date: Thu, 13 Aug 2026 01:23:43 +1000
In-Reply-To: <20260723151853.2143177-3-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-3-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA3LTIzIGF0IDIzOjE4ICswODAwLCBCaW4gTWVuZyB3cm90ZToKPiBIU1Mg
dXNlcyBhIHdpbmRvdyBhdCAweDBhMDAwMDAwIHdoaWxlIHNldHRpbmcgdXAgdGhlIEwyIGNhY2hl
LAo+IGRlY29tcHJlc3NpbmcgaXRzIHJ1bnRpbWUgaW1hZ2UsIGFuZCBleGVjdXRpbmcgdGhhdCBp
bWFnZS4KPiBUaGUgbWlzc2luZyBtYXBwaW5nIGNhdXNlcyB0aGUgRTUxIHRvIHRyYXAgYmVmb3Jl
IGZpcm13YXJlIGNhbgo+IGluaXRpYWxpemUgaXRzIFVBUlQuCj4gCj4gUmVwcmVzZW50IHRoZSB3
aW5kb3cgd2l0aCBSQU0gdG8gcHJvdmlkZSBpdHMgcGVyc2lzdGVudCByZWFkLAo+IHdyaXRlLCBh
bmQgZXhlY3V0ZSBlZmZlY3RzIHdpdGhvdXQgY2xhaW1pbmcgdG8gbW9kZWwgdGhlIEwyCj4gY2Fj
aGUgaXRzZWxmLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJpbiBNZW5nIDxiaW4ubWVuZ0Bwcm9jZXNz
bWlzc2lvbi5jb20+CgpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L21pY3Jv
Y2hpcF9wZnNvYy5oIHzCoCAxICsKPiDCoGh3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5jwqDCoMKg
wqDCoMKgwqDCoCB8IDEzICsrKysrKysrKysrKysKPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L21pY3JvY2hpcF9w
ZnNvYy5oCj4gYi9pbmNsdWRlL2h3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5oCj4gaW5kZXggYTMw
Yjk0NGFmYS4uNjEyZmQyYjY5YyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L21pY3Jv
Y2hpcF9wZnNvYy5oCj4gKysrIGIvaW5jbHVkZS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuaAo+
IEBAIC05MCw2ICs5MCw3IEBAIGVudW0gewo+IMKgwqDCoMKgIE1JQ1JPQ0hJUF9QRlNPQ19MMkND
LAo+IMKgwqDCoMKgIE1JQ1JPQ0hJUF9QRlNPQ19ETUEsCj4gwqDCoMKgwqAgTUlDUk9DSElQX1BG
U09DX0wyTElNLAo+ICvCoMKgwqAgTUlDUk9DSElQX1BGU09DX0wyWkVSTywKPiDCoMKgwqDCoCBN
SUNST0NISVBfUEZTT0NfUExJQywKPiDCoMKgwqDCoCBNSUNST0NISVBfUEZTT0NfTU1VQVJUMCwK
PiDCoMKgwqDCoCBNSUNST0NISVBfUEZTT0NfV0RPRzAsCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2
L21pY3JvY2hpcF9wZnNvYy5jIGIvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMKPiBpbmRleCAy
MThjY2NhYjY5Li5mZDI4ZWU3NWZlIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L21pY3JvY2hpcF9w
ZnNvYy5jCj4gKysrIGIvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMKPiBAQCAtOTcsNiArOTcs
NyBAQCBzdGF0aWMgY29uc3QgTWVtTWFwRW50cnkgbWljcm9jaGlwX3Bmc29jX21lbW1hcFtdID0K
PiB7Cj4gwqDCoMKgwqAgW01JQ1JPQ0hJUF9QRlNPQ19MMkNDXSA9wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB7wqAgMHgyMDEwMDAwLMKgwqDCoMKgwqDCoCAweDEwMDAKPiB9LAo+IMKgwqDCoMKgIFtN
SUNST0NISVBfUEZTT0NfRE1BXSA9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHvCoCAweDMwMDAw
MDAswqDCoMKgwqAgMHgxMDAwMDAKPiB9LAo+IMKgwqDCoMKgIFtNSUNST0NISVBfUEZTT0NfTDJM
SU1dID3CoMKgwqDCoMKgwqDCoMKgwqDCoCB7wqAgMHg4MDAwMDAwLMKgwqDCoMKgIDB4MjAwMDAw
Cj4gfSwKPiArwqDCoMKgIFtNSUNST0NISVBfUEZTT0NfTDJaRVJPXSA9wqDCoMKgwqDCoMKgwqDC
oMKgIHvCoCAweGEwMDAwMDAswqDCoMKgwqAgMHgyMDAwMDAKPiB9LAo+IMKgwqDCoMKgIFtNSUNS
T0NISVBfUEZTT0NfUExJQ10gPcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAge8KgIDB4YzAwMDAwMCzC
oMKgwqAgMHg0MDAwMDAwCj4gfSwKPiDCoMKgwqDCoCBbTUlDUk9DSElQX1BGU09DX01NVUFSVDBd
ID3CoMKgwqDCoMKgwqDCoMKgIHsgMHgyMDAwMDAwMCzCoMKgwqDCoMKgwqAgMHgxMDAwCj4gfSwK
PiDCoMKgwqDCoCBbTUlDUk9DSElQX1BGU09DX1dET0cwXSA9wqDCoMKgwqDCoMKgwqDCoMKgwqAg
eyAweDIwMDAxMDAwLMKgwqDCoMKgwqDCoCAweDEwMDAKPiB9LAo+IEBAIC0yMDEsNiArMjAyLDcg
QEAgc3RhdGljIHZvaWQKPiBtaWNyb2NoaXBfcGZzb2Nfc29jX3JlYWxpemUoRGV2aWNlU3RhdGUg
KmRldiwgRXJyb3IgKiplcnJwKQo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiAqcnN2ZDBfbWVtID0g
Z19uZXcoTWVtb3J5UmVnaW9uLCAxKTsKPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gKmU1MV9kdGlt
X21lbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7Cj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICps
MmxpbV9tZW0gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+ICvCoMKgwqAgTWVtb3J5UmVnaW9u
ICpsMnplcm9fbWVtID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsKPiDCoMKgwqDCoCBNZW1vcnlS
ZWdpb24gKmVudm1fZGF0YSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7Cj4gwqDCoMKgwqAgTWVt
b3J5UmVnaW9uICpxc3BpX3hpcF9tZW0gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+IMKgwqDC
oMKgIGNoYXIgKnBsaWNfaGFydF9jb25maWc7Cj4gQEAgLTI3Nyw2ICsyNzksMTcgQEAgc3RhdGlj
IHZvaWQKPiBtaWNyb2NoaXBfcGZzb2Nfc29jX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3IgKiplcnJwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19MMkxJTV0uYmFzZSwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGwybGltX21lbSk7Cj4gwqAKPiArwqDCoMKgIC8qCj4gK8KgwqDCoMKgICogSFNT
IGRlY29tcHJlc3NlcyBpbnRvIHRoZSBMMiB6ZXJvLWRldmljZSB3aW5kb3cgYW5kIGV4ZWN1dGVz
Cj4gdGhlcmUuCj4gK8KgwqDCoMKgICogTW9kZWwgaXQgYXMgUkFNIGJlY2F1c2UgUUVNVSBkb2Vz
IG5vdCBtb2RlbCB0aGUgYmFja2luZyBMMgo+IGNhY2hlLgo+ICvCoMKgwqDCoCAqLwo+ICvCoMKg
wqAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbShsMnplcm9fbWVtLCBOVUxMLAo+ICJtaWNyb2NoaXAu
cGZzb2MubDJ6ZXJvIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBtZW1tYXBbTUlDUk9DSElQX1BGU09DX0wyWkVST10uc2l6ZSwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZXJyb3Jf
ZmF0YWwpOwo+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHN5c3RlbV9tZW1v
cnksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG1lbW1hcFtNSUNST0NISVBfUEZTT0NfTDJaRVJPXS5iYXNlLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBsMnplcm9fbWVtKTsKPiArCj4gwqDCoMKgwqAgLyogY3JlYXRlIFBMSUMgaGFydCB0b3BvbG9n
eSBjb25maWd1cmF0aW9uIHN0cmluZyAqLwo+IMKgwqDCoMKgIHBsaWNfaGFydF9jb25maWcgPSBy
aXNjdl9wbGljX2hhcnRfY29uZmlnX3N0cmluZyhtcy0+c21wLmNwdXMpOwo+IMKgCg==


