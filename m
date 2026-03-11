Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC9BFD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaR-00026X-FJ; Tue, 10 Mar 2026 23:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaO-00022t-R8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaM-0005aq-La
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJAinD303863
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4ubuonnIbgioCt0AFo7L5fPLuVKOnma6sTGNsKC0Pzk=; b=nUcbKh/LGFtb90KW
 DwAp4ZqzW2xvnBs/kYJDcBvyee4HIoZd2VgDD6s5hDUlVnjSGSsBBc3LH5hQC4Qq
 qksG2FGlEH4soE+ru8+zuylVvXfFd4OEkdCe4Q61RdLzPfos6rHupjWqKE26NDMm
 q4pSWLq35BJRehGVJHsyD42W+Blp7KHNdFjPuymY0flPUpYFVZwWwsgUtTZMY7ZF
 W08YOrL1855aXj1of0zKv0NUn4p94EBNNaGE0MmGbfnOWCE+OpfG9iTu1hwTEBWS
 JkVv3152j9nEp3K1yOIFq1XUaO4ZZIVl7jzpqS8+Z+LW64rteJ9dpuHxLCIpWTOT
 A6J1Sw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf3h4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:02 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d7510702e6so19078288a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201002; x=1773805802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ubuonnIbgioCt0AFo7L5fPLuVKOnma6sTGNsKC0Pzk=;
 b=NmVNM6vwQgaJkcK44656dfr0wY9/owrxCa1hDeoe7XW3p1oqtirt6UINijfCXuOMXp
 /ibhGhEklIujVXDym4lwtZhtCTwIJKZ9fKEZJrcaa/8qSGJtgozMrfTwBPLC6eF6m+YZ
 jAzLV0yOW/GqLkvAtidXwVWavMT+Fhfn0rBBcP6N7kFZkUjxlwWI5MU341GTRHZWAnS6
 ZPCxyVc/QRfOBEHzGpV9iHw6lceOU70z2w1/kR00TrRT5pnDItwLKLpTZ+uSbxMgMDua
 StND1zVbLP4khTn47pPnxJXWbazbpzvCdnt9PWycTjT9tZLu9a+6Gd3lsebvAd6CVC96
 +kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201002; x=1773805802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ubuonnIbgioCt0AFo7L5fPLuVKOnma6sTGNsKC0Pzk=;
 b=n7zvnqY15NUBZblazAiAGBK2KdIFIqq4tWjoyP/TZ//VNCxMjaqNbBFeaNgW0DIfh6
 ynnvQYIwSrqukNR31CVNoMC1py3UDHe9syy0TFG5MAi/j3lYP5aacXEA6E3l5tq4NMP8
 AZL+wExe+NaPH3org+Xexv3UdniO8aubbcN8MeZ62GEOnWsQriW6D+ayCt0LM4rfnvve
 VkZmu0jq/m3ZUOcR8IKwPJsiFjNoiGz3fquIOaW8B2cYu46KzIlvfQspaii98hH3Myx8
 WRdsHgmLnql66HcedBsCBjUYSZmq1czrniRmqT59qsdP4m1IzsbjxapF3c8wGGQNe7qM
 +JgA==
X-Gm-Message-State: AOJu0Yyot2hWp1MF47Z5sFAW42Dx3FSPa2XIISftVMwNR1CTnDim9hCu
 d8oCXUl5433++wG60GV1HJqVqFsGi2oFCqu7lwrJm7VipeY1Jq4uyuGJhnyr/myDFwlWptY4cdA
 aXrlji+hlPFlJpmlSn00B3qiJGqN4dzwkRwUNu0KXX/XkEkSnUoGHl1LfcFeUUW4WWw==
X-Gm-Gg: ATEYQzwt4yez8w9gKp38PvvABUDJK5ogmiYyT4Hl1nrqNdae6LnlLDProqFZQcJBfM/
 kU0W8+iI1NBpV8V189Qn3NCQX/78PLNqHQyYcElxvgkBmuqJRLfm6tWKhyUvPiVbzrEYbyE6G9L
 ZGhkp46q+lM9XCw2eZt9VQhQE7IGSugW+6owRmsvcqP8M1Jnt7M/kI/oyZEKds0OwYyHiQQF50Y
 ApGjtqhBWykoPHO+4Ugwm0KfX1lYSwEKuTDR06gZwMs5yMuxa+T2dXXYiczhZGomefW9hHnkQlN
 SVQ7rQr+JKFFPF3CQSlpnt+sMHpcX5GnbJYLpuxWSSc14hLO/CJZ1s8/9QO95vdVxy9NG9YmhYx
 y/h6SQJyK3NXJ85LriLp6E12lpVI8SPk2gxMkfE0Zd3O0Zbm3Pyu7rkavkm0CIE8iDD423w==
X-Received: by 2002:a05:6830:6b04:b0:7d7:4aec:7ae1 with SMTP id
 46e09a7af769-7d76a8e9bccmr837451a34.31.1773201001949; 
 Tue, 10 Mar 2026 20:50:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b04:b0:7d7:4aec:7ae1 with SMTP id
 46e09a7af769-7d76a8e9bccmr837418a34.31.1773201001134; 
 Tue, 10 Mar 2026 20:50:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 27/35] target/hexagon: Add TCG overrides for thread ctl
Date: Tue, 10 Mar 2026 20:49:15 -0700
Message-Id: <20260311034923.1044737-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: DBZl-aUKwBJqXFPjdoAFO_DuPQT3drqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX2LUlXoiDYeLb
 lOpeCbyzY/yQofvZKFTbnOMXAryLqkdvH0yndocVRFTTntt8nF76jtG80StKgeCGucG9C9fmlOO
 GRrDD1KxGrudLl+HKXhLlqHqt6mV4Jz+9X+gSIHE5icl0aB+KLAmbg7MV31cADPSHr7ZoBqd8j6
 z+ij1KtGjwx7Q77mKHyzisW9uzRs4Vn75SK8vOv4MStjeYMr4Ml6rZXV/bjDADQPmTRxYTmLZ8y
 hqBqnBNl5sPfnWPMSdMn2cVdTupKQb6WERa715TepCUgZIzQKRAtNjzLzlvGDkV5EO1dD24uG01
 VQ9ZIXdBOjwz994JQr2NPzJoBcwMhUJydqeAZLWG+W31KtJXV+1+8cbQwgCvf3DLytOVwHzrFEA
 2HI0vW9chSBa3fkX0aoucp6/4AlCqZ9lMTP5N8iwg76aijXd6dbYrvu9cegTZpNdiaHeVcvUrcn
 5dpOtHVVk88QDI5X98g==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b0e66b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DBZl-aUKwBJqXFPjdoAFO_DuPQT3drqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgoKUmV2aWV3ZWQt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMTggKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCBjYzcyY2E4NmRiOC4uNzM5ZTk1ZWE2MGIgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19zeXMuaApAQCAtNjIsNCArNjIsMjIgQEAKICAgICAgICAgdGNnX2dlbl9leHRy
aF9pNjRfaTMyKGN0eC0+dF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19TR1AxXSwgdG1wKTsgXAog
ICAgIH0gd2hpbGUgKDApCiAKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfd2FpdChTSE9SVENPREUpIFwK
KyAgICBkbyB7IFwKKyAgICAgICAgUnNWID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2Fp
dCh0Y2dfZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QtPnBjKSk7IFwKKyAgICB9IHdoaWxl
ICgwKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3Jlc3VtZShTSE9SVENPREUpIFwKKyAgICBnZW5f
aGVscGVyX3Jlc3VtZSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfc3RhcnQo
U0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9zdGFydCh0Y2dfZW52LCBSc1YpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfWTJfc3RvcChTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgUnNW
ID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfc3RvcCh0Y2dfZW52KTsgXAorICAgIH0gd2hp
bGUgKDApCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA5NTUyODcxMzNlNC4uNjgyZjBjNmMyNmUgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
bHBlci5oCkBAIC0xMjMsNCArMTIzLDggQEAgREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMyLCBl
bnYsIGkzMikKIERFRl9IRUxQRVJfMihncmVnX3JlYWRfcGFpciwgaTY0LCBlbnYsIGkzMikKIERF
Rl9IRUxQRVJfMyhzcmVnX3dyaXRlX21hc2tlZCwgdm9pZCwgZW52LCBpMzIsIGkzMikKIERFRl9I
RUxQRVJfMyhzZXRwcmlvLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hFTFBFUl8yKHN0YXJ0
LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShzdG9wLCB2b2lkLCBlbnYpCitERUZfSEVM
UEVSXzIod2FpdCwgdm9pZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIocmVzdW1lLCB2b2lkLCBl
bnYsIGkzMikKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
Yi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBlODFlODliOGJkOS4uZWFjNmEyMmZk
NjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDIwLDYgKzE0MjAsMjYgQEAgdWludDMyX3QgSEVMUEVS
KGlhc3NpZ25yKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CiB9CiAKK3ZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgaW1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsK
K30KKwordm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgZ19h
c3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihyZXN1bWUpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCBtYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKIHVpbnQzMl90IEhF
TFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCkKIHsKICAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

