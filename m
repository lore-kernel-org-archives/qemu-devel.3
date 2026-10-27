Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p8YWFmrr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BMH4/CCZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXu0-0004ci-HM; Mon, 26 Oct 2026 23:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtc-0003rQ-U0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXta-000091-TX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F2JX512082
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=; b=p8YWFmrrEFsSrwjN
 nXZkAK4De5EYBOEusx895I6v8CDy0fJo8hJqKvk92XJ+hibJoUo4VfuCxU4t7IUp
 00wYjO/NTyis7wDoXhLnW9A0eMy+1HmJGh/kmdUfSVzhk+fw8gDr2JAsNkd0Z7VF
 S9gsJ5gGC3wrYilmpwHPeh64wvQbwjMvoHybrEnydxkjtm5plqZVv2Eq616YW8mJ
 T1U18RaXkiY3f7QQRvjS42Twd4DKBaPriDOZ78FTob3xmtjrFO8CjFbglPr2uVpa
 a5yuRbJrflG80YaYMJUslegue3AqsPiiYelJ1aWlTj5u8aHo/xvX4XwDNm9ZkYUY
 k8yDcw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpbmch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:31 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so1724139c88.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071831; x=1793676631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=;
 b=BMH4/CCZBGVQfh6Ame1tHTIizcUdsTjevnak/z5qejn/+Bwi9e3FU+BV3y9VMdXxkR
 6OSU3izRwvddiCfuk+iLJOVDJgmJn1b+jz4lcLWjFKdx8/BcFf4sqn22Wkeb/BNPWE0j
 zSTPXRmq4VHHrFd4cI7sxUtD+1vcHOmZgRMN1RXlSvzW6bSA3EjU5ff9atQ1lffOD0Ky
 yA+bLy+D+z07XTsX7oAGd21QIQUI9G2A6s6IkBajUQ/khkU3SO5uL6z7j9RlHQYCLmDB
 UcKFExH61bhz5FqkMNNG3reX7GbYrcqGmLlL0FeviqNAR0yXW2kgfWu73aZ/yKuKfo4l
 TlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071831; x=1793676631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=;
 b=ZFCnwqKuzbaB6GAb/UwEAzMQW1Glsw+zB/AtR2Q5OESASR6hAcMARm0O21akVhb5dx
 LAmDb9FQsRXaRADGF5abPgdMzRv6fcUzeML97pk6C3tT9O4IDfOfZ7CM3/RxjZTE08Cg
 Ixj/gZsD7vHRBPJ89myis0sTsNyC1u9KElDKVgBbJtuf8ZxCjOSlCaBB3LDFZiFPz/kp
 NCavFuxXtioMiDkkzWHomPp2MfDuFHSuQbWj9bzOncasXWeg60qqVfNCnPfG4XJoi0HS
 dUDKm0nyUZOG7C8TEWW9CHHrwAfszeZ0v0GISITBDZWk/fAkF1Ii10e/jb76LMiUtUnL
 DMbg==
X-Gm-Message-State: AFq9FYLWbsBAokK7fykYztji0PRPEfMF6EcwxOI7eQ9MP3cHzMx/YvWM
 pMbqra96itiXe3BZ/WbQOdZdj86+1bqCdkfFtwXMoPVrzqIJ9551tSNYyV8LiBViQ7xAegQkT2S
 7D0TH9usvNXPhqzYUXsZx1pEetuMqEUwcJy7JhWYMWBvzoaxXD6SJIUj8JW7osjL3Pw==
X-Gm-Gg: AYBFou3ToRa1R0W/5m5WLCXxnMyNPcmL8oyEZIDEppMM2iy/8kb5/SUYUsh4T9xsGl7
 6OeZn7Cl0lYl27K0c3QxFxaFRFyWa2UKV/4VdU98Tu2+LhEJGfuSNP7KZLwFRE+xHt1PggSq20v
 Sh0Vlar9LQfwtmnhW/TyIbY5KNbB4wkPHdblQVp5+X8p2LsmD2lTKMa7iyGNU6YaYfu5lSv6sXO
 BV6OEZmqjwnES2EDPjOb8zHwC71CplU5dbDWpLLOrWOUf0gOZrsmhbfsXSRz2BrS/4ZBuat255M
 h/suddF6keVojUexRDUd3HM3oUxDyX8EGrDM9CvoQajipKC/kYnRsEczI/QBgWPHsrt0+synuMN
 YJ4EXX56/JWMHq47+zMkj35QpGCLXDdqySTLX4gARevXZZ6M=
X-Received: by 2002:a05:701b:4591:10b0:143:5266:48ee with SMTP id
 a92af1059eb24-1994006f186mr11647884c88.42.1793071830589; 
 Mon, 26 Oct 2026 20:30:30 -0700 (PDT)
X-Received: by 2002:a05:701b:4591:10b0:143:5266:48ee with SMTP id
 a92af1059eb24-1994006f186mr11647845c88.42.1793071829887; 
 Mon, 26 Oct 2026 20:30:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 29/41] hw/hexagon: serialize config table as little endian
Date: Mon, 26 Oct 2026 20:29:15 -0700
Message-Id: <20261027032927.3055166-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX/YCANlBF0dic
 VyLMqYeUznxR5Q0kw8x5O9RrnwAo9e7kKHqUA0gmbuYudint3v0f86Xpwq1DtawTP00b4EBBa7h
 hIkuqrBcnEoLcJ0G8dCdiMoyRi2QZjtwtEhdDz5Pxvex5QxcaSG15H5zPpuoszT5eSTubDuUwbV
 YAwRYDlEk/lgj0HScu+noLmVq5DytESrEHuOPVfVPjWPyph2dXB6mTIKzaXEDtF3WvGoMzJrEuc
 WZuwzd56dmg2gNEBHYvrglvPY5beC6b6BqIad3vuooQbeRKPUEIX714Y5oOLrzidIkdOODHY9d3
 8DrIpHmBRP/jEn+x1LBG9AEpapCZr8zsdHD5LHRGewXQ166Aca4WZX8ysDuPgwjljKX1XnwRZFk
 Vp3Si1yUz206y6TtC6sy4sfdqx5QFA4YankM809Dh1Pw3Cd89d4SwEOe/pvc0l2wPyOkJ7tqrwT
 hKj3nezAenIjffElr3w==
X-Proofpoint-GUID: loDsWGHrFtR89lbR7Z3NveJAl_jL5LW1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX/GegH0j85mWs
 Yq09Cca7Bv5YqEfTOIoYGW9sOG7hYhA9RukXNflBq/Mg85Yxt8RijWlNsth7zAk8LS7SpSquyP8
 MpkXrs0ak7cXqj29d44TmjJ5gTPc3jk=
X-Proofpoint-ORIG-GUID: loDsWGHrFtR89lbR7Z3NveJAl_jL5LW1
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6ae01ad7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5Al4mlNl2lj96zGDs44A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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

Q29uZmlnIHRhYmxlIGVudHJpZXMgYXJlIGhvc3QtZW5kaWFuIHZhbHVlcyBidXQgYXJlIGNvbnN1
bWVkIGJ5IHRoZQpsaXR0bGUtZW5kaWFuIEhleGFnb24gZ3Vlc3QuIFNlcmlhbGl6ZSB0aGUgUk9N
IGJhY2tpbmcgc3RvcmFnZSBleHBsaWNpdGx5LgoKRml4ZXM6IDE5Nzg3MDM0OWYyYiAoImh3L2hl
eGFnb246IGFkZCBoZXgtc3Vic3lzIikKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgg
fCAgMSArCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgIHwgMTAgKysrKysrKy0tLQogMiBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmgKaW5kZXggNTQ4MTM1YTdkZDkuLmM0ZTc4MjE2ZmI4IDEwMDY0NAotLS0gYS9pbmNsdWRl
L2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgK
QEAgLTE3Niw2ICsxNzYsNyBAQCBzdHJ1Y3QgSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSB7CiAK
ICAgICBNZW1vcnlSZWdpb24gcmFtOwogICAgIE1lbW9yeVJlZ2lvbiBjZmd0YWJsZV9yb207Cisg
ICAgdWludDMyX3QgY2ZndGFibGVfZGF0YVtIRVhBR09OX0NGR1NQQUNFX0VOVFJJRVNdOwogICAg
IE1lbW9yeVJlZ2lvbiB2dGNtOwogICAgIERldmljZVN0YXRlICpjbHVzdGVyOwogICAgIERldmlj
ZVN0YXRlICpsMnZpYzsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jIGIvaHcv
aGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggMzgyZjQ1YmQwOWYuLjFlNjU3ODI1NWViIDEwMDY0
NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhhZ29uL2hleC1zdWJz
eXMuYwpAQCAtMTM1LDYgKzEzNSw3IEBAIHZvaWQgaGV4X3N1YnN5c19jcmVhdGUoSGV4YWdvbkNv
bW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAogewogICAgIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSA9IE1B
Q0hJTkUoaG1zKTsKICAgICBNZW1vcnlSZWdpb24gKnN5c21lbSA9IGdldF9zeXN0ZW1fbWVtb3J5
KCk7CisgICAgc2l6ZV90IGk7CiAKICAgICAvKiBNYWluIEREUi4gKi8KICAgICBtZW1vcnlfcmVn
aW9uX2luaXRfcmFtKCZobXMtPnJhbSwgTlVMTCwgImRkci5yYW0iLCBtYWNoaW5lLT5yYW1fc2l6
ZSwKQEAgLTE0NSw5ICsxNDYsMTIgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhhZ29uQ29t
bW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbSgmaG1zLT5j
Zmd0YWJsZV9yb20sIE5VTEwsICJjb25maWdfdGFibGUucm9tIiwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCAmZXJyb3JfZmF0YWwpOwogICAgIG1l
bW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXNtZW0sIG1fY2ZnLT5jZmdiYXNlLCAmaG1zLT5j
Zmd0YWJsZV9yb20pOwotICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJv
bSIsICZtX2NmZy0+Y2ZndGFibGUsCi0gICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZiht
X2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKKyAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0la
RShobXMtPmNmZ3RhYmxlX2RhdGEpOyBpKyspIHsKKyAgICAgICAgaG1zLT5jZmd0YWJsZV9kYXRh
W2ldID0gY3B1X3RvX2xlMzIobV9jZmctPmNmZ3RhYmxlLnJhd1tpXSk7CisgICAgfQorICAgIHJv
bV9hZGRfYmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJvbSIsIGhtcy0+Y2ZndGFibGVfZGF0
YSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBt
X2NmZy0+Y2ZnYmFzZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNl
X21lbW9yeSk7CiAKICAgICBpZiAobV9jZmctPmNmZ3RhYmxlLnZ0Y21fc2l6ZV9rYiA+IDApIHsK
ICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT52dGNtLCBOVUxMLCAidnRjbS5y
YW0iLAotLSAKMi4zNC4xCgo=

