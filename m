Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02654CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9N-0003R7-Rn; Mon, 22 Jun 2026 18:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9I-0003Oo-9l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9F-0006Xj-TA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZn6m1612568
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=; b=E4
 Gk9ttyHf7QzdvnzhDtcuNjrNYVIzNVlUi/iSLczgJCPeVKL4sC1nOhLI7pXUqowN
 nD0L8cX9YI0fn5sXsuM027qhjtHmxhGgwgqsw9P5MMnIT6X60z+0OjobBUu7Wltu
 3NzbnRp6aG+jxhST0kUb+KHyg4IfE4yk0ZrPiDBT7Srj5r3xrUqIOJ2wYsEFN8TM
 LVzL5WYfosYIgcHIh12ToKD3wcmd0UPcLefh3CrRLNnA3EnxSVPXJN/fRIskhyvL
 z+jHiAcc/cJpoyPjiBfn04JiLv/pRnfrdarH734tJ/C8aZhlUl5z2wG02w9OzZ3s
 91MePVoChbQzFHpk5AGg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjaker-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c5319332eso1093586eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167383; x=1782772183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=I1MZlb0uqTUPa/ST0siY/YffKHp/mje/enFCnyez0vpmtjh+nllds9vR/t1u1xjidW
 EJ9Or1tdzP4zLbBbeScU1fcLSae8CoZN2WDBbZJVz4/JdZkWXdN2Gj7tIOjH1PkX2Bde
 KTBWO3rPrb/syfaeA0d/8DXXhJbYI6ysCl7FqB+1ocWSIkaKUrgcLzz58SYGpqtbV5bD
 6y/WFifDZ3ECQwKJhDaDAvkcZkoRG3eq1/WKj86FJh7SL8xFvL3s8OBDADO88Z3iKbxq
 2hjIEzyamxB6LpPlJKmqPbj/Aa8F6cPQjkNLFdDTlJgTVhwaevb2SKFovhKB3G+bzLFe
 JRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167383; x=1782772183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=sdSoS/Ad6Z00AhA7z/XV+ZBtHGqBAoKsHL4idC9OMl/nirqa37JRgNmzuXH1U8B8VP
 uJIQVw39B4ZF7EJuYbKBZmOYpl8iMAsk/c2C9zvR/d6oG3gvVgUeTO36HUg1NnZPr9EM
 L9X07ELhpB/Mi9cMI8Apmg5gw2NTdkaa+SHMGCa3rmoXIG1VBA6s97ve0FAa3vWk58CC
 Bgs+P44EJoUPItcUISPhKA+TwEWN6WiXrqMWmEte2Co9ugb4e862uGbjyUahgtXtdIqL
 Mr2bvpBn+XCeobN2mftcxpkdYayuWd+fS+yCQ6ZzVlIL1wHcXgTqrCvlbsiTK4iKfqjf
 4vkA==
X-Gm-Message-State: AOJu0YwvLsPnXRFmJvhZDiLfAh0YVZvdAhuMXkadvhf+MX96CxtDkviU
 qYUB3aa26LOm+WxJ3CimcICAPco9XxCh6aQM6VYNzLwyQerDJ8NIYXQgJPSjwNAa6Y86PjnBfwb
 N6jFc70IVKOoX27+aKpftU9Ts+QYuFCoBZ0CMaFaLKguo1NAHjyS8KUOh8I1l4hPE/A==
X-Gm-Gg: AfdE7cmtFwU1Q6mGMHfzfrMff3fOydvxRZhwOhqxcZcHo1v8KOGhhajOsFg8NS3Kig5
 yA0dWS1DJfY4Li9i0nFyau0OJAarjx98//ckCRbD89ftPcQWumELDO3JU6rwwJGshuhfvjM32Pd
 IqMOuwjEo+7YMymcGAOCwrRU1Hr2vQFIsm8vO4p3WQKHRdbThw2TPkSwQIBL6VgAQE5KSMwchuu
 9kAfNOMWay+TvtEv++/VAj6q6Ish2kK7SnXlQENtFsYtfkM0A4bcpZySy6kiwWl8DuhhKt5FVc1
 Ge9NiOWuCRcVsxU3da1zugIKmyAtM1y4+jg+jRoD0A0BfqsV/X8UH9nwgDQP74PKRV8lBAobVF4
 35j+FrQTDbBu3WodJjRdmLu/+eA0jXrPA0vCiMHPAb58nBNGQQTp5bVI+85k=
X-Received: by 2002:a05:7300:6c89:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-30c06fb6c13mr11243639eec.5.1782167383463; 
 Mon, 22 Jun 2026 15:29:43 -0700 (PDT)
X-Received: by 2002:a05:7300:6c89:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-30c06fb6c13mr11243626eec.5.1782167382962; 
 Mon, 22 Jun 2026 15:29:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 22/75] target/hexagon: Implement do_raise_exception()
Date: Mon, 22 Jun 2026 15:28:11 -0700
Message-Id: <20260622222904.607771-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: oHdqm5YbvXIe2tz89Jra7o4VV8bv4mWf
X-Proofpoint-GUID: oHdqm5YbvXIe2tz89Jra7o4VV8bv4mWf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX29aWGCdboKvS
 JtyKfTweWuwkvSXdFUmdiZ9r30bYc3f5sFd9VJZUMgTsTKFN8evAUBfomXBEre0SeZGEXHPjCw/
 aTXUBuE5sf1T+fMCjAIv+c49c+ZXoeM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX5iplGzwOyaUH
 rOWLYZBkbvvWwC1aPyaeAFno9n/SVF4UPBPaf1IqTKFQfxPORfnBudmyFx/4C8HZBe2UlvINxDP
 zc/+rdsFymLsTy6zChEK5BNyC0PEPUA6c4RZuQTqcDZInCRRebvbGtCFZ77n4S+0mDtYcMx7Ykd
 jZTDM7WhW1VN7J2TX49oMRoVZj8gNEolisbkYn93T+bvndwQJHrZdpUkRrW6DCuo2L+zF1G3+Ab
 k19CPVKYiXuoSmKvWWgST8GaqJ1Teud6BJ/O3+vU+an2F67P7OMRDY3zkWF+xDCvORH5x9kOTzP
 Ao0i8S2q/6De1BEwn02mnh84BiFKh/RB1r7rPKOwT+/f1K/uBq3DEu25Gkb80AD5BD0IJhT15V7
 ay/QJJRjigPeHoREELfn/0yO1vFYmRdoy3JajrZ6M3MZk+dypwLTEHDpQrlqtuF4LgiPtpFRJb+
 t2lW3Uh2XRZMmXIBDcA==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a39b758 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjZDMyNGMxOWE5ZC4uMGY0M2E2NjYzNDEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MSw2ICs0MSwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

