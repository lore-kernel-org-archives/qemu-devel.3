Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5782CD5B854
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBqf-0004yS-B1; Mon, 15 Dec 2025 11:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVBqM-0004xU-NU
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:54:42 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVBqJ-0001iV-IS
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:54:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765817554; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tc53rykijguGng9yYKEEUVGC2Jb2qdgQtApnef1tbvc3RdpVvl/fXvEjzFrVMfkqajgnknvMz8FF7Tfh6BbpkpyfVFJ9j6UEJHuOqFCGoad2t7fOiIgvhfNci2WU6jJl5Nkj/OYmPnBrDpHo7xJ7tsJaZ38+rsa5Z42+op02MLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765817554;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fhf/i3W922cwjDZzN+Aa9fovELFDhLsvX8mkJjuCJJM=; 
 b=NmVj8ODn3GiqOuBXgQEJpLltc0E7KhG+GmDTa7Sv/dx8iEkh3pC3VamjYvQysmPHNmCphchCvK0Ks58/Vk4EmJSasqajA5eUbTkeh5PA7qguq/jBCpF2FJ6poU6qwBEo7H2dbsIpP3PIdstFMMkjhjkzQ6L5ffyq718z67pFXY0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765817554; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=fhf/i3W922cwjDZzN+Aa9fovELFDhLsvX8mkJjuCJJM=;
 b=AWB58VYPxD1Fi2QiXwGt8AAAthX6GT+mpml9W+/NrYOeN6wwcfOauzcSNC3AcKcU
 5JF+PxNqP/boJXC0RtCLAIYoiR7IccqnJjMUtANfBGhgbJq9mhoS9zl6ZxlDctKm/h6
 H/XIf0XeXBI4Hb+MLeHwmpqU3rBCTPZsA/6yYeXuubRLklTNJ3kXrXPhkhqYCHgkK/9
 dAfTxwya1LUR+NyEzCIJzlmhfmqkWG9oRDXj9436pRx+tkAJfWsXJQeXmwLXuqPQHD6
 ZnaddWHR25POBeooGp4EFQJv7/NraRuImzbqE9DtR58gm+9807SAv5w916k+yQwz7wJ
 XXQy5lJtzw==
Received: by mx.zohomail.com with SMTPS id 1765817552126861.6983322663837;
 Mon, 15 Dec 2025 08:52:32 -0800 (PST)
Message-ID: <70995759267010817b2005884979e57117006e7d.camel@icenowy.me>
Subject: Re: [PATCH 5/7] Add termios2 support to ppc target
From: Icenowy Zheng <uwu@icenowy.me>
To: Luca Bonissi <qemu@bonslack.org>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Date: Tue, 16 Dec 2025 00:52:27 +0800
In-Reply-To: <ab68ba71-acd1-4ef1-bdde-f72a9e8e3152@bonslack.org>
References: <ab68ba71-acd1-4ef1-bdde-f72a9e8e3152@bonslack.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

5ZyoIDIwMjUtMTAtMzHmmJ/mnJ/kupTnmoQgMTQ6MjYgKzAxMDDvvIxMdWNhIEJvbmlzc2nlhpnp
gZPvvJoKPiA+IEZyb20gMmFhMGExM2RhMGRhNmUzYTgwNDM1OWYyNGNjMTI5OGI5N2NkYTQ1YyBN
b24gU2VwIDE3IDAwOjAwOjAwCj4gPiAyMDAxCj4gRnJvbTogTHVjYSBCb25pc3NpIDxxZW11QGJv
bnNsYWNrLm9yZz4KPiBEYXRlOiBGcmksIDMxIE9jdCAyMDI1IDEzOjMxOjM2ICswMTAwCj4gU3Vi
amVjdDogW1BBVENIIDUvN10gQWRkIHRlcm1pb3MyIHN1cHBvcnQgdG8gcHBjIHRhcmdldAo+IAo+
IFNpZ25lZC1vZmYtYnk6IEx1Y2EgQm9uaXNzaSA8cWVtdUBib25zbGFjay5vcmc+Cj4gLS0tCj4g
wqBsaW51eC11c2VyL3BwYy90ZXJtYml0cy5oIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9s
aW51eC11c2VyL3BwYy90ZXJtYml0cy5oIGIvbGludXgtdXNlci9wcGMvdGVybWJpdHMuaAo+IGlu
ZGV4IGViMjI2ZTA5OTkuLmFlNmVlODg5N2MgMTAwNjQ0Cj4gLS0tIGEvbGludXgtdXNlci9wcGMv
dGVybWJpdHMuaAo+ICsrKyBiL2xpbnV4LXVzZXIvcHBjL3Rlcm1iaXRzLmgKPiBAQCAtMjAsNiAr
MjAsMjggQEAgc3RydWN0IHRhcmdldF90ZXJtaW9zIHsKPiDCoMKgwqDCoCB0YXJnZXRfc3BlZWRf
dCBjX29zcGVlZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIG91dHB1dCBzcGVlZCAq
Lwo+IMKgfTsKPiDCoAo+ICtzdHJ1Y3QgdGFyZ2V0X3Rlcm1pb3MyIHsKPiArwqDCoMKgIHRhcmdl
dF90Y2ZsYWdfdCBjX2lmbGFnO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogaW5wdXQg
bW9kZSBmbGFncyAqLwo+ICvCoMKgwqAgdGFyZ2V0X3RjZmxhZ190IGNfb2ZsYWc7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBvdXRwdXQgbW9kZSBmbGFncyAqLwo+ICvCoMKgwqAgdGFy
Z2V0X3RjZmxhZ190IGNfY2ZsYWc7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBjb250
cm9sIG1vZGUgZmxhZ3MgKi8KPiArwqDCoMKgIHRhcmdldF90Y2ZsYWdfdCBjX2xmbGFnO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbG9jYWwgbW9kZSBmbGFncyAqLwo+ICvCoMKgwqAg
dGFyZ2V0X2NjX3QgY19jY1tUQVJHRVRfTkNDU107wqDCoMKgwqDCoMKgwqDCoCAvKiBjb250cm9s
IGNoYXJhY3RlcnMgKi8KPiArwqDCoMKgIHRhcmdldF9jY190IGNfbGluZTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBsaW5lIGRpc2NpcGxpbmUgKi8KPiArwqDCoMKg
IHRhcmdldF9zcGVlZF90IGNfaXNwZWVkO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
aW5wdXQgc3BlZWQgKi8KPiArwqDCoMKgIHRhcmdldF9zcGVlZF90IGNfb3NwZWVkO8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogb3V0cHV0IHNwZWVkICovCj4gK307Cj4gKwo+ICtzdHJ1
Y3QgdGFyZ2V0X2t0ZXJtaW9zIHsKPiArwqDCoMKgIHRhcmdldF90Y2ZsYWdfdCBjX2lmbGFnO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogaW5wdXQgbW9kZSBmbGFncyAqLwo+ICvCoMKg
wqAgdGFyZ2V0X3RjZmxhZ190IGNfb2ZsYWc7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBvdXRwdXQgbW9kZSBmbGFncyAqLwo+ICvCoMKgwqAgdGFyZ2V0X3RjZmxhZ190IGNfY2ZsYWc7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBjb250cm9sIG1vZGUgZmxhZ3MgKi8KPiAr
wqDCoMKgIHRhcmdldF90Y2ZsYWdfdCBjX2xmbGFnO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogbG9jYWwgbW9kZSBmbGFncyAqLwo+ICvCoMKgwqAgdGFyZ2V0X2NjX3QgY19jY1tUQVJH
RVRfTkNDU107wqDCoMKgwqDCoMKgwqDCoCAvKiBjb250cm9sIGNoYXJhY3RlcnMgKi8KPiArwqDC
oMKgIHRhcmdldF9jY190IGNfbGluZTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBsaW5lIGRpc2NpcGxpbmUgKi8KPiArwqDCoMKgIHRhcmdldF9zcGVlZF90IGNfaXNw
ZWVkO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogaW5wdXQgc3BlZWQgKi8KPiArwqDC
oMKgIHRhcmdldF9zcGVlZF90IGNfb3NwZWVkO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Lyogb3V0cHV0IHNwZWVkICovCj4gK307Cj4gKwoKV2VsbCB5b3VyIHRoaXMgcGF0Y2ggc2VlbXMg
dG8gYmUgaW50cm9kdWNpbmcgbm9uLW5lZWRlZCB0aGluZ3MgZm9yClBvd2VyUEM/CgpBbGwgMyBz
dHJ1Y3R1cmVzIGFyZSB0aGUgc2FtZSBoZXJlLCBhbmQgUFBDIG5ldmVyIGhhcyBhIHRlcm1pb3My
CmludGVyZmFjZSAoZXhjZXB0IGluc2lkZSB0aGUgaW50ZXJuYWwgb2YgZ2xpYmMpLgoKPiDCoC8q
IGNfY2MgY2hhcmFjdGVyIG9mZnNldHMgKi8KPiDCoCNkZWZpbmUgVEFSR0VUX1ZJTlRSwqDCoMKg
MAo+IMKgI2RlZmluZSBUQVJHRVRfVlFVSVTCoMKgwqAxCj4gQEAgLTIyNSw2ICsyNDcsOCBAQCBz
dHJ1Y3QgdGFyZ2V0X3Rlcm1pb3Mgewo+IMKgI2RlZmluZSBUQVJHRVRfVElPQ1NCUkvCoMKgwqDC
oMKgwqDCoMKgMHg1NDI3wqAgLyogQlNEIGNvbXBhdGliaWxpdHkgKi8KPiDCoCNkZWZpbmUgVEFS
R0VUX1RJT0NDQlJLwqDCoMKgwqDCoMKgwqDCoDB4NTQyOMKgIC8qIEJTRCBjb21wYXRpYmlsaXR5
ICovCj4gwqAjZGVmaW5lIFRBUkdFVF9USU9DR1NJRMKgwqDCoMKgwqDCoMKgwqAweDU0MjnCoCAv
KiBSZXR1cm4gdGhlIHNlc3Npb24gSUQgb2YKPiBGRCAqLwo+ICsjZGVmaW5lIFRBUkdFVF9USU9D
R1JTNDg1wqDCoMKgwqDCoMKgMHg1NDJlCj4gKyNkZWZpbmUgVEFSR0VUX1RJT0NTUlM0ODXCoMKg
wqDCoMKgwqAweDU0MmYKCkkgZG9uJ3QgdGhpbmsgdGhlc2UgdHdvIElPQ1RMJ3MgYXJlIHJlbGF0
ZWQgaGVyZS4KCldlbGwgdGhleSdyZSBtaXNzaW5nLCBidXQgdGhleSdyZSBub3QgaW1wbGVtZW50
ZWQgZWl0aGVyLgoKPiDCoCNkZWZpbmUgVEFSR0VUX1RJT0NHUFROwqDCoMKgwqDCoMKgwqDCoFRB
UkdFVF9JT1IoJ1QnLDB4MzAsIHVuc2lnbmVkIGludCkgLyoKPiBHZXQgUHR5IE51bWJlciAob2Yg
cHR5LW11eCBkZXZpY2UpICovCj4gwqAjZGVmaW5lIFRBUkdFVF9USU9DU1BUTENLwqDCoMKgwqDC
oMKgVEFSR0VUX0lPVygnVCcsMHgzMSwgaW50KcKgIC8qCj4gTG9jay91bmxvY2sgUHR5ICovCj4g
wqAjZGVmaW5lIFRBUkdFVF9USU9DR1BUUEVFUsKgwqDCoMKgwqAgVEFSR0VUX0lPKCdUJywgMHg0
MSkgLyogU2FmZWx5IG9wZW4KPiB0aGUgc2xhdmUgKi8KCg==


