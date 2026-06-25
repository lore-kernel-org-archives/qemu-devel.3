Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CF0CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO7-00031p-JK; Thu, 25 Jun 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNp-0002hk-74
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNn-00008o-QD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jsZj1919010
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=; b=IJenYrO78aeSUUIZ
 lGmr+zV0ksYHitxUjkQeG4e/h/mWu7fHubnofMgzpX9rMqLgkDC56mZhHXs3Y/W2
 mKfzV/vC3wj2IWioTpLEflDKmKjA4m3bhCdXqrCRHZ9ZgDfuRMOKEM5z43wJerl9
 /Lm14D2X23PGKmBtcQ/EsNdYWb5s5CYHhbQ/k7wwKN0srRn9ThkLTYGvDKs9Ivff
 215d20gur5DiRgtFVyS4wqFa9oeJjmnqWbiglxSuyBZD/WP65FFdGcdBevI+qgtX
 Ig+ieOg91G0KzyZY0888g4qfbjiwSaKIIylXdTlIj6bo1hKcH6RXSMy4/0Zs/NhZ
 QemQkw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuaqmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so670265eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398916; x=1783003716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=fDCFsGZFK2BGsiysYwQbOebFtJ8pWQUVaA7E1kj5adYfRhgpAp83L4ou4WcwNsxCxo
 MDddX6HfRE4r2cHscac99wqFSaI0qiIItCbUwMUz7b+4jqH5Xd5hcJz6DVfMXAWRd+VZ
 LyVDKDUGSI+WnYy9XX10C3B2TKlddK+1N29GvbKyM4v8m6PV5jqCw0uyGIgRqp4m+d6W
 lD2YFguH2lKaUj2mVGI1LdnoP5Pm4pCRRrPg7qHJEYlKP1zfVZAkt2sG3YKm7Wctifo3
 1mpq5gdvSSDavAor7s0luYMREAPFaNtwguOH3FlBomdX3MbhEdKxm2ibK7aT4jxI+Tmq
 DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398916; x=1783003716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=HFoQO9dKceCBSaYf9CtfszqO4u2J0xJBFruykmVOeYuK7NGUjjWCvl45lMUHFL6wZ5
 GKiGlhCLss2p4owssI06I4OfNLvQEtUdOEQen3b0IIZw8o2rk3rPvqnFysiAJ6oeLBPb
 rZ18Ut56NGQHWYunDc1QBeWeA7C0mWSNPLsuUoafz4c5Nds4eu0SSHAehN7fk2aa7zst
 Rv5jy5x7F3q9QyX6SQKsfuVnXMZln0Dry6TgTzHG2kJDGe+nbbQJNN3cvMGtqLaXyYo4
 6+snktsoXD78mggl6h52wrAcpPTnIn1GdbZSdJp6cnJiqQmeEkdUtyCZ5vs+U60v8hlj
 JP1Q==
X-Gm-Message-State: AOJu0YxkuEWW3HuciM5rB72uWdZGNjujkvsK0ZEUBSe911vtarbbuo/s
 uOcXsQVfeY9XnQqJr6pqEHPzICHHHv5lJvLxT/U3Q1VkEbEfoUiuSYLoOTxL0dDUx0tQkGmgI56
 EtrhIejBV7viNW5xyRQw0B0INBuj11VtSu4UNDCaiYefmrBtffZ9Fa0G2lEighS37CQ==
X-Gm-Gg: AfdE7ckSx+p251Gz1k3JaKUbrsaEM7TZnv7Q+7CWnUea9D2Fv6tqLs+LO/6N6DijtYr
 bpRhPKyHFnYMdho/E0hhaO6iV9PYm4u3KPyaXSD7Iqp1EoayHDPx7M/iJEy6ZtPNDsWaZ8WBcnI
 Bs+gprtIXkfHabH40FZrsJmNGUxJ5KAoB4OxmQhLKkYlpLJFAwDyIK95WAXNe2SaWyNA7OfhVev
 WstL+oAuie6lLjw/Yj1Zo6g3BvK2MF+b5Svijxqjo6LTKFDTbVB4fpIY3BJHY1opP/S4UnKkRv5
 lcKTEUBtVmI+8k4dmJ+u9DaAcMoInMRtoO45wpr9JrvjrmeeYFSvJ1WMvQ+ONM0q81PkFKF99wj
 jsr9jENvwiPQUyCKE7GTJnkXUkN2R10f7PhQCoYaE9ZH+JTPDayxaQ5NkbXs=
X-Received: by 2002:a05:7301:7c0b:b0:304:dc2c:3280 with SMTP id
 5a478bee46e88-30c85b27df9mr2511182eec.14.1782398915617; 
 Thu, 25 Jun 2026 07:48:35 -0700 (PDT)
X-Received: by 2002:a05:7301:7c0b:b0:304:dc2c:3280 with SMTP id
 5a478bee46e88-30c85b27df9mr2511160eec.14.1782398915049; 
 Thu, 25 Jun 2026 07:48:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 58/76] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Thu, 25 Jun 2026 07:16:15 -0700
Message-Id: <20260625141633.449487-59-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: R_F_4FsuE4KszwcpPaB7t9ujGZhRcsLY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX3jlZsOvttkcj
 y1dtVWkV1oEmPDIEp1xrHktsaXuUKbSCFDSMFsNFUAwllOX9TKuPQtkfoYA8hq5nh8cWSDFGmc+
 eAktVbn3WLQsc8eiPKPokRe9iCp3hhg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX45Ua4RO9VVuE
 056ZISo371KnjPXN6Wu9O3hAC8Q8mPxEuo30kDC5kpzQ+qc0CgAO8tmgLCX1ZLOgxh5y3IAbO30
 lbiiimFD35wtRl5JJEbkQrVije20rYdeCCQkJZJ/BVgsHW4vi1Oovb3tX+b82MYSVRs3Y3ktsXQ
 w5eNCojHADovieeECcADqYYuK+s7aw75o0ZG53th445Oiqhxb2EZUlXhtcm69/tuDWpcG0N0zQQ
 G2JSVrUgJbOAVVlpppFEFuvkTUqcIA1zk22Cnd4HhdviWNTUvPP69f2eymErRJ44/4V/XRm3oqj
 XsXbQAEl6C9W0v3wYSg4ZAlI6QbEc1q6+NrQirNOUavA69/aawILyfwH/fIZaGhlB8Eow8hd2gh
 uWkKXtlTAtpp9DvjGTZjudYQoLdK/AxVuGEs+Q2kQD4l7p1l3ZUtOmtGedt3f2AwKN1GKJR6kYI
 2lh5qItvhEqIKSP4UGA==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d3fc4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: R_F_4FsuE4KszwcpPaB7t9ujGZhRcsLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzYzI1M2IzOTFlNy4uOWZiY2Q3OWM5ZDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI3LDYgKzEyMjcsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDgsNiArMTY1NywxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

