Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF94CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNe-0002g7-AV; Thu, 25 Jun 2026 10:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNY-0002db-Qm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNV-00007F-0D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kEAx1948503
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=; b=UdE3YRbL/IhnmR+5
 Q+Sug5XEuiN2F7a22ZnMear23ocYzQlyMhCzJHucJXeeP53Ov0EILoi45u4u/FTX
 PcFvLuiRZv6i4xmTJdOJkxaLzugyy1eX9pe3UtOADa25aSJSqCuEfDO5aYYxPxE5
 dTjra842IOyhK4Qwl3263YD1oSk27UYBv9FEaCwybIb67+jh3LMOG0T8J5V5YZ2a
 hxzKALSI0aCulvzErQYyXg5/35hbsW6+bJaJP7h8oBTE8uwLAeH3vQ8iHSxcITFg
 ANMAH4hRviI+AYOYrtN/jCfbaIsPtUkHYvbpYhpr0I45D+VY53Pw6fNqlVtLQm8k
 qS+5kw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8su5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso2630478eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398907; x=1783003707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=XiPvvAzraxVFq5ZPMFPy0OvCUR7/UR101DlntmJdHW+BUwx/BZbqEkbPd8PExPFdxH
 yNm2ZKQU2DOfSb8szjKShQIILuXpjQ6L0fQk82Rs3fcosN45FCUD3aaA/V5eeZW4NE3J
 R7lOWM2E7bO2941nEz6DaL+TgZ3iFZ2voH2hLKujm+XMHKfcUk9l2cyKZRmXR+3EcLh9
 iDvYIs9hfQDkmt1AEvJTjRFAIcvKfFmaBTxok9ijTr/edeUxbRNGnUxSashqObg1eTIo
 KOgG5jNXPAZRSyPVpPWPECQLJ/XzfK+4uytADFVTdPnui31JTO1rCvQaNt9ZOvegjgiB
 elnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398907; x=1783003707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=HMM9EB3SHLCw8+W8/nVQQWPDTjp6oQbiMeIT7YcN+FbxjFTh7FGWNgZDtonJmtRa1l
 zgqyZ+6OpYC2QbAqrUI20nzdXEfRx56z1rPPiLtD/ZiDEnWYsIM1Ov8ClsQ7onwu057d
 utClf+jF7L+PokzFa6c66ZD05LmEQmeIzPWXNuw/p6HWyOpTkAe0xWnq6Gz5Ldygg6wL
 ZuWzkgvNCezMSeSpkYrImAhX3QzQcFFZIO9KKsBbBK9WCyHy2k8MIbzdiJA9CqbdDLX6
 QhqLKJyAao2tIcdHig4QqzP/gN/SiswaaZyftjfoi8vzn4VBUrVQgEdt2HwJrIla+1jC
 RVXQ==
X-Gm-Message-State: AOJu0YwLSaTZIZ6J3kUhNIabIUI5m5seupEi8Z5EXdrwW0+2mMx0mkl9
 X2pvIjgOYy6UGsWKhmRj05NnhYxu1LE1hWUCH57d6oLXcTRlXPhBj6o9NLmnVDruJ/ATUPICJoE
 s7DjuVYu2uwdjqidpuivq+PsvVP9hXPM4TdOQDo53V0u4rDhmG2wmdL7QAa4J8xrq+Q==
X-Gm-Gg: AfdE7clyFKRAaik3phaMyAZMlTszYpdu7bILe8lz7aH7IskrIhkEjWLafgmYO6jBTnk
 AGRxjC33q9bEFtvaeSw24XLjEW6NxuhdvkMi62brQeI10YAoX0FLWsEkIT4ekSVU8twn6+3KrKW
 kHpMfw4mgaJAOBqUPjHGlsDVAz5EX8PBCFQm+mBMrTd2DkXo5xNnK8lxO74Qi7eRtJtui5j5S3o
 AYBEIM3xVjLOG8m1zZ2XXA08sPxvToifeA7ZE1UQsUjj5Rlh715rXm6o2QyvH5ZqDVQ0uhMYj/G
 jqygKfRv+t8c9h77tRy8X32FM3uCl8sJfhWfaUVp8KTvCxFGbUfxLYbtbbCTdXp08vszvER/E7a
 4/ac6eyQHdTPgooQ3+c+eJtt9z/I/XjowSjZ8rnL4F8knVFSMlXcWUAH1a2Q=
X-Received: by 2002:a05:7301:608:b0:307:3a6c:ece9 with SMTP id
 5a478bee46e88-30c84b98913mr3201300eec.15.1782398907161; 
 Thu, 25 Jun 2026 07:48:27 -0700 (PDT)
X-Received: by 2002:a05:7301:608:b0:307:3a6c:ece9 with SMTP id
 5a478bee46e88-30c84b98913mr3201270eec.15.1782398906685; 
 Thu, 25 Jun 2026 07:48:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 52/76] target/hexagon: Implement siad inst
Date: Thu, 25 Jun 2026 07:16:09 -0700
Message-Id: <20260625141633.449487-53-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX0hQFZRDroPO/
 mljtoo9RLFF5d4vULmD8dtylC4np9NlT20a7G/38wA1lXhuS3rQfkUkemgAqrnnQlAx/GqLIHzJ
 G5osHQqQM3AEHuotG+oplsw5miMNFA8=
X-Proofpoint-GUID: esOgb3tPyM7fJBgfskQip0F24VC6ct9y
X-Proofpoint-ORIG-GUID: esOgb3tPyM7fJBgfskQip0F24VC6ct9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXybeYZNYLGxK9
 qzotDfBCmQdeSC9hEVFCwvipr/6PIADZnOacNWWUM3cQE6kzzptMMWIWoORgbX1+J8rfrE17CZy
 7KrepiIZ5iCu+PiLAB3Ds9KgBF2Tv6hUKTReWLjBMyDOj/pop3roCkznK81GcEGs1yOgPJxH8Az
 vYSlj4MH4c6phJWlWg0oOJeg0xfAlyooOAK+Qg2Ap1e7VsByGQ4Mpu7zDQWEqbHGY+KMUpxYe6/
 RMRLQawGc/20ug/NE1f8+iReFX364/8k01JmbrpNNgcRK4RkGn+fYzAzHkba8oolQADXHn46dtj
 I10eCTiTcwhsRwqJdrFytJKZSQSOLlio36hrNXaUyIh5wsfT3ExYSOpXboEIcjhS9LJIH4D2xt7
 NlW3/ryYp7lreP9oFf2xjKO9Gu8gDos0GyUoH/vVmkL5XihgVS/BkTW8MwqrLyIugefX1BhayWV
 c+sCGfCvdocYP9evnlA==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3fbc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYThiZjg5YWI5OTYuLjRk
MzE5YTI2MzdmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNiw3ICsxNDM2LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

