Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAD5CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiC8-0002K9-Gf; Fri, 19 Jun 2026 19:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC3-0002GT-1D
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC1-0001e7-Ek
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXfeJ1251256
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=BSAS4M9DpFi79eNs
 eN2R8zJACJvUktZfJ80WaDEGWOtjWc2KyWIYpG1sfvhx9sFI49xlYCzrG50LaXFJ
 kuF9B9PPzE2NSsSO7sEl6C/zKwlrgPYtqwT9Xha8bJywdYzqT11p3v06M0LdKmGR
 WDbMGh4lOInDSAD0BVhz8HeW6P881gG/ihr+oTPZm9/Gzrp4TYFIzKfcQvVgCyBE
 1JQxZtQKZnAxPdbLFVxYA02ncn+QtyCP6zdetnSXSUtK0Ei20hh6xzdl/LXjPi0N
 +yzVEJSEpwGdHhpehoRrNLh1+Pv2DuxWc1uvx0u6H1FL8OrqgrODpwopkPoeKsU4
 89X05Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8n4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4609848eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909997; x=1782514797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=ix7fYuDaDifygJnB+zJFqAkvSi3ZEkort+S87+Uc3YTm8TDKeDeX/FWnYKMC7Q0L2k
 BYYtzcIgXJElz5G4xIb5SBHA3pIYcN2Q2L4J0b9eSyM+NhFQcyThEPTk29oZtiyhWq8z
 MfV8OdOgFoUQruL+grzQFwLMmK8QR/D+kRIUT+LlDXVPFSClLkzQ2aEB7sEtZ1sSUVcQ
 quFcqJobHF5H2dQVP4qhgILYru8mOaYwLZeou6rJrv0rZGOgjjwchS65E+Zb26SuZMQ1
 yg5qHp3Ro5G+2Gf0ls3UAZtxyjWfWaMDiFyT3V704qr0fFCnSkvEuVRBt6hne7JVUlsC
 hkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909997; x=1782514797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=naPuedIrddWxabi3NJ6uAzyD/Ht/406/5SCaqueTS0S+//Ga3ji0YaN39e1WhYpm5s
 bamU0BcOnAm/zEGnXO/RnYDy+RanoFuODoL7Kt3/dE8szT0W6oOD6cAUUxB3xDsfGG94
 2dsiwm25NghqM22RSqaWtzXX2SxfuPyh7i5puzblz/pSXbpIzIpxQyEy79CqfThDY6p8
 K0n0587gz4/WTWTreZILYjbBOBnQ6ZWgHNAAlYhOSsNZX66geOsLNQYt64Wdqqr/acnC
 mCzzUqIY/78jHBAPoB5R+u5rp7CDKCyGm30/wXjOcb+1ahNzGU4VB+drCd7FszuNclJW
 0DNg==
X-Gm-Message-State: AOJu0Yx7SAoPbb3HQnHp3h4/u6F3Th8wR8K4DjVUBRrGpxgkpRU7TVYs
 Tgpotdx+GC83LLfhml8FdWOcB2Q90I6rmRvBL89PUZOMAaYJC5ukg6w2YzpEsEhzBswBOP8wZri
 dXQwqs5YtgdAW1Kg0yu6iE0xb6VbtWln02ASFY7/5TMkbA9e8aMDkmuFlB/5+KSSSUQ==
X-Gm-Gg: AfdE7cnnbaHbCJrneBlp36kqFrT80UEV0szJEQSDkNnm7mnhVsND95p3OA+ItXEO6FB
 bfyqGvCH61+jLaz9EK/ZCQk23fGW9fR5NRINhnHZfh1IERCE1zfxEg5+aBX1vnuUfStCLPcUyQ4
 7/WIiiLmn5nYwI16RoG1Cek45potFtJSJtPcszoBqt5SNbPaQk8Z+/vsrJgCPhw2TslR3ohA3tA
 w1VTblr4k/Y8sBcXqrShADqYSfxRIpyj+BaHW/x2gB9DOAFiDgpM09eiZSsfNSU/qlkdGDEvdTg
 oMDX+B1dRqwczvlMFLz/YwXfKyFwrrHsUuxvPxBzSaOxi/WHdZCLgqsam6ulrU9QgqCDcq+l6h6
 8lMAOhTu8C4L5IlyS02h6K+H87QWSRU2bAPDVTbASgseKFlQLI7XgeF4auQI=
X-Received: by 2002:a05:7300:a886:b0:307:3a6c:ece9 with SMTP id
 5a478bee46e88-30c0d014ae5mr2317851eec.15.1781909997493; 
 Fri, 19 Jun 2026 15:59:57 -0700 (PDT)
X-Received: by 2002:a05:7300:a886:b0:307:3a6c:ece9 with SMTP id
 5a478bee46e88-30c0d014ae5mr2317843eec.15.1781909996978; 
 Fri, 19 Jun 2026 15:59:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 29/74] target/hexagon: Add representation to count cycles
Date: Fri, 19 Jun 2026 15:58:26 -0700
Message-Id: <20260619225911.159473-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 9aq3m2rzyObw8MxTq_UAe_n_VRub1YQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX+RAghKwyeh2Z
 PPv0SbsTZcTP18Gqc+b+KVlz3Oapsj+eHDpnOvHPFwspQLWOaoYGy+iqbG6h1VZ8wEDCZXDSI90
 bHD5qQ5OCam+w4tjHYBLmZz3DQUt9OItf4k6hkVLR2PTSwL6KkJmkA33yFgu47+8ztkToQ1TE1b
 dENm6mIdR9xXIVss6BmdJ33LbiX08Wru/c1Z/b4LN+VEcIQXLuc2g3yQUYqT5HnyAT9Vu0nD6zF
 qXCHSgEXM0Wi1mWNJlaZSVmIKYlGzWNVeAwIay9YF6RTWPKmAN8B0SD6m9WFVOTOW54sCUP3Zgu
 842NmiBsHBDgZca4gETXfYgk9HxQaFH9QuGkD2MTZKKjAvZDrpcCARunV6qISYQ0OuDfNmrEW9+
 qc/s2OBsrHBQo3r4wI6jc97P9CatLKJvA6dKRj7kVnCTvs41jTa/01sTl6DVAbaQLPZmEZ6ut0n
 Yyq0A+C3mxbcePK1cZw==
X-Proofpoint-GUID: 9aq3m2rzyObw8MxTq_UAe_n_VRub1YQa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX6CgIjt5qQwSL
 rc4a5/GhvhOvOAtF5WmIb7myGiW/D+HiquIOd3hQDgVJU4/FmMvE4HODu5/wpcrF3Q5fmrLyv2E
 nOfdVJVsSufTqG/rqGGEMQuE9AEPM8s=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35c9ee cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190220
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

