Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A88C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWh-0003EU-E1; Sat, 01 Mar 2025 12:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWN-00039r-8p
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWL-0008RV-9R
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:02 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 521CrjeF006134
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kHp9khBbeshNp5BMVepL8q02gSgVhlt6BXE4L+biJx0=; b=Qzqe+6LYik+28tZs
 Ff96ep753e4enJCU//RqBVZOkNUUCuAHXiJOKyG4BVRKK+jrTACydZJdabcLB7gi
 KrPyDm92D86Las3WejN0u7Now5RtcZiOAqh+VD7IjYAs9rwcAeweRnUwuigUblI6
 0o5K4ZPvMQTe1eWWlqvz5Bw9Gu7S4fPK959Qi9lVkEMeJ/H7CxQpsS27Ef5AM63p
 nfHLEM/R6uwH0mZjmN4AW/iy04+eS83RWgCxmsMsuMhjLB+Ni16NdjxFm+Gldnvt
 sX11Ptiqj/WtNtGh65e7ZEcZQ10+2e6R7S/YHhWQKMVGBS+hqb7y07gxeWdZZFkb
 qYyS9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas94ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:21:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22331df540aso94167415ad.1
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849659; x=1741454459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHp9khBbeshNp5BMVepL8q02gSgVhlt6BXE4L+biJx0=;
 b=OIWWRHI/Uuz+eSvB0apaAFrYHfL1QQefTL1tUAsm3IwrWCC33J7aNSoDICxjJiJIjO
 BCT4xAyyUPDzmHQAg2oBELk916y0h0SqWJScGEqDBTqTy/AbKOUbSrpnc1AKoytWAGe3
 yflGqVyxgwoQCGuM3fzzywVDPBvZ9PyPbcwKMskTrrrNJLuLUANRzo5upD6MTAY+ICJK
 eJwVJjasXGoOIQZME/zPx9osbnAjV+YMN/E3acmLt9qUcZAi0AavUiYjyrQJRLgg1Pbz
 /z7lckE3r8HzX/U+M7YuSa4dVF9M25ooPM5jQG3hoIzObTh1VaxS/mbrVFBZ+vfo5iCY
 Ok6Q==
X-Gm-Message-State: AOJu0Yw77X3LbjgcMTp2HVn1DpOhG3HgIL+vnlXoehwiFpiJD+sop4B5
 /GpRrnGI33hCFBwZoDrd1SrfcqjVc4i2azONioAavec8ZZP14f06Fd6vwGJSeWX+sTgHN0BfQbJ
 WUO83w77S3FB3PH3mqMkALyLqdk/pw8ZgS4TfLS9HX1DgmUpeu53Kk4G2Rr0cpg==
X-Gm-Gg: ASbGncvyvFOPBJRhEMJXL2v+XgQyJo3No+3EXwVXr8gs0uBqS3e7XPFKpsUM5iMGR4s
 PKvHqX0oL/KCceh3W8AuKNWK7GAShpFm2ZmG8x/+MfwzJMRY1W5y+gtBJk5JjNXRBc3z5dYQrML
 5bdBLB0VQjLNNiuYnCYEiJtTOEPMhHXEaD0HhYiowXmv9iCS2R32vqdn0hYQqeg8O1aW5lE8Evb
 Q+YrqXbViDB9bgG7/kMprmr9egro5u9vnrVC9gWlqnNPo1MLPU2FlD7gAhnNc+51blD4q/R+9FC
 /h9oFUeOVrJZvZr0YMnKa+kypgw3ohPyov+WYnhlRyAFTQVaraC/MIK57lkgwOAG
X-Received: by 2002:a17:902:e84a:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-223690e0257mr124772335ad.24.1740849658852; 
 Sat, 01 Mar 2025 09:20:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxRKyiDwnlQhnfV2rf3VhpQ+VmbTinbAwmLlttU8VqoQ3ubTGgWGWZej3YK2N6C8x2AYLqcg==
X-Received: by 2002:a17:902:e84a:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-223690e0257mr124772025ad.24.1740849658512; 
 Sat, 01 Mar 2025 09:20:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:20:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 5/8] hw/hexagon: Modify "Standalone" symbols
Date: Sat,  1 Mar 2025 09:20:42 -0800
Message-Id: <20250301172045.1295412-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pzecXS6BZ5p8m3g6ykVtqCY1F9XP_mAD
X-Proofpoint-ORIG-GUID: pzecXS6BZ5p8m3g6ykVtqCY1F9XP_mAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=702 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGVzZSBzeW1ib2xzIGFyZSB1
c2VkIGJ5IEhleGFnb24gU3RhbmRhbG9uZSBPUyB0byBpbmRpY2F0ZSB3aGV0aGVyCnRoZSBwcm9n
cmFtIHNob3VsZCBoYWx0IGFuZCB3YWl0IGZvciBpbnRlcnJ1cHRzIGF0IHN0YXJ0dXAuICBGb3Ig
UUVNVSwKd2Ugd2FudCB0aGVzZSBwcm9ncmFtcyB0byBqdXN0IGNvbnRpbnVlIGNydDAgc3RhcnR1
cCB0aHJvdWdoIHRvIHRoZSB1c2VyCnByb2dyYW0ncyBtYWluKCkuCgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaHcvaGV4YWdvbi9o
ZXhhZ29uX2RzcC5jIHwgMTUgKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hl
eGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCBjNDk2MmE5OGJjLi4zNGJiZTk4MTQ5IDEwMDY0NAot
LS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jCkBAIC0yOCw5ICsyOCwxNyBAQAogCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY2Z18xMDI0
LmguaW5jIgogCitzdGF0aWMgaHdhZGRyIGlzZGJfc2VjdXJlX2ZsYWc7CitzdGF0aWMgaHdhZGRy
IGlzZGJfdHJ1c3RlZF9mbGFnOwogc3RhdGljIHZvaWQgaGV4X3N5bWJvbF9jYWxsYmFjayhjb25z
dCBjaGFyICpzdF9uYW1lLCBpbnQgc3RfaW5mbywKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3Qgc3RfdmFsdWUsIHVpbnQ2NF90IHN0X3NpemUpCiB7CisgICAgaWYgKCFn
X3N0cmNtcDAoImlzZGJfc2VjdXJlX2ZsYWciLCBzdF9uYW1lKSkgeworICAgICAgICBpc2RiX3Nl
Y3VyZV9mbGFnID0gc3RfdmFsdWU7CisgICAgfQorICAgIGlmICghZ19zdHJjbXAwKCJpc2RiX3Ry
dXN0ZWRfZmxhZyIsIHN0X25hbWUpKSB7CisgICAgICAgIGlzZGJfdHJ1c3RlZF9mbGFnID0gc3Rf
dmFsdWU7CisgICAgfQogfQogCiAvKiBCb2FyZCBpbml0LiAgKi8KQEAgLTU5LDYgKzY3LDEzIEBA
IHN0YXRpYyB2b2lkIGhleGFnb25faW5pdF9ib290c3RyYXAoTWFjaGluZVN0YXRlICptYWNoaW5l
LCBIZXhhZ29uQ1BVICpjcHUpCiB7CiAgICAgaWYgKG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSkg
ewogICAgICAgICBoZXhhZ29uX2xvYWRfa2VybmVsKGNwdSk7CisgICAgICAgIHVpbnQzMl90IG1l
bSA9IDE7CisgICAgICAgIGlmIChpc2RiX3NlY3VyZV9mbGFnKSB7CisgICAgICAgICAgICBjcHVf
cGh5c2ljYWxfbWVtb3J5X3dyaXRlKGlzZGJfc2VjdXJlX2ZsYWcsICZtZW0sIHNpemVvZihtZW0p
KTsKKyAgICAgICAgfQorICAgICAgICBpZiAoaXNkYl90cnVzdGVkX2ZsYWcpIHsKKyAgICAgICAg
ICAgIGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUoaXNkYl90cnVzdGVkX2ZsYWcsICZtZW0sIHNp
emVvZihtZW0pKTsKKyAgICAgICAgfQogICAgIH0KIH0KIAotLSAKMi4zNC4xCgo=

