Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E8C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAZ-000606-QM; Thu, 03 Apr 2025 22:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAU-0005tm-SF
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAR-0006lo-8w
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341OPuT010956
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gVoHJ0OtSSYZsMzuDVY7GZ5ga6wHPMe1mgwZjB5K2qs=; b=jKH/3nV1kdP4smjS
 4aN1PSt/nilZEK5Budxs+Hkky2tHHKl3PxWf5ioxM15PqDrTpmO5XHg1SiBaKpC2
 Q4cpJwFn6hYndUO5pTl+2Du7qS5oyiPaCHshMVA4i8DBSwDTHWrxOanAcN5wxq2t
 9qYUKijEtQXmr2UJmAG2dmOKWfE/cfW+ohEqf5+gubQPC4QEz7tRkyP/G4stmuVu
 QUc+z4fBYHF2j96R8Ssx7pSP1GR7eZ9Gcrzf1ghb7LmzAU/4zvcs2gPVD4gLY8QH
 GOxNnw0OWx62kAXZe0VJmB8zq2C+tkZjNkuwGDk7FrPwWDpocA9M5lMajDINO15R
 KcLJWw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d8rgcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-225ab228a37so16009865ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735145; x=1744339945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVoHJ0OtSSYZsMzuDVY7GZ5ga6wHPMe1mgwZjB5K2qs=;
 b=O4fc2Z5pXu3Vj8z0hnNV0qoYyaUeNGpoMzJeG452F6EcyMddMi0V6AvnKRNzujdkI0
 wCRHo43HyieLRBFi3eSf4nllFoyZaYMtttt8RQTI+GrT/qHFvHSCqnQUWbEAtF0RjtiG
 kJFEv8EcSBNq0/snypBv2HQYnXDKGX5YJRVfva1t/g2ZqD1yEk7A20OKZhaq/kPIBmr1
 GxWEx+M3ElpxsiJ24jTICiE03StWhB/ecSFgA9iHnwWGIxJigDr+F8SZbSpnzfPiomjG
 lnbtWsqfHZjRbH7mNIezudMyfECUhGrFML/4epBw0ju3o2F98eJJZCCdTpvNxac3Nvdf
 pjog==
X-Gm-Message-State: AOJu0YwrqFx9mVclyg1PIbVvRXBRoxYstUMC//+j2yIaK7mlmjzw5Rel
 fWr2nxgWppHApURvweI5v5dgCg6jCcPkQbP0fAqQuBmAEuCBAdzpb1LXMseTGbDXccMn1RkxLh2
 zxAflcOoyJN0esBi45mjOq+r0IQ64mD0aWDgNWq8ZBJK8KDjmuNJYCGz5DQHweQ==
X-Gm-Gg: ASbGncvMW+Veo4lIHKt2EEhNgUAyeTlkoTj5dQl9fK/uWnUcAlT/qWSUoI22x4KtY1t
 F31QKOcA5UTbfFA4i7MRUJBFLd1EV7TtJ3JdldVrlsvqV8zDpxNLex1o/JIOHwEoMppDkmqoa+m
 CzMiBBgVuvJoTfaZu+FYx+rjvYcGWvhSfUJwRcT7KGzJiFeNopAPlX2K4ZVdEBaUqDzqqqK2uhh
 U9gYGQmobV7Mf6yd3pADTAG9wB5dkN/9ERfAcfzfyFUuI7e2bUDMZjGFNTZGOqc55HF/dbmBTOV
 pckZVkCbM45I1skU/tPh/HW3mTJcUQShJXEt1QvnZ4CBDxwCysTvB/8hmhv87kTl
X-Received: by 2002:a17:903:3bc8:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22a8a09a69cmr21682515ad.38.1743735144746; 
 Thu, 03 Apr 2025 19:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2cfgnvgfdl/LJCKwZeuuAK774BHHSN9msKNrW/9SVbwk/sQdEqYHnoJceDJUf0s9FRilC0A==
X-Received: by 2002:a17:903:3bc8:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22a8a09a69cmr21682325ad.38.1743735144365; 
 Thu, 03 Apr 2025 19:52:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 2/6] target/hexagon: Fix badva reference, delete CAUSE
Date: Thu,  3 Apr 2025 19:51:59 -0700
Message-Id: <20250404025203.335025-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: EMyql-j3t_5bl1QcCbIFIhCrq-a-sjZh
X-Authority-Analysis: v=2.4 cv=IeOHWXqa c=1 sm=1 tr=0 ts=67ef4969 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HN0uuiy-se_EESAQhN8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EMyql-j3t_5bl1QcCbIFIhCrq-a-sjZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=904 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCAz
ICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5k
ZXggNzY2YjY3ODY1MS4uNjJmMWZlMTViOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTIxNiw4ICsyMTYsNyBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFn
cykKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVt
dV9mcHJpbnRmKGYsICIgIGNzMSA9IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9y
ZWcoZiwgZW52LCBIRVhfUkVHX0NBVVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVH
X0JBRFZBKTsKKyAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJp
bnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9S
RUdfQ1MxKTsKICNlbmRpZgotLSAKMi4zNC4xCgo=

