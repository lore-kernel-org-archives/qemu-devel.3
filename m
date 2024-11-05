Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE1D3177F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OJF-0004CL-EJ; Tue, 05 Nov 2024 13:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0327b8673=graf@amazon.de>)
 id 1t8OJA-0004C1-6J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:29:40 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0327b8673=graf@amazon.de>)
 id 1t8OJ8-0006la-5H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1730831378; x=1762367378;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5PCZC0mBL2iugFnPmnPNB9ftUp+KJPKq55IJ1BA6nCU=;
 b=XyJQntGLOBOrDhRFmLbxTmbf+YBnbtVziijsIdFiwlHKX01J78KwAsIj
 yRY6EzJzHoNiEQCxNbUj5V9f3nEa3nNwFCnyNr/Nvz31j+Yrani2f+L3Z
 eru2zpN098a27lIqE9uR6Ge39VxHAuX56uuDxTZIJyzCY1RuLFVz2+Eea s=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; d="scan'208";a="349626617"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 18:29:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:15944]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525]
 with esmtp (Farcaster)
 id b555d9ff-e314-4541-945f-052a5a643bc6; Tue, 5 Nov 2024 18:29:33 +0000 (UTC)
X-Farcaster-Flow-ID: b555d9ff-e314-4541-945f-052a5a643bc6
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 18:29:33 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 5 Nov 2024
 18:29:31 +0000
Message-ID: <067f79b6-55bd-4ea1-87e2-056920548a4b@amazon.com>
Date: Tue, 5 Nov 2024 10:29:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Nitro Enclave Emulation on macOS
To: Payton Garland <payton@privy.io>, <qemu-devel@nongnu.org>
CC: Dorjoy Chowdhury <dorjoychy111@gmail.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
References: <CADVAEoB-UoTtdFDfbBAeRGB0TKTw51G59-EpZ7un4vjET4329Q@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CADVAEoB-UoTtdFDfbBAeRGB0TKTw51G59-EpZ7un4vjET4329Q@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=0327b8673=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGkgUGF5dG9uLAoKT24gMDUuMTEuMjQgMTg6MzEsIFBheXRvbiBHYXJsYW5kIHdyb3RlOgoKPiBI
ZWxsbyBhbGwsCj4KPiBJIGhhdmUgYmVlbiB3YXRjaGluZyB0aGUgTml0cm8gRW5jbGF2ZSBFbXVs
YXRpb24gcGF0Y2ggCj4gPGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11
LWRldmVsL2NvdmVyLzIwMjQxMDA4MjExNzI3LjQ5MDg4LTEtZG9yam95Y2h5MTExQGdtYWlsLmNv
bS8+LiAKPiBUaGlzIHdvdWxkIGJlIGEgaHVnZSB3aW4gZm9yIGRldmVsb3BlciBleHBlcmllbmNl
IGluIE5pdHJvIEVuY2xhdmUgCj4gZGV2ZWxvcG1lbnQuCgoKVGhhbmsgeW91IGZvciBjb25maXJt
aW5nISBJIGFsc28gYWdyZWUgdGhhdCBpdCBjYW4gZHJhbWF0aWNhbGx5IHNpbXBsaWZ5IApsb2Nh
bCBkZXZlbG9wbWVudCwgZGVidWdnaW5nIGFuZCBDSSBsb29wcy4gS3Vkb3MgdG8gRG9yam95IGZv
ciBnZXR0aW5nIAppdCBhbGwgYXNzZW1ibGVkIDopLgoKCj4gSSByYW4gaW50byBzb21lIGhhcmR3
YXJlIGlzc3VlcyBhbmQgYW0gY3VyaW91cyBpZiB0aGVyZSBhcmUgYW55IGtub3duIAo+IHdvcmth
cm91bmRzLiBJIHdhcyBtZXNzYWdpbmcgd2l0aCBARG9yam95IENob3dkaHVyeSAKPiA8bWFpbHRv
OmRvcmpveWNoeTExMUBnbWFpbC5jb20+wqBvbiB0aGlzIGlzc3VlIGFuZCB0aGV5IHN1Z2dlc3Rl
ZCB0aGlzIAo+IGdyb3VwIG1heSBoYXZlIHNvbWUgaWRlYXMgLyBkZWZpbml0aXZlIGFuc3dlcnMu
Cj4KPiAqR29hbCo6IC9lbXVsYXRlIEFXUyBOaXRybyBFbmNsYXZlcyBsb2NhbGx5IHJ1bm5pbmcg
b24gbWFjT1Mgd2l0aCAKPiBBcHBsZSBzaWxpY29uCj4gLwo+Cj4gKkF0dGVtcHQqOiAvYnVpbHQg
dmhvc3QtZGV2aWNlLXZzb2NrIAo+IDxodHRwczovL2dpdGh1Yi5jb20vcnVzdC12bW0vdmhvc3Qt
ZGV2aWNlL3RyZWUvbWFpbi92aG9zdC1kZXZpY2UtdnNvY2s+IAo+IGFuZCBxZW11IAo+IDxodHRw
czovL2dpdGxhYi5jb20vZG9yam95MDMvcWVtdS8tL2NvbW1pdC9mZTRkZGI0ZTViOTkxMzZjOTQ4
ZTY4N2I4YjE4YTUwNWRlY2M1N2JmPiAKPiAob24gL0BEb3Jqb3kgQ2hvd2RodXJ5IDxtYWlsdG86
ZG9yam95Y2h5MTExQGdtYWlsLmNvbT4vwqAncyBicmFuY2gpIGluIAo+IGFuIGFscGluZSBEb2Nr
ZXIgaW1hZ2UgYW5kIGF0dGVtcHRlZCB0byBydW4gYm90aCB3aXRoIHRoaXMgc2NyaXB0IAo+IDxo
dHRwczovL2dpc3QuZ2l0aHViLmNvbS9wYXl0b24vNGVjMGEwOGU2MTg4ODhhZGFmYjRiOWE4ODg1
MTNkOTE+Lwo+Cj4gKlByb2JsZW0qOiAvZW5jbGF2ZSBlbXVsYXRpb24gcmVxdWlyZXMgS1ZNIHN1
cHBvcnQgcGVyIHRoZSBsYXRlc3QgCj4gZG9jdW1lbnRhdGlvbiAKPiA8aHR0cHM6Ly9naXRsYWIu
Y29tL2RvcmpveTAzL3FlbXUvLS9jb21taXQvZmU0ZGRiNGU1Yjk5MTM2Yzk0OGU2ODdiOGIxOGE1
MDVkZWNjNTdiZj4sIAo+IHdoaWNoIGlzIHNwZWNpZmljIHRvIExpbnV4LCBzbyBldmVuIHJ1bm5p
bmcgRG9ja2VyIHdpdGggcHJpdmlsZWdlZCAKPiBhY2Nlc3MgZG9lcyBub3QgaGVscCBiZWNhdXNl
IHRoZXJlIGlzIG5vIEtWTSBvbiBtYWNPUy8KPiAvCj4gLwo+ICpRdWVzdGlvbjoqL2lzIHRoZXJl
IGEga25vd24gd2F5IHRvIGdldCBOaXRybyBFbmNsYXZlIGVtdWxhdGlvbiAKPiB3b3JraW5nIG9u
IG1hY09TIHdpdGggQXBwbGUgc2lsaWNvbj8gT25lIG9wdGlvbiB0aGF0IGNvbWVzIHRvIG1pbmQg
aXMgCj4gQXBwbGUncyBoeXBlcnZpc29yIGZyYW1ld29yaywgYnV0IGl0J3MgdW5jbGVhciB0byBt
ZSBpZiB0aGF0IGNhbiBiZSBhIAo+IHZpYWJsZSByZXBsYWNlbWVudMKgZm9yIGVuY2xhdmUgZW11
bGF0aW9uLi8KCgpUaGUgbmV3IE5pdHJvIEVuY2xhdmUgZW11bGF0aW9uIHN1cHBvcnQgdGhhdCBE
b3Jqb3kgYnVpbHQgaW1wbGVtZW50cyBhbiAKeDg2IEVuY2xhdmUuIElmIHlvdSB3YW50IHRvIHJ1
biBhIHZpcnR1YWwgbWFjaGluZSB3aXRoIHZlcnkgZmFzdCAKcGVyZm9ybWFuY2UgdGhyb3VnaCBI
eXBlcnZpc29yLkZyYW1ld29yaywgeW91IHdvdWxkIG5lZWQgdG8gcnVuIGFuIEFSTSAKRW5jbGF2
ZS4gUUVNVSBkb2VzIG5vdCBoYXZlIGVtdWxhdGlvbiBzdXBwb3J0IGZvciBBUk0gRW5jbGF2ZXMg
eWV0LgoKSG93ZXZlciwgeW91IGNhbiBydW4gdGhlIHg4NiBFbmNsYXZlIHVzaW5nIHg4Ni1vbi1B
Uk0gaW5zdHJ1Y3Rpb24gCmVtdWxhdGlvbi4gVG8gZG8gdGhhdCwgZm9sbG93IHRoZSBkb2N1bWVu
dGF0aW9uIHlvdSBsaW5rZWQgYWJvdmUsIGJ1dCAKcmVtb3ZlIHRoZSAiLS1lbmFibGUta3ZtIiBw
YXJhbWV0ZXJzLiBUaGUgVk0gd2lsbCBiZSBhIGJpdCBzbG93ZXIsIGJ1dCAKc3RpbGwgdXNhYmxl
LgoKClRoYW5rcyEKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


