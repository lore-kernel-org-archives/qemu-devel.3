Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DBAC9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA0oz-0006yZ-He; Fri, 25 Sep 2026 03:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1xA0ow-0006xT-Uh; Fri, 25 Sep 2026 03:58:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1xA0ov-0004j4-7F; Fri, 25 Sep 2026 03:58:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4bMdj077064; Fri, 25 Sep 2026 07:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rJfHmh
 jG9rPkDPEiB4OtJjaJOSMtmAqdYNavUUDtyqw=; b=NOkKDoAaoVeuZaiFGwl/4X
 IF8MI9uxp+YHfBBnkT5h+n6gBEiNxnPN+Kh3+I1KCJVRR/5I3WzGaq75/rUpZs7D
 tJ4Wt/FFBQbGFVg5bslbSb5YFtQ5pLzxPtl3CCNvAauoE1xOv4wb8TeOW2bIJ3W/
 cnRnGy+IHN8pT1RIKJ9sTgj6w4/WH5XmuEelXMuUKzhMCzdrUXvRCXm927QxeW1/
 jr+ezyEnwEzfc6lE6inyWzFcmM6JYOGSgqPi3E9KPljVQSgxukmY1sNtf0BD/AS0
 62saMrrOAJp+lSAkMzcYgsfcIUPTrndDu19rLfmqEGEJT7g8VeEvGgQ3nhodXuNA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2x028-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 07:58:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lXOk3244919; Fri, 25 Sep 2026 07:58:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu91ga8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 07:58:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P7w5FM49873372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 07:58:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3617D2004B;
 Fri, 25 Sep 2026 07:58:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00F9320043;
 Fri, 25 Sep 2026 07:58:05 +0000 (GMT)
Received: from [9.111.23.152] (unknown [9.111.23.152])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 07:58:04 +0000 (GMT)
Message-ID: <dbb9db92-6504-4ca3-8ab3-96140a1bf0f8@linux.ibm.com>
Date: Fri, 25 Sep 2026 09:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] s390x/sclp: Reject short headers in PV case
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260922201526.2383047-1-farman@linux.ibm.com>
 <20260922201526.2383047-10-farman@linux.ibm.com>
 <84b2133f-a8e2-47d2-8fe7-46c2b92118c5@linux.ibm.com>
 <ea7dd9b0-0ba6-4485-a488-eb5fe9d5a570@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <ea7dd9b0-0ba6-4485-a488-eb5fe9d5a570@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c0UTe20aiMTPJYtfd946BD65Rtu2BB31
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab62992 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=nMtZkYvYTDOY_RsH0ZsA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfXzD/xW7Y/ACFE
 p/22WOlD0lXl3y3DGVsfmfY71E83tGDoFw3u5P7vr9n06LiMoU6zp+lsL8tUhb/xLysAH4a8LfV
 qUxDGuPE7LT6z1fAj5SQcbsKrOk5TN4tXu0o7aUkDElIG1keS/F7IBnu3DzaWQx7B/mXnWGAjiZ
 lRJxfi6XEZ6y4yGs50JwRabmhXEf22VwUfehrudoFWAp1yOL1CdeBkCm69uxXNpmCwU5zgO6Bsl
 QaW36Nz4hhxELP68TtuY2Ys/K0+3BmXeyjfMlqjMa08NiQAJpaJgTjQSyCacLinVfeclBwrGk8r
 1WMTSQ+rH3fHgcxyENacNZxANn4BVxsA+3RyZbgJBfVMjw8IYKl8J2rQhN5N80q+UGJ/lDeAwsr
 DlUNUTly7FM5h0JKqVzIyjrdUlASGcJCO8QWYx2bmKildLFp+jhaYBGXX6WYeg1+ZBvWtwKIZBZ
 wulzDN/HMk5N7JE2DFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX8wcByjptoGyR
 Cvmdhb8fFe+nmj7AqGx05lB2GXdppWEYpB7o9p2HjDa/MN2lck3iA7j4ChOiAzCWzz6JM9Qip4K
 Q+YRS1bp3ewNwbLLsJDrD+G6Mvsui0A=
X-Proofpoint-GUID: c0UTe20aiMTPJYtfd946BD65Rtu2BB31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250030
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gOS8yNC8yNiA0OjM5IFBNLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+IA0K
PiANCj4gQW0gMjQuMDkuMjYgdW0gMTY6MzYgc2NocmllYiBKYW5vc2NoIEZyYW5rOg0KPj4g
T24gOS8yMi8yNiAxMDoxNSBQTSwgRXJpYyBGYXJtYW4gd3JvdGU6DQo+Pj4gQW4gaW52YWxp
ZCBsZW5ndGggaW4gYW4gU0NDQiBoZWFkZXIgY29ycmVjdGx5IGdlbmVyYXRlcyBhIHNwZWNp
ZmljYXRpb24NCj4+PiBleGNlcHRpb24gZm9yIHRoZSByZWd1bGFyIChub24tUFYpIGNvZGVw
YXRoIHRoYXQgcHJvY2Vzc2VzIGFuIFNDTFANCj4+PiBpbnN0cnVjdGlvbiBpbnRlcmNlcHQu
IFRoZSBQViBjYXNlIGRvZXNuJ3QsIGV2ZW4gdGhvdWdoIHN1Y2ggYSB0aGluZw0KPj4+IHNo
b3VsZCBhbHJlYWR5IGJlIHNhbml0aXplZC4gU2luY2UgYSBzaG9ydCBsZW5ndGggd2lsbCBj
YXVzZSBwcm9ibGVtcw0KDQouLi5ldmVuIHRob3VnaCBzdWNoIGEgdGhpbmcgc2hvdWxkIGFs
cmVhZHkgYmUgaGFuZGxlZCBieSB0aGUgVVYuDQoNCj4+PiBsYXRlciBkb3duIHRoZSBsaW5l
IHdpdGggdGhlIHN0b3JhZ2UgdGhhdCB3aWxsIGJlIGFsbG9jYXRlZCBiYXNlZCBvbg0KPj4+
IHRoYXQgc2l6ZSwgcHV0IHVwIGEgZGVmZW5zaXZlIGNoZWNrIGFuZCByZXR1cm4gaWYgaXQg
aXMgdG9vIHNob3J0Lg0KPj4+DQo+Pj4gQ2M6IEphbm9zY2ggRnJhbmsgPGZyYW5ramFAbGlu
dXguaWJtLmNvbT4NCj4+PiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPj4+IEZpeGVz
OiBjMWRiNTNhNTkxICgiczM5MC9zY2xwOiByZWFkIHNjY2IgZnJvbSBtZW0gYmFzZWQgb24g
cHJvdmlkZWQgbGVuZ3RoIikNCj4+PiBSZXZpZXdlZC1ieTogTWF0dGhldyBSb3NhdG8gPG1q
cm9zYXRvQGxpbnV4LmlibS5jb20+DQo+Pj4gQWNrZWQtYnk6IENocmlzdGlhbiBCb3JudHJh
ZWdlciA8Ym9ybnRyYWVnZXJAbGludXguaWJtLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBF
cmljIEZhcm1hbiA8ZmFybWFuQGxpbnV4LmlibS5jb20+DQo+Pj4gLS0tDQo+Pg0KPj4gSG93
IHdvdWxkIHlvdSBoaXQgdGhhdCBpZiB0aGUgYXJjaGl0ZWN0dXJlIHNheXMgRlcgd2lsbCBh
dXRvbWF0aWNhbGx5IGluamVjdCBhIHNwZWMgZXhjZXB0aW9uIHdpdGhvdXQgZXhpdGluZyB0
byB0aGUgaHlwZXJ2aXNvciBpZiBsZW5ndGggPCA4Pw0KPiANCj4gQXMgSSBzYWlkIGluIG15
IHJldmlldywgY3VycmVudCBVViB3aWxsIHNhbml0aXplIHRoaXMsIHNvIHRoaXMgaXMganVz
dCBkZWZlbmNlIGluIGRlcHRoIGluIGNhc2UNCj4gdGhlcmUgd291bGQgYmUgYW4gaW1wbGVt
ZW50YXRpb24gZXJyb3IuDQoNClRoYXQgZ290IGxvc3QgaW4gbXkgbWFpbGJveCBvdmVyZmxv
dy4NCg0KQWxyaWdodCwgdGhlbiBsZXQncyBleHRlbmQgdGhlIGNvbW1lbnQgYW5kIGNvbW1p
dCBkZXNjcmlwdGlvbiBiZWZvcmUgDQpzb21lb25lIGRlbGV0ZXMgdGhpcyBhcyBkZWFkIGNv
ZGUuDQoNCj4gDQo+Pg0KPj4gRGlkIHlvdSB3aXRuZXNzIHRoaXMgaGFwcGVuaW5nPw0KPj4g
QW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4+DQo+Pj4gIMKgIGh3L3MzOTB4L3NjbHAuYyB8
IDYgKysrKysrDQo+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9zMzkweC9zY2xwLmMgYi9ody9zMzkweC9zY2xwLmMN
Cj4+PiBpbmRleCBkOGI2NTVlZmNjLi5hZDgxMjlhNWQ4IDEwMDY0NA0KPj4+IC0tLSBhL2h3
L3MzOTB4L3NjbHAuYw0KPj4+ICsrKyBiL2h3L3MzOTB4L3NjbHAuYw0KPj4+IEBAIC0yNzcs
NiArMjc3LDExIEBAIGludCBzY2xwX3NlcnZpY2VfY2FsbF9wcm90ZWN0ZWQoUzM5MENQVSAq
Y3B1LCB1aW50NjRfdCBzY2NiLCB1aW50MzJfdCBjb2RlKQ0KPj4+ICDCoMKgwqDCoMKgIHMz
OTBfY3B1X3B2X21lbV9yZWFkKGVudl9hcmNoY3B1KGVudiksIDAsICZoZWFkZXIsIHNpemVv
ZihTQ0NCSGVhZGVyKSk7DQo+Pj4gK8KgwqDCoCAvKiBEbyBub3RoaW5nIGlmIHRoZSBoZWFk
ZXIgYXBwZWFycyBtYWxmb3JtZWQgKi8NCg0KLi4uIFdlIHNob3VsZCBuZXZlciBlbmQgdXAg
aGVyZSBkdWUgdG8gVVYgY2hlY2tzIGJ1dCBsZXQncyBiZSBzdXJlLg0KDQo+Pj4gK8KgwqDC
oCBpZiAoYmUxNl90b19jcHUoaGVhZGVyLmxlbmd0aCkgPCBzaXplb2YoU0NDQkhlYWRlcikp
IHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfbm9fd3JpdGU7DQo+Pj4gK8KgwqDC
oCB9DQo+Pj4gKw0KPj4+ICDCoMKgwqDCoMKgIHdvcmtfc2NjYiA9IGdfbWFsbG9jMChiZTE2
X3RvX2NwdShoZWFkZXIubGVuZ3RoKSk7DQo+Pj4gIMKgwqDCoMKgwqAgczM5MF9jcHVfcHZf
bWVtX3JlYWQoZW52X2FyY2hjcHUoZW52KSwgMCwgd29ya19zY2NiLA0KPj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJlMTZfdG9f
Y3B1KGhlYWRlci5sZW5ndGgpKTsNCj4+PiBAQCAtMjkwLDYgKzI5NSw3IEBAIGludCBzY2xw
X3NlcnZpY2VfY2FsbF9wcm90ZWN0ZWQoUzM5MENQVSAqY3B1LCB1aW50NjRfdCBzY2NiLCB1
aW50MzJfdCBjb2RlKQ0KPj4+ICDCoCBvdXRfd3JpdGU6DQo+Pj4gIMKgwqDCoMKgwqAgczM5
MF9jcHVfcHZfbWVtX3dyaXRlKGVudl9hcmNoY3B1KGVudiksIDAsIHdvcmtfc2NjYiwNCj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJlMTZfdG9fY3B1KGhlYWRlci5sZW5ndGgpKTsNCj4+PiArb3V0X25vX3dyaXRlOg0K
Pj4+ICDCoMKgwqDCoMKgIHNjbHBfYy0+c2VydmljZV9pbnRlcnJ1cHQoc2NscCwgU0NMUF9Q
Vl9EVU1NWV9BRERSKTsNCj4+PiAgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiAgwqAgfQ0K
Pj4NCj4gDQoNCg==

