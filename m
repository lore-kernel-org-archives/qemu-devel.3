Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CECD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bf-0003L3-9J; Fri, 29 May 2026 17:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bc-0003Ff-HF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Ba-0000Lk-N2
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdvMR203437
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=; b=ahUf9Umn3SrruK1n
 SKRtUrE0HTVUuisGcvorC7t6kfVge1HexauuTnKa3piR9UGfGujIEHGjZB6mMqew
 wjIDJ/MWqjiLh1vp4v+M66UQxmsuO5Aq9/8bJ5yYN5guea4uJJ2LQR1hgzdPNbca
 CwGczr5Eml8Ywp1kVX8JpMXv9fyaoN3P0bpudXxxr4k4jd1sbv50wszaOpBKZxPA
 80jcqCUrs++X5vg67V9AwvmLro8WmglX+SM1L93NrgJ0JzF8880BgMiisrXnZTMU
 rvHheOgYGeWCalv0+ZUqKFJ52EwPo6Q17ihs1KLT0m2DVqwA3bsqBJAH20HRTRBn
 j12OjQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8qx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304df51ff3eso2144345eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091768; x=1780696568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=KLgkTey6AUUi6I+pJhUgpOWrbPF3K2IOTF+JyMB99PAoSuIbHjmwyoDGRk/DoXxd+H
 K0IwoKJSg2i9KxtAYCxMO33pcI4ajEzFMgQu1vT4DVaEb1tXtNS2by1/fjuEO/Lgjd11
 dWooAHo5sJIQIjoWspcZzTUHrkxktMwPbyUG7emh/IPNKrkECuGnOhrgCBjN822SZbRR
 lFgF73l64sGktY4ws/mb86/8la/pmQMknxuTXF5AjourY7ogQ17AE9xwSB7s0AaHqTHo
 BQFZab+/vOHCJDCQHnPo+/w9uM8rB30Za6a/rFSgnfkv+/dOoSoHh0SY/iWAXtJzI8sp
 B4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091768; x=1780696568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=M5F6VWnYXqMlUZGRP2o8dlCIdYOHhSuOkDrykka9DtmXROwVKrKiY/MpdXf+LJfYeV
 tbL8ga9yQbD7fqoH5vHMX5ee0ZcaWzCLf9dD4NbPBQ3yODeeSdW0Cy1oAxpYsnWuw/DZ
 +mwqVgGiBsHdEriM/pqFGTzZidisS3C47na5mjMjsSPaSQw/v2pV7v89RjzXCpGqj0NX
 PL2mw4XWEn3uJnB3vue1jHjsD3xgt1yFK18NzO8VUeN7ILEozDi7JH/q2PKO3k75tUmz
 oHW1VuQ2dXYkpATrDWJYrHtGFsHgPIH/aSscyp3MgQCXUDWzpC7AtEr8OcMOgr8RS2rq
 2hzA==
X-Gm-Message-State: AOJu0YxiBOWTyFZ4z/L/UzStTwipVZLcASus7dFikBzf2lCPRrIW2GWk
 R6WqSCwggfDe7armkuhanEtWSnLAZeKS20du75VLIrpKP3O6/fo50aJPk+E3ZLVUWxbnq6U2rYx
 bLWgs8EEOkVCV5IpexPIdrGxbnuJrjRTcuz0JfHk6GheK/yukJD/l5bLYITmoQ3SXqA==
X-Gm-Gg: Acq92OGv/qpkqbcD8p5DoCR9IrgyHwbTLMzGhcI/o4zhJSVHnNX9/XXYgamzm4TFxbm
 Gvwqg+QTU+Ex+ot+U4RAadV+pPp0zTSrd3JUdaA2sIruiwgiOgqZbg1wG1j17thjDIUL9/pXM/i
 sH9QaOujbz0eOrEVVsaJLwspJ2F1q8u884/0Qg/Mos+3TzGeyzYLL9WkH0cY0OPx25nhGetBJVS
 eBQgfatQAez46ilMlbeEJK5rpoerAPY8piwZRiX3dDPIxiAgnNWGbs6AiFkTZC47urxwZJ39Q9a
 nzjsUUtpkedu6N8B42DMbeicTXKxQooAC4VKxQ1fp6PCNpImMmb7cHi4cOLskgBSS0QqQw9Nxh4
 64hTZ5Y9eYHsjbggnI//npnH2yvrBFwdrdaKWWjSey73zBsqFiUPqsizfES9VPCiUucJuMS02Fm
 cGFyBy
X-Received: by 2002:a05:693c:2c86:b0:304:2eb0:2726 with SMTP id
 5a478bee46e88-304fa658e52mr778934eec.25.1780091768009; 
 Fri, 29 May 2026 14:56:08 -0700 (PDT)
X-Received: by 2002:a05:693c:2c86:b0:304:2eb0:2726 with SMTP id
 5a478bee46e88-304fa658e52mr778921eec.25.1780091767515; 
 Fri, 29 May 2026 14:56:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v7 06/38] target/hexagon: Suppress unused-variable warnings
 for sysemu source regs
Date: Fri, 29 May 2026 14:55:22 -0700
Message-Id: <20260529215554.606133-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX6+v5A1mv5j1V
 ySCks64x2VMxQerCUpb4jqRwe0VBsOec4EAFOyxEKbP1qi+LtiMmDBdnA4rW9opkXUTUrbUjAzl
 QrSXVWjgByfASpLRwfe3UXqamoYdljHY+6Rfb+5TI9BzDfV3vUH3/IK7vFNd3Zos0alGyA8OFom
 XQl5dmqQB0NaYgtK7ewCmkZoVnsqRyagkIDEDRvyGyqo4/9d3J/zpENg8Bt1i8IpLfcmlKdrez/
 NvQ71vy1M0Vn4n2QbF0nyS4/94E2ak2vTj9Z6JSQ3lTWSRWKVzKf0gBY7BO8S81GdRBZIdxjz4x
 A7s9rNoBoyIOlpFo6g0cpeQcdw2VuSksL7xFwvhu526SOxu8vC7oWOdfx5esPlWFOR4DPhBr6JD
 FwbNE6uDgs8LKM9WJ2Y65O4qjYQz3ZdEBn1g6DAZvnBSe2bJR/tC+WmXd7DZpriS09qAkWVTinb
 dsVdmE2IaTGPxo8g7zw==
X-Proofpoint-ORIG-GUID: jk2akHQL-3qcsQJcNitALvSeGzyy6g0f
X-Proofpoint-GUID: jk2akHQL-3qcsQJcNitALvSeGzyy6g0f
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0b78 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290218
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKT3ZlcnJpZGUgZGVjbF9yZWdfbnVtKCkgaW4gZWFj
aCBjbGFzcyB0byBkZWNsYXJlIHRoZSByZWdpc3RlciBudW1iZXIgd2l0aApHX0dOVUNfVU5VU0VE
LCBzdXBwcmVzc2luZyB0aGUgd2FybmluZy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggNzk0MzZlZTI5ZDcuLmRmOGQzYmE2NTg2IDEwMDc1NQot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKQEAgLTEwNjgsNiArMTA2OCwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxm
LCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RTb3VyY2UoR3Vl
c3RSZWdpc3RlciwgU2luZ2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2Vs
ZiwgZiwgcmVnbm8pOgorICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAg
ICBjb25zdCBpbnQge3NlbGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3ty
ZWdub31dOworICAgICAgICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJl
Z25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKQEAgLTEwOTMsNiArMTA5NywxMCBAQCBkZWYgYW5hbHl6ZV93cml0
ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RQYWly
U291cmNlKEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRlY2xfcmVn
X251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAg
ICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+
cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYs
IHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTExOCw2ICsxMTI2LDEwIEBAIGRlZiBhbmFs
eXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFzcyBT
eXN0ZW1Tb3VyY2UoUmVnaXN0ZXIsIFNpbmdsZSwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9y
ZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAor
ICAgICAgICAgICAgY29uc3QgaW50IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNu
LT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwg
ZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAg
ICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC0xMTQzLDYgKzExNTUsMTAgQEAgZGVmIGFu
YWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNz
IFN5c3RlbVBhaXJTb3VyY2UoUmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRl
Y2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0g
aW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNl
bGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykK
ICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAotLSAKMi4zNC4xCgo=

