Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144BBC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoyi-0001sp-0W; Tue, 27 May 2025 03:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uJoxj-000123-UA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:43:06 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uJoxf-00007q-Pf
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:43:03 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1748331770; bh=gAeOKerGj2r3DBOc/WbrvbnasFeA75AFJwgZx/hma8Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 3JbQLNbc4utLRVm6wo/XvTIIBn1Uy+NFPDLeA6xirlELxeAoUPac36TOkF5stLw3T8TK87R5ln5Mlcjplwk4Dw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1748331770; bh=gAeOKerGj2r3DBOc/WbrvbnasFeA75AFJwgZx/hma8Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 qPKE98rvTgQokpby+FSWqSUYN+eVzzcHL1S54POaoefMeADCidGCF4IIG7LEd/N/86qY73ZZEY4i7puHa4rB8lPE6RbwjVZJup0suyfhffO92HskA7W3j4OOXFAprZcAWGabi/O0stp0z3moFFBeeDz8DU22u1+ybsKAezpbyNc6q1ZaIPiJzcIY7sUYILQyOr7eGPSAevf/DnogA2/cheJP0tgOkFvvJlAuUfKL49R8kLd6Y1Gt58uDkLFj41pLRWdcqm2DAbKAovIARHWCIrnDOIvht0B+TnrniVQdKIXkswZqt0CLGqbi131wxw7vbKbdp30hbovwzrzMZwNzJQ==
Received: from 172.17.6.17 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Tue, 27 May 2025 07:42:50 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 May
 2025 09:42:48 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Tue, 27 May 2025 09:42:48 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "edmund.raile@protonmail.com" <edmund.raile@protonmail.com>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Thread-Topic: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Thread-Index: AQHbyyyOIeUpjzZNpkWZF+h3YxwkkLPl/f8A
Date: Tue, 27 May 2025 07:42:48 +0000
Message-ID: <4e1f9747b59331845e68328a28a1c83c4e04e48a.camel@beckhoff.com>
References: <20250522151636.20001-1-tomitamoeko@gmail.com>
In-Reply-To: <20250522151636.20001-1-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-Fk7CZAljDB3SypbqgVKl"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-Fk7CZAljDB3SypbqgVKl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDIzOjE2ICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IEluIHZmaW9fcGNpX2lnZF9vcHJlZ2lvbl9k
ZXRlY3QoKSwgZXJycCB3aWxsIGJlIHNldCB3aGVuIHRoZSBkZXZpY2UgZG9lcwo+IG5vdCBoYXZl
IE9wUmVnaW9uIG9yIGlzIGhvdHBsdWdnZWQuIFRoaXMgZXJycCB3aWxsIGJlIHByb3BhZ2F0ZWQg
dG8KPiBwY2lfcWRldl9yZWFsaXplKCksIHdoaWNoIGludGVycHJldHMgaXQgYXMgZmFpbHVyZSwg
Y2F1c2luZyB1bmV4cGVjdGVkCj4gdGVybWluYXRpb24gb24gZGV2aWNlcyB3aXRob3V0IE9wUmVn
aW9uIGxpa2UgU1ItSU9WIFZGcyBvciBkaXNjcmV0ZQo+IEdQVXMuIEZpeCBpdCBieSBub3Qgc2V0
dGluZyBlcnJwIGluIHZmaW9fcGNpX2lnZF9vcHJlZ2lvbl9kZXRlY3QoKS4KPiAKPiBUaGlzIHBh
dGNoIGFsc28gY2hlY2tzIGlmIHRoZSBkZXZpY2UgaGFzIE9wUmVnaW9uIGJlZm9yZSBob3RwbHVn
IHN0YXR1cwo+IHRvIHByZXZlbnQgdW53YW50ZWQgd2FybmluZyBtZXNzYWdlcyBvbiBub24tSUdE
IGRldmljZXMuCj4gCj4gRml4ZXM6IGMwMjczZTc3ZjJkNyAoInZmaW8vaWdkOiBEZXRlY3QgSUdE
IGRldmljZSBieSBPcFJlZ2lvbiIpCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yOTY4Cj4gUmVwb3J0ZWQtYnk6IEVkbXVuZCBSYWlsZSA8
ZWRtdW5kLnJhaWxlQHByb3Rvbm1haWwuY29tPgo+IExpbms6Cj4gaHR0cHM6Ly9ub3NwYW1wcm94
eXdlYnAuYmVja2hvZmYuY29tL2VuUXNpZy9saW5rP2lkPUJBZ0FBQUFqOGMtV09OVnpmS2dBQUFE
bVJhV3ZfTl9hdndoOGEtRGwzTzRIM3BSOTY1bE9PS1ItNDN3VldmNTBXZFNvZTlCNFd2MmZxOGVt
S1RjYmVYeWU2OGJiYW50TzRmd2w2cTBiTjVOUlF4MTZZck95YnoyQ3VXSlR5ZnBLako1WXdodEh6
OTZxdWlSekd3QUlZQTNkVVhQNzZxN0FjUHlKNXlKSjRvczZMTjBkZEVIbVkxbTJZNkl3ZXlPd3Iz
NDFxNjBENkVwN3luajBIbGp1d2dMTHRhOWRBa1Q5QWdYMTBCcjlKaTM3XzI2a1UyTHh2R1ExCj4g
wqAKPiBUZXN0ZWQtYnk6IEVkbXVuZCBSYWlsZSA8ZWRtdW5kLnJhaWxlQHByb3Rvbm1haWwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IFRvbWl0YSBNb2VrbyA8dG9taXRhbW9la29AZ21haWwuY29tPgo+
IC0tLQo+IHYyOgo+ICogQWRkIFRlc3RlZC1ieSBmcm9tIEVkbXVuZCBSYWlsZS4gVGhhbmtzIGZv
ciB0aGUgY29udHJpYnV0aW9uLgo+ICogUmViYXNlZCBvbiB2ZmlvLW5leHQKPiAqIEZpeCB0eXBv
cy4KPiAKPiDCoGh3L3ZmaW8vaWdkLmMgfCAyMiArKysrKysrKysrLS0tLS0tLS0tLS0tCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vaWdkLmMgYi9ody92ZmlvL2lnZC5jCj4gaW5kZXggNWI2MzQxYzVi
Zi4uZTdhOWQxZmZjMSAxMDA2NDQKPiAtLS0gYS9ody92ZmlvL2lnZC5jCj4gKysrIGIvaHcvdmZp
by9pZ2QuYwo+IEBAIC0xODcsMjMgKzE4NywyMSBAQCBzdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2Rf
b3ByZWdpb25faW5pdChWRklPUENJRGV2aWNlCj4gKnZkZXYsCj4gwqB9Cj4gwqAKPiDCoHN0YXRp
YyBib29sIHZmaW9fcGNpX2lnZF9vcHJlZ2lvbl9kZXRlY3QoVkZJT1BDSURldmljZSAqdmRldiwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZmaW9fcmVnaW9uX2luZm8gKipvcHJl
Z2lvbiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXJyb3IgKiplcnJwKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmZpb19yZWdpb25faW5mbyAqKm9wcmVnaW9uKQo+IMKg
ewo+IMKgwqDCoMKgIGludCByZXQ7Cj4gwqAKPiAtwqDCoMKgIC8qIEhvdHBsdWdnaW5nIGlzIG5v
dCBzdXBwb3J0ZWQgZm9yIG9wcmVnaW9uIGFjY2VzcyAqLwo+IC3CoMKgwqAgaWYgKHZkZXYtPnBk
ZXYucWRldi5ob3RwbHVnZ2VkKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwg
IklHRCBPcFJlZ2lvbiBpcyBub3Qgc3VwcG9ydGVkIG9uIGhvdHBsdWdnZWQKPiBkZXZpY2UiKTsK
PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+IC3CoMKgwqAgfQo+IC0KPiDCoMKgwqDC
oCByZXQgPSB2ZmlvX2RldmljZV9nZXRfcmVnaW9uX2luZm9fdHlwZSgmdmRldi0+dmJhc2VkZXYs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWRklPX1JFR0lPTl9U
WVBFX1BDSV9WRU5ET1JfVFlQRSB8IFBDSV9WRU5ET1JfSURfSU5URUwsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWRklPX1JFR0lPTl9TVUJUWVBFX0lOVEVMX0lH
RF9PUFJFR0lPTiwgb3ByZWdpb24pOwo+IMKgwqDCoMKgIGlmIChyZXQpIHsKPiAtwqDCoMKgwqDC
oMKgwqAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkRldmljZSBkb2VzIG5vdCBzdXBwb3J0IElH
RCBPcFJlZ2lvbiBmZWF0dXJlIik7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiAr
wqDCoMKgIH0KPiArCj4gK8KgwqDCoCAvKiBIb3RwbHVnZ2luZyBpcyBub3Qgc3VwcG9ydGVkIGZv
ciBvcHJlZ2lvbiBhY2Nlc3MgKi8KPiArwqDCoMKgIGlmICh2ZGV2LT5wZGV2LnFkZXYuaG90cGx1
Z2dlZCkgewo+ICvCoMKgwqDCoMKgwqDCoCB3YXJuX3JlcG9ydCgiSUdEIGRldmljZSBkZXRlY3Rl
ZCwgYnV0IE9wUmVnaW9uIGlzIG5vdCBzdXBwb3J0ZWQgIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAib24gaG90cGx1Z2dlZCBkZXZpY2UuIik7Cj4gwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gQEAgLTUyNCw3ICs1MjIs
NyBAQCBzdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2RfY29uZmlnX3F1aXJrKFZGSU9QQ0lEZXZpY2Ug
KnZkZXYsCj4gRXJyb3IgKiplcnJwKQo+IMKgwqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgIC8qIElH
RCBkZXZpY2UgYWx3YXlzIGNvbWVzIHdpdGggT3BSZWdpb24gKi8KPiAtwqDCoMKgIGlmICghdmZp
b19wY2lfaWdkX29wcmVnaW9uX2RldGVjdCh2ZGV2LCAmb3ByZWdpb24sIGVycnApKSB7Cj4gK8Kg
wqDCoCBpZiAoIXZmaW9fcGNpX2lnZF9vcHJlZ2lvbl9kZXRlY3QodmRldiwgJm9wcmVnaW9uKSkg
ewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gwqDCoMKgwqAgfQo+IMKgwqDCoMKg
IGluZm9fcmVwb3J0KCJPcFJlZ2lvbiBkZXRlY3RlZCBvbiBJbnRlbCBkaXNwbGF5ICV4LiIsIHZk
ZXYtPmRldmljZV9pZCk7Cj4gQEAgLTY5NSw3ICs2OTMsNyBAQCBzdGF0aWMgYm9vbCB2ZmlvX3Bj
aV9rdm1ndF9jb25maWdfcXVpcmsoVkZJT1BDSURldmljZQo+ICp2ZGV2LCBFcnJvciAqKmVycnAp
Cj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDC
oMKgIGlmICghdmZpb19wY2lfaWdkX29wcmVnaW9uX2RldGVjdCh2ZGV2LCAmb3ByZWdpb24sIGVy
cnApKSB7Cj4gK8KgwqDCoCBpZiAoIXZmaW9fcGNpX2lnZF9vcHJlZ2lvbl9kZXRlY3QodmRldiwg
Jm9wcmVnaW9uKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgLyogU2hvdWxkIG5ldmVyIHJlYWNoIGhl
cmUsIEtWTUdUIGFsd2F5cyBlbXVsYXRlcyBPcFJlZ2lvbiAqLwo+IMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGZhbHNlOwo+IMKgwqDCoMKgIH0KClJldmlld2VkLWJ5OiBDb3J2aW4gS8O2aG5lIDxj
LmtvZWhuZUBiZWNraG9mZi5jb20+CgoKLS0gCktpbmQgcmVnYXJkcywKQ29ydmluCg==


--=-Fk7CZAljDB3SypbqgVKl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmg1bPYACgkQ2FTaVjFe
Ampp4hAAk9oq3EMqyOKl2iOMD7GL4a8Vi9xHfxL2HknH2RyU94ZhPlTxLTLi9aMk
pYAnOPssuPZdpDDCo9LSBpj0ClhT0ajXCaZM3YNFEDdtpC724f996vkswiI3WM4x
kRqSNiTEPq6KIldaC7noyIedK4lZqiH9vU+Jvxm23sAdRhDqylSMMJC1y2zE2AmL
IG27WeXTbk3ckRXjZNDk1560J8t2YRhyCGkzF/9AJZIer8o3SuYswh60iQVz9+Wd
qT/tMZCqDsl2N6lhhYc2A0MnMyygK+ntOv8Z98+tx4dQ1dg0EYUjTmdP6pbje/RP
Hd5crPaHno01UvjlUHJgDtoi4QhJHTX3cF0e3XA6HNryxxaLqXRvzQtLgrwslKHg
G72UT1TuwURvEtrhbt9IFWO+1bQfyIEtsVjmIo1yQgLJ8bV8wdU/YEg7wbDE1j0D
o2KKv5jObU/5lP4MuR0IIgr51EqxKiAZ9+am25nt5VpNcQDZ/oukoBfR2/3V8WQa
BVj/KSiOblGryDP7T0Bh75pPyTFjdnT1EMJa7I1pLejufc7StV/DJGt1fDLHQOjf
S6MUgA/Wo3iE9Xn8MbIggF0nzRqdXfkdyHVnhmncFXHYeDZx/bsOXWsaGzCp4CfP
hU3WM/H/URjDtrqLaxxmOr7wS033OCeQ+Mk3rO8hnbuFid4SCOQ=
=oxJF
-----END PGP SIGNATURE-----

--=-Fk7CZAljDB3SypbqgVKl--


