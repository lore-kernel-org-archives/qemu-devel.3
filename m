Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2239CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2U-0000mO-SP; Thu, 11 Jun 2026 01:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2Q-0000Pi-MW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2O-0002We-Nd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLtu2248044
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=KtkFtwIFns+a7QhN
 vBxh8x8hXMbpO9kBNeIN95d0sU7U1pm7coYI10yc+xZz4S3MQXFzaE1prZiozJ9/
 +mbI1nD/vQDoJMtt9js4jnnBuODwtn5OgVpD5GCi01Fp0ARjN6jUuXQGeAhTVzaD
 /GciLYafa2mAEEWcmEbXGGppYm0Uo4P9K6aXJMLVL7nQLKYdeKQPHDLmRewsqtd9
 gtf3pcYU/ryOqp2uNmOg0ZuXXUTkKeu2IfNyRZSPwE3aBSTtEJpJS7sfgl2qnM3y
 hmlavHaZ2bU7afrZK/xD7rhryXp2Fae5g7AvCNERE+ws03gpf7DjSOtlhVGSMf3e
 yZbi4Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hrj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304dd917645so9079423eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155987; x=1781760787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=IqU4+Sl9SqitHnY6EFezivcJK6iuBrl++gOzfNJpX3+tgqDPMdloUzwWuYLkuC/HCE
 bfut1QTV3mAMszYCC1gBgOo8IjwwtB+QTHJWt0/JfFb7jyOXpUqCkGqlwZ2dUnlfoY9u
 Gti177IQ07cPXi7vyKJTrqikv+xffJkVrEF4vIuftens5vcAlkibGLSQs52MTdW8s9UZ
 RxTKERJMFjxEHfBol4YrqaqCB3pXrBnMscyvh4kFfW2Wglyo/2aTTPE+vZqWHfwSXU2l
 +32cp9+mJ5Wr4yOOw20jy0kBc4sMIukin68nQmcgxF6boqs0QFqCh4znSJZkSjLuEzCw
 Of4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155987; x=1781760787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=RaPwxeeXX3Q+KVvKcCIztrUUmcI0mll9NfYSI3/BXRSsSErnwDTjc/EStCRvAlg2UT
 GrtIpLxPFuvwOpiMojX8tCp+PGsCrs2TRk9iXxrPwRJkSusU2nznUUH6h3sxVJc/o9Kq
 o3ouPVfQR7YP3ctbLugVGSoZNMvInhnZGz6/YYvq5pthIAc1l87YeHJLuQB7y9uXCqDS
 tuzBH5up7R0BZZ9Ix+l5SDGovviDLfioe2rIIONEnq+KRuKz+BNvNGpL7IY1PUbr+SUA
 sfWbG6ON2Cc4DZh2Kre6dTATpwXU/mrElIHe24ua67tHEi+poVnyGQ7aiA1ugDAaAODO
 3tFg==
X-Gm-Message-State: AOJu0Yws95bss7mvCcrC+ed1pwiReipw9ElAjpbcq9VZn9XKC6y2StBb
 y/taIuSDE9EuqHZuX1bkdoG76FzXkH2dUUhuFI77voofW+ZEo++odwDglTVxPPZsnU5EFRZpZZT
 mqzyeNckIJLYlLtcFOdNu5n23p67M/LNevf4GWVk23RBhUfHBm0SGdgvVoJYBrNEMpA==
X-Gm-Gg: Acq92OEN/eCf3vMHKxnMoPiQa7xHrOsDJ+iLDDDRSOJyLKGcVQ/BJs6gSELWaVCZz+B
 0rLTOd7iQonxUqHISC09sa6ihghyVq7ri+jBjk5YHAmskg2LW9hll8fgVOEXZ/dKqGIjoru5hs1
 18z2xNqu80pP31iGRshnKJDMaPooAdGK6xqe3oLGxhHwmjO8C1H5zPaVb+OHfkXggtYQFi+Cocy
 ipso/SwdNT3kEZS0k71YRSfaZ/IRwlFrI05T0Keyu5lsJhIgNghmmmi58ur1qZCJTYuseSxvVWg
 oGnSZPGwXuXn+gL3YFX5ofHJYryM9pWoLdKOiAy7JiyDd032Cg7n+sjGPyYD9U/0j0NJYluBy3o
 7+LHHMuzBxYKg9fVVcPxnpaP+Ta81VRDfLUWCdrYYhRVYdsJHjZvovu0MStqMU2EmHemSrQ+HDp
 BvA+25
X-Received: by 2002:a05:7300:2388:b0:2ea:5057:a331 with SMTP id
 5a478bee46e88-30804a0e948mr1072232eec.21.1781155986661; 
 Wed, 10 Jun 2026 22:33:06 -0700 (PDT)
X-Received: by 2002:a05:7300:2388:b0:2ea:5057:a331 with SMTP id
 5a478bee46e88-30804a0e948mr1072214eec.21.1781155986154; 
 Wed, 10 Jun 2026 22:33:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement get_exe_mode()
Date: Wed, 10 Jun 2026 22:32:27 -0700
Message-Id: <20260611053249.3918491-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: BEUdF37lhNmB4Cv9kfHDSUEsorNWOnqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX3wce9G5N/5+L
 UeNVOE+T+aGqrHgNRI5CIOpwQ10/4F/GCKWmUHsFBGPsszHWLLkFzuF98w03/IIyoXjB8YfSPbp
 Ol7A9wysIAn+y6zha5YXQAqSg63Zr5tjFgsjRWWhgVEJuU+8hRbEvAZptSQb1GfWVsZ1oTyTaGe
 wFCjalIcVMmbbHYX9MXBUWTguXIdD3F4Aie4yDN7YEZd5R5M8Dxs0kRuVVPx5HUhPapW4IZNXRB
 DdGThWOaonJiebn3AbXbHKRcdjQwJ8rGaHmaupWZtT/rqPtcYZK+SRx+txDUsScvALPEqSFhqT7
 wLBgFKOyymMqqtC4h9iedADiBeASX0H+yJcFzG2QVAUAzuEoS61OwmLHFi62pvzU0DJZESAj29+
 vVWQUJGItbzxga4On4jqSrzizZYyiqzUIoPhAC4Ua8NuiQSmS7P33vHWymOFGLlNrBMNxNMYu04
 SqQOEeE20D4YLujkcCQ==
X-Proofpoint-GUID: BEUdF37lhNmB4Cv9kfHDSUEsorNWOnqf
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a4893 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfXzLhlqSu4f5m2
 tsFhEp3woqAuLvwP3eJs0B2+UfJF0KYuWN7TbOBsJZR+CTxYqfeOjfWdos0NTQTkXoF4XonWaLF
 JVbbbt332YTN+4zr18+zaGY2QCTJ8io=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

