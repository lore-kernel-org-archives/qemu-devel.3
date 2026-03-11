Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD98FD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AZy-0001d9-MU; Tue, 10 Mar 2026 23:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZl-0001aF-VX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZj-0005Bh-2H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKushp1863218
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=Csen9qvAzd6DeOj6
 NLL1kbfy+A2zVsmZWY6CgDbeVPd27jtWT03YySRWiQF6LUdeHwOa6JzX5HZPbazU
 tq0V/fi4KJk+at0opRFNxnRu4ovHOIxfbbIrXV6AI/O/KdAE9My5e0+xj2rljhe1
 e68gm59g7+k1XyBinAYr70Xt4nmhbY8x6mJvtvFNCqHQqRDF8gkOptyciJJZdeYN
 HHTUnqLq1SGbFTpbnpXOjTCtJo6ESmv/hOOkNQvKKPwWSID29RWgLrrtnSNLLstk
 GqcMo9PnblIpgdC96mfRMzmQy69z/ltdlDRyWvIMd22205LJrovweO/KqsbN004O
 ykjdzQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82ndr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:32 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d74d78c5f7so5573124a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200971; x=1773805771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=K+NVD/Id3eRPjnnBt5nfw1HJiW/hWBfIFbUt5r6LsJ7qj5q9kSpa8zmE998spivxKG
 MNAddZ64HZQsvZV9vKnhazNeh7qMjryzo877ja9E0XsPdk+Gq4G2q8kNTrtaWVHecMFO
 StsaxJ5YFqQ1clxctyfjHIFx38ohu3lISqtTO8EpYgmp9xlzi/DI/4Lojxy6Err2ezFy
 dSz0drKYsrXXq2v6dQ3VaAeSpqt2Xf7v/ICPSj+qJ52GAXLU/RqMSoliKqdO/EXc3jtz
 Xj0aov+RmIPFAbY5TOq0DXBiL4LQfdi3JZmMmVdT2zoqPgV16ZdSv/kNZLc5RzpS3KyY
 zr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200971; x=1773805771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=iSvGwLUHQNOJfwfTXebociyAdsMStdi2i5Jcfq+ZuxUPXl8Ez92WV++eyFqe77G6N0
 GB+q4AybUbiRQAgaRB/S4nYzuhJK0PGAIt0I9QMaqYld3VtwbnPQkgFDx5adAqU0mfE/
 93L8b0eiPPiZ4dtPt7nkC/Ea1LTJPfm3ioL4ta6m/LZtR3Vj2hOFCOY1iI5+4+Q1KZDP
 4rGSqKlTmExtkNFaSeXedFhd/C5yZ40FcCt5qNavTGg8tycGzrgj0fVDv5On+meS/4nL
 ki9PJp/LqCs5RwfLLkzJ6GH5nmgrAnkA9u1Q/9bC/itEaFU0SqByTnETLYagIlklUbt2
 Iuvw==
X-Gm-Message-State: AOJu0YzhYGPmECABFQcEWi+aDuPh+DBNEdPVu0vPy5tCNvZ2TsluhnwZ
 Pxe2n4Zq2xfYZ0rUbdfZvTnG3dhXhpfgGE3SlU5Gdg82/Po/yKF8NPwHrxMvTefVAb5zGfKUcTg
 Qz7Cb/4I/gouxnWPluzY5uNXZ42i3EEj4LTL3BE6RLFMlxcSrrOmt4+Avb/bNqe7PdA==
X-Gm-Gg: ATEYQzyCQ4Fq2+U2tohqdRkwVHkawfvKsZH6EMrVoFHVsCvd4BHnnyseAsjnTqNAZSY
 ECCfUHK7slaNob9aGloxjPwKYEkdjkxco/iU4bNtcUBDUro+CyZYDh/qu4Zs/Csm8oJx9d5UFaz
 1ZfZ7FCgWIP54t3ejORQa1b20wHKVm/U851Fep8DoGIPdMPKlnhkcEDM8tQ780vFSiYHS/yMfPH
 8soDNHaF8yHbhFhcxQrRsGV2TvK+b0/SFYMEe1HcWp7WpHXddBM+ERniSu77mx2QxezNI/Yt40h
 Iq83K4J7CbgpkGdw1SVVaHZYuGYWwabkxbQC5POGaQwWFw6/K78+m4a0hVzuEoTyowKZHdBtZSr
 64JMN9NyUd5qtdGQqjEyArxVNO5bgY5DEnyXAxA8mWe2Z9GWREbYqove1BHLDC7+J655gBg==
X-Received: by 2002:a05:6830:6993:b0:7d7:4de4:2f12 with SMTP id
 46e09a7af769-7d76b04012cmr728717a34.8.1773200971651; 
 Tue, 10 Mar 2026 20:49:31 -0700 (PDT)
X-Received: by 2002:a05:6830:6993:b0:7d7:4de4:2f12 with SMTP id
 46e09a7af769-7d76b04012cmr728699a34.8.1773200971283; 
 Tue, 10 Mar 2026 20:49:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 02/35] docs/system: Add hexagon CPU emulation
Date: Tue, 10 Mar 2026 20:48:50 -0700
Message-Id: <20260311034923.1044737-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: BS-4zBUCbZ4lb7rmd6EFWnjwbqDgFYOA
X-Proofpoint-GUID: BS-4zBUCbZ4lb7rmd6EFWnjwbqDgFYOA
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0e64c cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX+t2mjVAbAln5
 mEYWse12ZnKImvw73sNfiIxpI+TvXVWvErlJuTHTSYxQnQIKQlgpuOVXdscJyxfPirixQ22iDbJ
 xctUY8ZBEkht92tgoR3//pMn1wiMQ2kj/mvEXfaWbQGW8AtP3gfYZVE4TTNQY348jiazrWUxMwF
 UigluBrHJWOSIb2wScULZl719fTmkoeEwTgnJDeir6Ajmcovhv68zGHw9ZgTzqKEtwWh5rQD/HT
 QmNdRMlKrZw7hLUHWg61lAUyf0yE/T4Kl74VrF/rQt6k1ckVtdl2oYyOcSgwEmyuWyxNL8t9tP6
 zoY08uCeSTqxn7oDltjPdxcThQgRQC4Bgoe57D+gvolAjkcbRgJIKXagLMjKmdozFbMQopXinY8
 oexfjo/OK6fIJLXWvC8sjYzsSjhQ18ES6SZ/MawIPWTAb/QRMPxTfnHshDQDy6KMgowue98jSb4
 0aNTRkjehATw5Gdc4aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cgpk
aWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIvZG9jcy9zeXN0
ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi4zNmY1NGYwNThhZgotLS0gL2Rldi9udWxsCisrKyBiL2RvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdApAQCAtMCwwICsxLDE1IEBACisuLiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCisuLiBfSGV4YWdvbiBFbXVsYXRpb246CisKK0hleGFn
b24gQ1BVIGFyY2hpdGVjdHVyZSBzdXBwb3J0Cis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQorCitRRU1VJ3MgVENHIGVtdWxhdGlvbiBpbmNsdWRlcyBzdXBwb3J0IGZvciB2NjUsIHY2
NiwgdjY3LCB2NjgsIHY2OSwgdjcxLCB2NzMuCitJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUg
Zm9sbG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgorCistIEhWWCAoSGV4YWdvbiBWZWN0
b3IgZVh0ZW5zaW9ucykKKworRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhl
IEhWWCBleHRlbnNpb24sIHBsZWFzZSByZWZlcgordG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3
MyBIVlggUHJvZ3JhbW1lcidzIFJlZmVyZW5jZSBNYW51YWwKKzxodHRwczovL2RvY3MucXVhbGNv
bW0uY29tL2J1bmRsZS9wdWJsaWNyZXNvdXJjZS84MC1OMjA0MC01My5wZGY+YF8uCmRpZmYgLS1n
aXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQt
aGV4YWdvbi5yc3QKaW5kZXggNWY3MDg0YTZhMDguLjQxNmI4ZjdiZTc2IDEwMDY0NAotLS0gYS9k
b2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CkBAIC05OCw1ICs5OCw2IEBAIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gUUVN
VSBoZXhhZ29uLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09PT09PQogLi4gdG9jdHJl
ZTo6CisgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

