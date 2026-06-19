Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E400CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCJ-0002fy-0A; Fri, 19 Jun 2026 19:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC6-0002Je-1m
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC4-0001eZ-E8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYCBk1336529
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=G4d6C9CeKkNlaO7I
 iOkkW5Sg4B35iYFoiTz8HPIuLw58DBRwm1DJm5xkMj5WvRfiZhmBZ1Kdbbq+Ph0X
 vZ06R0OSxEcSgMIYFEmyiE8BpbHNmcjuwIkGq9Zloo7GFHdqH1noUiLGchdf95Pi
 7XrWMPKIHSaKXJzoxK3roWIMh2utzOPTfquVnNnjWC8kEh1a9fOZiOgsqp7A/xo3
 wDSv2CxT9c4bGKG40gE4cTxFAUmzM1wCFeIKgmmjRb41fVm/6JZkwKN2d7zro/IA
 5Zfq0mhqGPD96cd2XSI4X0D07IMqvlM6z6l8ErCtNaojMEfKBFSV+krFjLZSXYu0
 tXCz/g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp675575-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso445506eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910000; x=1782514800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=hRWzRetOTQ4PWUdSD1Yzw5kG7z/fyVkeBBbTh0BneqQYpWXeSHE8xAbd8UqnDj83ed
 9maJSx0I2lPE2xPTADiCTbfujygI4LAQPrYuXTNIVxCjXMBgk9RvORR8gupuR8+PBVG+
 kRDH60G2EjIuW82mSo6JMLzJSkEz87Ve8pWDX8dbMpbJPTSZXsBr5muVk2s0QxjFAXRy
 pgbfrIKMNmIFH5adabDTMmEMuy7sLUlKm4rOusPNNn6iAzYjcgvTiNqmgWyf0Ay+w/P/
 lA+YhrD+eA8qzKdhHqZGcwr2jJP+R4MQ+pOIGvYhXxfDFjVcNlrx8m0vt6DV3EhSjbAR
 JcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910000; x=1782514800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=GbNjmTnt1IijL7LsRs7Q5kaEunMxZ7W8t9IkEagdqUVGh/cY7g2suRhb/6HuwstWRJ
 s7DlpJP3B3bPHMLSaAA2CXz+w+nRkyDJd6UliIb+3ebhRC406NAxoPDL6q85xeO0pEUC
 LDGAARHoW5e3pS3+Hl6Be+Qlr8Xx9rHN2wG0jdfjwL3l8idYR6Jjo7+B7MWDCIoUk1O0
 D5HKJDhXUtOhP5LmI4bVlPJKfFF6zXDa1zu1vZynDjXAx8L1s2PMk1w9y/BA6YAmUSTX
 6PnYJVQWD6mHs8oC4cb0nYCTtwyaJ3D+sSJzsY/pSjeJ2hF8X3I2kSlIZig9zZI3A22h
 /5xQ==
X-Gm-Message-State: AOJu0YygbxLkSa4AP7Lud7D5w4TZwoLTb3NScmXikvtS/31ceh2xOlia
 W/o9p/DM1M9Cdkd1jyFV8UgmmNBYnpvnOHoOgg0d2/VNpHshQryd2ZVlaJmLibnwdb14O6zJYrL
 ZUMhG1889PjAxDZKJVMmkGylfaELtH5R8fOoc80CsHYjQpRKhMI14iJLAbohVWY+MBw==
X-Gm-Gg: AfdE7ckXQGJEUA9BObaRZcyhpmiURRorzILk55GNefZJ9ooGrGsXy/c6i8pRdMqN7zD
 l1dHcf96PP00vVZAsEW6fvoZda5MzQ2BlaSiPjj3WGjpkWyXOCS3jm00XQR7tHXFTOzKkbs2u0x
 ZeGHg9q6DcrfRQBb7CaAvgEfdPEZ1ixJAMQwKC4jTgxWyH2MS9pezBh6V5tROArkeGLeh6OGNez
 2Qy/Tg4FXHpR7Yn2yQuFxnACeL0KtIkUD1IlVJKT4fzgIrtgiFqJSR2/DMuyVhkekbCzSKcembP
 9LkI/1BGqpDtd+63G/Q1CsitwdbaO7ZF0GUCBlazY9KmPM8QMWdnJSi19gERUb+qjuMsbhsbhbb
 iqRKEYfuW78GoYQh6c6Ul4joxGBFugdm7XrTlUfj6QW+pnEDzfMjTa4cocLo=
X-Received: by 2002:a05:7301:750f:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-30c079daeffmr1892896eec.16.1781910000017; 
 Fri, 19 Jun 2026 16:00:00 -0700 (PDT)
X-Received: by 2002:a05:7301:750f:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-30c079daeffmr1892887eec.16.1781909999533; 
 Fri, 19 Jun 2026 15:59:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 31/74] target/hexagon: Add pcycle setting functionality
Date: Fri, 19 Jun 2026 15:58:28 -0700
Message-Id: <20260619225911.159473-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 6_RY5lNTCb7rOE1yT-HNhpwa2fOiYfe5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXxOrxJrnACI8R
 VON244+JrdFd2coewcUigWkf6uzyTnNYrzdP1tk4MMlxB+/j/1Zxl7YdwqgVwDMIzocJp/ceig/
 XVCGtOK2UJbo6MugbfEjDmIsXm4zqnYX2QjsvHmBlixDVGUZJO/kGztJaFrS4HamnN9uorDkI8D
 RQyOKX/1WE+GoK1jdTvT2o2tEmxt8S+RZeYN9daYy+zt/7/gY/x112TB3Ux78+yhUSakYw5x2OW
 56IdtPPZ510IcZv3Z2+wUki1tV3HC10JPjPwBkV0n5e//qWk5/x696MrO994MsE/qyi1q0F9jcW
 evyc4ZhcDp+RMn8UZT6WiiGlrHUomTZtSaMxFP4x5Qiq3Q3j9ko+r8QYRkjPsVCH/B8g9Zz7NDr
 I6Wy/MYlFBhttx9Zy3ZOIQ6OFuImdx1tY9NpZiCtMmLKt++nJTa7buGumsEUiGaZ8i1nmrOV2/V
 zVvI7rBxy3SqOqZd9NQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX0/OXZ0I0elku
 8GR+kV89x+STuv3TGHUtJzk3FspeAtfLZVe/TcGFtK9bzhdCwPXMEDwJKEHrdEm3JKFqRzNHpPN
 OkQ6LQ2qiHZa6IUv7kWsC69RRRByYlk=
X-Proofpoint-GUID: 6_RY5lNTCb7rOE1yT-HNhpwa2fOiYfe5
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35c9f0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

