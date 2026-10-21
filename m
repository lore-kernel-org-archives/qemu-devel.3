Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ccS5yh9P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TP0X/5l6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKPJ-0002GT-6B; Tue, 20 Oct 2026 20:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPF-0002Fl-UX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPD-00071C-C6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KM3o213376380
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=; b=ccS5yh9P31dR8kSg
 QcPcU9FlPKbC5fhbECMCs8pgfVySnbkpnHYeJHhoWKF4MOKfequz+8J3oiBq0KGw
 SCsO2AysO06k53pQfssPxjOq1Yj5Br+y1jRIHPPJbNTz/CREoiWR2Ti5xhRmerzL
 kRSbRyxhmw7sIsUO6avjASkMtJd6wQgKPvn0b7vk4rAcpuCWoLbIqo4NlyFufuob
 xO9WLQeIvJVxdBCYxePUyJGrBm7MMMTTuWT+Ai7yHkTd6ESedSME/eeW0vI8tgUE
 HpAXMgxZgPSd10vRyyBXycDfjdlu/bzfhPwALjYkX1ZqidjIcle6Qts6Wdpzh8Jg
 p4gn4Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs00d4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so750135eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543329; x=1793148129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=TP0X/5l65nAvBM12ZxQEewKCJaTlIYcb0ByCRU54pOZ208im/z+yqa6PnT/KoOE0xL
 BsqvAXFXPeYGh3leQkCwU2EKnXI1+UsiqcKzzUwCLRxRJiVoFmQSJD+frbtAsNW/FGMs
 gniNFKl06Teo/kKnd5i6lF9ZS7XpXu/cxh/HMAQ/UzmbRAtKAZN0wO215dJnoyQBVTZb
 VZ6h2/W1QLzhEM7p6F4RBi+rIrynpc3cyzYq+6HVLY+UgoRdXziHwNyAubDOVi3L6Wjc
 AGEnzzVPcsOGLD+qcU7068nQofhWZ5OcNAbS+FsmYBtd2nT8jo6ljvC2ZGwmaCJk/b/s
 pkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543329; x=1793148129;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=toJHHc36XxLMEvInSUAE6BnKTh2LDuk9usIJarpyeY49EgyQcwmUuAYzxErMtY2g3j
 BGSf1NZZW1tuAdLqldBJY43ECxYyFxnXVWWjnJwRpTOiyYdeIIryCZ+2aoz8YkODNCKq
 10vSfAgzSTYgcdiGIj0Jb0Xb3aLt+hZExrwTqNOffZ8KIuCmNBz3VagF5/3g+4JeGUrQ
 EWkblyJRga0aDqi8HPm3H7WIsLlLmhannhbt7vz3/fQE8CQ++QL5ItFyw1esienlHlHH
 o8w+frsR00RmlNJdXWOMBRQPl6NlzNwBUpIKm8DGYTdR7RiIGo77ydy0V3jEYiNiofnX
 V6fw==
X-Gm-Message-State: AFq9FYJ24qNt4XB/D0KHYAO0e0UEECNgzCGD0luKf+lDCKDnT7hA6UD0
 xvneDFsLw7IN9QeoFYGR4ROLw1dUjbqsHX18lOl7q2DMMk1n18Gjec88l4y6fMVFH199Xt1aCQh
 Q6aOmjFjwkAUomdoufN0w4G4Oj57K/Goip52g8Gr3JCHXPNktRJqt4zh5L3eVdignRw==
X-Gm-Gg: AYBFou103JzjQW8ElNpuBa2nNF0ZIhFtqgrrbWt5hwWkA22ArG/Cw9L/gInoDmfjrDe
 hq4AQ0spGNtPxXO7hzHColTLI2r0g0L5GG9MkPu9mnNw8OyiZVYm0VVxREEgFmb8FAjOOXeXKDD
 el4MfhYeDc8XfqAd+xP6cHaaWwJ7FfuoanXUDHWua6MkGipaCzwQy2tAQPpPLjqFF0MlyOXcRRY
 Ch11jZELmB3BpHygQHEd+mCpH9xVxMpdi8L0RF31nK/f1CoUj/ZZAMG0xnJRp39CgGZICtVJBPT
 SlBiu0QkZBpyqEl2yfVuvYy7duP8CQK4qKEoeiI7NBiCBVekywfe5BAmwYGtyD9YkqZIhiqZzG1
 tQJDllV2enoOgUT1bkUXyrVVFLJT54ykS0EtZVuZJqGcmp+Q=
X-Received: by 2002:a05:7022:1709:b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-190a051ddf3mr524736c88.3.1792543329279; 
 Tue, 20 Oct 2026 17:42:09 -0700 (PDT)
X-Received: by 2002:a05:7022:1709:b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-190a051ddf3mr524707c88.3.1792543328705; 
 Tue, 20 Oct 2026 17:42:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:42:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 12/15] hw/hexagon: add v79NA1 machine
Date: Tue, 20 Oct 2026 17:41:42 -0700
Message-Id: <20261021004145.1693260-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad80a62 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX/gMz63gW5hKd
 rvLmyj5s0xJR0YtiCPMhkrtSk3+XY57u0+n+tFhDRqPO+l0zWPIPydEijqEVQHrqn2cZp6V1BV/
 deF3i2/fc5/A2mMZyTQ2BBnYv9sH48w7JaLfYCQp64nHZMk3iI7ZNd6gSWSAWiYINhoEoXkF7eT
 7l5DsuSCSEmTQs8KHGOsE37hhIShK3dzuEwUDjlAR62UW2/zp0jD8sNocXGN3OkwE9DhNLGmsRd
 FMCpATLzh36zMMHjIFoSU7dve4/Nj5GRtfyNLbJnWQiFIYMuLvWEoDXP/Js8hKsOQkugCzQutBJ
 yC5y+M3QkLzhMb47sIrVpY5Dn1jbLaQhN0P42wQIwxFC3t1SykYCOtn0XTD9g7w7bvJi06Dofls
 JvQVm5BuBtlEfZcExgKAQH8+2a1LEXO2aUSZpBIozJ8+1cwG/jypyT8/d8e4EWL8q5dJb3ksqQj
 yVH3Aa4YBhetbDYWQEg==
X-Proofpoint-ORIG-GUID: GSOUepal6OkdbTfQRs6rUOIrL7IJCTix
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXyjp4MCKGuXdX
 zsxYckr30Y4Un19G9Nn3WFL2VleIn3+0bdo2AvFfGCSZJdIeuPtBZCFH2y8BOE1lTRqrCgydOTZ
 FjkAN9QpkxBizh1K3mGbHhMcbhvRnCo=
X-Proofpoint-GUID: GSOUepal6OkdbTfQRs6rUOIrL7IJCTix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001
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

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9oZXhhZ29uL21h
Y2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5o
CmluZGV4IDI2YjBhMWIzNzU3Li43ZDE1YTllMWViMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC0y
OCw2ICsyOCw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjcxX3JldiA9IDB4OGM3MSwKICAgICB2
NzNfcmV2ID0gMHg4YzczLAogICAgIHY3M21fcmV2ID0gMHhjYzczLAorICAgIHY3OV9yZXYgPSAw
eDhjNzksCiAgICAgdjgxX3JldiA9IDB4ODc4MSwKICAgICB2ODFfc2M4NDgweHBfcmV2ID0gMHg4
MDgxLAogICAgIHY4MWRnYl8xX3JldiA9IDB4Y2M4MSwKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24v
bWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFf
MS5oLmluYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzBhN2FlNThi
YzUKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5p
bmMKQEAgLTAsMCArMSwzNCBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmln
IHY3OW5hXzEgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgICAweGQ4MTgwMDAwLAorICAg
IC5sMnRjbV9zaXplID0gICAgICAgICAgMHgwMDAwMDAwMCwKKyAgICAubDJ2aWNfYmFzZSA9ICAg
ICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgICAweDAwMDAxMDAw
LAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAgICAgMHhmYzkwMDAwMCwKKyAgICAucXRtcl9yZWdp
b24gPSAgICAgICAgIDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0
Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTksIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAg
ICAgICAgLmwxczBfYmFzZSA9IDB4MDAwMGQ5MDAsIC5heGkyX2xvd2FkZHIgPSAweDAwMDAzMDAw
LAorICAgICAgICAuZmFzdGwydmljX2Jhc2UgPSAweDAwMDBkODFlLCAuanRsYl9zaXplX2VudHJp
ZXMgPSAweDAwMDAwMDgwLAorICAgICAgICAuY29wcm9jX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
ZXh0X2NvbnRleHRzID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLnZ0Y21fYmFzZSA9IDB4MDAwMGQ5
MDAsIC52dGNtX3NpemVfa2IgPSAweDAwMDAyMDAwLAorICAgICAgICAubDJ0YWdfc2l6ZSA9IDB4
MDAwMDA0MDAsIC5sMmVjb21lbV9zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLnRocmVhZF9l
bmFibGVfbWFzayA9IDB4MDAwMDAwZmYsIC5sMmxpbmVfc2l6ZSA9IDB4MDAwMDAwODAsCisgICAg
ICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDYs
CisgICAgICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LCAuY29wcm9jMl9yZWcw
ID0gMHgwMDAwMDA0MCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMSA9IDB4MDAwMDAwMjAsIC52Mnhf
bW9kZSA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5jb3Byb2MyX3JlZzIgPSAweDAwMDAwMDEwLCAu
Y29wcm9jMl9yZWczID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnNCA9IDB4MDAw
MDAwMjAsIC5jb3Byb2MyX3JlZzUgPSAweDAwMDAwMDA4LAorICAgICAgICAuY29wcm9jMl9yZWc2
ID0gMHgwMDAwMDAxNiwgLmNvcHJvYzJfcmVnNyA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5hY2Rf
cHJlc2V0ID0gMHgwMDAwMDAwMSwgLm1uZF9wcmVzZXQgPSAweDAwMDAwMDAxLAorICAgICAgICAu
bDFkX3NpemVfa2IgPSAweDAwMDAwMDIwLCAubDFpX3NpemVfa2IgPSAweDAwMDAwMDIwLAorICAg
ICAgICAubDFkX3dyaXRlX3BvbGljeSA9IDB4MDAwMDAwMDIsIC52dGNtX2Jhbmtfd2lkdGggPSAw
eDAwMDAwMDgwLAorICAgICAgICAucmVzZXJ2ZWQ0ID0gMHgwMDAwMDAwMSwgLmNvcHJvYzJfY3Z0
X21weV9zaXplID0gMHgwMDAwMDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4
MDAwMDAwZTAsIC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19s
b3dhZGRyID0gMHgwMDAwNDAwMCwgLmNvcHJvYzJfaW50OF9zdWJjb2x1bW5zID0gMHgwMDAwMDAw
MiwKKyAgICAgICAgLmNvcmVjZmdfcHJlc2VudCA9IDB4MDAwMDAwMGQsIC5jb3Byb2MyX2ZwMTZf
YWNjX2V4cCA9IDB4MDAwMDAwMDcsCisgICAgICAgIC5BWElNMl9zZWNvbmRhcnlfYmFzZSA9IDB4
MDAwMDQwMDAsIC5BWElNX2RhdGFfd2lkdGggPSAweDAwMDAwMTAwLAorICAgIH0sCit9OwpkaWZm
IC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jCmluZGV4IDg4MjRmZTEwYTU5Li45ZjZmMzRlZjliZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdv
bi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtMzAsNiAr
MzAsNyBAQAogCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jIgogI2luY2x1
ZGUgIm1hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYyIKKyNpbmNsdWRlICJtYWNoaW5lX2NmZ192
NzluYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MWRnYl8xLmguaW5jIgogI2lu
Y2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MXFhXzEuaC5pbmMiCiAKQEAgLTIwNSw2ICsyMDYsMjIgQEAg
c3RhdGljIHZvaWQgdjgxZGdiXzFfY29uZmlnX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQog
ICAgIGhleGFnb25fY29tbW9uX2luaXQobWFjaGluZSwgdjgxZGdiXzFfcmV2LCAmdjgxZGdiXzEp
OwogfQogCitzdGF0aWMgdm9pZCB2NzluYV8xX2NvbmZpZ19pbml0KE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSkKK3sKKyAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hpbmUsIHY3OV9yZXYsICZ2Nzlu
YV8xKTsKK30KKworc3RhdGljIHZvaWQgdjc5bmFfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29u
c3Qgdm9pZCAqZGF0YSkKK3sKKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhv
Yyk7CisKKyAgICBtYy0+ZGVzYyA9ICJIZXhhZ29uIFY3OU5BXzEiOworICAgIG1jLT5pbml0ID0g
djc5bmFfMV9jb25maWdfaW5pdDsKKyAgICBpbml0X21jKG1jKTsKKyAgICBtYy0+ZGVmYXVsdF9j
cHVfdHlwZSA9IFRZUEVfSEVYQUdPTl9DUFVfVjc5OworICAgIG1jLT5kZWZhdWx0X2NwdXMgPSA4
OworfQorCiBzdGF0aWMgdm9pZCB2ODFkZ2JfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qg
dm9pZCAqZGF0YSkKIHsKICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7
CkBAIC0yNTgsNiArMjc1LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX21hY2hp
bmVfdHlwZXNbXSA9IHsKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1BfTUFDSElO
RSwKICAgICAgICAgLmNsYXNzX2luaXQgPSB2NjhuXzEwMjRfaW5pdCwKICAgICB9LAorICAgIHsK
KyAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZUEVfTkFNRSgiVjc5TkFfMSIpLAorICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAorICAgICAgICAuY2xhc3NfaW5pdCA9
IHY3OW5hXzFfaW5pdCwKKyAgICB9LAogICAgIHsKICAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZ
UEVfTkFNRSgiVjgxREdCXzEiKSwKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1Bf
TUFDSElORSwKLS0gCjIuMzQuMQoK

