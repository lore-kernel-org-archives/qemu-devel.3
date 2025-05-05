Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E139C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrZ7-0005zm-KS; Mon, 05 May 2025 04:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrZ6-0005zb-DR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:52:44 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrZ4-0003lJ-5I
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:52:44 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435160; bh=wpyMov9++6rxRc6oH+3MHfY1NHzm1X/IwAq5KlOmKCM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 93hr0+fmYIlk0dYNVfzm4X1sZuP72G9BoyVqHZ9mn4DXvpEuMFocMRJiYbS/el0+17AQKVapj3+3w+x3fBNADQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435160; bh=wpyMov9++6rxRc6oH+3MHfY1NHzm1X/IwAq5KlOmKCM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 rzfFR9MMR8mWEUwJmVyWSrk5uDuRRlRPjnldF2PwyJnFMI4tVkb4GNY2VjuB65I7JgXsfZrtwKZtreKqDhNtb+N4p4SPAZLLTF5nHZYeDNzYsLmaLTxlZccCg71P9m16SnnC5z9gavSeH5KEkmxrlcFlHIHqlSRE/94O/pSaw6HR3RP1qLa/pBpNYhMpXbdK1EkBYMfgXnPcVdQHOxOcjMykZfA3mHx345uORty7rhpEMykSK9ZYiORe0Tyj9rCI10Lu9py6HeKJQgf+D3aY27OrQTmCNfrml6PA3UY481j9rsxA0LNeqggbxPa9qqppSPV6E97PXuUPcIA8JC6XYA==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:52:39 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:52:38 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:52:38 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 7/9] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on
 Gen9+
Thread-Topic: [PATCH 7/9] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on
 Gen9+
Thread-Index: AQHbuFgcZVgSHMzEMkKudy3Ce8Vv2rPDo+EA
Date: Mon, 5 May 2025 08:52:38 +0000
Message-ID: <c2388b073646e225c749ca0ba454d96858ac7106.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-8-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-8-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-KzyiQqp11U+XTuXCLPjO"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
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

--=-KzyiQqp11U+XTuXCLPjO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDAwOjEwICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IE9uIEdlbjkgYW5kIGxhdGVyIElHRCBkZXZp
Y2VzLCBHTVMgMHhmMCB0byAweGZlIHJlcHJlc2VudHMgNE1CIHRvIDYwTUIKPiBwcmUtYWxsb2Nh
dGVkIG1lbW9yeSBzaXplIGluIDRNQiBpbmNyZW1lbnRzLiBBbGxvdyB1c2VycyBvdmVycmlkaW5n
Cj4gR01TIHdpdGggdGhlc2UgdmFsdWVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRvbWl0YSBNb2Vr
byA8dG9taXRhbW9la29AZ21haWwuY29tPgo+IC0tLQo+IMKgaHcvdmZpby9pZ2QuYyB8IDU5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9ody92ZmlvL2lnZC5jIGIvaHcvdmZpby9pZ2QuYwo+IGluZGV4IDQ5NmQzZGY1OTgu
LjdmMjg5YTYyYTMgMTAwNjQ0Cj4gLS0tIGEvaHcvdmZpby9pZ2QuYwo+ICsrKyBiL2h3L3ZmaW8v
aWdkLmMKPiBAQCAtNDExLDYgKzQxMSw0NCBAQCBzdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2Rfc2V0
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
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChnbXMgPD0gMHg0MCkgewo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICpnbWNoICY9IH4oSUdEX0dNQ0hfR0VOOF9HTVNfTUFTSyA8PCBJR0RfR01DSF9H
RU44X0dNU19TSElGVCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmdtY2ggfD0gZ21zIDw8
IElHRF9HTUNIX0dFTjhfR01TX1NISUZUOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZXJyb3JfcmVwb3J0KFFFUlJfSU5WQUxJRF9QQVJBTUVURVJfVkFMVUUsICJ4LWlnZC1nbXMi
LAo+ICIwfjB4NDAiKTsKPiArwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqAgfSBlbHNlIHsKPiAr
wqDCoMKgwqDCoMKgwqAgLyogMHgwwqAgdG8gMHg0MDogMzJNQiBpbmNyZW1lbnRzIHN0YXJ0aW5n
IGF0IDBNQiAqLwo+ICvCoMKgwqDCoMKgwqDCoCAvKiAweGYwIHRvIDB4ZmU6IDRNQiBpbmNyZW1l
bnRzIHN0YXJ0aW5nIGF0IDRNQiAqLwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoKGdtcyA8PSAweDQw
KSB8fCAoZ21zID49IDB4ZjAgJiYgZ21zIDw9IDB4ZmUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKmdtY2ggJj0gfihJR0RfR01DSF9HRU44X0dNU19NQVNLIDw8IElHRF9HTUNIX0dFTjhf
R01TX1NISUZUKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZ21jaCB8PSBnbXMgPDwgSUdE
X0dNQ0hfR0VOOF9HTVNfU0hJRlQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gdHJ1
ZTsKPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
cnJvcl9yZXBvcnQoUUVSUl9JTlZBTElEX1BBUkFNRVRFUl9WQUxVRSwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ4LWlnZC1nbXMiLCAiMH4weDQw
IG9yIDB4ZjB+MHhmZSIpOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoCB9Cj4gKwo+ICvC
oMKgwqAgcmV0dXJuIHJldDsKPiArfQo+ICsKPiDCoCNkZWZpbmUgSUdEX0dHQ19NTUlPX09GRlNF
VMKgwqDCoMKgIDB4MTA4MDQwCj4gwqAjZGVmaW5lIElHRF9CRFNNX01NSU9fT0ZGU0VUwqDCoMKg
IDB4MTA4MEMwCj4gwqAKPiBAQCAtNTkzLDI0ICs2MzEsOSBAQCBzdGF0aWMgYm9vbCB2ZmlvX3Bj
aV9pZ2RfY29uZmlnX3F1aXJrKFZGSU9QQ0lEZXZpY2UKPiAqdmRldiwgRXJyb3IgKiplcnJwKQo+
IMKgwqDCoMKgwqAgKiAzMk1pQi4gVGhpcyBvcHRpb24gc2hvdWxkIG9ubHkgYmUgdXNlZCB3aGVu
IHRoZSBkZXNpcmVkIHNpemUgY2Fubm90IGJlCj4gwqDCoMKgwqDCoCAqIHNldCBmcm9tIERWTVQg
UHJlLUFsbG9jYXRlZCBvcHRpb24gaW4gaG9zdCBCSU9TLgo+IMKgwqDCoMKgwqAgKi8KPiAtwqDC
oMKgIGlmICh2ZGV2LT5pZ2RfZ21zKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGlmIChnZW4gPCA4KSB7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZkZXYtPmlnZF9nbXMgPD0gMHgxMCkgewo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ21jaCAmPSB+KElHRF9HTUNIX0dFTjZf
R01TX01BU0sgPDwgSUdEX0dNQ0hfR0VONl9HTVNfU0hJRlQpOwo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ21jaCB8PSB2ZGV2LT5pZ2RfZ21zIDw8IElHRF9HTUNIX0dFTjZfR01T
X1NISUZUOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoUUVSUl9JTlZBTElEX1BBUkFNRVRFUl9W
QUxVRSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIngtaWdkLWdtcyIsICIwfjB4MTAiKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gLcKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHZkZXYtPmlnZF9nbXMgPD0gMHg0MCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ21jaCAmPSB+KElHRF9HTUNIX0dFTjhfR01TX01BU0sgPDwgSUdEX0dNQ0hfR0VOOF9H
TVNfU0hJRlQpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ21jaCB8PSB2ZGV2
LT5pZ2RfZ21zIDw8IElHRF9HTUNIX0dFTjhfR01TX1NISUZUOwo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9y
ZXBvcnQoUUVSUl9JTlZBTElEX1BBUkFNRVRFUl9WQUxVRSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIngtaWdkLWdtcyIsICIwfjB4
NDAiKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDCoMKgIH0KPiAr
wqDCoMKgIGlmICh2ZGV2LT5pZ2RfZ21zICYmCj4gK8KgwqDCoMKgwqDCoMKgICF2ZmlvX3BjaV9p
Z2Rfb3ZlcnJpZGVfZ21zKGdlbiwgdmRldi0+aWdkX2dtcywgJmdtY2gpKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBmYWxzZTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDCoCBnbXNfc2l6
ZSA9IGlnZF9zdG9sZW5fbWVtb3J5X3NpemUoZ2VuLCBnbWNoKTsKClJldmlld2VkLWJ5OiBDb3J2
aW4gS8O2aG5lIDxjLmtvZWhuZUBiZWNraG9mZi5jb20+CgoKLS0gCktpbmQgcmVnYXJkcywKQ29y
dmluCg==


--=-KzyiQqp11U+XTuXCLPjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYfFQACgkQ2FTaVjFe
AmqB2BAAvayx6mQ+FCG0180TwCsgI5wUC1gmPGGpGjHlMD44p4q2oKbGqK95ok+B
U1O39T6MKmPcn1tKQbSVjfzkGTaXHZ7PnA/i46PC5rzjHqX3u0zHtC+iJY1Ks1fO
CofI3hni1dTBY8G387ugEiN0tlMjCpOxz9zxzfGDa83rASMDP5CBxV9d9biqBQqd
Hhsj5MFSttAlf69pt13EJGHLJNUWu4eGnRl0/hwpssSyGxcnHfHitZvDQ+dBH6Qm
gb3UiQr+R6IFYdhIW/DRU8qzDN1wsoo7IgOUxflZyfov+Yd++yY1/NDFnu8hAoT0
h5H+dR+tenwLHSam27173lvkDWsMQauoLcWuH06j4YMEyjD6CGWypYGhFbaooDBp
/AgJJr2NKgrtE7vxC7Rgf+boNq/Yju/cwE3Eab17qfPVq2FLnImIE535FlgBnH+n
dg/1pXIDBzQY+9pAIhdIOa0waivtr+fkrWe+I9PJHgbosuhMiWsFva1dWE2H8QTe
hfkxqa6Zkqd/0AwVr3RF1LpBfmcBqNI2nh3pVFtKozsT5Ot/LDj719s+cSvh5qxT
vMX6mo1qnaCgHwnSACHR6kvy03AqYASQKQjo1WFHA7d+/V1OYDZSqwudiz8iEzf7
7IC6ta+MrcD7crPQQ80zDLSQICOQ7pejKzv2oHLC+NS9kSj255o=
=k7da
-----END PGP SIGNATURE-----

--=-KzyiQqp11U+XTuXCLPjO--


