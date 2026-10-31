Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C60606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HnvOG4Gx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ErgqWqCE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvy-0004u2-42; Fri, 30 Oct 2026 21:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvC-0004VM-MI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxv8-00032r-MP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1Bo6W3871195
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +oVjPWE9uKrTuPsePkA15Vd/LQdr5a0icXgBILCqBW8=; b=HnvOG4GxdVocsIHF
 Nfb7iZ78br7cvTlnlc1OLlJQtBSrDkXaKtyF0ksfQAKy9s+UMusRkpZXDU5pHAGy
 +ajKQnalzYJwLg/GGaYYfgP0YMuOK+m2cHwwRqj58Z9GQm8fEVhuk0wl3oH2zTbf
 hFbpqx4JM4ldW0I+2kYAPqAQS+pZmv7Q0rdraU+UoFdZShup7kpcATRY7QMaRQsM
 proU1IeLyV91TRHHCtByw5DQdaccoFRwLWrsBiGnF7g4X0yr6GfravwG5eCK+5M6
 r8F87527cg/7amHiJGLRTie1YIrc78EYma2Lm4u+xWD6T8Hhjlcg8IjiI6KIucGo
 3vKraA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08juf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a190c53a3so1682386eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410209; x=1794015009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+oVjPWE9uKrTuPsePkA15Vd/LQdr5a0icXgBILCqBW8=;
 b=ErgqWqCEyHN7h3gzsTkjIDSkHE9ZwqQ+hZo1fC+S8bSOJl1+8vsTIt25PXzWfNrkiT
 h6fCRRcrU8K4GsKg/vInjvI5QwQBALNO1tuNe5RXn07mzmu6z+wW4Kf4eCiorUGIui8e
 ZbMxW9cLHhRdacaju/fvK3lpZk5RVA2bU+F2n3laSvrE9SFL6Q7ZO9GzzEE6OlnPjnsN
 r07VHLKtyRxc+EnHjRUvKl2FtyHThNsbBdkBOmR3dloM+PNdXugU5/g5IAKDJfLE8eAl
 tinCC/hQs4XoOCWbx7h7rh7CPQkE8Yjp7/wu17gtkprOuM+F2Hu2q5nO5waNDivLzzyf
 Zyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410209; x=1794015009;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+oVjPWE9uKrTuPsePkA15Vd/LQdr5a0icXgBILCqBW8=;
 b=RIGsC/6Kd29ufqbnvTE33KclOEcgx9gpH6qW/C8ARh0bOEwBBsyrIM2zKEE+uoArCN
 Cgle4l0zgNOv2GAuSBsnEFsl22w4thlNTEILOygB+alyJMSWeqEtfSsWdaGd0EAyN/Wc
 FvNAQx6tSbibhg/W+Il4dMUNpIDdo9y0/xM5prGEgX8Tsf0RCmMEnKDkdcpnC9xa4oMw
 LTDI7J7AHJheDR4Xzxdflut3NPpvShoBEr3YUDl0kcwnU9wacl2r4pplJla5l2oLlkv5
 rJXmA8LOxmvFO03F2/13BY7o7b2PSE0L1jqIZvVMRz97v0i56f+14pRq9C3MmUBxxZSE
 r7zw==
X-Gm-Message-State: AFq9FYIjszsOZUbCOQylIz4k2GCMcYrrhjCI8GpauYpFzT4jJXJAy2LA
 p3Mjjb3bKZRf0f1c17mIqSvVg34m/vT69W8oeagQqWp2m/3XdcOEZei0lPKsBhCbcg0Uab0wY5s
 7VLlEv+DuffWjnsKMicCHDb60aaF3PyKpe0fLLuI0VOgPyAuQzBIH2zfdV4trArPZMA==
X-Gm-Gg: AYBFou2NoXYG7RtlUzOt+qCFgACrAPNNXHSd+haOKYcKp5Rn3QiEohXgFeLmWHuojmr
 NDGcY6M+qiSVLn1i7z2XWK7k63/jrHq4sBbNV7JC7sTbMZzd2ctVJLlc7Rst8sbZJGLBAN+n/i/
 U9+KfzhP2CSg3nWqhFAzyzMKUUmbfqGQTWQQFqj1GRktY7n9Jr0Rh738oQYDDbwD7LYCm8W+Sg3
 UeU13SNjMQ3gx3USL8jSGSXTnVRfT0tS97WUZ6pqCfqWNuxLXkAxKvzLxurA8zBraxKhc2F/FEb
 V8+Mxx43DO9prTHhLaEQUJY3NHVFa666jJMUlHiqCFahhfJulzpftN38xIanJ8xRz5KtEyH4vS3
 MQ/zF4sSh2HcKTeLCWLnJrQzo1ImwNRUPUOENoR2sQKY2HfYAVRjjzM2m/yHrZ8eESHIZ5boRMP
 tYaZJd77Vq7a9bN8yj2ao2aw==
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id
 5a478bee46e88-36a3002ef31mr13205649eec.14.1793410208570; 
 Fri, 30 Oct 2026 18:30:08 -0700 (PDT)
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id
 5a478bee46e88-36a3002ef31mr13205599eec.14.1793410207845; 
 Fri, 30 Oct 2026 18:30:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/40] target/hexagon: don't take the BQL to find the MMU index
Date: Fri, 30 Oct 2026 18:29:08 -0700
Message-Id: <20261031012941.339141-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hAY83Ejy0Msant6b99xxwVvsSYjq-_wa
X-Proofpoint-GUID: hAY83Ejy0Msant6b99xxwVvsSYjq-_wa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX81GI4HyqgP7e
 H78o753R1CRQpQxBrRham0Z/60dguA3lR7bEyonoGR3HbhSSQ/d8csiT6phRABvX2l6zAmrjqTP
 RhhmSV3EbzOuxS9PrjaHlJvs30XFSPE=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae544a1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hd0I6R_-cxdpsw1IhpQA:9 a=6xlk6pCANpZPHnt1:21
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX609QlIcKTEFa
 p+rL2tbq9nbTWSqEXFl0ed8uMfYdZvZhbeoIMyq5C9+GS8vRSdhB6QTu2tKRd29VXU3RB2blDB+
 SOtCJvlKb1WWim6ppxWPy9tt2ehnmscxjwNWnzyJMsiEqbUqucqtUbYHLQLOL1xh3z2Ti/GzLJc
 oz1UFLq32NlkwuSiVxYcwOzbiPPufbn2FvOTSTV0MbRhqY5Hl6us4LnSTySYztDnC3JRXtf1y8V
 6z3DusCw6E9VwFNUX7ca3Ij6SbZbdyBGfYmctfohXThSjJSCTlk3QYj6pNH6n9ojucwMl0iIDiK
 ZeOmNHWoaogNSvZynuybGa88hJ0pEu37962OT/N2jXae3cDOcbbn0WPxpcr+V2REAnW+auJIQU4
 MElH4KWjpeeGpAho3hUOhNUCqUAhPuDsoIXKixpc32C4PlV/iDUeDQFfhq3sMxpxJgt/TEp6NJ2
 YqhOO90AEQyaTrR3ARw==
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

aGV4YWdvbl9jcHVfbW11X2luZGV4KCkgcnVucyB2ZXJ5IG9mdGVuIC0gZWFjaCBUQi4gIFRha2lu
ZyB0aGUgQlFMIHRvCnJlYWQgc3lzY2ZnIGlzIG92ZXJraWxsLgoKUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1
ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oIHwgNiArKysrKysKIGh3L2hleGFnb24v
aGV4YWdvbl9nbG9iYWxyZWcuYyAgICAgICAgIHwgOSArKysrKysrLS0KIHRhcmdldC9oZXhhZ29u
L2NwdS5jICAgICAgICAgICAgICAgICAgIHwgOSArKysrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oCmluZGV4IDJkNWMzYzE2NmIxLi5kZmQyMWU3ODY2MyAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgKKysrIGIvaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgKQEAgLTU5LDYgKzU5LDEyIEBAIHVpbnQzMl90IGhl
eGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVp
bnQzMl90IHJlZywKIHZvaWQgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGVfbWFza2VkKEhleGFnb25H
bG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgdmFsdWUpOwogCisvKgorICogU1lTQ0ZHLCB3aXRob3V0IHRo
ZSBCUUw6IGZvciB0aGUgdHJhbnNsYXRvciwgd2hpY2ggYXNrcyBmb3IgaXQgb24gZXZlcnkKKyAq
IHRyYW5zbGF0aW9uIGJsb2NrIGxvb2t1cCBhbmQgY2FuJ3QgYWZmb3JkIHRvIGNvbnRlbmQgZm9y
IHRoZSBsb2NrLgorICovCit1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkX3N5c2NmZ191
bmxvY2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMpOworCiAvKiBHbG9iYWwgcGVyZm9ybWFu
Y2UgY3ljbGUgY291bnRlciBhY2Nlc3MgKi8KIHVpbnQ2NF90IGhleGFnb25fZ2xvYmFscmVnX3Jl
YWRfcGN5Y2xlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcyk7CiB1aW50NjRfdCBoZXhhZ29uX2ds
b2JhbHJlZ19nZXRfcGN5Y2xlX2Jhc2UoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzKTsKZGlmZiAt
LWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyBiL2h3L2hleGFnb24vaGV4YWdv
bl9nbG9iYWxyZWcuYwppbmRleCAyMmVjNDAyMDY2NS4uOGI1MGZlYzc3MGEgMTAwNjQ0Ci0tLSBh
L2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25f
Z2xvYmFscmVnLmMKQEAgLTI1Miw3ICsyNTIsNyBAQCBzdGF0aWMgdWludDMyX3QgZ2V0X3JlZ192
YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0
dXJuIHJlZyA9PSBIRVhfU1JFR19QQ1lDTEVMTyA/CiAgICAgICAgICAgICAgICAgKHVpbnQzMl90
KXZhbHVlIDogKHVpbnQzMl90KSh2YWx1ZSA+PiAzMik7CiAgICAgfQotICAgIHJldHVybiBzLT5y
ZWdzW3JlZ107CisgICAgcmV0dXJuIHFhdG9taWNfcmVhZCgmcy0+cmVnc1tyZWddKTsKIH0KIAog
c3RhdGljIHZvaWQgc2V0X3JlZ192YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQz
Ml90IHJlZywKQEAgLTI2Niw3ICsyNjYsNyBAQCBzdGF0aWMgdm9pZCBzZXRfcmVnX3ZhbHVlKEhl
eGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgICAgICByZXR1cm47CiAg
ICAgfQogCi0gICAgcy0+cmVnc1tyZWddID0gdmFsdWU7CisgICAgcWF0b21pY19zZXQoJnMtPnJl
Z3NbcmVnXSwgdmFsdWUpOwogICAgIGlmIChwY3ljbGVfZW5hYmxlKSB7CiAgICAgICAgIHMtPmdf
cGN5Y2xlX2Jhc2UgPSAwOwogICAgICAgICBpZiAocy0+cGN5Y2xlX3J1bm5pbmcpIHsKQEAgLTI4
MSw2ICsyODEsMTEgQEAgc3RhdGljIHZvaWQgc2V0X3JlZ192YWx1ZShIZXhhZ29uR2xvYmFsUmVn
U3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICB9CiB9CiAKK3VpbnQzMl90IGhleGFnb25fZ2xv
YmFscmVnX3JlYWRfc3lzY2ZnX3VubG9ja2VkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcykKK3sK
KyAgICByZXR1cm4gcyA/IHFhdG9taWNfcmVhZCgmcy0+cmVnc1tIRVhfU1JFR19TWVNDRkddKSA6
IDA7Cit9CisKIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoSGV4YWdvbkdsb2JhbFJl
Z1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IGh0aWQpCiB7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDI4MWQyMDEyNTBiLi42MDdkZGRmN2U3YyAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAg
LTU3MiwxMSArNTcyLDE0IEBAIHN0YXRpYyBpbnQgaGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0
YXRlICpjcywgYm9vbCBpZmV0Y2gpCiAgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUo
Y3MpOwogICAgIGludCBjcHVfbW9kZTsKIAotICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgLyoK
KyAgICAgKiBObyBCUUw6IHRoaXMgcnVucyBmb3IgZXZlcnkgdHJhbnNsYXRpb24gYmxvY2sgbG9v
a3VwLCBhbmQgdGhlIHZDUFUKKyAgICAgKiB0aHJlYWRzIHdvdWxkIG90aGVyd2lzZSBxdWV1ZSB1
cCBvbiBpdC4gIFNZU0NGRyBpcyByZWFkIGF0b21pY2FsbHkgYW5kCisgICAgICogdGhlIHJlc3Qg
aXMgdGhpcyB2Q1BVJ3Mgb3duIHN0YXRlLgorICAgICAqLwogICAgIGlmIChjcHUtPmdsb2JhbHJl
Z3MpIHsKICAgICAgICAgdWludDMyX3Qgc3lzY2ZnID0KLSAgICAgICAgICAgIGhleGFnb25fZ2xv
YmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TWVNDRkcsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOworICAgICAgICAgICAgaGV4
YWdvbl9nbG9iYWxyZWdfcmVhZF9zeXNjZmdfdW5sb2NrZWQoY3B1LT5nbG9iYWxyZWdzKTsKICAg
ICAgICAgdWludDhfdCBtbXVlbiA9IEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX01NVUVOLCBzeXNj
ZmcpOwogICAgICAgICBpZiAoIW1tdWVuKSB7CiAgICAgICAgICAgICByZXR1cm4gTU1VX0tFUk5F
TF9JRFg7Ci0tIAoyLjM0LjEKCg==

