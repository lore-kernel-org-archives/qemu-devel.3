Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E2606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VU/DuzaJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OlgjEwrF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzc5-0005I6-4d; Mon, 19 Oct 2026 22:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc3-0005HN-2p
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc1-0005dh-2i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tC9N3485875
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xKIqDTo8HI3584RCZ0iFhW
 HfUc7ieYEv0gQQu7WgJJY=; b=VU/DuzaJ7BZfb6xgXNmAkqrUGMj6aDMmhSQ1jK
 ZuUV376QVZV9HkuRFUN6ztUz5ElNa1rBvBqroN496+Wxb5LDSKuL+XJwtI/xZ014
 IoDslPRnsVEbc4W0EgaoadjA9WZ7pGE0nyF9toilrRSdxy3yJISDmXzmoHkmKT7o
 JTSX0yq3r7tvZ9TOLcQooPdW/5nk/PrPI57VwUfb5GKglL9RtXUkIzF4myCRSu2t
 qYKKkMjcSuKWEe8iadR+Q9X7jxJV+dwdGwkA20igDfMnDIy16ZPhm72UJ6cvoYMs
 vImWoo6xFUAFtE8UueuoFH78mHSOjOB0WlkdBCCvGJyjlkCw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n0f3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:29:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so8061217eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463397; x=1793068197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xKIqDTo8HI3584RCZ0iFhWHfUc7ieYEv0gQQu7WgJJY=;
 b=OlgjEwrF0FwnVdKKYb/mUkWX54k6n8+sycXwbjEdjyomIBpC0/Amiw99THBEGkBlih
 MEten44zC7/DDv/ACIkXl8YXsi/LhEMwd+MPv2uvbjUqxFUEppWe0aHKqPKecGCh2QuO
 cSr/EhMJl91J1ws1u4g9ubKoJqJ40tWiqMOnX1SLL3bHi7XBpPx/9juZ1lBrM59J44eI
 ViVkMOPVhMkYqiH/pJFPXiBEvj4/iQDrEQqdrCFjHN5HIrj5N+AkQJJPTh/agdX3R8K1
 /IuZQ4eFFZF7FOYKauJCnr84s57CQAOgW4rkQS7NBUv5gan+2EcQd+To4aQST55TRWql
 ZDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463397; x=1793068197;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xKIqDTo8HI3584RCZ0iFhWHfUc7ieYEv0gQQu7WgJJY=;
 b=VLVhTTXLVpMu3sdEn/NJx3hIFYkjwdz9GGQnMRE04TiR4Md5USaiXNCNNTLth3LcH7
 pBixHCfulsnfZ9f0NV9sv4kld4sLRaTaZ9g3QFODPyRD6rV/Pkx4tn8d0KaGWsIDIdeW
 09J06e+gCI+ki7UuQVngctkoE3/h5ndlTrBRnKWmopt2k0jntGQIOn5bxHa0gqsax/09
 sFZOYl9WxlxpZQb6+HSsHATnwt5OXlmobuMcA7H9hwTPgcCtiR9E/Rzsn+KqmcCO8cBC
 nF1IytbT5vILE6CLXaDhW6htenbPEIyGbw8tur9wMgaQ+7KvRSKrF0hc+JqtPhcXG3hE
 yquQ==
X-Gm-Message-State: AFq9FYIIsZdK0RXlcSfRLCzNtd/CoH6tOQGUtNLURlj2evpr0IVEGF7H
 RqSkwbfVNVDxtcFPoLdi13O1yd5SJcytYSTfAqTaXfg1Kb7/Vs5eLOkfBvHj4vW7qZ5cGvweLUE
 QEBMHJN0ZvjP2PBKUBpUZQjQ8/q5jcaqNYmOtNllXHOo4XJ8hpw4XXTpwaaaXOwSHlg==
X-Gm-Gg: AYBFou3G6+SPYzV+rixqidjSrOizIksuBzSj6x+AopnHJcyO8EZaRB9PJD8nl8qAQQO
 yGyaZNdIV9eCdczIeVUinQkU+PpFE10Cofhgesi9ZJSwZJGJylDMiuwo8Bd3HScl/dzPNsu8jHM
 pErL9/B+BdaMpvsY+DrxgSAVsEZdrhnQHKo5MtZVunE7rLL7fOpxsRTpZMDDYgfUdGZluzA9mHW
 DsmtBrVDm9mIz6IlL8cCgUnMATN2WJcRm2z+Wzyx16tiBBWJ05YApW5wpYzCC4NugGEXeU/PFd3
 kpe0Ha74NijS4XD4nMADlN6e9+gEg/avzQuFhJd9ywgKQlUcI/gcwHDMI4d7hW3H0jlA9mUoDS+
 uM9pRp3Mi7GLSVkBvBOBQIKIPH4vNTjkdxDsS+HKS1dbfCeY=
X-Received: by 2002:a05:7022:1508:b0:17d:7b45:f907 with SMTP id
 a92af1059eb24-185136ca94cmr13854624c88.33.1792463397137; 
 Mon, 19 Oct 2026 19:29:57 -0700 (PDT)
X-Received: by 2002:a05:7022:1508:b0:17d:7b45:f907 with SMTP id
 a92af1059eb24-185136ca94cmr13854597c88.33.1792463396556; 
 Mon, 19 Oct 2026 19:29:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1830f213ba7sm37895921c88.0.2026.10.19.19.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:29:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/3] Hexagon: performance improvements - tlb, l2vic
Date: Mon, 19 Oct 2026 19:29:52 -0700
Message-Id: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad6d225 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=C8NoJBFNCo05qvYrfdAA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfX1fUBBSlubImu
 4KCFNd5JtQhBc5Tj1Ralrsw4RDH+MNn3/Ssp1b/jXaCeo8IRo7Baj1dPuFnl1JgEYsXcbbzQGlq
 lgII6Akj3FXpuD0fjEgU1wO8WD2HZVs=
X-Proofpoint-GUID: ecXVtXu2InY8JQjugPCFzG4PvsnS62yd
X-Proofpoint-ORIG-GUID: ecXVtXu2InY8JQjugPCFzG4PvsnS62yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfX6M4zSpn41PxC
 /DzGo/xts0jrTxiVfmCW9YKjwLiDEuTaapkgtb6cdPgN4oHAYOOuvg94Iz7LRIMeTHF8nUoDY9I
 9Eo4EoI7YrTfsXzySsu4aNQYhpceYzy9G4IBquLGxLnbsn0xii2VA67Aj8I4HL/hb6Fqtl1WxmE
 DYZjNErkZ+fZSq+iWxIr+5sIedyr3doTg/NmYRxnLKjBt7p+nLsFuoX4ETuY7VU0fl09ZR9lABM
 XXB/VFbux715sAyslBiyRHG1R1XoT+MDRM0uLH6B6dAgLj7OWghzmiVqVGsPzHBHqyckZIujzBG
 pWaaA0/OdUhfE3myxohTjzCJJ24014+ufVhzUbdXAF3NQOiszynpdVgUeUM2DtIUxb7GgIitMbQ
 UA0CyaO+AX3pt9oXGWicHIKIOhx1yr62vNgqYJ57+EyddsVvzj7EIMsgiCEAJX7BWbc5qt6uqBU
 rv5GTacQwqNSrXYJPCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW4gdGhpcyBzZXJpZXMgd2UgaGF2ZSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXByb3ZlbWVu
dHMgZm9yIHVzZSBjYXNlcwpsaWtlIGJvb3RpbmcgbGludXguICBUaGUgZ2FpbnMgY29tZSBmcm9t
IGF2b2lkaW5nIHJlZHVuZGFudCBUTEIgZmx1c2hlcyBhbmQKb3B0aW1pemluZyB0aGUgY3JpdGlj
YWwgcGF0aCBvZiB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgc2NhbiBsb29wLgoKQnJpYW4gQ2Fp
biAoMyk6CiAgdGFyZ2V0L2hleGFnb246IGZsdXNoIHRoZSBzb2Z0dGxiIG9uY2UgcGVyIHRsYmlu
dmFzaWQKICB0YXJnZXQvaGV4YWdvbjogb25seSBmbHVzaCB0aGUgc29mdHRsYiB3aGVuIFNTUi5B
U0lEIGNoYW5nZXMKICBody9pbnRjL2hleC1sMnZpYzogZmluZCB0aGUgbmV4dCBwZW5kaW5nIGly
cSBhIHdvcmQgYXQgYSB0aW1lCgogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggfCAg
MiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgfCAgOCArKysrKysrKwogdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCAgICAgfCAgMyArKysKIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oICAgICAgICAg
fCAgMyArKy0KIGh3L2hleGFnb24vaGV4YWdvbl90bGIuYyAgICAgICAgIHwgMTggKysrKysrKysr
KysrKysrKysrCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgICAgICB8IDE0ICsrKysrKysr
KysrLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgICAgICB8IDE3ICsrKy0tLS0tLS0t
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgICAgICAgICB8IDI4ICsrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgIHwgIDYg
KysrKysrCiAxMCBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMo
LSkKCi0tIAoyLjM0LjEKCg==

