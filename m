Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67785606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T7R2v9C+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT5JChyV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLm4J-0004S0-JE; Tue, 27 Oct 2026 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLm47-0004QA-V4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:38:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLm44-00063t-Oh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:38:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIAp43486333
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MSRY8NQ1llHDCsNsi9fCJ0
 Ryf/zCCaX5TLLWIdZZhxg=; b=T7R2v9C+scCG18x8PajL2di5WR4NbJnuqbvutp
 YdtyAwvgZSAL1tamKc8oF5VsOWSTNZkNVxrh17wD5PQOSV8tPXRVssoS+DFEN5jX
 6NxlLjThOfg6STBoJ7dYyVS4wuRDXfQkCm4VTTbTGaB2oSd43C1GD7RMvA8Rqah0
 Cu766JVA2kCBjssJ+blqyRsl90ZfVJCmFuJv8j9e/bs1hctx0R6up6TWgMvKu5l3
 8DlTma94XeiMDUH4h78USxDgDtQBHH7kPViVShoRBkMRQyo7dkFyTl93TrouwoE3
 3bAolfMivtH+fbZVCWGL1OkeGVWRxL3dlPZPo8zMOutW9Evw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtbwbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:38:26 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-82169fb66c3so435952a34.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793126306; x=1793731106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MSRY8NQ1llHDCsNsi9fCJ0Ryf/zCCaX5TLLWIdZZhxg=;
 b=CT5JChyVgA6zEh1fXi4jNo64HwodCQPp+MVQqOoq2ReCDOuKcIJUG1MFTNernKarLJ
 PBKaebFSz6+RCQZJnD55o1leb08MrZiSmJXK/Zl9R0n1Ub2hfI8/5xA1fc61GuSkJyTJ
 ys/3Eb+W2d3gmxlXxir0WqHSedhbzUyBl97HqGU2v1xwMeRxdvAe4lb4/U2hAheLTWH8
 VOt4o13OEl35FFcrhePkMuuka3rxoXfaAhU9OZJ7yfFVLCl4gKrCQrWnAlBiBSFWuBf5
 wbtR5YdzPiAHodx2+15K3GLp8t5xfJ7eDCVcummPtY4FNqul0ejtQ+7f+sTESHqW2ivf
 byVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793126306; x=1793731106;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MSRY8NQ1llHDCsNsi9fCJ0Ryf/zCCaX5TLLWIdZZhxg=;
 b=e7SUliuSP7aPhzVo6AA+t8v4egwSWMtijZ1DKHQ3ZJ/xFLpNsFSRmCM3WQvp3dODjD
 2zu43q2dZAPghouM0QqDcKlv29qCxsnI33ig9KVng0MmoYYMJ7/F619awv3WueFObLWU
 j3Bz4gV/UkbzXcqjs1GAY9RoqiiI5YWw2ouwiHSXWXMDeB+mOjzyHaq3qZ9xdzWG0rPx
 u0cq93KMHtZqwjvBY0o2r3t3IeBY5ss1+nxBHi1Fstz5D7j+96hbpsNyt6QsojJsM2DN
 xwp6nMlifYirI5RjWqgNdYC4rqfx7Xp14E8djEz8iUgU8MIYICh+LSHZ5Ui9/NPYn3tt
 QVxA==
X-Gm-Message-State: AFq9FYKfdtnlBbTRKNsba84ziUtzP4YgfI64XLx9eLnU87/lhJTybBBa
 v24mz86DXCsSeRBWjqC3kuD+1OOfmwH44DMEIfxQ1+6xs29gjCIRoJccM7v52MNWv0D0+EfxpMa
 5Q3Y47Y7AsscchbF5N+Am+A3epp80+LMpj788P5YbLZY3DbIiGkKQY8h6HSYYkENzmw==
X-Gm-Gg: AYBFou1VlfbC54Vnnqd5E3UEpu+ZDmNejYxYFa914UPf7AF1oG8Oi8F1/kDkMAm6gTm
 6Mr0H4JZ2bX+Mb2Zk62X1xW0YgtViHqg0byHiSGghcBL/8IL60cIVNRb5K7/VeEMhedpXToxB6M
 UrW/4pTMpyFQu3T/UabfgHuJgstb4iXcWB/NHSQZlZVA4hKGdR/Ak/OdogjSXQFgmZyGWn4gN5m
 5nYwlSfqb/Lv+Uqt9XuOt1MngkAKFp7k47k4sovwm8YbaMQdabw7wn7IS6kpDFZIbWPVwL2vbAx
 m4DI4Qt40W5sL7wignNjKGdEe1G4tfArUXpZU5CbEwUOcsGUfoyWlOU24ZgVncP03Q6Q6yRiP6i
 JYFU8583GyDGVbXmZfX8vegq4B4cF+E6eOsaCNE8RLflT0mY=
X-Received: by 2002:a05:6830:2642:b0:857:52f3:a5fa with SMTP id
 46e09a7af769-85ab6781853mr449827a34.2.1793126306128; 
 Tue, 27 Oct 2026 11:38:26 -0700 (PDT)
X-Received: by 2002:a05:6830:2642:b0:857:52f3:a5fa with SMTP id
 46e09a7af769-85ab6781853mr449799a34.2.1793126305630; 
 Tue, 27 Oct 2026 11:38:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fbc1af87sm11800320a34.22.2026.10.27.11.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:38:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/3] hw/misc: QUP UART device
Date: Tue, 27 Oct 2026 11:38:20 -0700
Message-Id: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NCBTYWx0ZWRfXxXeQMShBPhmZ
 ji90kfMhAVXUvdapes95zxQ9uk5n3morjk6/JeavCxCvPX0x+z3TNQm4/e3J+e6NsBBy4FQJUC4
 ymmSm6NSfRWOIk3dcKD3C3xKO+kkzSU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NCBTYWx0ZWRfXxZx7hJtjZAf7
 VAYASl0AXBnbxGV3XqV6yDLgzq2YnsLia7zHpJt6rJJR80vFLtDbCyeALCZFlFKMWo4BOzk5sbN
 RyjLLQN95vw1rMawss+Tke8JjOB83cj9v4ipHgJe/7lRk68PnCyb2xrmW4aoHDs0OE0tblwvo5f
 iQp+jGCQ0nIZJoUYmn1AmFKmVgU9xGEFhi1Dew7nbQDNSkx/flbsdnrByY5pmP5pgyiO203Wz1k
 UzeJ+ziBiIMqrh8/kfEOkzqe/Vq5gkdvGD+MfasOBBDe0cotsRhOX4QozfWu+FNXPf+I4ydNuOl
 lSFAxRq9YPL5BK5NgUpMA76Bsk8cZDeear7RuBd6xfvHYm5qCxYMl/e4uYHHZznj0D9Ri3z59IL
 5wuc6N2QxAhuuLpjQKBmTHlDh1H47SFxM/na4Gk5RLlKeYQCc2Ggp6JvqeMf6ZMmVJXxoueqHut
 OUKlVGULWDaGxUlILWA==
X-Proofpoint-ORIG-GUID: l--64DPB1i6zivYBqEq1xmKMGpjiAbZ1
X-Proofpoint-GUID: l--64DPB1i6zivYBqEq1xmKMGpjiAbZ1
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0efa2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IbvcdFXhcY3Ddu1IGL8A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHRoZSBRVVAgKyBHRU5JIHVhcnQgZGV2aWNlIG1vZGVscy4gIFRoZSBRVVAgaXMgYSAiVW5p
dmVyc2FsIFBlcmlwaGVyYWwiCnByZXNlbnQgb24gUXVhbGNvbW0gU29Dcywgd2l0aCBjb25uZWN0
aW9ucyBmb3IgU1BJLCBVQVJULCBJMkMsIEkzQy4gIEZvcgpub3cgd2UncmUgb25seSBpbnRlcmVz
dGVkIGluIFVBUlQuCgpXaWxsIGZvbGxvdyB1cCB3aXRoIGEgdjIgaW5jbHVkaW5nIHdpcmluZyBp
bnRvIG1hY2hpbmVzICsgcXRlc3QgYWZ0ZXIKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI2MTAyNzE0MzcyMS40MTI1NTg0LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
LwpsYW5kcy4KCkJyaWFuIENhaW4gKDMpOgogIGh3L21pc2M6IGFkZCB0aGUgUVVQIHdyYXBwZXIg
ZGV2aWNlCiAgcnVzdC9jaGFyZGV2OiBmaXggd3JpdGUgZXJyb3JzIGFuZCBhZGQgd3JpdGUgd2F0
Y2hlcwogIHJ1c3QvaHcvY2hhcjogYWRkIFFVUCBHRU5JIFVBUlQgZGV2aWNlIG1vZGVsCgogTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDMgKwogZG9jcy9z
eXN0ZW0vZGV2aWNlLWVtdWxhdGlvbi5yc3QgICAgICAgICAgICB8ICAgIDEgKwogZG9jcy9zeXN0
ZW0vZGV2aWNlcy9xdXAucnN0ICAgICAgICAgICAgICAgICB8ICAgMTAgKwogaW5jbHVkZS9ody9t
aXNjL3F1cC13cmFwcGVyLmggICAgICAgICAgICAgICB8ICAgMjcgKwogaHcvbWlzYy9xdXAtd3Jh
cHBlci5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgOTAgKysKIENhcmdvLmxvY2sgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE1ICsKIENhcmdvLnRvbWwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsKIGh3L21pc2MvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAzICsKIGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAzICsKIHJ1c3QvY2hhcmRldi9zcmMvY2hhcmRldi5ycyAg
ICAgICAgICAgICAgICAgfCAgIDgyICstCiBydXN0L2h3L2NoYXIvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgNCArCiBydXN0L2h3L2NoYXIvbWVzb24uYnVpbGQgICAgICAgICAg
ICAgICAgICAgIHwgICAgMSArCiBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9DYXJnby50b21s
ICAgICAgIHwgICAyNyArCiBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9tZXNvbi5idWlsZCAg
ICAgIHwgICAyOCArCiBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9zcmMvZGV2aWNlLnJzICAg
IHwgMTI5MyArKysrKysrKysrKysrKysrKysrCiBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9z
cmMvbGliLnJzICAgICAgIHwgICAgOSArCiBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9zcmMv
cmVnaXN0ZXJzLnJzIHwgIDE2MCArKysKIDE3IGZpbGVzIGNoYW5nZWQsIDE3NDEgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vZGV2
aWNlcy9xdXAucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3F1cC13cmFw
cGVyLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3F1cC13cmFwcGVyLmMKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9DYXJnby50b21sCiBjcmVhdGUg
bW9kZSAxMDA2NDQgcnVzdC9ody9jaGFyL3F1cF9nZW5pX3VhcnQvbWVzb24uYnVpbGQKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBydXN0L2h3L2NoYXIvcXVwX2dlbmlfdWFydC9zcmMvZGV2aWNlLnJzCiBj
cmVhdGUgbW9kZSAxMDA2NDQgcnVzdC9ody9jaGFyL3F1cF9nZW5pX3VhcnQvc3JjL2xpYi5ycwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHJ1c3QvaHcvY2hhci9xdXBfZ2VuaV91YXJ0L3NyYy9yZWdpc3Rl
cnMucnMKCi0tIAoyLjM0LjEKCg==

