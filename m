Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TT3oRvPL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F6KwPhkq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoq2-0007cw-Bn; Sat, 24 Oct 2026 23:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq0-0007cR-G7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKopy-0001Rj-JO
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:00 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16YYs3095283
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=; b=TT3oRvPLjHOFQ7vp
 jtry0gPDUrwARv5pybXrreor5qYgzddRk/fZHffu8nJLWDmKbbEqfKTEe47g59qo
 y58bKxPgoO9TbtnN6Dnpjr3RWrHZFz98ePLqQ0TIAI2xI8t+OARfBPpm09ux8+CF
 WDFCeh+biuKS71E/GkNEiElsNcnGKffdx6w+QUihCTSpQvTkJiHdBt293h8Gwdcd
 ZXh/nNtZVfrYhpGlhljmcFrDEmywzOaSH93fTTcwg22TrA1fJhW7JhOGw1hFPTQd
 U1Lh24rl+S8PfQr8iTonIqrd2H60/37XuWfQRmWYG1mk8PuNoLMDvOb8ppwnyL/u
 005JyQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgj1pap4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:56 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so8083628c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898635; x=1793503435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=;
 b=F6KwPhkqsWAotEDVPM6xLdIP/oL4DyjuZKLh0b8jZ7TKUtLdaRoiawDwrGXZvydlVS
 ajJLjFcjPycXmYMGYfeJ5w6rUcJ1+MGSUn/xFIeKssyblK1PcHbKS5bHgGCCLYOvBD/U
 ti36MLTHed0b+tFvHSJzMl6apArdRaSFI7A6s/o+v3xzV3RMhvxbSXwRW+s6ooG+1Z8K
 CCwqc9ZZ4wfJyvyosxopXb7z89hAfh1gbTK9/+0Iu6UOMmeeG3flye62zNQKUVgJgzjJ
 v7thEMiaExn1K3Ob9eIkm/o4D02k8kSojg9oST6fGw83rslLNVvpELWpTQm8adH2S7Tb
 tUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898635; x=1793503435;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=;
 b=mZP/wCm+rdPl16tC99v+JKt8yy5iz80SQvvmhpKAP8r0jAImj7OSIOCbP8pt1NmnrU
 Lfzz98svKDaAnooisdv4U5gMEmboEDLCvgTRGDFbWYEah96HxFc8cWzPfplauwtMayfw
 WfD+u1eznldaRJqZOz3e0K8t+SXNTfiI0VxhNdXEaUaLgAB+OvANdKRGJTka5bDhXI5i
 mH9/Auw533LTKernjocN/f8S0UhOGsiMi2/UbdTSPPOeq8pndNEq1DQqad8Ughjq8psc
 zNEOKfPbococCjct6DckhE2IBsiTuruRYlhBLhpwx0Wvyk1Lty7YzThXGHNhhffrudE0
 Rw2A==
X-Gm-Message-State: AFq9FYI1K/gX3YNvBa8tLhaCqSVZ8LCQFwcNMJBoUW53zkBbBQKMhb38
 OBYrhjHKY3+tLSEhBSiHvykLYsBub6zTGeOv5YVk9s4+C+nLxA66/ys4yTV6v0rGxSXWnNO9ds4
 1Ekof866xI72V3plrr7EJzgaJH5xZAWUpM8hHNxPI2Can8fON3RGFk+qhDsC36sfwwg==
X-Gm-Gg: AYBFou2JINSq1sbKPpEu2heDDN9YW6+vz4e+i+soD23Db0mj+UzPnqleai40KUmZVH/
 vGc9CpIlTvfKV9GIfym7HfQZW5HTYx16w1EevQDLiJuG9k21SfQ1nMZAJjBL5jw46Di05872iIU
 IbzMnXz9i23fI26C5Lv9RN3TgnZm2gEk3KHIxRQQGY6uMWOVbuSE5ZNRSKWegGu9uVFADWfOWw8
 vad1CSKirJrHeq7LcDCM1nffOzR8tKr48lMzJVWQsAU4XIfOqzcQKzKiwJzmaAMtJRoJxXBfsWT
 aZruu2tywQt8LbBbdRTm4bnJXkI3D3Q2udMixeYUO4ccRW+/Wuxf7Qa1FFm7InhJsW6AriVg2gH
 wsO1EIcMiooRQ3XqXEBsUl9Uhiq8M4DcPY4ihbf+JHiyw37M=
X-Received: by 2002:a05:7022:ea47:20b0:19c:7716:cf72 with SMTP id
 a92af1059eb24-19c7716d165mr2037573c88.32.1792898635254; 
 Sat, 24 Oct 2026 20:23:55 -0700 (PDT)
X-Received: by 2002:a05:7022:ea47:20b0:19c:7716:cf72 with SMTP id
 a92af1059eb24-19c7716d165mr2037544c88.32.1792898634700; 
 Sat, 24 Oct 2026 20:23:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:23:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 01/40] hw/hexagon: add V73NC_1 machine
Date: Sat, 24 Oct 2026 20:23:07 -0700
Message-Id: <20261025032346.2917451-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX2L2WwvHx+a9S
 xbnPxjTzLoKBphQSDKop4wmyqKNDAnAW0A9zHPcniy7qZj+mUfc1B/aKuFexmFdcFwbVmwLTVnX
 UkrAYODNPwzjx4xgx7kJLrj9zBN/Plw=
X-Proofpoint-GUID: sXfmHPkaSkNAKh4BrbeVto8T9WtS_wbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXw7UQROOJZMn0
 h7QuTH/krO2WljgPg/82Fi5u6h44z5xV1QvPYJuq5o1gJrlYyxW3NIOcaIoFjwU7CH+feGsJCt1
 zhYDIqZ6FdFEYwvesJSD/3obicVOlOXPpnSRk/iUXsAf3mDZnSFrCDZd0v6tbscBK+P0K4vJkvU
 oeoEm1/ySSdCQHLg5maPKtOgjIwzJ9DEMAoSz8wSA62rYaFyalp2kJ0PmFIWILS9E3gCuAZQkoq
 z5fUqryPxOBXqy96dXBLzf8frWBo5GwZQ8plhYAcGybmLeDHYdpzb4i+mWmwsokJY8W6mPm+f/k
 zIOZ7we2AwlVE+/Rx52XXSbKYGuVR0oyrmuTy73L7GTz1rN7NHPHxr57Q/FoOpLCb4TdU+Q36Ew
 hLVIBALq9FMk6bFex8nLbAkf650y3tRWjAkLFeklg4qrQMSlBs75qom4HH4Wyn0QgHYt//Y3gGA
 9czmnN56l+kZ6qOoAtQ==
X-Proofpoint-ORIG-GUID: sXfmHPkaSkNAKh4BrbeVto8T9WtS_wbd
X-Authority-Analysis: v=2.4 cv=D5vSufRj c=1 sm=1 tr=0 ts=6add764c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pj8LCFR3QBkfOnWAeuwA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClNpZ25l
ZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClJl
dmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9oZXhhZ29uL21h
Y2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysrKysrKysKIDMg
ZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hl
eGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYwoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
aGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCmluZGV4IDli
NWQzM2ZmYzNiLi5hMDFjZjVjYjNiMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC0yNyw2ICsyNyw3
IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjcxX3JldiA9IDB4OGM3MSwKICAgICB2NzNfcmV2ID0g
MHg4YzczLAogICAgIHY3M21fcmV2ID0gMHhjYzczLAorICAgIHY3M25jXzFfcmV2ID0gMHg4Yjcz
LAogICAgIHY4MV9yZXYgPSAweDg3ODEsCiAgICAgdjgxZGdiXzFfcmV2ID0gMHhjYzgxLAogfSBS
ZXZfdDsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uNzI5ZTQ4OTc1YzgKLS0tIC9kZXYvbnVsbAorKysgYi9ody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMKQEAgLTAsMCArMSw3MyBAQAorLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KKworc3RhdGljIGNvbnN0
IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY3M25jXzEgPSB7CisgICAgLmNmZ2Jhc2Ug
PSAgICAgICAgICAgICAweGQ4MTgwMDAwLAorICAgIC5sMnRjbV9zaXplID0gICAgICAgICAgMHgw
MDAwMDAwMCwKKyAgICAubDJ2aWNfYmFzZSA9ICAgICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwy
dmljX3NpemUgPSAgICAgICAgICAweDAwMDAxMDAwLAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAg
ICAgMHhmYzkwMDAwMCwKKyAgICAucXRtcl9yZWdpb24gPSAgICAgICAgIDB4ZmM5MjEwMDAsCisg
ICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsCisgICAg
ICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3Vic3lzdGVtX2Jhc2UgPSAw
eDAwMDAyMDAwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5LAorICAgICAgICAubDJj
ZmdfYmFzZSA9IDB4MDAwMGQ4MWEsCisgICAgICAgIC5yZXNlcnZlZDEgPSAweDAwMDAwMDAwLAor
ICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwZDkwMCwKKyAgICAgICAgLmF4aTJfbG93YWRkciA9
IDB4MDAwMDMwMDAsCisgICAgICAgIC5zdHJlYW1lcl9iYXNlID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLnJlc2VydmVkMiA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5mYXN0bDJ2aWNfYmFzZSA9IDB4
MDAwMGQ4MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50cmllcyA9IDB4MDAwMDAwODAsCisgICAg
ICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5leHRfY29udGV4dHMg
PSAweDAwMDAwMDAyLAorICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAwZDkwMCwKKyAgICAgICAg
LnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDA4MDAsCisgICAgICAgIC5sMnRhZ19zaXplID0gMHgwMDAw
MDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAudGhy
ZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAgICAgICAgLmVjY3JlZ19iYXNlID0gMHgw
MDAwMDAwMCwKKyAgICAgICAgLmwybGluZV9zaXplID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnRp
bnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fc2l6ZSA9IDB4MDAwMDAwMDAs
CisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsCisgICAgICAgIC5yZXNlcnZlZDMg
PSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNlbnQgPSAweDAwMDAwMDAwLAorICAgICAg
ICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAyLAorICAgICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3Ro
ID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQgPSAweDAwMDAwMDAwLAorICAgICAgICAu
Y29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzAgPSAweDAwMDAw
MDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLnYyeF9t
b2RlID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmNvcHJvYzJfcmVnMiA9IDB4MDAwMDAwMDEsCisg
ICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc0
ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnNSA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5jb3Byb2MyX3JlZzYgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc3ID0g
MHgwMDAwMDAwMCwKKyAgICAgICAgLmFjZF9wcmVzZXQgPSAweDAwMDAwMDAwLAorICAgICAgICAu
bW5kX3ByZXNldCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMWRfc2l6ZV9rYiA9IDB4MDAwMDAw
MTAsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5sMWRfd3Jp
dGVfcG9saWN5ID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLnZ0Y21fYmFua193aWR0aCA9IDB4MDAw
MDAwODAsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDAwMDAwMDAxLAorICAgICAgICAucmVzZXJ2
ZWQ1ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2VydmVkNiA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAwMDAwMGEsCisgICAgICAgIC5jb25zaXN0
ZW5jeV9kb21haW4gPSAweDAwMDAwMGUwLAorICAgICAgICAuY2FwYWNpdHlfZG9tYWluID0gMHgw
MDAwMDA4MCwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9IDB4MDAwMDQwMDAsCisgICAgICAgIC5j
b3Byb2MyX2ludDhfc3ViY29sdW1ucyA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3JlY2ZnX3By
ZXNlbnQgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9mcDE2X2FjY19leHAgPSAweDAw
MDAwMDAwLAorICAgICAgICAuQVhJTTJfc2Vjb25kYXJ5X2Jhc2UgPSAweDAwMDA0MDAwLAorICAg
ICAgICAuQVhJTV9kYXRhX3dpZHRoID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwxZF93YXlzID0g
MHgwMDAwMDAwMCwKKyAgICAgICAgLmwxaV93YXlzID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwy
d2F5X251bSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfanRsYl9lbnRyaWVzID0gMHgwMDAw
MDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBi
L2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCA4ODI0ZmUxMGE1OS4uZDkwNGQ1YWZhMTQg
MTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMKQEAgLTMwLDYgKzMwLDcgQEAKIAogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y2
NmdfMTAyNC5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMiCisj
aW5jbHVkZSAibWFjaGluZV9jZmdfdjczbmNfMS5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2Nm
Z192ODFkZ2JfMS5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192ODFxYV8xLmguaW5jIgog
CkBAIC0yMDAsNiArMjAxLDIyIEBAIHN0YXRpYyB2b2lkIHY2OG5fMTAyNF9pbml0KE9iamVjdENs
YXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBtYy0+ZGVmYXVsdF9jcHVzID0gNjsKIH0K
IAorc3RhdGljIHZvaWQgdjczbmNfMV9jb25maWdfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUp
Cit7CisgICAgaGV4YWdvbl9jb21tb25faW5pdChtYWNoaW5lLCB2NzNuY18xX3JldiwgJnY3M25j
XzEpOworfQorCitzdGF0aWMgdm9pZCB2NzNuY18xX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25z
dCB2b2lkICpkYXRhKQoreworICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9j
KTsKKworICAgIG1jLT5kZXNjID0gIkhleGFnb24gVjczTkNfMSI7CisgICAgbWMtPmluaXQgPSB2
NzNuY18xX2NvbmZpZ19pbml0OworICAgIGluaXRfbWMobWMpOworICAgIG1jLT5kZWZhdWx0X2Nw
dV90eXBlID0gVFlQRV9IRVhBR09OX0NQVV9WNzM7CisgICAgbWMtPmRlZmF1bHRfY3B1cyA9IDY7
Cit9CisKIHN0YXRpYyB2b2lkIHY4MWRnYl8xX2NvbmZpZ19pbml0KE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSkKIHsKICAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hpbmUsIHY4MWRnYl8xX3Jldiwg
JnY4MWRnYl8xKTsKQEAgLTI1OCw2ICsyNzUsMTEgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGhl
eGFnb25fbWFjaGluZV90eXBlc1tdID0gewogICAgICAgICAucGFyZW50ID0gVFlQRV9IRVhBR09O
X0RTUF9NQUNISU5FLAogICAgICAgICAuY2xhc3NfaW5pdCA9IHY2OG5fMTAyNF9pbml0LAogICAg
IH0sCisgICAgeworICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJWNzNOQ18xIiks
CisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCisgICAgICAgIC5j
bGFzc19pbml0ID0gdjczbmNfMV9pbml0LAorICAgIH0sCiAgICAgewogICAgICAgICAubmFtZSA9
IE1BQ0hJTkVfVFlQRV9OQU1FKCJWODFER0JfMSIpLAogICAgICAgICAucGFyZW50ID0gVFlQRV9I
RVhBR09OX0RTUF9NQUNISU5FLAotLSAKMi4zNC4xCgo=

