Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D2606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UeRgXhq/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=csIxuh0U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mV-0004xt-Qt; Thu, 22 Oct 2026 19:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mR-0004wx-QZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mP-00020H-OQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF0vC048204
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=; b=UeRgXhq/dS0jRfKO
 BeEnuCeASzU45W5btmDMEXZHVhIYpcmSPCOmpvHwbJijdkbgbjGERMIBGnSE72u6
 rBOwqocY3+4JuA5tk8nxvq3QmskPsrgZUsu3OUgHhcn4eRo71PUVlTYKuH+oHjDD
 W+KWarSF2sltyHpGkaZ0IN9nyZEbxSrGRfRKDIfZIeHDgvfFA/wPe8YuyMIaPEOx
 rDJawRSV1HIjqaoxE1z15xp7FVUatCxnzXt37H1sEb//09BRmqFyy1OEX+Kto3aB
 v961kR6/4JCBx+5rBpL233zrzvkOKOhCG/+7ubz9NVBqlqb8pl9tEfVDatfQr/9l
 901kUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0w58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3698bd5392cso218533eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710060; x=1793314860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=csIxuh0UhyNtAn4+CIQl8oyBoDx4670/G/L2jd4FIofBI6aHLUNrL2Ba/rEBE8K3XW
 YZftqH3ZPUEbs2zl1CeOmwc4u1cbFgjQ+KZnQYydjBUJx3Di4pxjkikU2Uq2RHWNO9AF
 EF/PHosjl63FBKwhaOgkX8EbQk0nqcXkWrDYB/w097kBWzpNYqWnY45nuwLAK1cxoo2D
 6D0+5UEGm63jFUaW2ajGfpibcIThsZiHU+GbWYn97pwGtHKoYEd6MJZc5NeETy4ca34Y
 PGyLrdLAtqPjjMahu2OPAZ1NCbd6yenbBM4w/6vNzlAWt1iylLOS021Y2V3XnaW6QU57
 tXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710060; x=1793314860;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=h+znstRzCGQJzSpWT3MLi9f4SCfPMjnHk6arn6qG8rb/En/nhwDd729vMAde9PLISM
 IAkco9zWpfYL3hKyE2GSGGca6tPLHc+1c/9R1sNzAlezhM3e6QrVseyvyDOMEOTCBtvZ
 dUuqZSPph0jaTn9abNH1f8meas+7f3XY7lPQ3jeBWgLpn+z+mz1rgpxM7IonVX5JW2zA
 WuiF0mJ6gd5YsDy7rwAKycYHMYPR/DYKD/swwrLAXtl6ItgS6LIptckMX8SkzxxbBwAC
 dfnY5pfZ16az7D/pSyRLnyh03862msyeS51UsczbwAaxypLPrKUyCQjFsFDFAAPrnFKf
 bN5Q==
X-Gm-Message-State: AFq9FYJnpY0IXBicpasnp8HqlN31S2QbGop78P9O3kigGbZZl59SmvDf
 QxmOMUKfdQDLkInQmwgoGps1cyBA3nBOecSBIPd96ethxAOncld8QtPYf7W8M+u81bdsA13rTRq
 WrNNM5eF2OQ54TZ8Gg2xs1kAexF9dyFVsNa4NPg1gow6W7Ruze6I070DxhYjajVnKxQ==
X-Gm-Gg: AYBFou1mN2d8BEwlL+1tG1jAfigTh4PPtMejnw2Uot7Ao+7xQMd1Wu2YUxV32JJZBqp
 hnT/aZDH/xHBkkss2tBNPTr83PSF3GfKCeCgH+3WEC8ss3FTc/d5XSIIrYI8HCtdss7HVI6xrvy
 e3KW6G0uOi7qbo/AD/TqZzLB+pcs+CPBWEDueLOg8ilUKKhYilmqEJqhB4/hp+pJ8UQXPpkoDsr
 22MxuA1tvHCyKCZ+mDH7TgPtWbPDYyDLNpkB9Me/7tn14fNgsFFWM+jDDqH1K0np2mQrvbI2Fu8
 +7dCpkZSIyK5bbr7WIuyuJSA/EnCSj6cph/aKUIz15Ge5KCyoiP1RQrIt/ReJihenGjeknohs/9
 XOzgP2I59SeYml2Cz+lUL2wf/WHCMQnOZOueqBdmSIlUSJ9dq
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id
 5a478bee46e88-368b122ff22mr4180405eec.25.1792710059368; 
 Thu, 22 Oct 2026 16:00:59 -0700 (PDT)
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id
 5a478bee46e88-368b122ff22mr4180369eec.25.1792710058597; 
 Thu, 22 Oct 2026 16:00:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:00:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 03/16] hw/hexagon: let a machine place its DDR
Date: Thu, 22 Oct 2026 16:00:35 -0700
Message-Id: <20261022230048.2160400-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX4ZF6YqLLemHF
 krAq5qE0oDWZY6GQCj3mrKRuRp8pvphBLJLa0zDYK+ct8KdAtM+o8UdsjEza9OkbpH9sWQH4q3S
 AdVXDxyZhX1oIO5kC+mSH8NxPD7LpJ5a99K2wCwPeEGkZ0Bfvj/n94cSxh0uOZoWr0+3PBvIbb1
 i897l8YR6+TCJBznZ6YOxgdOizUd+C15de0ZSOTfU92EOi0xc1z177mOHTRKA8XAHdZfxUR7s/W
 KP5rz0ZNCIp2UBK6ajgoqZLe48cQasIBQU4lXIGP1WoSz3+121cVcl0F/PmsGFr1t43S1KtpSB2
 8yiKJtdovR9WV+dK0hErnec6AmEGOXecjTwNIfTrCaEFdnUWgxAGWDMvPsv6aTNJFbTRjknvkYb
 ND5X0zpPwhv2sgHUW5SSEV0ppeFoa3/5Citl8Cp4f5bm9cqkEy1EJ5iodpNBsfV1hbOYypxuaQX
 bwCRRQbPOB31aDasFfg==
X-Proofpoint-GUID: AfWw0lAohmybY8bIWTZod2CzrrFNDAqm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX8gslZeptTHRX
 JjTxWXkd7csBtw2YIKsmzUKjh8C5cFFkcLEAvJvNrmYB7zAmVc3J/jfLcL6G8iw5I7msgjeIJqh
 wraRqnQ4jADDKrBkJmnjZQ7LVkNSmKk=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada95ac cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: AfWw0lAohmybY8bIWTZod2CzrrFNDAqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220091
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

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4
YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQgKystLQogMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmgKaW5kZXggOWI1ZDMzZmZjM2IuLjY5NTVlNjAwYWVlIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgK
QEAgLTE0NSw2ICsxNDUsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7CiB9OwogCiBz
dHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRyZXNzIG9mIHRo
ZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAgLyogQmFzZSBh
ZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7CiAgICAgLyog
U2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jIGIv
aHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0NWJkMDlmIDEw
MDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhh
Z29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICptYWNoaW5lID0g
TUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5c3RlbV9tZW1v
cnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICovCisgICAgLyog
TWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5yYW0sIE5VTEws
ICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXNtZW0s
IDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVt
LCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWctdGFibGUgUk9N
IGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdpb25faW5pdF9y
b20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIsCi0tIAoyLjM0
LjEKCg==

