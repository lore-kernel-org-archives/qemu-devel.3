Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD9FD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaX-0002Mn-Vh; Tue, 10 Mar 2026 23:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaV-0002KN-Le
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaT-0005rD-Mw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2pZl43295832
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tJveh2KGypLiC/uLliLXyoDSyHx/mEveAKl7HLv78Ko=; b=FKDllY6gvqQPNVQJ
 QuwMA/bXIfHPomW9NdZxwuQK/Hhe4Yvgc2s8hztbFjTDx7iXPZ6jEXJN+UOOVFEI
 z84udUpvdy8+X/pqWCIXGAI2YLS6qoMzNByabgWurMhfT+fTUFbHPWfARhNleLrS
 Z1KqJWtK9A2JgmZ5bMdliRmg3P4grBEo6x+bwZzrrlNK8CzRhadung1fumIpONdF
 oddWMM+5FAqeZPzat4sENtIC4NDOGNu9QKx5ELQOtZXLXb7HP93Y9l5foDJ8vWFt
 6jA59m1/EGD86wq2Q8c291lgqlISyhUkz+iTcHxWu5NfEJ8JIX+443ViJG3mHkHk
 XHlD+Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1muuyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:10 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73fc43561so27815538a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201009; x=1773805809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJveh2KGypLiC/uLliLXyoDSyHx/mEveAKl7HLv78Ko=;
 b=CzN/INDBzwq1z4JNkZDinFpAZdrdTvkGuzlryNXFtFKnu2hxXHUfzIncBpQQ85ASqU
 MKMtufaH99ILhYwqVCasuR0X2ZuaWBtmfF02YpcX1v2J8USEtW6FaktcwNhmOjJi7Kvr
 yWpxYsiiBYVplgeQGjA/behT6XfVWOIgXOdeDjEtz3QDYil+n3KgOJu7Vf8Qi72TTJ6Y
 y1btSzt6HUpwaT+EGLExnP/xASXBTMItWpsJKaey7TYyTxugeE63YpXppYV3p8K/W4NF
 hJLDcaWEnOh7xFVOYC9RF/U1jhXi11GJNt1SY+kCLGKcVVD511zpL5Lw6IIB0aJnKFDE
 gdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201009; x=1773805809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJveh2KGypLiC/uLliLXyoDSyHx/mEveAKl7HLv78Ko=;
 b=ZXDoNfqBvD9tixyRJwRqznBQ9e6gXxO7Nz9gHeb3wwj/+ta0JF/KBoUwpsEdMgUNc6
 Jq8KE1nYZ7HDEKlIObAMDR4027HROL5sFZBd0jXmmWj6zLYkuCgw6UB59cy9G00O4EGf
 Fb8YkKkhKV7ZWaBurnACEAM3kTofvy2V13JhUm5Rtidd0ufpwQFw8BKsE+bRPVfmbur4
 kajEmblfpBvqURIuG1IFQCZIPUtLsxPzeHPZR7WX4heGRK4cZV+0d3x9q5ZdQVlLeB0q
 a/u9YDmdcEZ0Mb6xEUEaz+A3FmNIx1kbf95avEbVF5RpZ5x6B5xdjlHiQw7DJIUjH01H
 0Vew==
X-Gm-Message-State: AOJu0YxhEnONSFoR28cT4AMoJjk6z0AprXLIb5aJHKkYW2iRKsRCSirI
 DvQ4YL8ZlL2OofMSPcMzFKV1bIgg4v5ioVH6Ezk+lgkEBnzJi+Ssr/RqsHuTzl+ctrR72EK8hoX
 zzyFrXYWbLCm2OST9T4Q8+Mrj1psZ7Up8ME+JZA3HcHm9JTYj0VS6oaXV97ycIoN8Fg==
X-Gm-Gg: ATEYQzxkpZX3lnyWgO+HDkNKtN8my1qKlDDpFW7Qwcm1ADGFZAuJ4rqUa8wGziYjOyK
 j5urz7dnUXhr0GBnu0RAvHbe5SZF72TmW3YvCKpxtnhMy6jYxzDU1qSfTXqPyWBNCPTWxC1QCcL
 4fiTtsPfIWFXIrvOZwvvnoxetp98VoiYbhMGtAIiagH4R2JObeTMlTDm1WFdRfFTTZViKbrOx1z
 n2+MYH0a9iAFd9KdHCi5ZUAmHBhITA2mAMiTgX0xeWo+vCqJZ9j2L8eAFPb7JujoLOwNsdW5TOW
 z6Q7nzzF6rOFUKCZXvst/bz2mNK/rBFduR1SHHZP7WxHlsaL8u7FiSJA8xSHuV9B6CbeuIiup1R
 CS+sRpbMfOJLoKTsyP0o/rfgPrJ6HlCB+o1pwuHnK82XK/DHKvI8COr6pgjqvd0IgngcLng==
X-Received: by 2002:a05:6830:6d11:b0:7d7:5d9c:26c0 with SMTP id
 46e09a7af769-7d76a5dd99cmr967548a34.11.1773201009683; 
 Tue, 10 Mar 2026 20:50:09 -0700 (PDT)
X-Received: by 2002:a05:6830:6d11:b0:7d7:5d9c:26c0 with SMTP id
 46e09a7af769-7d76a5dd99cmr967520a34.11.1773201008833; 
 Tue, 10 Mar 2026 20:50:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 33/35] target/hexagon: Add clear_wait_mode() definition
Date: Tue, 10 Mar 2026 20:49:21 -0700
Message-Id: <20260311034923.1044737-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b0e672 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=InO9qlFFT13rIqmD9gwA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: puYvt3ras63eZtwH7JuBVnontA1FXfph
X-Proofpoint-GUID: puYvt3ras63eZtwH7JuBVnontA1FXfph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX1Nc32CmxpjSM
 pw5YdKqgRCVyy9yWHhRjOhYAyxIsX8XkI8/wkTGLOOjwJrPluwrZ+ZsBvlX6uUdmqBqtTs5AS7z
 DfqdAe8VQt2/RnM/oYvGBTguDfJFQ1nuyu/AlGc92+chILgw193n9gBgwIlaucNyzzTx8dikQVN
 Vk+OZ0PWVCq1vgyJYM7jqc/QQSvlb71HSXfGPYGrHvLsdVVKlE8lKCHJ9RSm3qHmVAh0pPric+X
 vxQPBaA4v6SMI/Gcvh5mqFrlY/dXkW/LY1GHIGaT6Lv0JbK5bkCuOhxLxMxKAxrY3qxIy3pahmx
 ZS/yXjGbadh9Zwdfp8wepfNwUQ2w2aIl9ciAzV0J+l3gptlCqPv5l0ezJhZ0YqCZYL6ORP74mG4
 PIYJDXUOEUumH1pFe5WkkehAYnLJLkklfedZvfWGEmyJKmlVQ5v6grt1kxWCUZdA3VjRcPtNUrX
 wfvu5hyx6U7SOk/Ycyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
dV9oZWxwZXIuaCB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDE1ICsrKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBl
ci5oCmluZGV4IDE4MzAwNjU3ZjNkLi5kMTUzODVkYWY4MyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaApAQCAt
MTYsNSArMTYsNiBAQCB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCk7CiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVf
Y291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QpOwogdm9pZCBoZXhhZ29u
X21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qg
b2xkKTsKIGludCBnZXRfZXhlX21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpOwordm9pZCBjbGVh
cl93YWl0X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIu
YwppbmRleCBiNmE4YmQzNTMwOS4uNmZiZjVmYzhlMmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTY0
LDYgKzY0LDIxIEBAIHZvaWQgaGV4YWdvbl9tb2RpZnlfc3NyKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OwogfQogCit2b2lkIGNsZWFyX3dhaXRfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAg
ICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2Fy
Y2hjcHUoZW52KTsKKyAgICBpZiAoY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIGNvbnN0IHVp
bnQzMl90IG1vZGVjdGwgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVudi0+dGhyZWFkSWQpOworICAgICAgICB1aW50MzJfdCB0aHJlYWRfd2FpdF9t
YXNrID0gR0VUX0ZJRUxEKE1PREVDVExfVywgbW9kZWN0bCk7CisgICAgICAgIHRocmVhZF93YWl0
X21hc2sgJj0gfigweDEgPDwgZW52LT50aHJlYWRJZCk7CisgICAgICAgIFNFVF9TWVNURU1fRklF
TEQoZW52LCBIRVhfU1JFR19NT0RFQ1RMLCBNT0RFQ1RMX1csIHRocmVhZF93YWl0X21hc2spOwor
ICAgIH0KK30KKwogaW50IGdldF9leGVfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKICAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

