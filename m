Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1290CD78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7B9-0008Cm-Ti; Mon, 02 Dec 2024 09:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2ys-0005LE-Vl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:44:39 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2yq-0006n8-V3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:44:38 -0500
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 09:44:33 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733132673; bh=ZHm57GGY5XBx4rN/vOhNS9uxgD2GxC/q7D+VwS6/jaE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 tc7hpSdJUDvRuxJphK2uZZsjXtjpjzXpR9tqo474dUrnW7iC9JuwucSoFCpIoBd9rrqMeSfo20I9rXz1jDA4Cg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733132673; bh=ZHm57GGY5XBx4rN/vOhNS9uxgD2GxC/q7D+VwS6/jaE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 t7XFvEJU5sIRJpp//b40pPPtqc6T2AxPy1XvZI7Hm6HLYNmuAkvW0+GE9TyoLjgUi+Znt5uGg9ZRwFJ4aXgPD1J5+TRiURhKor43j/B7kGuVe719X0YXSmjHNzuHvgmmY2Gi9TRAurQKygsAfqK87bReLyMZrjdcMXsNLN/6Rv2Qd9HyJ1CyOvkg7sEmAe2pzh75oNUW7krq/NllaAhKCZgEIbBIb7YjPqa1bn9zPD1+21RwCPN+W/JT/i5T7+8Mb9PAZRzwTc5YV4biy9n/q/1V5JTScVrhyNl5zUQe1lBbVtXopTiN1PTfGounx69zhX+VH+bSdYcQOAxqkVnW+A==
Received: from ex04.beckhoff.com (172.17.5.170) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 10:44:32 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 10:44:32 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 7/8] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Thread-Topic: [PATCH 7/8] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Thread-Index: AQHbRAt990ufnNPokkm98yjl3zmZ5bLSpLkA
Date: Mon, 2 Dec 2024 09:44:32 +0000
Message-ID: <483493629a375a9e35308527ffe0d8887b413111.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-8-tomitamoeko@gmail.com>
In-Reply-To: <20241201160938.44355-8-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.225]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-5UrqnThG953bpGdDJEZi"
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
X-Mailman-Approved-At: Mon, 02 Dec 2024 09:13:31 -0500
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

--=-5UrqnThG953bpGdDJEZi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI0LTEyLTAyIGF0IDAwOjA5ICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IEEgcmVjZW50IGNvbW1pdCBpbiBpOTE1IGRy
aXZlciBbMV0gY2xhaW1zIHRoZSBCRFNNIHJlZ2lzdGVyIGF0IDB4MTA4MGMwCj4gb2YgbW1pbyBi
YXIwIGhhcyBiZWVuIHRoZXJlIHNpbmNlIGdlbiA2LiBNaXJyb3IgdGhpcyByZWdpc3RlciB0byB0
aGUgMzIKPiBiaXQgQkRTTSByZWdpc3RlciBhdCAweDVjIGluIHBjaSBjb25maWcgc3BhY2UgZm9y
IGdlbjYtMTAgZGV2aWNlcy4KPiAKPiBbMV0KPiBodHRwczovL25vc3BhbXByb3h5d2VicC5iZWNr
aG9mZi5jb20vZW5Rc2lnL2xpbms/aWQ9QkFnQUFBQWk5NkJkTWNKVjdya0FBQUJ5NEwzWS1uMUg0
TTVFcmszdG9aZE1PbWhGbWM0SFVwandfWUctRzQtR2N3bVZkUzh3Q19wVXlLSDZwN3g5X08tNkhw
cnZ5djltYmJXaF9qMnc1RTZ6TEFyUzNjckMxMTU0YUVZVFJGY3JJQkxQTUlvRUF2OWlURVJYRTJY
QjBFMjYwTzNwa21tbzFVSk9NVWhiX2ZJNU9VVDMtNjhqbmtxNFF3VE5nYm53bWJWUm5MMkF5QU0x
cGp1WnFvcVA2R1A5eTVlNk9nb2NXLUJKcDBRdEhPM2VQOU5icVR1ZmlmQUFNZktsVTdla0FaTFdm
UHplanRxd2F3Mgo+IMKgCj4gCj4gU2lnbmVkLW9mZi1ieTogVG9taXRhIE1vZWtvIDx0b21pdGFt
b2Vrb0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBody92ZmlvL2lnZC5jIHwgMjYgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lnZC5jIGIvaHcvdmZpby9pZ2Qu
Ywo+IGluZGV4IDA3NzAwZGNlMzAuLjNmZDgyMjI0MWQgMTAwNjQ0Cj4gLS0tIGEvaHcvdmZpby9p
Z2QuYwo+ICsrKyBiL2h3L3ZmaW8vaWdkLmMKPiBAQCAtNDgyLDcgKzQ4Miw4IEBAIHN0YXRpYyBj
b25zdCBNZW1vcnlSZWdpb25PcHMgdmZpb19pZ2RfcXVpcmtfbWlycm9yXyMjbmFtZSA9IHvCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcCj4gwqB9Owo+IMKgCj4gwqBWRklPX0lHRF9RVUlSS19NSVJST1Jf
UkVHKElHRF9HTUNILCBnZ2MpCj4gLVZGSU9fSUdEX1FVSVJLX01JUlJPUl9SRUcoSUdEX0JEU01f
R0VOMTEsIGJkc20pCj4gK1ZGSU9fSUdEX1FVSVJLX01JUlJPUl9SRUcoSUdEX0JEU00sIGJkc20p
Cj4gK1ZGSU9fSUdEX1FVSVJLX01JUlJPUl9SRUcoSUdEX0JEU01fR0VOMTEsIGJkc202NCkKPiDC
oAo+IMKgdm9pZCB2ZmlvX3Byb2JlX2lnZF9iYXIwX3F1aXJrKFZGSU9QQ0lEZXZpY2UgKnZkZXYs
IGludCBucikKPiDCoHsKPiBAQCAtNTA2LDcgKzUwNyw3IEBAIHZvaWQgdmZpb19wcm9iZV9pZ2Rf
YmFyMF9xdWlyayhWRklPUENJRGV2aWNlICp2ZGV2LCBpbnQgbnIpCj4gwqDCoMKgwqDCoCAqIGlu
dG8gTU1JTyBzcGFjZSBhbmQgcmVhZCBmcm9tIE1NSU8gc3BhY2UgYnkgdGhlIFdpbmRvd3MgZHJp
dmVyLgo+IMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoCBnZW4gPSBpZ2RfZ2VuKHZkZXYpOwo+IC3C
oMKgwqAgaWYgKGdlbiA8IDExKSB7Cj4gK8KgwqDCoCBpZiAoZ2VuIDwgNikgewoKVGhpcyBhbHNv
IGNhdXNlcyB0aGUgR0dDIHJlZ2lzdGVyIHRvIGJlIG1pcnJvcmVkIGZvciBnZW4gNiBhbmQgbGF0
ZXIuIElzIHRoaXMgaW50ZW5kZWQ/IElmIHNvLCB5b3UKc2hvdWxkIG1lbnRpb24gaXQgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlIGFzIHdlbGwuCgo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IMKg
wqDCoMKgIH0KPiDCoAo+IEBAIC01MjAsMTIgKzUyMSwyMSBAQCB2b2lkIHZmaW9fcHJvYmVfaWdk
X2JhcjBfcXVpcmsoVkZJT1BDSURldmljZSAqdmRldiwgaW50IG5yKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIElHRF9HR0NfTU1JT19PRkZTRVQsICZxdWlyay0+bWVtWzBdLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDEpOwo+IMKgCj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfaW8o
JnF1aXJrLT5tZW1bMV0sIE9CSkVDVCh2ZGV2KSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnZmaW9faWdkX3F1aXJrX21pcnJvcl9iZHNtLCB2
ZGV2LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAidmZpby1pZ2QtYmRzbS1xdWlyayIsIDgpOwo+IC3CoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRf
c3VicmVnaW9uX292ZXJsYXAodmRldi0+YmFyc1swXS5yZWdpb24ubWVtLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsICZxdWlyay0+bWVtWzFdLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMSk7Cj4gK8KgwqDCoCBpZiAoZ2VuIDwgMTEpIHsKPiArwqDCoMKg
wqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZxdWlyay0+bWVtWzFdLCBPQkpFQ1QodmRl
diksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgJnZmaW9faWdkX3F1aXJrX21pcnJvcl9iZHNtLCB2ZGV2LAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ2ZmlvLWln
ZC1iZHNtLXF1aXJrIiwgNCk7Cj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbl9vdmVybGFwKHZkZXYtPmJhcnNbMF0ucmVnaW9uLm1lbSwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZxdWlyay0+bWVtWzFdLCAxKTsKPiArwqDCoMKgIH0gZWxzZSB7Cj4g
K8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcXVpcmstPm1lbVsxXSwgT0JK
RUNUKHZkZXYpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZ2ZmlvX2lnZF9xdWlya19taXJyb3JfYmRzbTY0LCB2ZGV2LAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJ2ZmlvLWlnZC1iZHNtLXF1aXJrIiwgOCk7Cj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdp
b25fYWRkX3N1YnJlZ2lvbl9vdmVybGFwKHZkZXYtPmJhcnNbMF0ucmVnaW9uLm1lbSwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZxdWlyay0+bWVtWzFdLCAxKTsKPiArwqDCoMKgIH0K
PiDCoAo+IMKgwqDCoMKgIFFMSVNUX0lOU0VSVF9IRUFEKCZ2ZGV2LT5iYXJzW25yXS5xdWlya3Ms
IHF1aXJrLCBuZXh0KTsKPiDCoH0KCi0tIApLaW5kIHJlZ2FyZHMsCkNvcnZpbgpkaXNhYmxlLWRp
c2NsYWltZXItQkFERQoKCgo=


--=-5UrqnThG953bpGdDJEZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNgYEACgkQ2FTaVjFe
AmoY3A/8Dd9XXg/69Pb4iKE89Y3vRqykbzLKVMbhr3i3k0Pgl9FdJVimrsUyXw0D
leYpgrgU1zRJRiqdwmtGPFgf9rNPrJC8Yzwsnxh+L053qzv7VjbBmcCDcahouN80
lTAkdFd3DOW8x2b9wryvfxUd5gSegZOh2IWGurXzE7uKurLqfnbYYQd114WXkcLI
uJVgVWdz3BHhEEDVqbZsDWKuW3kKgsPkkTzS8tlmYI8SOooqGZPg00U518wn+bf5
qzgUFB8AhK8EmnwyLkkOZxzK7DBjwsFrDsKVFr+D466l6hFYqgMGqtQPad7IHVFs
/5OecLtib6u/c/7HC9xIW9+dqllI66uAvbFfI0UwQNwAbVQFdWl8D2FeRFOclnyt
080cpLrUdUf0mMpDkmFmIRl/ZPRCUouIVJTzb0EQFA1bfIuLnp9H/Gginy6VRioX
IcvHoNt/1sncJNallK8SFT03fQjpJ5EfAapj7PBfRYgw3J5GESzqYRvwCttdnqUH
oqkYEB3QhP/MNkFucxQ7Mkql4b8UMpeZKViknOeMF7+u+e8xLRf0Wszce7UrImbX
mjkn1LRoRQ/4zancIEvPNT5SWDmkUySMaxZFUNiNrogAJTaXAjyzBVBfnQIip1jc
VAhb5yI802DzMdceuUCzWEIrkrbGpC9J/z4CCsw3KfBCcIDOTvs=
=49rD
-----END PGP SIGNATURE-----

--=-5UrqnThG953bpGdDJEZi--


