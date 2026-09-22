Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103BCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8yUa-0002TL-Bg; Tue, 22 Sep 2026 07:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x8yUV-0002ST-0G; Tue, 22 Sep 2026 07:16:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x8yUT-0007fN-7M; Tue, 22 Sep 2026 07:16:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M05X702948554; Tue, 22 Sep 2026 11:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pou9EA
 wokFz+s/nmHYAVFZ6zuzYcwvPhDtY4IbNVA4Q=; b=sYK4MjJUCUp7m8kTVb/1lX
 Sm6I7sqsU3V7DpZKVH3e6UZ0AeQ4WymYK9VWJV+at6fnlT/2GS01Ux3KK4I14ycu
 Ua06gCmvMurnxLtD3GQjKGY02qsDEbekIB9J3EuA7g3P/DJswgPLgVhJOlZyHC1I
 rJh+Lhd0TotNb/S8b5YcrCkJqPLs7iHOHT58mbHAARknGkj4jfd6/MTuEIap/v9U
 Gnpuxd7KStbgjUf2QKtAwloHxtap0OPFg4CKXRtTTPSZUVVS3dWIz291ADViWBcL
 v3hfDFeMuEAm275mwEDejEzDH7fqibQswOLBOoQda+WpDTe2p2ONcZtSTOIlloMw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs5cpr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 11:16:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MAGYOx764418; Tue, 22 Sep 2026 11:16:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkc3gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 11:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MBGafj47317292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 11:16:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B396720043;
 Tue, 22 Sep 2026 11:16:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F64820040;
 Tue, 22 Sep 2026 11:16:36 +0000 (GMT)
Received: from [9.87.138.123] (unknown [9.87.138.123])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 11:16:36 +0000 (GMT)
Message-ID: <a27063ef-f1dc-4560-bf8c-5abf315abd7e@linux.ibm.com>
Date: Tue, 22 Sep 2026 13:16:36 +0200
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
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <3a8d34b6-a0cb-46a4-8ef8-6d8b029bf253@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2639b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=gqckWzEuYbeArVdI7DsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xBX1TDtDYrBfWUOMlHhu6YF4ytyZEagK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfXwSLHkBv4YJ2H
 c2mpMpdnojJqKTXaCjCpYVU2n0UG/SZvAXMRG3P+bUTo81b+EfoDqw4mUUs9eywd6TUMIA1VLn7
 cPnHjj3K9AQ7oEG+WVcv8bHE319X3iOShStbVqGMiyjG5iAyMt9PW42KAxHr193DVKeZgxYW0k9
 fnoGUk6Vuj0LHmRlB8BZ3qe2cQ/bx270+ptygK1cK/69S/uY/0Oini5UOst/sjBNhDxlp3oYJZl
 r54aJtvRaZWBKaLMvVUYcl6kO5qFiEXv4ep2ABD5EO2m33+1WuoB/HnnRlk/gJnW+fJ/cZZy9JO
 HLhFxljS+UTmXbsS+kxfrCI7yN9/9xTWtZ4VMQG1TG9heJTmxehISXFFrT/e1bClZrHt1jlV2hF
 OVWID5cIDCn+v1Mdlfr4HF7mAvur7wS8xF8s15+LB9YmEF/JnUxSYh274Qkv3+gqErAjzW6szDN
 X8qcgDjTxb1kzdaziww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfXxa5HKFOmoGpv
 0KqJutqx1EEoTWPPlArQU8UpfVR9+1Zp7Xs3kAThMNgAVeYNO8zSOtEvYMOXp4kcTLiEMaYFEgp
 QUmy2HBgutEOtWfNvxxNpbPoE5GRVao=
X-Proofpoint-GUID: xBX1TDtDYrBfWUOMlHhu6YF4ytyZEagK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220160
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

T24gOS8yMi8yNiAxMDo1NiBBTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+
IEhpLA0KPiANCj4gKG9sZCBwYXRjaCBjb21taXR0ZWQgYXMgNTkxODEwMTBhMmZmODJjM2E5
N2U5YjU3NjhlZTg3YzM4ZTQ4MTVmMSkNCj4gDQo+IE9uIDIwMjAtMDMtMTkgMTQ6MTksIEph
bm9zY2ggRnJhbmsgd3JvdGU6DQo+PiBIYW5kbGluZyBvZiBDUFUgcmVzZXQgYW5kIHNldHRp
bmcgb2YgdGhlIElQTCBwc3cgZnJvbSBndWVzdCBzdG9yYWdlIGF0DQo+PiBvZmZzZXQgMCBp
cyBkb25lIGJ5IGEgVWx0cmF2aXNvciBjYWxsLiBMZXQncyBvbmx5IGZldGNoIGl0IGlmDQo+
PiBuZWNlc3NhcnkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFub3NjaCBGcmFuayA8ZnJh
bmtqYUBsaW51eC5pYm0uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0
aEByZWRoYXQuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZp
ZEByZWRoYXQuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBCb3JudHJhZWdlciA8
Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDbGF1ZGlvIEltYnJl
bmRhIDxpbWJyZW5kYUBsaW51eC5pYm0uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENvcm5lbGlh
IEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgICB0YXJnZXQvczM5MHgv
Y3B1LmMgfCAyNiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9zMzkweC9jcHUuYyBiL3RhcmdldC9zMzkweC9jcHUuYw0KPj4gaW5k
ZXggOTYxZTNlYmRjNTMwY2ZhYi4uNzFhMGM5YjNlNTVkMGNiZiAxMDA2NDQNCj4+IC0tLSBh
L3RhcmdldC9zMzkweC9jcHUuYw0KPj4gKysrIGIvdGFyZ2V0L3MzOTB4L2NwdS5jDQo+PiBA
QCAtNzcsMTYgKzc3LDI0IEBAIHN0YXRpYyBib29sIHMzOTBfY3B1X2hhc193b3JrKENQVVN0
YXRlICpjcykNCj4+ICAgIHN0YXRpYyB2b2lkIHMzOTBfY3B1X2xvYWRfbm9ybWFsKENQVVN0
YXRlICpzKQ0KPj4gICAgew0KPj4gICAgICAgIFMzOTBDUFUgKmNwdSA9IFMzOTBfQ1BVKHMp
Ow0KPj4gLSAgICB1aW50NjRfdCBzcHN3ID0gbGRxX3BoeXMocy0+YXMsIDApOw0KPj4gLQ0K
Pj4gLSAgICBjcHUtPmVudi5wc3cubWFzayA9IHNwc3cgJiBQU1dfTUFTS19TSE9SVF9DVFJM
Ow0KPj4gLSAgICAvKg0KPj4gLSAgICAgKiBJbnZlcnQgc2hvcnQgcHN3IGluZGljYXRpb24s
IHNvIFNJRSB3aWxsIHJlcG9ydCBhIHNwZWNpZmljYXRpb24NCj4+IC0gICAgICogZXhjZXB0
aW9uIGlmIGl0IHdhcyBub3Qgc2V0Lg0KPj4gLSAgICAgKi8NCj4+IC0gICAgY3B1LT5lbnYu
cHN3Lm1hc2sgXj0gUFNXX01BU0tfU0hPUlRQU1c7DQo+PiAtICAgIGNwdS0+ZW52LnBzdy5h
ZGRyID0gc3BzdyAmIFBTV19NQVNLX1NIT1JUX0FERFI7DQo+PiArICAgIHVpbnQ2NF90IHNw
c3c7DQo+PiAgICANCj4+ICsgICAgaWYgKCFzMzkwX2lzX3B2KCkpIHsNCj4+ICsgICAgICAg
IHNwc3cgPSBsZHFfcGh5cyhzLT5hcywgMCk7DQo+PiArICAgICAgICBjcHUtPmVudi5wc3cu
bWFzayA9IHNwc3cgJiBQU1dfTUFTS19TSE9SVF9DVFJMOw0KPj4gKyAgICAgICAgLyoNCj4+
ICsgICAgICAgICAqIEludmVydCBzaG9ydCBwc3cgaW5kaWNhdGlvbiwgc28gU0lFIHdpbGwg
cmVwb3J0IGEgc3BlY2lmaWNhdGlvbg0KPj4gKyAgICAgICAgICogZXhjZXB0aW9uIGlmIGl0
IHdhcyBub3Qgc2V0Lg0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAgICBjcHUtPmVudi5w
c3cubWFzayBePSBQU1dfTUFTS19TSE9SVFBTVzsNCj4+ICsgICAgICAgIGNwdS0+ZW52LnBz
dy5hZGRyID0gc3BzdyAmIFBTV19NQVNLX1NIT1JUX0FERFI7DQo+PiArICAgIH0gZWxzZSB7
DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogRmlybXdhcmUgcmVxdWlyZXMgdXMg
dG8gc2V0IHRoZSBsb2FkIHN0YXRlIGJlZm9yZSB3ZSBzZXQNCj4+ICsgICAgICAgICAqIHRo
ZSBjcHUgdG8gb3BlcmF0aW5nIG9uIHByb3RlY3RlZCBndWVzdHMuDQo+PiArICAgICAgICAg
Ki8NCj4+ICsgICAgICAgIHMzOTBfY3B1X3NldF9zdGF0ZShTMzkwX0NQVV9TVEFURV9MT0FE
LCBjcHUpOw0KPiANCj4gUzM5MF9DUFVfU1RBVEVfTE9BRCBpcyBvdmVyd3JpdHRlbiB0aGUg
bGluZSBhYm92ZSwgaXMgdGhhdCBkZWxpYmVyYXRlPw0KWWVzLg0KTE9BRCBpcyBhIHN1cGVy
c2V0IG9mIE9QRVJBVElORyBhbmQgZG9pbmcgYSBzZWNvbmQgT1BFUkFUSU5HIGlzIA0KdGhl
cmVmb3JlIGEgTk9QLg0KDQpUaGUgbG9hZCBpc24ndCBhIHJlYWwgc3RhdGUgaW4gS1ZNLCB3
ZSBvbmx5IHVzZSBpdCBmb3IgdGhlIFVWIGNhbGwuDQpTbyB3ZSBoYXZlIHRvIGRvIGEgc2Vj
b25kIGNoYW5nZSBpbnRvIE9QRVJBVElORyBmb3IgS1ZNIHRvIHRyYWNrIHRoZSANCnN0YXRl
IGlmIHdlIHdlcmUgaW4gc3RvcHBlZCBzdGF0ZS4NCg==

