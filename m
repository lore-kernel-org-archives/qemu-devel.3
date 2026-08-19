Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF44C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfxM-0001q7-S4; Wed, 19 Aug 2026 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwfxL-0001pj-CI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:03:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwfxJ-0001nM-Tf
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:03:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD0InF267983
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ndxsWQYsEWc9fpdvvtnfX/
 eyj0k7+9j7LHPACpd4MTo=; b=jl7TQFS4bHxF2V96GmdkGP+FzZ7BZ2E7Bolwq+
 +3Z2tOgvi/d0TC3s86tyj+3Dc36Op4v5K/dwxlV1ce4kUloIJs3PFluJeBOXaTl9
 mVZFHKhzLcIwDoQjIbdlh7CLYnidJVtvde8iJfVFeC9ipFVWCgJatcqEgvp/dqKE
 TIHICkJHyqCT5U4DW3LpQ7mcSCAR8CpxnN4PCZQAYU6g6mnOl4fQydkEd6ZyF7ZC
 M9h4yGfIPqXyhrh0tGUWIx1zRMMhhuFGm30LChfoMSR3mPd7QlAM0Qj/wen4DQv0
 xqu19e26WO7wh3C0czCW5Xd500CROXMgkVZjIfr2nI7mL9cw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfnb8n5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:03:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1281296a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787144624; x=1787749424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ndxsWQYsEWc9fpdvvtnfX/eyj0k7+9j7LHPACpd4MTo=;
 b=Mfj/YxOTLdZ9OcAXQfQ5HuFHOuIxByk4N3E82GQBocPrE0LCPT1swRJ/aNCkyXBIm9
 T2F8iPVPqiKxoe/u7G9xfT863/39MzQ3LDgWN0C+R8ybWkJuCm/dceyya5pRksIV7CVt
 vSAGB+bspQFahkW4vfW/f7wbY1cs0E6ahCgQwS6wiSAQRnJ7ovUjcsGgV4+RDofQGbn7
 kOdch4UQeSlSTYfBNMa6ZmKLV/ccP96Y+ekIFzGZrVhU3EK4DI6H61V8/QDJzLp6E65J
 2+gPoN8XvlyA+4s33ShVFCmOpauwIms37sa0hiPkpxGcK487lR9qXGKrpmG2SgFcDCV7
 mD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144624; x=1787749424;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ndxsWQYsEWc9fpdvvtnfX/eyj0k7+9j7LHPACpd4MTo=;
 b=QOlnJTDHHiXiEu9ne2FCJ1RtqE56PbA2W0wAFVYG3XG7N6QLNUgGDNbUYK7KqM/Jh+
 9jYCgtLUHUsKqOyT+q068JyAfp5glAHjO9lczROgoa/PycdrZBfBrZoquMmlV66QOgOG
 7CUuR2pOBen3XQB3440gJKPASUp2LyM1wiERITrh0KA01i/p4ESjRpuh2NiKYejDcDb0
 knsXHUec4T8L1pAYEg2ZikGEIzJn3EK9P5DItFjwoy46WjrFTFYd8jyeYR4Vlts6D6rF
 G73k1/JeIga1ULEruQ3ladURHByP1Ugd5xzxwB+rb3OQkAVXdoCxoOTpbD/bszwzeBzS
 OzwQ==
X-Gm-Message-State: AFuF++lOvpEz63Fehn6PUiv96R/613mx8VlqF4PJw7pxv7KMTaupeK/0
 2T5GLLn6VF0zvL+RODjZr4knwgW4ip8P4s0EvttTR2ME3bLn5RC21hqsMnVsE4L6ISVHQ62wEss
 DuflMdHKmOmoqGppBlPsC/HmD8D6Zk4VazOsoIzrqPH1Ecj+uYYIdjuoS3cNe8LMg+A==
X-Gm-Gg: AR+sD131Uj1IovL1XVjmBJ26ha7kaRz7eOMmBjrCzhAqAZbEG34CZ9yNo81G8EQ5AIo
 u5VZZXK8eoHiJP5srZhbSNeaQZnUHBc95Xf3H6L/0UpcLYdKlXLvN3F1VHkILlMmfRTghEB/Z6G
 SrdeIBvpAQG5Ly0hJj1HinPym+HgwTLLe/unYqANHAlqXeg5AzsoHQG/ikRjgxFTd6L6NBV5VbN
 wI7VVpBv5msA9u2eAOArdpscl78YgeGHP9q/czZLTiJgBxjtRFrbmK15HctZFSSgr/eABYvlO74
 iHTWxPKG9ci75bTbA+EEr0VFKIhIYWxXdgkgrRuZ0Vfr3MmK29/GHyBe6sVgLmx0l/2vncaH9tu
 PXOmnvD0HeIzFwvRpGzXGncCAVR1AUjpj/2uuUQk5Qf8aeksZ
X-Received: by 2002:a17:90b:28cd:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-395812a8b7emr8911647a91.6.1787144623550; 
 Wed, 19 Aug 2026 06:03:43 -0700 (PDT)
X-Received: by 2002:a17:90b:28cd:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-395812a8b7emr8911464a91.6.1787144622815; 
 Wed, 19 Aug 2026 06:03:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fbbc017sm2995668a91.15.2026.08.19.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:03:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] hw/hexagon: assign a distinct htid to each DSP machine CPU
Date: Wed, 19 Aug 2026 06:03:41 -0700
Message-Id: <20260819130341.4076146-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=QedWeMbv c=1 sm=1 tr=0 ts=6a85a9b0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WAbSPUPzBIoenm63aUMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: H3dMFCBfm_Ty1vB7KXnBKHQeO30-KpuI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX0jKSz745x5fa
 qxKmi7aOcKuIniEcsdCHQ+RsSrgW8Y9BKGWnw5DfaQGZMYDyX9Iepxxe5JLCJz2bcaD5JooM0EV
 +BEZE14LHVc9hkppQa0fSKTcwghwx/8=
X-Proofpoint-GUID: H3dMFCBfm_Ty1vB7KXnBKHQeO30-KpuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX7wPzt4V3eeKs
 48mDzlSCYGkRUCm85bpW+67dgDfqpNGejDcMNZqS694ifiWvnfID3M/KPhgVTE+qT7ULmqJKIGU
 LqGKvhuQ5lKnWDTVKPzyrins2JJ25ky7sOIvkLOgBgO6K6XdQ/sSDgDyeM7UqNRpoAQedFIpnik
 qTAqxyxzyTwRAlEXEqQ/3MmjYrhgYoZg0hoNAQndv3ApJfhicVuqzKZ5SJB/bIiuXr9pVviDH98
 d2dWD/wF3VQITF+ZtqU/t20qaViHoemCTiMTrSnQZpV+0bPWqQyeyUJKBShOSm0YiJNiqsKaxD/
 ppF9YMzeVfmPO2HEp7oC5488zVU4443kMIyk9Mpto8ST72s//fbuilrQkJ4ndrGOGb4+WFEuaet
 4La0ZYMsTbiZeGImnoiOo/+C+qlDN/dY4TnwV/FnnvextKvZ5AmjlPWkzrLZX/87Wk5vrBQZnc8
 ZgszEY5e0t9pacvfkXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100
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

VGhlIGh0aWQgcHJvcGVydHkgZGVmYXVsdHMgdG8gMCBhbmQgaGV4YWdvbl9kc3AuYyBuZXZlciBz
ZXQgaXQsIHNvIGV2ZXJ5CkNQVSBvbiB0aGUgRFNQIG1hY2hpbmVzIGNhbWUgdXAgYXMgaGFyZHdh
cmUgdGhyZWFkIDAuCgpUaGlzIGJ1ZyB3YXMgY2F1c2luZyBoMiB0ZXN0IGZhaWx1cmVzLgoKU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMKaW5kZXggMjAzMDZjMjhlNzIuLjgxZjhmYmVmMzYyIDEwMDY0NAot
LS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jCkBAIC0xMjQsNiArMTI0LDggQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jb21tb25faW5pdChN
YWNoaW5lU3RhdGUgKm1hY2hpbmUsIFJldl90IHJldiwKICAgICAgICAgSGV4YWdvbkNQVSAqY3B1
ID0gSEVYQUdPTl9DUFUob2JqZWN0X25ldyhtYWNoaW5lLT5jcHVfdHlwZSkpOwogICAgICAgICBx
ZW11X3JlZ2lzdGVyX3Jlc2V0KGRvX2NwdV9yZXNldCwgY3B1KTsKIAorICAgICAgICBxZGV2X3By
b3Bfc2V0X3VpbnQzMihERVZJQ0UoY3B1KSwgImh0aWQiLCBpKTsKKwogICAgICAgICAvKgogICAg
ICAgICAgKiBDUFUgIzAgaXMgdGhlIG9ubHkgQ1BVIHJ1bm5pbmcgYXQgYm9vdCwgb3RoZXJzIG11
c3QgYmUKICAgICAgICAgICogZXhwbGljaXRseSBlbmFibGVkIHZpYSBzdGFydCBpbnN0cnVjdGlv
bi4KLS0gCjIuMzQuMQoK

