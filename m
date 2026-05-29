Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5EACD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dl-0004GT-I1; Fri, 29 May 2026 17:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Di-00043J-Sx
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dh-0000rb-5X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2MPK1912315
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=Ml5I1qcwrNgwOQm5
 fq9Noush7d9sn0qWhqUaIbu5MCSN4n+8WXzsD5XTkM/8tAuPO3njiuNlN2NXEmoW
 aOz1LZ43iits9T2l187rHVzAsx5uy6e4sIpHHttSb5LzfAkqtDUoy2UmpN7yOHKp
 1VHCLj97mToXNwU4xhfGYdhA4Uxvo6Lye+3QxtLBSa7OPwDZuEGwd+KeIquME+u2
 pBmMP4/Cigc/UVfSxP4eIcHhTVNxc/KbjzUfmno16jTitpKrfFUkgLwM2I/jhfUV
 YYk+cuQ+ehmILm5kvrMH/3eAqibB3wBngCPoboshJuiui5AywxZACMU3x9MMgjBm
 xhNdjg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu52grf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5136617eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091899; x=1780696699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=GSqyiCVZF1gCS0vEt3tXSuz3/4XCZ0Sx2ofwrE7313byVHVEeofWDe6w6h0Ego7bz2
 E5bfmFV1ka6WiSnAWFGeYy/WTDmafkySKuzJuOmtR4QR98V43NJ7fNegJPkBaRT0h66G
 RO6KWoipu+DtS/VQT7hctpfeyDtl0/fjiU4iOYVMXZ/KMCgftqfr7LRwuqlGFRCgOUgY
 NYt1xBTE1cnV4oAsANHhsLeavUVKIr9Qds/3BvH+hwHJpgqd2Dw2o3zpXBcF2fBC+GtZ
 zb1cwMZeP1h3dTs790DJPP5EBGyJYHiY9gKzVARzr0i+DP11xFW7PtytTFTppnE7WsRJ
 lKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091899; x=1780696699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=QG4A93IicmMcKPwdrZnTFzwPYeErDCL3aalwCGTmY59y69HGUZmICDsBrKGuCPhNjU
 1HVV/+/XMVWhiqLR80gUModjWdSJSybG2FGwUg/DPMdV7QIhG7md33mMHm7VokJSHUW4
 3fbaPwhgvKBRBzUHsNrFjn1yMiVcOy5q/wCeXax3ZfNCttH5+hLalYIAKSFYj2rn0Y+I
 MJJqq4OnFdnJRcx+n2ngkA+q0wFqtcfRrefxbtLTG9ah8XwBlUe9zsEI6EvYVvqyvMD4
 Gwx9EguNuofcyIpqfrqxAIzFrMnGBh6z5+zJ0KK3X2JShh9BwLXu1sw9b+5jUkNG1b7r
 rudw==
X-Gm-Message-State: AOJu0YyjTykex79QnnZnmHllXbg2G+zcMtNbva1rmVF3altEktkUi+wv
 SdgVXHJBF87+jjGLKt7SmfbaviJes56C0rqcWQk27h+wIN2UBaClrUPD38uWPhPdNy64AiVAr/5
 haJ7uGJuzgC/uMmNsiFZwaRnnWT4dIz4ab4PI/V27Adx2vnRyTCpIspZ18lHVE+PPIw==
X-Gm-Gg: Acq92OGKIWLpluxAvanJtdRnkV4gdBuMJnKXP+xD4ITXiKVRLa4syKtxNjEsMj4K7OA
 4hrrCl3GSiQfrklzRWxz/9li0bnbfMhlntbXabpVt2qKxUhZHHkEwO6zNhFIZmJoactYjIB8lHU
 sY7NdmLrzgRGZzX6SN+dowjLkzu4OA2jgjW5G8Vr09Vzu5pDnysTOMRLYtdElueo6n47Z22Uenp
 h52IKhDB1nw2TM9W5DZ4j8ApoMaDN0fXW07y+tRail4WTivbWeH6Ojpr3CQs8Ve5AkTV3+wafKf
 zoGx7yZ4mU14583F/DfPbYnuiQXnzR+D/HGQl+iyQtVb3IwfNOk9lT1qBB7jQhWxgaAXggwGJ9w
 MXYSNnh7eD7sOYNgVU7L/Hd4uIj7MngH6QBjPy8xvGEfU1xD0kH1WxpQEJw5dWXSWO3wfFyzx10
 ahKsDx
X-Received: by 2002:a05:693c:2c0e:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-304fa49b11fmr881173eec.6.1780091898968; 
 Fri, 29 May 2026 14:58:18 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0e:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-304fa49b11fmr881155eec.6.1780091898447; 
 Fri, 29 May 2026 14:58:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 06/28] target/hexagon: Implement get_exe_mode()
Date: Fri, 29 May 2026 14:57:44 -0700
Message-Id: <20260529215806.608770-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a1a0bfb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0maKGDQT-e-q5ATrPXl4zCcU7yitpyBu
X-Proofpoint-ORIG-GUID: 0maKGDQT-e-q5ATrPXl4zCcU7yitpyBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/kZmlkOEFpef
 1PA26wlj3fnyKoxieDQiIsbCObGN6OeVQMzEY2xRSAHzjpLTYjFjxU7QGhPc3eSCT3sW451G3Qh
 EhjfP4aoUpAQJFp+Kw1IEtRpp7l+dTMDuIvgFXxW4ipwW7QYLJkWLHLss4Ous93xx8V22XtWDKt
 2uI4yszManPVxV0dhqwe69eb8WnLGevNtZBzOfm6ZgsD5cjJfrJaUsvd6KYTLLrVtYghoTU4/jq
 aLY1Ayaxrd+iLTe+a2nM/bCv+2YmvIT+Gh5KbdTVgxrifZyZjhpOgUje63/gmq75lPI7UD1ZHym
 yiL6ks1wnrbQs3vGcljjKr6VQt4V2C3ZtZj1dmSYSH0frWW5WE9lE5h1uv5ZB/Lm8wdycfJ3Acn
 bNR08RfQOV9jhiJ4Vx18WnfF8Ba0fcLzbxofvsujPQzlJVltYQZbxxnAgb6TwokAjTzMRrbmYuX
 URmtKzmqt5OT8l+86GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

