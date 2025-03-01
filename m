Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E089FC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ7-00037p-O0; Sat, 01 Mar 2025 00:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ4-0002pn-D7
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ1-0008UR-Af
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:48 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214BwZ1027245
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jx5E8UXzPamLqtOTkIV7LqZMWqAEg61uw+pj1z6VvYw=; b=Ahy0vGlqbxKt76bG
 me+SmluOK491+NcQdFwmCxHOgi2WSZBoyTpzq9g1iprr7DXMPzhjC5ASMFGg8lqa
 xtAZgRKx/a5XoBN9kVAk0BOHWCFsR9AOOzVxcDuHqQekUPKYWtsxl38Kg3DKaLKB
 qbx4OdAlL3VKLG8ail/COpOKeZp8bP/DlczOpTHpdlyW8i+j9O0wLS5cyte5rHRu
 ksqvyf7TuP1RVZrvLGMJZk+4PbnoV4a7cQZ3D2N74jO1kOA/4wZxSp5WQqIJC5kw
 ajcCczonxWA+PHDMyFO5xgriD/1CdjO97a/o9VQmB9fGZO9RGplZIQAVnJdp3av7
 6MvCPA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d0391-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fe8fdfdd94so5864338a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806973; x=1741411773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jx5E8UXzPamLqtOTkIV7LqZMWqAEg61uw+pj1z6VvYw=;
 b=RZmTMCFx2wPcmwhSKdLnDLert+S1tcHIJ6KFCFyVN+NmjCPF+LrDPkmRe3HJ5M+il5
 D4Bick+yOpBKjc+EPCb86mwDCVCyKaI8GrfrjAIX2FBWjpZ9ezRlbL+7VjX2n/lb+Caa
 QcDA/X2oj41dqHGtFn49FMR9Rt1Weuc9ngFqUuv1ZkcmbaGRkkYKofDbIyB8GjsBeLNY
 t+l5z3frnU/gnBqDoKzCBw/+O/zmQyosuodFvBg+8gAbj9uyaXWrYlxpLsT7w+Lv8Gt7
 XRzk9o02pPr+eclETMfY81Pt+CYda7YP2sYPclco7mgHOxjAt5BMV4tLT1FB74Or+rsZ
 99TA==
X-Gm-Message-State: AOJu0YyBPKcCbOItnuG3jMBkrp1nfakAA4Otj/sUIjZeB+qh8PFcCuj2
 p8tYEYBLEpBXs+ftStITsvQ4hZUWHH5OdgkbVu+aF7YKCOV7YqvaZEfn+2N6xqfvTJFmp0Iit7+
 TvX1h+xfN8i4865dKDjButM5/+CV5KU2amNaHiwPw2KwN9AqZbE7JTxniE8Fx1A==
X-Gm-Gg: ASbGncv/NUoHksjJn6l2VjX7SPl+unvOOaiZ+MUo5sbWB15IACq4jU8cEYT42q460AS
 D3Gz6tFRHit8zISfli2cGkIyUsVPrF1de87WVG7AL/Whx8MI+APEj8OOjudvgH6vpn4ZLY5exfG
 USEyQhNLBGXBuvs5GqavcYbMWcguOotZpsN2+Ga/ae2QB6Br0G74fGZqPXXTw4Pp10jZUml/vJT
 xMlPd33i0XIycLjXKITC9945Art/Or/3SYuXIHTVpUz7+4NPV5zW2WRgak8l39iXymB5LrmLdEg
 aK8mNCfyVWiH7pEVtoFbtAtMnPiL1dwu9WTVkk5yj+9Rj0nIv+fik8RZmLnk5lq+
X-Received: by 2002:a05:6a20:cd91:b0:1ee:c6bf:7c49 with SMTP id
 adf61e73a8af0-1f2f4c9737emr11907714637.6.1740806972808; 
 Fri, 28 Feb 2025 21:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7H4GrfAx78nJG7F5CX/iS9FAye+KF4eMS7gclgBIkB3ukFG4x68E1GJFKxNKYIKi7wPmu9Q==
X-Received: by 2002:a05:6a20:cd91:b0:1ee:c6bf:7c49 with SMTP id
 adf61e73a8af0-1f2f4c9737emr11907675637.6.1740806972414; 
 Fri, 28 Feb 2025 21:29:32 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:32 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 33/39] target/hexagon: initialize sys/guest reg TCGvs
Date: Fri, 28 Feb 2025 21:28:39 -0800
Message-Id: <20250301052845.1012069-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: xeQJpnThblSpZgjFUuaTg16ivtPYyuBP
X-Proofpoint-GUID: xeQJpnThblSpZgjFUuaTg16ivtPYyuBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=834
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBi
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGZmODgxZDEwNjAuLjI0OGVkNjBmMjkg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5jCkBAIC0xMjk1LDYgKzEyOTUsMjYgQEAgdm9pZCBoZXhhZ29uX3RyYW5z
bGF0ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAg
ICAgIGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCisgICAgICAgICAg
ICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBncmVnW2ldKSwKKyAgICAgICAgICAgICAg
ICBoZXhhZ29uX2dyZWduYW1lc1tpXSk7CisgICAgfQorICAgIGhleF9nX3NyZWdfcHRyID0gdGNn
X2dsb2JhbF9tZW1fbmV3X3B0cih0Y2dfZW52LAorICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4
YWdvblN0YXRlLCBnX3NyZWcpLCAiaGV4X2dfc3JlZ19wdHIiKTsKKyAgICBmb3IgKGkgPSAwOyBp
IDwgTlVNX1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQp
IHsKKyAgICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2Vu
diwKKyAgICAgICAgICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHRfc3JlZ1tpXSks
CisgICAgICAgICAgICAgICAgaGV4YWdvbl9zcmVnbmFtZXNbaV0pOworICAgICAgICB9IGVsc2Ug
eworICAgICAgICAgICAgaGV4X2dfc3JlZ1tpXSA9IHRjZ19nbG9iYWxfbWVtX25ldyhoZXhfZ19z
cmVnX3B0ciwKKyAgICAgICAgICAgICAgICBpICogc2l6ZW9mKHRhcmdldF91bG9uZyksCisgICAg
ICAgICAgICAgICAgaGV4YWdvbl9zcmVnbmFtZXNbaV0pOworICAgICAgICB9CisgICAgfQorI2Vu
ZGlmCiAgICAgZm9yIChpID0gMDsgaSA8IFRPVEFMX1BFUl9USFJFQURfUkVHUzsgaSsrKSB7CiAg
ICAgICAgIGhleF9ncHJbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwKICAgICAgICAg
ICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3ByW2ldKSwKLS0gCjIuMzQuMQoK

