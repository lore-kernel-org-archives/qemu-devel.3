Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD1C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwpPx-0007xh-J4; Wed, 19 Aug 2026 19:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwpPp-0007x1-LN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 19:09:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwpPo-0000V2-20
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 19:09:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL8M2m1354285
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1Ah1ijjnrgcaH/FZgiVM1u
 ioWyY+u4JyQjm/Ts95iew=; b=SkcmzSZu1+9zOf8/jXVXqUsEKBGhXLEoTS6gHz
 Cv0b/Z9N6WOmn7/0SA7jjD8N0fBscLbJzQ3tiI4LCGC/xG3iEOrPfYig01QQzPz8
 RQwfZ/6qf/ujRXk7xYPi2ErusYCzFUXDklrxuaMGB8mvSqHDQMFz0G6fF71Zzzy1
 JWiUErq+pfZkzzKeU74CSocBd2M4X4L1y1Cc8cEsql/uuJN7aiCTf17A+ZcO3uok
 taMq8723vyS6er5yUVfS4k089/PtuEa66jr5uJjafUYOuUKi2GMChs8VkqREJP59
 3wLGbldY0iFKnJOTXGgittkdJaYlxM9liyy0lHGC11YVwxww==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es5a2p8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:09:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so3239781a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787180982; x=1787785782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1Ah1ijjnrgcaH/FZgiVM1uioWyY+u4JyQjm/Ts95iew=;
 b=C4iKSHZNYtXRgy3BC/Qaqt3E3AidwRx0iDvy/HL6UaauF4bSD+ttUmOBO5zXKRKJ3z
 /93ze25NocHHOY/wCbPylF5Qn0reU0rSxViXm0e4YQcDTh9OMF5w0lbLuVqyS/VPMQe5
 lkf2CaWI/lk7+BkZyFNBjtSqeOLdgWVNEg0jNESlmoVsB3CAbifN111qQy4ClPr/Tqn6
 8OtZ8vOBNOpygqS3ZUUgmjwJDViN5ZIxwLeViSPLkc6d0OI+od1xpbjkqvpfEC8UwRG7
 Qiio9z7RtsIDu0xFLKNHPYHCyD6qiU1WJKMViDfAu2EPSThqC5zUuCelZm7WizxSIuRj
 Czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787180982; x=1787785782;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Ah1ijjnrgcaH/FZgiVM1uioWyY+u4JyQjm/Ts95iew=;
 b=MWAjj+WtCMD6yTOCRzAgLQQpLB5xIBzrgqXHPMCgKTtIPE1cicX8Vc4pKC0aYCvwOV
 FJ/q8JpjtYdO7Q9tyfNsKHKpS2Ap3DahlDn8PvNeSr2tYy8RVcPh3pPIdfxT44fm640d
 l2IqLiFdIM/Jd/hSWZCNyvlwUzDSPPlUIta0VM/zdmsxGl/O2Jh1PH68wwE1cpV2Joaq
 lxudHQoIXOPEH4ghG87Txs2SFA+jhmFS3kjEngYT7gqwO3qWBs1lF92YcRKXytTchkyg
 +3SekoCGS1kHYZERSI2qVK+QWVL5RKVXk0cQz33b0AfXKX6ZX3+wlAz2UbOeve3rH/TQ
 0sPw==
X-Gm-Message-State: AFuF++lQTsRY3id1fWulUuTvxPX24kgv0ERbF/4bzAK6BZcAoLoZTCsz
 koMTvzX8qukhs4rwdwpRd8kqxbPpg5oE5jB9OM7z5T9DbmAHy2rs3QW+Efqt24jEFGVLmfzwpt1
 3/cPR6jjywHNpplAbjnp2cNPOEh4Spoj8wmQeB/0deN1ruD/R6psewccX4HfRSrh9ig==
X-Gm-Gg: AR+sD13Uw2L1ztJb3bBxiup+AMOVFe0i2rHRGbs1sV82vBW5bpP77uhoA20lFQRV7iO
 2x6xzmK+trA+OYAyryX6EbM6gx62AYCgDtRIS0ilTblpsFPnxhb0yzRUcma8TDPUlkog6T5I99B
 pwvKdLs0dd/dDJFcyWy5XSxMOFEaKG1QADnlLZk3MKNwPkEoEImoRVKLZ+efEcgMRZarcfOeR8j
 cPisRKz5Ka7FfZfGInOlGlNX88MgA56ToueyMoI6gGuVq9Mt3tZxnJtTPsnVSv1LQMHbl4+s+b/
 suxKAtALevMX/ckmJAq8pGKI9cp4AnZbl7FULU3LP7TXebQHwtqStsZL9Fwa/XMW0RKuSKZ6VKo
 RfbDCmqrmDklvw7sUJZX+4Uujm5vAG1GPD9HVrtIM+3BDeGpT
X-Received: by 2002:a17:90b:4d83:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39580eda10bmr14649908a91.3.1787180982169; 
 Wed, 19 Aug 2026 16:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4d83:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39580eda10bmr14649808a91.3.1787180981503; 
 Wed, 19 Aug 2026 16:09:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae143edsm18988944c88.10.2026.08.19.16.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 16:09:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/3] hexagon: fix HVX scatter gather, BE host
Date: Wed, 19 Aug 2026 16:09:36 -0700
Message-Id: <20260819230939.466856-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _WNkWqzE6uxlSx9pRb8eVWnZ6ikiN71F
X-Proofpoint-GUID: _WNkWqzE6uxlSx9pRb8eVWnZ6ikiN71F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE3NyBTYWx0ZWRfX+2wDItGcO3+y
 D8u33qgF/jh6/JrlzJGiqkd1C7s8nck3ECseZ/eLViu8DiJ5qvEuDaq7gZvpkV456LglDedFItM
 uubw/ATslfpAQix4WCMk3989Pbc6lAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE3NyBTYWx0ZWRfX1GF07Z3aPARj
 ivm9dZOrjh0nUj5zjp+Zjx4vaH5+S5SK1QGHb9+vj0u5VTh8Hy04NTIjXQlbyMgsfSfDr5QZy/c
 KzsQvKuudbiEpA8ygwSgai58Ykx0oANItb8IayT/6wKrGFa4vwEL0l8xFbDMD+1VbdHVXswbvNF
 VJrwy7JC5LRNHNom5LBubl7x0GL78re5qGCvC6GS+ZKK9j6+Rcu5mPOTmut+ye/Riy+7+BpwfR5
 fKLQ5qq2tb9/LDTeC78xQdVRnFKl3Wbms4C1ZjKVucR68iVkFGaskMSZQ+21JV6OA2gvQk5Ediq
 HmsSzFUVuDiJHAD+zKKE+8Ywq+1ovCgiCpqK1IhEYaauwPp1d9gsN1pCxo1WGKaacxHfMrqYfrn
 Pu4Uaf+HEteVRCdFoo17KX6Cyym2PJU/FOhZ9lQmL2beUnupWiwXgVCVLDdTTbZ+3+F01BNDkHM
 Ah+iGqbDByfzI1TfrRQ==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a8637b7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=PuCi7y2KxjHj4uNWrSUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190177
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QW50b24gcG9pbnRlZCBvdXQgdGhpcyBlbmRpYW5uZXNzIGlzc3VlIHdpdGggSFZYLAphbmQgZm91
bmQgdGhpcyByZWdpb24gbGVuZ3RoIGlzc3VlIGFsb25nIHRoZSB3YXkuCgpCcmlhbiBDYWluICgz
KToKICB0YXJnZXQvaGV4YWdvbjogZml4IEhWWCBiaWctZW5kaWFuIGJ5dGUgYWNjZXNzCiAgdGFy
Z2V0L2hleGFnb246IGZpeCBIVlggc2NhdHRlci9nYXRoZXIgcmVnaW9uLWxlbmd0aCBjaGVjawog
IHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgdmdhdGhlci92c2NhdHRlciByZWdpb24tbGVuZ3RoIHRl
c3RzCgogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgIHwgIDQyICsrKyst
LS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlYy5oICAgICAgICAgICAgfCAgMTggKysrKwog
dGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgIHwgIDE3ICsrLS0KIHRhcmdl
dC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICB8ICAgMyArLQogdGFyZ2V0L2hleGFn
b24vbW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5jIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyAgICAgICAgICAgICAgfCAgMTcgKysrLQogdGVzdHMvdGNnL2hleGFnb24vc2NhdHRl
cl9nYXRoZXIuYyAgICAgIHwgMTI1ICsrKysrKysrKysrKysrKysrKysrKysrLQogNyBmaWxlcyBj
aGFuZ2VkLCAxOTEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

