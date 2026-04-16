Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B4F8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTsC-00008u-1G; Thu, 16 Apr 2026 17:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs2-0008Up-E6
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs0-000106-8l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GGRqj13197850
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=; b=Kczv6EX8tmVdsp9O
 A+U6LG7DTrZNnf17F9eOHvV++t9YoeuPSC5KvSD6scD0vDFqnTNKg3f1QS9ue6ew
 sgR+bkyiK6GbKslg7aRC+hLozmToV43W0IPVwJ6boTDV+O8AiBdvwOrBaOwAKpu7
 2AO+ANRRTwEiKcEAfeLfJfsldq0iCDfPzmeQ0s2uUaCN82pBewPedygw3Xy/QP5i
 OPlPyg9VqWwGy2sZkEYoi0g92H0DqdFlB2/mekPfg1zOQHRzS7dE9+gBehY+Vx2N
 u/Shw2pXxzyU218hT1d7j5jhK0vyyJoCMHgALgxxlXy1dx68lLprJ0XZE3bUzMga
 VRSMzQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk3af0xag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso11051303eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373406; x=1776978206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=;
 b=Hi4MdxIeVtoiK/x6GgxvAawDQN1Viw/vuQV1P9UlzTSt5eZX85FUPesOSzgJwN9xGk
 mCI3XdaM7NlOnDzd4y06NMgAAAZMMPkarE2+/ZlRQ/eCf3Pb9gy+k4M2MP+oiLeEFLrQ
 JRp4vW8wJ8uECOtkalNplJBUxKVlyMeqeBWokOisY9EcUix/ptvK2A5Ld0X7Jof32WPA
 mPC819pv0kR+RzN9ls6niYdL5Bw8kEud6v9rZio4/MOTvBxDlZw4plNGY+knt4WFDkiw
 3qrtKMWIiyPJG8x2xp6Yauew9FmgeR5RRvcwlkgCZOsnczgExh52uNomywwDYCwjwkjU
 Fyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373406; x=1776978206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=;
 b=lqkxUaS6J5G44RU3ZTUaYOufu/4p2lnrMRhm/vSOFEbNXPLCbNuySlOBgR02Xr1YFs
 6OQNAljXqMWAPbdP4OwdpSz+kr7+ILLfjHHsQ+aOtSSxuBOlnnovnAJwaRU9YV3vthY1
 6nWSEgdfiBTQ7DNKTgxR5lpy2UiHwpqGim101CxfY92h3PvYiGHBOuSndoLqyfp7r75G
 iEdHNLHWF4N3we2BeIzye26joetxc6PuePugItFW7kChQA58LiPHE2cGD7hQmQEoUip9
 2EG4sFrD+8Cel6PpDV7JUL7IXw7PnMw27cGOm4JgxUVODNWHy9Nl2LX2JQnIawQCq0X4
 rWAg==
X-Gm-Message-State: AOJu0YyfJ5w8F3S8buaC/PBMoZrfuWUvZK0uXnM+TBUCoy1RqcqqEeTM
 n+Jm5iMnY1huQ6qWmT4J8GG7h+A4x4hvybYPK2RL80QBP0XXxoIw2kHvo/j/vJ8xtmPdj3/6Xoh
 NiKuZBPZfX2d1SoiIH31d8MvgtZqh24Io4p/GGVo6EmDHmGrpWAuzevJZSURY2GIuog==
X-Gm-Gg: AeBDietUxf/PCYlRlE/ZznB8Rtv2FEzy4Kp00vIh30Q4AuZWX9cQbWMdk/E1Ch8eeg3
 VvGREUb2vVvTtsA0T6o+wfh4t25o1EEWxtAIMmaMqq3DFkTkrrSJqvOAGmex4rNFnOR/x1T/Sun
 URriQWg1SzTiyHLzp0xya/KA6Nt8fnKmCk2G2I4XyU1BtRlJW3KOxtyTtrvbJOG5sy20zWRg82/
 N2TlhkIrsTpc1cCrmse3vJ3kPhLCf2K6UhLQd5KeWBZSIeUSaWXj8LFw3HmnF5oCoQy4uIpdzHU
 Dc3d5G4eZ3RAR/CAFP6/vr/HN7lDS4VlH8rVAazXrwLg1x3VFmXZ7TLnC5A+KJDUX5T0P+9IrCj
 45n42XzXULRcMlCP/Z6CtbraHJS0/AgpTDWigMuQd6ftB0RYGyDW13osPPB/Uov8CxZ34fM6W/L
 oBhz/o
X-Received: by 2002:a05:7301:607:b0:2dd:649d:750c with SMTP id
 5a478bee46e88-2e2e35842femr570004eec.9.1776373405773; 
 Thu, 16 Apr 2026 14:03:25 -0700 (PDT)
X-Received: by 2002:a05:7301:607:b0:2dd:649d:750c with SMTP id
 5a478bee46e88-2e2e35842femr569979eec.9.1776373405117; 
 Thu, 16 Apr 2026 14:03:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 6/9] hw/hexagon: Modify "Standalone" symbols
Date: Thu, 16 Apr 2026 14:03:02 -0700
Message-Id: <20260416210305.2255579-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfX14JnnZ00cZa7
 rBV2qn4VUWTwfjENlS6UsED4ooUCRaiRoWZLdhoDIPNE3b8TzWKXiUnLnGfQoGzCvD1NCnhrEMK
 TGuTz70gdzCa/moAkx5lbZa3aqqaU2QzBpdRed1Wn9jwpUEkb8BZVJ1wz7YIGsePqZ7jBfl+xSn
 XD2pOzCpw6NaGKPLRdekj4P+meyLVoHTy3Y8Z9pr6lKANnAk4KuV2q1xtKIvTmnKv5cBCKl90Dg
 dBpeGvE1L/SeoCJclXyvGWRWltQ8SxN+2b9dMpj0aqZr/XiLiKneyzQd2AEyONsHAGYkVhfnF41
 ptdAYB33HZFW/5roBePHG8G1OtxDvtSunQkC4i9PRJyK/pqaHdL6mcm7NrDRDASSXiPN614jRpw
 K2Y2Pw5uSnRahPhlVH4IDZe7ZsyqCdVrnT4Gls4f8zn/Slq8CFAKXXysKyRS010iBStIvk+t/zU
 u4XWpvkfVHhjP412R4A==
X-Proofpoint-ORIG-GUID: DBCzoehXLhY4RmLH1IhJ_q42wLmLlyTO
X-Proofpoint-GUID: DBCzoehXLhY4RmLH1IhJ_q42wLmLlyTO
X-Authority-Analysis: v=2.4 cv=DfInbPtW c=1 sm=1 tr=0 ts=69e14e9e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QhYL57-57G4zB7GrFpIA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGVzZSBzeW1ib2xzIGFyZSB1
c2VkIGJ5IEhleGFnb24gU3RhbmRhbG9uZSBPUyB0byBpbmRpY2F0ZSB3aGV0aGVyCnRoZSBwcm9n
cmFtIHNob3VsZCBoYWx0IGFuZCB3YWl0IGZvciBpbnRlcnJ1cHRzIGF0IHN0YXJ0dXAuICBGb3Ig
UUVNVSwKd2Ugd2FudCB0aGVzZSBwcm9ncmFtcyB0byBqdXN0IGNvbnRpbnVlIGNydDAgc3RhcnR1
cCB0aHJvdWdoIHRvIHRoZSB1c2VyCnByb2dyYW0ncyBtYWluKCkuCgoKUmV2aWV3ZWQtYnk6IFRh
eWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMgfCAxNiArKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hl
eGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCA2NDljYWZjZjhlYy4uM2MyNjlmZWVkMjggMTAwNjQ0
Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25f
ZHNwLmMKQEAgLTI4LDkgKzI4LDE3IEBACiAKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjZnXzEw
MjQuaC5pbmMiCiAKK3N0YXRpYyBod2FkZHIgaXNkYl9zZWN1cmVfZmxhZzsKK3N0YXRpYyBod2Fk
ZHIgaXNkYl90cnVzdGVkX2ZsYWc7CiBzdGF0aWMgdm9pZCBoZXhfc3ltYm9sX2NhbGxiYWNrKGNv
bnN0IGNoYXIgKnN0X25hbWUsIGludCBzdF9pbmZvLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBzdF92YWx1ZSwgdWludDY0X3Qgc3Rfc2l6ZSkKIHsKKyAgICBpZiAo
IWdfc3RyY21wMCgiaXNkYl9zZWN1cmVfZmxhZyIsIHN0X25hbWUpKSB7CisgICAgICAgIGlzZGJf
c2VjdXJlX2ZsYWcgPSBzdF92YWx1ZTsKKyAgICB9CisgICAgaWYgKCFnX3N0cmNtcDAoImlzZGJf
dHJ1c3RlZF9mbGFnIiwgc3RfbmFtZSkpIHsKKyAgICAgICAgaXNkYl90cnVzdGVkX2ZsYWcgPSBz
dF92YWx1ZTsKKyAgICB9CiB9CiAKIC8qIEJvYXJkIGluaXQuICAqLwpAQCAtNTgsNyArNjYsMTUg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9sb2FkX2tlcm5lbChIZXhhZ29uQ1BVICpjcHUpCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2luaXRfYm9vdHN0cmFwKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgSGV4
YWdvbkNQVSAqY3B1KQogewogICAgIGlmIChtYWNoaW5lLT5rZXJuZWxfZmlsZW5hbWUpIHsKKyAg
ICAgICAgdWludDMyX3QgbWVtID0gMTsKKwogICAgICAgICBoZXhhZ29uX2xvYWRfa2VybmVsKGNw
dSk7CisgICAgICAgIGlmIChpc2RiX3NlY3VyZV9mbGFnKSB7CisgICAgICAgICAgICBjcHVfcGh5
c2ljYWxfbWVtb3J5X3dyaXRlKGlzZGJfc2VjdXJlX2ZsYWcsICZtZW0sIHNpemVvZihtZW0pKTsK
KyAgICAgICAgfQorICAgICAgICBpZiAoaXNkYl90cnVzdGVkX2ZsYWcpIHsKKyAgICAgICAgICAg
IGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUoaXNkYl90cnVzdGVkX2ZsYWcsICZtZW0sIHNpemVv
ZihtZW0pKTsKKyAgICAgICAgfQogICAgIH0KIH0KIAotLSAKMi4zNC4xCgo=

