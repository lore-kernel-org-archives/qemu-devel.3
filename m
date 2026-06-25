Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECC9CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktP-0006j8-Jx; Thu, 25 Jun 2026 10:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktM-0006iJ-EY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktK-0008TN-Pq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k4i12048176
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=; b=mGaUqRuvG4OFSjZG
 scj0HrMRSpxzcbvp6YH8mGL5UzU4eJEx0gzEHOPeCscb0yFR/xGrmRBJHSybTb6F
 v36TepPDJCRuTHVYEwE/cr6Cr6a13U66AZFFdoFMvRR/kuoDMiFBlU5bhtlyEsVd
 cDtMis4qgReMOTIEBYxivvns0b9F06/g63A+5TTUz7BELQxDW971NtLxo6xKJJk8
 6LNYq2L1gUAFvnQEQAVEULImbTM/2s2PzniOWu64S/tu2d73qo+nIHjnuXCLLa82
 OWkwicf9D4kjmmGuTquoqMSNynuB3fF5iYHj5BEaeImuCCOMG+avk7XevKjARTxd
 mQt7Gg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqjf3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so2299075eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397026; x=1783001826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=Fy+gOyPp/7fdRelYKem3n/u/y84UCHhwmhAehc2sH7XpP2+oykGk4K3KsEft5edi1j
 kNXkQuxtU9aRJJmaCmYQ/ITj5sPVH7EAf0T1pWKcuyWmmRMbRGQNWt5vTo7Q7nvPpncB
 sbZk1GU41Hn7DMv+renl+s4CKlzUrOKuS94Lkj0fSKM1FK4RxZCFyl/UpLfLGp9KwVH0
 ydojK0TU9YE89dA5HLwZBliM8DVWQ6Rf+nIXcZj/UWSL3xX1otaOG18db3mQZmFec/wm
 /iTj2YqpZQkGx0tEkRzOkBo83TjDSdJSMw2JMeSOLMpSsOs9YkOZQSXhAAMvnnny/RIj
 J98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397026; x=1783001826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=ieG5Vg2ZVwjjb7OlzWDM2CPYFwtQzWe4o46gfR8BApO/yKc//cDRJufrB/3O1eUX8r
 O2HMIMtGrPMwGqha+L6Wk+LLAWmp04lzhb3TVhCpA8mpBS1P2CRfCVbGXpxLGQEWB6tq
 9KQNh3xZFMko6nshJZp000uRvqdJQGK6ojp54BQkPHU0ZcWXYO0eMvzsD/Lb9J+hUMcU
 kyxfhzKbuZ0rPwwdKgvfyN1jTokz7QYfk3K4oM42IpluC1O35lSEBPG12LvPKWLJ+UsA
 OcGm2GhoLHDRvCmJc/Rv9CyZ6QXIuhbcb9tMZhr+KbxMHLcliUY7KakZPkYLRVc/xd1w
 3Elg==
X-Gm-Message-State: AOJu0YzMU4fn17qgu8WhbWkq550v9K/0T3P5XZOcFblJsKTVODsrYZ2M
 m6bcB9JfdW6Bi1wM+opg7WWmEw9lIzSqzfsLJ5cuQdqoRdxTCLjZQHi3f1jf0ROQi7mObRpH067
 DMs+CO4Ze4MWyS84obL+06gd70EIFY8KHVCaKaZQTLLgLHBUjE4cxKoJbr9RTlGDk2w==
X-Gm-Gg: AfdE7cl3VyHlnwBG8RFGEArM+LpymD0UK5TAMeRUxzGCn41EOOLoJ+Cegzz3KsN2OXp
 NXTte+lmTSdQ10vOVzqJwR3q3KNhmN0PolJ62C2De2Ll82zBLazmtWwrlPmgb4OLPv62rtaET+v
 Ob7bck/Tb5jeIU7piGCYLaQlAv2kHRR+SRb+59KtF8lwkETc0znx/LnQ0kHZi5VeU0492U++Wma
 B3X6xp/wBSKL9aqJQcTgSN5ik9QSdA9Oezp2xXl4Lf4h+tGKOYQiLy5krxAwtVpYuZ5cgIhLmQq
 c9yP7pAVO130we43aj+2g9pO2dtfSOfA1iDxK49JsEId9sGkTCD2igMAxbJIUNePuJ6+BgsSLOE
 eusRYW9bYebKzkIdLZWyHFRDi9innSL1XHDryw9k31xtkRWTQBy/cRcftFQw=
X-Received: by 2002:a05:7300:2321:b0:30a:e52d:fb27 with SMTP id
 5a478bee46e88-30c84b84f6dmr3264581eec.11.1782397026109; 
 Thu, 25 Jun 2026 07:17:06 -0700 (PDT)
X-Received: by 2002:a05:7300:2321:b0:30a:e52d:fb27 with SMTP id
 5a478bee46e88-30c84b84f6dmr3264423eec.11.1782397024812; 
 Thu, 25 Jun 2026 07:17:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 13/76] target/hexagon: Add guest, system reg number defs
Date: Thu, 25 Jun 2026 07:15:30 -0700
Message-Id: <20260625141633.449487-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 0gUENbOlLFNWJP0ciloyXZsvqzxtOQ3M
X-Proofpoint-ORIG-GUID: 0gUENbOlLFNWJP0ciloyXZsvqzxtOQ3M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX8UktwxPJs+2K
 CRATXiXo6gsRod2gFVd6e++m0BkvQweZKwW/fIWnmnI5bqaQRIRfc969bjc3EmjNCxqDFJIXd9D
 DLftYT1rcW2zzmCVpmlBzQhkboimeMY=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d3863 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1O8jGhpnVxV5
 GVgY7Hz8iOluArVQk0QYf5PnrNs3Jf9Y5GFxUWiINoTOq7IdxfYn2MOwtDXOCoDL/I+IZMSz/Vb
 QAkw0zhhspTi/9+AYvw+lVgOapGm+Bevj19AmJJ8dqXOUvpb/7AjkGWTy3sK/MDUJ8t1z2MO3iy
 btAMNGTCMe2VEaV6w9MKHrXoF5/aHfh6S7Tt9mJx8LxsVBlCviQqhPHPf07Y4pkppwwFR4RMUAe
 xbHNWmv+rGTjzNAaIbssJ7/g46Ld3G+n8ZvbyADIwpA7gkXt1HxMXuxsZeJ20TmyWJ40NefapzE
 Nsyn5PBccPmyywwII7+uVorTaeMuuB7LKoEU78HH/dZzh6eFgJzlVdkORG2hYEthixME1jAbQP7
 eiqXzgDg3xVW8O0t5uICL01aLrtohYYT9zE6RIy52TgDatXZl1B5SwzlghB6OQ7I/R3aOdG53oM
 s+EHDIU2e9yiZYViWaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgIDcgKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIHwgMTE3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQv
aGV4YWdvbi9jcHUuaAppbmRleCBlMjI1NjdkOGU2Ny4uZTBjZjg3ZTVhNGMgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMCw2
ICsyMCwxMyBAQAogCiAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC10eXBlcy5oIgogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdfV1JJ
VEVTX01BWCAyCisjZGVmaW5lIE5VTV9TUkVHUyA2NAorI2RlZmluZSBTUkVHX1dSSVRFU19NQVgg
MgorI2VuZGlmCisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29t
bW9uLmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKaW5kZXggYmRk
ZmMyODAyMWMuLjIxNGI3YjhmZGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVn
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDEyMSBAQCBl
bnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hF
WF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBc
CisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwg
ICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwK
KyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xF
XzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hF
WF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMp
IFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdD
WUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVD
TF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAg
IDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JF
RyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisg
IERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05U
MSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVY
X0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUg
REVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhf
R1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVT
Cit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKwor
I2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZh
bCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVt
IGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdT
IHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIK
KyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVT
OworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xf
SEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19V
U0VSX09OTFkgKi8KKworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitlbnVtIHsKKyAgICBIRVhf
U1JFR19TR1AwID0gMCwKKyAgICBIRVhfU1JFR19TR1AxID0gMSwKKyAgICBIRVhfU1JFR19TVElE
ID0gMiwKKyAgICBIRVhfU1JFR19FTFIgPSAzLAorICAgIEhFWF9TUkVHX0JBRFZBMCA9IDQsCisg
ICAgSEVYX1NSRUdfQkFEVkExID0gNSwKKyAgICBIRVhfU1JFR19TU1IgPSA2LAorICAgIEhFWF9T
UkVHX0NDUiA9IDcsCisgICAgSEVYX1NSRUdfSFRJRCA9IDgsCisgICAgSEVYX1NSRUdfQkFEVkEg
PSA5LAorICAgIEhFWF9TUkVHX0lNQVNLID0gMTAsCisgICAgSEVYX1NSRUdfR0VWQiAgPSAxMSwK
KyAgICBIRVhfU1JFR19HTEJfU1RBUlQgPSAxNiwKKyAgICBIRVhfU1JFR19FVkIgPSAxNiwKKyAg
ICBIRVhfU1JFR19NT0RFQ1RMID0gMTcsCisgICAgSEVYX1NSRUdfU1lTQ0ZHID0gMTgsCisgICAg
SEVYX1NSRUdfSVBFTkRBRCA9IDIwLAorICAgIEhFWF9TUkVHX1ZJRCA9IDIxLAorICAgIEhFWF9T
UkVHX1ZJRDEgPSAyMiwKKyAgICBIRVhfU1JFR19CRVNUV0FJVCA9IDIzLAorICAgIEhFWF9TUkVH
X0lFTCA9IDI0LAorICAgIEhFWF9TUkVHX1NDSEVEQ0ZHID0gMjUsCisgICAgSEVYX1NSRUdfSUFI
TCA9IDI2LAorICAgIEhFWF9TUkVHX0NGR0JBU0UgPSAyNywKKyAgICBIRVhfU1JFR19ESUFHID0g
MjgsCisgICAgSEVYX1NSRUdfUkVWID0gMjksCisgICAgSEVYX1NSRUdfUENZQ0xFTE8gPSAzMCwK
KyAgICBIRVhfU1JFR19QQ1lDTEVISSA9IDMxLAorICAgIEhFWF9TUkVHX0lTREJTVCA9IDMyLAor
ICAgIEhFWF9TUkVHX0lTREJDRkcwID0gMzMsCisgICAgSEVYX1NSRUdfSVNEQkNGRzEgPSAzNCwK
KyAgICBIRVhfU1JFR19MSVZFTE9DSyA9IDM1LAorICAgIEhFWF9TUkVHX0JSS1BUUEMwID0gMzYs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcwID0gMzcsCisgICAgSEVYX1NSRUdfQlJLUFRQQzEgPSAz
OCwKKyAgICBIRVhfU1JFR19CUktQVENGRzEgPSAzOSwKKyAgICBIRVhfU1JFR19JU0RCTUJYSU4g
PSA0MCwKKyAgICBIRVhfU1JFR19JU0RCTUJYT1VUID0gNDEsCisgICAgSEVYX1NSRUdfSVNEQkVO
ID0gNDIsCisgICAgSEVYX1NSRUdfSVNEQkdQUiA9IDQzLAorICAgIEhFWF9TUkVHX1BNVUNOVDQg
PSA0NCwKKyAgICBIRVhfU1JFR19QTVVDTlQ1ID0gNDUsCisgICAgSEVYX1NSRUdfUE1VQ05UNiA9
IDQ2LAorICAgIEhFWF9TUkVHX1BNVUNOVDcgPSA0NywKKyAgICBIRVhfU1JFR19QTVVDTlQwID0g
NDgsCisgICAgSEVYX1NSRUdfUE1VQ05UMSA9IDQ5LAorICAgIEhFWF9TUkVHX1BNVUNOVDIgPSA1
MCwKKyAgICBIRVhfU1JFR19QTVVDTlQzID0gNTEsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHID0g
NTIsCisgICAgSEVYX1NSRUdfUE1VU1RJRDAgPSA1MywKKyAgICBIRVhfU1JFR19QTVVFVlRDRkcx
ID0gNTQsCisgICAgSEVYX1NSRUdfUE1VU1RJRDEgPSA1NSwKKyAgICBIRVhfU1JFR19USU1FUkxP
ID0gNTYsCisgICAgSEVYX1NSRUdfVElNRVJISSA9IDU3LAorICAgIEhFWF9TUkVHX1BNVUNGRyA9
IDU4LAorICAgIEhFWF9TUkVHX1M1OSA9IDU5LAorICAgIEhFWF9TUkVHX1M2MCA9IDYwLAorICAg
IEhFWF9TUkVHX1M2MSA9IDYxLAorICAgIEhFWF9TUkVHX1M2MiA9IDYyLAorICAgIEhFWF9TUkVH
X1M2MyA9IDYzLAorfTsKKyNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLworCiAjZW5kaWYK
LS0gCjIuMzQuMQoK

