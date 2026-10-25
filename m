Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B039606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEmLlOyM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TCKs3U7s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosM-0001ka-2O; Sat, 24 Oct 2026 23:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorD-0008SP-FY
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor7-0001Xi-7p
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16Wdi4172763
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=; b=TEmLlOyMcDTBpECo
 sRaeVDq0LZIZW0GMOqfLPBJrMWMwiWgxcHN1stMJhK8lZ/vv5v5Om3+ZCqiYebLE
 8hj9FUn6exBqy/OVjOxM+F7XCiRLmc4ssur98wg9oVqFz/8S6TTELS0+OgMmomNi
 3wRcbJ1OW4BRW9sF6gTdyjuVWYehTHJCLAEM5RSja64aLQJ5dEvDfCt55JRneGHu
 pNED2Z+/Islln2eYiWjlVFPo0vB2gadFe0+k2+mDrmAAoOHSZxgGdPoGFDiG4ksU
 mD5ZZyCB9GMe3ct/lE5qA+VLvU7JiA8tM9DDthiHwwGW/aSWgZAjdEmN7d8Rj9Ux
 vnU9vw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgtnbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:57 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso3828611c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898697; x=1793503497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=TCKs3U7sYzcjn2gcwShiCOvGmMycJomFPLfEsmyIKAPnJgtDxUSjM7+jMBxtIrocFF
 KMpfHa3Wjw/oi6knaTAHGPgP48PkuzkmE+j4fJ0SZ8xhpCsn83hhLs0+hYRD/AcD6D3w
 1Ssxs5qHgVVE0o8QvQAMNhffJdhyaCc1lEZfCEdL2CGVbt32Czzu0nLQI7BLmfsNA7tE
 uWilJMxq48VRL+kejlswC9G5TtdA0RVfpI3o3+WC3bdU6DB7lTL1I/239/E224yu2eqg
 YASN0bRakLncL6Dcf48/9Sae5EOBJZR/HyRlZ9rTo391n690AVFC9RHy6zYOUo9Njbnl
 sC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898697; x=1793503497;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=eIUBCBcWewX7wHEZSrXUYKuXBERsq4TvioUXzqFYaXOYkhUCTx3HgpqENlvQyLNfZI
 I0E7XgiQIbvVGZu0yrbd4d+JaqxCGN2vf194dMAfA3IBAxZ3ogqQgBdoHWkgUib477ny
 S5eIoOZMX6CO8m0CZ5JnmQLJbjUoO6xflZSX/3KQkqEurKdzuG2dEJQBA8iViVw6eSoh
 6h+k9d/XJiRXdGDYg1+qI2yKtCK/NtS47XLUM8ha6GfUNrln5TnjhWgjI7jCvdD1+Yl0
 Rx/tBwPS7YXnjNt5hw6XXVBtQwLX5MGcEccOqQrqa2CT9GtGop81hRnWBBbHBvu7oFbv
 pQRQ==
X-Gm-Message-State: AFq9FYJBHvj9w0xbNhFKvrcFRwsyviejgO8Ra1jud1DHak+yd924kY5r
 wnfewZcA8HC4z4HRPC5E1S8bd+fU+E2QVAi+IoacnEO5xQnIE+8Xud+EIG5evl+hmPoFrfQw6Ey
 BbIapWnEGGZwxRtqUmfvalO8kcgIhOlqM6rM+kgQjbsDcuyfPvGg3rgbR84h2dftH8A==
X-Gm-Gg: AYBFou3inJ/37o/BkCVHClu2D+Pe4ttfchH1xa0lKLZvk6U6txlUyR2TY5UrbkPtiCs
 YPWjRPPLz2Pjz2UuQ1C8XN2OxDsFkmnfLJtnlDlTkgpevkyTDoNwhX6AM+mohaw4hmoA67HSFBV
 XoKnPWTPEKcC5vrb+c7GKywg1OulkSPt6eTpGG+eB36q0X1qIaDMsBoPlJohDm4Xww/MWSdKFTN
 2k3w4Ngm4aW5l4xiZfUoYeuVzVKzVPJ9v//vI927C6CpfIpb+Uk8mpCMwKqzqc9JN8f3DKieNMY
 fw8QSWVNqvG6YHxSP53gP2Suo6QFl/EGdTyvkqZK0+Optp8ADuLZpftIeqsGPvaZ+c/0b9y4WLx
 50J3NX+w/2d7V+YqCjKgyWu8ofhwGFdgmTryYCbGYBt1+ORE=
X-Received: by 2002:a05:7022:3a85:b0:14f:8d59:edcc with SMTP id
 a92af1059eb24-1993505de94mr5337397c88.12.1792898697108; 
 Sat, 24 Oct 2026 20:24:57 -0700 (PDT)
X-Received: by 2002:a05:7022:3a85:b0:14f:8d59:edcc with SMTP id
 a92af1059eb24-1993505de94mr5337369c88.12.1792898696411; 
 Sat, 24 Oct 2026 20:24:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 36/40] target/hexagon: reset implicit USR write state
Date: Sat, 24 Oct 2026 20:23:42 -0700
Message-Id: <20261025032346.2917451-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX2DaP6Gl46mjR
 z85r3kTvS82Gj/fE/34spwUhEyJuWCBfyxOivGc95GXccs0vxCZcP7ehbNxPV+4wC/TZNGNjXIh
 XsDMgObVNQs7I5eWYfD3rcpHmjoLVXo=
X-Proofpoint-GUID: ML9z1NZIfvtCYw_G0TICrxNRjbtMUa_F
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6add7689 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXyLJ0UDIdIoBl
 0NhEbjYz1EJQe09+d3/p7Mya8sPkFsxmTMJdwignfauahe1KcUN0OdOk827xLxhAjiQ4t3Q6/hz
 N7bF10dSA7JWeZtNjFiFzCw19WCw4cb42TDh/QgxLzQmGAwO8WCcTRRobj3y77KHB42Ce5CE1Km
 7DKsN3J2e9OWW+o6QM+BQ8EnixICB+kzA6PG8B02eOa6CoFhgy/yPQr0pyOOu7jDm0z8u2MV3Y2
 29dW2ENqGa+ydxHj3bwFNMNoILgmcekoD0ox0qi3kpg+iDbKgvdvIi/M+RUJWUc004+WwgE2KIy
 3KK8zhQM0ECt3Qv25syh7Et4YX1o7D15YCxHXnwPTx7QfKfX6NGBy5iYyDbTurHBqnKDyPlkgxq
 lFbzS42hL/o6U+VrZ/7d9RmqLXCKMEQtOCzHUb8K4IZi7BfBNjOHaIo8uio1yXDINoHqd9hqsL2
 ksu4FHR6/sB3Gwn7zdg==
X-Proofpoint-ORIG-GUID: ML9z1NZIfvtCYw_G0TICrxNRjbtMUa_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
YWMwOGViOTFiOTYuLjA2YTNlZDU2OTYxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNjQ5LDYgKzY0OSw3
IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3Jl
Z3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUg
PSBmYWxzZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0t
IAoyLjM0LjEKCg==

