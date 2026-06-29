Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E47C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dt-00034z-1W; Mon, 29 Jun 2026 00:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d3-0002d9-Ko
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3cy-0000jo-RY
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NHU81787648
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=; b=i2EZZLITJP0QAGrl
 EsFCDiPbSIhLQ3jnaKyv2W0wz8vWsw1phRJ3/agIlQ8NK59WT/PqqSooDl8ieDIv
 B13fc2qTX9Y7efm7Mfr45eqruroLaUEQaFFF7rY1api/ZjJ6slUdqRYcUdupr3JI
 XuWb1vVmvSSFu3WqG/Df/AN/bhMQnee7t3Ni4j67fN7sft4EOaNAKGliFnY9Pvkh
 45IB7Zv9R+QkuQMvJBn9TRpddt75F0l1tPYTaZAdt+bfRIwkOMtsHIx6pMLfDbkL
 /itP7a0T81cDo3F3TIUWwBElpk2cc0tx1DNawjnixiSD/lmLCjDRiodY1/IrlFTH
 KaguTQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvfdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso2540601eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707386; x=1783312186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=jQX7nodj+SYPsY26MWWVzlV8ORdRu1+taj9xbh6Lf3kE5Abs2AkikvQhGHacPWGBBq
 9kH1wD38oBRIFPcw7WXucIgEpQhCWpBQCgwkaPj3Q2a3/D6cjLmvRYU7kRiY4ZBJ+ldt
 rczpCg2IJGJgEXRzkCtEumFw/mx0cJLYnP3NIq3q11BpKw0nIe3PBOH79uqNDA01O961
 XOsok+9+xdrvO8lviz782Q1GrWJ/yZbKoQScPWOTxc1v/ZQSm/Y6hLE31GC+OJxpr63N
 CxoNwwW6I3uO4jd/wnA76UkH1GUx7vk2AhNl+ouEXQmmy0IJ6UWNrGWWCGSX08QG1swR
 N+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707386; x=1783312186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=qjjlpa29/3HI3OQBZ9Q3k7ZTl7V8BLe+qBv2RMCLMg7nsaCNPgAz83E1/KpzfGxN/J
 QhWlTwDTu2hyvT8sMzS47NI1gUH3+lZV8Sn6LA31wTeRb+PXpnmT6dt3V0lPwG5PwP0u
 imTdzmYG5l6oFdUcPnAmwxDa5IPdzPBg+qzUpHOLHldfxlow4BNIWXQA/F2VXH22Cwy+
 dT3j+sSNyB5bQF2yNQeZgY76jDz4wGPkEBQd2nIX6VG2RYaFMDvoXpiOMxlF6KN/AFhM
 gyYr+YafKFCFfFFBuvLrYchRW03LDvFm0Ox0D/Dml6DXKXQjzqw3916HTW+978pJua+Y
 BgJQ==
X-Gm-Message-State: AOJu0YwXZtnlTvCtVOamMBVKgTP/TQxAtn8o70qFLpTEzLu8kEafTTva
 0vW8yl/25k8J03RH3SlhjAf3r1jB2xmQmT+5fu70YN00LTLfOJ1mlB3cMTYg+kCLWn4TxbB03MA
 G2DgE3HAXPE6UP1pDFjZT4VpqB3r0eQ4uwvdA+6d3L6qR3aXwgPM5fRkyVeW27xIAsw==
X-Gm-Gg: AfdE7cnBOL0xx/erqCAe85QrhZC33O1DTP8DO3JQRdx6IXdX1Ji2iagLG38mi9K8lfa
 Svk9lY+N4dXL4ocFqDdp1BHJ2XJe8clsRCvRpA8/M4S/70KmQ70v4LD1b3rDDCsTPATNEmwPJrh
 EVDNKiBEI8krYGBSLHAkdDJ9zWrcHEgYAgPK1PeFt1VrYUZKQt6PzksgeoIdocn0LJH45ApNuRF
 mXFdrpo3L/WpB+6g68UPj2H5R1kn/rVrCeqigOQl4RFgXLuZ9WQd1DojDkqZ8jTvnI/IJ/Rsej7
 OngUr7d8NrOnTdEVy/skych1j7Ng7qeZ5MkBq2TwW5StdwBjcA21g5q13x/M0HrsAcx9e0JVpnH
 YB0d/SRDP5Od6pil24WxPhKCVAGjqrFco09uKWgMiWd2d9e6Nd1PG+95AGXg=
X-Received: by 2002:a05:7301:618d:20b0:30c:9ca4:5cd0 with SMTP id
 5a478bee46e88-30c9ca45e3bmr6553517eec.4.1782707386245; 
 Sun, 28 Jun 2026 21:29:46 -0700 (PDT)
X-Received: by 2002:a05:7301:618d:20b0:30c:9ca4:5cd0 with SMTP id
 5a478bee46e88-30c9ca45e3bmr6553508eec.4.1782707385737; 
 Sun, 28 Jun 2026 21:29:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 45/77] target/hexagon: Implement wait helper
Date: Sun, 28 Jun 2026 20:57:58 -0700
Message-Id: <20260629035830.1520296-46-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX41+q7QQ4yD7Z
 TEN8YSz8NBMUDc8YfTOE52DelkUoMPb3k+ItSuzPOpXC2d/NYblJ9PaL9GTXEqtly3XICVw00Pr
 txK2WtufeRRNslcvzPYCVnKP4Aqdsr8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX0Vyuy2hcQ8+8
 ZNUIpmSoEYRtrlQ/q+Vi9L7JNgqPIF3ZQwhTGEK18JXf2Dj5vylD2n+/cSmNLyzXGlt/FKemn4n
 cX8woY1/HNMfYzJryf27uJxi6GYF8aEEYIbY9DcoUkM2Iq0HIm3GeMGZ7NFGKEGNEdSzc4y1JAR
 KTDU6MByqUBaDk7vQzIfqJBTTe+bCZ8GySidaOCAFt143NIugCRwdt7Es8oQbwvaX3Pz1OvoHiQ
 klN7mAZ7WTlMkg9v1Up8sGTqOUvQcn1pDmVAV6RWP1oJD/knk5+dGPE8Ub9vu7yOtc2YwYlMz5H
 B/2PLKbVs6sg21WE7tL/2GdfN3QKRn+/e03ac1WHbdDZuFi+MersKupHLtt6I0WIQ5j9q4bgo2O
 3hOoJFNtJ4S54xT8r9X2K+TFwhnUDWuRwGKmZiJDBbT1SQ3ns6T7+HozyLYw+O6cgrj++Q8rxJ1
 nwTqZgEc2jZuF4VyHVA==
X-Proofpoint-GUID: 1EOh-UJwko5LBKBjb6dTMfg1eo583V9-
X-Proofpoint-ORIG-GUID: 1EOh-UJwko5LBKBjb6dTMfg1eo583V9-
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41f4bb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

