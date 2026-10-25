Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7077606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMiVvlXG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R5YUVMgV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqm-0007qY-K0; Sat, 24 Oct 2026 23:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqV-0007kn-Ld
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqS-0001Ub-La
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16pG54173954
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=; b=cMiVvlXG9KZQTlpb
 EFucCPP+8tV7GVlORY46VGMEVlEJhOsWeqsExiuiFK/sEz+toFowRD75NMQcwhav
 bVxzZLwRrmE104P5QRzQypUy5q0AXmhT0nPvF4xcSxXwO56Smy49bFtbH6x6mFjz
 24VAs92MNfWskJAtZprKFGw/VcS8XKgAFQRagL9k0AuaiWP/gkHOdPOqwGVuF33R
 XQ4sB12a7obqfQKtWC5Lg6R4R5N03gV7NjZb8XBP/YZtKZJr3xt7SFE0yVmhR0Si
 bR7x6qaQAYocc4822Su+GwbOzc52xylBtapR/yC9wB+Ly41CmeHH70mBAMF/4XIb
 TFc1BQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgtnaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so3507205eec.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898666; x=1793503466; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=R5YUVMgVcCFqovVC69XJzP5Z0K3u/Jv1+qWjseeHj7MbuVhUyjXiICdvAcwqG1LmcT
 MlApOT+BwkSGTooT5iFvtYBP7hBGaFNaWpnjw6Li3qYaobKW2Rbr4rhpyXRlPA6t3yBQ
 coSdpxarB3dxk9mQYVeCDSOpmRmqQD5ppBGRbMTAqzKm3A5tF0asCxfiBLslpI+sAAwo
 gdDqwW6b8T+80/Esp4af7WF+nerWGEmXHwc9DFgyrGMPzk0+6tpjxoIRNTqb2bNfFX29
 NmQiCKF00D/9B7LZIGPBsK9OD0ZNiq76UMC6rcES+C1ahLs3A3+AQPSvs2wkAOcDGgh5
 om9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898666; x=1793503466;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=A2Qg/1Pxqv6tVhUsvIlCD/rHMPFWtiTi+/6l2w3OHM3/U7ae2N0zD1zTQfOW/oRY0G
 O4XbZ9S4LIyHqRoDiAfNIQPdmBFTvQhe37XPIOIURB3QAPwWlOhFP/xRDUCi2DkcTI3r
 FZkeCH2S5cwJgq2E7ireZsLbDBrDvAG4YdFfcMbJDjkRT/qC2bA1C16dMEs1YntQsnaO
 mlo5ZS2XfBAo26uLHUVSRqF/1l6b1B9Gzau+R1qtJW9YjmtAFP8pYK/i6AoPnRXqNemI
 wWZ0wCkmVO53Sb3SEWhQ2yDl2W1xtvB2j3Ad4G+L3/hVPhVEtwL1Yzh7OIS97TvVjP88
 24oA==
X-Gm-Message-State: AFq9FYJXPB8V7mesKyPCUa/Tq67AYCGPTmPOVjMx/qqxJfmLErd7EZeR
 ELlPYVhKx1Sv5qio6hXqsmO4wYSFgQkEXaTf+UfueWFtuywESKJP5S6k5ZyYQIGnIlzM2/SoTno
 fHSy9gGrV5zrkwQM6XavLmCpOYqNRpQ0fOp75Esdv+1Heu2MIEOIssrtpd2aNqq7GEQ==
X-Gm-Gg: AYBFou2mFQTtYxY9bbnHE2jQyf+VMt2IXM1qimJMpXKIhpANIoooMPwibH3PBr0Eu3V
 X9PdeWofW61VTzzk8vYqZPeDawYVnBUwJmaRl8WZ/iSU0rzAmPaMjwEDUzgG0m2wOI5s/PNMdHg
 wAZu8i/wMLRjylkzzcjRako9sIO0UWN5ES+UzZaJCzlGYxa1GWOISuOrlew04pV+rO/PQOLwhtt
 34EnyDgqb0ZvIut7SWR18m6XN+TjXE5Hh8MW8POG6M8iIFY1iWkwQlj7Rux1uNNssSLAWG3qQaA
 vwZPGH2wCcEeMk+7WL30SVB/PR0jD/HuQB/PVOoPkHfsQeFt4uMpPc4zbiIMVyfnugbUsPt6Mjm
 rFoRZqNatSP6aivtWdoe2OobhZ5jc6zZNpkDP4kLeJnxDcuc=
X-Received: by 2002:a05:7022:1509:b0:16c:3408:760b with SMTP id
 a92af1059eb24-19937306c70mr5017536c88.32.1792898666447; 
 Sat, 24 Oct 2026 20:24:26 -0700 (PDT)
X-Received: by 2002:a05:7022:1509:b0:16c:3408:760b with SMTP id
 a92af1059eb24-19937306c70mr5017503c88.32.1792898665677; 
 Sat, 24 Oct 2026 20:24:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 18/40] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Sat, 24 Oct 2026 20:23:24 -0700
Message-Id: <20261025032346.2917451-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX6KMFhk5g1W7H
 qW1MLABiuPYwSPud8sbalmx8CT94Q+YuBgreZ6O8GbepnCGAXBQ6z6/yFa7z8EH6b74HWv8mMx8
 bLTOzdJ8taW2GenfVTgD2yS3WtUxnnQ=
X-Proofpoint-GUID: QQssK7epQG1LLoHADiyGV3FtgKQ-oawf
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6add766b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX5OIhF4ifyrJf
 ubTu4wy7/3XRnyqWTJsQrY45ZotschOJFburTLHtL2ZeSi3hOr+wp1Acz7MOY658O8h1syEQ1g/
 19y5GfV6dW1p7KHZB+j+tsMPl7kA1qrpzuA1BD1H64WiLgoen/nJhoBrxA41+4qVmO8R1mJiekh
 KCKmsdpUHt5azs47df9+wIvQPckXu8mY+Vx98F9F/KCXGpnmMZ48mvVRJgjxdIkvzRZNn80nVs4
 QHAYTGy5KUMxTAozOTKf0hjY32AQ4XDOuY6q701TUeegc9Z8DJ8ksKBUO/uTaaD1F2qaT98hOB0
 8QMS+sqMFZC2ViIdW4xbyQJep7cbvYz76adIuW3yaPpt1Mc2b47A+3qMd5SnkHotQ5XydFoHpdG
 I5+D4EZmnn6Iuiohd3P/AzE4cSBUy67syACVZBr0BDmRYAvHdn2aLAR+a+dMPKjBeDuSjnUY5qy
 Oe4RTmIkviI0wCDChYQ==
X-Proofpoint-ORIG-GUID: QQssK7epQG1LLoHADiyGV3FtgKQ-oawf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggMmViYTYwMjFiNGMuLmZiNDZjMDUz
NjBjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjMwLDI2ICs2MzAsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
ZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19BQ0NFU1M6
CiAgICAgewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZp
bGVuYW1lOwogICAgICAgICB1aW50MzJfdCBGaWxlTmFtZUFkZHI7CiAgICAgICAgIHVpbnQzMl90
IEJ1ZmZlck1vZGU7Ci0gICAgICAgIGludCByYzsKLQotICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgIGludCByYywgZXJyOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIoRmlsZU5hbWVBZGRy
LCBzd2lfaW5mbykgfHwKICAgICAgICAgICAgIGdldF91c2VyX3UzMihCdWZmZXJNb2RlLCBzd2lf
aW5mbyArIDQpKSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9Ci0gICAg
ICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtpXSwgRmlsZU5h
bWVBZGRyICsgaSkpIHsKLSAgICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAg
ICAgfQotICAgICAgICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYg
KGZpbGVuYW1lW2kgLSAxXSkpOwotICAgICAgICBmaWxlbmFtZVtpXSA9IDA7CisgICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhGaWxlTmFtZUFkZHIpOworICAgICAgICBpZiAoIWZp
bGVuYW1lKSB7CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CiAgICAgICAgIHJjID0gYWNjZXNzKGZpbGVuYW1lLCBCdWZm
ZXJNb2RlKTsKLSAgICAgICAgc2VtaV9jYihjcywgcmMsICByYyA9PSAwID8gMCA6IGVycm5vKTsK
KyAgICAgICAgZXJyID0gZXJybm87CisgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBGaWxl
TmFtZUFkZHIsIDApOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJy
KTsKICAgICB9CiAgICAgYnJlYWs7CiAKLS0gCjIuMzQuMQoK

