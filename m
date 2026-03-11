Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52ADFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaJ-00020v-22; Tue, 10 Mar 2026 23:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaC-0001kk-4f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa9-0005SZ-BB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKJrCp1863458
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=; b=V1Ne7aaKYjHruUd+
 VZIuOqEwUeCLFvoITA5F9mordS1eTQ3Q0NrTUYsPMQWgHFZoGDNmaTrQjPYoFCkN
 cYBwdNMYR8nunMgs3pjGIwyC0wZ9PCihLmMKQjmEzojxoWf3KYrpWsXIGVF+tQDD
 mrRvXzYuu//sjHn2TbhcZAPJLxAmk+itxAM1/QAq8JCTsCQjF111cnylx4Cv3Zi4
 ETPjLFjQuvj6mujxSOD/QpMP9dq8+VoZQq+1xKi+O4dmMgEsh3vVhy9UvmJIS/VL
 qTSIkoGEgPgszyw4AvQxMy/dtKMnruqcBICgCDolSjNk26IB1fFEVy+Irg6BwWWA
 zPY28w==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82nfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:59 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d742da766aso12917046a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200999; x=1773805799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=;
 b=iLRKfUwME+Kscj+Dh4ZSKvnI8mmYP/WwFE48I3KmbbwavbrLooX1XL+Ockcy/8ub6z
 D74s7fqvPcyJ14qNMbucGAd8tRyXEVWsGzYfIc12/AyBS4WlakG6WMPwJC4Y4GfUH8UD
 RLcmFO22fW2ytdtP2ZDcqYFEwHQgh1HwclM+hWNtld9I20aRIOFn5IePu6yjEeo59U/o
 Lfss1E7KOsg/aCPxxgjLHLTKDixxlZBZuWllBvmjiaYJhQsHEdaB5Lak0YaeEu9rMSyz
 URoZFEz1yfHIgneUXeHUbJsCMr4qMJhumZEDnRcMyDEOYN2fqxo5sW7+XV3F09INh7E9
 e3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200999; x=1773805799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=;
 b=lq/RulInmfKbX6aYs+ROM05MIX2cgFD057w6Da8ey/YXu4r+jaovTe82VlJIus09LE
 d/CezvHZjXJZcjNcbNMGwPgS0cBPokZ6OiChzaVCRtX2GvWVMSamf23DlMjW4PwjWPPk
 Mn4agqbMOQFUYfpFLTxUsCH+013gFbx86KyHMk72EwEhVs1/hvCfg3YcV7G/IUzJjBTl
 RY8EodQiTuo1NQi+kJMMiG1jTOzm+h8rDfYaamT88vlkYl2Yexc7JRLXCAaBSX3Ssqfz
 yR9tcJjWDC8vX0jcZkD3jfVh3cNqaVXzhIiQo0XxN/kToGEAOkl8Slg0C7/lt4qKIf4T
 efMw==
X-Gm-Message-State: AOJu0YzuvAX41r6+kTTahk1CuAxTk+4oZbzx6oGB91buU/pNHeXJFR9c
 Ts+V7PaQQFU16/QdrO0V7t2qjhm8fZFoDuRSWF5fuL9FFHFcAJ6Ios3rInG98tYYiFFZFO8IrS8
 /lPFz0pLINiRHNoSJnHMEUQrz/3K5btx8ZHGXjGYgTdpD+LTXD4LWd5erEyR6r3LZcQ==
X-Gm-Gg: ATEYQzxyGB2eHmPNd4mBLcC+o0d+22zYecT01vJRjrFW3sbpB8OsgfteEt7+1Sbtw4+
 HCctYGvI13bu/JzeY+0U/725wstyeVZmEF2ipSrJiDLxroLzj41Fb+eXc5Em22HaI0ZBNpN7zQz
 7/BCBAy+Pm8OIbKbzKVICb3K3O+r3Gh8T8cZKUwfqQ5vWrEQj++JhIHjj2tm2kmb0LEuuNlMW0M
 HGqECYKHsVj3NQSRUpx2zw+4+t8YWMmP1PSzNIrthmNFsKi1Hrx2DOm1mmzHyEN91mpAcu3d+Fr
 jPic70oAZdMBx7WPzgLZ2wV2mO2odaGlzpgB0RXVQjlRbpqkLxXWUb251NRCblaVvssMFDPH7ot
 gzSt8sAmvn0FoBvMcMN6B3mocc0y0Lk5LA+jwosgeDDryFiwXsCBBMElV2ZPhdbwbMz5dqQ==
X-Received: by 2002:a05:6830:82e2:b0:7d7:5032:cc86 with SMTP id
 46e09a7af769-7d76a7f2402mr843329a34.23.1773200999129; 
 Tue, 10 Mar 2026 20:49:59 -0700 (PDT)
X-Received: by 2002:a05:6830:82e2:b0:7d7:5032:cc86 with SMTP id
 46e09a7af769-7d76a7f2402mr843312a34.23.1773200998793; 
 Tue, 10 Mar 2026 20:49:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 25/35] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Tue, 10 Mar 2026 20:49:13 -0700
Message-Id: <20260311034923.1044737-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 583MpznVN_SohLJDGp3nQUZXsNorFUqD
X-Proofpoint-GUID: 583MpznVN_SohLJDGp3nQUZXsNorFUqD
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0e668 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QUxWXsmna62PihYCv0QA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX6WAx3G19ilQ3
 ngMaRzrffw87ZsWoEY2cmSi77tBhlOd/f+kqscOZ0t5WkFdkpfVYXpi/zc2lDSAH9lbtBe5/FCG
 urrpgV51qL8v/rZO6Bw6isEczoXLu9LYBvJAuIgEiPTXdpIRj4iQ4Kd94XmvNjwF4BidXmcfo+b
 gXZuKdG0WJZU5PuOSCx6A48UrEuJgij82tSeNHGVG38D9omEmS613GR+5wOWSMXzQGURrPfWQew
 tTd4C1jbyG06baqEllKJ7z6hl8wVbVa6JLhPa1Kul6NNOXPaCg0AN8rmzSnSQ9woICLw0wBDmTh
 ks9nT16kOnyV7dVNWkYI61OpktKy9+1xK69SRzgMqcpn/LZE3R3qDjZoWJVMXTK8Pu+AWwv9waP
 omMev8lnbNMO7wS9NssiqJeuKuhjqzFiis1XXqzAO0xR/JrDr1++mA6P/tKGuRHAystWYTRuugu
 WbbOyT8D+KRKBp2YjNA==
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDNiYTFhNDUyM2YxLi45OTg2ZjQ3MTE0ZSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

