Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2699606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AZ7u1Ne3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jXFcnkaO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr8M-0001Q8-Gv; Mon, 19 Oct 2026 13:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr8H-0001P1-4G
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr8F-0000R9-Jd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPFe93115290
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FOpwqohhNxaJ2gsTZEkU1cGfwjzgPX2ImTwzJmVcB64=; b=AZ7u1Ne3OE3Sp3oh
 5h4UOLSSS7OniJ5p/uKejMpe82Rm3f14pWyQEATNFga15S2fzuQq7JUW8bjqXR1k
 EbhP8CpyS9UcTh3us1w/VnEwko73wkdgsqo+L5EYqDnnjr3gglYf/UNma+U6jSZ6
 JNww9sFTb0DTeNVtuzbJSmD4M2kdTvlnWsr1fTaiLZAaLsJ6+nv9mBfhrQ8qWgFA
 uJdU5NecI5EU69L2tTAwuDf840EYFu0ZlJAso5A1AE/RbVMWbDAcU8ycR2t5JXVM
 wdJKhqYY2owbAJyciQKl9qJoOL8ij1l7NNVeBUnUr9hgTVocKXSNMuOUd2P6ND7I
 wTMq+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1byw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so6395184eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430802; x=1793035602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FOpwqohhNxaJ2gsTZEkU1cGfwjzgPX2ImTwzJmVcB64=;
 b=jXFcnkaO4HglKZ/CqFCTyf8mFy/EgfGnSAjSRhVx5Nc056zESJPPYXzNPPr9cRMd3A
 vqnnAaz0HCRrT+jIeRvPsspTK3BMcydwbfE+4WbAXZRi1KVgDhtlaBLca/oFVrJIMLBl
 X2t/tHY42PMBM0qqups8O6xuinYSigKSfVRWXndtRiD+CALHD/vZ6xUQRLf+OutvaxaS
 eEGsyLr+AwnnQeCrYs4j/4FVp6pLA4DpOnfInS61xYbla8QsZvj8W15hGp1VPhdCLgB4
 TLsnfs2qHXrGeazVIUCRz2DvNJpNDIjDbI5+514rxkpvJVOsd6jZHLMhjX1PnHSAVoOV
 A+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430802; x=1793035602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOpwqohhNxaJ2gsTZEkU1cGfwjzgPX2ImTwzJmVcB64=;
 b=vHp+xZdcfi8tbcVDsBS4p4oype+7CyTavnXTkwhdE3X1y3clMtJD7xyLy+t1eYClwF
 pyFueitGa3UGc3z4Y3E13NdqS46pbuMcu/DfRFZ7lFNUTrmP7zcWRRWhRQZ4hcUwvssN
 PbETtOax9eWszGGC+iZHkxwZgzr9xFGXdXvGNXV/iijb/sPN/U0ssW/l/apD1etjGMqD
 DzCG3gBU1mCj+txxGypP9eRg53DWmke0xzzO2b1FNPq/REv/42/Uc56quiMkfh9X+RxC
 6QBs3jmhyrkKSdN33nyfrOqQykfqfGtbZEM16U9HT+gMrGYTK9a1IvRAC/eFNh6qoMoh
 U78g==
X-Gm-Message-State: AFq9FYI8ByM7wl5Hbfg30QRMD3I43WGy6C69C7+AfMIUZOpTnsCDu0Kg
 EpCZriG6DAenRg7ZN4DT8eR2t0LoDgUC46NS1wyyKaZHfc4luks1xnyY3o5zZXj3HNLeomLuQjx
 RguLA3Bs9Gt+V1uZAoAINNEwPto1UN+GSz5PvK6HB4f4GPgBN8NJyRhLrlCaww83JBA==
X-Gm-Gg: AYBFou0AawOaHPpyK2RLfWQGv3AwhLjynu9b9Qyr+KJeQSQXgJd9YaFwX/Yr8nWwstk
 EskcIQRkJtDlv7rz65tser0T5WOqOSCzaiWUY0AdKN6p5bLclUQcWRVA68LDApezOtDQUOwrqKQ
 fpvpO1rwGfpmeysR2DfxzO+XQP/k5ElHZiRIf/kPx3zZhqBGLaL3JI2TWcSjsXn5C74cX2LjUak
 hPrbTF5fANVrUiWzDz1I4LUY5MdtMI40jfPNfWLNFNu9ghYjgD5zahSF1t1crVttBIwZvEJlFVi
 UHCoJ9CXVMM0WGkNpFvKBktyG3geODuV9WsAZfxcGG6maVvV0WWOahueP3Wv9tb27SR9vGM38FU
 KMBa1RPUyS4m0RC/Rml/XBkh79oYdNutqsmrtDaGnf7TWXKg=
X-Received: by 2002:a05:7300:dd49:b0:35d:800:6344 with SMTP id
 5a478bee46e88-3619ea243b4mr11598538eec.4.1792430801615; 
 Mon, 19 Oct 2026 10:26:41 -0700 (PDT)
X-Received: by 2002:a05:7300:dd49:b0:35d:800:6344 with SMTP id
 5a478bee46e88-3619ea243b4mr11598510eec.4.1792430801059; 
 Mon, 19 Oct 2026 10:26:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 08/11] target/hexagon: preserve callr target when Rs is LR
Date: Mon, 19 Oct 2026 10:26:00 -0700
Message-Id: <20261019172603.2625677-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfXwWl71PUXd2hd
 DaXC2Isu3W5eozw7ZuFYbVbI1LyROBChTV009U8tyG1V7QS//QMC8qh6SM3pdrpqlEivlzaDkwV
 ei01xpQxoEEo1DKaJBwTTIn3ljPKhEs=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad652d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX/o37sqBl8K+P
 IuU8ENLrDhkUoFuxQ6Ro/7qHRVxm2V8tvXImmFGO3svyxEucB3oYfpTh5NLqIS/Kc9bEpfltXHn
 O/6MWM0AT4zIiKyUGgof5LRJ2qJnt96g0XrD/s7UuuqGNHHbOdvz6ygzSpvIeLWDERtCOenCC5V
 l8eCJxtgNRuDBYNOLRsSlDtrllInryqgaAdvsKJPmjvj9eWjeU9Mojgv998WSVIyPMlh+yIJwyr
 YkzG6520d0OoxhZAI6U+pxVZYKUVkMKQ3zSk1zdN42/k5u3zxiG7OaL9aCRV/sF3hWN4/RmFSUS
 OP71CPgBL4jYHcnupNSo3vX81aIUqtdpT59ObgBCYSk/t1auLSGOreL8sA80i9AWGfB7AVnVLJo
 nniVzwX/xL9AZTHelie8h+gI+fed09zNI8BKBJuwlE1wU+Uv+4rmDoGrcoU13V57buWQGfVWdEI
 ZzfjQ/iFF28pYYFVHPg==
X-Proofpoint-ORIG-GUID: KfIILYuwnndXHPV-FVltp7BIlC0cvJUD
X-Proofpoint-GUID: KfIILYuwnndXHPV-FVltp7BIlC0cvJUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190069
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

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKaW5kZXggZDIzNGY5OTRmNDYuLmYx
ZDA1MjlkMGM4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMTA1OSw2ICsxMDU5LDggQEAgc3RhdGljIHZvaWQgZ2Vu
X2NhbGwoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwY19vZmYpCiBzdGF0aWMgdm9pZCBnZW5fY2Fs
bHIoRGlzYXNDb250ZXh0ICpjdHgsIFRDR3YgbmV3X3BjKQogewogICAgIFRDR3YgbHIgPSBnZXRf
cmVzdWx0X2dwcihjdHgsIEhFWF9SRUdfTFIpOworCisgICAgbmV3X3BjID0gZ2VuX3VuYWxpYXNf
Z3ByX3NyYyhuZXdfcGMsIGxyKTsKICAgICB0Y2dfZ2VuX21vdmlfdGwobHIsIGN0eC0+bmV4dF9Q
Qyk7CiAgICAgZ2VuX3dyaXRlX25ld19wY19hZGRyKGN0eCwgbmV3X3BjLCBUQ0dfQ09ORF9BTFdB
WVMsIE5VTEwpOwogfQotLSAKMi4zNC4xCgo=

