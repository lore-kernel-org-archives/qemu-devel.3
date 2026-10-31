Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51418606A32D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwXsub1J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NjUZRJal
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxw5-000582-D5; Fri, 30 Oct 2026 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvv-0004sJ-PJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvt-00036J-OF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CXXJ3872787
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 knc//XCr2XnZfHbFr5ZnI3QeXzrtRyrgk2JKnA2mV2o=; b=QwXsub1JZvSxlngv
 1kig8YpGSAFbH24OWE+BUgc9hmMFZ3bYjDpGEW0tOM+4j/o0VY3Ls1Ns0iUFkgHY
 VJBa4lzE1TGRcUCqhBKBae9KnQRDxzipq6KK+cPWjG8kIjRC8fHqfWaI1RdNp7dt
 91EUChbklFCfsJmyDZ+eZJOwbnVQXUoS81NNjahxrjGjwY9TN9sVVerKQnX5y2R4
 QGHWImaa0cN37j99IPMr94Gajc/hTROomdlyHCnIqRsCCD87Ua+t81CCVAK0zKci
 lBCo19qAwilR11RPQ8CgGIpT+bqa6bCRWoS2428TOobXkT+ZYYhdHsuIBsguzw9Z
 L11l8w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08jw4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso3147653eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410245; x=1794015045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=knc//XCr2XnZfHbFr5ZnI3QeXzrtRyrgk2JKnA2mV2o=;
 b=NjUZRJalHO7KnMthC/80adSdlLZf+VLhWo/jDrXjSSbmD/H1VUzavL9PkXNTCSSWmA
 K3Gfj9yUdPTwzv5Nev50+XdPuCDJHSIL/cr+djLj0I4tY5maU340SrSmMrzMM9nmE3/z
 VyozZIAyiR/1az4yb5ynS37GW94KKRNrHROK6ldgjM1VZCWdqTxfZOfVvNJjzSD+QyJz
 s7sHjUau2Q9BZhzP6liFx6HvXwtsUqG/wX0AGqs8HMU5E7u92RxO9RmKg78WBSrYaqJj
 H7Ut2Fv/ierVrLX4S85lNgGHmoQaL912DWyKXnFk9flu+Yqw5OVfK964drpXUu7UbG7x
 w3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410245; x=1794015045;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=knc//XCr2XnZfHbFr5ZnI3QeXzrtRyrgk2JKnA2mV2o=;
 b=M0ITgXZKhEce2/oxc2C9lB7oOjKF5AhbPzv0PVIPldJ5dYc0I0OUOHOrorPC/1i+ik
 qQKbw9pLh4/T2t2zG++Kbw0YRGPr5zTpgk/gmzPvEHsM2HMVMonEhJv7BeRZdLgiHwEe
 VhbRuiuKCVtgbY6DHgS0Me0uJU9tN5HEHRDfpY3bWuSjzpgE5MUjN9YWCtM/TrOt6hqN
 Xp4wH/HpfUWq/E6rpilLXZT44vQ3FqXtxoTevjwj+3N/GYXYUYSy1F4dq3NerZ4LptFW
 lPDxBZ/bMZGoXkrc5y/3ABYek7x4S6iFbNxYb5+YrbZfxc7mBhEx6Hi/+1odKRku8AGN
 ZVSQ==
X-Gm-Message-State: AFq9FYIx9y58ssFBishCxTqgkUPC+FDpHUl06NEcMuyyPUsGPV46wZTm
 E2fnqpquCr2JfrjfYtE9/qb+AytMs9YOL6OC/IS49w37T5CvSAXwgYFqACO+bWI66LmdeJGvGYK
 4U2JGfh5PwaA1HRMMCAcQbaOeL9Q2IXvCwuxtC9YtIBXTq5lwxFJifQyIGQ7+H4PR7A==
X-Gm-Gg: AYBFou1khw6l//ao/C7Bf3NB3jFuL0kGEb2fYUtYPSwgLj9l66DkQu75tbnL4J5uXgV
 zG940DDWdVkTXPQGUdGuJsNkXHmwDeILUOfCsWj0xAKYMDv8R6uCiJ4+Dn3foL7c2b7Y8WSzYym
 wa45FwF6AFonXCguZNRi47QpEhYF+vk9QWrUH/VrAtc0uLAKPGlQfL276I1Ln6FGMrOHPsQ//l1
 mbp4Lxp/E3gsBl3ukWmsO3oN1i+uts6ek5UhKYHKSMIIO09lTdn0taqZvNXNP29z88T7Upd93Rl
 AePa/Aut9Chb554Wb5opZpw9x+iT1iVZ5eaFp7mm1Kd8FmunKTGomU9avRazUE7bXoInZmXXSj1
 5Jxlw4TXLW6+2O1lqWVXZqbl/LJH31LOVG9zJoMeGZDswO70qiM1pyD9QyYQSuUcohcOkQePeeZ
 mNZJeHl4d/pQLqDmv3knguDw==
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a4206d82emr6065279eec.0.1793410245066; 
 Fri, 30 Oct 2026 18:30:45 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a4206d82emr6065239eec.0.1793410244347; 
 Fri, 30 Oct 2026 18:30:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/40] target/hexagon: add HLX packet slot and resource checks
Date: Fri, 30 Oct 2026 18:29:25 -0700
Message-Id: <20261031012941.339141-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: DYiPF4QYTeTMNfVTK15QN06AA9Gzpu-o
X-Proofpoint-GUID: DYiPF4QYTeTMNfVTK15QN06AA9Gzpu-o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX2wPIML1Qeuso
 x8ipZgwStpJQo2tlNCYPdEm8IN/1J6u3pNcvvn8mV2wRlgb/46uy2nggJbCMY1K3IvtG4xS63/S
 8bzuLUF356a5TNbPHBCy8cgoSSgiR/g=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae544c6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=h1MXg8X0kOsy87eJFU4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXyI3AYBcHTkz9
 ShzePAo5Sz5qHXerrYlJiG8VHbnmwIbFJ/bMDpxFEHlgME8dLNondzvcNFMb/fDZPAeJPUw+Yci
 n+5NlfSKduXTdvrq8pChqbhjx7nkgVO4cmFOIGbNCs8IaZS9CLsHk+XOV76xevGkDcPfSw7YRMI
 +PO7WcTNz+0SHfohLTWAwzL6ggqvY/t952LihL53JgV6viyyT5BbpbmfpmOjaSe9FmtBYlN+8YW
 4al3eEZBxBq620d0m23FwITLt/aR96FvGnTbeyOG+VHW1qewKD9ywQ1uuXonL854csC8YV39NWy
 0I6+srDlVqE2hnR544psi9qb76o5Cq2cMsUGwTnegBv+rBvGC2p8U0Hvujn46rvASVXjpseINmp
 ADkuybbSmfQ4/s7sNhwb/Y1zqXKdYVndu5MTre85oRknhDQ1axFDMBi05K9XhQDbw5knjhsbc8c
 MOnO8jy1Gdh32x9/wFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkFkZCBI
TFggc2xvdCBydWxlcyBhbmQgcmVqZWN0IHBhY2tldHMgdGhhdCByZXVzZSBhbiBITFggcmVzb3Vy
Y2UuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNv
bW0uY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGx4L2RlY29kZV9leHRfaGx4LmggfCAgMTQgKysrKwog
dGFyZ2V0L2hleGFnb24vaGx4L2RlY29kZV9leHRfaGx4LmMgfCAxMTcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEg
KwogMyBmaWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRhcmdldC9oZXhhZ29uL2hseC9kZWNvZGVfZXh0X2hseC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L2hleGFnb24vaGx4L2RlY29kZV9leHRfaGx4LmMKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9obHgvZGVjb2RlX2V4dF9obHguaCBiL3RhcmdldC9oZXhhZ29uL2hseC9kZWNvZGVf
ZXh0X2hseC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi43ZmVlY2Zm
NmMxOAotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2hseC9kZWNvZGVfZXh0X2hs
eC5oCkBAIC0wLDAgKzEsMTQgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hu
b2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2lmbmRlZiBIRVhBR09OX0RFQ09E
RV9FWFRfSExYX0gKKyNkZWZpbmUgSEVYQUdPTl9ERUNPREVfRVhUX0hMWF9ICisKKyNpbmNsdWRl
ICJpbnNuLmgiCisKK2Jvb2wgaGx4X2V4dF9kZWNvZGVfY2hlY2tzKFBhY2tldCAqcGt0LCBib29s
IGRpc2FzX29ubHkpOworU2xvdE1hc2sgaGx4X2V4dF9kZWNvZGVfZmluZF9pY2xhc3Nfc2xvdHMo
aW50IG9wY29kZSk7CisKKyNlbmRpZiAvKiBIRVhBR09OX0RFQ09ERV9FWFRfSExYX0ggKi8KZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hseC9kZWNvZGVfZXh0X2hseC5jIGIvdGFyZ2V0L2hl
eGFnb24vaGx4L2RlY29kZV9leHRfaGx4LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAuLmNiN2ZjNThkN2Q0Ci0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24v
aGx4L2RlY29kZV9leHRfaGx4LmMKQEAgLTAsMCArMSwxMTcgQEAKKy8qCisgKiBDb3B5cmlnaHQg
KGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4K
KyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2lu
Y2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJkZWNvZGUuaCIKKyNpbmNsdWRlICJvcGNv
ZGVzLmgiCisjaW5jbHVkZSAiaW5zbi5oIgorI2luY2x1ZGUgImljbGFzcy5oIgorI2luY2x1ZGUg
ImhseC9obHguaCIKKyNpbmNsdWRlICJobHgvZGVjb2RlX2V4dF9obHguaCIKKwordHlwZWRlZiBz
dHJ1Y3QgeworICAgIGJvb2wgc3RvcmU7CisgICAgYm9vbCBsb2FkOworICAgIGJvb2wgc2hpZnQ7
CisgICAgYm9vbCBtcHk7Cit9IGhseF9wa3RfcmVzb3VyY2VzX3Q7CisKK3N0YXRpYyBib29sIGNo
ZWNrX2hseF9zbG90X2NvbnN0cmFpbnRzKFBhY2tldCAqcGt0LCBpbnQgc2xvdCwgaW50IGluc25f
aWR4LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGx4X3BrdF9yZXNv
dXJjZXNfdCAqcmVzb3VyY2VzKQoreworICAgIGludCBvcGNvZGUgPSBwa3QtPmluc25baW5zbl9p
ZHhdLm9wY29kZTsKKworICAgIGlmIChzbG90ID09IDApIHsKKyAgICAgICAgaWYgKCFHRVRfQVRU
UklCKG9wY29kZSwgQV9TVE9SRSkpIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAg
ICAgfQorICAgICAgICBpZiAocmVzb3VyY2VzLT5zdG9yZSkgeworICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOworICAgICAgICB9CisgICAgICAgIHJlc291cmNlcy0+c3RvcmUgPSB0cnVlOworICAg
IH0gZWxzZSBpZiAoc2xvdCA9PSAxKSB7CisgICAgICAgIGlmICghR0VUX0FUVFJJQihvcGNvZGUs
IEFfTE9BRCkpIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAgICAg
ICBpZiAocmVzb3VyY2VzLT5sb2FkKSB7CisgICAgICAgICAgICByZXR1cm4gZmFsc2U7CisgICAg
ICAgIH0KKyAgICAgICAgcmVzb3VyY2VzLT5sb2FkID0gdHJ1ZTsKKyAgICB9IGVsc2UgaWYgKHNs
b3QgPT0gMikgeworICAgICAgICBpZiAoIUdFVF9BVFRSSUIob3Bjb2RlLCBBX0hMWF9TSElGVCkg
JiYKKyAgICAgICAgICAgICFHRVRfQVRUUklCKG9wY29kZSwgQV9ITFhfQ09NTU9OX0FMVSkpIHsK
KyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAgICAgICBpZiAocmVzb3Vy
Y2VzLT5zaGlmdCkgeworICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworICAgICAgICB9CisgICAg
ICAgIHJlc291cmNlcy0+c2hpZnQgPSB0cnVlOworICAgIH0gZWxzZSBpZiAoc2xvdCA9PSAzKSB7
CisgICAgICAgIGlmICghR0VUX0FUVFJJQihvcGNvZGUsIEFfSExYX01QWSkgJiYKKyAgICAgICAg
ICAgICFHRVRfQVRUUklCKG9wY29kZSwgQV9ITFhfQ09NTU9OX0FMVSkpIHsKKyAgICAgICAgICAg
IHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAgICAgICBpZiAocmVzb3VyY2VzLT5tcHkpIHsK
KyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAgICAgICByZXNvdXJjZXMt
Pm1weSA9IHRydWU7CisgICAgfQorCisgICAgcmV0dXJuIHRydWU7Cit9CisKK2Jvb2wgaGx4X2V4
dF9kZWNvZGVfY2hlY2tzKFBhY2tldCAqcGt0LCBib29sIGRpc2FzX29ubHkpCit7CisgICAgaGx4
X3BrdF9yZXNvdXJjZXNfdCByZXNvdXJjZXMgPSB7CisgICAgICAgIC5zdG9yZSA9IGZhbHNlLAor
ICAgICAgICAubG9hZCA9IGZhbHNlLAorICAgICAgICAuc2hpZnQgPSBmYWxzZSwKKyAgICAgICAg
Lm1weSA9IGZhbHNlCisgICAgfTsKKworICAgIC8qIFNsb3RzIGFyZSBhc3NpZ25lZCBvbmx5IGZv
ciBleGVjdXRpb24uICovCisgICAgaWYgKGRpc2FzX29ubHkpIHsKKyAgICAgICAgcmV0dXJuIHRy
dWU7CisgICAgfQorCisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwa3QtPm51bV9pbnNuczsgaSsr
KSB7CisgICAgICAgIGlmIChHRVRfQVRUUklCKHBrdC0+aW5zbltpXS5vcGNvZGUsIEFfSExYKSAm
JgorICAgICAgICAgICAgIWNoZWNrX2hseF9zbG90X2NvbnN0cmFpbnRzKHBrdCwgcGt0LT5pbnNu
W2ldLnNsb3QsIGksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJl
c291cmNlcykpIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAgIH0K
KyAgICByZXR1cm4gdHJ1ZTsKK30KKworU2xvdE1hc2sgaGx4X2V4dF9kZWNvZGVfZmluZF9pY2xh
c3Nfc2xvdHMoaW50IG9wY29kZSkKK3sKKyAgICBpZiAoR0VUX0FUVFJJQihvcGNvZGUsIEFfUkVT
VFJJQ1RfU0xPVDBPTkxZKSB8fAorICAgICAgICBHRVRfQVRUUklCKG9wY29kZSwgQV9TVE9SRSkp
IHsKKyAgICAgICAgcmV0dXJuIFNMT1RTXzA7CisgICAgfQorICAgIGlmIChHRVRfQVRUUklCKG9w
Y29kZSwgQV9SRVNUUklDVF9TTE9UMU9OTFkpIHx8CisgICAgICAgIEdFVF9BVFRSSUIob3Bjb2Rl
LCBBX0xPQUQpKSB7CisgICAgICAgIHJldHVybiBTTE9UU18xOworICAgIH0KKyAgICBpZiAoR0VU
X0FUVFJJQihvcGNvZGUsIEFfUkVTVFJJQ1RfU0xPVDJPTkxZKSB8fAorICAgICAgICBHRVRfQVRU
UklCKG9wY29kZSwgQV9ITFhfU0hJRlQpKSB7CisgICAgICAgIHJldHVybiBTTE9UU18yOworICAg
IH0KKyAgICBpZiAoR0VUX0FUVFJJQihvcGNvZGUsIEFfUkVTVFJJQ1RfU0xPVDNPTkxZKSB8fAor
ICAgICAgICBHRVRfQVRUUklCKG9wY29kZSwgQV9ITFhfTVBZKSkgeworICAgICAgICByZXR1cm4g
U0xPVFNfMzsKKyAgICB9CisgICAgaWYgKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0hMWF9DT01NT05f
QUxVKSB8fAorICAgICAgICBHRVRfQVRUUklCKG9wY29kZSwgQV9ITFhfU0xPVDIzKSkgeworICAg
ICAgICByZXR1cm4gU0xPVFNfMjM7CisgICAgfQorICAgIGlmIChHRVRfQVRUUklCKG9wY29kZSwg
QV9ITFhfQU5ZX1JFU09VUkNFKSkgeworICAgICAgICByZXR1cm4gU0xPVFNfMDEyMzsKKyAgICB9
CisKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBTTE9UU18wMTIzOwor
fQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdv
bi9tZXNvbi5idWlsZAppbmRleCBmZDQ5ODMzNDNkMS4uZjllODIwMjg2ZTUgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1
aWxkCkBAIC0yNjUsNiArMjY1LDcgQEAgaGV4YWdvbl9zcy5hZGQoZmlsZXMoCiAgICAgJ21tdmVj
L3N5c3RlbV9leHRfbW12ZWMuYycsCiAgICAgJ21tdmVjL2h2eF9pZWVlX2ZwLmMnLAogICAgICdt
bXZlYy9odnhfcWZsb2F0LmMnLAorICAgICdobHgvZGVjb2RlX2V4dF9obHguYycsCiAgICAgJ2hs
eF9oZWxwZXIuYycsCiAgICAgJ2hseF9ndmVjX3RhYmxlcy5jJywKICkpCi0tIAoyLjM0LjEKCg==

