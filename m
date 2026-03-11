Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599AFD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaL-00021w-RQ; Tue, 10 Mar 2026 23:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa7-0001hJ-Jf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa5-0005Ji-6Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B17M5S508294
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=; b=OigGOZIHdYf1JVIa
 eAe6r6E2fqiVCX/qe5bNcm+TGSiQtrHC+gE9jzP9eoSR+fHZvXTqMYfa5VKQRCLK
 yuAwKBoxOYnLLfjfpV0lKwttreju4ZJTCde0kEf9swvUsbi90qoWss+LYYxays4D
 6siwd4C3e0mqe0ZXnzG0qt75ZGRh/z/k+IQd/BpY4QtAL7Ys076LCAJdiclPWjyU
 MuxliBd1HO0ViWe3I2LR6V+KxM8suZoBavxgdfgOwoUyHOhDMvnv6gzwou90gYgv
 KVo9FgPFmkzxesF9KNI14gpmcogGxPXrxhweRjwx53Ichxq9detjRfoX57/KtvKo
 m4UQmw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppaj3e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:56 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73bcdba71so39002492a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200995; x=1773805795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=aFuKBG7c66qJtU6HKJVusQeCNWEu7VxQ1oK6ZoNCRfEU6fHJDIYqZSmrGWTJo9pqGS
 lvLWqTjCyqPDgpdGpjs0YXM7+Q8qhM38dl5HFPNjhtULP8FCLVZWYArTwcliuDpXQ7/e
 BmpXllK3JHYulftvTBPhdebD1H9o3rV53y176obRYBMaPZ+ldclioSmVr9RhGKAAD5e5
 3Jei2UBRPeaghE/mtHNamrrUx4YGFrjtFJdcR0UOlQpFLd/FP+rBUOnExy/c9+jR46SJ
 7lDx85F0JMfIYjuDDWtVkqdiz4mPF7g7PY66QiebggZiMcMBWGJbxBCDzcbquRm0UayU
 jKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200995; x=1773805795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=sHRD6Mudk9D0/E42l9PKchjbtimhnw+mRClvUm1oEYvFfu28r3vBWzMoFuzt+8nfmt
 voHOfBQj+q8upbZZgrPwgeWjJTFlarmNnOz07Zz6p9dSGtr9l+yFTTgKXrht0zamRY8B
 xAzIBDFOHn2izOemiMtZNF6DTWc2fSBG4zDgFm7oCeyywu6+2jXr5rlBxxrOO8OFw6O+
 EngvynLNJgQy7m5zn6pr10HrSqR1FfLluAK8RIpl06qLW7eezU/vip5986az/F1JxJK2
 Nlk0KFyvpyYHhPZQzyBgttT5yqPzK9QpJQOnsCFb59lnGDIoeUa7J58fz48CGV1nyUNm
 FS0w==
X-Gm-Message-State: AOJu0YzyDatq4Oa/KKeww7rqJyv170tZcXJ1NKrrmx6Rl0/WVz/njaI6
 xDRWmllzubvu07FQnnVncE7lJOlScSdeAdpZPSK5mKsg9BxxNb7pwsWAA2irFzTXOdty3v8LpaP
 RT+qqHJDoFZAjaW2y+0paNtWiS+S9B5wxwZI7llSt0e762qUUJJLew450QcHQgyTyFA==
X-Gm-Gg: ATEYQzzK/7DkW3GbZKU2j4p3mh9onW4kgAtY9SFI3enkZtMZj16OmITriVdcsZn21mc
 vylzm78wAf6/pawyFK9pj2OT7TygUSKuksGkx/1132q9W9Ln2goPJXTGrbdXUSgypN8sFDap92V
 UVf0wzWssNoTA7DK0Nup+h2CHLdoV3lSmHqjZ53o6lNeS0mgJJzXbTvlmXYID+pDMKe75q/azQN
 EK/M3E5dIy7FMhJ0BnI+qlBgQLghgdQseVOj3+ShNnkPM97ZEOeDIQ2M+PgWvY0wsjLxgQywts5
 0GHUnRkJmf9f0fyaFegl9RxDtpl0jwjfzPonIGcaj1oppzvacuOVboX+011m5rJwtb2A/BuAUuh
 YcYiIa3hnE66DcF1K3fwrwiSmV6wC1hGY8ktNpbG+qGTHuU5O5TOSmaEtGnMJCK6tyJVZwA==
X-Received: by 2002:a05:6830:449f:b0:7cf:dd34:8e1f with SMTP id
 46e09a7af769-7d76a844224mr1056376a34.18.1773200995571; 
 Tue, 10 Mar 2026 20:49:55 -0700 (PDT)
X-Received: by 2002:a05:6830:449f:b0:7cf:dd34:8e1f with SMTP id
 46e09a7af769-7d76a844224mr1056359a34.18.1773200995116; 
 Tue, 10 Mar 2026 20:49:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 22/35] target/hexagon: Implement do_raise_exception()
Date: Tue, 10 Mar 2026 20:49:10 -0700
Message-Id: <20260311034923.1044737-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: GkIPb3DSnpAQbWOoc3UwYmdsiwZpeVPN
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0e664 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hK29HtBGQMdOITfcgGsA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX/2gjeB2Y21nM
 TsmzcbOviLhWaQSOzNLHpvOjtisQ8ikAXSGZSiGAAHZpYYdRithi56cqncSiiKY6fQ9T9std2fX
 7uVSqnkG5fXnhBTN0aHyzJlnRCiwEgUTLFvo/iZIbGkyAPFPwwxv2q+zfAGVrUFkJYFSRYetcvd
 g/l4iIuukDSZ789TZCLzt2f+LzbDBFF9i8Q+Ryv/MZtvkKfaxRbn+Apwx7MoeysizWRABbyVEwc
 4HVzbMzgMW+WUVMCPRRhHburRKmcLwTz7dq8ov3CYfdeNTsiE4AWGDil3GZjaAK1LouxmnpJLPB
 itngaTrz0LbEiYHX9dm3cUHvR24mSw528ktOgYtspBABpC0PnK8fybw6YB0HVbFqjEYcKArDGTN
 wdxR9yq231a9tOH/3LVZnDGewQD3LC281OXwAEHvXZ4BumK6kTNk7CoqGCBHk7CG4MzlW1gxFol
 oyzvvm6GstBCqLvlepg==
X-Proofpoint-ORIG-GUID: GkIPb3DSnpAQbWOoc3UwYmdsiwZpeVPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzNTliZjEyZjFmMi4uMzI3YzIzM2MwMWIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MCw2ICs0MCwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

