Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67985606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwXALclR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h1IwEKJs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1D-00026O-Bl; Mon, 19 Oct 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw1B-000267-Nk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw1A-0003vW-AP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLa4Ct2892393
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zat3YB0A0xL0VOSG+iQ87Y/IW5SuzKvtR9attdSyzfY=; b=pwXALclRXT6EG6ve
 wpNG6AyfmPJliFSS366XA68L4nrY+0Q9I5C5VpDC/k2JJyiwysRzAn+dHbMKrJI+
 YxFe0a0EOT0D/wqTvZHCQshidiqtoVsiw29MGb54VmlgS/l765zk6ldjyKUlIZ+u
 gPyPZFsadK7PlzirU1nJq5FHXZXBvIeMu/QlObSDzdVYhwWZ1oBLKMfrQkKz5/XP
 6hG8y5J/AcvK5PCGZot418y9+XfBQbK8kwcrN4uB+m7Kcr0KhM7u1BmUA+CMCTI+
 eeIR7WXbDXBqzSEJtFEW+BL+vHDZYwaehVQphLpwuo/9H/quOR0YJNJ1g6ub5LWp
 fMOZKw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0wuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so4596121eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449582; x=1793054382; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zat3YB0A0xL0VOSG+iQ87Y/IW5SuzKvtR9attdSyzfY=;
 b=h1IwEKJs7dCGuTe7VeH3e2cTtYO9u0WeU6C78Pe12TAox00xZCh6MeVjrO/lcMgW3B
 tRcNBpjtMCgB3j8jAPUyH3n9miXUCuOib7vmY5FTBSk+57ViQKDQ/8AVW2zTRmIZWs/7
 JRcRb9vfyfk+9bpgsM2JaRi2FE62GBcgWKlBPFDbbE/vtDTXXldKYG+L+oq9sKOeZGgl
 YCmD2jZpZVwIiqPneriWnOoZahuWfh2Jpc9JOmQWLsaNtWJFCBln1z13OCdB/19Mwru0
 DZS385/0PsjcIjbbO3qBf/9VtS1o4PLuWSmG1Y+1m75ll3LHISURJd2BsalTNFPJt4jE
 HFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449582; x=1793054382;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zat3YB0A0xL0VOSG+iQ87Y/IW5SuzKvtR9attdSyzfY=;
 b=V3T8xdys2e7eTs1CJr0Olqh5nA7l1DxbZlWg3ugQEsszlrZ5ytPOB+Dev4ZtBw7kc0
 9qL1iwKfl3sFgPZ2a/nY0aebEdWP3mmwtTUEgxo0VNl/YyDU3a1ZA7osAT/oEJHS2Nri
 absnsGtXQbczNO4t4QKxUi+yMQkDE7RFVVqssBqZIyKVaayestUEXiZhFHwSpHoUS7ou
 mN1rU6/fA5w/iQK0J+HirIoGB3KWRX6r0tAPHa9GZJo5QMwhTJ4jKOxL+IOlP5apBUHe
 HJjWlbGCrXOhFkIfjdFgHXuoRp8Nk0SnO6jpyiYlT8vaNQwiDGRmrG/MQ7ILicrndh2F
 qsjA==
X-Gm-Message-State: AFq9FYIgzP5U/NtGCKveLbZrQCd0SEcQZq3TR5NZgD+mj2TMwMvH7Zqo
 Jz6GClCsjEW0e+1QQDkthEzY23rKN8bba4erNJIgMkxtSOLKL4b0mxxeHblSW5jSOeSQW19/f+S
 y3VVe6IaPOtqip1lMsKeH9NUJC7DOMNBRvx+4qIQsN/YLn90pmyMktU1u9uvTyLf81A==
X-Gm-Gg: AYBFou1G/q4mBIl5yMxArVcnK3Md1DGUSyCJWcD1Z20D/bifuKsAjZ0gh6lzY90+6LF
 Hb3Yr+BX/f3S7dVXNvRHqyd0i9WkTDhaf37oRPSJPsJi+WG9xuYCZ2MhDjkXT09xrXOsxYJfCa1
 1iV0M0nYQ4k1egktWJCR5PLl6b82Hx0BoUN/GX3obfxceaYlX0n1vB1091vN0kWy/7K28vPE/Zi
 rEl4368VEO9Pd3Z++2TUTH3I1fe/eZ0h/f1rFlblrY91vAMfFyHZIaKOtFR/CtBjsgTRrO9L9Zn
 29prp2gegEP0xTxqXGkIea0pTXc0knKl4eqqqIK3v0ln1VPFa9GPSZ6sI8xtX0rEzB93B/unuvg
 YlarS5xddTrFkXe7ARtY8ScCm690DYnpBcnp9kHqacRAJ7C4=
X-Received: by 2002:a05:7300:8256:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-361a146ee7fmr11352741eec.11.1792449582451; 
 Mon, 19 Oct 2026 15:39:42 -0700 (PDT)
X-Received: by 2002:a05:7300:8256:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-361a146ee7fmr11352724eec.11.1792449581943; 
 Mon, 19 Oct 2026 15:39:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 5/5] target/hexagon: enable MTTCG for system emulation
Date: Mon, 19 Oct 2026 15:39:33 -0700
Message-Id: <20261019223933.3248208-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
References: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfXwaTY586D0Zk0
 XivykeWzUFGGx9BFsutjKBAvCpZTDSmJEmDGrdt1ImWfo8JsdEJBkJZHmcEgH65ar9EKLvqvkFO
 dcZPp4UMpJJ5k7Glz1XOGktRrdRfM3g=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad69c2f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=HN0uuiy-se_EESAQhN8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Haew8yWOMPXyHeJRf6jJg-Fw0a-pN-8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX1aiVe7LkhNzX
 +8vRN3+shzJNkxiiz5RULiPPRP0rcEAknkVUHEuBpAJn77GgFKSfcZ9J0ck4IXBmmp8oUXZ/qg5
 WmKczavKozXmTvKAuKJYXEaAjClPM+MN0kKbFPZX6X5RdUuFRQKN8qS7w5j/jJ8AqM5L/YIg3fa
 KWAXAiXzD2/+GAfXjVfPpBmRsy2kbmVVRLpKaPPDUawQTEDBsQioa6mprzVuqaMabe6AOpakhGA
 VPJAG5RwGpGfIPbyX/v7T+KRPf8AkP6MT3kSHyRvLDilLx2DXkdxYF2dJSJdZMtLUXd8/ukb8Ca
 U8iOfaH+nnzTmx8Nl618PtPZZjPYRX14OLeDlcINvSbSL1EBusgxjjs7KeseA8+yPPP9J0jryID
 oC/cvY6plw1BUdcBrTHgtr/gxZUijyyrLEUZBn2daeydZ4E4CNfp7Ztdbe3ol5HG3DoU8WbBtaJ
 wn2Bm1iZpgLO491zYHA==
X-Proofpoint-GUID: Haew8yWOMPXyHeJRf6jJg-Fw0a-pN-8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDg5NmQ3MjgyNWE2Li4wNDE2
YzM3NTE1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKQEAgLTgwOSw5ICs4MDksOCBAQCB2b2lkIGhleGFnb25fY3B1X2RvX3VuYWxp
Z25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyLAogI2VuZGlmCiAKIHN0YXRpYyBj
b25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewotICAgIC8qIE1UVENHIG5vdCB5ZXQg
c3VwcG9ydGVkOiByZXF1aXJlIHN0cmljdCBvcmRlcmluZyAqLwogICAgIC5ndWVzdF9kZWZhdWx0
X21lbW9yeV9vcmRlciA9IFRDR19NT19BTEwsCi0gICAgLm10dGNnX3N1cHBvcnRlZCA9IGZhbHNl
LAorICAgIC5tdHRjZ19zdXBwb3J0ZWQgPSB0cnVlLAogICAgIC5pbml0aWFsaXplID0gaGV4YWdv
bl90cmFuc2xhdGVfaW5pdCwKICAgICAudHJhbnNsYXRlX2NvZGUgPSBoZXhhZ29uX3RyYW5zbGF0
ZV9jb2RlLAogICAgIC5nZXRfdGJfY3B1X3N0YXRlID0gaGV4YWdvbl9nZXRfdGJfY3B1X3N0YXRl
LAotLSAKMi4zNC4xCgo=

