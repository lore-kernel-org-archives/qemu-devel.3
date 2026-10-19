Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U2MJNyHW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KNVQHSlM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1B-000268-Q1; Mon, 19 Oct 2026 18:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw19-00025I-Qt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw18-0003uy-4g
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZS3k3914119
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5JoXeAq/KYY9NlbzrGPKHTj33pVITNDlzwp855i1znM=; b=U2MJNyHWNrmeSHRz
 6QZwh9zVFOb11uewezVGpGcXG6diN6ASh4R6/uvHndYFZkKPQTALJ8mPhHhoGV5C
 yy0a2Dk89sDzE7pj6mBwu8FZmSQTttHySbsS+1GzXqZkVSIwLxujlGqroR3lVq8H
 ps93FvPtJ3u58vMnrtEEC9sF9NseUAnitk5EdZnhMTJqXaZ4wKS3il+71UgqrzcF
 CFfQtWuMCDXIwe2izW3iBKe5gufmx377Dq69Irzrtp0A0zo2AT9bjpPO2V5/iFt0
 IAtR7SwYI3nxN9Q710cDffa1Kk6VpQdtZeQTkuhFVvIYIrtpW4hKdDhEIqQhks7N
 MHquog==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gwrq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso4078818eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449580; x=1793054380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5JoXeAq/KYY9NlbzrGPKHTj33pVITNDlzwp855i1znM=;
 b=KNVQHSlMiyKKNF0rrwDWKvIhnYOdJyz0kdCskqG4e03FllXK04WKBymbqIyNmU5zmS
 Qg5FzcwjLQ642mghfYuTWoVr9QZ1SUfdGIBK0K/7CRbE8HnERgTjnWSAaTbSTWuVgWyk
 /lO2APAVfIG+Z+vGLHtNJmMQC2l3IgjHunRQRDQa+HY7tnCpV5KVTPOqzWc1LSYyHP8D
 o89jltxqLmSS0iI2TiG07kEhQ/NNhRC9Zn8dA32D+4UuWMq4cpgWrzRGEUs+ck8PYBzy
 v0SushQU/FOh44DH63kuTqhxZ+JD1hWHVf2lhXiYO/tNWkBeDrOCsQ13P0GCMkie1n4I
 BdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449580; x=1793054380;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5JoXeAq/KYY9NlbzrGPKHTj33pVITNDlzwp855i1znM=;
 b=ZHajPYxeWfKbOMXYGIvhWR5v/cngZ9f8eobPHSmLqdLHosZWyA7V3FOPQ5ZjaIIa9/
 byP+oPLDyQoOwd6uLSaEiv2Jx4Ut2HGfki9hhyiu4NJT7CveTIRdO+sWXK+IDMAm7sti
 xK8aM4MuPHtlHMSZXHb3neBEUXyXZun34A3ZEjic8W1IR+iaWy9zPx/Lq+iIkwVBifah
 458LUWPDWAGXTSA++WJWJTx1Xn9cdHD6OnNRzVpWFBC4yamMYTlpeiGaRWXhPz1xpxT1
 hFgaTtRsA6D7/XdE9YKJK8R/u/mjwyJfuNryj/SMIYSwqezyCN72/WCQG8eNMJt1/SUh
 oSWw==
X-Gm-Message-State: AFq9FYIuorqbarILULBHbjpr+7cxs6UOY9trLYN2TM6AWGRJfVjPeNOi
 u6SWYUgTq6C2QNAnhXm0X1OSfu6PAyaeFXcJtSOdqU5yBxt/BG3mnSXKLSEujPWZQmfnDq6mNgH
 XIPWgTYqr3xt44R59+qZSW4Fr0semBoXHrO5qxzUik3v2cWbgvxx2qpJbnGthWuHlyg==
X-Gm-Gg: AYBFou0WqJv/Z/4xiAmftZe63q0X/fqvGRnsnfX/+nBFXu0vGXGZk3LU9uFfAIcZESZ
 x2ao4R/k07uGhm0oaoYXMgkEfRrXQQhlUFsv6q3sZs0c9Rd7lv/Gh/7t7SQE9uK7OFSZdygEvQ+
 zgAeq93H5nhrJsuvHp90UTPiB7JGhdS34C1yy6c2QhEkAR5ZAx05JcVDLdu29tGpg+TBbrSYAB1
 AcC8eM89Nqj8i3bpIaKYtdvuPks55C0HsokiNk+oAyI7YT+C4WXeg95I9TLUUfcxZVCqC4A3GtG
 Nfv962RNK3p/U9ipqJG2+UFO42/njU0oROBQ11R4/zM7JU/lp1J/5h9t9MCD6tKp2s74oEyU0Kd
 odNA7E+2zY5jNbvR43F/7sIR0IYQOYZTKdBr9H1DDFI9xvgU=
X-Received: by 2002:a05:7301:2d2d:b0:35c:89df:812e with SMTP id
 5a478bee46e88-361a302a214mr13035008eec.34.1792449579766; 
 Mon, 19 Oct 2026 15:39:39 -0700 (PDT)
X-Received: by 2002:a05:7301:2d2d:b0:35c:89df:812e with SMTP id
 5a478bee46e88-361a302a214mr13034982eec.34.1792449579155; 
 Mon, 19 Oct 2026 15:39:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 3/5] target/hexagon: drop a pending HALT when resuming
Date: Mon, 19 Oct 2026 15:39:31 -0700
Message-Id: <20261019223933.3248208-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
References: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX1G71kgEURWiX
 DRYqbkWqeNqBuLtgRMTQgN/5m7XMvShIPrtgwWaobvYQkkbHz02DH1Hp8i68KUQTtaj5pGBng0g
 NrUhYE+Fp9rBDLSu9Qg4RqRO/Dx4P3ZdySjx4TrYqWWYekPFgWPVVQhP9lGknyq9U51pki0i0ff
 vrNuQ5aafTKeIxWLGjngjeyGjy5hDa562yIF4A/GhvsXr14/Zkkcb53FGRqx5sxsFnmBLPMylr2
 FHarU8mceOHA0x3/+BaiNV2DhtJoviff6W06E83EWTqq/qOgoQKf40jSEE2U/KJyBxETgRq4sH/
 J/vCGzeKaycKRyauisqyw7zTYUFJI5KT5DnHSfk0V7kmuM1c2rwzO5FyvYtMavrjmIVXEdbYDHq
 ONRfowKIKjQ/UhNpSKwS9Z5kYDg1+PAaN2tZ/J7FA4KMEgb7LrlesKIJG0+Ar4M+JMOUS1d8zBg
 KvETdY1ipWl6fdzDp+g==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad69c2c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX4FaEWBkV6hsE
 /JJKVizG0GmhW5K94Ax6zwPd8Qky8Up2PHkXRIheQorQHdCN9IIlaO3y57zYm/pzRwu28uvqy6R
 eWThSlVcZzuMFrhf5D2uON08NB/u1Ic=
X-Proofpoint-ORIG-GUID: 4qwmNedcFSARYPdWBCDwtkt0NVV92sei
X-Proofpoint-GUID: 4qwmNedcFSARYPdWBCDwtkt0NVV92sei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190090
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

QSB0aHJlYWQgZW50ZXJpbmcgd2FpdCBtb2RlIHJhaXNlcyBDUFVfSU5URVJSVVBUX0hBTFQgb24g
aXRzZWxmIGFuZCBvbmx5CnRha2VzIGl0IG9uY2UgaXRzIFRCIGVuZHMuICBJZiBhbm90aGVyIHRo
cmVhZCByZXN1bWVzIGl0IGluIGJldHdlZW4sIHRoZQpIQUxUIGlzIHN0aWxsIHBlbmRpbmcuCgpD
bGVhciB0aGUgSEFMVCBvbiByZXN1bWUuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMKaW5kZXggNmRjMDY0MDFhZDUuLmI2ZjMxYWVmYzBmIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBA
IC0xMzgsNiArMTM4LDcgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhl
eGFnb25TdGF0ZSAqZW52KQogICAgIGNsZWFyX3dhaXRfbW9kZShlbnYpOwogICAgIGNzID0gZW52
X2NwdShlbnYpOwogICAgIEFTU0VSVF9ESVJFQ1RfVE9fR1VFU1RfVU5TRVQoZW52LCBjcy0+ZXhj
ZXB0aW9uX2luZGV4KTsKKyAgICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBU
X0hBTFQpOwogICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4
ID0gSEVYX0VWRU5UX05PTkU7CiAgICAgcWVtdV9jcHVfa2ljayhjcyk7Ci0tIAoyLjM0LjEKCg==

