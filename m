Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A586DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3ga-0007US-Kh; Mon, 29 Jun 2026 00:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dT-0002hN-3p
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dK-0000lo-I7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NE8N1718897
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=; b=FcO6pQPBOauWyc4a
 a2fXEevuf5WS1owBWZfCEvuFQPBlO7Hs4UCw1tixwAn+BKda9VJC92kKnCboYnbG
 WHuR4hE1HdOgAN9NMu0846S+Ro2yBS5pmfitenPm1G11vPkWK/37SSlLdKgSpdYl
 JUhfFVGeHC604hIsp1W3OLUZUCMgV0hxsRV51jtpKGA5u+jT7SqQA0TquQzpK9Um
 jRbrCDg83ZCJRBhDpmEl1zoy/UwuOosgTSBoRtAof1u2wT+1uM+CSDIVDuuPzxMD
 dZTuZZejMobrluY+y+5jOIZHlOpuei7S8NTHVvQj/PJaV1tj470H779ZO/7JIVxm
 HE0BLA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf49xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ed664e368so70436eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707398; x=1783312198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=g+dmW57Bt9G4JpT//0IO8vEk+AAe1yObHVS9o6OAuoOZkHI8meON1HBrvGqaiabdts
 2aXRlO6+1nVYv9hkF5NV02j/eM8/5ZQCBSjWnQ8elUdtGSf+a+olo3PQKFF/kh3TgVSU
 mKFyW7yBKREuE+vYsSCM4OBrV/Etb/pmD58xAbhHgcBR2vkEAXDr0U/cNySqGEJFovIS
 TvZ1xapQ0tPuh2lwkFmeWwsRVUmPACTTiY+zBhJtmq1OZcWYkJikDEo8bSMoYgIGvyIZ
 lL2GLE3x2uvfuQyQdCETZ77DfLHJhaG8AcWY+LW1DJD9jK6pzh2RGzY4z1YOsElJqVH1
 qZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707398; x=1783312198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=WsJwO0RXrTz+AX5vcO+DRXIJFBfVhm+H2+G5n5tDqQgWiXoEPMGNQ4Lo78vY+EimL3
 LHDpUsP/nosO5WIgFQnCebcmrhPTb8n0Dw/1rACfYg40MlXQluLiRrOWil13UeBoua+4
 +vBWQ4rXTPIdYhZ0eewSQU0BI4I/iB/ZdpIvhEPomsDJ5qvKEJcDCr+3lC6942UdhrIe
 l9td19sBi+GPq1hEYJ+g8pMfQy3Rrm4UIk+NEPyskhIzKLG+NYgr/j4YhFOfuDEEbRf6
 I5McOAde4HGa44qjMXouKPpBCd+Q/FFIJ145k6saLSiZNjFlT4SYTuJjvKqe60qjF1Wl
 4GAw==
X-Gm-Message-State: AOJu0Ywj+t4w6oUTNBcN3nakBxVjS9TL2Jtrkzbr3KK08Wn+MsNXUQp6
 yKhvIf4TY9WevjpI35Z79YelC3pXQLYl2HmlDKUlVE3mwZBDSXLfWtauT9u6UAFdz6gfVarQuvE
 V6Y0Qv8JlLyAw2O0zoy5fiZaTNSEpILqv8SrpkbAi/Wi5N++bPqs6EsWhc3BtxFJRcw==
X-Gm-Gg: AfdE7cky5f7mA2Yyx1MMMsSo+HQD6Rs8u+11IbIW1BHEYmQBgHlLTk3mc24X9Sq6gcu
 YbhXWEc7JGFUiZFKGCp4DKojJkp9iA6KzhfVFisE5wH4vE3zk3HYs5/kpFsjnvrFu4Uyho7RUk5
 a0vwOFVTxqdIsH/UNHnR4zzmmiU3DerMqLA84ZKNWiD3rXIl1CXPiqQDVRwxsxL961pne0Lz65p
 OIDPj7mTUktyQQ68z6o4BDHvGH7kz+Gjx2XzMzWT4jh7xeWmMG6gsy6c7Bm3GVjwpa+3PHURgUw
 QvAlUCLxTYLgKOySdRrfMPTAKdgQ7gzqgyUAlmkC1JmgR9TGygc8/+FLjyr6Z1KRZLDbcdld2FZ
 /mZoEHROBo7cNCh0+kJRV/NX0bHW61KibJfHkwe9tWGWHNUsHi+7E7uH3vos=
X-Received: by 2002:a05:7300:da17:b0:30b:d209:dc18 with SMTP id
 5a478bee46e88-30c55606b7amr14250290eec.10.1782707398562; 
 Sun, 28 Jun 2026 21:29:58 -0700 (PDT)
X-Received: by 2002:a05:7300:da17:b0:30b:d209:dc18 with SMTP id
 5a478bee46e88-30c55606b7amr14250278eec.10.1782707398062; 
 Sun, 28 Jun 2026 21:29:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 54/77] target/hexagon: Implement hexagon_resume_threads()
Date: Sun, 28 Jun 2026 20:58:07 -0700
Message-Id: <20260629035830.1520296-55-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX3lngSb95+31s
 bYYAzBOa8AkWfmG6qqIFSA4pSuFfrH5jHDj75og3xso9gCAFDuZg6+CS72VsY6M/zxLi62rI4eL
 DeC3joE0sNJYfv9fJJ9pz95J0snXdYU=
X-Proofpoint-GUID: 2-EZmnVl6gL_Qyt3ohzqZl7frrvcr4Yz
X-Proofpoint-ORIG-GUID: 2-EZmnVl6gL_Qyt3ohzqZl7frrvcr4Yz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX8LxVj0Hrqbdn
 Yi7jV7xlfPHYDFoRELWTYlbpeDn/EHXE3ltLIrbxtrPQeaWeTmiuk9TZ0xIh69JbJip4mQx5pTL
 bs2lIDZ2PiTJ5BypUFjdTXY4mvI7WxwO0R/ES0oToJxxddGuVlhSzUYFqf6TOpjk+DHQRZTlm1M
 edpZm/jjIcQ9LX1OiwEHYV5WWxc2WEQNWHeEf7DbALHrhu93AC3WGeBZw8eEvrYm6CDfGwAmH2e
 Z9YZVByXJ13HMsExn1PrHpepok0utG8MX2aTObDlTemwgmRE7yMl/ZYur0nYgqaWnLxGmhulHLC
 pRcF/NOP2jR3a8BROlXFndn5EMESRtyBaNZNkgfcf9ELBkTsa8wVvkdPy2GejdMAhmOUBqO614x
 UCQ3FHGgnHgdFumMSCBOMQY7CsDCJ2WU6JjW2MGCJ5414d45mFWMBo+95z+undfcC+XOnVoMtiw
 Xh1Cphmna6nfzYJ5bPg==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41f4c7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRkMzE5
YTI2MzdmLi4zNGM1NWI1NjBjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDEsNyArMTYwMSw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

