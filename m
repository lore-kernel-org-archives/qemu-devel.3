Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0413F5542B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 23:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv1eP-0002dV-9x; Tue, 24 Feb 2026 18:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5087e30c2=graf@amazon.de>)
 id 1vv1eN-0002cY-OD; Tue, 24 Feb 2026 18:17:08 -0500
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5087e30c2=graf@amazon.de>)
 id 1vv1eL-0005Gy-F3; Tue, 24 Feb 2026 18:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771975025; x=1803511025;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ViumTtedRb+koefa70wHWBPRlYvfYrXB6Dlp+Uija90=;
 b=dXo4WjnuCTU/Ti41vpys8Pkek1FK9Tpo7yjlWYYHt+EOJEFnz9AkvPrU
 p3mSgxEDHSCH3A7yERhovfb7hH+aAsKXB1jIwVaEBpyj698/WxLkecaur
 h+XgWpqrqWOXEKNHhvAYYXNMHWAwC6O0mEFXChXEMEh/yR6oc0kBX4yCf
 Cqw3nb2O5F96/YjW3Ov7yi6YP3Kzkpu8kaw26q+4o57DEEjgBrxonULus
 x9mJyEWm18Vn6gbeJeg7I+RbZ9LipbJ7L5L5O2Piy3NsIYlx96OXJ3k2s
 CT+8FhQ0KttnkQFyFQHH5TODiVFFY7TrKNPbayd50fO5sXKgyLgruBYFG w==;
X-CSE-ConnectionGUID: 39pMirYvT3GAfMkTNKDuCw==
X-CSE-MsgGUID: z+fsWX8XRAu6uYB0K+EC8w==
X-IronPort-AV: E=Sophos;i="6.21,309,1763424000"; d="scan'208";a="13529305"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 23:16:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:8911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.196:2525]
 with esmtp (Farcaster)
 id ce1adf89-aa4a-4dc0-939a-8d2a0bb869b2; Tue, 24 Feb 2026 23:16:56 +0000 (UTC)
X-Farcaster-Flow-ID: ce1adf89-aa4a-4dc0-939a-8d2a0bb869b2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 24 Feb 2026 23:16:56 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 24 Feb 2026
 23:16:52 +0000
Message-ID: <86b8f3b3-4016-460a-bc8d-daa39f344ae4@amazon.com>
Date: Wed, 25 Feb 2026 00:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel: Add Nitro Enclaves accelerator
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tyler Fanelli <tfanelli@redhat.com>, <mknaust@amazon.com>,
 <nh-open-source@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-4-graf@amazon.com>
 <2be88699-f77b-4236-a959-bc999a3e4caf@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <2be88699-f77b-4236-a959-bc999a3e4caf@redhat.com>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=5087e30c2=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Ck9uIDI0LjAyLjI2IDExOjIyLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IE9uIDIvMTgvMjYgMDI6
NTEsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+PiArLyoKPj4gKyAqIFN0YXJ0IHRoZSBFbmNsYXZl
LiBUaGlzIGdldHMgY2FsbGVkIHdoZW4gdGhlIGZpcnN0IHZDUFUgMCBlbnRlcnMgCj4+IGl0cyBt
YWluCj4+ICsgKiBsb29wLiBBdCB0aGlzIHBvaW50IG1lbW9yeSBpcyBzZXQgdXAgYW5kIHRoZSBF
SUYgaXMgbG9hZGVkLiBUaGlzIAo+PiBmdW5jdGlvbgo+PiArICogZG9uYXRlcyBtZW1vcnksIGFk
ZHMgdkNQVXMsIGFuZCBzdGFydHMgdGhlIGVuY2xhdmUuCj4+ICsgKi8KPj4gK3N0YXRpYyB2b2lk
IG5pdHJvX2RvX3N0YXJ0KE5pdHJvQWNjZWxTdGF0ZSAqcykKPj4gK3sKPj4gK8KgwqDCoCBNYWNo
aW5lU3RhdGUgKm1zID0gTUFDSElORShxZGV2X2dldF9tYWNoaW5lKCkpOwo+PiArwqDCoMKgIGlu
dCBucl9jcHVzID0gbXMtPnNtcC5jcHVzOwo+PiArwqDCoMKgIGludCBpLCByZXQ7Cj4+ICvCoMKg
wqAgc3RydWN0IG5lX2VuY2xhdmVfc3RhcnRfaW5mbyBzdGFydF9pbmZvID0gewo+PiArwqDCoMKg
wqDCoMKgwqAgLmZsYWdzID0gcy0+ZGVidWdfbW9kZSA/IE5FX0VOQ0xBVkVfREVCVUdfTU9ERSA6
IDAsCj4+ICvCoMKgwqDCoMKgwqDCoCAuZW5jbGF2ZV9jaWQgPSBzLT5lbmNsYXZlX2NpZCwKPj4g
K8KgwqDCoCB9Owo+PiArCj4+ICvCoMKgwqAgcmV0ID0gcWVtdV9yYW1fZm9yZWFjaF9ibG9jayhu
aXRyb19kb25hdGVfcmFtX2Jsb2NrLCBzKTsKPj4gK8KgwqDCoCBpZiAocmV0IDwgMCkgewo+PiAr
wqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJuaXRybzogZmFpbGVkIHRvIGRvbmF0ZSBtZW1v
cnkiKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGV4aXQoMSk7Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvC
oMKgwqAgZm9yIChpID0gMDsgaSA8IG5yX2NwdXM7IGkrKykgewo+PiArwqDCoMKgwqDCoMKgwqAg
dWludDMyX3QgY3B1X2lkID0gMDsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChpb2N0bChzLT5lbmNs
YXZlX2ZkLCBORV9BRERfVkNQVSwgJmNwdV9pZCkgPCAwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVycm9yX3JlcG9ydCgibml0cm86IE5FX0FERF9WQ1BVIGZhaWxlZDogJXMiLCAKPj4g
c3RyZXJyb3IoZXJybm8pKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhpdCgxKTsKPj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCByZXQgPSBpb2N0
bChzLT5lbmNsYXZlX2ZkLCBORV9TVEFSVF9FTkNMQVZFLCAmc3RhcnRfaW5mbyk7Cj4+ICvCoMKg
wqAgaWYgKHJldCA8IDApIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHN3aXRjaCAoZXJybm8pIHsKPj4g
K8KgwqDCoMKgwqDCoMKgIGNhc2UgTkVfRVJSX05PX01FTV9SRUdJT05TX0FEREVEOgo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIm5pdHJvOiBubyBtZW1vcnkgcmVnaW9u
cyBhZGRlZCIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDCoMKg
wqDCoMKgIGNhc2UgTkVfRVJSX05PX1ZDUFVTX0FEREVEOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlcnJvcl9yZXBvcnQoIm5pdHJvOiBubyB2Q1BVcyBhZGRlZCIpOwo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgTkVfRVJSX0VOQ0xB
VkVfTUVNX01JTl9TSVpFOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQo
Im5pdHJvOiBtZW1vcnkgaXMgYmVsb3cgdGhlIG1pbmltdW0gIgo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZXF1aXJlZCBzaXplLiBUcnkgaW5j
cmVhc2luZyAtbSIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDC
oMKgwqDCoMKgIGNhc2UgTkVfRVJSX0ZVTExfQ09SRVNfTk9UX1VTRUQ6Cj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgibml0cm86IHJlcXVpcmVzIGZ1bGwgQ1BVIGNvcmVz
LiAiCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IlRyeSBpbmNyZWFzaW5nIC1zbXAgdG8gYSBtdWx0aXBsZSBvZiAKPj4gdGhyZWFkcyAiCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInBlciBjb3Jl
IG9uIHRoaXMgaG9zdCAoZS5nLiAtc21wIDIpIik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJyZWFrOwo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBORV9FUlJfTk9UX0lOX0lOSVRfU1RBVEU6
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgibml0cm86IG5vdCBpbiBp
bml0IHN0YXRlIik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKg
wqDCoMKgwqAgY2FzZSBORV9FUlJfSU5WQUxJRF9GTEFHX1ZBTFVFOgo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIm5pdHJvOiBpbnZhbGlkIGZsYWcgdmFsdWUgZm9yIAo+
PiBORV9TVEFSVF9FTkNMQVZFIik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+
PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBORV9FUlJfSU5WQUxJRF9FTkNMQVZFX0NJRDoKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJuaXRybzogaW52YWxpZCBlbmNsYXZl
IENJRCIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDCoMKgwqDC
oMKgIGRlZmF1bHQ6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgibml0
cm86IE5FX1NUQVJUX0VOQ0xBVkUgZmFpbGVkOiAlcyAoZXJybm8gCj4+ICVkKSIsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyZXJyb3IoZXJy
bm8pLCBlcnJubyk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKg
wqDCoMKgwqAgfQo+PiArwqDCoMKgwqDCoMKgwqAgZXhpdCgxKTsKPj4gK8KgwqDCoCB9Cj4+ICsK
Pj4gK8KgwqDCoCBzLT5lbmNsYXZlX2NpZCA9IHN0YXJ0X2luZm8uZW5jbGF2ZV9jaWQ7Cj4+ICvC
oMKgwqAgdHJhY2Vfbml0cm9fZW5jbGF2ZV9zdGFydGVkKHMtPmVuY2xhdmVfY2lkKTsKPj4gKwo+
PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIFB1c2ggZW5jbGF2ZSBDSUQgdG8gYWxsIGRldmlj
ZXMgdGhhdCBuZWVkIGl0Lgo+PiArwqDCoMKgwqAgKiBFYWNoIGRldmljZSBoYW5kbGVzIGl0cyBv
d24gY29ubmVjdGlvbiAoY29uc29sZSwgaGVhcnRiZWF0KS4KPj4gK8KgwqDCoMKgICovCj4+ICvC
oMKgwqAgewo+PiArwqDCoMKgwqDCoMKgwqAgQnVzU3RhdGUgKnN5c2J1cyA9IHN5c2J1c19nZXRf
ZGVmYXVsdCgpOwo+PiArwqDCoMKgwqDCoMKgwqAgQnVzQ2hpbGQgKmtpZDsKPj4gKwo+PiArwqDC
oMKgwqDCoMKgwqAgUVRBSUxRX0ZPUkVBQ0goa2lkLCAmc3lzYnVzLT5jaGlsZHJlbiwgc2libGlu
Zykgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXZpY2VTdGF0ZSAqZGV2ID0ga2lkLT5j
aGlsZDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG9iamVjdF9wcm9wZXJ0eV9maW5k
KE9CSkVDVChkZXYpLCAiZW5jbGF2ZS1jaWQiKSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRfdWludChPQkpFQ1QoZGV2KSwgImVuY2xhdmUt
Y2lkIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmVuY2xhdmVfY2lkLCBOVUxMKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgwqDCoMKgwqAgfQo+Cj4gSSB0
aGluayBpdCBtYWtlcyBtb3JlIHNlbnNlIHRvIGhhdmUgYSAibml0cm8gYnVzIiB3aXRoIGl0cyBv
d24gCj4gc3ViY2xhc3MgYW5kIGFuIGVuY2xhdmVfc3RhcnRlZChOaXRyb0RldmljZSAqZGV2LCBp
bnQgZW5jbGF2ZV9jaWQsIAo+IEVycm9yICoqZXJycCkgbWV0aG9kLsKgIFByb3BlcnRpZXMgY2Fu
IGJlIHNldCB3aXRoIC1kZXZpY2UgYW5kIHRoYXQgCj4gZ2V0cyBlaXRoZXIgYXdrd2FyZCBvciBi
dWdneSBwcmV0dHkgcXVpY2tseS4KCgpJIHRlbmQgdG8gYWdyZWUuIE1heWJlIGV2ZW4gYSAibml0
cm8gdnNvY2sgYnVzIi4gTGV0IG1lIGNvb2sgb24gdGhhdCBhIGJpdC4KCgo+Cj4+ICvCoMKgwqAg
fQo+PiArfQo+PiArCj4+ICsvKgo+PiArICogdkNQVSBkdW1teSB0aHJlYWQgZnVuY3Rpb24uIFRo
ZSByZWFsIHZDUFVzIHJ1biBpbnNpZGUgdGhlIGVuY2xhdmUuCj4+ICsgKgo+PiArICogQmFzZWQg
b24gZHVtbXlfY3B1X3RocmVhZF9mbigpIGZyb20gYWNjZWwvZHVtbXktY3B1cy5jLgo+PiArICov
Cj4+ICtzdGF0aWMgdm9pZCAqbml0cm9fdmNwdV90aHJlYWRfZm4odm9pZCAqYXJnKQo+PiArewo+
PiArwqDCoMKgIENQVVN0YXRlICpjcHUgPSBhcmc7Cj4+ICvCoMKgwqAgTml0cm9BY2NlbFN0YXRl
ICpzID0gTklUUk9fQUNDRUwoY3VycmVudF9hY2NlbCgpKTsKPj4gK8KgwqDCoCBzaWdzZXRfdCB3
YWl0c2V0Owo+PiArCj4+ICvCoMKgwqAgcmN1X3JlZ2lzdGVyX3RocmVhZCgpOwo+PiArCj4+ICvC
oMKgwqAgYnFsX2xvY2soKTsKPj4gK8KgwqDCoCBxZW11X3RocmVhZF9nZXRfc2VsZihjcHUtPnRo
cmVhZCk7Cj4+ICvCoMKgwqAgY3B1LT50aHJlYWRfaWQgPSBxZW11X2dldF90aHJlYWRfaWQoKTsK
Pj4gK8KgwqDCoCBjdXJyZW50X2NwdSA9IGNwdTsKPj4gKwo+PiArwqDCoMKgIHNpZ2VtcHR5c2V0
KCZ3YWl0c2V0KTsKPj4gK8KgwqDCoCBzaWdhZGRzZXQoJndhaXRzZXQsIFNJR19JUEkpOwo+PiAr
Cj4+ICvCoMKgwqAgY3B1X3RocmVhZF9zaWduYWxfY3JlYXRlZChjcHUpOwo+PiArwqDCoMKgIHFl
bXVfZ3Vlc3RfcmFuZG9tX3NlZWRfdGhyZWFkX3BhcnQyKGNwdS0+cmFuZG9tX3NlZWQpOwo+PiAr
Cj4+ICvCoMKgwqAgLyogdkNQVSAwIHN0YXJ0cyB0aGUgZW5jbGF2ZSBvbiBmaXJzdCBlbnRyeSAq
Lwo+PiArwqDCoMKgIGlmIChjcHUtPmNwdV9pbmRleCA9PSAwKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBuaXRyb19kb19zdGFydChzKTsKPj4gK8KgwqDCoCB9Cj4KPiBDYW4geW91IHJlcGxhY2UgdGhp
cyB3aXRoIGFuIGFzeW5jX3J1bl9vbl9jcHUoKSBjYWxsIHdoZW4gdkNQVSAwIGlzIAo+IGNyZWF0
ZWQgKGluIG5pdHJvX3N0YXJ0X3ZjcHVfdGhyZWFkKSBhbmQganVzdCByZXVzZSAKPiBkdW1teV9j
cHVfdGhyZWFkX2ZuKCk/Cj4KPiBPciBhbHRlcm5hdGl2ZWx5IHdpdGggYSBtYWNoaW5lIHJlYWR5
IG5vdGlmaWVyLgoKCkkgbW92ZWQgaXQgaW50byBzZXR1cF9wb3N0KCkgd2hpY2ggaXMgYSBtb3Jl
IG5hdHVyYWwgcGxhY2UgYW55d2F5LiBUaGF0IAp3YXkgSSBjYW4gYWxzbyBleGNsdXNpdmVseSB1
c2UgdGhlIGR1bW15IGNwdSB0aHJlYWQuIERlZmluaXRlbHkgbXVjaCAKY2xlYW5lciwgdGhhbmsg
eW91IDopLgoKCj4KPj4gZGlmZiAtLWdpdCBhL2FjY2VsL3N0dWJzL25pdHJvLXN0dWIuYyBiL2Fj
Y2VsL3N0dWJzL25pdHJvLXN0dWIuYwo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAw
MDAwMDAwMDAwLi4xODZjODQ0NGY4Cj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvYWNjZWwvc3R1
YnMvbml0cm8tc3R1Yi5jCj4+IEBAIC0wLDAgKzEsMTEgQEAKPj4gKy8qCj4+ICsgKiBOaXRybyBh
Y2NlbCBzdHVicyBmb3IgUUVNVQo+PiArICoKPj4gKyAqIENvcHlyaWdodCDCqSAyMDI2IEFtYXpv
bi5jb20sIEluYy4gb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCBSaWdodHMgCj4+IFJlc2VydmVkLgo+
PiArICoKPj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4+
ICsgKi8KPj4gKwo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKPj4gKwo+PiArYm9vbCBuaXRy
b19hbGxvd2VkOwo+Cj4gTWF5YmUgYWxsIHRoZXNlICpfYWxsb3dlZCB2YXJpYWJsZXMgc2hvdWxk
IGJlIGluIGEgLmMgZmlsZSBpbiBhY2NlbC8uCgoKSG0sIG1heWJlLiBCdXQgSSdkIGxpa2UgdG8g
bGVhdmUgdGhhdCBmb3IgYSBkaWZmZXJlbnQgcGF0Y2ggc2V0IHNvIEkgCmRvbid0IGVuZCB1cCBi
b2lsaW5nIHRoZSBvY2VhbiA6KQoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


