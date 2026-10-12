Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C6CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Tn-0001tD-Ij; Mon, 12 Oct 2026 00:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tl-0001sX-0w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tj-00017N-0p
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lQgD328473
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4BErLYNz9A9TotKeXKcsN0vaMV1GYPGrmw6a1LXaprw=; b=CtFq4T0K4+ry3iWA
 wEcPXRmryj4fkPJkLEfaxEzLtVsmlE/0CNO0QAEdgNtKkHgzh5SQx3k2rLR5lWfP
 cyD8r20H88OkwFWcrYXh9RW+F6I3eD2D70m7kh0RsITgygnaqSdNWMDfEcMnrzBq
 AekUPk5Vb+QhF6W7WqODu3rQTiBqKE6LYuy7QY2nmZfWRqMGVm8THBsee5ncX+Os
 zYggf5dI/XIsWZ78wYKVjay53TDVW5HyI82aECjlaaSeCa+L5nsPYQNmq4JkNYk8
 D7oR69er8II8iDOoI5EtkFGWfmGW/O+pzO5EBn+VGv/Jnk4pOmUITc/DDbHMayIh
 YnSv0Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ech94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3199130eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778652; x=1792383452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4BErLYNz9A9TotKeXKcsN0vaMV1GYPGrmw6a1LXaprw=;
 b=Hze9gKxWphrACnkNAM4CyGIT+DOxi2IzNvPaEpetSv1vKRYOnxBwKqsHXBSUvkrA3j
 4IcELYnqWhqJA/y86BzVv/L7/GGHfVT9yn2cHuVlr+hnwiO/gcimViT2XSK0P7pDNxhZ
 4ZvPlT/ADVzIgObP0UzXZZhYBwFfEsrOuBusSraOKC8QQrDfprQErjzjQKEvg8+pHqMN
 tIy4swwIG+WhK4Hp+ayEKiFSzCNJREdvrqxASB837dJ0khp4dKT5vbXCrPiA12C7cZ60
 mdoEqZj70mubETSEKz7jqFUK54Rms0IVmzfVehPi9SKZSX/gZigCINr1Z1TOPnCtA+ie
 N8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778652; x=1792383452;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4BErLYNz9A9TotKeXKcsN0vaMV1GYPGrmw6a1LXaprw=;
 b=uqO7QaASnCg+v7tn/TD3UhecMgsRBVnSKmIrtCgbDLYrPagK3Ktc/XwQvgHVDL9KP1
 iVOPyPr5kBBX84ePBZxEa/+EzPG6N96HMO3bi4WNfrufpnb/OpPjXsUQRYLewJGuZrbj
 AYPztTVRiL/2+jnTpI86KjLGZ6z0/sZ2A7MaQOjGTArUzHp/1TvugiBdf0xuVpGsuwqT
 fqA99xdUTOtXUk5K80g+vYrsFRj+5TN9aXFHYqId946M6mOe3OxI/Lq/2MEKYw1Dd4eV
 lNOPKQCnQ9T1+QTJYQ6SURlO2/KUWilCIFEzhyXyuj/hz8DC6Hk6KWhKPr+XrWmOvFci
 9mGw==
X-Gm-Message-State: AFq9FYJhpCbJBQWxbEPS6mT4lfNOkfFNTKPC7O+G2ynwRGI3ugpl4MQG
 Q74wKENrQr3rszSOcj91OFRNVZthkI7J2CIAC/xgxUt5F8AXFZZI9f3rlA1e3vdaqd7Enravx3w
 O13qXQ4mV572R19PIezNHM2P8OUmrtHDRLm3vsv9FqFxPlRRDgPP5HGf9945SHO+UlA==
X-Gm-Gg: AYBFou2oGSuNdmmxuBBhVHEI8uAaVWSQJFTAB4BCWk6rfeWQinJ11vjDom7Yv/cp1Jd
 7MyHc/03v3S0nFJym9OHpjXRrKhyspV7yRotw0kZNzYH5ahA8+GOClWsbiGoZGph3twD2QIwyCi
 264Ckxz4Gjcamgyt9zDc6CeVXJCN9+LsGClI3ji3PsdjAU3FnVjrVG0nQfaDwQuk1vuOCql1xbS
 I2kb6lruRfGlsMMro7HKBS9GkazvpAVQISPPgNHtXKPDNQjITmq5e0bi4t1Ope7D6INmvxeth/z
 iM+wV8RpTkBUSoVCZ3vVp6RPfEagqB5NksLJ5QU0AuJxpaH+LPmjiCvYkN7LRTpNg0ZsBHP3zHS
 HUf+JMGZcHPx2KkbGqzqmNiDQ+YjsayvK5SHHkO1DsWFpIKI=
X-Received: by 2002:a05:7300:bc9a:b0:346:7c2c:1d25 with SMTP id
 5a478bee46e88-3537e27b99dmr18451026eec.41.1791778652508; 
 Sun, 11 Oct 2026 21:17:32 -0700 (PDT)
X-Received: by 2002:a05:7300:bc9a:b0:346:7c2c:1d25 with SMTP id
 5a478bee46e88-3537e27b99dmr18450978eec.41.1791778651834; 
 Sun, 11 Oct 2026 21:17:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/25] tests/functional/hexagon: add bestwait systest
Date: Sun, 11 Oct 2026 21:17:01 -0700
Message-Id: <20261012041722.1159355-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX+q/UgSRALGCz
 Mdg11d/+XC1Rduo+3HlpfcUjXfzYzRRNRBA/vwW17mQwOATdtY0WIynkq1bej1kiUSvYthU06yu
 1jtyIxe3+/HUe8z8kgLPmacwDyNIdIRBVYUBEu7n8O5nLIDtIAyrYnHzOpDO1goYi4qTJjBtovP
 w9ZqkUoEXWhNchLKlR2x+clqoL8S/4WGIFvoTA58mS1C5+ZTwDbQipbpy16aIal5R6XlENVRfoV
 yOtGWvrEGf2jRDd+L/eZ9TRpOHDAWTIG+NlRavihc+0azXvQkh6tUMi1gBzvjVnfywygPM+iZFi
 YbpRERRIvIFPt9sago0EkvMVEWjeMWosjLjDPX3/Jlqh6fkJY6e/5tpA2kSG6uatj0myYfsMoBw
 aeFgZ3fu6VfLtwNrD1/CzDlpOcwD1AMlo5Q6FVrPQ+t1ZR+rPg5KLx6xMcpBXnRiXLd+S2Rs3c2
 0IA8u6Xi0fUcx5sMOfw==
X-Proofpoint-ORIG-GUID: F_aDLSaRUsuxCC2fFjL7Hel2UIrx3L7k
X-Proofpoint-GUID: F_aDLSaRUsuxCC2fFjL7Hel2UIrx3L7k
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc5f5d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=L6WagNYi_-3FiElUOsoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX40iXdhiyYw10
 OSthSv1iE8nZR8GFKbEBsDpFzxT+s7bFTB332DdD1MWECCGiMAYCj5v1y/IPp2agjUQ81WPAyP7
 GUq0O7GxWYjTqRTtEfxh5wJ7n9kmo+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QWNrZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8IDMgKysr
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFn
b24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCBjODEzN2E3MTcxMy4uMjBjNThmODRmNjcgMTAwNzU1
Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC05Myw2ICs5Myw5IEBA
IGRlZiB0ZXN0X3NlbWlob3N0KHNlbGYpOgogICAgIGRlZiB0ZXN0X2R0Z19pbnRlcnJ1cHQoc2Vs
Zik6CiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiZHRnX2ludGVycnVwdCIpCiAKKyAgICBk
ZWYgdGVzdF9iZXN0d2FpdChzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJiZXN0
d2FpdCIpCisKICAgICBkZWYgdGVzdF9tbXVfbXVsdGlfdGxiKHNlbGYpOgogICAgICAgICBzZWxm
LnJ1bl9leGl0X3plcm8oIm1tdV9tdWx0aV90bGIiKQogCi0tIAoyLjM0LjEKCg==

