Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633A4CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNX-0002bt-2C; Thu, 25 Jun 2026 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNP-0002b4-BC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNJ-00005N-8V
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jtDb3077408
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=; b=nH8iea8kQlAXQKcy
 6OqZ05ltCbPajRPTI8xJUWQIZKEmKPU8cazu9WkTvieZak1AuypspxmHRSzBG/Td
 t4ta0LqyT1FS+IO5FO8f1/1/jwLD4R2ZaPmtqkBTz+YWEGIYFq5U8Az5dj49Mtgr
 6G9ESFEZU0uAOWIPdGRmdCSdEOcFsURTuN3LollZtPvCGuppsYcRO2RrsJBL4qZI
 Gf0WVWwfuDRe+1kEuQPimJ4uQEqgRO4DJB31M53A300bA25e9h3bJ5fSwk1et0KO
 Yz7ml2i37kZdIdM8HPgMz7TtSWzc+JIwPsJCt5bjOWLlaaut8ZiZbOGSa8tK+Zxo
 ZXQfAg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynsq0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so2342504eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398895; x=1783003695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=TKwLELr9sCBXBtdCVfYgAlUeLEOf4o50LDXis1zN4qw7ddWf0xxBHmEMR1KsIExPQE
 KT/Qd65Anse6Jk7tGf2Ckd+kM4+lmdrp8OU177u50ytoMwAp7HBW4V9p1VnyUTF9aGwS
 lbFhxi1oc7C4Q4wTfFMiNw1ROK0eUe4BrNDrc8uMtIB3Ce30E9Nrol9jRNwtWMKbzgI0
 Q3seL860do3saXJExn/XtD+4rpTmf9qmiJcfDmVN7sgOFtQ4nlpwLo5tCaOvHiaK9Mu9
 uil1PDZBXVhsZHTdVW52g6pwn9TSKpdkPHWSYvzoFXxhGySeKX4EuQ5PMOGFZv9w9CwM
 dNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398895; x=1783003695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=KR5HU57QE3fmGYJGll+MtPAs0InCluAEe6iBNYMpknYXaKhb3AAXx+kSTc6iqHQgzS
 l2B6BFN9c06Buw+4M8N4AMvU8nNjzgKwLl7BJvFh/+7QykRnKtunJqqBTN5+e2Xtffe6
 tFRmTmoHWuqIanbrywOhu6gk/ps9aqmInPyJrftTE+gFAeYsTTexKdVZY4Sj2A3skuB1
 Ea2cFtvgFSZP3Fd4s53y1U5ANncqEh0XIUysLc4I9Kyzph6s6X2ZGr0XMG3wqJVEEUtg
 wDnG9QCjonTqgaqfshE6FO0P1xj5j2ICiPrfJK7FcBHhSEJDMJ4Rd+ekG2djIv3+lBCR
 l3rw==
X-Gm-Message-State: AOJu0YzLrzC7t4VmaL0Q/T82JZbTDPW+8Duf6O5NnkBTXe5HFliusWv1
 UAOCwsBeIBjtJXt3hlBJpRcgLVOUWsiFnhk29csZEPp1qGv6gctJBby79VHqlehCjrFKKyyhppr
 sqgcHLqsy3jp/RTtPsGij2TvMIo3ocKHRybgNmMa++FiXiuyAh0g6oThtvFKiuH2bQQ==
X-Gm-Gg: AfdE7cm8q2SRme8OWObQd6tuR91XQVW7sSo7QQULNMfMhVuaG/kMNPSplh/4KLCYMKG
 pDjL2kkz4ZXerG5FBDJlHecTwnb/dDKqS+tYOzUcE3eKbNfZtCZY9YV4Dt/PbJVpRbak2gGySTa
 mw99+o5YhsNHE/Z/g8Kr/EesZXHO1l6/56+pXAcsG5xxyGYe7wEIp5NcHIR6dCgkPig/yVw/Ovo
 egL+Yn/JiQxqSSgSaZc6CVW2pFQcqUWsQ3nZM0j5M5P5SGZoIGG54SPoFPpXSmeGfCw45e06x9B
 +l1Q0nZ9caFMaJ3IYWhoGskHVrynWhoBkdPKmcuhyR584Vc5peGNAKm08qAO6w6a7MJTGANSPvv
 9HLCE2ldyf36btFXhRoyoUeNwQDFRsiImpl9TkceKY9bq4Isl48Z/c/c1ejo=
X-Received: by 2002:a05:7300:760a:b0:30c:2d3d:7840 with SMTP id
 5a478bee46e88-30c84e1987cmr3314545eec.35.1782398895151; 
 Thu, 25 Jun 2026 07:48:15 -0700 (PDT)
X-Received: by 2002:a05:7300:760a:b0:30c:2d3d:7840 with SMTP id
 5a478bee46e88-30c84e1987cmr3314503eec.35.1782398894566; 
 Thu, 25 Jun 2026 07:48:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 44/76] target/hexagon: Implement wait helper
Date: Thu, 25 Jun 2026 07:16:01 -0700
Message-Id: <20260625141633.449487-45-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX1v6e3OEvPqJt
 OrtrGNJISrOyADP8FObxNTBRUtzAyHGkpn70Ip9faYk8TPItZoy1r4soDnFgSa2I8X5bGrZxaeV
 zpOQn2tGKsQEVZ6ew+hQAVF0bP1Zz7IkW9MAqIZyb9nhzCTCDbjGUAQKsGISVclvtlFTp+trJ78
 bPpl1xCGLbEJWgwew36jt7XjK+vMCPSOIN0yylZ1z4vg9nKgjla08E058y7e4M27lgoHKvd3Zf4
 nScTzwgIp8cgyV4jOoIxurdi9w9k6gJSj0V0C0zrxHObdKeMMLg5r9ZItf4Eo5trA1IISl/sGNk
 1Mz57jQXB5aMkT7ABRfOJ4yhtbUaO7MkST2okiq+uG74wy1JA2VA9HgMBwWDlfkOtdDs32gCrAp
 Yz6Y7lmvpXPVQsA7uq+Ya80SJQfCP+IgSwJmeBA+bW23Ko50Kchqy2xlND3Q6RRBQUimA/TuZL4
 4xmMoRaMLQFnuLOi9IA==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3d3faf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3CUTQoF8Gx8dTLRG7KigKpGZMUvH7VjT
X-Proofpoint-GUID: 3CUTQoF8Gx8dTLRG7KigKpGZMUvH7VjT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX8C7MsDukOIU0
 dhUPeARmS5E47RashbPz54fZvRsdap+Gm/Wv5CfWnWbeuHIQAlZ9flYdAJYRF+x/a9UqGl1IkNP
 Z7WtzQFwgpxy3iBFxkSX4x2lTE05VQY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8IDYwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1OSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDI2NGVh
MDI3NTJkLi42OGIyMzg5NTQyOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19z
eXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw3ICs4MCw3IEBA
CiAjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCiAgICAg
ICAgIFJzViA9IFJzVjsgXAotICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2VudiwgdGNnX2Nv
bnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2FpdCh0Y2df
ZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QucGMpKTsgXAogICAgIH0gd2hpbGUgKDApCiAK
ICNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCAxNjgwZTMwMGVjNC4uOWQ1MGU2ZWY4ODIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg3LDkgKzE0
ODcsNjUgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgaGV4
YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCi12b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQorc3RhdGljIHZvaWQgc2V0X3dhaXRfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAg
IEhleGFnb25DUFUgKmNwdTsKKyAgICB1aW50MzJfdCBtb2RlY3RsOworICAgIHVpbnQzMl90IHRo
cmVhZF93YWl0X21hc2s7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgY3B1
ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpZiAoIWNwdS0+Z2xvYmFscmVncykgeworICAgICAg
ICByZXR1cm47CisgICAgfQorICAgIG1vZGVjdGwgPQorICAgICAgICBoZXhhZ29uX2dsb2JhbHJl
Z19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICB0aHJlYWRfd2FpdF9tYXNrID0g
R0VUX0ZJRUxEKE1PREVDVExfVywgbW9kZWN0bCk7CisgICAgdGhyZWFkX3dhaXRfbWFzayB8PSAw
eDEgPDwgZW52LT50aHJlYWRJZDsKKyAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCwgTU9ERUNUTF9XLCB0aHJlYWRfd2FpdF9tYXNrKTsKK30KKworc3RhdGljIHZvaWQg
aGV4YWdvbl93YWl0X3RocmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgUEMpCit7
CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKworICAg
IGlmIChxZW11X2xvZ2xldmVsX21hc2soTE9HX0dVRVNUX0VSUk9SKSAmJgorICAgICAgICAoZW52
LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEIHx8CisgICAgICAgICBlbnYtPnRs
Yl9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEKSkgeworICAgICAgICBxZW11X2xvZygi
V0FSTklORzogZXhlY3V0aW5nIHdhaXQoKSB3aXRoIGFjcXVpcmVkIGxvY2siCisgICAgICAgICAg
ICAgICAgICJtYXkgbGVhZCB0byBkZWFkbG9ja1xuIik7CisgICAgfQorICAgIGdfYXNzZXJ0KGdl
dF9leGVfbW9kZShlbnYpICE9IEhFWF9FWEVfTU9ERV9XQUlUKTsKKworICAgIGNzID0gZW52X2Nw
dShlbnYpOworICAgIC8qCisgICAgICogVGhlIGFkZHRpb24gb2YgY3B1X2hhc193b3JrIGlzIGJv
cnJvd2VkIGZyb20gYXJtJ3Mgd2ZpIGhlbHBlcgorICAgICAqIGFuZCBpcyBjcml0aWNhbCBmb3Ig
b3VyIHN0YWJpbGl0eQorICAgICAqLworICAgIGlmICgoY3MtPmV4Y2VwdGlvbl9pbmRleCAhPSBI
RVhfRVZFTlRfTk9ORSkgfHwKKyAgICAgICAgKGNwdV9oYXNfd29yayhjcykpKSB7CisgICAgICAg
IHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAiJXM6IHRocmVhZCAlIiBQ
Ukl1MzIgIiBza2lwcGluZyBXQUlUIG1vZGUsIGhhdmUgc29tZSB3b3JrXG4iLAorICAgICAgICAg
ICAgX19mdW5jX18sIGVudi0+dGhyZWFkSWQpOworICAgICAgICByZXR1cm47CisgICAgfQorICAg
IHNldF93YWl0X21vZGUoZW52KTsKKyAgICBlbnYtPndhaXRfbmV4dF9wYyA9IFBDICsgNDsKKwor
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7Cit9CisKK3ZvaWQgSEVM
UEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKK3sKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworCisgICAgaWYgKCFmSU5fREVCVUdfTU9ERShlbnYtPnRocmVhZElkKSkg
eworICAgICAgICBoZXhhZ29uX3dhaXRfdGhyZWFkKGVudiwgUEMpOworICAgIH0KIH0KIAogdm9p
ZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKLS0g
CjIuMzQuMQoK

