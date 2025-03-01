Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D0FC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPk-0000yv-Aw; Sat, 01 Mar 2025 00:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPi-0000sj-9W
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPg-0008RP-DR
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:25 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213PcDB006204
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J9lT4pD85JDzd+C9/1NMDo+QZ9q6Lc2vvZEMBtVYzLI=; b=WUfhUUK4d9ICVGst
 Fo6kzGDkYElxqPT/8ikbIB9V3WrCdqln/Duo2yjl+PNdT6MnyLWtrBK9BR4C+FVh
 FQIPZnX/vrsTPHrXx3WQmra5o6jHnOpDhQnBBeG28+BPV8d7C+2EGswixNmy/Zkl
 VDZD5R2VBa/fJZcbl/JpWG8Fk2+Aq6jmjXIgIin3IamUPSQ6+A11eAKQthXHwkzP
 hArgnI/E8qU9LrM1bKNCILThT4+AnHw/Yf3t8eavREG+0N2rX8s7wPvbh/3gSgwG
 rw2e65xsMXCfG2R5EBExz1N8nYOXtTqMZAyyqxIklUOUeNBLDdOZctWOfBTQ9nxC
 NaYcOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas85tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22366bcf24bso31598025ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806962; x=1741411762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9lT4pD85JDzd+C9/1NMDo+QZ9q6Lc2vvZEMBtVYzLI=;
 b=jpfi+iZTijHmhev+7a8Ri/oQNwKo+lcKEmNhIdxosFczTdmeCb6VQmw+7IQvXnFH0n
 LlrFRZ6upbH961PGLR0fpkDPHT2QDSFPBD3hbZkIOrOmngMvch/EPeFiM+kYDeWktZ/m
 +nKk6VlCrqBt5uGD9T68N7DWMyEAXnUtgg/Wy1xqNI/v0E6wlUtdc+LHLF72LEkDVJO4
 gx7Zz7zsRoWV4prgXRTpn0kAzsJ5sGkixo945kDkQjq++ItoDYWtCUoA0EpbC0T24cIJ
 KZz48FkQUAAGXD+GzMDfW9JIfbbl2fMRrIQnQ+ulOxUaCGBh2dyaST64q9SnLGta7JWS
 58eQ==
X-Gm-Message-State: AOJu0YzomznfJQaTyDHHD905cClS055JC0qy0y3r7CWhninJ7H+yKFZ2
 FvV5e1whXP6J2WTN4o0/MeFFvXcOciHxrEF7WSzcA6AatMsnpe9QEYGjfY1qEebsvPKOJI6KMxq
 E0zfODrr4bEpzwNUdXZphXbnr9H5yIdy7aU99eFp/jJ+IFAo9zWv25LKP+Y3zJQ==
X-Gm-Gg: ASbGncs65FnKz+wuGusJYfl4I+OPZQ5Y4aT0eg0M6hXk2WYH6ehOG6UKsFPgYB2r2L+
 8jWoYWkcsDmFzMxl0XfZsx98TMC1b2Kwob1ktpGYv8FNRWICyf7t7/QP0+nlIudjq7uWWGgCuJ+
 3XB4uGNGzz6zfd1ytDrdMcjMojG+Qzf8rNnUpcVKi1FgNsBrurrZFrRM+EX3/fRI+mWFQOm1fue
 lcLMopmYGhWhPciNihZVF0Wi+K9zBK52NcAxw2y1camBn9F35SPcBF6+mh1pqfPR6F2CAOcU02i
 GeJuavMvgk/jvjm+IBGY/lb/LvfN/FxZuhBeuhEktKsdXEQ1olDfCSXGxKdmnDhH
X-Received: by 2002:a17:903:905:b0:223:6657:5001 with SMTP id
 d9443c01a7336-2236920c423mr83888925ad.40.1740806962000; 
 Fri, 28 Feb 2025 21:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5lCZSLTPI42RvPVhrPq3VAUJHGAtR4zAGCz7a6RTBsB/jUFDcNK6lqafiW2F+h5FczyRPZg==
X-Received: by 2002:a17:903:905:b0:223:6657:5001 with SMTP id
 d9443c01a7336-2236920c423mr83888735ad.40.1740806961630; 
 Fri, 28 Feb 2025 21:29:21 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 25/39] target/hexagon: Add hexagon_cpu_mmu_index()
Date: Fri, 28 Feb 2025 21:28:31 -0800
Message-Id: <20250301052845.1012069-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xXb1Kdbp4E4rTXB-xQUCjA0xGB7q9ETv
X-Proofpoint-ORIG-GUID: xXb1Kdbp4E4rTXB-xQUCjA0xGB7q9ETv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=954 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5oIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgIHwgMjMgKysr
KysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCA0MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDY1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKaW5kZXggMDcyMzQ4NWU3OS4uMGE1MTM0MjA0ZiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuaApAQCAtMTUsNiArMTUsNyBAQCB2b2lkIGhleGFnb25fc2V0X3N5c19w
Y3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90KTsKIHZvaWQgaGV4YWdv
bl9zZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
KTsKIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCk7CiB2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CiBpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKIHZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCmluZGV4IDdhZmRjYmY5ZDAuLmM3YzQ3MGIwOTkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC02NTAsNiArNjUwLDI4IEBA
IHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewogI2VuZGlmIC8qICFD
T05GSUdfVVNFUl9PTkxZICovCiB9OwogCitzdGF0aWMgaW50IGhleGFnb25fY3B1X21tdV9pbmRl
eChDUFVTdGF0ZSAqY3MsIGJvb2wgaWZldGNoKQoreworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9l
bnYoY3MpOworICAgIHVpbnQzMl90IHN5c2NmZyA9IGFyY2hfZ2V0X3N5c3RlbV9yZWcoZW52LCBI
RVhfU1JFR19TWVNDRkcpOworICAgIHVpbnQ4X3QgbW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZ
U0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICBpZiAoIW1tdWVuKSB7CisgICAgICAgIHJldHVybiBN
TVVfS0VSTkVMX0lEWDsKKyAgICB9CisKKyAgICBpbnQgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUo
ZW52KTsKKyAgICBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAg
ICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVY
X0NQVV9NT0RFX0dVRVNUKSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0K
KyNlbmRpZgorCisgICAgcmV0dXJuIE1NVV9VU0VSX0lEWDsKK30KKwogCiBzdGF0aWMgdm9pZCBo
ZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCB2b2lkICpkYXRhKQogewpAQCAt
NjY3LDYgKzY4OSw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKmMsIHZvaWQgKmRhdGEpCiAKICAgICBjYy0+Y2xhc3NfYnlfbmFtZSA9IGhleGFnb25f
Y3B1X2NsYXNzX2J5X25hbWU7CiAgICAgY2MtPmhhc193b3JrID0gaGV4YWdvbl9jcHVfaGFzX3dv
cms7CisgICAgY2MtPm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRleDsKICAgICBjYy0+
ZHVtcF9zdGF0ZSA9IGhleGFnb25fZHVtcF9zdGF0ZTsKICAgICBjYy0+c2V0X3BjID0gaGV4YWdv
bl9jcHVfc2V0X3BjOwogICAgIGNjLT5nZXRfcGMgPSBoZXhhZ29uX2NwdV9nZXRfcGM7CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVf
aGVscGVyLmMKaW5kZXggY2MxYTg5NjU0Mi4uOWM0NGNiNzk1MCAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpA
QCAtMzk0LDQgKzM5NCw0NSBAQCB2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0
YXRlICplbnYpCiAgICAgfQogfQogCitzdGF0aWMgaW50IHN5c19pbl9tb25pdG9yX21vZGVfc3Ny
KHVpbnQzMl90IHNzcikKK3sKKyAgICBpZiAoKEdFVF9TU1JfRklFTEQoU1NSX0VYLCBzc3IpICE9
IDApIHx8CisgICAgICAgKChHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgc3NyKSA9PSAwKSAmJiAoR0VU
X1NTUl9GSUVMRChTU1JfVU0sIHNzcikgPT0gMCkpKQorICAgICAgICByZXR1cm4gMTsKKyAgICBy
ZXR1cm4gMDsKK30KKworc3RhdGljIGludCBzeXNfaW5fZ3Vlc3RfbW9kZV9zc3IodWludDMyX3Qg
c3NyKQoreworICAgIGlmICgoR0VUX1NTUl9GSUVMRChTU1JfRVgsIHNzcikgPT0gMCkgJiYKKyAg
ICAgICAgKEdFVF9TU1JfRklFTEQoU1NSX1VNLCBzc3IpICE9IDApICYmCisgICAgICAgIChHRVRf
U1NSX0ZJRUxEKFNTUl9HTSwgc3NyKSAhPSAwKSkKKyAgICAgICAgcmV0dXJuIDE7CisgICAgcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc3lzX2luX3VzZXJfbW9kZV9zc3IodWludDMyX3Qgc3Ny
KQoreworICAgIGlmICgoR0VUX1NTUl9GSUVMRChTU1JfRVgsIHNzcikgPT0gMCkgJiYKKyAgICAg
ICAgKEdFVF9TU1JfRklFTEQoU1NSX1VNLCBzc3IpICE9IDApICYmCisgICAgICAgIChHRVRfU1NS
X0ZJRUxEKFNTUl9HTSwgc3NyKSA9PSAwKSkKKyAgICAgICAgcmV0dXJuIDE7CisgICByZXR1cm4g
MDsKK30KKworaW50IGdldF9jcHVfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudikKKworeworICAg
IHVpbnQzMl90IHNzciA9IGFyY2hfZ2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19TU1IpOwor
CisgICAgaWYgKHN5c19pbl9tb25pdG9yX21vZGVfc3NyKHNzcikpIHsKKyAgICAgICAgcmV0dXJu
IEhFWF9DUFVfTU9ERV9NT05JVE9SOworICAgIH0gZWxzZSBpZiAoc3lzX2luX2d1ZXN0X21vZGVf
c3NyKHNzcikpIHsKKyAgICAgICAgcmV0dXJuIEhFWF9DUFVfTU9ERV9HVUVTVDsKKyAgICB9IGVs
c2UgaWYgKHN5c19pbl91c2VyX21vZGVfc3NyKHNzcikpIHsKKyAgICAgICAgcmV0dXJuIEhFWF9D
UFVfTU9ERV9VU0VSOworICAgIH0KKyAgICByZXR1cm4gSEVYX0NQVV9NT0RFX01PTklUT1I7Cit9
CisKICNlbmRpZgotLSAKMi4zNC4xCgo=

