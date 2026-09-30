Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF8CA5FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySi-0003NT-Up; Wed, 30 Sep 2026 13:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBySa-0002bJ-2Z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBySY-0001b4-Iz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHeuId241660
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RWQA3knkM5vN8fnI7ov392
 51Nq+F1GXBwhcGsIy0/8Q=; b=TeTxO2C36TOY7M1ut9isiAAqpBJ1E/WlHSZ2Ud
 B2t5tpkUXNoyP88ckuAfylIpyliVMlxxYlq5EPWpZBM1dmu5yJNa3ohuxj+X46AV
 tJRRJIRmo1uCWihTmQ6VATtMkUQB7u4nlJvmu0oHbZS6a1HxinsR2GWWS2gCb/81
 s4+pvf8bdqFiYlx4WrkMgYH3D6FipFtYdgrXTbx5Xg5ik7g2469A5v7H/PWM0qpJ
 a+VM9VNK1uWZyWd/Yok5BNAd+yBC/iAV6hWUf7W0LIlhTbrw5fFXiud2o50WX41r
 DKo52Jw0kNltRudd6kuIvucEOJ3XmIIOut328aWNLnm4t+6Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h10bka2q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:51:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so7150977eec.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790671; x=1791395471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RWQA3knkM5vN8fnI7ov39251Nq+F1GXBwhcGsIy0/8Q=;
 b=UVB2oVCTDgcmdVeQnYtkFBLoh44wO+Zo1fJ+gDku2X9uyt/J1RnKbGyNAYJ+WyUSQA
 62IyQET8lnzlxeJZGbdTOu6hvXfomnjM94op/7iU9IRS/z37vaAUy95VUivtsd93YqLO
 F/gzZdU+VCnqwpivUWJud7f3pMZyzZWjgEo5+AzqBa0wQncyr3iibIicdxUZKfKW47HM
 6IvMpCgMlA11LghXGGJbVueoZ8gy+6zjqqhbclUuLapOElcpFqkNEVGDDAk+OSoRUbzD
 zyQ+1WY89Y4bVt6MRPVIXwPPbLOf0CaZaQSTIyywmlkHIBGnBguxRPx1Bvi1BDx1R2Uu
 LqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790671; x=1791395471;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RWQA3knkM5vN8fnI7ov39251Nq+F1GXBwhcGsIy0/8Q=;
 b=G/HTMOMpt8w7eOkJce08kj1iMEjiWKB90K+/I0a+kBNFB8YYbWm2p8MjbJ9mX++qtK
 uy2yOCxEQ46chNE8bZuiNkZyJ5qBw30mwUj97jDSPWPaJ3nnFip7x27co7EWtTYGpZW/
 SjBiVeuC8ehKqsdtUfZX4LmEOjJt0mf73XQc8lJS6OYdvG7SxBGbZ0YdskzOGspOruLD
 +OBVSMJ09p1M6pQdBVzYgWDcFZgl1W1CMrBul/No3Ue/G1phpH8QZSBxCgJQA1iU5Kso
 vA9rVqfqKuKfj6Vp2HdpkeARramnoaZvIoScLuFpBc3kc7/nsCczH1rr/NzmAdkI5zME
 iUXw==
X-Gm-Message-State: AFuF++kGc1I4Vdn6dWdRV++IaymzzRvn7TAw7zQ0e6FpWETKL2pwSS0L
 TOnGH9LXHCUes1fjXTkuGm9c9B3GSXGULcA7SdJ/aFMd7CdVQtETcn4P++s+7imxhh7ovWMKS/k
 Revlp4Ml2SBAbIgll8y5ihkjGy+6iSFW9170+ZfQP9AxDAzJswh/R12yK2kkfu/iJTw==
X-Gm-Gg: AYBFou0jpQZErcuIwn5OBaWkkTylEFkkEvrzIuCJb6hUTFdQXHU1DG4j9x5SpIDVS6O
 5ee1fStZNtVBbrAzNd/1GEOeYrLcMSzPpKcc+3PXXL61+CCr8/V4zNP+Fc5+JNhxpDyuJPo5tDq
 gqbGSKV4182Ltj/cAnKKjUvpmofNHMsxVExs/L59qLlY1nXBjW0tQU6RJk8YT4BFPF6/y8hnnAD
 BWCJdkh/jx5hHqVbclxgCoyQIUbgNs5Y8Y17go1lXexcMt0OiPo8j+zl34UMqNAgi0Yzmp8V7K0
 t0mxbGOvJVtrjuB++8Cx20fCNbACHCQ6N/rfNqVWmtt2joBBdldrIUJYVvDPhBk0SoPPBa3RG3o
 44jccoeFKs5lAtliKUTSUpiZyP41FsYOhAqj4xy5uBGwZ4ow=
X-Received: by 2002:a05:693c:6392:20b0:33b:fc17:e786 with SMTP id
 5a478bee46e88-34cdc6bb167mr2390146eec.16.1790790670788; 
 Wed, 30 Sep 2026 10:51:10 -0700 (PDT)
X-Received: by 2002:a05:693c:6392:20b0:33b:fc17:e786 with SMTP id
 5a478bee46e88-34cdc6bb167mr2390119eec.16.1790790669924; 
 Wed, 30 Sep 2026 10:51:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34db42325c5sm496156eec.21.2026.09.30.10.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:51:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] hexagon: sys+guest regs in gdbstub
Date: Wed, 30 Sep 2026 10:51:06 -0700
Message-Id: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xviS5GJ8zxpOzeLRn4-CBRuNvUU4CoLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX2yzj0F1QI6Qn
 ms0DmNOIgPj/3PJGZvU8Sj3kH83RPZsj29Y9qvemoZGPhyD0B1q2XTwDDE26w0OPsAfYdX1Vc68
 PEvzQc2ddv7nZ2obUut9rXQrvkAJG/n4G57OLpIXj61UEORRlQNHHIWnCUJqpSP20wHrfwonk3e
 dr2OCan8m4RmF3dVtvIju1DXpyxxl5bIsuVhZTtsykuz6hYtMBQU0UWEc+jc/5i8tT5fbyAEQzt
 lSlCJLN/AyCvqfXlEoiITMOVqb1EdrErEdBZ8Zm4OAaaPF11JN4UqlrmyeEvKFcbWo4rY0wILjT
 zP+Zcjx5S2u8KzeTUTTUx5A2NBvd1D+POKHUtu3cSiK2YzdejKufTwwwg3BsuwhLsWE/jSiXbco
 6Ft/WWu9vLeWMaKv68mgpdRPrlNHMJ1ZB1rr/VITOMRWiusAXJjKqNPIFKyT1pySWoZGpsYsy+9
 VS52YYNqdlbcFvzDR6Q==
X-Authority-Analysis: v=2.4 cv=MZn5KJ/f c=1 sm=1 tr=0 ts=6abd4c10 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=WIpnzGJqifEpWwfNQGcA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX08FOG/HcCNBa
 F1vFiPhYKEETZ9UKbh6XSoVzRHKV5LNXobmkO+MXL0fO7IMZFe1vO2jXkYwsYa07LsK0jKnVRNn
 z8dCgVYq5XlbrTcFyR3SC15gYaVpnu4=
X-Proofpoint-ORIG-GUID: xviS5GJ8zxpOzeLRn4-CBRuNvUU4CoLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300071
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

QWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcvd3JpdGluZyBzeXN0ZW0vZ3Vlc3QgcmVnaXN0ZXJzIGlu
IHRoZSBnZGJzdHViLgoKQnJpYW4gQ2FpbiAoMik6CiAgZ2Ric3R1Yi9nZGIteG1sOiBBZGQgaGV4
YWdvbiBzeXMgcmVncwogIHRhcmdldC9oZXhhZ29uOiBnZGJzdHViIC0gQWRkIHN5cyByZWcgc3Vw
cG9ydAoKIGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrIHwgICAyICstCiB0YXJn
ZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9p
bnRlcm5hbC5oICAgICAgICAgICB8ICAgNCArCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICAgICAgICB8ICAxNCArKysKIHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyAgICAgICAgICAgIHwg
IDY4ICsrKysrKysrKysrKwogZ2Ric3R1Yi9nZGIteG1sL2hleGFnb24tc3lzLnhtbCAgICAgfCAx
NTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNiBmaWxlcyBjaGFuZ2VkLCAyNDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGdkYnN0dWIvZ2Ri
LXhtbC9oZXhhZ29uLXN5cy54bWwKCi0tIAoyLjM0LjEKCg==

