Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11BFFD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Arw-0000lv-Nk; Wed, 11 Mar 2026 00:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arr-0000l9-UZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arq-0008TU-BW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VBGK614019
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jKyRYhNa5c12K9+79BWJvOIpWMhQ09qP9DMLIfKwEqo=; b=L+LrE+L01zfpBVTZ
 g8nlHQ9/GSxzNp7/lw2bKDa0q52AoJ0W2dbZldtHW8sIv0JX1mPqzlB88mIk431f
 0U6FE9ikyReSohUOpVnVEuGSxkpD9NLRZy53iinOelL3Y2foQIGAM+nn53q3P+Vx
 O1r2ee+Jps4b/AWJcwDsBltvoP5qvdJnN3DPpiIhmOl3W+h9ThpmjhklleWdQCNc
 3p80S4B7MYsIcmWx4UVUVySMM2Zbs9h5hFAolYeHoRDsxgW5CVh3cIf4kfzMzXT8
 Dd/vsNX5Ahdg7NERHSIINY4eS7x/tFeFfmoJxcGHKx8bMz54A7I/UT6q5SvGqqNn
 6mbFvA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf03a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:16 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-45a8cdc7e01so113324023b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202096; x=1773806896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKyRYhNa5c12K9+79BWJvOIpWMhQ09qP9DMLIfKwEqo=;
 b=jUC0N/TzOYPLOyS6/J5nggsggyvzN4cqcIWa4skPoG5NPI+Sf0531C4QEW4RJKk+ZU
 1W+3HfGEMAuQsVj7n9hFdoK0a8h3p2Cnn7AbSCvKMjH2eARLqC3T2NcK0mere7735NQl
 RCP35lWhNGr6+3ig+92GDt7NjWOYnbtJwOf0yTjYp8Ongr6VyRayCAEh/J0IzP8UndGv
 ekewm4kqR/9WFIohE4XMG4/RSsPY2Rn1Lvp71IPc8ll1c+KQgeBTo4lz9bqpBpqFgGjU
 nE7tMclXv8NEXIlZcuXXK4kLiYZSsaj43cqYCo8imqxAP5R9WA8nl3KgafnoxRJ2Ak5x
 /ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202096; x=1773806896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKyRYhNa5c12K9+79BWJvOIpWMhQ09qP9DMLIfKwEqo=;
 b=u9qQVD0/9mZp/P3Lzoegtg2jBXoFMdMWkCJZphrgQU+fMlVepEm71i4qrX/qJZnyAK
 hU1Ff8K98mWnsBDDANKFCpwqz5NUdtcBpFqCgV6C6BUFCUIv37prs1UyNU2AuTe7Hvf9
 Y3Yl9Gf2T9RQs39GglJqZJo8s75dEI8uiET8gfMD8nRRrpH0nQGDWmAMO4q4OUXRUfZ0
 vleqF9TS+D/WHrJ7HWdD53HDwsK2jPndlHnXqNJb0phjKBt981EeJQqEmQdQ0RXP70hc
 bm154BNhS26+M0udt0+kFWb8C4KQzs4AgVN7Q2Q00DnD76URw6yHCBTaZ2O8zkOwYchm
 qq1A==
X-Gm-Message-State: AOJu0Yx9L8I3kSNPCJHJID9eSF2a10JD3ISOFLfLaDJ4w3AAg/WDFHdV
 xLpokLTPXgV//THhj39LYtnnueVUdZ+xafN+8XdCg0ojXZVEjMgPZsSXiQIfSZ8XDWRL/hYXzQt
 mxIjL6uUFwDxaLEaK/0FcMGlP4yevur9AJKevDeNYw/dExY2jtVkIwW6FkrXgoGjhzg==
X-Gm-Gg: ATEYQzy+GvdUewDm79Yj2oVIiD+FjW/aHTSBA+dmzm8XzEvmho5aAxgtFH9swqzAkCK
 hGX4AFxTQSfE7JqCh2rPXUX2FFTLsWTaJRLaMMspowEjzpKnnHiAKvfcSw/p/IcQ8EUyVG+YxZO
 n2QVnLvAlxe9zIyLF2j5oY5J67D+EVrIXx0wJ8HMaAfu6gP8P8E35MWctuUDonB//1f6ciyI5eP
 v3VGb8i4xREQVXkAS7CxeSzHu6ZsIlKR79+ulKrYD2ft8ba6d5sIjqOeU1id13KxeiOTIOmKm1C
 rO8ZVmVLCVbYAHvivbUevnCOVegKIUrihASvYXcODTKoEKKIQqY/GPNPBVIVU7EwSVL//FaERwn
 WLtVNyMCYqOhASss5veTFRsIpi26bgf/xYYpskE4hsBnXehTbtyNRvojFgmt0Z48/l+z4TQ==
X-Received: by 2002:a05:6808:bca:b0:450:42c9:4cd0 with SMTP id
 5614622812f47-4673359a6a4mr827960b6e.49.1773202096128; 
 Tue, 10 Mar 2026 21:08:16 -0700 (PDT)
X-Received: by 2002:a05:6808:bca:b0:450:42c9:4cd0 with SMTP id
 5614622812f47-4673359a6a4mr827948b6e.49.1773202095722; 
 Tue, 10 Mar 2026 21:08:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 07/32] target/hexagon: Implement get_exe_mode()
Date: Tue, 10 Mar 2026 21:07:33 -0700
Message-Id: <20260311040758.1068731-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: DS_DYsNqNLYJBie-r4tYSO0FTbVXSz6O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX7OgMBqjqLTt/
 wRQboZexAQ53NoNRXyt0r1z9o7NymEQZw5K/C9uRS6aD8PZbKp10781uWFezwTgSqer1rsZbkKv
 cSVw7CnMUEAl6i5GobRNZolSsiELaU/J/o30K2AL1+BB3DC37tMv4MTmRUuFsP9jN+OrrBbVlgj
 9/dCLaYRvA1U/3HJQXwlrsAgOAJkFFZuyP+5TmI4KEr8NyC8cCoQm7Xf9OW8SnVEPIerLNGl4jd
 UKK3tvnkNlJXpfvFKA2PV/qJhbYf7k7KPHPG82ESRpiIWcYn5m9ClA5n0GmDDT00tzfdL1RGTTf
 NPvVD65JNyuyHFxmqJC1PBcMDDCWgcdME/F6jzOpntPrnqGvD9WdNyjgfdqF4nTYzu4kWE1PHW5
 GLOA17WnOoGziXCS1nwdkOswTPlEkrf3FqbCLVFjKhBJcCNubldHLeelOoRk884Qt0qSSlXI6Dw
 8kO/1bGb/v08DB6Jz0A==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0eab0 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xNtBLlBv4CHGg5Otw5oA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DS_DYsNqNLYJBie-r4tYSO0FTbVXSz6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdV9o
ZWxwZXIuYyAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmlu
YwppbmRleCA5YjExMmNjZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3JlZ19maWVsZHNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCkBAIC0xMzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcs
IDEpCiBERUZfUkVHX0ZJRUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYy
LCAzMCwgMSkKIERFRl9SRUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmll
bGRzICovCitERUZfUkVHX0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklF
TEQoSVNEQlNUX09OT0ZGLCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwg
OCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19G
SUVMRChJU0RCU1RfQ01EU1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01P
REUsIDMsIDEpCitERUZfUkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9S
RUdfRklFTEQoSVNEQlNUX01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X1JFQURZLCAwLCAxKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGM3Mzc1ZGUzOWY0Li40ODYwZTRhNmFi
MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTI2LDYgKzEyNiwzNCBAQCB2b2lkIGhleGFnb25fc3Ny
X3NldF9jYXVzZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2UpCiAKIGludCBn
ZXRfZXhlX21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7CisgICAgZ19hc3NlcnQoYnFsX2xv
Y2tlZCgpKTsKKworICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAg
dWludDMyX3QgbW9kZWN0bCA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFnb25fZ2xv
YmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19NT0RFQ1RMLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpIDogMDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0bCk7CisgICAg
Ym9vbCBFX2JpdCA9IHRocmVhZF9lbmFibGVkX21hc2sgJiAoMHgxIDw8IGVudi0+dGhyZWFkSWQp
OworICAgIHVpbnQzMl90IHRocmVhZF93YWl0X21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9XLCBt
b2RlY3RsKTsKKyAgICBib29sIFdfYml0ID0gdGhyZWFkX3dhaXRfbWFzayAmICgweDEgPDwgZW52
LT50aHJlYWRJZCk7CisgICAgdWludDMyX3QgaXNkYnN0ID0gY3B1LT5nbG9iYWxyZWdzID8KKyAg
ICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX0lT
REJTVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7
CisgICAgdWludDMyX3QgZGVidWdtb2RlID0gR0VUX0ZJRUxEKElTREJTVF9ERUJVR01PREUsIGlz
ZGJzdCk7CisgICAgYm9vbCBEX2JpdCA9IGRlYnVnbW9kZSAmICgweDEgPDwgZW52LT50aHJlYWRJ
ZCk7CisKKyAgICBpZiAoIURfYml0ICYmICFXX2JpdCAmJiAhRV9iaXQpIHsKKyAgICAgICAgcmV0
dXJuIEhFWF9FWEVfTU9ERV9PRkY7CisgICAgfQorICAgIGlmICghRF9iaXQgJiYgIVdfYml0ICYm
IEVfYml0KSB7CisgICAgICAgIHJldHVybiBIRVhfRVhFX01PREVfUlVOOworICAgIH0KKyAgICBp
ZiAoIURfYml0ICYmIFdfYml0ICYmIEVfYml0KSB7CisgICAgICAgIHJldHVybiBIRVhfRVhFX01P
REVfV0FJVDsKKyAgICB9CisgICAgaWYgKERfYml0ICYmICFXX2JpdCAmJiBFX2JpdCkgeworICAg
ICAgICByZXR1cm4gSEVYX0VYRV9NT0RFX0RFQlVHOworICAgIH0KICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwogfQogCi0tIAoyLjM0LjEKCg==

