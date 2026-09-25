Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E2FC98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9O-0004wx-44; Thu, 24 Sep 2026 21:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9E-0004ul-Q2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v97-0005rq-Ew
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1knqx3751792
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I2fWHups4uPXskmv7tDTi4PsWfpjzo/2boZHYy4P3ZM=; b=gB6YbVvcmmhdxAfG
 gcv1+HHSXd5giflz+F/N5UlAH5DRiMQfGJw55yppUFnJ0BA1tikTerZuIoXS1gYR
 5J9KWwhtKWQqkI5fhmhxPGR6aqVj6nqe3O/MqHln7Ug3U/dCNipC26qAqdJcVISb
 6368iwskOAmQbiyuyPQex1WHNjFjh0fkJuc8ZMpMN9PVd2wrBzgJMTLye4C/iH+5
 mHlhI0SoTDfDLz7UHfqZjFpcqO1b/UmJHCaCWOF7tHl40TKQMNVZXWxSrX0crqvX
 W15oTxXg/fgnSni7OInM99Hxe7GFupL9k4vyMNejSKpccr4/b9Dw5i/Cb58CSHYG
 Wh3YgQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8tcmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-334f782d1abso1522858eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301279; x=1790906079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I2fWHups4uPXskmv7tDTi4PsWfpjzo/2boZHYy4P3ZM=;
 b=X4W5Z2o5PY8HgF54bZqsELDkKp37aG4SZaMLOTSdZ/zoSwL82UO53BosgDh/Ai6PQy
 SC3rzuCN3LQiCm8klrdPElg7r5ermR1j7dBgWIdIROZGQAUSGhkaG0BIcErWKYI4rZ6G
 CibDITFva94YFTzi4gcR7P0uFjuHMRRFINYadLwKZeFB2CRRCZgFPorKZb8kcVpnzO8F
 p5wBlHz53E/2RUrBQrJWIX/MwJp25x5ZJyDQN4Gg6Cy18pwWCplSxigfvj7pKJCVgXse
 iaGJ6UzKQsRhN5ESMS2ZJynQUXoXCi32IIuo55qm5zk90gFPXYfQomAoaAP4sprS1MDu
 PC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301279; x=1790906079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I2fWHups4uPXskmv7tDTi4PsWfpjzo/2boZHYy4P3ZM=;
 b=e5gIA5qMWx/u5ntKGzp9G5TqEtP36s233Or6oTl1oo5V1zg9/c5o1c/b4WeIyuibvB
 +Y5SvUX+kfNGZZHkFy2VSrMt1/t6wLJQd8X79nLaz3Ax2rQY7XHm+dEM2XJ/2UPhh6UG
 jHAe3vvDt8enW1RO14mT3NzOIfPE16XGJP3SGgMSXpaIbi3xJ6uylsby6NADTtlgE5m6
 1Sv7qoZXc+2BAwquLNyiT/9HqN/q4OEimXBEaanm60a5Qmgi/WIB67k8B/CZ/BpWTb3Y
 rJ4J62dSzoTfsd5RIyX5o5OoTJZQN+Dn6C2NBdIEeLDyIugIPo4jjdSMeVINgFvVFIkp
 N2DQ==
X-Gm-Message-State: AFuF++kIfLnDiortRa3Jb6E2V2dmyG76O/QbwetkxUO+ox5AbTOmW/ML
 b1oTZ3T2tmKVHKp4KESvClLAXBl4FpBZncJzQySF9MvMS3ftYot+SQ4voVFdJPUqO0+OtrR522m
 Tvx4sQ1vbT2Bko7raHkhAod22fRK2mjLzlrI9cPU8rpDRbhtT/cf/3RwoKieDi+NXxg==
X-Gm-Gg: AYBFou1wgUcVGzufc+43LjZhn9hpJLH5YhfByb0gezljA112XAglMIVKNXe8tDhBs4a
 yacr3hELVdAFNTv1YtGP7iAVsTwekJB1I7GPNnaXRdcdFbupBJZmSZSU2TAxtYTNoxpGNNkuqZS
 NAhBVVT7AL/Ts72iPld7vfCb2HfeY26ZMLC4nUswzDKJch7KfEVeXcc0w5Njl1EaSBJlMZVbbyr
 2aURYod4mRN2YWxBeD3yhbUauFKlLShv1BKQiKTzEqUSIaoPIws48a+qvgUwLYqc31S8ZUQ/8bL
 WIrqPvyEpzshrYEao6LJ7wy++OBmxsltNCa+R4K4k69xhZGD/W90+O9zpY3xifj0Vpv3SFFv9vv
 QeSGAA4n98yuzh2q5cmGB+iBu+qjyUt8g6L2MptuAiDyexsI=
X-Received: by 2002:a05:7300:169b:b0:340:dca6:f34e with SMTP id
 5a478bee46e88-340dca6f75fmr1905476eec.40.1790301279362; 
 Thu, 24 Sep 2026 18:54:39 -0700 (PDT)
X-Received: by 2002:a05:7300:169b:b0:340:dca6:f34e with SMTP id
 5a478bee46e88-340dca6f75fmr1905438eec.40.1790301278226; 
 Thu, 24 Sep 2026 18:54:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/40] Hexagon (target/hexagon) Check for vreg multiwrite in
 analyze_packet
Date: Thu, 24 Sep 2026 18:53:53 -0700
Message-Id: <20260925015429.2579174-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX+1IrNulGu5cy
 nUGx5gDgSiQaMj6WuPyBpwvWQsLo1twsYHMjJfoUnkuUL+WstOH9IC/hLrU1lDCq7w6GaYzHPW5
 K/l8RHc6ibzzBiAaCHVT/ps3dOTdMl0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXz/RxhQCD8pfw
 e2QUANrhUMSFDW11v7NhUSSFb/DC9KPIzSSmvIO1wb/6g73GiAO1LFDxajKCf7eXA4D/SEJD44a
 eufwf7oPkxZlI8oa/UaBgxiAJVbz2D0FOn8KAhFGatc7WCS6oDRUCItzEAnxfD5EnzfRh6xma19
 hD/V8joMRI6jZlsTwpgeQ2Yk1QhAWAYW9d5xXl58rk/XzEfpCJasbhO8HQw1ISUYYeCNalS8j/c
 ky4dA02v+8LWDBx4v4ugLYN7Ulm54esafz+sePiV61xb57a7LHWP/J3sKoWGO57Q3Jl4IwEtcrc
 7cK2G0lp9cHQpMhfm/5YqoLrhDSAnielGHcHw0+fvfn2SbTO6aQ2puUl4+ABqlJZxJNr+sUlY7x
 8Ng1F8B8SNlxK1L7w8VuJSEJ0+ws7Fp3tPRjb2rdhmMUtl0JjSguY6iqYxCUfnvoEbzJ3McssZ/
 v1K8lCGwZHHKcz58IsQ==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab5d460 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rweD1h4czDRuSoyrQo4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Ptt9H5oPYZOeJP2-p9bToa74RauVqrwm
X-Proofpoint-ORIG-GUID: Ptt9H5oPYZOeJP2-p9bToa74RauVqrwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggfCAxMiArKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jIHwgIDkgKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDk2NGU2Y2UwYjc4Li45ZWU1
ZjI1MzY1MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTcwLDYgKzcwLDggQEAgdHlwZWRlZiBzdHJ1Y3Qg
RGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUCh2cmVnc19zZWxlY3QsIE5VTV9WUkVH
Uyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9mdXR1cmVfdnJlZ3MsIE5VTV9WUkVH
Uyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF90bXBfdnJlZ3MsIE5VTV9WUkVHUyk7
CisgICAgREVDTEFSRV9CSVRNQVAodnJlZ3NfbXVsdGlfd3JpdGUsIE5VTV9WUkVHUyk7CisgICAg
REVDTEFSRV9CSVRNQVAodnJlZ3NfdW5jb25kLCBOVU1fVlJFR1MpOwogICAgIERFQ0xBUkVfQklU
TUFQKGluc25fdnJlZ3NfcmVhZCwgTlVNX1ZSRUdTKTsKICAgICBpbnQgcXJlZ19sb2dbTlVNX1FS
RUdTXTsKICAgICBpbnQgcXJlZ19sb2dfaWR4OwpAQCAtMjE4LDcgKzIyMCwxMSBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY3R4X2xvZ192cmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LAogICAgICAg
ICAgICAgY3R4LT5oYXNfaHZ4X292ZXJsYXAgPSB0cnVlOwogICAgICAgICB9CiAgICAgfQotICAg
IHNldF9iaXQocm51bSwgY3R4LT52cmVnc193cml0dGVuKTsKKyAgICBpZiAoIXRlc3RfYml0KHJu
dW0sIGN0eC0+dnJlZ3Nfd3JpdHRlbikpIHsKKyAgICAgICAgc2V0X2JpdChybnVtLCBjdHgtPnZy
ZWdzX3dyaXR0ZW4pOworICAgIH0gZWxzZSB7CisgICAgICAgIHNldF9iaXQocm51bSwgY3R4LT52
cmVnc19tdWx0aV93cml0ZSk7CisgICAgfQogICAgIGlmICh0eXBlICE9IEVYVF9UTVApIHsKICAg
ICAgICAgaWYgKCF0ZXN0X2JpdChybnVtLCBjdHgtPnZyZWdzX3VwZGF0ZWQpKSB7CiAgICAgICAg
ICAgICBjdHgtPnZyZWdfbG9nW2N0eC0+dnJlZ19sb2dfaWR4XSA9IHJudW07CkBAIC0yMjksNiAr
MjM1LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfdnJlZ193cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwKICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgtPnZyZWdzX3VwZGF0ZWQpOwogICAg
ICAgICBpZiAoaXNfcHJlZGljYXRlZCkgewogICAgICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgt
PnByZWRpY2F0ZWRfZnV0dXJlX3ZyZWdzKTsKKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAg
IHNldF9iaXQocm51bSwgY3R4LT52cmVnc191bmNvbmQpOwogICAgICAgICB9CiAgICAgfQogICAg
IGlmICh0eXBlID09IEVYVF9ORVcpIHsKQEAgLTIzOCw2ICsyNDYsOCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgY3R4X2xvZ192cmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LAogICAgICAgICBzZXRf
Yml0KHJudW0sIGN0eC0+dnJlZ3NfdXBkYXRlZF90bXApOwogICAgICAgICBpZiAoaXNfcHJlZGlj
YXRlZCkgewogICAgICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgtPnByZWRpY2F0ZWRfdG1wX3Zy
ZWdzKTsKKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHNldF9iaXQocm51bSwgY3R4LT52
cmVnc191bmNvbmQpOwogICAgICAgICB9CiAgICAgfQogfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAwYTcy
MjRhOGUwZi4uODViNTQwNGZjYzQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01OTEsNiArNTkxLDggQEAg
c3RhdGljIHZvaWQgY2xlYXJfcGt0X2N0eChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBiaXRtYXBf
emVybyhjdHgtPnZyZWdzX3VwZGF0ZWQsIE5VTV9WUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4
LT52cmVnc19zZWxlY3QsIE5VTV9WUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNh
dGVkX2Z1dHVyZV92cmVncywgTlVNX1ZSRUdTKTsKKyAgICBiaXRtYXBfemVybyhjdHgtPnZyZWdz
X211bHRpX3dyaXRlLCBOVU1fVlJFR1MpOworICAgIGJpdG1hcF96ZXJvKGN0eC0+dnJlZ3NfdW5j
b25kLCBOVU1fVlJFR1MpOwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cHJlZGljYXRlZF90bXBfdnJl
Z3MsIE5VTV9WUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5xcmVnc193cml0dGVuLCBOVU1f
UVJFR1MpOwogICAgIGN0eC0+cXJlZ19sb2dfaWR4ID0gMDsKQEAgLTYxMCw2ICs2MTIsNyBAQCBz
dGF0aWMgdm9pZCBjbGVhcl9wa3RfY3R4KERpc2FzQ29udGV4dCAqY3R4KQogc3RhdGljIGJvb2wg
cGt0X2hhc193cml0ZV9jb25mbGljdChEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBERUNMQVJF
X0JJVE1BUChncHJfY29uZmxpY3QsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgREVDTEFS
RV9CSVRNQVAodnJlZ3NfY29uZmxpY3QsIE5VTV9WUkVHUyk7CiAKICAgICBiaXRtYXBfYW5kKGdw
cl9jb25mbGljdCwgY3R4LT5ncHJfbXVsdGlfd3JpdGUsIGN0eC0+Z3ByX3VuY29uZCwKICAgICAg
ICAgICAgICAgIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CkBAIC02MTcsNiArNjIwLDEyIEBAIHN0
YXRpYyBib29sIHBrdF9oYXNfd3JpdGVfY29uZmxpY3QoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAg
ICAgIHJldHVybiB0cnVlOwogICAgIH0KIAorICAgIGJpdG1hcF9hbmQodnJlZ3NfY29uZmxpY3Qs
IGN0eC0+dnJlZ3NfbXVsdGlfd3JpdGUsIGN0eC0+dnJlZ3NfdW5jb25kLAorICAgICAgICAgICAg
ICAgTlVNX1ZSRUdTKTsKKyAgICBpZiAoIWJpdG1hcF9lbXB0eSh2cmVnc19jb25mbGljdCwgTlVN
X1ZSRUdTKSkgeworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisKICAgICByZXR1cm4gZmFs
c2U7CiB9CiAKLS0gCjIuMzQuMQoK

