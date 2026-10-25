Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D91606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h//0/+tX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XeA7g08D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosH-0001Lp-5D; Sat, 24 Oct 2026 23:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorA-0008Rd-Mv
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor3-0001XF-4s
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P165c52207233
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=; b=h//0/+tXuHbKVSiV
 2+yGKAMxuIkqgNuSUvBgOKW/UYx/+eQpENle6ZJKO9hFVRn4XuGGP5mqh973WKSN
 kAR1hvwUNZ/Df3GD7rIqcfmvgyqnW92HcgLr0Kzo7UMmJZ15ix4G20EL298br1Yl
 WQoR2GmFHAdoRolIZyuXmDiiCHz9k56KDKI5TkmrdRErsCrX8a+L6LJ4iUnCTuFK
 Gv3eym4KbUfjRBlRE0BvuO9oLNs7m9JiJ5bRq93mi5LTUeuvmuTzNEdT0CfkQ1VO
 RiRptNTTAyNcOZrvYR3m1YgA9HTc3wlEz6bFsjesigd3BCBYOv+MgALMj7VlZ/6e
 byJ+zg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9t5xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so5813727eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898693; x=1793503493; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=XeA7g08DHudY6Om5Snj4bg/4z903GcVciO9wLwq8Mf8XxXVFw6BDSdNja+7fR4oKXD
 PsJKZIOhAw6P2OwkX4eF/qL8do1B5zfYb2Bj07biCt1qHVjqsXPcu2gor1A+J9lcbXbs
 38evEhyl0yJ/aXTCCuWk0dwXRBgY1rklti6fxk64gHC0Ms7A98HO1cnAzwGm3jeXpquk
 b99p+6iLVodH43uTiUYdYGnZk5LiiqI3oZqa849/A3YoCmDDyzotgUEdnSM1wBW7+Dgh
 GZS53CbcGTcq2ixEnJGLczIs27Td0XVlFd04/5/fUkeoi7udCIpQWEcWlqad40/T2sTg
 DrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898693; x=1793503493;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=VnjFm7+iEl0uMV3BkpP+xzS2aqV5VLkcyk11K025NPUmccRr1qVr6BtM2DCS7xrLuW
 S5+FFJ43cKyF39N5Bm00jKHGeZV4mMu+igZU4ufKR1fQW2SzkM+Z81CkQR1tXdKGxx16
 t7Y+Y1NH3OfhA5ldc/3+9JVy3fiBLtoZR+3s5gt6xbocU8JIQC1YFDpvUwF5dSZo4POt
 w/6M8VxDtshl+x6Ap4iIQPyXK0bHKrNv2v06TbAwB/pAE/XsqgvDWnkl8jNzWjP+hAT8
 ts9d8lMCHC2vS1m3RaZULcwdDrmcQtDNXMXbPp+5YqnGHrGqQcpACMlvOpb7UbVlGxIO
 5E+g==
X-Gm-Message-State: AFq9FYJevNYtaNmCEjJDAbcVb05ELMVkMV4rVy8rkDhyDul2eTask0c7
 uqwvpD42eR1QyFEsHf5mOw/L3WNb3tcPuKCnZg4T3A+V21TC5MEBauV+zDlwP4rThp2eXJDvHL1
 U1iKdgDUGrGohqzqNLc8uAb2bD+kDjPeAs75DUAd6PlJfOFurV1cWFB39Mn/bR7gssg==
X-Gm-Gg: AYBFou1KfTFML0u2f9Guzc2DvNCPqsQo1TjVv7uHCxtN/WtamHwmIufJvM4M0wmZZ4J
 21uxeIuxRo9bpu3JTjjtfdDBl0y1Z9ztEVWD/Rj4J5T7Wj3GcP4xQwj2wP9tk1Lqn1dOm1kXzEP
 YCJcp2/FBSCiu3dCnAgpYYxFFUgNKDhUMknrNelR/xTpOUqlm8sEN/vi2YROyHqNUknWJputzjv
 WwAoC6Og8WoAl1zgXL8y0h78Bf0pygBhB/8o9/JOQn89rQcWo+8Mly5qyLkLbC4Hy+5H1E+7hBA
 U2YEWQ9PQK6Vs7TeIovhREa/mljZhGuS3+o0adGFZh0uOnq2fhR6sh5hbNPEgYU1TaFUSBWlEai
 X/Vm2AwLUwa1Zt7UwkomRVQ08jpcTZal+D+K9nHrpGzj4Qas=
X-Received: by 2002:a05:701b:42c6:20b0:166:9e0d:3b50 with SMTP id
 a92af1059eb24-19937da2744mr4876205c88.42.1792898693015; 
 Sat, 24 Oct 2026 20:24:53 -0700 (PDT)
X-Received: by 2002:a05:701b:42c6:20b0:166:9e0d:3b50 with SMTP id
 a92af1059eb24-19937da2744mr4876179c88.42.1792898692451; 
 Sat, 24 Oct 2026 20:24:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 33/40] target/hexagon: drop a pending HALT when resuming
Date: Sat, 24 Oct 2026 20:23:39 -0700
Message-Id: <20261025032346.2917451-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: rmvRVfsTbYSe2Une3htsdKaPu-5Slpzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXzr5ACgF15hca
 A7TJ6fG7trIPlJWQXLlbB/vI7o6fRKSjB5pP2Cx3IW22iEVagabs24Cvxitelx415/CtUWROjvj
 199QnHv/7tgnTGxuqg3SdMyHVrypOrsGpcPXp+Zqh4neceOut7xZ+CLytacR2Ot2MAME0CDA18E
 4vapiyZaAuNgCSqI29+bawE8aCavs20/80O1iFBf06Z67w/aGnkvSZc5Te7xLQeTP4ERweusoqP
 sGqVHxmtxgSMYMII6p2eXh4Q5UVug2tMLY9inXWhaOJU+ZfFeghYc01JCIozCNmUrWqfQ9QgSiC
 hJliV0ORrNDyZDcZUPW4ydPnTvxWDOvaFKu0CeFtPPgOu7c/zn5Wsf+dy8znBC0iUo1LkNe8DAv
 /MAFTM4G1mE/DllsJWQkEQgvp91RxEs7oxW1L+G7UHtIjfDKb6EZv53MeyQ5oRC71ZPoNZoAdPT
 xFazZDVpQRNsR1caUBw==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6add7685 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: rmvRVfsTbYSe2Une3htsdKaPu-5Slpzf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX5pwEXGm9jqCF
 NYHOyYiksRUgOZGFa7FlwUL6lqH+4XfhcwBeSNGMMXjhBv3BCwCFLmdZvusE4C1qULVxqHngD5g
 hNYlMxYyWidHR2qmtJL/b7/YU/NEWWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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

