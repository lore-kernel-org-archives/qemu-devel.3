Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BFC369D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UJe-0000F6-8w; Wed, 23 Apr 2025 03:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UJc-0000Es-Qf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:14:40 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UJa-00006U-IP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:14:40 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1745392476; bh=AAH7DjyCyhC+wUnkICBjmUoHJWlzmBV4zr3dynBv7KA=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 rFKJCngjEXFgn6V8nmCIFRQMcstHwXjQNfKwC4B3pv46KMxYZT5kvs17rJ0sM9A2sXmWkDT1kBRLuqaoKEFVBg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1745392476; bh=AAH7DjyCyhC+wUnkICBjmUoHJWlzmBV4zr3dynBv7KA=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 Ee96tdOTZdpltizSNp/Bs6e+ICfU82BCRhdkxzmcJfnqZo6d5OWBBVZpR/mcbj2j4ADtajrAkLeUAydS4sFvbZUBd4vD0bl9kYCRYiY0QAvjRnh1RikZxlTsq/j3qtAemP9GrV7mXgj0nF4Caa30BO+Cpzc1NiJZ/UnUCmWmXwDlq8MuBOaESqLTBNGN9J3R8P4bPlB8OWzjjA6Ku5cxawxoOgV9/B4oUk57FjNeqoYZme3uQOJUwc+Xm+mvvjsDP3LaW68/XHTpW8ZHdnJT3khVzAN7asjYv3EezbSsX53ezMcL7BYwOfv84raXkaAlYN0qSfS4bjs2NQIBptwHsA==
Received: from 172.17.2.111 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Wed, 23 Apr 2025 07:14:35 GMT
Received: from ex06.beckhoff.com (172.17.5.171) by ex10.beckhoff.com
 (172.17.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Apr
 2025 09:13:23 +0200
Received: from ex04.beckhoff.com (172.17.5.170) by ex06.beckhoff.com
 (172.17.5.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 09:13:22 +0200
Received: from ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3]) by
 ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3%6]) with mapi id
 15.01.2507.039; Wed, 23 Apr 2025 09:13:22 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 08/11] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on
 Gen9+
Thread-Topic: [PATCH 08/11] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe
 on Gen9+
Thread-Index: AQHbstr7nrKyPzAiq0WfOU7KUJj0orOwtyUA
Date: Wed, 23 Apr 2025 07:13:22 +0000
Message-ID: <80e220ac7819902dcc1bb6a1974016a1d791346f.camel@beckhoff.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-9-tomitamoeko@gmail.com>
In-Reply-To: <20250421163112.21316-9-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-RqVFcOe6OLf8JSWp8PNQ"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-RqVFcOe6OLf8JSWp8PNQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDAwOjMxICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IE9uIEdlbjkgYW5kIGxhdGVyIElHRCBkZXZp
Y2VzLCBHTVMgMHhmMCB0byAweGZlIHJlcHJlc2VudHMgNE1CIHRvIDYwTUIKPiBwcmUtYWxsb2Nh
dGVkIG1lbW9yeSBzaXplIGluIDRNQiBpbmNyZW1lbnRzLiBBbGxvdyB1c2VycyBvdmVycmlkaW5n
Cj4gR01TIHdpdGggdGhlc2UgdmFsdWVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRvbWl0YSBNb2Vr
byA8dG9taXRhbW9la29AZ21haWwuY29tPgo+IC0tLQo+IMKgaHcvdmZpby9pZ2QuYyB8IDU5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9ody92ZmlvL2lnZC5jIGIvaHcvdmZpby9pZ2QuYwo+IGluZGV4IGUzZmY4NmQwZTYu
LmI3NDdmZGZhZWIgMTAwNjQ0Cj4gLS0tIGEvaHcvdmZpby9pZ2QuYwo+ICsrKyBiL2h3L3ZmaW8v
aWdkLmMKPiBAQCAtMzg3LDYgKzM4Nyw0NCBAQCBzdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2Rfc2V0
dXBfbHBjX2JyaWRnZShWRklPUENJRGV2aWNlCj4gKnZkZXYsIEVycm9yICoqZXJycCkKPiDCoMKg
wqDCoCByZXR1cm4gdHJ1ZTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2Rf
b3ZlcnJpZGVfZ21zKGludCBnZW4sIHVpbnQzMl90IGdtcywgdWludDMyX3QgKmdtY2gpCj4gK3sK
PiArwqDCoMKgIGJvb2wgcmV0ID0gZmFsc2U7Cj4gKwo+ICvCoMKgwqAgaWYgKGdlbiA9PSAtMSkg
ewo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIngtaWdkLWdtcyBpcyBub3Qgc3VwcG9y
dGVkIG9uIHRoaXMgZGV2aWNlIik7Cj4gK8KgwqDCoCB9IGVsc2UgaWYgKGdlbiA8IDgpIHsKPiAr
wqDCoMKgwqDCoMKgwqAgaWYgKGdtcyA8PSAweDEwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKmdtY2ggJj0gfihJR0RfR01DSF9HRU42X0dNU19NQVNLIDw8IElHRF9HTUNIX0dFTjZfR01T
X1NISUZUKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZ21jaCB8PSBnbXMgPDwgSUdEX0dN
Q0hfR0VONl9HTVNfU0hJRlQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gdHJ1ZTsK
PiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJv
cl9yZXBvcnQoUUVSUl9JTlZBTElEX1BBUkFNRVRFUl9WQUxVRSwgIngtaWdkLWdtcyIsCj4gIjB+
MHgxMCIpOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoCB9IGVsc2UgaWYgKGdlbiA9PSA4
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmICgoZ21zIDw9IDB4NDApKSB7CgpuaXQ6IHlvdSBjYW4g
cmVtb3ZlIGEgcGFyYW50aGVzZXMgcGFpci4KCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmdt
Y2ggJj0gfihJR0RfR01DSF9HRU44X0dNU19NQVNLIDw8IElHRF9HTUNIX0dFTjhfR01TX1NISUZU
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZ21jaCB8PSBnbXMgPDwgSUdEX0dNQ0hfR0VO
OF9HTVNfU0hJRlQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gdHJ1ZTsKPiArwqDC
oMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBv
cnQoUUVSUl9JTlZBTElEX1BBUkFNRVRFUl9WQUxVRSwgIngtaWdkLWdtcyIsCj4gIjB+MHg0MCIp
Owo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoCB9IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDC
oCAvKiAweDDCoCB0byAweDQwOiAzMk1CIGluY3JlbWVudHMgc3RhcnRpbmcgYXQgME1CICovCj4g
K8KgwqDCoMKgwqDCoMKgIC8qIDB4ZjAgdG8gMHhmZTogNE1CIGluY3JlbWVudHMgc3RhcnRpbmcg
YXQgNE1CICovCj4gK8KgwqDCoMKgwqDCoMKgIGlmICgoZ21zIDw9IDB4NDApIHx8IChnbXMgPj0g
MHhmMCAmJiBnbXMgPD0gMHhmZSkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZ21jaCAm
PSB+KElHRF9HTUNIX0dFTjhfR01TX01BU0sgPDwgSUdEX0dNQ0hfR0VOOF9HTVNfU0hJRlQpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpnbWNoIHw9IGdtcyA8PCBJR0RfR01DSF9HRU44X0dN
U19TSElGVDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB0cnVlOwo+ICvCoMKgwqDC
oMKgwqDCoCB9IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydChR
RVJSX0lOVkFMSURfUEFSQU1FVEVSX1ZBTFVFLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIngtaWdkLWdtcyIsICIwfjB4NDAgb3IgMHhmMH4weGZl
Iik7Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCByZXR1cm4g
cmV0Owo+ICt9Cj4gKwo+IMKgI2RlZmluZSBJR0RfR0dDX01NSU9fT0ZGU0VUwqDCoMKgwqAgMHgx
MDgwNDAKPiDCoCNkZWZpbmUgSUdEX0JEU01fTU1JT19PRkZTRVTCoMKgwqAgMHgxMDgwQzAKPiDC
oAo+IEBAIC01NzMsMjQgKzYxMSw5IEBAIHN0YXRpYyBib29sIHZmaW9fcGNpX2lnZF9jb25maWdf
cXVpcmsoVkZJT1BDSURldmljZQo+ICp2ZGV2LCBFcnJvciAqKmVycnApCj4gwqDCoMKgwqDCoCAq
IDMyTWlCLiBUaGlzIG9wdGlvbiBzaG91bGQgb25seSBiZSB1c2VkIHdoZW4gdGhlIGRlc2lyZWQg
c2l6ZSBjYW5ub3QgYmUKPiDCoMKgwqDCoMKgICogc2V0IGZyb20gRFZNVCBQcmUtQWxsb2NhdGVk
IG9wdGlvbiBpbiBob3N0IEJJT1MuCj4gwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqAgaWYgKHZkZXYt
PmlnZF9nbXMpIHsKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKGdlbiA8IDgpIHsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAodmRldi0+aWdkX2dtcyA8PSAweDEwKSB7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnbWNoICY9IH4oSUdEX0dNQ0hfR0VONl9HTVNfTUFTSyA8PCBJ
R0RfR01DSF9HRU42X0dNU19TSElGVCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnbWNoIHw9IHZkZXYtPmlnZF9nbXMgPDwgSUdEX0dNQ0hfR0VONl9HTVNfU0hJRlQ7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVycm9yX3JlcG9ydChRRVJSX0lOVkFMSURfUEFSQU1FVEVSX1ZBTFVFLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieC1p
Z2QtZ21zIiwgIjB+MHgxMCIpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKg
wqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodmRldi0+aWdk
X2dtcyA8PSAweDQwKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbWNoICY9
IH4oSUdEX0dNQ0hfR0VOOF9HTVNfTUFTSyA8PCBJR0RfR01DSF9HRU44X0dNU19TSElGVCk7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbWNoIHw9IHZkZXYtPmlnZF9nbXMgPDwg
SUdEX0dNQ0hfR0VOOF9HTVNfU0hJRlQ7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNl
IHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydChRRVJSX0lO
VkFMSURfUEFSQU1FVEVSX1ZBTFVFLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieC1pZ2QtZ21zIiwgIjB+MHg0MCIpOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqAgaWYgKHZk
ZXYtPmlnZF9nbXMgJiYKPiArwqDCoMKgwqDCoMKgwqAgIXZmaW9fcGNpX2lnZF9vdmVycmlkZV9n
bXMoZ2VuLCB2ZGV2LT5pZ2RfZ21zLCAmZ21jaCkpIHsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IGZhbHNlOwo+IMKgwqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgIGdtc19zaXplID0gaWdkX3N0b2xl
bl9tZW1vcnlfc2l6ZShnZW4sIGdtY2gpOwoKLS0gCktpbmQgcmVnYXJkcywKQ29ydmluCg==


--=-RqVFcOe6OLf8JSWp8PNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgIkxAACgkQ2FTaVjFe
AmqTXBAArGEnAZ7OO63Vjoy7nF7hdT60FG1AeBXNM950xNokrPiN9isblXwL4eoG
2JvUh2ddPnG4/xlnEPNNol3zYFNdJy4fa1I5F8t1t2g18nabYzjNUQdoROe36cOv
R5w+gQ3YYIGBidHETb0BB5/t5NLJIHysmY2PU6brIjUo7K8rIjT0Lv9nqe4PsPX7
IkUYBqsOl/k3i5xTOn//EiN6CPfDr9kbC9cjCu6TYZqGliaIdNMf7dcYhuhhNtBW
R5L5v3yNZOB+a60xrWT2W4mqY9613EiEUxlU/qZI1DJrOaypbDhU1r7BAngGPmnb
tUFDnkF8r5kzFk3PlQxYyCL6j9Tr1RfwR/IbL8yVw+ax1nfagahraV4g41ZqRrMr
pYnRCwAz+TSpQ51asBqo11lIh9lhwxBzUM91AQbI2qIYhoPmcaAMyyRp6QzxOv1H
WoL+W3OasW53bzgQwop0+Piqwe6lsoO62Z8FjSMZkSBw0FEKT6PiPJBhUc/NYp9v
yTk+JjBsJ/z2bZuABvzFx/19LeeFb7wNX0K8IoiVEUMiCMYOKzdM0XXme8M3iOVs
mVyTKzc1Kk+YwUoPlYm9i8CcTFhkFqT1hHPaaOq1pMMchI3UqTEPtoHpjL36OyRn
jkCB6yKvaZBg3oEvu+K3fjAKULjKUKbnwty0F1A3r9Hem87NEG0=
=xm0T
-----END PGP SIGNATURE-----

--=-RqVFcOe6OLf8JSWp8PNQ--


