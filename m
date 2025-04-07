Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E579FC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1s8h-0001qX-2j; Mon, 07 Apr 2025 15:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7v-0001hB-Hg
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7u-0002kg-03
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537Iev58002203
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0JNy0H8rZ3mqJbvaSLWvLnEsqqiwOr/aprP21Ezpjjs=; b=XE/B4tm5cy/35HBX
 CoEuSEw10M6oepe21VccPYl43UJAMxJ1O0kwqkgBqfzRsOW+IF//cJcCyPOhTNBY
 iu1UZqx+gbdKiwIWcVMBQgrmLTz0SXtU7cvDHIkHTqkmS8yh3uawQSs17VR0ppoV
 CmqHAfwJUewU/UAYJVU25VCPkWPxcDaN2KDqU0Gh81gtykeYI/slSNLe+Q7CI6xJ
 SUKub3CKdraYxoU1kgTumoPirxeSl/o0otpPDVa77696stdGY0jh9i/+Y96npCKh
 IRIJ1iwLpd4vqBfsC/emqEPInfrV6jvi2yuHWn8zsWv6NtnpqtZQ+k8WL5lhhal+
 GNx+aw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtawbra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:27:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-736cb72efd5so4134362b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054039; x=1744658839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JNy0H8rZ3mqJbvaSLWvLnEsqqiwOr/aprP21Ezpjjs=;
 b=JN0aTkdpSWr0WvsAtDalGtGkhub54fNaVSb5vkVuezuWtKqZQrLtZjdEV1kifdLk01
 qejk1fICY+iwbpH7o9Z7K7wc/g2D9T0cxSNqdJ7+cGYj+JLlUVkdq6imCLhTMMkuwAY7
 h5W3x96cHnu/aH77+FrnPBH1imxSjs6uINdEyfCD5OfeCM573rbTOf3NK+wHMLLmX6pJ
 JKmE3o0986//b4mi/6/VUt7gN+Q0YdSRKLxOYGoAqBKm9AGbAgUEKWPZGI9fmmE/Zetd
 s92aMxZCWR//AdyTkhwIma/CjV6A2PcLfdCVBVFLpAt+zOgg3mh+6UXUyYiA8R13q5JI
 y8wA==
X-Gm-Message-State: AOJu0YztUNBGhH800yc/fiVHonPVYEB2bsC5vUQ6lSIj+9dVEUUqPnUt
 WFG5lSk625gQPqPqQwgoTtw6mnYKN5m9MqKswIvRgPFg94I2UUcYLyxsqdQaJAMoiEV0ZAa23mI
 ntx3SUOf1BrErFa2wrtGXWxm5bs7lziJILo68MI3bfMcYj/Mr+3e9aNBtACDviQ==
X-Gm-Gg: ASbGncuAuri52VPjfMFlKcIfuIcPDed8oiORrAjKl0xCdQLPSP37PqTaEdab62c9t3j
 wub3mKpXZQNn3DTbwshnqn82X691LRyywfV8lsKITJ/hhn0/5yrhWSqfte+TEr6R+Df93tmGZay
 zvSD7aza/uY2LaXMJR3EUQ9u0TmsN17MWpFRDDyftt6b06rmEBOgpGkV5Vj4r06HCmxuq9vvlQO
 9DeY1JtiO7jYWSidD10P3IPCNrMi7fUqExujKlx41AVnzJQtvh+mCE8x7X6cY+rpcF5Da1OAnoY
 2wUed310cwzmSmnvhlS70uYPyr4lyW80abcNoNmCHm5NipHDHlaG0HGqjXdxt6kr
X-Received: by 2002:a05:6a00:244b:b0:736:450c:fa56 with SMTP id
 d2e1a72fcca58-739e6fa9cfamr14551789b3a.5.1744054039358; 
 Mon, 07 Apr 2025 12:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKt0SgA+ox6gfndudPGmsMONQJztQ01Z57Zr14sCFVS7+ZRu8K0WJldGkf8Iejw+VUaeI3pA==
X-Received: by 2002:a05:6a00:244b:b0:736:450c:fa56 with SMTP id
 d2e1a72fcca58-739e6fa9cfamr14551768b3a.5.1744054038989; 
 Mon, 07 Apr 2025 12:27:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee619sm9206559b3a.52.2025.04.07.12.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:27:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
Date: Mon,  7 Apr 2025 12:27:05 -0700
Message-Id: <20250407192705.2605614-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6WOOfMzrVNzNTsg0WRzLyjFzTvi83AeG
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f42718 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=WeWQB0ruK5ITHrmzxTQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 6WOOfMzrVNzNTsg0WRzLyjFzTvi83AeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=706 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

V2Ugc2hvdWxkIHJhaXNlIGFuIGV4Y2VwdGlvbiBpbiB0aGUgZXZlbnQgdGhhdCB3ZSBlbmNvdW50
ZXIgYSBwYWNrZXQKdGhhdCBjYW4ndCBiZSBjb3JyZWN0bHkgZGVjb2RlZCwgbm90IGZhdWx0LgoK
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IGI1ZWNlNjA0NTAuLjFk
YjdmMTk1MGYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2RlY29kZS5jCkBAIC00ODksNyArNDg5LDYgQEAgZGVjb2RlX2luc25zKERpc2Fz
Q29udGV4dCAqY3R4LCBJbnNuICppbnNuLCB1aW50MzJfdCBlbmNvZGluZykKICAgICAgICAgICAg
IGluc24tPmljbGFzcyA9IGljbGFzc19iaXRzKGVuY29kaW5nKTsKICAgICAgICAgICAgIHJldHVy
biAxOwogICAgICAgICB9Ci0gICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CiAgICAgfSBl
bHNlIHsKICAgICAgICAgdWludDMyX3QgaWNsYXNzID0gZ2V0X2R1cGxleF9pY2xhc3MoZW5jb2Rp
bmcpOwogICAgICAgICB1bnNpZ25lZCBpbnQgc2xvdDBfc3ViaW5zbiA9IGdldF9zbG90MF9zdWJp
bnNuKGVuY29kaW5nKTsKQEAgLTUxMiw2ICs1MTEsMTEgQEAgZGVjb2RlX2luc25zKERpc2FzQ29u
dGV4dCAqY3R4LCBJbnNuICppbnNuLCB1aW50MzJfdCBlbmNvZGluZykKICAgICAgICAgfQogICAg
ICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogICAgIH0KKyAgICAvKgorICAgICAqIGludmFs
aWQvdW5yZWNvZ25pemVkIG9wY29kZTsgcmV0dXJuIDEgYW5kIGxldCBnZW5faW5zbigpIHJhaXNl
IGFuCisgICAgICogZXhjZXB0aW9uIHdoZW4gaXQgc2VlcyB0aGlzIGVtcHR5IGluc24uCisgICAg
ICovCisgICAgcmV0dXJuIDE7CiB9CiAKIHN0YXRpYyB2b2lkIGRlY29kZV9hZGRfZW5kbG9vcF9p
bnNuKEluc24gKmluc24sIGludCBsb29wbnVtKQotLSAKMi4zNC4xCgo=

