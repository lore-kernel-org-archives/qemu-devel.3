Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B251C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrca-0007YE-Au; Mon, 05 May 2025 04:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrcU-0007VI-7T
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:56:17 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrcR-0004Mh-AY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:56:13 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435369; bh=8BzuENbKShH3AHbcavHN++ZSC7NBz5ZnJh4xW1NaCOI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 n9FObu3hr3BHj2f3CnFceXDHwMuK1XZImMvMBXPPTxVf5FVGoPLfJb2xbnCC/QPthn8/yNUp5jKIKSxmEIXNAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435369; bh=8BzuENbKShH3AHbcavHN++ZSC7NBz5ZnJh4xW1NaCOI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 WKqKGGayVN7E41DY7sxojDIpXUu2lmvYWaJj5h4AIltO2I8vk31ZlvUcKSyXCohwAkFV0ae2Nd34rkfN3W9jE67f+Cpxyj3+O/UhKO+uYXJ1hA0mvO6AUTG04xutsEns2BDnYwQAzBZDMcAAjKurzC7eZje0fh/236aktQP0eQJE5fpdww5VFwSLpr+aX2dPumTkykrsrxatXQCBSh55SqIjddqEc/5ZQB94zGYttAwyC7vm/sLse1ED/VDSCUk5brsqXk0+02uW51pZIOBmHo/UwOCGC/bOAi28nnnWZ7rvrcTjHn5jVeJP7xTtYV4GCJDJj994B/Z6BD3zyPvtOQ==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:56:08 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:56:07 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:56:07 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms is
 set
Thread-Topic: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms
 is set
Thread-Index: AQHbuFgfypfvonHOrUuwJtuFtfUFZrPDpNqA
Date: Mon, 5 May 2025 08:56:07 +0000
Message-ID: <014ada7ee85d82257bdc8fd9cce5818b66fcb54c.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-9-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-9-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-jOIBVtBU1P7x6M4aYnYL"
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

--=-jOIBVtBU1P7x6M4aYnYL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDAwOjEwICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IHgtaWdkLWdtcyBpcyB1c2VkIGZvciBvdmVy
cmlkaW5nIERTTSByZWdpb24gc2l6ZSBpbiBHR0MgcmVnaXN0ZXIgaW4KPiBib3RoIGNvbmZpZyBz
cGFjZSBhbmQgTU1JTyBCQVIwLCBieSBkZWZhdWx0IGhvc3QgdmFsdWUgaXMgdXNlZC4KPiBUaGVy
ZSBpcyBubyBuZWVkIHRvIGVtdWxhdGUgaXQgaW4gZGVmYXVsdCBjYXNlLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IFRvbWl0YSBNb2VrbyA8dG9taXRhbW9la29AZ21haWwuY29tPgo+IC0tLQo+IMKgaHcv
dmZpby9pZ2QuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9pZ2QuYyBiL2h3L3ZmaW8vaWdkLmMKPiBp
bmRleCA3ZjI4OWE2MmEzLi41ZDEyZjc1M2FiIDEwMDY0NAo+IC0tLSBhL2h3L3ZmaW8vaWdkLmMK
PiArKysgYi9ody92ZmlvL2lnZC5jCj4gQEAgLTQ3NywyMiArNDc3LDI0IEBAIHZvaWQgdmZpb19w
cm9iZV9pZ2RfYmFyMF9xdWlyayhWRklPUENJRGV2aWNlICp2ZGV2LCBpbnQKPiBucikKPiDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsKPiDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDCoMKgIGdnY19xdWly
ayA9IHZmaW9fcXVpcmtfYWxsb2MoMSk7Cj4gLcKgwqDCoCBnZ2NfbWlycm9yID0gZ2djX3F1aXJr
LT5kYXRhID0gZ19tYWxsb2MwKHNpemVvZigqZ2djX21pcnJvcikpOwo+IC3CoMKgwqAgZ2djX21p
cnJvci0+bWVtID0gZ2djX3F1aXJrLT5tZW07Cj4gLcKgwqDCoCBnZ2NfbWlycm9yLT52ZGV2ID0g
dmRldjsKPiAtwqDCoMKgIGdnY19taXJyb3ItPmJhciA9IG5yOwo+IC3CoMKgwqAgZ2djX21pcnJv
ci0+b2Zmc2V0ID0gSUdEX0dHQ19NTUlPX09GRlNFVDsKPiAtwqDCoMKgIGdnY19taXJyb3ItPmNv
bmZpZ19vZmZzZXQgPSBJR0RfR01DSDsKPiAtCj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRf
aW8oZ2djX21pcnJvci0+bWVtLCBPQkpFQ1QodmRldiksCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ2ZmlvX2dlbmVyaWNfbWlycm9yX3F1aXJr
LCBnZ2NfbWlycm9yLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAidmZpby1pZ2QtZ2djLXF1aXJrIiwgMik7Cj4gLcKgwqDCoCBtZW1vcnlfcmVn
aW9uX2FkZF9zdWJyZWdpb25fb3ZlcmxhcCh2ZGV2LT5iYXJzW25yXS5yZWdpb24ubWVtLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2djX21pcnJvci0+b2Zmc2V0LCBnZ2NfbWlycm9yLT5tZW0s
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxKTsKPiArwqDCoMKgIGlmICh2ZGV2LT5pZ2RfZ21z
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGdnY19xdWlyayA9IHZmaW9fcXVpcmtfYWxsb2MoMSk7Cj4g
K8KgwqDCoMKgwqDCoMKgIGdnY19taXJyb3IgPSBnZ2NfcXVpcmstPmRhdGEgPSBnX21hbGxvYzAo
c2l6ZW9mKCpnZ2NfbWlycm9yKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIGdnY19taXJyb3ItPm1lbSA9
IGdnY19xdWlyay0+bWVtOwo+ICvCoMKgwqDCoMKgwqDCoCBnZ2NfbWlycm9yLT52ZGV2ID0gdmRl
djsKPiArwqDCoMKgwqDCoMKgwqAgZ2djX21pcnJvci0+YmFyID0gbnI7Cj4gK8KgwqDCoMKgwqDC
oMKgIGdnY19taXJyb3ItPm9mZnNldCA9IElHRF9HR0NfTU1JT19PRkZTRVQ7Cj4gK8KgwqDCoMKg
wqDCoMKgIGdnY19taXJyb3ItPmNvbmZpZ19vZmZzZXQgPSBJR0RfR01DSDsKPiDCoAo+IC3CoMKg
wqAgUUxJU1RfSU5TRVJUX0hFQUQoJnZkZXYtPmJhcnNbbnJdLnF1aXJrcywgZ2djX3F1aXJrLCBu
ZXh0KTsKPiArwqDCoMKgwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKGdnY19taXJyb3It
Pm1lbSwgT0JKRUNUKHZkZXYpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ2ZmlvX2dlbmVyaWNfbWlycm9yX3F1aXJrLCBnZ2Nf
bWlycm9yLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJ2ZmlvLWlnZC1nZ2MtcXVpcmsiLCAyKTsKPiArwqDCoMKgwqDCoMKgwqAg
bWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJsYXAodmRldi0+YmFyc1tucl0ucmVnaW9u
Lm1lbSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2djX21pcnJvci0+b2Zmc2V0
LCBnZ2NfbWlycm9yLQo+ID5tZW0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEp
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAgUUxJU1RfSU5TRVJUX0hFQUQoJnZkZXYtPmJhcnNbbnJd
LnF1aXJrcywgZ2djX3F1aXJrLCBuZXh0KTsKPiArwqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgIGJk
c21fcXVpcmsgPSB2ZmlvX3F1aXJrX2FsbG9jKDEpOwo+IMKgwqDCoMKgIGJkc21fbWlycm9yID0g
YmRzbV9xdWlyay0+ZGF0YSA9IGdfbWFsbG9jMChzaXplb2YoKmJkc21fbWlycm9yKSk7Cj4gQEAg
LTYzMSw5ICs2MzMsMTUgQEAgc3RhdGljIGJvb2wgdmZpb19wY2lfaWdkX2NvbmZpZ19xdWlyayhW
RklPUENJRGV2aWNlCj4gKnZkZXYsIEVycm9yICoqZXJycCkKPiDCoMKgwqDCoMKgICogMzJNaUIu
IFRoaXMgb3B0aW9uIHNob3VsZCBvbmx5IGJlIHVzZWQgd2hlbiB0aGUgZGVzaXJlZCBzaXplIGNh
bm5vdCBiZQo+IMKgwqDCoMKgwqAgKiBzZXQgZnJvbSBEVk1UIFByZS1BbGxvY2F0ZWQgb3B0aW9u
IGluIGhvc3QgQklPUy4KPiDCoMKgwqDCoMKgICovCj4gLcKgwqDCoCBpZiAodmRldi0+aWdkX2dt
cyAmJgo+IC3CoMKgwqDCoMKgwqDCoCAhdmZpb19wY2lfaWdkX292ZXJyaWRlX2dtcyhnZW4sIHZk
ZXYtPmlnZF9nbXMsICZnbWNoKSkgewo+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4g
K8KgwqDCoCBpZiAodmRldi0+aWdkX2dtcykgewo+ICvCoMKgwqDCoMKgwqDCoCBpZiAodmZpb19w
Y2lfaWdkX292ZXJyaWRlX2dtcyhnZW4sIHZkZXYtPmlnZF9nbXMsICZnbWNoKSkgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIEdNQ0ggaXMgcmVhZC1vbmx5LCBlbXVsYXRlZCAqLwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9zZXRfbG9uZyh2ZGV2LT5wZGV2LmNvbmZpZyArIElH
RF9HTUNILCBnbWNoKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfc2V0X2xvbmcodmRl
di0+cGRldi53bWFzayArIElHRF9HTUNILCAwKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
Y2lfc2V0X2xvbmcodmRldi0+ZW11bGF0ZWRfY29uZmlnX2JpdHMgKyBJR0RfR01DSCwgfjApOwo+
ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBmYWxzZTsKPiArwqDCoMKgwqDCoMKgwqAgfQoKbml0IHN1Z2dlc3Rpb246IFlvdSBjb3VsZCBh
dm9pZCBhIGxldmVsIG9mIGluZGVudGF0aW9uIGJ5IHVzaW5nIHRoaXMgc3R5bGU6CgppZiAoIXZm
aW9fcGNpX2lnZF9vdmVycmlkZV9nbXMoLi4uKSkgewogICAgcmV0dXJuIGZhbHNlOwp9CgovKiBH
TUNIIGlzIHJlYWQtb25seSwgZW11bGF0ZWQgKi8KcGNpX3NldF9sb25nKC4uLikKCj4gwqDCoMKg
wqAgfQo+IMKgCj4gwqDCoMKgwqAgZ21zX3NpemUgPSBpZ2Rfc3RvbGVuX21lbW9yeV9zaXplKGdl
biwgZ21jaCk7Cj4gQEAgLTY1MSwxMSArNjU5LDYgQEAgc3RhdGljIGJvb2wgdmZpb19wY2lfaWdk
X2NvbmZpZ19xdWlyayhWRklPUENJRGV2aWNlCj4gKnZkZXYsIEVycm9yICoqZXJycCkKPiDCoMKg
wqDCoCBmd19jZmdfYWRkX2ZpbGUoZndfY2ZnX2ZpbmQoKSwgImV0Yy9pZ2QtYmRzbS1zaXplIiwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJkc21fc2l6ZSwgc2l6
ZW9mKCpiZHNtX3NpemUpKTsKPiDCoAo+IC3CoMKgwqAgLyogR01DSCBpcyByZWFkLW9ubHksIGVt
dWxhdGVkICovCj4gLcKgwqDCoCBwY2lfc2V0X2xvbmcodmRldi0+cGRldi5jb25maWcgKyBJR0Rf
R01DSCwgZ21jaCk7Cj4gLcKgwqDCoCBwY2lfc2V0X2xvbmcodmRldi0+cGRldi53bWFzayArIElH
RF9HTUNILCAwKTsKPiAtwqDCoMKgIHBjaV9zZXRfbG9uZyh2ZGV2LT5lbXVsYXRlZF9jb25maWdf
Yml0cyArIElHRF9HTUNILCB+MCk7Cj4gLQo+IMKgwqDCoMKgIC8qIEJEU00gaXMgcmVhZC13cml0
ZSwgZW11bGF0ZWQuwqAgVGhlIEJJT1MgbmVlZHMgdG8gYmUgYWJsZSB0byB3cml0ZSBpdAo+ICov
Cj4gwqDCoMKgwqAgaWYgKGdlbiA8IDExKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBwY2lfc2V0X2xv
bmcodmRldi0+cGRldi5jb25maWcgKyBJR0RfQkRTTSwgMCk7CgpSZXZpZXdlZC1ieTogQ29ydmlu
IEvDtmhuZSA8Yy5rb2VobmVAYmVja2hvZmYuY29tPgoKCi0tIApLaW5kIHJlZ2FyZHMsCkNvcnZp
bgo=


--=-jOIBVtBU1P7x6M4aYnYL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYfSUACgkQ2FTaVjFe
AmoEYA/+PKJGSZOaXg3DRx+LuqZga8po78++na1YCdhjaFHqWv1cjzPAJ5nCJRTN
2V6s4OW532FfrqtALqqAloC/6bvhPQYE4TdCr7wrqnNPPl50AZeSADf8t9dI5EQD
Hd8ECZ0bpiNtJLutZImXht/ctkFUEk9LuGrWrdKAznx4qWiLGf1viEb3LUizuyxH
0fPEKGGP9srqAZy4p142L6+YH48/7D9v+j3hQ/Q7YKxc1JczdAXAsAYbC1mK36V1
xIRHmgUE97KvnExmyu5XCU3Uku8pQ/QEtG2zlgjFq5M6+2EsmmnlyPuS0zZW9AV2
pn3AePlpoElec/WjMe6lm82ZvkQQ7k9xi1lMZEwV4nAkKqaYKu9QaQzHouVhqn7v
pH2rgIGsYcwTwL9xZJD3OPJ50uSrWUIt/jIH0Dg6AEtyNT237Sa3E9T2GRM5zea/
9v9PPvb+qMSb6gdTXg1lPNYL78GJJVo9G7I7eeQhXiYLgyHgkxfUUzfSnAV0ycQ7
7KAUqjK7uiCJ2tVvubFueGGFH9x4pDL+XSPgs6HjxmOWeSsLY2p++dYUK3WFyB9z
PVJVfKxaN1K/6AB0yO6RPMRqksTckFYSwdSTsJauM7UWVgcW7cj+qT43UWylEf+D
hACubszG4Z8fdG1E1HF5hm+Na0E4ggC9RPAHLUlqO/V7fYR8OxA=
=F1cY
-----END PGP SIGNATURE-----

--=-jOIBVtBU1P7x6M4aYnYL--


