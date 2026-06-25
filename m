Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90970CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktC-0006hZ-Gi; Thu, 25 Jun 2026 10:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktA-0006hB-F6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckt8-0008SX-QO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9ju131723164
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=fX
 NiQD/TfxpNfaypKefcumAxEWtGppRqq7VWlpnDk+IRTg2rHgZli3UHUZjMBgWY+K
 NnGzu2lIsQO301pG5Ip+OOxjIYQscpgl/QTO4KR184cHBqIqQfABvZTlZfFdYOFG
 Srv7RfrpKp5qMJO0jQD7/+jcDryIQpmRSPeCeqJhiMBUA67QCbA9xIU06se5qv0V
 itAzbAEyOqWfsTfbpKqyiovXx1X9yIhonqmrLGcq6Dyg1FkMOGOJzyQWbDgTw+wg
 cA/0gia3iVeDHeMahCBjFsmJdYiC4wQrfPGZ2cfgyR2rZQXpCXcDOlPDjm9AWBE+
 mLxFeot6P/bqVXMtAEvg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvnqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c8a940e76so743525eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397025; x=1783001825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=dN6ESJwDUo5WslVldQKzIXvdN5VgpPK9uhQDezbxnLmvJbwijEkO/5MYMX+E+hHh+z
 iWN2WCNBZRd1RgiggXF8ZeVGnYuEgndF+/ncNREUrC9u56iVvMQsyndtV/hWSlKfNdzh
 Iv1acUv4odd5+IAXNgIfk+hvhCHjov+1EIA/b1UW+S9UhflcLYlrsES3GfoMtTbmphA6
 BGy9KUIT6Dw4V6LD5u+DPqaynZSnv0d3Hk0HOhSqLm5qke3yYxk0PIw5umuYbn0d9Uoe
 6V4kgEOoPhIG/UXN0NE9EqsIZIvbHwZDEeEMznQZZsmQ9ng10natHm2uf9PUb4IVLht7
 O73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397025; x=1783001825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=cpstXsWpvvMySU5PnZYsDV1Dx2Q75KDmbSGp6UawclgqSAyN5hLkWrYl87BWr1geac
 H4I42um1T3pcEx9UDw0vRY9Wt13vPfj91dcPRs9C/z912XUNWaY+zVg2MGpwH42QQ7oO
 38b/J4PByG8I2LSOp9A3PVESlxcsf71v01zi0FBEz34QxfOTGYlNZ8JLWNuLt/a33kMO
 F4BgdVn9+NOmEyZM2A1tSVh8BN1gmaWQ2pibavJ87cqf+GtLs5UI5GvR2gWyqexjxQV8
 /BS3zDA6LuqnKXJCZTTFB/Ln9CKMEjCyqL0qWJMh11elzsgPzCq3+6mbE413rPDpAoeE
 EqkA==
X-Gm-Message-State: AOJu0Yzyl1dZtXaQ3Au3oWBFvu3AmdgwgbL70Xn0LJKjvvkqVPwHDRYu
 UbS5EeTtwGQPjZpsLAZASpM93NtPtiIlRelDkQdBRVC49FL0SscwKsSWWopWhvQfhpzrhPasa3F
 rmmwPZQ//NrD1Eo7vuV1c7aYqveODdVJy20PQbTX/bW7vr7PK4WaUG5ogRbRZWGdmBA==
X-Gm-Gg: AfdE7clYpfxJ8ddW/TJuq7Xmtx2gjtznGf7pgWZzFGZQddi50uifVsV+vuwXOYiprwq
 Y7PRZIP5+jr8g9p0aCV2H4csu95yFXKDYLW+CPXDfeMYAUSaVpOi7ynJAyZk9khW04vg2ONLSJb
 00FUvjOdoteyMe5guW4+w/d5eIbSYN9dt8sDTRDwtv8BhF4ep5H67tYMGSqn/fPMfaxB0olnN2X
 i32IT3zrAFewEiHvaET4nDxTsHg1r5AWFR4E5Ys/4XvpOKEiDduaZ9FLHom9hOliZAP1hjaxLPR
 9qo82wumWeFEojiZS+mmJBUvWbIRy6UdL8w1GTvSHx8A739JkG8EqCqY95K1xQe23KRJo3yYVyw
 X+7aFMABfXy/979u9nHgelOmMIBk9H7pUDofMl/qVf+04sY06iRJtccuPuJg=
X-Received: by 2002:a05:7300:3b0c:b0:30b:6191:7f96 with SMTP id
 5a478bee46e88-30c84de5507mr2444315eec.30.1782397024453; 
 Thu, 25 Jun 2026 07:17:04 -0700 (PDT)
X-Received: by 2002:a05:7300:3b0c:b0:30b:6191:7f96 with SMTP id
 5a478bee46e88-30c84de5507mr2444223eec.30.1782397023430; 
 Thu, 25 Jun 2026 07:17:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 12/76] target/hexagon: Add a placeholder fp exception
Date: Thu, 25 Jun 2026 07:15:29 -0700
Message-Id: <20260625141633.449487-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 1ms2xGI5LkJAbY6QtuPz-8gI3HKFwtze
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3861 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1ygj6LqssG4g
 G32v6XCzVpqo7dedTlCaR20xKlOcy+sjen/taHYFLcss3HL3+SMoSVUJ3H0dTVQWh3KmHkp8R7r
 wPQ73Ha3q84Vf9ShxF68PYZk+umIoIw=
X-Proofpoint-ORIG-GUID: 1ms2xGI5LkJAbY6QtuPz-8gI3HKFwtze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX49N1zW074bWa
 M4LGSKj5Qvm68Ivnm3OhS20jIROgXTOUONdKGctT1CFQq73x0hPjWEJE49DL1UyRiKzx38eI10b
 BAUPr6coR3vvTBHcnNbt6xNrhWG6Z4Uka4Z3+6ueGEbs8tr3bJvV2K0kacUjwp15FMFCNdmDtud
 atZLhL5wpg1WscWT6usGEeDjcLPZx+Kn3JmjSNVlWey5SiNpGSMP3sT+JEQ3bOkheuIBVdn0Qqr
 z8uCVbtUCDUJndsmn/QQxkH9/fAUhJ1IUBZ5TaGdbKZV7hfJc10yHE678dzShZpkrvEbVbqhzaB
 CW/LrUxTUbahtwmhaSFKz9ynkAn6nZi8PHc+eEyrzjTlIRUDtrwAp+7snKU9vLPkWrVS8eo60ZV
 rGB5DACy3wksUgvhnPwRuJRSNf13Y4wE0zjlKuF2rhWVWZ3MtGlPaKqX6GXjdpy/o8YXjYXUxiK
 nuuVIb5NZgntQaxipsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

