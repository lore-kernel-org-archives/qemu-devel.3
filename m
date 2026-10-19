Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3AECCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJU-0006af-KH; Mon, 19 Oct 2026 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJ6-0006XT-HJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgIm-0001HU-Md
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:52:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j3OY2264937
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=; b=n+3kIJDLUvLFBh8T
 N+bL5Dc2UytgD/biTP931mW2Y7YGnMQFphwyU1lMccZXpMSzmchqbak2q9wiUM9H
 zNCOEamzlelACrteyRmAS9lAEPcL5iSylJqJJmFGBl9VogeZMnYhCkcviuu2c6I4
 YD8aCXbFbdgIqkEpI17YKRR4uPwYB9N8hlGGJodhNzP8AWjcewI6Q8xoJuEkTOD0
 mWV2hQ7P4dV2tbP72b2wm0VwSd1dSaSrZQDtwHVAfZkQxQqrQGeKZ7MocJ/OSjGk
 EhfPFmPVYgSN+vVBF3gcf5hq11UBCBNzc00nMuXLJ/UMmdWhaBs3RlnmUUljG3dM
 tajLaA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxn5qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso5116437eec.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389169; x=1792993969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=GUa7cievTuylVtB0+edA5+IVSYDTpJkprZaWySiLJpedY+YG8bUuoVwkQcZu4TsPBV
 /LuzNNjxfSCJWxk0og2Ws+NiuyccvD9kJ6Y3B+nGxMT9JybrFNbil0Cs3pr/ApmjahS4
 TRwZ4kU4aU4KtYZchumNKG6t8ZifWLjBK1db63iZ2T1MZo6n6nu3OTJDfmN+PFiXW4MN
 h0dIRrzr8YgOJgHKB1Q3Lohv5BPJURGcZte1nTCpzkrsLabwQjv9msu/PwPdygO0YtIn
 spv5//J3wuTjVP1GhzAqCNssGhgn2C8Ty66ZVswSUYyUNd7tueBBKB6Ml1m1uHH3jm7P
 SO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389169; x=1792993969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=Q9CazT9x6X2tcwTtGt4QicTezryXPZPplDE/gWpFTEhyWvZO7FdjWC9t4xb7bfTcTK
 0keyscEkKm+aLrPY4WRJA59GA+45aFsqc/55Gq/4de3oEpmfgTcxcFeGjbGRr1U6tho5
 5e4AI91huCjerCPlFg33/BbHzjPnv75CorMHnUuxYyqFGQU2945FUmw6yeqSJZHEsA0D
 6CD9y/jYgKW+qKUKI92VN7QOm018/A7De8b9IYTCMwQPyx2HIEZkHQ4F1FIVWNJrqjXO
 Sa3j830SQw9IrGbeH40q+oLF9EmF2E0SSdNwuzw4z7qE6oNofRxkXWD0DeE8RVAtwG7q
 oY0g==
X-Gm-Message-State: AFq9FYIxiYJc/e5uy5Y6JjYcgc3unbIPz8vWfMi5OYy4WC76Z+tw1ex7
 Lltcucoo+y9W+qYoT9Lk2wQhvS0Qa/RYP1pgX8ysrqTQq8/8OsK5VbvLbZfvratddQ4RKAgV5MU
 JyClnMJ+ipAeSRJN0XEU9tIV5p+rts3EiQqQqxQMSsmeQX0gHNhMiIhasZ9aZuMaDNw==
X-Gm-Gg: AYBFou10QmevkQh0rxU8+tifg+jX29YyIccj/vr7wV9PSp9fVRm+3rxNYw142co6bok
 KE5ICTbAOhf+8wfCwQCV8g30zKHLk6HobgW62tiPldSeBOz6vAwpPcS8LNIv3NEsaeCPOrlt2s6
 CNeVVZyxbQNiu+PP3MHD8L/dWLWaIjjYwzB63g/LyedohB2qqgK1Ni2X4UEwjbnOMAZKIexyNjJ
 KWk/SSEth32Zs2zOMI1qKxu1NGZAD/HvEL6wHcgyZA0y1mrrL6xi6/nhhM6a44u0H2vcwaJl77v
 RDqkfIgsiHIeUHtYB2TVk/B2m1zanWQxqXAgZs/kW6qSaABduA860ca5CmHoYaWKJDqI6qZEnnP
 iAiNzWc5EpxfM31s1BBPfgJSTRxlfUVexxDdOYhxY4yHkXqU=
X-Received: by 2002:a05:7022:1706:b0:14c:6eab:3f65 with SMTP id
 a92af1059eb24-18513b9aa08mr8540615c88.31.1792389169408; 
 Sun, 18 Oct 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:7022:1706:b0:14c:6eab:3f65 with SMTP id
 a92af1059eb24-18513b9aa08mr8540599c88.31.1792389168831; 
 Sun, 18 Oct 2026 22:52:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:52:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 01/14] Hexagon: add v85 CPU model
Date: Sun, 18 Oct 2026 22:52:32 -0700
Message-Id: <20261019055245.1457795-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX0nRGt1Jr+igz
 M/JmRpfUUWxggIQ6QFvbEgDuJNABdHX6PKspZEzjA/S4HEbkszdO2Bt6imO33YlZZ6AjFeujYga
 bOQ1Wftw9WcDdMVSnuBdzyJR0buM9NQ=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad5b032 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX3e5bVJ6G5Nyt
 Xs+k2lj5ee64GcI7GdmHFJiKvt+BI9Uze/TdIm6XmKdabrGv1O2q97ed4O/1uBpHUWY/cz2wfzP
 cM8a3bsBNJX89PvwnZ85vLkqL2/CUk12wOnpwLHUht79mgpxSlQ62PanzlCH4+oaAfURN7WlH1K
 4SwVw3MHP+ITOaMHPv/09Q9Nepb3g0wf/J7TR+e8g3r7KVc+djUPlbKOeqzotGSZ7qXaTUVnlVl
 goTBrFR5BeKY7UzIcYaBQOHKkcXTbJyu9if3fbup3CM7NIlg53EqehoI/2dJLIc5Y3+MBuAD1xQ
 McUVnJysEHHNViEP4tS3Ikd8/shJMJfLEdpAmGYTFMRie1o9hWj7It7Nzj9pq0br22m84dtNZ5T
 2+mDPbRraefr6hvEtLY9WzZKuPuRnPD+7hK2nQ/1iwKxPThPruhEuLv08Xaf5biyrBllra5yexX
 4TyNg2/9Qjw+lxKHe/A==
X-Proofpoint-ORIG-GUID: 6mbHnbH1_o_Grpjjvzu1xUKjCBqpT4h-
X-Proofpoint-GUID: 6mbHnbH1_o_Grpjjvzu1xUKjCBqpT4h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190023
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCB8IDIgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICB8IDQgKysrKwogbGludXgtdXNlci9oZXhh
Z29uL2VsZmxvYWQuYyAgICAgIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICAgICAgfCAyICsrCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgYi9k
b2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKaW5kZXggMTIzODUzMTFhYTQuLmZiNTdj
NzdhZTkwIDEwMDY0NAotLS0gYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKKysr
IGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CkBAIC02LDcgKzYsNyBAQCBIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAogPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KIAogUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLAotdjc1LCB2NzcsIHY3OSwgdjgxLgordjc1LCB2
NzcsIHY3OSwgdjgxLCB2ODMsIHY4NS4KIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xs
b3dpbmcgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBl
WHRlbnNpb25zKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LXFvbS5oCmluZGV4IDJiZmE0ZDVkMGZjLi5kNGM4NDEzZGVkMyAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS1x
b20uaApAQCAtMjgsNiArMjgsOCBAQCB0eXBlZGVmIGVudW0gewogICAgIEhFWF9WRVJfVjc1ID0g
MHg3NSwKICAgICBIRVhfVkVSX1Y3OSA9IDB4NzksCiAgICAgSEVYX1ZFUl9WODEgPSAweDgxLAor
ICAgIEhFWF9WRVJfVjgzID0gMHg4MywKKyAgICBIRVhfVkVSX1Y4NSA9IDB4ODUsCiAgICAgSEVY
X1ZFUl9BTlkgPSAweGZmLAogfSBIZXhhZ29uVmVyc2lvbjsKIApAQCAtNTUsNiArNTcsOCBAQCB0
eXBlZGVmIHN0cnVjdCB7CiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BV
X1RZUEVfTkFNRSgidjc1IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9D
UFVfVFlQRV9OQU1FKCJ2NzkiKQogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09O
X0NQVV9UWVBFX05BTUUoInY4MSIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjgzIEhFWEFH
T05fQ1BVX1RZUEVfTkFNRSgidjgzIikKKyNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODUgSEVY
QUdPTl9DUFVfVFlQRV9OQU1FKCJ2ODUiKQogCiBPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShIZXhh
Z29uQ1BVLCBIZXhhZ29uQ1BVQ2xhc3MsIEhFWEFHT05fQ1BVKQogCmRpZmYgLS1naXQgYS9saW51
eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpp
bmRleCAzYTZiYTRlMTMwNC4uOWY5OGFkOGZiODYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMTEz
LDYgKzExMywxMCBAQCBjb25zdCBjaGFyICpnZXRfZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxh
Z3MpCiAgICAgICAgIHJldHVybiAidjc5IjsKICAgICBjYXNlIDB4ODE6CiAgICAgICAgIHJldHVy
biAidjgxIjsKKyAgICBjYXNlIDB4ODM6CisgICAgICAgIHJldHVybiAidjgzIjsKKyAgICBjYXNl
IDB4ODU6CisgICAgICAgIHJldHVybiAidjg1IjsKICAgICB9CiAKICAgICBlcnIgPSBzbnByaW50
ZihidWYsIHNpemVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBmMjBk
NmRlNmY2My4uMWUzZGY1ZDBkMDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC05MzQsNiArOTM0LDggQEAgc3RhdGljIGNvbnN0
IFR5cGVJbmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJTkVfQ1BVKFRZ
UEVfSEVYQUdPTl9DUFVfVjc1LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzUpLAogICAgIERFRklO
RV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCiAg
ICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJf
VjgxKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjgzLCAgICAgICAgICAgICAg
SEVYX1ZFUl9WODMpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODUsICAgICAg
ICAgICAgICBIRVhfVkVSX1Y4NSksCiB9OwogCiBERUZJTkVfVFlQRVMoaGV4YWdvbl9jcHVfdHlw
ZV9pbmZvcykKLS0gCjIuMzQuMQoK

