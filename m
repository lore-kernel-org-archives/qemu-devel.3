Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA6D32D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tApnG-0001Uc-9m; Tue, 12 Nov 2024 07:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tApnF-0001UN-BO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:14:49 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tApnD-0005Ep-JU
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1731413687; x=1762949687;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=elqDmOEmNxAbsX5atw0GxZsF/QJaFNXjU5z8UuOGNkM=;
 b=hbBkyz2T91XfOJS6k9aqFn4JJWk8vYkvO3FDMxhRce27zGgApuJA9rC6
 SXa5mmzVEkXQVX2qTp39Ns0Cbemu4lPxO+U8l9++aU53WOU+a9kt4DJdF
 F85q5KaudOvWYGHDMTGUoKTx2fMVgdlicmKIpPCXtq1/k0YDvvUExOTZP 4=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; d="scan'208";a="384523772"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:14:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:6849]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525]
 with esmtp (Farcaster)
 id 76199f82-575a-4628-ac0d-a756709e08b0; Tue, 12 Nov 2024 12:14:38 +0000 (UTC)
X-Farcaster-Flow-ID: 76199f82-575a-4628-ac0d-a756709e08b0
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 12:14:38 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 12 Nov 2024
 12:14:36 +0000
Message-ID: <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
Date: Tue, 12 Nov 2024 13:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20241109123208.24281-1-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=039b511fc=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGV5IERvcmpveSwKClRoYW5rcyBhIGxvdCBmb3IgdGhlIHBhdGNoISBXb3VsZCB5b3UgbWluZCB0
byBzZW5kIHRvIHRoZSBNTCBzbyBpdCBjYW4gCmdvIHRocm91Z2ggdGhlIG5vcm1hbCByZXZpZXcg
KyBhcHBseSBjeWNsZT8gOikKClNhbWUgY29tbWVudCBmb3IgdGhlIG90aGVyIHBhdGNoZXMuCgpB
bGV4CgpPbiAwOS4xMS4yNCAxMzozMiwgRG9yam95IENob3dkaHVyeSB3cm90ZToKPgo+IE5TTSBk
ZXZpY2UgaW4gQVdTIE5pdHJvIEVuY2xhdmVzIHN1cHBvcnRzIGV4dGVuZGluZyB3aXRoIGJvdGgK
PiBieXRlc3RyaW5nIGFuZCBzdHJpbmcgZGF0YS4KPgo+IFNpZ25lZC1vZmYtYnk6IERvcmpveSBD
aG93ZGh1cnkgPGRvcmpveWNoeTExMUBnbWFpbC5jb20+Cj4gLS0tCj4gICBody92aXJ0aW8vdmly
dGlvLW5zbS5jIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9ody92aXJ0
aW8vdmlydGlvLW5zbS5jIGIvaHcvdmlydGlvL3ZpcnRpby1uc20uYwo+IGluZGV4IGEzZGI4ZWVm
M2UuLjY4MzBmY2ZlMTcgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1uc20uYwo+ICsr
KyBiL2h3L3ZpcnRpby92aXJ0aW8tbnNtLmMKPiBAQCAtNDQ0LDcgKzQ0NCw3IEBAIHN0YXRpYyBi
b29sIGhhbmRsZV9kZXNjcmliZV9wY3IoVmlydElPTlNNICp2bnNtLCBzdHJ1Y3QgaW92ZWMgKnJl
cXVlc3QsCj4gICAgKiAgICAgICBrZXkgPSBTdHJpbmcoImluZGV4IiksCj4gICAgKiAgICAgICB2
YWx1ZSA9IFVpbnQ4KHBjciksCj4gICAgKiAgICAgICBrZXkgPSBTdHJpbmcoImRhdGEiKSwKPiAt
ICogICAgICAgdmFsdWUgPSBCeXRlX1N0cmluZyhkYXRhKSwKPiArICogICAgICAgdmFsdWUgPSBC
eXRlX1N0cmluZyhkYXRhKSB8fCBTdHJpbmcoZGF0YSksCj4gICAgKiAgICAgfQo+ICAgICogICB9
Cj4gICAgKiB9Cj4gQEAgLTUwNCwxNCArNTA0LDIxIEBAIHN0YXRpYyBlbnVtIE5TTVJlc3BvbnNl
VHlwZXMgZ2V0X25zbV9leHRlbmRfcGNyX3JlcSh1aW50OF90ICpyZXEsIHNpemVfdCBsZW4sCj4K
PiAgICAgICAgICAgaWYgKGNib3Jfc3RyaW5nX2xlbmd0aChwYWlyW2ldLmtleSkgPT0gNCAmJgo+
ICAgICAgICAgICAgICAgbWVtY21wKHN0ciwgImRhdGEiLCA0KSA9PSAwKSB7Cj4gLSAgICAgICAg
ICAgIGlmICghY2Jvcl9pc2FfYnl0ZXN0cmluZyhwYWlyW2ldLnZhbHVlKSkgewo+ICsgICAgICAg
ICAgICBpZiAoY2Jvcl9pc2FfYnl0ZXN0cmluZyhwYWlyW2ldLnZhbHVlKSkgewo+ICsgICAgICAg
ICAgICAgICAgc3RyID0gY2Jvcl9ieXRlc3RyaW5nX2hhbmRsZShwYWlyW2ldLnZhbHVlKTsKPiAr
ICAgICAgICAgICAgICAgIGlmICghc3RyKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgZ290byBj
bGVhbnVwOwo+ICsgICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICAgbnNtX3JlcS0+
ZGF0YV9sZW4gPSBjYm9yX2J5dGVzdHJpbmdfbGVuZ3RoKHBhaXJbaV0udmFsdWUpOwo+ICsgICAg
ICAgICAgICB9IGVsc2UgaWYgKGNib3JfaXNhX3N0cmluZyhwYWlyW2ldLnZhbHVlKSkgewo+ICsg
ICAgICAgICAgICAgICAgc3RyID0gY2Jvcl9zdHJpbmdfaGFuZGxlKHBhaXJbaV0udmFsdWUpOwo+
ICsgICAgICAgICAgICAgICAgaWYgKCFzdHIpIHsKPiArICAgICAgICAgICAgICAgICAgICBnb3Rv
IGNsZWFudXA7Cj4gKyAgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgICBuc21fcmVx
LT5kYXRhX2xlbiA9IGNib3Jfc3RyaW5nX2xlbmd0aChwYWlyW2ldLnZhbHVlKTsKPiArICAgICAg
ICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgICBnb3RvIGNsZWFudXA7Cj4gICAgICAg
ICAgICAgICB9Cj4gLSAgICAgICAgICAgIHN0ciA9IGNib3JfYnl0ZXN0cmluZ19oYW5kbGUocGFp
cltpXS52YWx1ZSk7Cj4gLSAgICAgICAgICAgIGlmICghc3RyKSB7Cj4gLSAgICAgICAgICAgICAg
ICBnb3RvIGNsZWFudXA7Cj4gLSAgICAgICAgICAgIH0KPiAtICAgICAgICAgICAgbnNtX3JlcS0+
ZGF0YV9sZW4gPSBjYm9yX2J5dGVzdHJpbmdfbGVuZ3RoKHBhaXJbaV0udmFsdWUpOwo+ICAgICAg
ICAgICAgICAgLyoKPiAgICAgICAgICAgICAgICAqIG5zbV9yZXEtPmRhdGFfbGVuIHdpbGwgYmUg
c21hbGxlciB0aGFuIE5TTV9SRVFVRVNUX01BWF9TSVpFIGFzCj4gICAgICAgICAgICAgICAgKiB3
ZSBhbHJlYWR5IGNoZWNrIGZvciB0aGUgbWF4IHJlcXVlc3Qgc2l6ZSBiZWZvcmUgcHJvY2Vzc2lu
Zwo+IC0tCj4gMi4zOS41Cj4KCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50
ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVl
aHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFt
IEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJs
aW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


