Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B19CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig5-0004Ds-U3; Fri, 19 Jun 2026 19:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waig1-0004BD-NV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifz-0007Wj-MC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYQ621337250
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=; b=g7U3hvb6MgqzIZ4Y
 CIMb7f5QrPM/9KUfJFzS/kMjYkvzglIvNAhfZZZ+jfZYR6N1nsupfzx4FDbUpTYm
 ZGWX2WTYXnoRbqRXvsFYIojxULzr380bXMa9fclzv6CV1x0W8RAw1bq/jOWA8tkc
 3r4NDbCTmMy2aYlpLNfQXeS1kgFIc4k9F1YrYTqmGre46WemyiW8lbPPslmqgVqZ
 P3pwKwODje1CcCYqC0VbCtHsMz/XeWqkyHplrJB//2TSU6agf+I+zb1m0hjjGOyC
 12eUrON+ztIWY1XYJO4MwOxZO9O7z0ZNOR4VfxAl95GKSXvxNXxqHOCet2FXx+qg
 6QK+nw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6757b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4641726eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911856; x=1782516656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=czlWRComNl/FaZDNnaOiGylNu4hY8Q9bVTKT7ZBsv7dp2k58HE32RtPVX8+3Hr0FyP
 0Gu2GowKWuSz7loF/2wQhewao02U89+F8wAtAkUSi2mKI8byvDizHX/Qh+O1GjoukmIJ
 fyNDaWUVCGisUVOiHvPaKHpxK6tVkiP+AeSp2S3R2g1fn4RPLp3s9SSGYccQ0DpbfvPt
 DiEYjb7GZbUhgHzNuxt11FEFi6dJ5yuFdvZOwhIjQ8FxlxF1FGLor9UL+hnnBrpacAq+
 AtSIDOuJ+wpUqlAVNE9SWBq6Jo4TduUnPgEN9Rp3MzY2KuWoKIlu96pFVlr1Az+N9wb2
 WTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911856; x=1782516656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=ogo7ELIXrBY4JuKrG28lI6zwwHCLfxahinCc9HjB9nEMFzLVFMvej/MmIVATexnssL
 LliIkF4jLFeVKhvO2Q4ufPIQYFAP153ua4r26NR1Zbs3kZndskC5QzJVvpNQ2ABoRF2L
 DIVxQa1kiMaRn8rjah0jhqMLlD3j9rtCwusgAwZO4/y6uw15hFDtvJNERhgWDlDXbsoK
 exfDz+PLu5WzOD1cI0jruAwvo3QPAFtfcJ3iqj05xaCs/M4zV8C55EpKSWMbm6M8qWkb
 IIDROFW0VN5okfCYBKTNTGPECRH1LEJNLKETZmx94UUrPo4vAZTXK/H7MO6hiwxHDy1e
 m3Qw==
X-Gm-Message-State: AOJu0Yzzwz2ohdyp15qvm2h/M1F4zJhSmX9jXklKuvYsHZLg1uR/NSJy
 OYEFcqyq+mOgsge5oqgjkReD+y+27JXVKpcCPJbgHG9vKlTsnKLcExd/1ekzDV/mhImurCbuNOE
 mEG+0IN0zBzyvQVXqCRmVeA229yHN7iwmG05UB6O7Cv2Tm/IfhRJnYcNBOpF8BUP7fA==
X-Gm-Gg: AfdE7cn6Beyj8Ya95M7ylze50UmAZDUCSrf4ChPh9tvHdz/0DmiU6DHwupR5iH2mqnk
 r+UVogEQICexlgrZD82shJ4BuMXLfC3+ygzVfOMAYZ0jLuT+yoPBx7bFRSRdJAwxPAbXYHLIqZ5
 ys0EBA30Hc0NOT9kpcjvafdDtQxVd2MgLqg4vAkWbX2cmc7oUIGLILzUHmvbyXCKy7Ej8c6FD01
 Lg7DPsSr1+2GUyCdTPjsC2RRvQicL6bz1lfo/8sS/zw+nxDlwXsaFoVrDEz+uQTzUJ4lXZPXP4x
 D/QuO7o5x5VvCKhoppKIsNLZFo2VNh7V2Nd0B4rcUtU5UWnEnSCNg+lGdR9qq9P3SX13DIF3BYb
 4IkzgxTaV6wB5E4MLoOIXaOhdOSf4OvR7n6zVhEBFtFmYzj5IbkXLGCpbg6I=
X-Received: by 2002:a05:7300:5b95:b0:2ed:e12:376b with SMTP id
 5a478bee46e88-30c0d29fafbmr2485250eec.33.1781911855466; 
 Fri, 19 Jun 2026 16:30:55 -0700 (PDT)
X-Received: by 2002:a05:7300:5b95:b0:2ed:e12:376b with SMTP id
 5a478bee46e88-30c0d29fafbmr2485241eec.33.1781911854958; 
 Fri, 19 Jun 2026 16:30:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 70/74] hw/hexagon: Add support for cfgbase
Date: Fri, 19 Jun 2026 15:59:07 -0700
Message-Id: <20260619225911.159473-71-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ycJc-28KiqrCPJTyqvtou_8-vau_msr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXzcgw0OXVCxTt
 hQiJOseLwJkfrLZADYaSqEV78ePZhY1AC1ArScVete3Odr7tF0RVVy0b2hef/mlDvLQHJTsOeBH
 Xwp3VAIJE6S4Tbibbf3wvhpzLk/kOgr/NWCKqRnSZW+FLnel11TsYSrxcgl+fhdBeq+5H2moEMN
 7eut6Pu8v1YkCSPj8VYu6JxZCX4p3CEWW0uUQ6H7LDoyN60uVXpN46BpLBDt8UuU96rYx2khBJR
 jwyjCdVmPrAJwqmd0iMbcYdyUwZsyF9ZE5sx1JWlckSur61t2pSGeXHbYSMtFrUxgk6AXv+pCDj
 hbuzsNdOGQwKwgxxboL1KMTKHKw2iiCVHBMipNuu6bB5Bj8tpt0drjjtmeQV0vAdy41hejq8prA
 m6utmpQZFaBX1AmdPoDNLIqV7NuWrhyt2xVLNEh8xwU5N7X2Jy1u0nUVXJpFksaS0J6TE/HnNKs
 4jj4VhgwW7C8FnpCfeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX2OaY9WMIAntt
 H9ZlR44lYmqSr88ZES2DwbGPJl2i8oHnwgWGPj2WRH/4xmcOy6q8lN2NvOsjqZIpyT7NIi/oEkL
 dHtt9B9FurWXgi57tvllkHVua8PxFC4=
X-Proofpoint-GUID: ycJc-28KiqrCPJTyqvtou_8-vau_msr8
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d130 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNw
LmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDEgLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggYWMwMWQz
NTk5MjguLmFhNDkzOTkzMjI5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xNjIsNiArMTYyLDEwIEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCBy
ZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZl
cnJvcl9mYXRhbCk7CiAgICAgICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoREVWSUNFKGNwdSks
IE5VTEwsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorCisgICAgcm9tX2FkZF9ibG9iX2ZpeGVkX2Fz
KCJjb25maWdfdGFibGUucm9tIiwgJm1fY2ZnLT5jZmd0YWJsZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksIG1fY2ZnLT5jZmdiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwogfQogCiBzdGF0aWMg
dm9pZCBpbml0X21jKE1hY2hpbmVDbGFzcyAqbWMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDA2YmU1YzhkNDk4Li40MmQ5M2U1
ZGE0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKQEAgLTQwMCw3ICs0MDAsNiBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB9CiAjZW5kaWYKIAotCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVT
dGF0ZSAqY3MgPSBDUFUob2JqKTsKLS0gCjIuMzQuMQoK

