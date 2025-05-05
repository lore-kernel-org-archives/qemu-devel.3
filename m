Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD8FC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrS4-0001Eo-Fk; Mon, 05 May 2025 04:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrRt-00014v-Ts
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:45:20 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrRr-0002rA-Hj
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:45:17 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746434713; bh=/ueo8tdh6x5mTSDQ4Z/tSfhLCbItQJCoKsdRcQYODRc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 mE/ReVGa2hgRbL7Kra22a/II+58lPzTmFsLj6iLm4Q1ElJoXeQuvgO+/VX0W8dJVq2lC23AXYK6vyPTlx+bRBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746434713; bh=/ueo8tdh6x5mTSDQ4Z/tSfhLCbItQJCoKsdRcQYODRc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 BETi+AECbNppRwKLM/nmcLjcQT8jc63rJ/nCfTyJenOChyHqSPY9QaDDnuBfaIN6s7Et4sRVnDX6UZSO5UqQEr4koCLaeD8KaiQ1+PL4S/dcBQUTySHTaBA5lLvXmUmsBTXsS/xQDr1/pVdbMq6alnI3LB0h1Hi0WF6WB4Ue5ykUcbya7YqJgDTcXEBo7DVGbmIQ31K54440CQkvRlUscF37CtqPdA3SxJiDlgaj2GvbaI7gIeJUQd0y5Fwnaj3i5RFlITaeL5KGU/7G2wOMLDAEi1bAT1pPgWlZH4+4xDtPqqi+z8C+iwIDi5iIC6QuLu6W6FslkDozfken1wMuXQ==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:45:13 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:45:11 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:45:11 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/9] vfio/igd: Detect IGD device by OpRegion
Thread-Topic: [PATCH 3/9] vfio/igd: Detect IGD device by OpRegion
Thread-Index: AQHbuFgSyAuAXynkYkS8+ipeFGZewLPDoc0A
Date: Mon, 5 May 2025 08:45:11 +0000
Message-ID: <606c1dbdb133be7e86b1bf41768705a8e070dd71.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-4-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-4-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-5087DLFBDUgQy3dEQTcQ"
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

--=-5087DLFBDUgQy3dEQTcQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDAwOjA5ICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IFRoZXJlIGlzIGN1cnJlbnRseSBubyBzdHJh
aWdodGZvcndhcmQgd2F5IHRvIGRpc3Rpbmd1aXNoIGlmIGEgSW50ZWwKPiBncmFwaGljcyBkZXZp
Y2UgaXMgSUdEIG9yIGRpc2NyZXRlIEdQVS4gSG93ZXZlciwgb25seSBJR0QgZGV2aWNlcyBoYXZl
Cj4gT3BSZWdpb24uIFVzZSB0aGUgcHJlc2VuY2Ugb2YgVkZJT19SRUdJT05fU1VCVFlQRV9JTlRF
TF9JR0RfT1BSRUdJT04KPiB0byBpZGVudGlmeSBJR0QgZGV2aWNlcy4gU3RpbGwsIE9wUmVnaW9u
IG9uIGhvdHBsdWdnZWQgSUdEIGRldmljZSBpcwo+IG5vdCBzdXBwb3J0ZWQuCj4gCj4gU2lnbmVk
LW9mZi1ieTogVG9taXRhIE1vZWtvIDx0b21pdGFtb2Vrb0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBo
dy92ZmlvL2lnZC5jIHwgMzAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vaWdkLmMgYi9ody92ZmlvL2lnZC5jCj4gaW5kZXggYWUxOTQ1NjQ1Ny4u
ZDY4ODBjYmZmNyAxMDA2NDQKPiAtLS0gYS9ody92ZmlvL2lnZC5jCj4gKysrIGIvaHcvdmZpby9p
Z2QuYwo+IEBAIC0xODUsOSArMTg1LDEwIEBAIHN0YXRpYyBib29sIHZmaW9fcGNpX2lnZF9vcHJl
Z2lvbl9pbml0KFZGSU9QQ0lEZXZpY2UKPiAqdmRldiwKPiDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsK
PiDCoH0KPiDCoAo+IC1zdGF0aWMgYm9vbCB2ZmlvX3BjaV9pZ2Rfc2V0dXBfb3ByZWdpb24oVkZJ
T1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQo+ICtzdGF0aWMgYm9vbCB2ZmlvX3BjaV9p
Z2Rfb3ByZWdpb25fZGV0ZWN0KFZGSU9QQ0lEZXZpY2UgKnZkZXYsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCB2ZmlvX3JlZ2lvbl9pbmZvICoqb3ByZWdpb24sCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJycCkKPiDCoHsKPiAtwqDCoMKgIGdfYXV0b2ZyZWUg
c3RydWN0IHZmaW9fcmVnaW9uX2luZm8gKm9wcmVnaW9uID0gTlVMTDsKPiDCoMKgwqDCoCBpbnQg
cmV0Owo+IMKgCj4gwqDCoMKgwqAgLyogSG90cGx1Z2dpbmcgaXMgbm90IHN1cHBvcnRlZCBmb3Ig
b3ByZWdpb24gYWNjZXNzICovCj4gQEAgLTE5OCwxNyArMTk5LDEzIEBAIHN0YXRpYyBib29sIHZm
aW9fcGNpX2lnZF9zZXR1cF9vcHJlZ2lvbihWRklPUENJRGV2aWNlCj4gKnZkZXYsIEVycm9yICoq
ZXJycCkKPiDCoAo+IMKgwqDCoMKgIHJldCA9IHZmaW9fZGV2aWNlX2dldF9yZWdpb25faW5mb190
eXBlKCZ2ZGV2LT52YmFzZWRldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFZGSU9fUkVHSU9OX1RZUEVfUENJX1ZFTkRPUl9UWVBFIHwgUENJX1ZFTkRPUl9JRF9J
TlRFTCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVkZJT19SRUdJ
T05fU1VCVFlQRV9JTlRFTF9JR0RfT1BSRUdJT04sICZvcHJlZ2lvbik7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZGSU9fUkVHSU9OX1NVQlRZUEVfSU5URUxfSUdE
X09QUkVHSU9OLCBvcHJlZ2lvbik7Cj4gwqDCoMKgwqAgaWYgKHJldCkgewo+IMKgwqDCoMKgwqDC
oMKgwqAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJEZXZpY2UgZG9lcyBub3Qgc3VwcG9ydHMg
SUdEIE9wUmVnaW9uIGZlYXR1cmUiKTsKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsK
PiDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDCoMKgIGlmICghdmZpb19wY2lfaWdkX29wcmVnaW9uX2lu
aXQodmRldiwgb3ByZWdpb24sIGVycnApKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsKPiAtwqDCoMKgIH0KPiAtCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gwqB9Cj4gwqAKPiBA
QCAtNDc5LDYgKzQ3Niw3IEBAIHZvaWQgdmZpb19wcm9iZV9pZ2RfYmFyMF9xdWlyayhWRklPUENJ
RGV2aWNlICp2ZGV2LCBpbnQKPiBucikKPiDCoAo+IMKgc3RhdGljIGJvb2wgdmZpb19wY2lfaWdk
X2NvbmZpZ19xdWlyayhWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApCj4gwqB7Cj4g
K8KgwqDCoCBnX2F1dG9mcmVlIHN0cnVjdCB2ZmlvX3JlZ2lvbl9pbmZvICpvcHJlZ2lvbiA9IE5V
TEw7Cj4gwqDCoMKgwqAgaW50IHJldCwgZ2VuOwo+IMKgwqDCoMKgIHVpbnQ2NF90IGdtc19zaXpl
Owo+IMKgwqDCoMKgIHVpbnQ2NF90ICpiZHNtX3NpemU7Cj4gQEAgLTQ4NiwxNiArNDg0LDE3IEBA
IHN0YXRpYyBib29sIHZmaW9fcGNpX2lnZF9jb25maWdfcXVpcmsoVkZJT1BDSURldmljZQo+ICp2
ZGV2LCBFcnJvciAqKmVycnApCj4gwqDCoMKgwqAgYm9vbCBsZWdhY3lfbW9kZV9lbmFibGVkID0g
ZmFsc2U7Cj4gwqDCoMKgwqAgRXJyb3IgKmVyciA9IE5VTEw7Cj4gwqAKPiAtwqDCoMKgIC8qCj4g
LcKgwqDCoMKgICogVGhpcyBtdXN0IGJlIGFuIEludGVsIFZHQSBkZXZpY2UgYXQgYWRkcmVzcyAw
MDowMi4wIGZvciB1cyB0byBldmVuCj4gLcKgwqDCoMKgICogY29uc2lkZXIgZW5hYmxpbmcgbGVn
YWN5IG1vZGUuwqAgVGhlIHZCSU9TIGhhcyBkZXBlbmRlbmNpZXMgb24gdGhlCj4gLcKgwqDCoMKg
ICogUENJIGJ1cyBhZGRyZXNzLgo+IC3CoMKgwqDCoCAqLwo+IMKgwqDCoMKgIGlmICghdmZpb19w
Y2lfaXModmRldiwgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0FOWV9JRCkgfHwKPiDCoMKgwqDC
oMKgwqDCoMKgICF2ZmlvX2lzX3ZnYSh2ZGV2KSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHRydWU7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gK8KgwqDCoCAvKiBJR0QgZGV2aWNlIGFsd2F5cyBj
b21lcyB3aXRoIE9wUmVnaW9uICovCj4gK8KgwqDCoCBpZiAoIXZmaW9fcGNpX2lnZF9vcHJlZ2lv
bl9kZXRlY3QodmRldiwgJm9wcmVnaW9uLCBlcnJwKSkgewo+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gdHJ1ZTsKPiArwqDCoMKgIH0KPiArwqDCoMKgIGluZm9fcmVwb3J0KCJPcFJlZ2lvbiBkZXRl
Y3RlZCBvbiBJbnRlbCBkaXNwbGF5ICV4LiIsIHZkZXYtPmRldmljZV9pZCk7Cj4gKwo+IMKgwqDC
oMKgIC8qCj4gwqDCoMKgwqDCoCAqIElHRCBpcyBub3QgYSBzdGFuZGFyZCwgdGhleSBsaWtlIHRv
IGNoYW5nZSB0aGVpciBzcGVjcyBvZnRlbi7CoCBXZQo+IMKgwqDCoMKgwqAgKiBvbmx5IGF0dGVt
cHQgdG8gc3VwcG9ydCBiYWNrIHRvIFNhbmRCcmlkZ2UgYW5kIHdlIGhvcGUgdGhhdCBuZXdlcgo+
IEBAIC01NzEsNyArNTcwLDcgQEAgc3RhdGljIGJvb2wgdmZpb19wY2lfaWdkX2NvbmZpZ19xdWly
ayhWRklPUENJRGV2aWNlICp2ZGV2LAo+IEVycm9yICoqZXJycCkKPiDCoAo+IMKgwqDCoMKgIC8q
IFNldHVwIE9wUmVnaW9uIGFjY2VzcyAqLwo+IMKgwqDCoMKgIGlmICgodmRldi0+ZmVhdHVyZXMg
JiBWRklPX0ZFQVRVUkVfRU5BQkxFX0lHRF9PUFJFR0lPTikgJiYKPiAtwqDCoMKgwqDCoMKgwqAg
IXZmaW9fcGNpX2lnZF9zZXR1cF9vcHJlZ2lvbih2ZGV2LCBlcnJwKSkgewo+ICvCoMKgwqDCoMKg
wqDCoCAhdmZpb19wY2lfaWdkX29wcmVnaW9uX2luaXQodmRldiwgb3ByZWdpb24sIGVycnApKSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+IMKgwqDCoMKgIH0KPiDCoAo+IEBAIC02
NzEsOCArNjcwLDExIEBAIGVycm9yOgo+IMKgICovCj4gwqBzdGF0aWMgYm9vbCB2ZmlvX3BjaV9r
dm1ndF9jb25maWdfcXVpcmsoVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQo+IMKg
ewo+ICvCoMKgwqAgZ19hdXRvZnJlZSBzdHJ1Y3QgdmZpb19yZWdpb25faW5mbyAqb3ByZWdpb24g
PSBOVUxMOwo+ICsKPiDCoMKgwqDCoCBpZiAoKHZkZXYtPmZlYXR1cmVzICYgVkZJT19GRUFUVVJF
X0VOQUJMRV9JR0RfT1BSRUdJT04pICYmCj4gLcKgwqDCoMKgwqDCoMKgICF2ZmlvX3BjaV9pZ2Rf
c2V0dXBfb3ByZWdpb24odmRldiwgZXJycCkpIHsKPiArwqDCoMKgwqDCoMKgwqAgKCF2ZmlvX3Bj
aV9pZ2Rfb3ByZWdpb25fZGV0ZWN0KHZkZXYsICZvcHJlZ2lvbiwgZXJycCkgfHwKPiArwqDCoMKg
wqDCoMKgwqDCoCAhdmZpb19wY2lfaWdkX29wcmVnaW9uX2luaXQodmRldiwgb3ByZWdpb24sIGVy
cnApKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+IMKgwqDCoMKgIH0KPiDC
oAoKUmV2aWV3ZWQtYnk6IENvcnZpbiBLw7ZobmUgPGMua29laG5lQGJlY2tob2ZmLmNvbT4KCgot
LSAKS2luZCByZWdhcmRzLApDb3J2aW4K


--=-5087DLFBDUgQy3dEQTcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYepYACgkQ2FTaVjFe
AmoAlQ/8CXL/AgjTCQJ3dh6ffITS9Xld9ORXUBGpHFH7QKYThkEE8dxgdAKaSA1l
QIsG9BEOQQILq7GlZj39cW6YdCQr5xNNZXKyFYb4C7a1EZQhvJzGOFCmSxCkh2Q7
FQxh2R4VXYXmcL6scf3ZdH9eMtI4ELtycxv7VG2IWkyoIMImhNV6Ybu6pjwgjTTQ
3e8HMRnOBjkbH/t7HGuMLvP7kKfwpgulCpSxxvytvn2ZoPZQkNPPicKo79+CJcSJ
CZ2OobvY2BpRPYBiey8pJd2Dys5/lNR2wSr9K7IIcSDFOY93aNINu7WDby+tbFxG
Y1JCKQbIGLcOKyDr8/rBvuZtPyglZM3/sjXt3NskuU85hNAXOW+lUDmflIeg8kXz
NBNiZLdco/ElQG3ztTPssl79ss7vDrlPSU5WSe8qwtuq7Qn9nmhBKqw33GZL6PK5
WV+AzNYeTeyyMbE+FYyj9MZG85/Ymz8fbvYl0oLbkwaRowxdQxrsb0sbuz+pfqZa
JKsHYByF3uABF4YUOcdiSXhqVORaQcPAYuj4e9miXuPrhEDw6f5UK9KD9O/ovFRg
OYR8LD5xiUkzOaTl2T1kacpyYYIKLF2PqrQzaKgnctpfc2mR17DYbWKtnJDKa6US
kTEhrbh63on91M+mHpXWNF/RrtexzPAPOCgFh/6Dtj7E3wiSwRI=
=5ffo
-----END PGP SIGNATURE-----

--=-5087DLFBDUgQy3dEQTcQ--


