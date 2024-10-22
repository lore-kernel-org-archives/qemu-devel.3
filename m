Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E2D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BO9-0002m2-JQ; Tue, 22 Oct 2024 05:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3BO8-0002ls-2e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:41:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3BO6-00015G-6o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:41:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HAK6005260;
 Tue, 22 Oct 2024 09:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FxQfAN
 7ODFpA7Szsy86wjEmvoGMp2LGyrrkmMyB/cYM=; b=CoQD1aGlsq0wOm8FZqhWmY
 0f7rzGIWRNYfoP5hRB6kUWNcW75tySN2bDtRkJzIbTiRK9x58a4uVjUqkIS42HpW
 cGzBt4dl5rOVyDyKHhGlSP9h5cTA+7KmuwJ+hM6Wc57Mnx0Vt7IxXgAFG6kuUkbz
 5aLNUfLkzlUV9oHVZ7vyDcTNzUvGV2/HOFtPpqvSWQGOPH2NhshdC+OPYvSDVfkd
 uCDRpuPydHa1qySmqr22c4x0YGHPjVEB2kUFbD41Qt56K5kXj+NlKOBS+fSbtjVT
 u/3nTCTHdHt5oOD2aHkgGCIEE6x/kP3MmPnEQHr03LwaHWLS6l5SmfoLqkuzH+Cg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcn5yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 09:41:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8atUP028907;
 Tue, 22 Oct 2024 09:41:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cqfxjpxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 09:41:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49M9f9rg53805472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 09:41:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A6DE20043;
 Tue, 22 Oct 2024 09:41:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE4CF2004B;
 Tue, 22 Oct 2024 09:41:08 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Oct 2024 09:41:08 +0000 (GMT)
Message-ID: <4cc78de8a3fde301774f1ce2e2f41876b60e2996.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Trace rt_sigprocmask's sigsets
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Date: Tue, 22 Oct 2024 11:41:08 +0200
In-Reply-To: <94e56b07-1f4d-4c43-9239-795ed060016d@linaro.org>
References: <20241017091449.443799-1-iii@linux.ibm.com>
 <94e56b07-1f4d-4c43-9239-795ed060016d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -HVvlKA0dZvu68qUpl7t3diiZ4Yr9f-D
X-Proofpoint-GUID: -HVvlKA0dZvu68qUpl7t3diiZ4Yr9f-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=887 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

T24gTW9uLCAyMDI0LTEwLTIxIGF0IDE4OjUwIC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBPbiAxMC8xNy8yNCAwMjoxNCwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToKPiA+IEBAIC0z
MzEyLDEwICszMzU4LDI2IEBAIHByaW50X3J0X3NpZ3Byb2NtYXNrKENQVUFyY2hTdGF0ZSAqY3B1
X2VudiwKPiA+IGNvbnN0IHN0cnVjdCBzeXNjYWxsbmFtZSAqbmFtZSwKPiA+IMKgwqDCoMKgwqAg
Y2FzZSBUQVJHRVRfU0lHX1NFVE1BU0s6IGhvdyA9ICJTSUdfU0VUTUFTSyI7IGJyZWFrOwo+ID4g
wqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgIHFlbXVfbG9nKCIlcywiLCBob3cpOwo+ID4gLcKg
wqDCoCBwcmludF9wb2ludGVyKGFyZzEsIDApOwo+ID4gLcKgwqDCoCBwcmludF9wb2ludGVyKGFy
ZzIsIDApOwo+ID4gK8KgwqDCoCBwcmludF90YXJnZXRfc2lnc2V0X3QoYXJnMSwgYXJnMywgMCk7
Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkCj4gPiArcHJpbnRfcnRfc2lncHJvY21hc2tf
cmV0KENQVUFyY2hTdGF0ZSAqY3B1X2VudiwgY29uc3Qgc3RydWN0Cj4gPiBzeXNjYWxsbmFtZSAq
bmFtZSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYWJpX2xvbmcgcmV0LCBhYmlfbG9uZyBhcmcwLCBhYmlfbG9uZwo+ID4gYXJnMSwKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWJpX2xvbmcg
YXJnMiwgYWJpX2xvbmcgYXJnMywgYWJpX2xvbmcKPiA+IGFyZzQsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFiaV9sb25nIGFyZzUpCj4gPiAr
ewo+ID4gK8KgwqDCoCBpZiAoaXNfZXJyb3IocmV0KSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgIHBy
aW50X3BvaW50ZXIoYXJnMiwgMCk7Cj4gPiArwqDCoMKgIH0gZWxzZSB7Cj4gPiArwqDCoMKgwqDC
oMKgwqAgcHJpbnRfdGFyZ2V0X3NpZ3NldF90KGFyZzIsIGFyZzMsIDApOwo+ID4gK8KgwqDCoCB9
Cj4gPiDCoMKgwqDCoMKgIHByaW50X3Jhd19wYXJhbSgiJXUiLCBhcmczLCAxKTsKPiA+IMKgwqDC
oMKgwqAgcHJpbnRfc3lzY2FsbF9lcGlsb2d1ZShuYW1lKTsKPiAKPiBJJ20gbm90IGtlZW4gb24g
c3BsaXR0aW5nIG9wZXJhbmRzIGFjcm9zcyBzeXNjYWxsIGNvbXBsZXRpb24uCj4gVGhlcmUgYXJl
IGEgZmV3IGV4aXN0aW5nIHN5c2NhbGxzIGZvciB3aGljaCB3ZSBwcmludCBzdWNoIHJlc3VsdHMK
PiBhZnRlcndhcmQ6Cj4gCj4gwqDCoCBjbG9ja19nZXR0aW1lCj4gwqDCoCBjbG9ja19nZXRyZXMK
PiDCoMKgIHdhaXQ0Cj4gwqDCoCB3YWl0cGlkCj4gCj4gYnV0IHdlJ3JlIGNlcnRhaW5seSBub3Qg
Y29uc2lzdGVudCBhYm91dCBpdC4KPiAKPiAKPiByfgoKSSB3YW50ZWQgdG8gc3RheSBhcyBjbG9z
ZSBhcyBwb3NzaWJsZSB0byBzdHJhY2UgaGVyZSwgYnV0IEkgZG9uJ3QKcmVhbGx5IGhhdmUgYSBz
dHJvbmcgcHJlZmVyZW5jZS4gSSB3aWxsIHNlbmQgYSB2Mi4K


