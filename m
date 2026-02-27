Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52996FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aY-0007qD-8Q; Fri, 27 Feb 2026 15:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aH-0007JP-Em
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aF-0006qy-9b
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:12 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIetZx373605
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uOmQcfvtUBhmLpHpjOqkH06FAc9fEZSVWLmdbdFVvs0=; b=IsEV7R197+GpRRLP
 N97TQ/vrdEoHGwb8qi12P04OwXtBB74JUwhuhCZ/pqOevnSrnYNHWGMz9xFjs1um
 oKhT380M3/Ehe3K+WHZEBEV8qIA/wA8GroCoaCrUZzFzmEIHIV3Z7vtWFPkbJdAi
 oFTinJj43eR3kCBIxXRw3SogKfGJLbta7Uky+2/dc1tVqiqcxyzSVGmqfpvK1Qkq
 JbMwKfwQoPK0ZII/+RG/IAQyd9QSvrLmnF1lHVuh25YMYZiHIHlmzvWdQPwU7ZdS
 9fRh9cdkuyxplKRnjtQqNbzckpHyf3mC4uNGGS2tbBkPDtK7IFCA4/KsxnwpL5Yp
 bAlhBQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtraur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:59 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-679f6f264ceso30893228eaf.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224619; x=1772829419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOmQcfvtUBhmLpHpjOqkH06FAc9fEZSVWLmdbdFVvs0=;
 b=kawIVMv4pJya5Hghvu9jBSzmPvp52ZEAppVOhen7YV2AxUJ6iFrxLvUlpyxzRTwQlR
 8J6NwmEpnMD3aVemPjManjdrVnw7dip4rJ70A4EafU6btn/+I7/SoweVvWtDrfQrQoGO
 v4SkYrCKjmbwHvTSHanBmjl9lpZOX77qYkyws+TiazSa/hfPfdzgaKqhKzHWR2P6q9wV
 +rbkDslO4C6HAhrgI45BnbrXVwQ3rSRANiMOiLQMkrIeX/GtnDoCc/SDRVBP1nOqSx5h
 4uUK86r1Zz+yl/Wm+d88m9owhZ9eWwaPADinsVV4naXcgsqJw5l3lts1z4WjYJMzbGQp
 oRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224619; x=1772829419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uOmQcfvtUBhmLpHpjOqkH06FAc9fEZSVWLmdbdFVvs0=;
 b=mwvCnuzk5EFA6qwF/8PLGbDca6FZrL4Jt8ENYzdHuzMAFpPj7SmK+TxfU42hwh0WFp
 GG1lckoLtKF6Zolt0iBhmsrkEEbTlsIwR6qY+N0fKHTfvVcxIOq2aq11xihh0EPv8k7S
 w4nPlKJPTiMg8pYGCPPPRgWUvYHQA0zy+V7m6G/w7lxZocWKu+z1LlCy/Lj3JF6GXdKm
 9mGfWfn0FsbUMA87zg4uYnybF5PjkySk4GTxU681gtHZwKzfvcQBLz3CdxfbM/ES8Z91
 UObVvTFfYwsNUah/V0dP8cdRoMhwvrZkN6EdNUBfU0ONBnWPFcBTQUgPbph63K20iTbU
 TXxQ==
X-Gm-Message-State: AOJu0Yz6dbMPsIQZOiTli6wXK86e88vRXAxgPwPz78GDQdk76MJ5koF/
 AhGE/bk5psUV7GuOe1GIGdD5Ffuvx9ujMGh8vzlVSJI33naEJ4cMYldBITtWIIp6xTYiPhpv45M
 72+nc0ccZH3PTbTJ2W/zRyErYCnrk1e9gLvh1UY/++X7zLt0P/Nwm0oDl/zGzsW4vVw==
X-Gm-Gg: ATEYQzyn5Fdvh/DuVPAVT+OII/QRjNI7bANnFoz0OC98zg/owpVvKl0xeUzOI0dwfpz
 qylWdDS1kS8VfLFabZZLXD/YiU1K+3QaLWfbER4XsetDdh+W69PACb00MB2MffJwZLyLhBq2vuH
 L9GynbSVqZSTf94y16S3B+5m/Ak5XAfkWYDrnH2X1CRvrVW4cQ2uGUIkC7NH9XhAt7bfcY5p00L
 JFcJoVuQoIoeDY2W5Pez+wF7cUvFkkXzSMVSZCLJ9Rv5gFm748C2IxxcP8RZ/aE3m7fUfFUtuFh
 zJN/rxjy4hAZ3LX7F1yZjSUX/qJhD4JI9cDJGOOjV7oOYCLByGYIR+LYIM6wzj/zCs7dvVtXRiV
 zbIlOfvzPs+eLx8lBV6mmLv/+jtxIroKyhTn2IVcKo6raWArvXO8WbLN32ingvMeyG2kvzw==
X-Received: by 2002:a05:6820:8108:b0:659:9a49:904d with SMTP id
 006d021491bc7-679fae0a4c4mr2964205eaf.24.1772224618825; 
 Fri, 27 Feb 2026 12:36:58 -0800 (PST)
X-Received: by 2002:a05:6820:8108:b0:659:9a49:904d with SMTP id
 006d021491bc7-679fae0a4c4mr2964186eaf.24.1772224618446; 
 Fri, 27 Feb 2026 12:36:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 19/37] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Fri, 27 Feb 2026 12:36:09 -0800
Message-Id: <20260227203627.932864-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a2006b cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oSs-Am0MwCqMoGAbxz0A:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Yb8-m1XRyau5QJqZl36D-cv-ByYbXvqB
X-Proofpoint-ORIG-GUID: Yb8-m1XRyau5QJqZl36D-cv-ByYbXvqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXwVdbySPzoKzz
 TaNt3giFZaFzVHggmuJenWrpNi4P3jlvsENvYM/GURvoo150MZcDui+hJ7mDb9XbUS3a/uLamhd
 MyMp4ziUchweBzyERTzBj/caFtjv42j99vwStVW/0HzT79+wd365DTaNLUxl0KuY49TV2tbHkIL
 Kw2liV0KSjs7SPz32/C9Lgn2NDkcJt+6d3BRGVUeCYG1Hos/0LNqpqdEpD9+NgwmouSUWReowCw
 ILYRDrUCrwt9V5/4SaE+JCmgQ+pmN1GBoz9b0b6QwZ9QB+YpnYAVULO+OMEPzInV9W2p6KXT7tL
 TceMk3yTGzCOeMva4ekv6lrrcxYiDOV6PYG9k5CKRmeL5EzBFHqYYRribgF7W/mp4xGHlpQF1wY
 NsWY5HGL6aE9gzxF+bnQMQwRDRxA4XtKNSqGYGYHC4z6hzxSjsVcscbf//Ct4BoFbMaAcLpt0YC
 a3XXiUceMkyasH+YgRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDkgKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDM0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFy
Z2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggNjQ0NTY4MjJiYzEuLjg1ZGJhMmY0MjkxIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaApAQCAtMTA3LDMgKzEwNywxMiBAQCBERUZfSEVMUEVSXzQocHJvYmVfbm9zaHVmX2xvYWQs
IHZvaWQsIGVudiwgaTMyLCBpbnQsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9wa3Rfc2NhbGFy
X3N0b3JlX3MwLCB2b2lkLCBlbnYsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9odnhfc3RvcmVz
LCB2b2lkLCBlbnYsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9wa3Rfc2NhbGFyX2h2eF9zdG9y
ZXMsIHZvaWQsIGVudiwgaW50KQorCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKK0RF
Rl9IRUxQRVJfMihzcmVnX3JlYWQsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoc3JlZ19y
ZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkLCBpMzIsIGVu
diwgaTMyKQorREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQorREVG
X0hFTFBFUl8zKHNyZWdfd3JpdGUsIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzMo
c3JlZ193cml0ZV9wYWlyLCB2b2lkLCBlbnYsIGkzMiwgaTY0KQorI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IDM5ZjBjMDQ0NWQ2Li4xM2UzYzJjM2E0MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEzNzAs
NiArMTM3MCw0MCBAQCB2b2lkIEhFTFBFUih2d2hpc3QxMjhxbSkoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIGludDMyX3QgdWlWKQogICAgIH0KIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2
b2lkIEhFTFBFUihzcmVnX3dyaXRlKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVn
LCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9p
ZCBIRUxQRVIoc3JlZ193cml0ZV9wYWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
cmVnLCB1aW50NjRfdCB2YWwpCisKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQor
Cit1aW50MzJfdCBIRUxQRVIoc3JlZ19yZWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgcmVnKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3VpbnQ2NF90IEhF
TFBFUihzcmVnX3JlYWRfcGFpcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykK
K3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50MzJfdCBIRUxQRVIoZ3Jl
Z19yZWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQoreworICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3VpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworfQorI2VuZGlmCisKKwogLyogVGhlc2UgbWFjcm9zIGNhbiBiZSByZWZlcmVu
Y2VkIGluIHRoZSBnZW5lcmF0ZWQgaGVscGVyIGZ1bmN0aW9ucyAqLwogI2RlZmluZSB3YXJuKC4u
LikgLyogTm90aGluZyAqLwogI2RlZmluZSBmYXRhbCguLi4pIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7Ci0tIAoyLjM0LjEKCg==

