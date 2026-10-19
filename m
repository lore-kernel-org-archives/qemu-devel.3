Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A0606C174
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GCQIBpVZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HI+JJz2T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpPD-00048H-KY; Mon, 19 Oct 2026 11:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPC-00047u-As
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPA-0004jd-Bq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPMF32816667
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MEetPehIFJIVQGjP9NmNvI
 LiFhebbzmcaJluPmoOKVA=; b=GCQIBpVZJqnLBuOc3HyyrPPAipffx8lDAKWh8q
 BAH2We+qKt0Riri+prjO8OSfZKHUBeMhySY3dzE7YGWLncr4W7QeFIai/SuGZi2P
 gpX1DjQz2xjkY7zFij5qqcZKSYdJvfZyTblQTGKvoDaU0OXBbV43yL7DvJ8mEiyH
 DexoxzsHCu8STKQfcWgWbiyGSw0yRR6aVmxFNO3QUJjTl/BunKkz8xOzeqXUuILI
 bwqa+Hef5Hzw7zMmHivNVAJMQ8pdH/jenDDmWglJKMIyR9hfBvFFoaAKgasowo2W
 Nnukf1B5WE7vr2IZHaJreLiDb44hRdCG3ECcxAPdnNN+mocg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfgrh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:01 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-186c1aae818so2644227c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792424160; x=1793028960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MEetPehIFJIVQGjP9NmNvILiFhebbzmcaJluPmoOKVA=;
 b=HI+JJz2TuPO6ooA9sX1OALUAXywnUifd2iIgAbt6e6vVN9Him4ZLFSRytJ7E2R8MzO
 +tTDTP1MFSCTDEvREhFSujWwNxeoqyFPmcXxGRg2ozq3pykXYIrRgP1bSm6noRyeI0pA
 38/GbtsPT167F2nD6n+Zm4XQ8TsqpWRyvxwQncrgNAjY96KvQahU05olw+1iBfgyL26e
 gfPULhHafyLD3Uxxl5VzKDfVfaSrauO0keBpzoypxOSreuGDbh5lXZ2nCqzjgxlfAVdF
 SKLOZ5qH/+w0C04Abeb2uZMCVtz0MfzZstxby9dqAKHKNv194d2G0xlytdr2vh51Tg/Z
 meGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424160; x=1793028960;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MEetPehIFJIVQGjP9NmNvILiFhebbzmcaJluPmoOKVA=;
 b=I94gwkNaSdhdCbUuYHRzUAP8LvCS79XyySU1xF3jGR7AyvqGKUKLdNwMebNZYPQgvl
 x1XWIAq5Vrpv1mRvYrPnS79yMN2fD5JXBcn4i8WI6Nh11EVQCnfz3qY5kZHLfBaGM4pM
 yhSHak+MNCehH1sAIYNuChLXsnH+gGc1y344s7YwI8SZsNCfwtrJGw2CuRGmTAgrLzIa
 3APaU7TWwedPXCJjt3lpohzvO8uWEuAy1S/vuv24fJmeiXowIha0hp6FRNO382IY5TLA
 xKNaYQcCK3EryiKfyW9gmo1QAS1SsmGM5zqkDPb+lqIW0UwPjdxJgIOPM6t3pdiepXRy
 oTqA==
X-Gm-Message-State: AFq9FYIcynO2QatMYW3fXdbh48tRqt1l0ftNeORzRNiJuJRiroYxsZHz
 muaFKI1Yw+skU/gDMIXmAtsIHMKjkSImcyb3Q1BrACv43AE5MR6TS2l0EFdUSLe7ZUbplc4+aex
 Ll9p8wBF376ZsJwMDvtvK+h1KZA76Gv1Z8Nt5P6fqHZig2LwtSj54WFbz/fzVnPnh8g==
X-Gm-Gg: AYBFou1Q/KS41Wckebt2P3AQmC3iuq2MasfPyvz/2jsS6yvBX3uS6Z1WZcjzjGQlOK+
 Q8oOW2fQ/Kh6TRqu4qXXKT5bYFasJqwJEWsW4Mpu4YGciREP06InPj+Gf6P/RneM1KiTd6wADfR
 LKwRP8sDR6IUS9oFetanwrOJH9Ldz+tm3LzltGpkDWcIEy+ADCcgdHxp4vN86b4TQe2yN7v67Hg
 Jw7o7edJkeZqfXpOkqyceRFE0VzBY9W3TN4ktV8wRyLZtrrQRL3jMxI+3zH84fCVpr1mgwL0Zxd
 2+twimzWGyE201wfO/aYCfv8vWRsFUEGOeNoYkafCov4D6m0fycrodQ7aze6NBrmICj+exrLDnk
 pUSpVJ6Trm8WhVNuDrksCemErGYWX3CEVKl5gYD5yFtU05KU=
X-Received: by 2002:a05:701b:4346:b0:151:2e62:fe5b with SMTP id
 a92af1059eb24-18512b42d3cmr12186341c88.22.1792424160231; 
 Mon, 19 Oct 2026 08:36:00 -0700 (PDT)
X-Received: by 2002:a05:701b:4346:b0:151:2e62:fe5b with SMTP id
 a92af1059eb24-18512b42d3cmr12186306c88.22.1792424159617; 
 Mon, 19 Oct 2026 08:35:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm33595924c88.4.2026.10.19.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:35:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] Hexagon: Fix undefined behavior bugs
Date: Mon, 19 Oct 2026 08:35:56 -0700
Message-Id: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: K2vEAcZwSL2B7P5lsOKXuE21nyL_w9hA
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad638e1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EjFjVWwXLKCIMEEeru4A:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfX4aKhVo5LR3AC
 5MrzUa8cMH+F9/65Fg3fz8AUfyEh/+7phQ39hnjQMX/V40Un42PAaBNUKfddu6/S2s9NNSzSLoC
 /jhS5kbLJROAjFt740MthgTM5yoUZOBpEt308J2/JEELCjO9UiOAI9cwaAOkSdfswe8YUx1Ao+m
 AdX9TVud3rVmg93TObWOZaQDgH414Eg+8YdIn8tAoF/LUkOUXqqhUmso3WvjGKb6l/75J4z5pHc
 aKqd0uGTNErMYcV2W/sylWadnIkoICafaU1t96OcL7S0AW3aekYfpvjy+3E6+G32d4Ed6g6IChE
 tPrej9oX5SaQBEpEJqpS8T9G6m+NSLImb8GHhveTMLl8eNgNsftSVAQ3j9cQ18QCi69AjLHAM5t
 vPP1aH897scxGUyqOXVaySqIWCD0/VD1bwHrNw+s7aDXC8FBi9lL3JaE4L8lGqbZWKlbcB41Zop
 7uSiuRZENH700+0UGqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfXzN4YpsoXpsBW
 WLvp465lEfzWJO+VzShqkWzaoWMPN1ZNDB80sg4EojwjP1s9uv4qezQq0iVcuW1+YlFN3OkgYDI
 Hy2Q7mxkmUtzQ+Ueg3Tpu3x5dQDGirk=
X-Proofpoint-ORIG-GUID: K2vEAcZwSL2B7P5lsOKXuE21nyL_w9hA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190062
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Q292ZXJpdHkgcmVwb3J0ZWQgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIGlzc3VlIGFuZCBVQlNhbiBz
aG93ZWQgYW5vdGhlcgppc3N1ZSB3aXRoIFVCLgoKQnJpYW4gQ2FpbiAoMik6CiAgdGFyZ2V0L2hl
eGFnb246IGFzc2VydCBxZmxvYXQgc2hpZnQKICB0YXJnZXQvaGV4YWdvbjogcmVzZXQgaW1wbGlj
aXQgVVNSIHdyaXRlIHN0YXRlCgogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIHwg
NSArKysrKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgIHwgMSArCiAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKLS0gCjIuMzQuMQoK

