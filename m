Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA323C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39T-0001c5-5x; Sun, 28 Jun 2026 23:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39P-0001bI-OG
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39O-0006F0-Bo
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d0Nv1554573
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=ft
 8gece0p0rFt4UzjW3fghohDNz87T3Pjs2tX20851QDOlpMP79VfvWgRtMtlV0ex0
 TrYCm+zPuUlT1SMYoaJ3d3hFenp8OnW4kBom2w56VtpmDykP/oIDH/Kj58BVZDYW
 wu80lmTCUXx8TPGYdXAShHoqzalaF5IZV4W4igTnr/wlHqr55NCl5FMRjM6judP3
 Ww/Iy02KYeYIvAZNzKlYwICTKAjlBfM7Ot7gPwyCwu6GP4hX4pewKm3OxNxA4vOP
 GY9bndC0SbgdwSUpEIDBx37PZ6smdbIXFnqWmBjxxX4uje6cZB1nfWzLIPz38khc
 VZNFn2kDFpQCvbj/v+Eg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74e82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139f77afcb2so3338370c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705542; x=1783310342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=XJBfpoGbvoNNxJifbiPxPrKr/mAJhs98YSM1P+S8o0M8/NMAla5YqVwsHxW+wF8NX+
 OjUPepCw5dV2V7NHfubwSCJaISf68oYPx4oXfZTFRq27bHTafQvsV+rNDsVekWNEVfN6
 cAe0BEZgvVR4vgq5ScjWAmOtzhWRvEgYuFSJMKn7yTmXa96dm7niRzxnL3nuPdMSjz6X
 9NVpNhDHC4oKPU5xP04qBv0QH4N9ehDuaBMm0F/5FJKNQMB0AxhbJHtwJplayvOig4kX
 bnplQDUHMxNNHYWX/b0n/RS2zqDn1hhAdVNxpjRKbCrRcQPvnIJ/nsoEiFx+2T7gdzbA
 SeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705542; x=1783310342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=oDuBmpuVfZrcnWhzJwutJd1WMnYWeRs1RFS1xSZOyCsvDmRCUz9s1q2kCUIDKMrpp9
 0Uh8lCeUcuwXmCRVpbsfN26P5AhWVhfqWWoWlbApg1Y9GqZ102+cCpMFWriGGQjXBU3X
 cJkW+ZcpbOw+4GDL899Me3bzXpREunNowiRRXPEtQ27sEYUoduMWtz+W38sv9A0Jd0IH
 uP9mrxtSDSyrQKLJyvXZIah8DArrUbFwEh0117K+rQPe5GI8b+HqDVJeFhDxYGWAj1rP
 JqP0LZaQxAiN5TcCQjRCCKj2bETTIiWqlhcyW1TwjvduuoxNphLCf4NuH9mx3iJdwsJM
 XV5Q==
X-Gm-Message-State: AOJu0YwAAM3XWTqDiLguj5SiG5h8vljDMfOzI1SIGh24P8U4WeoK9n7h
 NHmsaTa+WxliYTnxjtyTpSwf8S7eUeXZIon56S10/SC6//zijKOseWQM8LaImRSV0RqqK4wUX0I
 5os+V0JXWZnYM7I3RLlAsSv0Wf8KnMdohU6L/Z4pEQI2BMIfPEfeeeb+vkBbMDCzTEA==
X-Gm-Gg: AfdE7cm4kS5jloMw/S4Aw3vLifQZk4SL+I5ggqPA+QdVRd07kyU3BZ/29w0SmRtgV+A
 NV+vCWpI4HG5IT24ofayQhDlkuLO+sd/Hte3NXIxWT18o0bLlVa+II5xjXOdV/piIdZd0/MkyrT
 ZIfKtdFKXPrCe7nkrw+Q2eSmUctTpXIMdc8ctelBKC0Mt8TjYho69Muf6mZ3NHYKo6slWIoNNfC
 K6QNhsGgwAcrtS4fzoyTDoOolO3K2SxLT4cQtz155gIHxakMBOZ7BakWaQSq0b9IolSBfp/I0To
 G0NJcSKJTGkxFZXlBtKLOAWYd/WaTzUM5v25xxyjnihcAtDDreEplfwoKd/sRKDo5MEwFWWXUPP
 dI/4YRwEyeItAN7bw7QiHb0VIJs7jZ3wTk+SPIro7RiRhRfs+SPLsKoaeumI=
X-Received: by 2002:a05:7022:421:b0:137:6781:7dd7 with SMTP id
 a92af1059eb24-139dbb5b14fmr14175022c88.20.1782705542413; 
 Sun, 28 Jun 2026 20:59:02 -0700 (PDT)
X-Received: by 2002:a05:7022:421:b0:137:6781:7dd7 with SMTP id
 a92af1059eb24-139dbb5b14fmr14175003c88.20.1782705541950; 
 Sun, 28 Jun 2026 20:59:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 13/77] target/hexagon: Add a placeholder fp exception
Date: Sun, 28 Jun 2026 20:57:26 -0700
Message-Id: <20260629035830.1520296-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxiMxywJzBF4A
 wAXD0dMxQIpWbOtzqcYmAg7P7zW9jgtAeXIzVcY+mPkDAy9J6D5aHKALxkNgC/mbSDr2sjeCt5U
 w+prlcKQt6/0xOWV572sOCuIftZK/jI=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41ed87 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LY1itotVuVIxTwafH6u4zqqQARK7gQFt
X-Proofpoint-ORIG-GUID: LY1itotVuVIxTwafH6u4zqqQARK7gQFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX6NnixSdGa2Jw
 zAuI6gJ69X/QjM0IEOYIG2AeKOi1nIEkLlfemFbAR6ZiCNaScj8iN1tWO+2T6Nek739txQihWly
 OMBDGyoX0K4B6Vtlr7FnN7L40ncgbjUMB5cNDA5cjGL/euqHht5IcSKvNaHzHNL/bgUYbQ0YGW8
 s7fHGzzYhE0jFx9GkBu7cwwh9QsvtvJBHpucMi7wuhxEmYE/oekX3e8YP+ge0QV3HJ16wGC49aG
 RvuS+z/fwQdl9iehtk26tfUaRRj0dnz9PYJFCNHcDcXGalmp7vIzEwUiHRHzB3NT/hVqdsFYehF
 zQZVSbj6iGQMIgZTd2RF8Wr3Aw6U/1gan15KJeVKzKEFdJL3RpaL2xQV3zvpRDdRXJwDUSLjxsU
 joHZK1CxAc4PcJKgjyOMIO8fFO7utku+GS0ZcfPik6rTpgWZtu9C/fMzVLw3xoB59A18ZyrcWA7
 ghurZZXQc+t7PQjiylA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

