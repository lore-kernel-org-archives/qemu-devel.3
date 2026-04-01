Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4B10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV2-0001WB-6k; Wed, 01 Apr 2026 11:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUs-0001Ay-1Q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUq-00089k-KX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FLiuj1562613
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=; b=WhXAajRX3jZM6P7C
 GLTPY4BegL3nSSgTB3EfEt8Yc60xiWQmo9o5E3XciU4ikG7uwNa6HpjIMgjs4GkQ
 GW0J+h1cdKl26NK6NdjfhaH/+1OdB7OUGwowGbk3WGv+n7U9g7mHC5IB3Fzx9MWh
 nIir6Iv5iMDZJkUD1WQ0g4o8pcVwxhfwuVGbr59lHa0zlQE8xBBZWUokatej4q13
 ANR5Ud2TGRoElLocvv22ypu91lrsafUrNlmAJhiecpMis468sIBiUjm1jY0RT/0a
 KCMUvfHn9QwJZPr8vKC1tWD/VNPXRrXWByMeP9ljgPkzvB85X/biABhubwvFiCAn
 lpUQYg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tq7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so6984797eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057276; x=1775662076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=Kj52g9gsHKmNprx1qQQ4fDzGhiHBZYj9z4e48Bntu0FxEmJSvnxE38IRHO8eOF9dJ6
 8QHW5Qz7PR9xKTMsE+bi9991uYClWQB+ud8s3HBwClsmaQGoVwCT04X3ji3cR86FWm8l
 OseNbK7XvCiWJVzWjKdCclBifVG/994qj6vAwLnRJGvuBZEF8W9sAeAxeew95a7/lKMR
 nC80sFwOndSK5cjBkd3EhxmltQXGMTcu9jPOIERrcFjxFSM3F1XJn9MR5MSGgQ4Ze8vh
 xN6KPjK5J4jgztSYpfgsw1w3JxacTgnwoGzN8xvNTLRtCRK44wpfjiDJE0tXu+jWwFff
 vlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057276; x=1775662076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=LzK2runanrJoEC4fWxXnk5M63CcmGc3lUFGC+c8j1EWYBws5iwMZrRiUJL3WR2E5sS
 hNm/hRognZqOYfBVdX31L9oFo48wzgc91k/wQ3LBI+W+gLzcUBmyolWeT6GkJ9WmkEAI
 APwcF76q/HSI/v1W/FTVvFic3/k0vhflljhQp/24AAHVP3p4MfQG3yANXM4QcnrLdrHN
 fBAN21ncI7K1np4Gw02QZviWH6j3Ca8ZZzvngdfeSG7ZtWjO36h7viiLnqwxbzR1Pik1
 rOnwFQf0mtAAN/KaZaC3uEldDmcKg3n7KCohywT6pylWej42Our1sOSuauSPVk9oGF+0
 LJZQ==
X-Gm-Message-State: AOJu0YwP/NfLNFrKeKVQg/BriFtNN6RcpQdQxURcbMwKDj7K4/dkhDfC
 SqSuoGDDS48j9xvENhHUJoH27UQ6BHTqN0a3eYAKR+rzRD3H6QaIxJUqcWqpyR5R5Qv3BHIp2GV
 8ebnpQzv7eWjkiLHfohbNikxxUzpitnFFhaBUtRWY/0yfSxN6cmZY11ObRFj/OxhA2A==
X-Gm-Gg: ATEYQzzslreOyx6hreB5fn/cyr97sYF8MCVLBKB2zwXEQoApvemjF2M3sJK8eHfqp0C
 CS4TCRg+UwGD8zNDZMKkk2vqfhxN2wTWsuUb0FO8Vfd032hY4/831+LA5bihQuQBT2JSaIojnv5
 uwQYrei0ck9zeHdyfk5/EbCrULDOHfRgu92DHipXAhMf+/R5Fz+iuoKBOVNz0CtSfV/c+vTnSQk
 UNE3UTc0b3dGJBMeUkxq2Bivzm+XWu9MoZh6c2aKlfJrBqpUNXhHkRv3LMCYpafWlbboibpugVx
 r7aIUpCNK/hNxgT30cLJ+v0AqO44Evo0xrB0LKRo+3CsUow6T8KM6vBXR6axhaLWMK+aNAPHcvt
 fcY3aF4dGRfDIONXx5x8qbD3kKMg78Gb9TVUzmq1eV4cpVjdJ0ur3ln0QCWIh7HSR9uxz/g==
X-Received: by 2002:a05:7301:db04:b0:2ca:775a:94f4 with SMTP id
 5a478bee46e88-2ca775a9ed7mr38266eec.0.1775057275643; 
 Wed, 01 Apr 2026 08:27:55 -0700 (PDT)
X-Received: by 2002:a05:7301:db04:b0:2ca:775a:94f4 with SMTP id
 5a478bee46e88-2ca775a9ed7mr38247eec.0.1775057275068; 
 Wed, 01 Apr 2026 08:27:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 10/37] target/hexagon: Add a placeholder fp exception
Date: Wed,  1 Apr 2026 08:26:30 -0700
Message-Id: <20260401152657.314902-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6MOC6wi-8-f6uxx1iRJDz5W2JkV4A69f
X-Proofpoint-ORIG-GUID: 6MOC6wi-8-f6uxx1iRJDz5W2JkV4A69f
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd399e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX7c/A5LkVTN9y
 VcMrOA5cXFPhl24DRjhSmNF3jQqj2AFRGDfm/kGxHLXUywr1Lm8b6PE3Dfp3YgdY5ajTwgXuuXv
 wJA3vipxGp00sAVRAMy/5/EfLqNGbDBobroBsL1rclBMexJjOPXxYCEC77kMsdBMXYNtwGtfuit
 +XP6BYyUIfkxRIwDG9nyeNkR8k38y/B1evQw1NgswS4Iu6fO4hyDpv53ca4bC2Leg2v6UF6N1Cd
 rNOe5xI/whek6v6aUNWpgIzInzHVjC3aD+xMJYTqdqe6YlZs58KS7Ae3TF6RFl1DJFEpvzv+yRl
 iUpPWIiiH4pQmdKUtfy2ZgF/6oY4aZ0F6ZHfa6N5ip5QiyfIZsyKsbIKnlMx4MeAtJ5fDrnhYAd
 z1qXfFDX2qq3ENC3fVdQQmbak8Yj5thyjwezG4NH47ye/1OORVLfKiCt4poDrbJVbI9cVs88QUI
 xTQr7Na6WDVd92rO/2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

