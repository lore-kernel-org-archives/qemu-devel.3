Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C97C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8X8-0007Wx-1R; Wed, 12 Aug 2026 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8X0-0007Rm-Cy; Wed, 12 Aug 2026 08:58:08 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Wx-0002mM-Tr; Wed, 12 Aug 2026 08:58:05 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1BB85140017E;
 Wed, 12 Aug 2026 08:58:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 08:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539483; x=1786625883; bh=cpT/G0LmyRml2DUPXgML+MlK2hMuwQnB
 kL4Oaj/pp1o=; b=zbEpcVaXw41CLTp+QEMmz1paNy/SnJNwopRWWfueWVVwZDzh
 kaMS2I6OYhlne/ofibJqZms4ltUIi308vpmCxqaf6hJPmoY4QZsvLknyq4geikaP
 8NsbnbXB84DRMqf6qdCk8rGbwxFtZy/FLYKN7T0rqcVQOkcU63wrQYkKpaMgYVu1
 sFRta1qa/Q0IM64mIfKjHmGs4kCoVfXax1UtnmesCrUbLry+RPUcmuFuKsaR5QMd
 HP/TuglNbGStRliCF249K8J37rtwKfmExsLHep9IU7YIDNw8C2qIpiCxU2FjyTtN
 K6aBvX0nGNetdZ6So4CnPKJayjiYmxjV0MfY8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539483; x=
 1786625883; bh=cpT/G0LmyRml2DUPXgML+MlK2hMuwQnBkL4Oaj/pp1o=; b=h
 D5uv3SoNk3EF273wZzmgnurQHIELt/nIkOwVQVHn271b94Cjn48DMs/C2mnVjalc
 1gO12sPQwKMiWimJk7FiNeZ0m4YKJK709cFrTWSyTmZW9z8L+d0jqFG4o2LLR7OS
 +xPx2T1xJS21ck/n+blk58BXxQtRpRJ1F+h/3wDuQne4NkndsQKO0yIXh+W21eq8
 wUut+hwWTtcGWuz+EG4yZ0z1uwtq7f5FeQaRjdbb0yqEWrSPYn6f0p8afR5RYpTW
 hv569b5v+hEBspd7xy49mer5Sy6zr/yGSkniaUdE7bbdspFIX8Pj6vNsbpldTxDe
 BDqfjFkhejpj/xyaOXZLA==
X-ME-Sender: <xms:2218aumJ7JyrHm9UC4akEjkZy6SdifKP1Y66ufjnuZACySgW96XZrA>
 <xme:2218avfA_mCh0JUxXnCJyrIaOBvpqP21gJKWcd0o8dpp1EB2iv45b7y0wcm7d6wmi
 U1uI0likt2HPo3TqJtMMuVdEm7uEyoa8ap8AYjw2is8O3iksX4TaClc>
X-ME-Received: <xmr:2218asoKXPXqlzmUE05msiFE0sZCKCecMN5xdz761HuevXFG80Dd1AaOijW7nm8jTCC5Tw>
X-ME-Proxy-Cause: dmFkZTEn/h1HsYL9SQSYKc/le2Y/f6khyiVUuJriweaacEMJ9c/rJRbtyk6NFqTjjZUezT
 oBfdqDt8pt/Xc926V7AocRhKTePGPv+BfDaI57Dsu13L7uq/6Q0/9vha0kMYynN8ycVSyu
 hebenHBebcjmdRtWf0Yz8/M0x5CpqshIEtHQHYQ9M5Fd/BHJQPIQMtNrqH5Iy372vsypVJ
 39xCmMQ5KlDhTUp9xGqfFdiN3z0IhAkww3K35/mYi4vKXTnWJwbFGX+GvCRcsihGmYuKTa
 ClbMjMurRGnH5YiXfgNtBGTCGhYuafMR0MgJMYjOKM+9qB4eaPDozS+14sCdgNSFYsfqpy
 4F8lo5XLDscFPlThn/BdQMz1TQy9BOVw8WHm6cYD/cVOfmuxkRzt/gv7BXoHk5D/1umDXn
 syKwPc1s1iWo+l85s3I6+7p+nJi5cIRBjaE8RM4IvpIG73IPw7jIKlcLO9TmaTdZ6JOBgb
 iOT7HvKRoaweikkP1SLCXF8zmT4uJx+fssHVEuWcbEUTUBU+Bp+WbnbBZg9Ewctucg9TGP
 pJrYH6XUtxqtU6W2H2Q0krGAdvHgJ2dcrwW6hhPkEXvAX0nQXwD+HuqlEFeRGY0OVhy2XM
 BKLjn24X+jKeAOay+53dNgNIcusNgYCax31hd4pRYB9jv/dSXihwH1OYWF6Q
X-ME-Proxy: <xmx:2218al4cmHzRJEZpnp1TcU6lX5EwamBB0a1BhvDXiIZJGfv3cF8npg>
 <xmx:2218aqoLs0mJxXht9Fk0LwJz-B6-n4L93t6sRrMWT2DHAUFDlH2ZtQ>
 <xmx:2218avgu0NS4zhSrsdDUOuCgihPSKGwmL8w1t5Aw1yrZHxK9KHaXjQ>
 <xmx:2218asJQCA50hLmLlKGAvay63U_JhYm94AOdOvF17yaL6yWWAla0lA>
 <xmx:2218am1smRLEVnCXrFNz_qBuPXJnahI_VFFlOokl5TR1bpswdNvLmuMl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:58:02 -0400 (EDT)
Message-ID: <a36bed97f5653d292558fa8d36990b2371383e04.camel@alistair23.me>
Subject: Re: [PATCH 52/56] disas/riscv: Merge all c.mop.n to one pattern
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:58:01 +1000
In-Reply-To: <20260809223545.730664-53-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM1IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBBdm9pZCBwZXJmb3JtaW5nIGFyaXRobWV0aWMgb24gcnZfb3BfY19tb3BfMS4KPiBUcmVh
dCB0aGUgJ24nIGFzIGFuIGltbWVkaWF0ZS4KPiBDcmVhdGUgYSBjb2RlYyBhbmQgZm9ybWF0IHRv
IG1hdGNoLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgZGlzYXMvcmlzY3YuaMKg
wqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqBkaXNhcy9yaXNjdi5jwqDCoMKgwqDCoMKgwqAgfCAx
MCArKysrKysrKystCj4gwqBkaXNhcy9yaXNjdi1vcC5jLmluYyB8wqAgOSArLS0tLS0tLS0KPiDC
oDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuaCBiL2Rpc2FzL3Jpc2N2LmgKPiBpbmRleCA0NzY0N2Y3
NTBmLi5iMDI2OWJiNzA5IDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmgKPiArKysgYi9kaXNh
cy9yaXNjdi5oCj4gQEAgLTE1OSw2ICsxNTksNyBAQCB0eXBlZGVmIGVudW0gewo+IMKgwqDCoMKg
IHJ2X2NvZGVjX3IyX2ltbTJfaW1tNSwKPiDCoMKgwqDCoCBydl9jb2RlY19mbGksCj4gwqDCoMKg
wqAgcnZfY29kZWNfbHAsCj4gK8KgwqDCoCBydl9jb2RlY19jbW9wLAo+IMKgwqDCoMKgIHJ2X2Nv
ZGVjX2Ntb3Bfc3MsCj4gwqDCoMKgwqAgcnZfY29kZWNfbW9wX3IsCj4gwqDCoMKgwqAgcnZfY29k
ZWNfbW9wX3JyLAo+IEBAIC0yODYsNiArMjg3LDcgQEAgdHlwZWRlZiBzdHJ1Y3Qgewo+IMKgI2Rl
ZmluZSBydl9mbXRfcmRfcnMxX2ltbWhfaW1tbF9hZGRywqAgIk9cdDAsKDEpLGksaiIKPiDCoCNk
ZWZpbmUgcnZfZm10X3JkMl9pbW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk9cdDAs
MiwoMSksaSIKPiDCoCNkZWZpbmUgcnZfZm10X2ZsacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJPXHQzLGgiCj4gKyNkZWZpbmUgcnZfZm10X2Ntb3DCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk8uaSIKPiDCoCNkZWZpbmUgcnZfZm10X21vcF9ywqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTy5pXHQwLDEiCj4gwqAjZGVmaW5lIHJ2
X2ZtdF9tb3BfcnLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTy5pXHQwLDEsMiIK
PiDCoAo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNjdi5jIGIvZGlzYXMvcmlzY3YuYwo+IGluZGV4
IDZlYzYyYTU4MzAuLjg5YzJlNjM5NDEgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+ICsr
KyBiL2Rpc2FzL3Jpc2N2LmMKPiBAQCAtNjQzLDYgKzY0MywxMSBAQCBzdGF0aWMgdWludDMyX3Qg
b3BlcmFuZF9scGwocnZfaW5zdCBpbnN0KQo+IMKgwqDCoMKgIHJldHVybiBleHRyYWN0MzIoaW5z
dCwgMTIsIDIwKTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgdWludDMyX3Qgb3BlcmFuZF9jbW9wX2lt
bShydl9pbnN0IGluc3QpCj4gK3sKPiArwqDCoMKgIHJldHVybiBleHRyYWN0MzIoaW5zdCwgOCwg
MykgKiAyICsgMTsKPiArfQo+ICsKPiDCoHN0YXRpYyB1aW50MzJfdCBvcGVyYW5kX21vcF9yX2lt
bShydl9pbnN0IGluc3QpCj4gwqB7Cj4gwqDCoMKgwqAgcmV0dXJuIChleHRyYWN0MzIoaW5zdCwg
MzAsIDEpIDw8IDQpIHwKPiBAQCAtMTAyNyw3ICsxMDMyLDcgQEAgc3RhdGljIGNvbnN0IHJ2X29w
Y29kZV9kYXRhCj4gKmRlY29kZV9pbnN0X29wY29kZShydl9kZWNvZGUgKmRlYywgcnZfaXNhIGlz
YSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgoKGluc3QgPj4g
MTEpICYgMGIxMSkgPT0gMGIwKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IGNtb3BfY29kZSA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbW9wX2NvZGUgPSAoKGluc3QgPj4gOCkgJiAwYjExMSk7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gcnZfb3BfY19t
b3BfMSArIGNtb3BfY29kZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgb3AgPSBydl9vcF9jX21vcDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChkZWMtPmNmZy0+ZXh0X3ppY2Zpc3MpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3AgPSAoY21vcF9jb2RlID09IDApID8gcnZf
b3BfY19zc3B1c2ggOiBvcDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgb3AgPSAoY21vcF9jb2RlID09IDIpID8gcnZfb3BfY19zc3BvcGNoayA6Cj4g
b3A7Cj4gQEAgLTMwNTYsNiArMzA2MSw5IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9pbnN0X29wZXJh
bmRzKHJ2X2RlY29kZQo+ICpkZWMsIHJ2X2lzYSBpc2EsCj4gwqDCoMKgwqAgY2FzZSBydl9jb2Rl
Y19scDoKPiDCoMKgwqDCoMKgwqDCoMKgIGRlYy0+aW1tID0gb3BlcmFuZF9scGwoaW5zdCk7Cj4g
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgIGNhc2UgcnZfY29kZWNfY21vcDoKPiAr
wqDCoMKgwqDCoMKgwqAgZGVjLT5pbW0gPSBvcGVyYW5kX2Ntb3BfaW1tKGluc3QpOwo+ICvCoMKg
wqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoCBjYXNlIHJ2X2NvZGVjX2Ntb3Bfc3M6Cj4gwqDC
oMKgwqDCoMKgwqDCoCBkZWMtPnJkID0gcnZfaXJlZ196ZXJvOwo+IMKgwqDCoMKgwqDCoMKgwqAg
ZGVjLT5yczEgPSBkZWMtPnJzMiA9IG9wZXJhbmRfY3JzMShpbnN0KTsKPiBkaWZmIC0tZ2l0IGEv
ZGlzYXMvcmlzY3Ytb3AuYy5pbmMgYi9kaXNhcy9yaXNjdi1vcC5jLmluYwo+IGluZGV4IDIxMDBl
NTQ0NzUuLjgwMmE1MjFiY2EgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3Ytb3AuYy5pbmMKPiAr
KysgYi9kaXNhcy9yaXNjdi1vcC5jLmluYwo+IEBAIC04NzUsMTQgKzg3NSw3IEBAIE9QKGFtb2Nh
c19kLCAiYW1vY2FzLmQiLCBydl9jb2RlY19yX2EsCj4gcnZfZm10X2FxcmxfcmRfcnMyX3JzMSkK
PiDCoE9QKGFtb2Nhc19xLCAiYW1vY2FzLnEiLCBydl9jb2RlY19yX2EsIHJ2X2ZtdF9hcXJsX3Jk
X3JzMl9yczEpCj4gwqBPUChtb3BfciwgIm1vcC5yIiwgcnZfY29kZWNfbW9wX3IsIHJ2X2ZtdF9t
b3BfcikKPiDCoE9QKG1vcF9yciwgIm1vcC5yciIsIHJ2X2NvZGVjX21vcF9yciwgcnZfZm10X21v
cF9ycikKPiAtT1AoY19tb3BfMSwgImMubW9wLjEiLCBydl9jb2RlY19jaV9ub25lLCBydl9mbXRf
bm9uZSkKPiAtT1AoY19tb3BfMywgImMubW9wLjMiLCBydl9jb2RlY19jaV9ub25lLCBydl9mbXRf
bm9uZSkKPiAtT1AoY19tb3BfNSwgImMubW9wLjUiLCBydl9jb2RlY19jaV9ub25lLCBydl9mbXRf
bm9uZSkKPiAtT1AoY19tb3BfNywgImMubW9wLjciLCBydl9jb2RlY19jaV9ub25lLCBydl9mbXRf
bm9uZSkKPiAtT1AoY19tb3BfOSwgImMubW9wLjkiLCBydl9jb2RlY19jaV9ub25lLCBydl9mbXRf
bm9uZSkKPiAtT1AoY19tb3BfMTEsICJjLm1vcC4xMSIsIHJ2X2NvZGVjX2NpX25vbmUsIHJ2X2Zt
dF9ub25lKQo+IC1PUChjX21vcF8xMywgImMubW9wLjEzIiwgcnZfY29kZWNfY2lfbm9uZSwgcnZf
Zm10X25vbmUpCj4gLU9QKGNfbW9wXzE1LCAiYy5tb3AuMTUiLCBydl9jb2RlY19jaV9ub25lLCBy
dl9mbXRfbm9uZSkKPiArT1AoY19tb3AsICJjLm1vcCIsIHJ2X2NvZGVjX2Ntb3AsIHJ2X2ZtdF9j
bW9wKQo+IMKgT1AoYW1vc3dhcF9iLCAiYW1vc3dhcC5iIiwgcnZfY29kZWNfcl9hLCBydl9mbXRf
YXFybF9yZF9yczJfcnMxKQo+IMKgT1AoYW1vYWRkX2IsICJhbW9hZGQuYiIsIHJ2X2NvZGVjX3Jf
YSwgcnZfZm10X2FxcmxfcmRfcnMyX3JzMSkKPiDCoE9QKGFtb3hvcl9iLCAiYW1veG9yLmIiLCBy
dl9jb2RlY19yX2EsIHJ2X2ZtdF9hcXJsX3JkX3JzMl9yczEpCg==


