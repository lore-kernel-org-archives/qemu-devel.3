Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB4ACCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYr-0004g5-PD; Mon, 19 Oct 2026 02:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYp-0004ft-VW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYn-0002kS-AM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j2ZR862400
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFA36/v4DrafNzrBSOePw4itVs2yqEZtlJp2R+aYC54=; b=mNf8FAUjj6pXI6yH
 cXlk38+jiDhfOxqgA4WpmNc4kY4Z7BroZALcxPmYI4G14BD8zfsohnxz65cHVS9U
 fxPTF2JeMXE9JhXCDBPObDA05vGR26N2noeFKXP4n0JSes2DKcVDDd6DQWPuM6rM
 C5yDCJxi/fTK9oB76zcIXVtdfYVnl+9VaR2vyGEExySuJDu3TK6Jn0Ki8SrkKS9R
 WqYpAb8pUZT7OMFOGo/O4x7cz/L/2tl+5GCSp0VHt4uasciwpcYafBb3XSdf1Ds1
 sXTHjDga390bddNfoAqaPkygJjKEuxClMiQF6fm1kVoYqw50VqYvmH2faXkGsXZQ
 SB0WpQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9my2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so3108887eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390163; x=1792994963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HFA36/v4DrafNzrBSOePw4itVs2yqEZtlJp2R+aYC54=;
 b=bRkkBlb9RAvF4a6vAX0jf3qxFi/DKTNyEOu/b4bqGTCcnCxqLOwhnoDQpho2oW/BjN
 0M9xQWk7y8NL9GhnAxU52EOORXaiNnh+5/Kg948bSTHD1DcGTeJaLovOmbiuv07Xv7xV
 Y4ytXFrnSraLgWfkXRfYwVPUHwSpwg5kJcppgb81Nl2g3sEviXN6tth/feRcqKGKL8uV
 E5bp/qwLaWncFhLzgbgv/cO2rc4Bcdbsf1Ooyp0dT63oaE0deKU+/RQlXy+HRjENgwfg
 I8Jg00nLbgec8niZOMceT06CWcyuZ3UamiQJ86djwbSxBcNZNGQHmUhNc8RlJ6rv03Bz
 BIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390163; x=1792994963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HFA36/v4DrafNzrBSOePw4itVs2yqEZtlJp2R+aYC54=;
 b=fbHmGZ1TK6cWrLB0MONTHi3tK1XuqrXQk5rrOnT7EIWCR/4YLzSIqgSBWsxFq89H9k
 ojc8uMUMd29/un4Hz1HC7zjoENM6+lpj86ieQ2VyzxNESwZSxaondUgSv7JDQWbtByFr
 5oOTS/lojkWfhWPjlALk+J/iz2Ou2wVOxU0pmRzTGRZw542fNUVoFGigk+vRP6DwlJnQ
 eqo6KNSoTXa11hwiP4HxZHu3PsR629lCv+XwTlzQ8dXCX15FwaKTbEh6Yt24oVSWypQJ
 B4Q/faF2OslEwDP/FW7ejmWIS2UfVEiG8mRgKJkJcDE0vNHFXGsiim+b4AZCMJX9x8Uv
 m2MA==
X-Gm-Message-State: AFq9FYKeBeKP/LZ60TeNTjv6XMWuNMuqbQf+w1fxGgIjTxX9L3N5tP2L
 HI4jJw2YnN8YDcjXZdyS3RrcZANNzfCm7JYS/oQv9lAPu68eiIuqdKn9UVTF2w64TChgSpG1iGy
 zWaXvsadpQ/HmMP3IEBxsUXgMZX0ykAevewnwUue4qnDNRuI/6RSAZEPUK/yLl77pOA==
X-Gm-Gg: AYBFou1+fm01T6zbqRpVuULk7WO7wue4zpLPdDQksh4aeGhqA+crnlwn3PzdLgNoiAF
 GUKboa8Ut8cmqfFCAh+0cxZYQOSbh8mGQFsvVPpbU0Z0aSz2oWdxHtmL/68ex61yGW6i4nZ1nuy
 KvC0Y+SBriLHDyOli4vUkqntwnOieF/Gfpc3AsOu/dmzxp/T7YwxYj0AMcQ9WwoFr+BSMpDkOp1
 7SHRwSiyadOLtrsoPTDx8WgmOQI+lleuaFXDj6/NP7DjJQx22qhKkinEYDGWLX/wdTe9FgEwOQ8
 RxqNwxnpLR3iJzGQFzw+P4/A6dRmsA9271iWZicLSQ5tC74yjJJUZL5AP6ZDjzlgXU31qGFvacP
 NRJAY4XvhNndXmUNz7cAZlxGfkhg29f2MMijeT/thH6chOsk=
X-Received: by 2002:a05:7300:880b:b0:361:7ab9:47b5 with SMTP id
 5a478bee46e88-361a2e393c2mr12249738eec.36.1792390163044; 
 Sun, 18 Oct 2026 23:09:23 -0700 (PDT)
X-Received: by 2002:a05:7300:880b:b0:361:7ab9:47b5 with SMTP id
 5a478bee46e88-361a2e393c2mr12249681eec.36.1792390162245; 
 Sun, 18 Oct 2026 23:09:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 5/5] target/hexagon: enable MTTCG for system emulation
Date: Sun, 18 Oct 2026 23:09:11 -0700
Message-Id: <20261019060911.1479329-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX5IcNLwdZVi0I
 lO1yh/Kklsp9ygVvY0Qt3wg32C6iXaFUvwUCFn0T26d5BHIgzh1jPoGWA702AJaOrhdpq7JaYDo
 eZcaw71QmmrQQvZzh/eciMiWxXh63H4=
X-Proofpoint-GUID: OCJ7yT03xRfG1ppfvAJpyEGPgPW6c7vi
X-Proofpoint-ORIG-GUID: OCJ7yT03xRfG1ppfvAJpyEGPgPW6c7vi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXwmNRz9Uwhqcv
 sMjI5s7Amlb4z2bJhs3tcYaU7TgrvNRjLwZT4UL6VfDNeTkFW4JvZ3+sARe4TMGlZHouQIK0Btw
 CwugTZVyZKgXcTSMtrMlhVHC4fwqWddY3DLbpe399Fxe7dJ3Q4ZzwIPyws9o6A0nMK3wjPBO/hM
 BzadNl9nsksBEL5y4ZpbRR1OY1pyUNdT0aPm5ZNq46L0cp5HifwIV7wtyZUyvTCHP+jZEkwWfoR
 2QdcXcaodZ5LfCuSD1VA+cWGurtVZQz0aFmTKM8PV3GVW/A9sCEf1XeVZNE44kYpS/4+6hTBsA9
 2a9kw/YDNAaa4Tlh1977z6EFp1v1wUrSNdNjrL+ExFE2qZhk4LcC2ecI8dVl2gCzQ3eCtze4ipB
 CpyROItxfDjl4pQF3Sg1aDU2cSZ65nw/5L49UT+Bu2ecpmB/I75wuCeBePHWYjTMq1tO9ZgEVGb
 L09D6Msy7giaGZK+BAA==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5b413 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Mpf73wT2ZL6LqHt7OasA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrIHwgMSArCiB0YXJnZXQvaGV4
YWdvbi9jcHUuYyAgICAgICAgICAgICAgICB8IDMgKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMv
aGV4YWdvbi1zb2Z0bW11Lm1hayBiL2NvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFr
CmluZGV4IDFiYTY0MjBkMjA1Li42MzNiN2IzZjhiNyAxMDA2NDQKLS0tIGEvY29uZmlncy90YXJn
ZXRzL2hleGFnb24tc29mdG1tdS5tYWsKKysrIGIvY29uZmlncy90YXJnZXRzL2hleGFnb24tc29m
dG1tdS5tYWsKQEAgLTgsMyArOCw0IEBAIFRBUkdFVF9OT1RfVVNJTkdfTEVHQUNZX05BVElWRV9F
TkRJQU5fQVBJPXkKIFRBUkdFVF9ORUVEX0ZEVD15CiBDT05GSUdfU0VNSUhPU1RJTkc9eQogQ09O
RklHX0FSTV9DT01QQVRJQkxFX1NFTUlIT1NUSU5HPXkKK1RBUkdFVF9TVVBQT1JUU19NVFRDRz15
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CmluZGV4IDg5NmQ3MjgyNWE2Li4wNDE2YzM3NTE1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTgwOSw5ICs4MDksOCBAQCB2
b2lkIGhleGFnb25fY3B1X2RvX3VuYWxpZ25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNzLCB2YWRkciBh
ZGRyLAogI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0g
ewotICAgIC8qIE1UVENHIG5vdCB5ZXQgc3VwcG9ydGVkOiByZXF1aXJlIHN0cmljdCBvcmRlcmlu
ZyAqLwogICAgIC5ndWVzdF9kZWZhdWx0X21lbW9yeV9vcmRlciA9IFRDR19NT19BTEwsCi0gICAg
Lm10dGNnX3N1cHBvcnRlZCA9IGZhbHNlLAorICAgIC5tdHRjZ19zdXBwb3J0ZWQgPSB0cnVlLAog
ICAgIC5pbml0aWFsaXplID0gaGV4YWdvbl90cmFuc2xhdGVfaW5pdCwKICAgICAudHJhbnNsYXRl
X2NvZGUgPSBoZXhhZ29uX3RyYW5zbGF0ZV9jb2RlLAogICAgIC5nZXRfdGJfY3B1X3N0YXRlID0g
aGV4YWdvbl9nZXRfdGJfY3B1X3N0YXRlLAotLSAKMi4zNC4xCgo=

