Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EB4C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNg-0002vb-Ap; Sat, 01 Mar 2025 00:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNe-0002vL-L0
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNd-000884-6E
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:18 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Pbhh006167
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kAzZu6vQE1Q5r3QTU58nt0GePP1vTC7caLPwgCSQDM4=; b=b+cOd1iGQdZCtMmg
 2J9q/IukKJKchcLss/D1Wymb04mzbkvT+qE/Y9ZEyQ2EzofGkuF4gVc9dNQcwjwr
 fDd8FBNr/1h1LCXC9LQXhXpZLFIdUn8+ltKTaeF+pHiNYm2goLuZzo9B0v8bj/Gb
 4Mti6InRB3PuhZ6fR29R87hYba3+atnOnUtCtOsvXpRCt6smSjo+dC91jLZpdcE5
 U5LpJE5enhRyqPn/Q8T3nycKZ1FwJinh03u1ex9WT70N8ceyNWX9XPyc5lo5RhJQ
 alSNANOoIVPlHwrJLDg69AV2xDDyOcDIbpgIdeL0vQP5fhLN0DKc6AD35pwW2oY9
 DFFv+Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas85p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fec3e38b60so2176622a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806825; x=1741411625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAzZu6vQE1Q5r3QTU58nt0GePP1vTC7caLPwgCSQDM4=;
 b=v6CxrCAOl8eyu7qb5+1K+DNxT3+XnkJxbhhWh0zVqlbY110nNHWsmfEKcFeaVE/smc
 VdJGe7xBKoKdvR08lcU6vRt+sKxbpVJPBcMzYkns0KBJtbrYKuQJ8tHy4rZdAnlM91ZZ
 19CU4ZHpjWtVJLSlQN3xXuALkGctG1SQHmoSxFotCcC5OHQx7QhHIX/+6S+Q85/svohv
 9JfVrHgC0A0UvqSQlvfObnMkGTy2irDljm3xB/NXHzESxYfEn1bN1WxLdo2OzIOWRfb/
 1P34RrcDHeazAcgkyTH8VO4u5peukN+x+p9SEbYx1yuQ0/KR2klUiIIKYCAdlJTiMTWD
 sq8w==
X-Gm-Message-State: AOJu0YwDcRMxkEsYbnKKyU/6v7S/BjMvbvClMj+uql7R7ntwa6/tYU2z
 1Z8nnDe/CGGiecltvK9hRbg7u6n802jmE8Nk6aR7znL2MTZXN50gkZL6EcQ0/UKzHk96x9yQz9m
 eMFX+VLGuapLROzPLKXCN0xxUXLInGz1DS08Ico+KEudOOEMGFZSreYUxFVQ1Ow==
X-Gm-Gg: ASbGnctc+wbBg3x4n6JL1Nh8nFkNUGbvbxv+KIMUgg0hpgLuTlHJlrUApypfT81fbCp
 LlLyVrY1svFEyGq4l3L5Jl1/LvR4BhT0FiYeZepoxtwHUsWYL9oxFgA4BlLzyWGe7RjR6hmaQh4
 gIgKi2I0wR8LA59t0oZVgj6yX5fqeqicqGzdRmqzgoECne4PdpUW3xoB5OLwT3+0LajZmkO89Wy
 A8C//gegvaUTT4MeYKgYow6nb3YTK2X4YftiwWDoG95FBUTwQXzBXZ1ONor40Is7VyAr2cSjOSi
 R2zzIHn5scqzmEJPHWJEHSv5XzjXl+lP7ksbBd26sF8h6SNWkFXkSCW2/n/VLQFx
X-Received: by 2002:a17:90b:4c11:b0:2fe:baa3:b8b9 with SMTP id
 98e67ed59e1d1-2febab2bdd6mr9762984a91.4.1740806824837; 
 Fri, 28 Feb 2025 21:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY1h84bMJCCiwViXJTV6rLDbofDSUHPCXmk8fAiEp6eyVtEQIPcQ+VBBoYkp5Z0EZ5OWOwKA==
X-Received: by 2002:a17:90b:4c11:b0:2fe:baa3:b8b9 with SMTP id
 98e67ed59e1d1-2febab2bdd6mr9762952a91.4.1740806824475; 
 Fri, 28 Feb 2025 21:27:04 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:04 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 13/38] target/hexagon: Define DCache states
Date: Fri, 28 Feb 2025 21:26:03 -0800
Message-Id: <20250301052628.1011210-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2y79oi-OI4RUfRLalg1hCKG6sKNpSs0O
X-Proofpoint-ORIG-GUID: 2y79oi-OI4RUfRLalg1hCKG6sKNpSs0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=787 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1X2JpdHMuaCB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4YWdvbi9j
cHVfYml0cy5oCmluZGV4IDY1ODJiYjRmMTYuLjVkMjY4MTVlYjkgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdV9iaXRzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaApAQCAt
NDEsNiArNDEsMTMgQEAgZW51bSBoZXhfY2F1c2UgewogICAgIEhFWF9DQVVTRV9QUklWX1VTRVJf
Tk9fU0lOU04gPSAweDAxYiwKIH07CiAKK2VudW0gZGF0YV9jYWNoZV9zdGF0ZSB7CisgICAgSEVY
X0RDX1NUQVRFX0lOVkFMSUQgICA9IDB4MCwKKyAgICBIRVhfRENfU1RBVEVfVkFMSUQgICAgID0g
MHgxLAorICAgIEhFWF9EQ19TVEFURV9SRVNFUlZFRCAgPSAweDIsCisgICAgSEVYX0RDX1NUQVRF
X1VOVVNFRF9XVCA9IDB4MywKK307CisKICNkZWZpbmUgUEFDS0VUX1dPUkRTX01BWCAgICAgICAg
IDQKIAogc3RhdGljIGlubGluZSB1aW50MzJfdCBwYXJzZV9iaXRzKHVpbnQzMl90IGVuY29kaW5n
KQotLSAKMi4zNC4xCgo=

