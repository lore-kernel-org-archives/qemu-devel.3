Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF82C282D2
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFON-0004Xc-PD; Sat, 01 Mar 2025 00:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOF-0003zV-Lb
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOC-0008Ba-Ro
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213JRp9016337
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QTQb6Th40otpqKkURmUBguywDlgccM1vHXcnXME2QwM=; b=jK8FCmhWxQp/6KQj
 PSooRPXdZFO/LOOwdsQ5fmijGNDVZ3KlZwHSUTQpE/mUc/CbCDx9tED7jnx7w8hD
 G8Vpob5v6a9DRam7gnNqe3pxO7tvRTUJ0JYAphm92VBlEutiE6T3eZusG7uDDO4I
 Kf+DZlJbqliI8VNT1dGs9Th10vZs6+ioQfFLlhBByBAKDeWjJVlD6fTX+uEOyCOk
 zfJ4t+TMmZ3ayTFjG5OU086pjMmsNOlRK/VP8iTGbR6V2iW7SDYhg28wcK2O9JgM
 jIY/l97feyAZ7dvqqcAwXkD+KFPU3J13liMem5kj/hEXz6v8G4ZbsS6aTjHAwCt1
 hEALFg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr67v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fe8c5dbdb0so5815424a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806850; x=1741411650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTQb6Th40otpqKkURmUBguywDlgccM1vHXcnXME2QwM=;
 b=GQBOK5gDO2NScnJHP3vr5XF0R2TNgX0Jg/BrGpdT2nud2kaMuTiTm9+9ibXPs6AsJy
 UiMWaO9nUbC1H3hqmSw7gFzpGVR4yCtsePihdOKysLg1QDKkOcqoDoll27PAtEl4Wc+t
 Z2SoGy8KBFpbsLykfisC/euk5+L/THK5F8zDti+HuxRiL+4Nq8t53oLm1DNF9XPobI0M
 K8061hjX+A7IzLenpOlPUW7vZJ8djCqT49+CJSMnbnabvQA+MYJ93BVBdSyBBeaGOt/M
 laqIdQ52YLtiyDHOisi6/2BZU40rosjsdKC1glde+NHy7TES3JzthiiMKSrxaeRqo+lG
 qg4A==
X-Gm-Message-State: AOJu0Yz5tWNycbKUabNyFbEBIcUI5eRJ/ERIAxZdm1fPhkqmvLmYVSjj
 JE6nAmNgFrX4X8Mc//MoNFGuUk/I0v4GtaikYHMCzoBE/ifmT9GeNpCdRdfK4KOMLdLE9JZTVIM
 9Ce4BGgLh17HTJN1Hr8ATmUNgm/54XqZwcR32MyGbHGBdRqFUJch08HBZzYVaKQ==
X-Gm-Gg: ASbGncsal4TjwAo1mIaLgm90gL16Q5Vk3sjbH6gcjgb841oN85D9CX0zHhCknlKJueA
 HlaFJiUsoKsUBpdHDXvdIYtUy0yGiWThZxgElZPH6ml3uuloPWoESA4M0Y6gjRy8mctO5ODIJx5
 J5OhsyJHZcNKX/tM1UX5afi0U9+0/krHLGVAN7g7DV8rjdTlWajARt9gnToswqLis4v/dfgq/kU
 YEv+ispp5YXLWduOYMvMoLo4Z37P8y32eNC7KrnZONxjCHSNqaxYAWWY45EGBQHsS7wLzJU3/o3
 Z/tgA4UnJPdnZaKaQ4KlR+z6Hh7SHNDuGpaQDNWoV+sri6Mw+z2cqLvdyqir2TkV
X-Received: by 2002:a17:90b:3ecd:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2febab2eec2mr8950712a91.6.1740806850178; 
 Fri, 28 Feb 2025 21:27:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQHF/+Fn8VXTVBho7TenhhRigT/lMsmKysvLuPCqK0OgEq8UK3tGwpID+BKRguF8FLeT52KQ==
X-Received: by 2002:a17:90b:3ecd:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2febab2eec2mr8950689a91.6.1740806849761; 
 Fri, 28 Feb 2025 21:27:29 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:29 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 32/38] target/hexagon: Add stubs for modify_ssr/get_exe_mode
Date: Fri, 28 Feb 2025 21:26:22 -0800
Message-Id: <20250301052628.1011210-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: zpw2rvCxOKHq5dmFf_fuEc4nFsNuIfcj
X-Proofpoint-ORIG-GUID: zpw2rvCxOKHq5dmFf_fuEc4nFsNuIfcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=584 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
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
Y3B1X2hlbHBlci5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgOCArKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCmlu
ZGV4IDVmNWYxNTE0OWEuLmUwYzBjMDM3YTYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKQEAgLTE0LDYgKzE0
LDggQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFn
b25TdGF0ZSAqZW52KTsKIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudChDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDY0X3QpOwogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2Nv
dW50X2xvdyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QpOwogdm9pZCBoZXhhZ29uX3Nl
dF9zeXNfcGN5Y2xlX2NvdW50X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90KTsK
K3ZvaWQgaGV4YWdvbl9tb2RpZnlfc3NyKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBu
ZXcsIHVpbnQzMl90IG9sZCk7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52
KTsKIAogc3RhdGljIGlubGluZSB2b2lkIGFyY2hfc2V0X3RocmVhZF9yZWcoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IHJlZywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHZhbCkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCAwMDYyMjUzMTc2Li45ZjRm
YzcxNmUzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBAIC02OSw1ICs2OSwxMyBAQCB2b2lkIGhleGFnb25f
c2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IGN5Y2xl
cykKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCit2b2lkIGhleGFnb25fbW9kaWZ5
X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7
CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KIAoraW50IGdldF9leGVfbW9kZShDUFVI
ZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQogI2Vu
ZGlmCi0tIAoyLjM0LjEKCg==

