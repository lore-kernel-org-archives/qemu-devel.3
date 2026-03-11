Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED5FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsM-0000u6-Dm; Wed, 11 Mar 2026 00:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As6-0000nf-3i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As2-0008Vv-Lx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VLtr614152
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A9eW1q/hnWZzTd+3ooLBoE/Tkar5dXU4AKL2u4UVaRw=; b=Fo8As1IDqj0OoCvX
 wnfFVgcKK/YJAzwqQcnVugJW6P++mikWj2u8gcEMeN+nUqbHQRA57cdLKosrzgJY
 M9Z6X4oElmHFLMZRG7yvXb+ohLfV658sxEzbTxJyszCnMYuoHTpqAgMOzWlAWSaL
 NpSZ4x4DkCuZYdjLw5R5wU+0PLv3AnIaDsyq93j7M7u1Zp00oSIPjhj/JWl8f1J4
 +XRhryEAVd6UqC9EDUsQ9peSGbwFhZa1zKGf+3EP6YSYo6vDXzrSuQN1rq4lPQPK
 4SZRRQW3ohdaWLlYOspNv3oUgmoPfRGZshdhWzun6ZLa7W1aoqeKgiX29UW2bLN5
 ozI0ZQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf03ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:29 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-41702ea8343so19797535fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202108; x=1773806908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9eW1q/hnWZzTd+3ooLBoE/Tkar5dXU4AKL2u4UVaRw=;
 b=NnQxPtrnOMV5HCT/8Sv/zUnPBvq9voDvDSKjNxNH8dHhkT8v5vZHtFNwF60TSxepkk
 FPdPHUrhrOdMRmBMGCK7x4V8gQ2L+mZDazQNVtgpnQU4fk5RXuV+V8NJM+Ry0ZdEmWc5
 3uRk9+nRR/565hjb2iycFXwx0Er3UwnDI5npsypVXaqw0c+tTEmfp/39JqNrWV0Uyx5J
 t+U1zeJQ0SiuTWgf/xuSTGkI5R9JEnIjnBmxEbyY21jfCelGdmMTPibwqCxr11fT3Hor
 PVnhWcLhf9DFd10eTLwHFJctSIyfSKnVbgpV95dOwTIg+bsGWNB60bZ6Pbd5lXx3tker
 CvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202108; x=1773806908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A9eW1q/hnWZzTd+3ooLBoE/Tkar5dXU4AKL2u4UVaRw=;
 b=Ub0oLiBdxi4ZViq7XFwclhkB/qdEnsryTaJkVHetRlZ2qlCBsAWJeGnV8vXiUm70Wu
 HICjL1EWUjhTKK/KM6c48+SIsxp6agRfTVA8QoihR1kdBT4kUb62MPLB2XVxhyWWv1+a
 fkwyU/0QG2gFFms+vXB8mjKBFcEbho3gkx0P/P361jFJW00X4iRe5BFdckdhqs0JvSvw
 lXn9QsXbh9Ev/obZ51tkWBSntaL2WkYA7h0/IXU0Z9iVVCWTPFuSTYkFj2q5jXrgIqld
 X8id1msQOuNnVy6EBUvgaWLayU5NmoSYXEaIbfinzRckES76kv8XjrOonNk+Iu8h8z9h
 3ghA==
X-Gm-Message-State: AOJu0YzU385R5yvrrtMbiWG3IZc/fNvdnad+5chV1HxfZwYuvaDCfCr9
 XIGF3Mpr3YKml+tzBaMQCkmw2XQCZ8iEAiuUmL9YtAdp5YXe+tNMCUX0yHwn2OW7xDnJ/5fDrp1
 pe2bIECB4XEy+8SpqNbgWZqmCFEdDfyYQpnA4GhSETbHkM3Ahrnnu8NNDS0SYwZ6Zpw==
X-Gm-Gg: ATEYQzwEL2XwbdYKfSxEsaBrVsAzkvjtz/VcOAU1U7nDbQDL/LjdrwpwjVKOViYLHca
 60CvQJKof3AAEbv/mzMqGaxOdLod4dTJ65ERL+mgEgTUXQk71a3TrcyFGrPxfd36l/Iq9W6bcUs
 UdBoGNKvf2vSbgBTpRzxhDBMk/1NHxZgUSA0cIdRwALVfU0aRv5hLuEFFEO+L21xEdifReUpGYB
 C+0pe8y8RtWrhiUWkK7ToG/vW5S7VLDH2yhM8/4sX/Ak3N7TPlH17+aUuZmrFV5zU+dTksTkgar
 5Kq6O+jNEBMDVDeexiiyfFcE8vQG8y1mQQlhWRzwAvpJ9iPHJVlcM0cc4K8P0EiBGbHnGfdqXvR
 oi9q4xkBVOUmehjb5oqBhnKqr9A5unJCcQ6NWr/xdWAGBURs4/1Olu2Oydl6knpDhDF9XBQ==
X-Received: by 2002:a05:6870:506d:b0:417:5b15:41b0 with SMTP id
 586e51a60fabf-4177c5d02b4mr825800fac.5.1773202108530; 
 Tue, 10 Mar 2026 21:08:28 -0700 (PDT)
X-Received: by 2002:a05:6870:506d:b0:417:5b15:41b0 with SMTP id
 586e51a60fabf-4177c5d02b4mr825778fac.5.1773202108086; 
 Tue, 10 Mar 2026 21:08:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 16/32] target/hexagon: Implement siad inst
Date: Tue, 10 Mar 2026 21:07:42 -0700
Message-Id: <20260311040758.1068731-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: TY0-l5cyYhgngAd_gbMPhTtpCuBhe1rF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXznDAO+Reueae
 K4ne/6L9kOWM9JPz9nkw76Cajuv3OTt3iHbyRHZ2J72rN5dvWoTz9wiUrRsSJB08edgxeng/wi1
 DBxSCses5LXUpWen+8RNjLB9nVOJOBovx/Zd9eKep+SLceS5568sRYeKRsi+CHuaOZ0iTyN92Zc
 rQol1drO3SOEbeuLPRCCaHvJ43OsSePLI+Ob+QPZQW5qZEz5q8tESyxpjP/sNVqt/3V1LdmsICn
 BafBdAELZTk0FzZ57RYmDJq/MWCwA2nIrcQCj16jsKF1FS1wzKwQrnAh1R1lN5K1QIYnKfYefPA
 V1kHkhWhpWFvROAB8bujoFL4SXypm0hzK4oID3ujujXb+epf0xlxoAUis3sxmtsc/94c6BrG2Pd
 PNUCvivN3eto0RBvX4i5LIFp2Duw8fwYnCRtJOP8fELnTJznzj/pfET8qjmCEV9wzIk360Wg9Ke
 QzJgOAnkkCsandBaE/g==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0eabd cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TY0-l5cyYhgngAd_gbMPhTtpCuBhe1rF
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE2ICsrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjNWM2MzhjMTMyZS4uZGZm
NjA5MmRkOGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDMzLDcgKzE0MzMsMjEgQEAgdm9pZCBIRUxQ
RVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVM
UEVSKHNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdf
YXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgaXBlbmRhZDsKKyAgICB1aW50MzJf
dCBpYWQ7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIEhleGFnb25DUFUgKmNwdSA9IGVu
dl9hcmNoY3B1KGVudik7CisgICAgaXBlbmRhZCA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAg
IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFE
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpIDogMDsKKyAg
ICBpYWQgPSBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKTsKKyAgICBmU0VUX0ZJRUxE
KGlwZW5kYWQsIElQRU5EQURfSUFELCBpYWQgfCBtYXNrKTsKKyAgICBpZiAoY3B1LT5nbG9iYWxy
ZWdzKSB7CisgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywg
SEVYX1NSRUdfSVBFTkRBRCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXBlbmRh
ZCwgZW52LT50aHJlYWRJZCk7CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7
CiB9CiAKIHZvaWQgSEVMUEVSKHN3aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1h
c2spCi0tIAoyLjM0LjEKCg==

