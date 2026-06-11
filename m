Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC436CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3E-0002O1-Op; Thu, 11 Jun 2026 01:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2o-0001cg-EN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2l-0002et-M9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GIbq3791680
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ty/tA69kdT3qwefOUDstB5gezYmZn16SypwyYTX8xbg=; b=i8n0Px3xgkC+Qbd0
 nnZI0+kT2JKJgld1+0DRwx37nGi0gqLFvgx+iV8KKNVKnfGeyUG0bv1kxhPdHI5r
 6UsH007PudClLK1F0f+nWkmaGLtEc9UulAz1y108nAL+qsjJoWBmJmRdS5NaD37j
 K8d4a5GsSkqPPfNTweGc7OPnBtNx4rVUGcHVQuuc9fK6TZyqCRBqWgO/g/98sw7u
 ewuAyemLXYn/V5I0wkOJW6TIISxUmC+d8UM0ANrvC//zAp4egcRWL4Qe/mQCF0E4
 V2umNQi4A2SISOqduT0YPg97JC4Ir7NILx2YqS/TUWQjRyHb8i07ksFDn46B+/yk
 Liu3og==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701skn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307625ee07fso11482764eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156000; x=1781760800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty/tA69kdT3qwefOUDstB5gezYmZn16SypwyYTX8xbg=;
 b=PEEn3CHYO2D5exZihnJMSmM2SvqMmHK4MMv4ojoU7WHcC/3SgdMkIdtf+4rXlbVl13
 9mieHT6fqKTJkFnrvWcewqKuwRvhSxdNRcafH4ncNiFOkrUZlAy7dvTn0SQe+xLhnSW6
 siBJ/ShmBuyKdmKaN7MpeA46cGhMsRWypbImZ85cq2ppRZWoLsq0mNDOq5OMSaYK1OTc
 2lmd+/08+VAOxkmXgaASyjUnGEDJyF3sYTAh77EJlKRFQju9tJ3F2jAlmDVnLsiTyoGH
 2/RYd7znGfHjuMLMZM8aKPinhhGKrQY6As8xWe5IhgBrKLRMI2HwQBvLpM4WhJbCD9qQ
 SDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156000; x=1781760800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ty/tA69kdT3qwefOUDstB5gezYmZn16SypwyYTX8xbg=;
 b=N2DnBYDhDEvhKGLuoT10YKE8uE/eAopcHyDt567aK7KQOJjmVJ8VJKXhKU27tAO9Jt
 fSYbhf1G/rKoM2EWrpm9Ea0sSc9Mwo960kcJ2RlbtXL3Dv+cq8oiQgQL/tOZ04mdZsnR
 s0HyxIes2pR1sDasOiWTVFQF8KtddfCB1yzyUCEjNuqZv7zUQzA7ilBXmil1VlI6vJxC
 q7D9C8O9r3ogG56rCn4Xn0gkT8QhEkbQav4NL+lKfmTKvYkOffl3tFQ1rKqoinTGXdGa
 BJseqnKmZ2SGF1Qhbw1P+6DcNmA6yg3g7AavGfus8wAW6JlXdGqBBAITzzcm2GysXzQr
 HnUA==
X-Gm-Message-State: AOJu0Yz1d1hxjcXJ1f3dlxMS5VtmQFbIIKbjnZqzKErJjyuFVh/VkHRJ
 gluEG0vGyoujbT58JvZGa+vq3yt0EpRPul+nczK3kMRiR/tVOZ7OPzWBFQb9oc76yFfzfbVcDTO
 4mEt4rl3L97vO2oi9kuDTL6KMakOmkejSOGMyBE9UweS+VZRLmcNvv8yyg1IsYDOXDw==
X-Gm-Gg: Acq92OGIr0Syf2pXg7w/q7DQOC2J8nmCijCit+zrZUmBF7DpxDoHpgns9PSZ96vvlcb
 /bLe2eSKJr3QgWi/VZoofoXwqZDL4qqrxLi1yy58C21DOG1Px+Rtumkl8dUgsNX5QqR9a0JCO/3
 dEkWugog+6HSyQhEboI11TC8u0rTkal61s9QiecyWPEI/OdbfHWfNkqJPzQOYLyTuZyxYq7kvTb
 YTFakBd5zlTT/dHzHGVM6wU29m8JCIDzwSdme8dQrUzzdm+w459Pgg5FdlPeuZ+y5U1RoUI0PEI
 MVZO21fNWe1h4s9oRIAbG/Yue0ue0+yRHRDeO8s/vlaiLBn01+8ew+J1t428ud4bnKcVkHXH9HO
 chV++l0dltJkol1h8F2/j3eKDA3/fH2i8u0KI5WCCKZa5jB5LGXiXnwBpBj+y+O99MkEvFIaTMQ
 WFHsyK
X-Received: by 2002:a05:7301:168f:b0:302:e560:afb5 with SMTP id
 5a478bee46e88-308049ebddfmr1108179eec.18.1781155999147; 
 Wed, 10 Jun 2026 22:33:19 -0700 (PDT)
X-Received: by 2002:a05:7301:168f:b0:302:e560:afb5 with SMTP id
 5a478bee46e88-308049ebddfmr1108144eec.18.1781155998534; 
 Wed, 10 Jun 2026 22:33:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement setprio, resched
Date: Wed, 10 Jun 2026 22:32:36 -0700
Message-Id: <20260611053249.3918491-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX31kLvUArNlvA
 BZ1/p3zx35eUulIZwG15kjBru8tQ6MvVg34rONCDQMHuV/X+HV/FF7FFJ/h8bvn5Tp93uLCSii5
 QxG9D3YsMq8Rkd7lszj6S/9iMTvo/t+cNx2xalm1Q3+r/wsW6vQZigsrv0eKR/jupfFsScAGUaP
 6HxIbYngXTAESalYt1m0oiJbnayaGVGc2bd7oVCrvdAqA6lAAH2NHEJcCpAjzSNkJ5eVz/s9c5J
 keIkHdbMeF6X8h9c65HUi9a5Vp8D9TeOwsvHfJ8hzkQmktLkJxh8fvYkO/4O5sVVY0D6nOqcr+9
 iKyDlU+WHrnmBVzQn9IdxR2q2dAMeQ0UJeSszs4gQePg1fUtQTgfJUh3iU24MQtjyK2BLrFCiqq
 bEqUk0vh+3OBG5AwDJMxNJ69+Gi73RTbEu6CURFdVeey61/jhLtfjBwFQJsU8kSfUgbrsfYQ9//
 f9lnM6qPMJ5lvQ46WaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfXwGDema5LFID2
 td+vbaaul03mAyycBzTM07y0aY3HSTTHciqSWXlf00zoCht8M+BZPUJEjAgieOuW+AWSa/RZivq
 jj1Fn/VREqQOrfrpyaIB3mw1+IUZsCA=
X-Proofpoint-GUID: SHvohswYXIaaEvnjp1SdZdfXDAaNYAGY
X-Proofpoint-ORIG-GUID: SHvohswYXIaaEvnjp1SdZdfXDAaNYAGY
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a48a0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDJiYzFmMGQzMTNiLi5jYmM1
YTYwNGMyZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE1ODksNiArMTU4OSw2NCBAQCBzdGF0aWMgdm9p
ZCBoZXhhZ29uX3dhaXRfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykK
ICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMg
aW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCit7CisgICAgdWludDMyX3Qgc2NoZWRjZmc7CisgICAgdWludDMyX3Qgc2NoZWRjZmdfZW47
CisgICAgaW50IGludF9udW1iZXI7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVpbnQzMl90IGxv
d2VzdF90aF9wcmlvID0gMDsgLyogMCBpcyBoaWdoZXN0IHByaW8gKi8KKyAgICB1aW50MzJfdCBi
ZXN0d2FpdF9yZWc7CisgICAgdWludDMyX3QgYmVzdF9wcmlvOworICAgIEhleGFnb25DUFUgKmNw
dTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lO
VCwgIiVzOiBjaGVjayByZXNjaGVkXG4iLCBfX2Z1bmNfXyk7CisgICAgY3B1ID0gZW52X2FyY2hj
cHUoZW52KTsKKyAgICBzY2hlZGNmZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TQ0hFRENGRywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgc2No
ZWRjZmdfZW4gPSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsKKyAgICBpbnRfbnVt
YmVyID0gR0VUX0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCBzY2hlZGNmZyk7CisKKyAgICBpZiAoIXNj
aGVkY2ZnX2VuKSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBDUFVfRk9SRUFDSChj
cykgeworICAgICAgICBIZXhhZ29uQ1BVICp0aHJlYWQgPSBIRVhBR09OX0NQVShjcyk7CisgICAg
ICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOworICAgICAg
ICB1aW50MzJfdCB0aF9wcmlvID0gR0VUX0ZJRUxEKAorICAgICAgICAgICAgU1RJRF9QUklPLCB0
aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfU1RJRF0pOworICAgICAgICBpZiAoIWhleGFnb25f
dGhyZWFkX2lzX2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOwor
ICAgICAgICB9CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0
aF9wcmlvKQorICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9w
cmlvOworICAgIH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19CRVNU
V0FJVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7
CisgICAgYmVzdF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7
CisKKyAgICAvKgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2Vy
IHByaW9yaXR5IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RXQUlUIHJlZ2lzdGVy
LCB3ZSBtdXN0IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJydXB0IG9uIHRoZSBs
b3dlc3QgcHJpb3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dlc3RfdGhfcHJpbyA+
IGJlc3RfcHJpbykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAg
ICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAldSwiCisgICAgICAgICAgICAgICAg
IiBjdXIgUEMgMHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKHVu
c2lnbmVkKWludF9udW1iZXIsIGVudi0+Z3ByW0hFWF9SRUdfUENdKTsKKyAgICAgICAgU0VUX1NZ
U1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX0JFU1RXQUlULCBCRVNUV0FJVF9QUklPLCB+MCk7Cisg
ICAgICAgIGhleF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgMSA8PCBpbnRfbnVtYmVyLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CisgICAgfQorfQorCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTcs
OCArMTc1NSwyNyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0K
IAorLyoKKyAqIHNldHByaW8vcmVzY2hlZCAtIGhhcmR3YXJlLWFzc2lzdGVkIHNjaGVkdWxlciBo
ZWxwZXJzIGZvciBtYW5hZ2luZworICogdGhlIHJ1biBxdWV1ZSBhbmQgaW50ZXJydXB0IHN0ZWVy
aW5nLgorICovCiB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogeworICAgIENQVVN0YXRlICpjczsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdv
bkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3Rh
dGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAgICAgICAgaWYgKHRocmVhZCA9PSBm
b3VuZF9lbnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5k
X2VudiwgSEVYX1NSRUdfU1RJRCwgU1RJRF9QUklPLCBwcmlvKTsKKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogdGlk
ICUiIFBSSXUzMiAiIHByaW8gPSAweCUiIFBSSXgzMiAiXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgcHJpbyk7CisgICAgICAgICAg
ICByZXNjaGVkKGVudik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICB9CiAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

