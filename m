Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD991606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RgpONGls;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CXNJTAKM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvnx-0006uI-NT; Tue, 24 Nov 2026 14:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnf-0006o7-72
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnZ-0006hb-IT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:28 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXLNN1767125
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=; b=RgpONGlsJnsDpyD+
 c+BSmUJAZhSqNefLXhy3kJ+9Wq7tlqU4zgxw7U2pPaP6U71hrIiLv/kA7ygx6bYE
 mTH8l64AoFFqu2/C2g4+l5+TzGL5dZpKc76Gmc89E+pXLMcX7q7TF0+hC0PNy3am
 rDvpNtMOxwhZtP+lJWRdIz8Jww6Z4yWWUNY6keZ96yCoz9EJkhbDOoME6ntduB9o
 2y23kMZTBzv8ZaWW5c/iWFDxy9WbDiTTmv6NvoFNbBt6mQO4McmisvHL9mHGHkvl
 nNtv+uDwNJIhZPQT/vg2DD1oviwGMtg3s5EIFCOsY0OXg3NYduSyvb8mZNG9krRW
 sEQgRw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs8mpu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:23 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4fb73e868aaso5200865b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547003; x=1796151803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=CXNJTAKMqVsYVZFfHzjeE4G5dRKQKNYSjtExDiOqhV8mE8aKM4yseZzrF+BT8owb+P
 ikrFWFuXcAliDdxQwlbecEV+uMwkNNF2wNdddOfe7+GJobFC/0+AqSbNNOcp91hlnSex
 0AkscH/+44nh9B3Sje6TClJFWQDEvabxSuV5LRs1qd/uQoB/dVfqhfBmlo3JTUQvijQq
 6kU60LwOMHpjAgVq9PQizTUahwq+4IgdF1Vc79HOdXn4ihttUZFMsM/4TEvTv1wxfssJ
 O3tFGtkIibNA2sbwNe5sPZV5ptQZgpIatWlTH4R3O4tzLMGf9Ju8rBNcJbM4gNB5XSc2
 p3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547003; x=1796151803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=TMIe+doeFBPo94D5QYV2LjD/apDcrDFA9M331trwZRHXPuahHDgeJmlTxRYtZv4LLM
 LoSv3dHvh/7kQbv/PXUt/rzz+Y00g7gqGtOiXtyhnjy8fH9EoGxSOSYxWDu1ZGfZh1Rq
 Fti2Mhk1CeClg9LQqi5+tAI5+ZXD4ahCz+H9LVda3C4MFg+oA54sIRuQWYqSb7msKmZq
 8wXcxz7asTj4srw2iR+FJw0C5yMwzYAZfvjHA8OcWVWuiVM7vyK56XRfDxeo+XLVXsgM
 O4Xrg9/ibv4Xd2TjZormBFVLUVC0QuFUIBbJy2Ec9euBTUe9mDC2arcCecbJKsKf1e8A
 N5gw==
X-Gm-Message-State: APuU4Z/SLSE4eRO7MSAubknb+i9ncN5JRq8hoFcIxo2b2YqlyaRbreKE
 QdEeyjSQkRZsselTKSR0kYoUrv20Y0T4+FoaokF3zBR9FZcEnxYLg+VG7NSQiMPVnLDgnyWl8A6
 c9/DPe0gRRDfuZqEvp83SBtnAVfjI4lxhEt+gR6XUL76GWta31q3rCT+/c7ocOMxUgA==
X-Gm-Gg: AZFdTZcTDl8nLfSbq0OdWoLdoEKGYgRflSkkyXLPN2Gs2nhkeiZqyT6iulROVFfKGe+
 AI8YW2NlnE5VOX3HH6ThhNsbF5NuC/z146+DNbvK1yWXpUkW1WKVfJ6ifVryk6XrEJLfIgAe9Dd
 ZRIPPk6k1PTW7dDUNIlzoAqoQu1jx3w2hOBfa089zeOzUqOadQXx+T2DcjtzxOr8exunK5HbseD
 nomrRlbzz0iNflNV1Qkv4PyotnauGRXzdInSACAKZGNhFtLAW/ijDt4FDMn5f9fssSSrk1FU/wD
 rODoI6Pnp7Z/rxyfNA/QvfK72Kt244cxzrrmS6ph3O/7eLjlKqUdh6JP5fkWMvML28hlwO4BHrV
 40cYgRFbdYPmrcQR3CgxXmXFjxUIjPNs6Xgha7Prc8phrfv7ZphVZRhywa1OyC/w/NJAyIykJuH
 GkkJcYdg/oJj4jA0PtYIgf5Q==
X-Received: by 2002:a05:6808:1507:b0:4e7:dc61:f4fe with SMTP id
 5614622812f47-57a0b6538a6mr16308669b6e.55.1795547002758; 
 Tue, 24 Nov 2026 11:03:22 -0800 (PST)
X-Received: by 2002:a05:6808:1507:b0:4e7:dc61:f4fe with SMTP id
 5614622812f47-57a0b6538a6mr16308629b6e.55.1795547002332; 
 Tue, 24 Nov 2026 11:03:22 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 3/7] target/hexagon: fix get_exe_mode assertion in
 hexagon_stop_thread
Date: Tue, 24 Nov 2026 11:03:10 -0800
Message-Id: <20261124190314.3882017-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX43eQiXZZk1/v
 wDlZxtZ2Zb0Tjnml7r8SJGvR+U3THqgfVvlveE2c9H+gl3puvDeD26O4OW+4Qg/lpAbaJq+KEZ4
 qMWdbKzmbG6AK0KFHGSJDDAGghodG8V6++4WO0NTv2EX6WzHD42EmkZHFxzU5Gj+hcc7wXc3T0a
 FZLv2PVHXGdeHIWHhU3NGQjMIgmJJdbQZn24AajWVeHnNpMz9WJ6aTzb3otBnOfTtWYNxABupjf
 aK6TsyRYVt4Or1dDg3WF6wbVv70LW9b4xCdN0NjwOnQL1EZNfRB7nJlUwx6HuGKdsQSXlVoll0o
 jh7Gdianzmm/I4zMG1Tt3iXzI9pKiR2fbNs8JnoFRkwEZuWbE05Ho3HGlhCvAm6kY6GtVRhiH0M
 t5OqRik9w05B6p2LRzXH0VQsP+tmoM3i7HdPLLyFm2Co8U+duBVG5so1/PaZmALp0mM4qSt1PK/
 /YQSxdfQQJOuczNvK0w==
X-Proofpoint-GUID: SGdKqazVknehWvY3ZdKe0daa_9s3o4Xz
X-Proofpoint-ORIG-GUID: SGdKqazVknehWvY3ZdKe0daa_9s3o4Xz
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b05df7b cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=DyE358pAE-X188sEe20A:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfXzYXswotcAzM7
 R1PMDJSvEQ1pToR2YgbbF5qwfLsqQ0F4U6Jwrpone9Iq5AgWu2wcm8XCgL50srqOS4/bPbstt0J
 Wv87VheYTJZLUTKRGRUxn3Jq9n3w4Rs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240074
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

V2hlbiBhIHRocmVhZCBpbiBXQUlUIG1vZGUgKFc9MSwgRT0xKSBleGVjdXRlcyBhIFNUT1AgaW5z
dHJ1Y3Rpb24sCmhleGFnb25fc3RvcF90aHJlYWQgbXVzdCBjbGVhciB0aGUgd2FpdC1tb2RlIGJp
dCBiZWZvcmUgY2xlYXJpbmcKdGhlIGVuYWJsZSBiaXQuICBXaXRob3V0IHRoaXMsIGNsZWFyX2Vu
YWJsZV9tYXNrIGNyZWF0ZXMgYSB0cmFuc2llbnQKKFc9MSwgRT0wKSBzdGF0ZSBpbiBNT0RFQ1RM
IHRoYXQgdHJpZ2dlcnMgZ19hc3NlcnRfbm90X3JlYWNoZWQoKSBpbgpnZXRfZXhlX21vZGUoKSB3
aGVuIGFub3RoZXIgdGhyZWFkIGl0ZXJhdGVzIGFsbCBDUFVzIHZpYQpoZXhfaW50ZXJydXB0X3Vw
ZGF0ZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCBmNTNkMzc3YWIxNC4uNjgw
ZGNmNTY4MDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTQ0MSw2ICs0NDEsNyBAQCB2b2lkIGhleGFn
b25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAKICAgICBCUUxfTE9DS19HVUFS
RCgpOwogCisgICAgY2xlYXJfd2FpdF9tb2RlKGVudik7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFz
ayA9IGNsZWFyX2VuYWJsZV9tYXNrKGVudik7CiAgICAgY3MgPSBlbnZfY3B1KGVudik7CiAgICAg
Y3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKLS0gCjIuMzQuMQoK

