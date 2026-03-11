Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9AAFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaU-0002Ew-Mu; Tue, 10 Mar 2026 23:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaR-00026r-Ok
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaP-0005ml-R1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKN0nI1863463
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZnXLXreRXZinzOrIobpoU6PRKGdpbBhwYdiapKuqRs=; b=HXxUNvjjrFA3jRZF
 OeUrQlm7D7RhPQt2hcKW+5Z0rqtYhAJJjt0HBz8rUJB2zHnNqVyW5TnVkDL5Bub/
 S4La99zjep5bYV/y/072lADmbBd7Or92KrFmlOQRqfCbngQ3jlAhFXJGR3ZVvbDg
 lrwBOB91n2UZVnpv4cyT0L1obiN7iIjB1RPY5ItJfTn4GTNX9hbhiTfk9oCFPC6x
 0yybK8ybA4bTwkfpitbkETGJGAiVtcNIZH9Nhie5uAknRdarae4jMBB6Bg70UIs5
 wOsIrRgxz+yUMB2+McwdTz66ic4WHLGAdQnBdr9R8Z0Ud77KMMLbQAmIqj3hUMyF
 ybn5mg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82nfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:06 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d74d78c5f7so5578459a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201005; x=1773805805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZnXLXreRXZinzOrIobpoU6PRKGdpbBhwYdiapKuqRs=;
 b=GjveeAlzIbeSLUkbVW/BWZJFTD268jsuMWT5W6ztJ4quqqNUiwZFYXPAdHibkRLbra
 EtljxRGETU7uEWC/uOatINwGDpIf8j3MQTjk0V+S5De31J4VaEYCl7NCltLnwkKezkG0
 jkgR9Oer+P2JWtPKNlvealPwuvHnj7tLkoPgnBEmiPedfcaVaYPoOH/pqMVerSqnNWrl
 Lrf0eHMarIuemkO+rvXqN9J40H7MDuHHe0AFO5cM+I/ShDW9nQEBeuyclrQLmy14ylhS
 N+lkT5aRAm3LFR15TLNK4Bol7X0s9j5y64yv7Ao6CXGUxXFrfZlu+3eolQwrjLYsONSs
 oYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201005; x=1773805805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ZnXLXreRXZinzOrIobpoU6PRKGdpbBhwYdiapKuqRs=;
 b=joQnQPi2ZnbdZkH4PtSih6EhO+bL4AOteSnK4i0P3YA6NSM3cBKYKERFCiyTKHwQPM
 1hmp3w5OjvovMY9V3eHj1aXjRZZjTGiFGcxM76SuA6WGJpexgNrVtcnFBCAFbpU+LKlD
 t26lgFh21+OELDDml4uujiBkJQMP3QB82v3PFX2awbe9oYqaHXpQmZdPT5pqqGtK30Sz
 6O9ns9XpGUAHejHveuvkT2B2qyWc+64dVZDzvR1OUGM1fh55kcunAv5qcamJvzc3/XTv
 xt7I9TDTgsXd7kFb0pWpF+L+yWr8iPI0dg8BacYp88rV49coXJGolBKC083LWyYMInTy
 4Aqg==
X-Gm-Message-State: AOJu0YxheN1uwfp3/jAb8G1KtOrkqEPSBUdRRprJmCv/5R2PgYuiE9Hx
 DkMNp3CtyBn3ncSjlHLWePw2R6vPJhIBuICB/I3B2PsYgPzR26qz6KA2qyVP8T3T3PHfDw4Ay5E
 dwIB4KljVLxekAtRmb6FsINTMK2h8aeK5XDixmhNSjT9Vffq80LAH3CJ5fu4EfudQVQ==
X-Gm-Gg: ATEYQzy7T3XD7i/msGOW/wnNO4gmmpXvKJpyRjodBRuIh2sxnB0aiGZ49oqZpOHbG7b
 MZwEExYNZSKR2URBdahkJFiwyfdTqgoJtTNT4ibAwl3V4OvOt5oPgC8G6z28ldMl6xAVypRkk1v
 TxN2YpTiiApK2o6g7Dk4Q052/pqOBtlBz3M1wqZzzSftVYe2tNt02yiLNHN6oliKhWifCQAhry2
 lAF5oyrzAG6BuzsrswKWiZ97Y/GlciqXlDvUS5+PbCNouzFlsAfW/1DzOdAr56bSiG9tm9F0IAk
 TkC9O19s45f6jMf1iQaHA1SlQHgGmHvNr8JRWZ2sjfeSLLsdiU4psagHZLRcAV2H+Kqat2Ff8SW
 C6GpFGYRa1W5XEYw6wPxKLjKkGgMzNwBMcfzC2A3+ds775pDsc9iJitResMcSQYyKLWzNvA==
X-Received: by 2002:a05:6830:13c2:b0:7d4:8c9d:dd2b with SMTP id
 46e09a7af769-7d75989e741mr2357050a34.0.1773201005383; 
 Tue, 10 Mar 2026 20:50:05 -0700 (PDT)
X-Received: by 2002:a05:6830:13c2:b0:7d4:8c9d:dd2b with SMTP id
 46e09a7af769-7d75989e741mr2357042a34.0.1773201005054; 
 Tue, 10 Mar 2026 20:50:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 30/35] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Tue, 10 Mar 2026 20:49:18 -0700
Message-Id: <20260311034923.1044737-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: WzmjJNFBTUG4w7k4slSmNOFXYn8DbWYY
X-Proofpoint-GUID: WzmjJNFBTUG4w7k4slSmNOFXYn8DbWYY
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0e66e cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6d93uPKVDIcG5a3x7xMA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX1R3rwyKWdgoG
 2e8E1Pmk7p4JFLPTw6bD/WEDgBXg0a5+L+eVNFmxMxZu3sLJYY+MbWKnsr3tAbYcglh7rYp8l75
 nFAA/cBEwxvxQeayd4DKgPdnE5NFb1EDUDDjJ2DFgaQfY4V1ei2RKAs4wwT2rUltPr8GdkOS2vj
 xulzFAKk/ZnkPB5f+fEWxrHHmlaiJJQ+OLXVUWb0qHQkVOoMRsH/Di7eYA/l4IPlVolQF81H+2d
 sSu1sOTNTGv+GqSp6GXy4DH8O4NG8Gc7HWzUItquSyvvxYsj7WI5O9SxVpa5dqahB5GaavV2biW
 NGlSGhg3Lo1jEE0X9IKloeOz59C/k+d40gNp2sQ744RvcZQJoAz1Jv23A3XRKXvr7bAKa4IU3c8
 VP5KTwwWWpJNZnetZRC6XC5XuT5uuiLFe2em33MhBLY9FZpcyB5E+Pyw4lirIf0leuXTwrxYPI6
 Hqt5W01IFm+v2fXw+Fw==
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMjEgKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5k
ZXggMzU2Mjk2NWM4OGEuLjllYjJkMWJiYWJlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNDgsOCArNDgsMjYgQEAKICNkZWZp
bmUgVlNUT1JFU19NQVggMgogCiAjZGVmaW5lIENQVV9SRVNPTFZJTkdfVFlQRSBUWVBFX0hFWEFH
T05fQ1BVCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9T
V0kgICAgICBDUFVfSU5URVJSVVBUX1RHVF9JTlRfMAorCisjZGVmaW5lIEhFWF9DUFVfTU9ERV9V
U0VSICAgIDEKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX0dVRVNUICAgMgorI2RlZmluZSBIRVhfQ1BV
X01PREVfTU9OSVRPUiAzCisKKyNkZWZpbmUgSEVYX0VYRV9NT0RFX09GRiAgICAgMQorI2RlZmlu
ZSBIRVhfRVhFX01PREVfUlVOICAgICAyCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9XQUlUICAgIDMK
KyNkZWZpbmUgSEVYX0VYRV9NT0RFX0RFQlVHICAgNAorI2VuZGlmCisKKyNkZWZpbmUgTU1VX1VT
RVJfSURYICAgICAgICAgMAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE1NVV9H
VUVTVF9JRFggICAgICAgIDEKKyNkZWZpbmUgTU1VX0tFUk5FTF9JRFggICAgICAgMgorCisjZW5k
aWYKIAotI2RlZmluZSBNTVVfVVNFUl9JRFggMAogCiAjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8w
IDAKICNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzEgMQpAQCAtMTEwLDYgKzEyOCw3IEBAIHR5cGVk
ZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5j
cHVfaW5kZXggaXMgdXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRo
cmVhZElkOwogI2VuZGlmCisgICAgdWludDMyX3QgbmV4dF9QQzsKICAgICB0YXJnZXRfdWxvbmcg
bmV3X3ZhbHVlX3VzcjsKIAogICAgIE1lbUxvZyBtZW1fbG9nX3N0b3Jlc1tTVE9SRVNfTUFYXTsK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMK
aW5kZXggZGMzYmQ4MmJjMDUuLmIxMzE3ZjgzZWY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzEwLDYgKzMxMCw3IEBAIHN0
YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0
eXBlKQogICAgIG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9T
UkVHUyk7CiAgICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9H
UkVHUyk7CiAgICAgZW52LT53YWl0X25leHRfcGMgPSAwOworICAgIGVudi0+bmV4dF9QQyA9IDA7
CiAjZW5kaWYKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKIH0KLS0gCjIu
MzQuMQoK

