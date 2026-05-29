Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40545CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C7-0004XO-TT; Fri, 29 May 2026 17:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C4-0004Oh-PD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C1-0000TA-Bg
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2OTm1862680
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=; b=SxT95OcSKc7Gx9lY
 F7jMPk9/fapfiekIAbnZ82IOPt6NfxuHr+4L4Ka/weldyYk4IWpC3gRaX1PwucYD
 xsOmkYW8jZM/oanGeWgduGZr3O/J9rEo3eOaooLmXO44nILjtVXfHmE9x9XCFLSk
 swQTBPfFjgr6pJw/Mhbs9+KcfC24RIC/0rLhS3Wp8qvZLF3r3LSmyczDH00+BF13
 e37IxRPrCtlQTN3NzQG7I8Hc7v90fLCZM8lEa8UlF0ls/DwaKGFcvT8CpuvjtF4p
 d7nIQ6Byzc4ppYkbJArN9t3vS4DMc+mlRHdkXs2lv3zvzOGsIMA8O33F7qotGCvY
 M82h4A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te4p7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304f1820babso1364110eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091791; x=1780696591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=AsUv0VPgC9e5YTDOZnaggQMkJ/DOKKK2M6yb7gGws8ImDM9xCAz4PRQhDn8zFAZivD
 UMVfxhbKtCKjUuk8B1W6B+vbaWqWxu1gqnSJVAKYtsQyyu7vZeoipZmrvNHQd9RvKT3V
 KeIfZk9fqa1n2FoKOnNZARvo/wRXsHemubNOH8nxGvrA7abgwiSYPYsr4qD7MxkgXSu4
 vZc1fnwfw/UMDKHhmy1u7Yr2xxR0iIceCeqNjbPd2mhPl4EQTdmBiPp75alWZYklcGow
 HysuJSPiYt/s8DVCCn/nvuBEoyTPDGxDzwA28kEh0jsP/JVdVegegUtAlRflAl8WR2Lk
 AJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091791; x=1780696591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=R2lieIY5QoFpVoBpmxg1e7SJme1YWEiXHEVGhdjHs6A+dvLNBfckImwYRtbqPRI2tR
 tf5kKPXPsE+SCaUjhYXgoCmSgTMHuwVHHzr0rglPFM6wO7SwMCks60SFDa8wRXnpJbjr
 W2DUYe7SpWpL6TMbNmBnVOk+PKcai6HGsXQXDNEzVljjRvv4EHSarhhJIpIwU1YiJ8DU
 MCmeMjIAz5do6x63HzQBX7nd6PTsmujWiv1BeptvhX4ZF7wX1eJ3CUqUotLlvG7bEGwb
 xpDCc+/g98zWYi8DF2FlC9Y+kK/zQGWJdMe7qINKidhjybVlZGxnre8nJB3fhPCPeR0P
 Im1A==
X-Gm-Message-State: AOJu0YzLasTACVODa2g7TkL65waJL5XvBtztevWAKhjbh+Om4a3zLBo/
 fVkOG05x6QeKzt4VHmD/vscDvQFAlkFYLmzcWKF/msXreDVycU780e8O68/y20fX1KTiZq77/lm
 lOiNiJOhrDR2UsygI+mZb1n2d+nbjmAguDpM5Ps3zyoziF/UiZsiuSsp5P2wMQRWCQw==
X-Gm-Gg: Acq92OFto6tlBpKcrU/cK21gTnvJO4ojCfIlMiVw68bge/0SXiirqTTasloRfpj+HeF
 3KI+WsLuB61L83/iTHynSZyQN3YS6TjTKpNBBBxoGrqD/lH4IeJuiW8IHav62uEdc3IurPUiWz/
 WGk03qFN6T2ypzE0IVouFjM6qynh/X+rygWktjeGgbjTqvXbDSq2EuIEhYjsqVJpwSvoijSLSd1
 yPnfNY5sSqPgg870+hOZv6CXjS+hlqszIn6nCy4QxHyVM1gw1bmzDj3+aNoe0FYs44dFnnXTJtP
 mkY/gurOOJvjFcFTnSvXwGM02PhwNSjhFjTJTu7+RVgB4GtZKcN9zgKS1o2fRP+SCDspX5s0Uyk
 S03ASynipEgArPNeMQJ3RYDKGuTWV3rLLwHnRovQGAO/HcSNLR6cTk4h+tEnJnUcgj6lfeHoDY+
 iO8isV
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr789268eec.31.1780091790764; 
 Fri, 29 May 2026 14:56:30 -0700 (PDT)
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr789257eec.31.1780091790262; 
 Fri, 29 May 2026 14:56:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 18/38] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Fri, 29 May 2026 14:55:34 -0700
Message-Id: <20260529215554.606133-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Fvfk9vOhb9Tk4BLZ72iPUFyp4GtJOaqT
X-Proofpoint-GUID: Fvfk9vOhb9Tk4BLZ72iPUFyp4GtJOaqT
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a1a0b8f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6ZP5CW58HnX0
 ATha+2g69zAos+SDgvAS5CCU8C9Udl1ysZdo9JUsCBJzIZQKEsk3o0TOAbKoItpgN/zieUVgnsl
 j37Rp8G+UG/RdSzm1VONXadTcUYKjQegTxQ3kMaDO9KDa6pnFn+ujwZsKdJlY1m9qc6Os3XJxrg
 2ZiD7jAJxs+SBvdYMASsbk3FOSB+JxbPE45NEQUS7+pIruQ4lLxJE/d/ra3SuzCFNKsCShP4OW2
 72ZJJ0CaWpiJc1YqGWs0nwfBlSMdgoUeQ+wn99jxGwfsef8kn+I3UfvMpGN3JmcDqhFJxViQV+e
 o3kouISxihB2KHHMSBykgMhGruhaGIC59h81XDxmlLR/hNUx6XibF75FpJvOTk3MeI0JJ7G1ROI
 F11DwHo+z3xG+7aq8L/gph+S1P77167AvfY6z321NFbdF+JE6vdG9yF06bDstGsGTZHpxkPc9iB
 QeB5f3zIGZcrDuPsxUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNTM4OThkYjgxNWIuLjM1OWJmMTJmMWYyIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3Myw2ICsxMzczLDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

