Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86161606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ioN42AaA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aZSboNh/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4v6-0006Sp-GD; Thu, 22 Oct 2026 22:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4ur-0006RL-1a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:22:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4up-0000tw-Bn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EuYl2376082
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=; b=ioN42AaArXQ9wEH3
 uHFrhHH0pezhDpnqsbcpBBAO0s26VblVnyL6qM1dP+1+i2X9ljYnQkffnaYBKy41
 ZXAEJvKIt51P5EMOtL6eVrJj9o9C/xYDzDSeALVZQ7TSzxWPi+30pnNu6HMyoL8Y
 O59bWsEucj3Dv/iyUbj17SZWBKnGbIQVZMIyRNe0ugQcasm8JkdCuKBkFwoBM8mu
 KPpeHiofzZ7ixIAUqWrSwODlBoZXZJxQ7BGs55sLtZ4uUG2/LMsK7XuVOzlT4CEB
 DlKMKvB792vhPxk4IKpFja9kFMR1ySYyg8X65p3FQvkfgRNf/TypmXhSvr5W1HQe
 LXi9fQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr9ejr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso694342c88.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792722113; x=1793326913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=;
 b=aZSboNh/B+JRjHuFu+oJtWWYRoDpOuGzk3znr39tRcToF01Qrq3dhDViro4UzR0c4M
 Vg2rejxsTjRv8XeZsKBazd04ikRwCTC2vruKSTON2qMVBJoE6LMe1NzDyb/XEDTYZBCk
 A/nbYKIxQgBQ6dGWv/BDG4r1lsSwWyY/ZH0//zDDWqTk0Wyv/amOjCe4hFnQSk3De2WR
 QwkKOQSSgrPqOQFhZDPngHqs8zOBWZa33Ydq2tgq6uixXArBJrAVk/aBeTsptCLXatla
 8VcDY+NlHVL7Yx8b+CSSEtpCRNpoDvpOCZdxDOzh0UQk1FWpNEINru1Z5F6NbAr6Kvwo
 9V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792722113; x=1793326913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=;
 b=tLNRuXm829rSXyBxeMp59TBXFw8e4TKoJhbE3pYVX66/i3iFQxPLmeaKwvkqtD3ZRz
 0KNqUiUtbDsmucTZWz8CU9miId8q9qBihMzYOE0QZb+CaYH1y6fTy5gKEJJhqdGn+XhW
 TebrfOtt3p9dBTi/SLuwyOOz9BADlpppPX69YWHeQTI+EAlEkuVxz8pe/+2QcotGa3yH
 lifm5MT0YgErRcBr6Py002PkmxxTQdh4UTOD0pnIaSDYez3mvHz7ygWm6aII1YPUFlDO
 LPpzpHdOmQNBeJi80eR31tqQWUv+t6MgRSOzOrZFYrdYXJ0+JwzZwfGDNkyBV+gOOy09
 iW4w==
X-Gm-Message-State: AFq9FYKb9gyoI1tch+D9amoiL4dNoorxkVbl9/0TG+Ot7u2/lNDKKHBS
 dGzSsMV19saPwjXC/UvFwmRN+lMA8FWc6eq7WTOo4VpM1F9SsHWUdBc6Cs5NOCtt1snS6QyCi8K
 dQBIGUOYJMYi7WQxLErNt2wDzcQ1AJxD1PrzhohBRPB82n/yUzOmgLqs/2SkTXF4x6g==
X-Gm-Gg: AYBFou3nws/GW/U5D4UJZyTAJUpFAt66163gNuX/q6+n0dE/BhXyzqt6Zju84OUAFgg
 SI/TBN4baprOjMl6aoxkjq2ux28tJ2V4wpT/1Ra7T8TvkhMvdbobHmpMg+Ht6pMUxUMU1ji9vZe
 Tg64BUubBsrPhGx6SlSIKYmoaW3MlOUc/ryJTa88FkVNgDngc+9gRYhVD9z/Mq4b42UP76RoADg
 npxNl/BJlaadoXF+pFqLCdru3VZhzFCuJBt/iZ6X3jcNnpHBdpCUJsOLR7yJgh1zoUv02rBbWLk
 APtZi+8ktRm514BdRni5Q93EkzRfUlBaoF5rEATExiGgRSwgqY+lVAnx8BY6sfWcoIX8Ya5/++O
 l+t3XIaOCojB/gcHLWTk4xtOVM7yDNXVb7ZL79wclauccOB5u
X-Received: by 2002:a05:7022:5f1a:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-195c5bc6eddmr1044728c88.26.1792722113219; 
 Thu, 22 Oct 2026 19:21:53 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1a:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-195c5bc6eddmr1044699c88.26.1792722112632; 
 Thu, 22 Oct 2026 19:21:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eae0e918sm2093713c88.11.2026.10.22.19.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:21:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 43/43] target/hexagon: fix semihosting ACCESS filename handling
Date: Thu, 22 Oct 2026 18:50:40 -0700
Message-Id: <20261023015040.2473105-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: VfQWX6WdwLpAK8_2bAc15L8C23AMbByT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXzujgSVW1ILsf
 uQvbFJrh/Mi7rGFPUZFKYY/htpcS7fPe+EcrE2u04u7Ax01dFCTtc9nnH1nLfmIGwuv13v9E3Ky
 lMQ2M7CFqgPJRtreJIBby0jjQKBoLvE=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adac4c2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXwmnDSuOsFQyB
 ZwqqjPo8ngoJjYFYFn/A1R/28eRcYGWcgvmA0/nUtnEGm7caRToOdOKosQ8YG2zQlhWObrzBM2g
 3b27WbONeHnn8IaVevqztpS3clioP7lBpmyDXAs/5vnmRirF+uNCZsTNKJc7TcP5/vLXuIvnilE
 BCzqo3KfFvz45pchQPQDypyffvYysmowONh1Vi/upjTYuAkuP5gx2ydCPIKUnCER76mWKBvX0qS
 F8mlLIZS/szIig4kjhs8lawS0vHiRBaVjGtfcDtJTgvhPVYZfQk3VFuoZ0tddM6+wiGWR2wQRVP
 uinE8hX981ZIonF9Gg9BWSa02PH2TbK8VYuWZMr8qoQj7ojkfDIwEI1IHdq2zhD7Wx3Cr3pns4b
 tCZAFjy7UnZ1z/PW9u1wq9cSNothz9ev26WRkwvrunR98HvIlMnCwMxxaa/SENTIoYl7zrz3nxp
 uMyT8psWUEB2YfToigA==
X-Proofpoint-ORIG-GUID: VfQWX6WdwLpAK8_2bAc15L8C23AMbByT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230009
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
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggZWE1NTJhMWYxZGYuLmJiMTNlZjVl
NTIzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
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

