Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBC10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRE-0007nP-9w; Wed, 08 Apr 2026 15:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY2M-0005do-Pv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:54:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOo-0005Zd-FF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J6aYR071730
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=FkpLlVy3IOEnpCdk
 KJF+zNk4AeAz55at0BYr3NUdmyq9StrdokcyHQA3zlZZ9n2voG378vLxREl3zlQ0
 5D5Hh0uXJzszQu2fgLa0D9ic+bHeM7OmnIYU6hrAeOE1wXrarzf+9FJi2lHTc8NI
 sb94R1dH7coa1fR59wQNak0Egr5mTzOKq8uPfhJAwcAODToV9ibWOKMY3CrhhAQ1
 VgZL+hFkJqxyPI7lPCADCheScBlQ+CGo8HRvTeY7/M9EZezwWu8dJwqPORwfHvGo
 em1sjPO3ZSTJMlKWzG6E+wx5yjPWv7/4WYoRRZiiOyxiFk+aNuLWa747WV4WOvJN
 18I/IQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7sx9dq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ccc035f125so330196eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622016; x=1776226816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=G2bCcBwwwQfxBYoGCnzaHR/98lt75etYfVQ71M87c1wKxVZAJ4pPGBuD4qMHV7b3nP
 u3UmiGhzlIK3xKQYCNb1qRbRBpRDaxG2194vBAGKx+VmhZ4OA8bdREoRZGvY7do1NsBk
 hGCepnV5pl9sQ5hkj/876r3eZWp/EFZ2tgA8OeTHS0dvPRfHMA93Fe54zX6zlLNf6O7y
 zXwROkps6Jz4e3eM2nB4Xypgqd+JY/vbmwnFVlVaidE63AajVCX/JPsyCGIaCiamIvSg
 fE0ZE162Pa6RkSIkTNHRAyp4MFGZWYrRhRTM+XGsMLJsrW+Ib5SBhi9WOa48jOSfhAhy
 UQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622016; x=1776226816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=qrqdVmcTiCP3cOrHvZw8Z7EhOid3ABGrViJ1CmVEMeXdRl3vOl1fUnzkAqDGqzsn6u
 OLrkGPtw4yom4rmiaIeHh2N3zKo22cNfAIoqBOVadSK27OgvZ8eFdGqXiBffI+phRSha
 0LxHBqKhzf5C4ju8kkZbmVL8qNN9A0ivrXBeKPUkod58XWNiiYIQ7cPHjva4BZfXHWUd
 rO/urxqWXc03nLULdrdZqleEVHR3LX4dvEca6klPbqFP5DcyBnVwcqBt50TmueiZrj5c
 c1pI3EjGQuIqUeZzDTXzB2vTD4XH0UkeviALXgKw1mozD1YsNRZ7mXJhP48R6+M9btch
 RfMQ==
X-Gm-Message-State: AOJu0YxCHXcY06D2AWvPu6S9J+84fxEf5HN1OOLippQNuDx8Eqt2SZEf
 84H5OhTBu4ByjvJ7zuf/v3PgcwnSpBqy1X9O9BOOerU23AQWANhmUUO4+n5ofZ6V3SkUWHJPkvQ
 3fmAAB6GGg7MCzWLyakF63BEOdFK2SaU+Vtg+3+ZEdFlYG7EJ1/G4AoAGQO8oz/LiGQ==
X-Gm-Gg: AeBDieu7EahXiT31TPk625ZOq5UhhDNaGYIv5KKTzf+vsPoPD+zyMp3SwomkLEyMrMF
 mVe2+veZo4xRP55UQlJLGAuFCnNXUfM8ZdI05JY7gR6xAduMMk3YRFiLWKoigrT0w6BGHUX/Si5
 PTqQLxyghjAgotq+fvCbcSSDuPQq0f4YkaYeOM/OHnXiHWLYXQi2efz6/P1HNvNJMjCZM8nzb2m
 Gx5yicu+t/va8BW8qGTP6LI1D8jMaak8x/CJpxIV8v41D4t1lnNu0kKZPmjP+0IDf55x38dbE1Z
 wcbb6uhRVIzUEB+ZlZn2Fu4zaT27OMCZJ+dWTI5Ei+UFJzRrweHbNIyyR05ikG0CA7bcy/dhjzZ
 9YqILhunMnbK9fyYzr3jB+6WLgWoz+fNHOmWxLRv0dmX6EnUlbRovbBn9d8Dnm+yVnOA4vw==
X-Received: by 2002:a05:7022:4588:b0:119:e569:f84d with SMTP id
 a92af1059eb24-12bf0599beamr9448552c88.4.1775622016045; 
 Tue, 07 Apr 2026 21:20:16 -0700 (PDT)
X-Received: by 2002:a05:7022:4588:b0:119:e569:f84d with SMTP id
 a92af1059eb24-12bf0599beamr9448543c88.4.1775622015509; 
 Tue, 07 Apr 2026 21:20:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 07/28] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Tue,  7 Apr 2026 21:19:32 -0700
Message-Id: <20260408041953.1899532-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=etfvCIpX c=1 sm=1 tr=0 ts=69d5d781 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Cf9Nk-S3kYd6tEVVOxaS98BFBSJzBE1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfX9abxyOl+tC88
 Tibw/6TCta3xQlRiyoGFjelcaVybddeqQaoPB4JJcpPXzbGOzZ+NvcRXPMYNVH4A2ZKym+pO2QP
 bzzSKg4X3K+UY3Mdn+OGp5pbD8bfAPBOX6K987POYU8v0ryXdY1QbkE3pngFGdiuzzyWAgAxQEF
 22zv/q9ApJLDnmJDStz06ZkTIAZY+kUxIl4KlSAiZEVHb6eNKH72n6QT9iPlokJNijnn7jXCLWu
 a9MwC5/0D00Kb19AsjWyJ/wIybV+1s25CbYxl1k4xVasGRSZOcJv3Ydkh4ti56i7fmTo7PW9Rx4
 ZDpEiEusZprvGngo7Ta/ty+fkm3iMD+9pjMDPqo8D2SsoMmAg95UKRJl4BCLiL5LIoVMjNDOAOG
 XEFiJKiyvYTodLkid/S+Yz0vGdDJ7L50IYZwks8h+Lao7YIh/YsGUS5TH9YKU2mTnbW2TqoAPRj
 LpXcEucLTCBVP/2HWNQ==
X-Proofpoint-GUID: Cf9Nk-S3kYd6tEVVOxaS98BFBSJzBE1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

