Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB92606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoSuhIQE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KEN/JZAR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXug-0005jr-DC; Mon, 26 Oct 2026 23:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtr-0004Ag-Gz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtp-0000Cw-Ql
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F5TW1421286
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=; b=eoSuhIQEKVU9Whmr
 BLkmj7s5KEQrJQuwWBM4O7honpjTl3bZTq7tiCNf8PsmLymvEy9CtZFPe4Lgo8i6
 XwmLynMzUpX0tyRk8rn9oJDHyKgVdK9bdazYpXp+g/aNc5kgNt2UDXTNJda0MfOs
 NED3LtfHWyzavL+OxXGft//3g/DD1lTlINqDGTgVLsq1HzpSduT1VXaH0tYnw1HJ
 2xr0ioLoRCEiy5dBtHiVJ3e7WGl+/qeUH+yaIzk//H6GbN1Hjb8YM3H1iZoIw2MC
 yOvSbIlZ3WO4NZCY8H5UbivNAOyHcOyiEEG/BnShH8LvIMvFs9sQBy8R+HrrvkaN
 vHktBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf3j1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36637676140so6032531eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071846; x=1793676646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=KEN/JZARrOkW7PNpGHWtV61b3ikqnxxfdF8Zm8O/vR/QhBM4PYoh/vWOsQwH/cpJwm
 I8oCBin6uQ7LoO96e7GPQrFcpEGIFgtvBv+nJugejHH6opXpVUbXrZo5yhOSKwt3KWBA
 WCGQsrxHk8w+wCa72xNgCSeVng26hv6Gdt71gEGew8IJXDIoaj7O3fDcg4oQ+Dwlm+Uq
 GxBBv33rfIsbyXULQ3/EHaiz7k4z8kQMiJbeLaTlgyQ2/0UN6ZvgWqjMAwrSdCGEH8Z5
 /MobF78qtTd3qhRBHwhEF9FrxA9D4MHnJDXT/vupDjyjJmIC/67seHsgcWRuA7UfBdeR
 PvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071846; x=1793676646;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=uM0MWiOseREoLYGY8XubxbO0ceKc2KEjpB99DDt3EVwsK5lO8WFS6mxGrgOsZXw7M3
 x5m7ZPGiRHe88gXUXIlIuqOilmccPANFUiZZdSzK8b30HKeyIX8V5wkhNonp8/INrlov
 ptNaXIUjOF0Fy7+yYOe+nK95PHHGP+nQamTWjyxSxbowCIO1/k1yGh7isFQGt2Z6S6pU
 ldTrNNDZSFhyxqyRXjTZW38Aooull1uLSjSJU0NAyp+KJIvDzWccPKHtmAv0eiC+1QQs
 1gIEbSv1LdP3WGGCotMjmMHzUBxVc6mBZ418hVzYwZuSMSd1hNsWPfLheFT1H/cnWLrf
 Xg0w==
X-Gm-Message-State: AFq9FYLEOMjokGG25OuZl8lPtT/f6n/uEvJm8q6tyHWuNJa67VcS5SwZ
 qq9SZrIb43m2JC9SXh2cfDR9tbLvjmM8hleHCbjHG+x6AthFveEDpXbFddSs5Se78UyXM/qpxI0
 IWoiBriUTLdHX30iw0BlHhhKMQuC0b4X9slk2g4XYQMupTXsvk0WDve7qO/xL/9bJ2g==
X-Gm-Gg: AYBFou3WWvYGQ+E4N6xmEIerTuAog8Ks8nspb0hEgx952jglRwBRtpettvMF4xmEO38
 Ds/mJVW5OfpuhTDXLWNOijE02GW4101YE6ZTyn8Lw3npTIjhXlK4CYEsCNfF3zIa1yDgcZC6AXK
 dbZPNTMOH7PC9hQ/+/Y3z2VKUQcvUzlKwW//4wbmsa1wVVg3ua62PvYugTfiFH5Tnc2K/JLarAs
 5Gxov8zUU7tPoekbt5opKqYXfzs921cHCLo/WCJYaEpXZ383Psv6qJNrMg+iGG/Rkb7t3G9yi14
 KOhuiUC1YsUexTuCGUGwKvLtNJbf7w1Ijw5hjUL9IRC+IDIw6/GNade4gW6KCQ99FAlJvCpkaQh
 Ycsir8i1mBlWIKFuTz5d8Wifosv/ru9a9cEF6TzafLH4QC5k=
X-Received: by 2002:a05:7022:4585:b0:185:8c9f:de82 with SMTP id
 a92af1059eb24-1993639e220mr16837870c88.33.1793071845651; 
 Mon, 26 Oct 2026 20:30:45 -0700 (PDT)
X-Received: by 2002:a05:7022:4585:b0:185:8c9f:de82 with SMTP id
 a92af1059eb24-1993639e220mr16837826c88.33.1793071845127; 
 Mon, 26 Oct 2026 20:30:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 34/41] target/hexagon: drop a pending HALT when resuming
Date: Mon, 26 Oct 2026 20:29:20 -0700
Message-Id: <20261027032927.3055166-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX+NQySDqLecVx
 wv7gh6FbLAnEPwoD6Ihf9IQeV5TB6wsXYj0d63s7mHL61ZAJF4F+sZym7HrpkDUh9X3GTXISh4Y
 PosdneOxgqnBldXcv9HBfFNxQNaMYN4=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae01ae6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: n810w0KBKutvWFkGPP1FamlL0W0xoGrB
X-Proofpoint-ORIG-GUID: n810w0KBKutvWFkGPP1FamlL0W0xoGrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX6hpPfrRBPQ7x
 T/mETvKVLuTKO7I2nk2xWAAjBAuw9/FWO9NRq/2ylpxROHwQ82qowvobuS52ER9CdZQ68Wa0/WB
 91bpPwdjDYlaPvZFb/PxPU0rLkmdgzpuhQ3DDehy9Pi4kp096Ko+ZWzERgPFwherJPdPnVoltwn
 IV0X+MNVP4a7JuwcYK4UJAtc+Z1MkuY5ueSOCg6/eGHpGsY/5E/KBuGvA1WdbJxS8EzFrPju5Wu
 AH/TJnJej1z45jrhsf4u6Lv37IAuuWPWHjZA8GTdeDI5vh2daYw1WWmwn/aEXXXI8UmVEDYTDAA
 rwnE5B2nS6AQRNWb7ZmM9p/ujTdtJOD1ukuEo5kqG/Kf/Vok2fRRABFbqzjJbVyp/jIpiR0Xbj6
 gEwNulY1vKp/Gv5CnPI1lH5p3IPDumf2OiH5qCZFq+Qeiq87DeA6/O0jMV78io+xDv7JYOGAZtF
 K2KjnVNWo9QcJhSUjEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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
cGVyLmMKaW5kZXggYzY2YWQ4ODEwOGQuLjkxOWZjYmM3Yzk3IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBA
IC05OCw2ICs5OCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fcmVzdW1lX3RocmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudikKICAgICBjbGVhcl93YWl0X21vZGUoZW52KTsKICAgICBjcyA9IGVudl9j
cHUoZW52KTsKICAgICBBU1NFUlRfRElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgY3MtPmV4Y2Vw
dGlvbl9pbmRleCk7CisgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9I
QUxUKTsKICAgICBjcy0+aGFsdGVkID0gZmFsc2U7CiAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9
IEhFWF9FVkVOVF9OT05FOwogICAgIHFlbXVfY3B1X2tpY2soY3MpOwotLSAKMi4zNC4xCgo=

