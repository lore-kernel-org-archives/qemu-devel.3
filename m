Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B01C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FDs-0000fI-Bu; Mon, 14 Sep 2026 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDb-0000dI-M5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDZ-0006qQ-37
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJZ3uR772833
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XD4bk1vlqFkPULOSiPy9282jSdpZze/qiV59zoNxK8s=; b=D+1kyAfV/MwQ+LOT
 w22B+S11EiVfW3REJqprzjjUS0/1o9Tr8VcQc3rzWyWc1Evo7e9gKBy4GkEES6ST
 3sWmiChVPjooGKbCL9GXPF5SonXRQmLZU//jExrRZXXfVmh/bXcQ7P/tRDWBOe4j
 c7gPQ4c8FkqTPf8NmyfJC4s8TDg0mdsDp3aqB/ysM6fPf8EKcu2MisPZ4kxN1Utt
 NfA5oElFIL0oWXF7uFBCI/2XLcv/mvGbCbSa1Ja5Lc4o0DsMUVpEj/BecE2BhtId
 afYoQ90BDPOEioCL1FZSqGzhY2ZVEZstv5sqRMavksA82QFE7NtU+nvZoh5DLJrH
 P7NUFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg3cax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so6509084a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789425123; x=1790029923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XD4bk1vlqFkPULOSiPy9282jSdpZze/qiV59zoNxK8s=;
 b=ZTlzMvJtUIdPiwrZhE3xNe0rUcjq85Ibqv/a5G1ykkHQZJv/AdMmy7RmwFVr3KhRsv
 O7USGxGyQWuK+TaT28bPImS/8/DiisKULrCSOaIaaR217UCsd0lve4f4KaDKEvSK6D/c
 kCpMNiRB+hDgLelNii747XU9p0oxGPxopG1FIody0WvYZQCTMN9J9VFqlzVBBOYvVkY8
 JrRgwvUrzwYn0ObjeizmM0d/ZsGGgbOBOL3BXqVT/af587GdNOR4IVVwxo7nIPTkSPri
 CjndP51aRIiHJDohcu2gmirSwsOHMPTreCpCEFUguNuV/H675cDqyRXuPQvVMZziNQl5
 TMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789425123; x=1790029923;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XD4bk1vlqFkPULOSiPy9282jSdpZze/qiV59zoNxK8s=;
 b=PbTRj7rTcbaetuGBWvUYJqJjPCvi+JLCUMNzwY5Ggpyl8C30cpyhDIQmBOkmM9q5zn
 uSgbqy0W9VfIyFvB8DBv9+UfNwi7FDGnYsN98kV79xOe/AxU2aBbLm95MBjbfSgskKxT
 tRLrgs8e3a3k/25Rq8UqAtS2y91N2KFqFp+R9NoGeW6hEKCjvR2SMk/Lv+jIQm9JNp7h
 ceHZ3Ri1Zu6vlgthdxNdklWE4I5VTQeiq24mtktqCkVJi4qlFSzueebE+3ToiQmvkeMq
 sU0S3j9gch9Z45r+cxFqxHq3bU3x6oc8CwLk1wzGXllQ9ktChzWP2MnKuJRkjNX6TFSB
 Ry9Q==
X-Gm-Message-State: AFuF++murbiyXt/WaCIA9o/qt1iGu39RvnkAZhlFhcWXPry7cWcW9Zik
 JF9sSN1barwkLcdQ25GjISaCaz9fMQicZzswC8DYKMxLj3oNJ8moImWHsPtBUfMvUuAs/z6FTX6
 +sdpGuHYEOnCB/n1YAZ1aVOqJ2zdCnLgATJ8Zsas8zdUCp/OhR8bF4RKxVOeC1bH3RA==
X-Gm-Gg: AYBFou281VdP43JRzAQxS15Cz7b/HRPMnwNhRUEzeONoBdAwdN7o9/iDxVVHf4OI6q5
 cYEMa67CUR5UzfKCHgAPTSilGEDiEAIlQlpBUWMG7ed5RWymXvBl1OJkY2XfVnJznCKP1AgIcZB
 eyYg+Dfz7YyXEeDCNy3zGAOBHLwpR5Qh81odgFqIVLk1nM4NxHFZuxGiosRXh+769h0F2OeSfxH
 NiPdNfENT4AMts5pdhs4ZrKu3VfTNKsADNRe0D+XKv+9nuloGnWtmdjlsR6bM9m3V62UlHTS+Xr
 R2Vk2EFTZXk4x12XHW3r6f+cwrVlGeR3BiaJyceczi7dWNPbAe05LiT9W5EaS2sv4mkbsJhK4TH
 aiCmzXrAuKgSVcz5dCJlKoawvdb/gxRkOM/Z6Gzef50mJYe5s
X-Received: by 2002:a17:90b:39cc:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39debf5f2a2mr8990929a91.4.1789425122853; 
 Mon, 14 Sep 2026 15:32:02 -0700 (PDT)
X-Received: by 2002:a17:90b:39cc:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39debf5f2a2mr8990851a91.4.1789425122286; 
 Mon, 14 Sep 2026 15:32:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm30190753eec.31.2026.09.14.15.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:32:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v2 1/4] target/hexagon: fix semihosting OPEN filename handling
Date: Mon, 14 Sep 2026 15:31:56 -0700
Message-Id: <20260914223159.2735262-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa875e3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KK66kVsJytlCUo0Xp5QBPCkORulhGNAc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX9ogISnx5TrNk
 mhOqD8LjQDh6ZQTrVu8l7akyx11I9o1pxjdLXvngoVxtgQkhXnpw7+Fr6N7xy7lTnR7DcrePj40
 NGUhEHHl6aSYVuk5p3vGNo3Fij9WnRs=
X-Proofpoint-GUID: KK66kVsJytlCUo0Xp5QBPCkORulhGNAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX3lXx3z9K1YQB
 y6Hyak4OBseO60NPnVSVoxxk15FtpPHE8FNoMylD7oodObBmbypDFxS++n19e/sUS6vRI6v7g86
 zJgeLD77LORobaVjx1cXqKf2ybeaCZ2u+JR8qPPPOnL3hVLOSYEIE/hthaZFOK3b5Nl2lRd5t9s
 lGeL9XE0pkMea5avdfl8OIVhdokxy8YuXHHfZMI04RemVbKXM66L18Lw8/8/kjToNn5SMcFBdFB
 DnoK5adL6IM1jeU2V+8s8p4C/0j3gs2nN0RNxlPUWbZ1yPui5ch+LJRtlK3rNEM6AVWj1lYnR5U
 lt29LxDh17oQPzubucqCmmJAEV2X+aQWxwWc9DdpHASClM1siexNOqUpLZgAKHgU9nCsJlpJH6m
 BCgpy3n82WEbFArbUs2QYcr0/5Gk9Am+/X/S0PlWg+NQd6XmKflsUQNunwK6IRDzGENYGUNMGsC
 DPWATxcTN9A8OQdz5tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140322
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYSBOVUwuCkEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoIHRoZQpBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAzNCArKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgYi90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwppbmRleCA0NzA1ZTkxNWFlYS4uMjFlNWQ2MzBhNzUgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eHN3aS5jCkBAIC0yOCw2ICsyOCw3IEBACiAjaW5jbHVkZSAic2VtaWhvc3RpbmcvY29uc29sZS5o
IgogI2luY2x1ZGUgInNlbWlob3N0aW5nL3N5c2NhbGxzLmgiCiAjaW5jbHVkZSAic2VtaWhvc3Rp
bmcvZ3Vlc3RmZC5oIgorI2luY2x1ZGUgInNlbWlob3N0aW5nL3VhY2Nlc3MuaCIKICNpbmNsdWRl
ICJzeXN0ZW0vcnVuc3RhdGUuaCIKIAogLyogbm9uLWFybS1jb21wYXRpYmxlIHNlbWlob3N0aW5n
IGNhbGxzICovCkBAIC00NjEsMzEgKzQ2MiwxNyBAQCBzdGF0aWMgdm9pZCBzaW1faGFuZGxlX3Ry
YXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogCiAgICAgY2FzZSBIRVhfU1lTX09QRU46CiAgICAg
ewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZpbGVuYW1l
OwogICAgICAgICB0YXJnZXRfdWxvbmcgcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAg
dW5zaWduZWQgaW50IGZpbGVtb2RlOwotICAgICAgICBpbnQgbGVuZ3RoOworICAgICAgICB1aW50
MzJfdCBmaWxlbmFtZV9sZW47CisgICAgICAgIHNpemVfdCBmaWxlbmFtZV9zaXplOwogICAgICAg
ICBpbnQgcmVhbF9vcGVubW9kZTsKICAgICAgICAgaW50IHJldCwgZXJyID0gMDsKLSAgICAgICAg
aW50IGkgPSAwOwogCiAgICAgICAgIGhleGFnb25fcmVhZF9tZW1vcnkoZW52LCBzd2lfaW5mbywg
NCwgJnBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIHJldGFkZHIpOwogICAgICAgICBoZXhhZ29uX3Jl
YWRfbWVtb3J5KGVudiwgc3dpX2luZm8gKyA0LCA0LCAmZmlsZW1vZGUsIHJldGFkZHIpOwotICAg
ICAgICBoZXhhZ29uX3JlYWRfbWVtb3J5KGVudiwgc3dpX2luZm8gKyA4LCA0LCAmbGVuZ3RoLCBy
ZXRhZGRyKTsKLQotICAgICAgICBpZiAobGVuZ3RoID49IEJVRlNJWikgewotICAgICAgICAgICAg
cWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICIlczogZmlsZW5hbWUgdG9vIGxhcmdlICglZClcbiIsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fZnVuY19fLCBsZW5ndGgpOwotICAgICAgICAgICAgc2VtaV9jYihjcywgLTEsIEVOQU1F
VE9PTE9ORyk7Ci0gICAgICAgICAgICBicmVhazsKLSAgICAgICAgfQotCi0gICAgICAgIGRvIHsK
LSAgICAgICAgICAgIGhleGFnb25fcmVhZF9tZW1vcnkoZW52LCBwaHlzaWNhbF9maWxlbmFtZV9h
ZGRyICsgaSwgMSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmZpbGVuYW1lW2ld
LCByZXRhZGRyKTsKLSAgICAgICAgICAgIGkrKzsKLSAgICAgICAgfSB3aGlsZSAoZmlsZW5hbWVb
aSAtIDFdKTsKKyAgICAgICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIHN3aV9pbmZvICsgOCwg
NCwgJmZpbGVuYW1lX2xlbiwgcmV0YWRkcik7CiAKICAgICAgICAgLyogY29udmVydCBBUk0gQU5H
RUwgZmlsZW1vZGUgaW50byBob3N0IGZpbGVtb2RlICovCiAgICAgICAgIGlmIChmaWxlbW9kZSA8
IEFSUkFZX1NJWkUoYW5nZWxfdG9faG9zdF9maWxlbW9kZV90YWJsZSkpIHsKQEAgLTQ5OCw2ICs0
ODUsMTYgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVu
dikKICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICB9CiAKKyAgICAgICAgLyogVGhlIEFCSSBs
ZW5ndGggZXhjbHVkZXMgdGhlIGZpbGVuYW1lJ3MgdGVybWluYXRpbmcgTlVMLiAqLworICAgICAg
ICBmaWxlbmFtZV9zaXplID0gKHNpemVfdClmaWxlbmFtZV9sZW4gKyAxOworICAgICAgICBmaWxl
bmFtZSA9IGxvY2tfdXNlcihWRVJJRllfUkVBRCwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWVfc2l6ZSwgdHJ1ZSk7CisgICAgICAg
IGlmICghZmlsZW5hbWUgfHwgZmlsZW5hbWVbZmlsZW5hbWVfbGVuXSAhPSAnXDAnKSB7CisgICAg
ICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciwgMCk7
CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAgICAgIGJyZWFr
OworICAgICAgICB9CisKICAgICAgICAgaWYgKHN0cmNtcChmaWxlbmFtZSwgIjp0dCIpID09IDAg
JiYKICAgICAgICAgICAgIHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV9oYXNfY2hhcmRldigpKSB7
CiAgICAgICAgICAgICByZXQgPSBhbGxvY19ndWVzdGZkKCk7CkBAIC01MTMsNiArNTEwLDcgQEAg
c3RhdGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAg
ICAgICAgICAgICByZXQgPSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAg
ICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAg
ICAgICAgc2VtaV9jYihjcywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQu
MQoK

