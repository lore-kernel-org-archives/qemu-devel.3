Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A28EC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90Ei-0003dn-4u; Tue, 22 Sep 2026 09:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x90Ec-0003d6-Ac; Tue, 22 Sep 2026 09:08:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x90EZ-0004h3-Hj; Tue, 22 Sep 2026 09:08:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBZcI0312042; Tue, 22 Sep 2026 13:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=t4G4JK
 fP4nq508Tf8n8mj+7UjGO8JA3VUL5LY3TcEGs=; b=FpvKJ8W4X0SvhNV/t3Lr2A
 ENVPVY9IPinCIX0uA8K3j0OLnvfXLfQIyTDuaikLn2fRb1G/LXCU2mpE9Hwjlig/
 J72rP4DIP0P5xfw9nrpMN7K3IVbsBS2QLXVknFefqJMhX2NFxPzty/9vFeSmTKeA
 OxZjyyTCLj0psGV9uy0tEiM/BlVl5AEJRTaojxuc4rgZaHGyWKW4YKraPExV3v11
 yKSk+Ghl/syi1g9CM6HYtfzWzyyv4qnO5/5WJgxnCfKIthjZLH2jnrwvLMaimye1
 aDK2pRWnU10mDPuSwmlu+7868A8ONrYzeDWiJhH0Sv22S+Dsgf4AHHFduRp3iBUg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs5u3y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:08:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBWSrj2794456; Tue, 22 Sep 2026 13:08:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gsu2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:08:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MD8J3h45482436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 13:08:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E6D52004D;
 Tue, 22 Sep 2026 13:08:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E550020043;
 Tue, 22 Sep 2026 13:08:18 +0000 (GMT)
Received: from [9.87.138.123] (unknown [9.87.138.123])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 13:08:18 +0000 (GMT)
Message-ID: <8d2c05a9-0723-48a3-a2c0-e985aa0ec94b@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/16] s390x: protvirt: Set guest IPL PSW
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-11-frankja@linux.ibm.com>
 <3a8d34b6-a0cb-46a4-8ef8-6d8b029bf253@oss.qualcomm.com>
 <a27063ef-f1dc-4560-bf8c-5abf315abd7e@linux.ibm.com>
 <25b4032b-d5d0-44ed-8733-cf43d4a3fe26@oss.qualcomm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <25b4032b-d5d0-44ed-8733-cf43d4a3fe26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab27dca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=ZaZFRyDKbuBKrtD4o5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kFc_JUR48IC1fA2ImsQI1vTaisk1RgDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfXyfzN7Ud/xLwF
 7a/kXD03pIY6p2YaOIQj3nrJ4a/cQEShIPuXfRvSQoIc+z3z8MqJGeLPKKig/eJwTA22W3CNTdZ
 DYZe1kx7SoUmQqqNqkSRYw3ecszfYdoDFlIga3GBvSvSnn+nQIHzbedvQt9+Se72WFfK20Lxpuf
 C1hylY2hl240Pwqi51ZgfSFRW6tCuIX78/B0D6cZUvqxEIQvutkIawchkBzt6Vv3UE8nl8zu8p6
 c6VhGvG2o7Jo7W8txEs1FyN2PACucaox+NfwmA8KSbYJSSf+2L+/mjGFXXkKYka8GLcAD9Zj6oA
 xxpJ6A/2yRVIqsVKRXs7qzP4EThLwB1IWXWpKyjMoLqFX3/CTUPlJfsZ7ryTBJDYblBkjqjXiiY
 gB8ihf8LQyRW5uR8U0FpVxUrMcZSMK/tfWYzTaM/HD2Pl6iEW3PbPmfHwzfee++NMWw1etDmF0R
 z5r9O+jNrLGCPAk7Onw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX4W9D65KrcJiO
 VXXgENMJbvnsL1mcbbbF0yBFE9z8eyMocLSnQc8a4K3unQoGTwY6qrdnrDg9NBeLkLygLQoXlJx
 DmkEEKP2yCoPdQQ5haQWKr/ajTC/THE=
X-Proofpoint-GUID: kFc_JUR48IC1fA2ImsQI1vTaisk1RgDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220190
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

T24gOS8yMi8yNiAyOjQ4IFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
T24gMjAyNi0wOS0yMiAxMzoxNiwgSmFub3NjaCBGcmFuayB3cm90ZToNCj4+IE9uIDkvMjIv
MjYgMTA6NTYgQU0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+IEhpLA0K
Pj4+DQo+Pj4gKG9sZCBwYXRjaCBjb21taXR0ZWQgYXMgNTkxODEwMTBhMmZmODJjM2E5N2U5
YjU3NjhlZTg3YzM4ZTQ4MTVmMSkNCj4+Pg0KPj4+IE9uIDIwMjAtMDMtMTkgMTQ6MTksIEph
bm9zY2ggRnJhbmsgd3JvdGU6DQo+Pj4+IEhhbmRsaW5nIG9mIENQVSByZXNldCBhbmQgc2V0
dGluZyBvZiB0aGUgSVBMIHBzdyBmcm9tIGd1ZXN0IHN0b3JhZ2UgYXQNCj4+Pj4gb2Zmc2V0
IDAgaXMgZG9uZSBieSBhIFVsdHJhdmlzb3IgY2FsbC4gTGV0J3Mgb25seSBmZXRjaCBpdCBp
Zg0KPj4+PiBuZWNlc3NhcnkuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbm9zY2gg
RnJhbmsgPGZyYW5ramFAbGludXguaWJtLmNvbT4NCj4+Pj4gUmV2aWV3ZWQtYnk6IFRob21h
cyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPj4+PiBSZXZpZXdlZC1ieTogRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gQm9ybnRyYWVnZXIgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+DQo+Pj4+IFJldmlld2Vk
LWJ5OiBDbGF1ZGlvIEltYnJlbmRhIDxpbWJyZW5kYUBsaW51eC5pYm0uY29tPg0KPj4+PiBS
ZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+DQo+Pj4+IC0t
LQ0KPj4+PiAgwqDCoCB0YXJnZXQvczM5MHgvY3B1LmMgfCAyNiArKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLQ0KPj4+PiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3RhcmdldC9zMzkw
eC9jcHUuYyBiL3RhcmdldC9zMzkweC9jcHUuYw0KPj4+PiBpbmRleCA5NjFlM2ViZGM1MzBj
ZmFiLi43MWEwYzliM2U1NWQwY2JmIDEwMDY0NA0KPj4+PiAtLS0gYS90YXJnZXQvczM5MHgv
Y3B1LmMNCj4+Pj4gKysrIGIvdGFyZ2V0L3MzOTB4L2NwdS5jDQo+Pj4+IEBAIC03NywxNiAr
NzcsMjQgQEAgc3RhdGljIGJvb2wgczM5MF9jcHVfaGFzX3dvcmsoQ1BVU3RhdGUgKmNzKQ0K
Pj4+PiAgwqDCoCBzdGF0aWMgdm9pZCBzMzkwX2NwdV9sb2FkX25vcm1hbChDUFVTdGF0ZSAq
cykNCj4+Pj4gIMKgwqAgew0KPj4+PiAgwqDCoMKgwqDCoMKgIFMzOTBDUFUgKmNwdSA9IFMz
OTBfQ1BVKHMpOw0KPj4+PiAtwqDCoMKgIHVpbnQ2NF90IHNwc3cgPSBsZHFfcGh5cyhzLT5h
cywgMCk7DQo+Pj4+IC0NCj4+Pj4gLcKgwqDCoCBjcHUtPmVudi5wc3cubWFzayA9IHNwc3cg
JiBQU1dfTUFTS19TSE9SVF9DVFJMOw0KPj4+PiAtwqDCoMKgIC8qDQo+Pj4+IC3CoMKgwqDC
oCAqIEludmVydCBzaG9ydCBwc3cgaW5kaWNhdGlvbiwgc28gU0lFIHdpbGwgcmVwb3J0IGEg
c3BlY2lmaWNhdGlvbg0KPj4+PiAtwqDCoMKgwqAgKiBleGNlcHRpb24gaWYgaXQgd2FzIG5v
dCBzZXQuDQo+Pj4+IC3CoMKgwqDCoCAqLw0KPj4+PiAtwqDCoMKgIGNwdS0+ZW52LnBzdy5t
YXNrIF49IFBTV19NQVNLX1NIT1JUUFNXOw0KPj4+PiAtwqDCoMKgIGNwdS0+ZW52LnBzdy5h
ZGRyID0gc3BzdyAmIFBTV19NQVNLX1NIT1JUX0FERFI7DQo+Pj4+ICvCoMKgwqAgdWludDY0
X3Qgc3BzdzsNCj4+Pj4gK8KgwqDCoCBpZiAoIXMzOTBfaXNfcHYoKSkgew0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgc3BzdyA9IGxkcV9waHlzKHMtPmFzLCAwKTsNCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGNwdS0+ZW52LnBzdy5tYXNrID0gc3BzdyAmIFBTV19NQVNLX1NIT1JUX0NUUkw7
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIElu
dmVydCBzaG9ydCBwc3cgaW5kaWNhdGlvbiwgc28gU0lFIHdpbGwgcmVwb3J0IGENCj4+Pj4g
c3BlY2lmaWNhdGlvbg0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGV4Y2VwdGlvbiBpZiBp
dCB3YXMgbm90IHNldC4NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8NCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGNwdS0+ZW52LnBzdy5tYXNrIF49IFBTV19NQVNLX1NIT1JUUFNXOw0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgY3B1LT5lbnYucHN3LmFkZHIgPSBzcHN3ICYgUFNXX01BU0tf
U0hPUlRfQUREUjsNCj4+Pj4gK8KgwqDCoCB9IGVsc2Ugew0KPj4+PiArwqDCoMKgwqDCoMKg
wqAgLyoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBGaXJtd2FyZSByZXF1aXJlcyB1cyB0
byBzZXQgdGhlIGxvYWQgc3RhdGUgYmVmb3JlIHdlIHNldA0KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoCAqIHRoZSBjcHUgdG8gb3BlcmF0aW5nIG9uIHByb3RlY3RlZCBndWVzdHMuDQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzMzkwX2NwdV9z
ZXRfc3RhdGUoUzM5MF9DUFVfU1RBVEVfTE9BRCwgY3B1KTsNCj4+Pg0KPj4+IFMzOTBfQ1BV
X1NUQVRFX0xPQUQgaXMgb3ZlcndyaXR0ZW4gdGhlIGxpbmUgYWJvdmUsIGlzIHRoYXQgZGVs
aWJlcmF0ZT8NCj4+IFllcy4NCj4+IExPQUQgaXMgYSBzdXBlcnNldCBvZiBPUEVSQVRJTkcg
YW5kIGRvaW5nIGEgc2Vjb25kIE9QRVJBVElORyBpcw0KPj4gdGhlcmVmb3JlIGEgTk9QLg0K
Pj4NCj4+IFRoZSBsb2FkIGlzbid0IGEgcmVhbCBzdGF0ZSBpbiBLVk0sIHdlIG9ubHkgdXNl
IGl0IGZvciB0aGUgVVYgY2FsbC4NCj4+IFNvIHdlIGhhdmUgdG8gZG8gYSBzZWNvbmQgY2hh
bmdlIGludG8gT1BFUkFUSU5HIGZvciBLVk0gdG8gdHJhY2sgdGhlDQo+PiBzdGF0ZSBpZiB3
ZSB3ZXJlIGluIHN0b3BwZWQgc3RhdGUuDQo+IA0KPiBPaCBPSyBub3cgSSBzZWUgdGhlIEtW
TV9TRVRfTVBfU1RBVEUgY2FsbHMuIFNpbmNlIGl0IHdhcyBub3Qgb2J2aW91cw0KPiB0byBt
ZSwgY291bGQgdGhlIGNvbW1lbnQgYmUgdXBkYXRlZCB0byBjbGFyaWZ5IHRoYXQ/IChubyBv
YmxpZ2F0aW9uLA0KPiBmZWVsIGZyZWUgdG8gZGlzcmVnYXJkIGlmIHlvdSBmaW5kIGl0IGNs
ZWFyIGVub3VnaCBmb3IgeW91KS4NCj4gVGhhbmtzIGZvciB0aGUgcXVpY2sgaGVhZC11cCEN
Cg0KU3VyZSwgSSdsbCBleHRlbmQgdGhlIGNvbW1lbnQuDQoNCg==

