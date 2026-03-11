Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABBFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B3e-0006LE-Rl; Wed, 11 Mar 2026 00:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3b-0006JQ-G5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3Z-00030n-8U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2VNoG1572930
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=6ZC4QHCUzDz
 tY0q7CxwOVvUOMqctdLaCLCew76oDejg=; b=Ku4kG06NJYgr3/C3L/+9HIXTWK/
 K8lGmDlMS0NEkHCgeaUjooXX3mt4h7BnaJyssYlZGI907wXiGpf5Rozx6w/fwuO3
 /IjnH5t+G05WI0AqzYxDmzIQrqlk62Ha9sYZ22md28hkqA1erqB6pfNxDdyhMV+L
 stjY9p8xIXXYNiIgvl6k0b2gaet5dvj7wC7YLoO5O8EaQpUoIYl+jOZvxACokIwm
 yQ/ASUweumM+Aikk8/L3FTUMhA2eas7FE1uoWsS3+LhRYnNRYH2MZpSXnTlXWmWk
 qzeMNARN+L+ABr3/HxzAW4ZxTPE9X58uwl0GIegg5FOQ/JR7mjm/JP3qbAg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9w0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:23 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7543bc61cso24311025a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202823; x=1773807623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZC4QHCUzDztY0q7CxwOVvUOMqctdLaCLCew76oDejg=;
 b=dc91YFyBh5dpPt4UrO1mmVGvxKJEmVh2268dQbsYh7E2A+dsqiAKxJLdi05E9pIoqw
 u5z+Woh1uErChRSXEsFJoM8K2r07Uvfx5jiVRTO5XBv+R8z1J1MFJKtRSdVpI/5Ov6N/
 7GJL7hiqG2Ph//ltIBWlj/1m1SZJL1G0oGwLkxZWVyU8ebUnhF/MMD+MRL/efKyP6LT6
 ksMv4mNj3N10nx4DhqqoAO2frekhAqHVCWH8dspjtWm+2RPqTNciryC81rpPSndXfWOG
 lu5nrmsRJebJJaJhpqN56BieS3L5ftZJAB7uTKuH8q8pS6rPPcI4+owsIHY7YkyJThae
 t/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202823; x=1773807623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZC4QHCUzDztY0q7CxwOVvUOMqctdLaCLCew76oDejg=;
 b=uqOTM7CHS5CD5tZgd40lunMviiIALRzh8flifzr6zZh/5Dsm1HL3MFFwFLqtAecPZ8
 N3a4MtKg9eyNo/LyriIUWZvycs5no+yZYLAV1ngj1B3CHJFWY9W1vkjLFT99Rib+u7EA
 U6pDbXTlFuC++kJpgFZOhv/o4O4IcrKeJRULBaySOJHPa7xcLeSEh0QGx9fZGA2tbyQg
 /7AukyJCdBzaLoODWNn6MegD45oooaMU4DdbrNMMqWURZY+WBguY1+yOyt2ZgEbAY9jl
 ZLkAA2gWCn2kRZunFqGVedc1qHOfag5mk+m++TAQmdRECkgTCFMX4jISPmMg/DiYNH/S
 gd/g==
X-Gm-Message-State: AOJu0Ywmh8I95eZzdP35uVQIsq2Osm10kXWSLD9Ux79Vz05D7Axz3Lbe
 kiH7eLPEobo95kt8RGbyGwZlAUXXmT2rSKMvwbRGKpIBkBc4w+xq1BWpwtgP6nbulOB6YgHgRdi
 RqRH/pRpMEV3+Ezgoj99TZh/sK+m0ud5HbUAr7h//oG7h7bMM5kZ6qzDA9+L1dDUQpQ==
X-Gm-Gg: ATEYQzwkrKifVxMj0ROVw4XqARAPm8HLRrTY8M55O6ajesmn10gI5IenOhLD2RP+dui
 ZraU4vqR7GrsjbbZRfUgzV5x2+Rww/SmrsMd4PFw+u6EKhD7ogfOvx7F9xIrd9Oa+SYKo6nmO3b
 hF3ELos88cs6WHUjfLOLuA0OdGh+aXDCjpUriqIWb8I1sXg1OAunjVieoTDBYrwi8LBskYsGxvD
 RKYcJHdbprIuUqND0dr0jM8ELAcHcrhVAqtJEgThNflE9DWueIqXFhmLnaIKCDYVfW1W1/juId8
 Kg0o8FuPGlrrrUe14uK+RgiPyieMsnj55SPvBAMHycnnxv3/qrneU/siZuWJgoyay5wSkgSXcmS
 DM0tICrfPu3Nmt7So4RaR41kaC+Lv39pU3K6FF2TnWYCCIXSirTDSncgQnIqPDRF0tURyNA==
X-Received: by 2002:a05:6830:700c:b0:7d7:5559:3d1c with SMTP id
 46e09a7af769-7d76a5a42edmr1004439a34.1.1773202822675; 
 Tue, 10 Mar 2026 21:20:22 -0700 (PDT)
X-Received: by 2002:a05:6830:700c:b0:7d7:5559:3d1c with SMTP id
 46e09a7af769-7d76a5a42edmr1004424a34.1.1773202822316; 
 Tue, 10 Mar 2026 21:20:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 0/9] Hexagon system emulation - Part 3/3
Date: Tue, 10 Mar 2026 21:20:10 -0700
Message-Id: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: qQ6dUITENVtsUCfOqlBRIsJMUx9IvBGk
X-Proofpoint-ORIG-GUID: qQ6dUITENVtsUCfOqlBRIsJMUx9IvBGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfX/7wii+0YR27g
 03fznG8abSQ5jFO++XGgCG+REcjsKbmPwFLs19qCm68bg9+LWGd67VPy7idO9DhBTQg//tRC63Q
 gBwWv3aAVSKLjjAVrwkgdHuWvd4cIY6VNp/u8iWflGHqPIqSHGYmxQhTEBSBheyN8rUdWHUFLiG
 k7k2eDbQxONr3uJhQNEQyzhW87qsKYtaQeZ+pfWCi0eFRoMZYE0EYx8HgvN3Ct0QhOa26OqOYC1
 hkw2fw+2iYchZoZYnntOwvIpYCPzT7QQ+eI8+CBjix3sd5+sEXn0DP5kee2qMBEwLjq6XPaI+bP
 nsAj+SaGAZJKAFrcoZ3Ua+3F/r0QHjBPC0YKO0/lwVzvENnJbMg184CRs7ikCSkhABBxpAqCXCX
 Irx/ynE3/rHr3q7AlZG5O0O1OkWOR/qS4LliRpTBClNUnKRHZ+lzM0ejoTIXFP1e5pgfkfCmZ/P
 OaIP5BzIZ1RI1zJTrDw==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0ed87 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u0mfFI38COpXtrgxlx4A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VGhpcyBpcyBQYXJ0IDMgb2YgdGhlIGhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiAoc3lzZW11KSBw
YXRjaCBzZXJpZXMsCmFkZGluZyB0aGUgaHcvaGV4YWdvbiBib2FyZCBhbmQgbWFjaGluZSBzdXBw
b3J0IHRoYXQgdGllcyB0b2dldGhlciB0aGUKdGFyZ2V0IGluZnJhc3RydWN0dXJlIGZyb20gUGFy
dHMgMSBhbmQgMi4KClRoaXMgcGFydCBhZGRzOgogIC0gR2xvYmFsIHJlZ2lzdGVyIG1vZGVsICho
ZXhhZ29uX2dsb2JhbHJlZykgZm9yIHNoYXJlZCBzeXN0ZW0KICAgIHJlZ2lzdGVycyBhY3Jvc3Mg
aGFyZHdhcmUgdGhyZWFkcwogIC0gR2xvYmFsIHJlZ2lzdGVyIHRyYWNpbmcgc3VwcG9ydAogIC0g
TWFjaGluZSBjb25maWd1cmF0aW9uIGluZnJhc3RydWN0dXJlIGFuZCBzYTg3NzUtY2RzcDAgZGVm
aW5pdGlvbgogIC0gY2ZnYmFzZSBzdXBwb3J0IGZvciBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGJh
c2UgYWRkcmVzcwogIC0gaGV4YWdvbi1zb2Z0bW11IGJ1aWxkIGNvbmZpZ3VyYXRpb24gKEtjb25m
aWcsIG1lc29uLCBkZWZhdWx0Lm1haykKICAtIFRoZSBoZXhhZ29uICJ2aXJ0IiBtYWNoaW5lIGRl
ZmluaXRpb24KICAtIEEgYm9vdC1zZXJpYWwgcXRlc3QgZm9yIGhleGFnb24KCkNoYW5nZXMgc2lu
Y2UgdjI6CiAgLSBEcm9wcGVkIGwydmljIGludGVycnVwdCBjb250cm9sbGVyIGFuZCBRVGltZXIg
ZGV2aWNlIChkZWZlcnJlZCB0bwogICAgYSBmdXR1cmUgc2VyaWVzKQogIC0gUmVtb3ZlZCBodnhf
Y29udGV4dHMgZmllbGQgYW5kIGh2eC1jb250ZXh0cyBwcm9wZXJ0eSAoSFZYIGNvbnRleHQKICAg
IG1hbmFnZW1lbnQgZGVmZXJyZWQgdG8gYSBmdXR1cmUgc2VyaWVzKQogIC0gYXJjaF8qX3N5c3Rl
bV9yZWcgY2FsbGVycyBub3cgZ28gdGhyb3VnaCBnbG9iYWxyZWdfcmVhZC93cml0ZQogICAgZGly
ZWN0bHkgKHRoZSBhYnN0cmFjdGlvbiBsYXllciBmcm9tIFBhcnQgMiB2MiBpcyBubyBsb25nZXIK
ICAgIGludHJvZHVjZWQpCiAgLSBBZGFwdGVkIHRvIHRpcCdzIGhlYWRlciByZW5hbWVzIChody8q
LmggLT4gaHcvY29yZS8qLmgpCgpQcmV2aW91cyB2ZXJzaW9uczoKICB2MjogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDkwMjAzNDk1MS4xOTQ4MTk0LTEtYnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tLwogIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLzIwMjUwMzAxMTcyMDQ1LjEyOTU0MTItMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20v
CgpCcmlhbiBDYWluICg4KToKICBody9oZXhhZ29uOiBBZGQgZ2xvYmFscmVnIG1vZGVsCiAgaHcv
aGV4YWdvbjogQWRkIGdsb2JhbCByZWdpc3RlciB0cmFjaW5nCiAgaHcvaGV4YWdvbjogQWRkIG1h
Y2hpbmUgY29uZmlncyBmb3Igc3lzZW11CiAgaHcvaGV4YWdvbjogQWRkIHY2OCwgc2E4Nzc1LWNk
c3AwIGRlZnMKICBody9oZXhhZ29uOiBNb2RpZnkgIlN0YW5kYWxvbmUiIHN5bWJvbHMKICB0YXJn
ZXQvaGV4YWdvbjogYWRkIGJ1aWxkIGNvbmZpZyBmb3Igc29mdG1tdQogIGh3L2hleGFnb246IERl
ZmluZSBoZXhhZ29uICJ2aXJ0IiBtYWNoaW5lCiAgdGVzdHMvcXRlc3Q6IEFkZCBoZXhhZ29uIGJv
b3Qtc2VyaWFsLXRlc3QKClNpZCBNYW5uaW5nICgxKToKICBody9oZXhhZ29uOiBBZGQgc3VwcG9y
dCBmb3IgY2ZnYmFzZQoKIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDMgKwogY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayB8
ICAgOCArCiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgICA3
ICsKIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
aW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgICAgICB8IDE1MCArKysrKysr
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCAgICAgIHwgIDU2ICsrKwog
aW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCAgICAgICAgICAgICAgICAgICB8ICA0MyArKwogdGFy
Z2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCAtCiBody9oZXhh
Z29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyAgIHwgIDY0ICsrKwogaHcvaGV4YWdv
bi9tYWNoaW5lX2NmZ192NjZnXzEwMjQuaC5pbmMgICAgICB8ICA2NCArKysKIGh3L2hleGFnb24v
bWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jICAgICAgfCAgNjUgKysrCiBody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwgMTgyICsrKysrKysrCiBody9oZXhhZ29u
L2hleGFnb25fZ2xvYmFscmVnLmMgICAgICAgICAgICAgIHwgMzEzICsrKysrKysrKysrKysrCiBo
dy9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNDUzICsrKysrKysr
KysrKysrKysrKysrCiBzeXN0ZW0vcWRldi1tb25pdG9yLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgIDEg
KwogdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jICAgICAgICAgICAgICB8ICAgOCArCiBo
dy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGh3L2hl
eGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKwogaHcvaGV4YWdv
bi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArCiBody9oZXhhZ29uL3Ry
YWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGh3L21lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgfCAgMTMgKy0KIHRlc3RzL3FlbXUtaW90ZXN0cy90ZXN0ZW52LnB5ICAg
ICAgICAgICAgICAgfCAgIDEgKwogdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiArCiAyOCBmaWxlcyBjaGFuZ2VkLCAxNDY1IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy9kZXZpY2VzL2hleGFnb24t
c29mdG1tdS9kZWZhdWx0Lm1hawogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvdGFyZ2V0cy9o
ZXhhZ29uLXNvZnRtbXUubWFrCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhhZ29u
L2hleGFnb24uaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQu
aAogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3Aw
LmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjZnXzEw
MjQuaC5pbmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y2OG5f
MTAyNC5oLmluYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vdmlydC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4
YWdvbi9LY29uZmlnCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tZXNvbi5idWlsZAog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vdHJhY2UtZXZlbnRzCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2hleGFnb24vS2NvbmZpZwoKLS0gCjIuMzQuMQoK

