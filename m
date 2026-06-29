Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4B5C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3en-0005FZ-Fm; Mon, 29 Jun 2026 00:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dN-0002ff-FN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dH-0000mA-2s
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NGSf1719002
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=; b=fpMuHpcbjeDxJogy
 CRTf9Pvj7+b/D2j7MqlB/DBDjeELPVE+h8OsbLvFEB9NvRBDSBGZINfUmThFzWkW
 HHr14nc2l9NLP3wuUP8TUwKIh1HM3UHI15dfYO9pqihy74t8OhZW/8HbwcsucG8F
 mBK7nR/mBNg2vt7XRTmM1rqFXhZuDYgIh6WolmvZ6J4rjO9DYri7XYmmwB6HAFNX
 WFj9wXmWIBuQnSvGxgiqWLMkPYHrAIzNO4ngMkXOzFnwqhpp2yjwMCPSC39jIH58
 jwkWONA2obcAOogbDvQlRXPnJwJDsT0q5x0ThKpkXaDsyEoauEdD3oJwWIx2NLBO
 tRr+5w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf49xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso2802355eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707400; x=1783312200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=WIZfpZXiGMMZS5goqZg1MdvFsuiG1MQXYiAFGDPGKV01EDJC0Bgi0TpUA0agS0wRSL
 1BcbLu+dnnkxmoKqymCItEYrNZuy2B2zc4WkKfBN/Ifvs/DbTi3ZhzYpykLc10apRcpm
 ZaMFonWSOAik3B5906el83U1nAlu29kGmKoAGzF2JpPB3ZdXlWfTjro+FJ44H9t7Smn0
 WtcNVZCHOrZJTNK9Q0m34yQY3cDZAoWbh5lkXUI8l2PXbE/uOeW9/PW+++ToSuLuOLkG
 aBSSqHit+8QOkUfkGI1dyMAL4N7uGHqdjuEmcRMXr444o9P7G/IQYiwp81P2JHtldtV5
 XyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707400; x=1783312200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=q4EbQ8kR/9w8+2Rduwdovxnfs7v07w+SVsCvM+PaWb6AGsDWIawI1F8ypeVhxpInAM
 xN3icEig2kRljnDXgbSprW8R3PSiDVjO7k+HeeSscYuUtS8MEtajIovQ4SG3bCmj9s8s
 Pnsdw4t+mQS5uDVm5NPNjrwmTzpRPLpdfNUHE/Rn6OMXjxYx9umUWj/k7cB/g/G3Cn+v
 eoy74NnWBGpbjlhrETZDb0DhCy3lwGnWbj3bLSj/XX9tvONgEuU5nxgqLmAdetYO+j7H
 bcsISAbLEkndsuCPHiO6x4fgFxli74jb0qmpOZq4u/L8CLjDd3jNmqp0xPvOmfLyLxd5
 hiNw==
X-Gm-Message-State: AOJu0Yy+LvRiL+kyaaG9ooZ5SVq5arDK52VtPMck31buq/0ExU1dfXRq
 rx268cVndw2sK8HB7/LOBA4b73a/R1o99GIWuPs1x2WTuUoHIiU0Ocp+7CaeOJIFqmv+ldml16/
 9eIqlt38nds3y7vPgUC3PuBDPTIzSZz7z96tNacnKQVcSRUK1wf1WeGmIRHa+UvxhTg==
X-Gm-Gg: AfdE7ckx/QceTX0crjb4eNmtbK4CWXNr9yl17x6yifNITWW4Ku9LXkwIn49mrDuBpjd
 wEfoF40JewTkEhAEiTDdy4yisRiFOhM0BLQxGxpfA4s3p4KjTIxkmG+XmEF2OkHfUArO0dNtyWt
 i3/hLG1jg8lCLkoQuFjXOsqBVd3/ygqG9I6i2X06pZoH6KJvgogkLma7FY+lvHOisJYpwjlcu4z
 vamSpFYyuKDZQTFFI9Fs5O7TUmDT0+bPVR92vr6oiO+Oud+xePiVbZjgriShjaskEpgV66pkG3g
 4OODaFBgreMBcicHqY95Sdf3/8zUt+MG49aR5CsLEu8iEJ13zdGVP3eyymUy2tv2dJ5JWy59dNt
 ryN3sLc1rFza96zsp9fynCM12k4WFj/oQFh4VdJYo1VIWSmEXxZ9+sM8DqmI=
X-Received: by 2002:a05:693c:880b:10b0:30c:b0a8:c9b7 with SMTP id
 5a478bee46e88-30cb0a8cb0bmr5159012eec.41.1782707400188; 
 Sun, 28 Jun 2026 21:30:00 -0700 (PDT)
X-Received: by 2002:a05:693c:880b:10b0:30c:b0a8:c9b7 with SMTP id
 5a478bee46e88-30cb0a8cb0bmr5158999eec.41.1782707399627; 
 Sun, 28 Jun 2026 21:29:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 55/77] target/hexagon: Implement setprio, resched
Date: Sun, 28 Jun 2026 20:58:08 -0700
Message-Id: <20260629035830.1520296-56-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX8CwNmCsLzKyt
 PUzYYkHQ7+djUiv9TXdfGvMhL23TYYDgJ4o0Khsd8sG6uicRjNb/gT0nz7PlFbCgZ+DhtYVT+0Z
 gDAWwuQMoq26TmMt4IOLh3LK4V0dI4c=
X-Proofpoint-GUID: 1Ah82UEw5OARMp_bLpqq4b998qYA7BiO
X-Proofpoint-ORIG-GUID: 1Ah82UEw5OARMp_bLpqq4b998qYA7BiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXz0G+pF5VNME1
 taC/3g26OEH3eDv2a5436gUXCer9vQGG8CVlaE8hyEIy4mH2VrFOrqvydNtyjfWYYI2lMmu7ZGO
 EpVTSf8ahbgLhJ0QcQ7R92arAVZ42gNiyPieduwxGmw7E+ICrE5qG3lr0i+mZN8WjlGqunqq704
 K2u5BxLqLIAJS7u7ZucJeQqMvmch2Wh4RxmV6hZar25nmVhBCWyt0soQFuUEL3aaRGbUM/tYzrl
 Tilcw/pMs3EaaSO8sMaVyMMgSR8iI6c73XeoICzWa9Vd4BP+Of3hekKajEayobRD/1FGnECZFhj
 ecrwRIEcjYe1Dlmb3+E6yXDJHTIAFGXmuy0ucxCLP4C3lj4gUj/DHp0Atu4vPe3edrVbeuZSEsE
 TQs8CP6om2wFcIWkdwYQ3rekZSdaFThpZHwQpDCCC9w0gyeI4dXIkYD6S2FPlnm4yr1OxXvvvz1
 BjolhfFIrwO8FIj4tqw==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41f4c9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDM0YzU1YjU2MGNhLi4zYzI1
M2IzOTFlNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE1OTAsNiArMTU5MCw2NCBAQCBzdGF0aWMgdm9p
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
dGUgKmVudiwgdWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTgs
OCArMTc1NiwyNyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25T
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

