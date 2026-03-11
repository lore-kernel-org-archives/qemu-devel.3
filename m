Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8CAFD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsG-0000rc-C3; Wed, 11 Mar 2026 00:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As9-0000oL-5d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As7-0008WN-5u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKDfkF1863186
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zuRUYpTiC5TwT27OFq7oroDGlRXSCX5ZcVkOh2x95a0=; b=YiFvIa9xGsQJVvS/
 knATHWX0ojwKe519x8+LMEbeGUZ4BXlUj+BHvkmxw9dUdXZQH/EBkJdefmoWVBja
 f7t/3ZAqYtK2mSZu63DlQwgZd218d07Exs11JykgrKGFbDwBNqiYIfC+oxuTVBIC
 ZW1Kj7kaWMyG80+YFKviWUUhJlmmoWSpD10fmSfbvoFS59ZdVgZ80BaOe3d/jrla
 vs8gshUL9x6igYjodYS4yKBm7e2JO6JHQqgu1AFW9LYVhMi54DH7+qP/wDDFSzFa
 w61i+4LIkx9t1im1CfN25bktYQ9P1P00qqV1426f2r9s+iR/LbOghFN0sht6HnNs
 fALv9Q==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82q2d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:33 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-41704d89a50so12599108fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202113; x=1773806913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuRUYpTiC5TwT27OFq7oroDGlRXSCX5ZcVkOh2x95a0=;
 b=hEwlanNb1aNgDARlkKEn7OtwT6/dGqeMWwlink/oZ0FrtJGfCOMCdYfNvvrHG9wPu1
 xco0PfDAo6B0dChBVN1D0UopdP+s0uHsZt8zrsmwH1d8bMg/kMX7a3UQbZIRIOsVk7Iw
 /rBoRK69u7VxuXhuIrbCNV4N/Q/KDtFontUaftXIePG9UijdFiaQgWCX8aUy810bNW6k
 OsRX+g+mfqnY0jxFT/r0uPZLEYLMYsbaZicuqJqbwBLV8rDaMBZFoTn+T67n8euiDWok
 DlxRxBBdsu0WfWFv8E0BlCw1A2bB2rcT5929LRyqKqizMWHna4jftegXd1k8EId/P5Ap
 TBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202113; x=1773806913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuRUYpTiC5TwT27OFq7oroDGlRXSCX5ZcVkOh2x95a0=;
 b=DDuVe7F938k/QOwiC4Mp/3NuxPmLmDJaO+fTNZ4dWc6bpzIZgvF54n9l1LGQzBXfDH
 nAlLJhXKg0N4E7NY7ToGJhXRVAhF1FyB6hhYDbZWWFb8aw9QnuwSI6yTZBWWkS/7mBQi
 BA0w8NAfJH7k9R1g70jTHzZKOIsEbfvvmzHotickiEuCDmwCB3Gnfr0Wu+gannFJKlEu
 yK7n0iNddtUe/CNpMsIF7TiAWLQcaCs4kGoFMhfUcw7SPPaxsraIHclkqIfhp5XCI4MB
 b1ydqKIW5dDxCN9vfDD/fswApFiZNAr2rt5r+qA35Idm8UMfvZ8WDfsS63kN3I8PcYxj
 V7fg==
X-Gm-Message-State: AOJu0YzvUSMgiM47nERgl0KdQM1VobFljysIdll9Q5r4NeKHywoBx+z0
 ZDFDt+BYee8kZXo2cNRvFhuM4UEvXAG2O7wjj/TCwwByYehXQVm2D0N9+Mt1yPvwfYBiZfkku8J
 IN5iTByLOiLqdf/vAALbeSJw8iJRiqh/lPEbZ1ce4g2qP+0cTkIx/WESs3Id9xqJ1Vg==
X-Gm-Gg: ATEYQzwbhWoD+5Qqlpa+RswjhSNtMMQcjRWvYxyY7AAWOQwSnl19qWYSEp1dlhQciGo
 W3VPjsC11fMP1GOIUuh817+Q2DqDolqxh1OO1hXWGnmZSLRtNiwo2uk6sWhOBpdPiNdb94//zbU
 b3W7kJCIfn9g2/p1QEP6Rux2j03qC5EscSNYjhQ28DnVK52F9cvvIw+MCgHblADtHuV6FIsEf6T
 NB+u/CU9R52JAdhq0rEY99eAE4VLzJ/x0Z5bT1YtBmr9eQNpZF90xk+HteU5sV59etZao5QYDxt
 GcFhV+E4lVueGXubnFGnlpRGMC67zdcLh8kQTBvLzmV2adtra5KeUgrV4turvyg/OzY8F/CpW39
 FJeO66aFuphuqL6WCIQAw3lKCCL4RGzO2v0Vn1xc7OPe1OLlckp54fTqxwo4FmMBcqNcUVw==
X-Received: by 2002:a05:6871:3143:b0:408:694d:ff27 with SMTP id
 586e51a60fabf-4177ca59999mr844357fac.34.1773202112776; 
 Tue, 10 Mar 2026 21:08:32 -0700 (PDT)
X-Received: by 2002:a05:6871:3143:b0:408:694d:ff27 with SMTP id
 586e51a60fabf-4177ca59999mr844344fac.34.1773202112411; 
 Tue, 10 Mar 2026 21:08:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 19/32] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Tue, 10 Mar 2026 21:07:45 -0700
Message-Id: <20260311040758.1068731-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 8zSr98qJlAF7CAst-OMtFohwRCbMBXPN
X-Proofpoint-GUID: 8zSr98qJlAF7CAst-OMtFohwRCbMBXPN
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0eac1 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX8op2XXcwdxDn
 ZsaEXPUugDMUdW7h4KBb9gGer57NVdkmMt775IbI2OyugqQkvclvblUcMEoR9TI0O9pAo8yZMFO
 goeAWQ8WtJgLii0DAu+m7YE4ifZ5B/2sIdtU7Dvtaf7CMLaoAjGEOOi1R8JufwnsGd+LsPrb2Z5
 tnc8J6r0DGBW1hTEk/kr1oAA/ZyRaImvWK5+dRLcvrgaMytiH/IpjEjrKfC9+Hn23ylyeYYZ4Fw
 PozU6E2TXZOZyo+c/ts5k720dvl5rJM1Fu7sUndvuXunJjTFFOy3vMPhe3pVh0gpEkfdViEweUi
 W5i/OdHGikl+eKami4N67ltx7Sn+5gpEAj33CYfdWvOwwVJnMP9qWWiw1x3smNzSP+b2ChU0Z4q
 KQJptFdnlg5MTqVbQdmP07iht912uyLO4iZa+Gbgt9oR0vZJdu6tYKrv+peSwW/0gs14D4RwyPF
 Z4xpnGTez3qi3vq7E4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBjNWVjNDc4ZWY0MC4uNjg0OWRjNzk2NmIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRf
cGFnZS5oIgogI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKQEAgLTUw
Niw2ICs1MDgsMjQgQEAgc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBhZ2UodmFkZHIgKmFkZHIs
IGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQogICAgICpwaHlzICs9IG9mZnNldDsK
IH0KIAorc3RhdGljIGh3YWRkciBoZXhhZ29uX2NwdV9nZXRfcGh5c19wYWdlX2RlYnVnKENQVVN0
YXRlICpjcywgdmFkZHIgYWRkcikKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9l
bnYoY3MpOworICAgIGh3YWRkciBwaHlzX2FkZHI7CisgICAgaW50IHByb3Q7CisgICAgdWludDY0
X3QgcGFnZV9zaXplID0gMDsKKyAgICBpbnQzMl90IGV4Y3AgPSAwOworICAgIGludCBtbXVfaWR4
ID0gTU1VX0tFUk5FTF9JRFg7CisKKyAgICBpZiAoZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAm
cGh5c19hZGRyLCAmcHJvdCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZHIsIDAsIG1tdV9pZHgpKSB7CisgICAgICAgIGZpbmRfcWVtdV9zdWJwYWdl
KCZhZGRyLCAmcGh5c19hZGRyLCBwYWdlX3NpemUpOworICAgICAgICByZXR1cm4gcGh5c19hZGRy
OworICAgIH0KKworICAgIHJldHVybiAtMTsKK30KKwogCiAjZGVmaW5lIElOVkFMSURfQkFEVkEg
MHhiYWRhYmFkYQogCkBAIC02MTMsNiArNjMzLDEzIEBAIHN0YXRpYyBib29sIGhleGFnb25fdGxi
X2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKICAgICBkb19yYWlz
ZV9leGNlcHRpb24oZW52LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBlbnYtPmdwcltIRVhfUkVHX1BD
XSwgcmV0YWRkcik7CiB9CiAKKyNpbmNsdWRlICJody9jb3JlL3N5c2VtdS1jcHUtb3BzLmgiCisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgU3lzZW11Q1BVT3BzIGhleGFnb25fc3lzZW11X29wcyA9IHsK
KyAgICAuaGFzX3dvcmsgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZ2V0X3BoeXNfcGFn
ZV9kZWJ1ZyA9IGhleGFnb25fY3B1X2dldF9waHlzX3BhZ2VfZGVidWcsCit9OworCiBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKIHsKICAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOwpA
QCAtNjU1LDYgKzY4Miw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3Bz
ID0gewogICAgIC5wb2ludGVyX3dyYXAgPSBoZXhhZ29uX3BvaW50ZXJfd3JhcCwKICAgICAuY3B1
X2V4ZWNfcmVzZXQgPSBjcHVfcmVzZXQsCiAgICAgLnRsYl9maWxsID0gaGV4YWdvbl90bGJfZmls
bCwKKyAgICAuY3B1X2V4ZWNfaGFsdCA9IGhleGFnb25fY3B1X2hhc193b3JrLAorICAgIC5kb19p
bnRlcnJ1cHQgPSBoZXhhZ29uX2NwdV9kb19pbnRlcnJ1cHQsCiAjZW5kaWYgLyogIUNPTkZJR19V
U0VSX09OTFkgKi8KIH07CiAKQEAgLTY4Miw5ICs3MTEsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBj
Yy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAiaGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2Fz
X3NldF9pbmZvID0gaGV4YWdvbl9jcHVfZGlzYXNfc2V0X2luZm87CiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKyAgICBjYy0+c3lzZW11X29wcyA9ICZoZXhhZ29uX3N5c2VtdV9vcHM7CiAgICAg
ZGMtPnZtc2QgPSAmdm1zdGF0ZV9oZXhhZ29uX2NwdTsKICNlbmRpZgorI2lmZGVmIENPTkZJR19U
Q0cKICAgICBjYy0+dGNnX29wcyA9ICZoZXhhZ29uX3RjZ19vcHM7CisjZW5kaWYKIH0KIAogI2Rl
ZmluZSBERUZJTkVfQ1BVKHR5cGVfbmFtZSwgaW5pdGZuKSAgICAgIFwKLS0gCjIuMzQuMQoK

