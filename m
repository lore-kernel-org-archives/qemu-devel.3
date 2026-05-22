Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXJi-0004Q0-18; Fri, 22 May 2026 17:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJe-0004PM-Sd
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJc-000315-9H
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfh7M3601580
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LNjQKScwg3LDIlG0Yj0s1V
 cGm0Q35RHNL4eDJJEtIvM=; b=DGnTTeTcP+kSlcSFwQZfxNa9PPfS3GJTgZ6K+R
 +cAZhlZK8hW8U+i74hdVR6qgiC+/7O1qD7UnAf1zEYHY15rM8ya4FdnfnP8Fkd3E
 uKegEHcqyrmQ7B79vEwZixZoQhdiEKuCVV1kgPlFGcP4hVD6icAcIDeHLgSRZjk8
 4FanVxG2jNdTaotOpIckr1XC4TRmG1ab0BBf8TAtPlGQvdCI/w+n7Sc+QkR6lx7b
 obv23VT1L/uPwuSwg3ajk566fkCNglDl9maX0U4Xm+hih/FxM55dWiB0LsvuDcWR
 lBThE0nfR6+woRZLeYnp/1nanVqIBnuAkKs1kxR2YVdpH1mg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury0ngm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bda35eab74so6798591eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779484912; x=1780089712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LNjQKScwg3LDIlG0Yj0s1VcGm0Q35RHNL4eDJJEtIvM=;
 b=I815tqYpqC7Q6N7t8L6DbTPt9C6WV8/ZU/Rh8u3xAq0qynk0ry/q9RrEGM8Q/iWcof
 s7pgh9XaG938Fc6djq/s+qA4e8f7A4kccywCS+F0uZqJkJc4Mp9O4mpEPnkb8JUn/XXb
 sh0bhQI9RdvIctRi120llYbW4mCXDL4vDjNXRTmanBOAyS2KVH1JRLZDhO8e9TlY7BWY
 BE07ToT0T6/ocyTRcu3A+rnURt/uQ1BD7cehxC53BT5BnqxtL/0OxpojtSBdAdkQbFaz
 5fiA5ZhI4Up4nHpet7jwlcBha5ZLte83PSo6oZLYtQLDafs9Wp2B/OZTXw8Ymmg3rKLC
 WjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779484912; x=1780089712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNjQKScwg3LDIlG0Yj0s1VcGm0Q35RHNL4eDJJEtIvM=;
 b=dvSywx2Kz0/56no66j6ZOOLeIXAihRAUfabyfSBOi2RQpEhEMGLgKkWRh6wmN+HNGX
 lzJHaEhBDL9fapWKI1nf6eeAzUDw7ScwT09ptBzExiCEXqtdO/ltHFUaSVbszR77EDHB
 QgpiUKulm/e8zuDUILlRyF+thQqWPoBJvzGP24tA3ajQ2dc1J2cSBt0ozdLbLn3O81Iv
 8dn2ghO24mEQIhB1n/7aCLfyawz4tfyOchgkM3n0xgVSZq3dQW5lYL4uXGSrQnla87g/
 ScpfwSzJs77feKOzYJjDWB/VPivZRdiM+95e+sdd3IwWXw//QqBiF9Fp0OrSDVmemKEg
 V3gQ==
X-Gm-Message-State: AOJu0YyYeWbwVlVPrS6BjcB+0OqciWFrBm8l4Qpvlvup8ARqBsukvUch
 EEubK6wG38wIbyohQf6W9qW9tGRrtNvca4hAGEJejQuEuX+RmijtN6O69kCmya9bxP1Ac4dwvOs
 dExPKUxF49r1GUbA3Zq+41nW2KAHhtDT7AlcMA4+JVf5VolroDP/zo8AYlggJ/ERxYg==
X-Gm-Gg: Acq92OHcDN1iewH/69ze21owUDlVfB9jHh9upN9Sc7IowVnO5zRpoxKxSYxCdkfg2jV
 zWoRvjln/Sldi8W5NYXhpS5npwtBaQ3jZoGb1bjjdhKl6F/URqZbAZXfr6OACxlQN22TA3WT67t
 xRLb13zpx3HRN/ZVuNlikTqW9jOn+uZZdfC7lTM5nAvMjzX8qJnHwROsq7PYCMmcDobhmxp7vqx
 877sCRuF7r707KQbJQaaYyWxOBjfRw4WzNbvaoAIscIhAHCCEFCdc4hx2K74VvqwShNbsh9+8dg
 9B+fgKG2TYInxulZZNL099Kz6TozZmzGf7b2Mddcskn+X7V94Jnw0mtFmDY+zOeGgwUSvNMsCnz
 0YfkaJwpCGWa+c+vdfk3Xv9Ahyy6juMp5GlSodrI/U81HCdy4oarBhAPWhwBy0Ca3B6I62Q==
X-Received: by 2002:a05:7301:1982:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-3044a5c1494mr2150253eec.12.1779484911998; 
 Fri, 22 May 2026 14:21:51 -0700 (PDT)
X-Received: by 2002:a05:7301:1982:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-3044a5c1494mr2150247eec.12.1779484911510; 
 Fri, 22 May 2026 14:21:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm3005755eec.25.2026.05.22.14.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 14:21:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org,
 berrange@redhat.com
Subject: [PATCH v4 0/2] Update hexagon cross container to 22.1.0
Date: Fri, 22 May 2026 14:21:45 -0700
Message-Id: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMiBTYWx0ZWRfX0OZpC1ISPiWD
 RW6q9V+i6N7fpQ8dB1T64pKqZDGVNxQrl9ZXN9/NGifgms+tRYlbiybCpUJPaIWycln/LkVpjLw
 +hVxoPz3uVfw60oRv3uYrDaTmmxPi4hJ/KKdyo9ZIk/9sP87IvNqc2oZlP33FiVTkXet9ThaHG6
 bg2LNAn+cDqxczF9jRxlLM+8OIau7M84RTcv2/tHgyN4ZyoWNP6WwqjhmW/Ok3ijsbDU80vx1nN
 /Uk6Sn4r5fepBLhp2tJRSb8XJ0Fs2Ok7c/PNakTcCfCBscw2QMecKBh4Tgw6qNV2Wi7amzBcWK0
 cCDC4oR7qtXWL1k3eh4UkU0c7aA+vvl6wNlujwDirik5U2VtEhhjodpfp8z13SCL78Mo0CRTZts
 K9z7pseiO/N+OSYsFBssXEf7pp57AKN00cbv3bAhQ417m65whcP4rGCOXwRjqLrbexgpLv7Vyul
 KiwpYj1SZ0QRZOcS4sg==
X-Proofpoint-ORIG-GUID: vLG2HUQjfA0DtY2fYOVkFdu3xvC7BpT_
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a10c8f1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=THJXtxu_gN-uaQjS0FAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: vLG2HUQjfA0DtY2fYOVkFdu3xvC7BpT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220212
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

VXBkYXRlIGhleGFnb24gY3Jvc3MgY29udGFpbmVyIHRvIDIyLjEuMAoKQ2hhbmdlcyBpbiB2NDoK
ICogYWRkIGZpeCBmb3IgY2hlY2tfcmV2X2dhdGluZyB0ZXN0IGZhaWx1cmUgd2l0aCB0aGUgbmV3
IHRvb2xjaGFpbgoKQ2hhbmdlcyBpbiB2MzoKICogY2hhbmdlIGRlYmlhbiBmcm9tIDEyLT4xMwog
KiByZWJhc2VkLCBkcm9wcGVkIGRlYmlhbiBjaGFuZ2VzIC0gbGFuZGVkIG9uIGJhc2VsaW5lCgp2
MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDMwNDIwMDkwMS4xMjgx
NzMxLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwp2M1tvb3BzIHJldXNlZF06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAzMDMyMTA1NTMuMjA0NDMxMy0xLWJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyNjAzMDMxNzU0NDQuMTU0MDA0OS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbS8KdjFbb29wcyBzdGFydGVkIHcvdjJdOiBOL0EKCgpCcmlhbiBDYWluICgyKToKICB0ZXN0
cy90Y2cvaGV4YWdvbjogZml4IGNoZWNrX3Jldl9nYXRpbmcgd2l0aCBuZXdlciB0b29sY2hhaW4K
ICB0ZXN0cy9kb2NrZXI6IFVwZGF0ZSBoZXhhZ29uIGNyb3NzIHRvb2xjaGFpbiB0byAyMi4xLjAK
CiB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyIHwg
MTAgKysrKysrKy0tLQogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0ICAgICAgICAg
ICAgICAgICAgICB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

