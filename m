Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3115310F6FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUV-0000pz-6w; Wed, 01 Apr 2026 11:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUS-0000pp-RY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUR-00085l-D6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631Ck55Y1285828
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=; b=ORL1+TDKtJMS/6Tk
 b1DkXYsm8psWViT/ZjOJjZvd+XFcqh9zivFqh6Y5fZ77D6gPk2nB7spiKztWpCwF
 ccTaY3QbPIFLDKDvjcz+jsAC2BZGqF9YOlmRzj61WnapnXCL9FYh6hIxoFl75n9a
 zID2EG8/yQXxizFcREqkhW4aI+xPaxMAyxV9q9jxfUR6/mWKc1P1YumeVPRwbtkX
 LsXHgDkcWc8Es3wjfq+CdoJscC2CAzXOaKLIKa9i27y+iz2KTUeMLPFNKNMwbaH1
 xpVQGexEyxPTjyrpnqLaz90+fU+Twe0JpZyH+uAb+H5mSUtkrRi2GgRyIQuQjqAE
 BJBeYA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c68a134df8so3031496eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057289; x=1775662089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=;
 b=W2Ek1aI2qzzqMqC1MYhWVtyZUiqcjqn/+JosGmNQ8dQuEFD2iae26IOSr/ZYu04nRj
 TpTObXN6QYGdB1ZTPn8gHAoEwuRs9XmXgYhr/UPIGblopgvkz4WNhiFECejf2l2SZx4D
 kk4xE52LjWb2fqWtG0QCkSQ5T9jsQnZ/5ZozO+v+k7TYfw//RjsbYMs7df1ebXLmMJT8
 Fi92jm9wN0fg9CJFnIfsB2Ue3Z8tVxhq/sWCWCo+9sfbwVSMnZhDFCipGe/9rCAzQGa8
 IpzbPNrIYgV64Zne0LdX/8Ql0vnUJ/aXyZ2CJhTBD7DsE50GBQSDjWID3WDc7EOQx/kx
 8ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057289; x=1775662089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLyeJVWTlb4gtNJk7DgkzpygCPEbRzc6XmSLYTn5geY=;
 b=WwgF+qJzP2N5xhsVdR/J3v/8B1tYoPDCbW6dHvy+cQ3/SegMiCd7TaTMBEwHPWaCk9
 mxxZ0C49V9snQ/z0j34WRETC+9nCs1MZWALyH1mX+DSiiDyvIzf36XAjwF1TUB/WupWX
 Vs23a7mD5uBX0gaMczdnVcsMjosNxlMsyxy4BW5gGH4f+g4Lc4SHiBxatN1twUb67Yvt
 wKPD0O0BsvzaT/VjjuvYzTJLkXzNyNSPMCoDPiaopORJrduZSlouyijpInbmNocudU4Y
 1uC0GivUebpllunWRDMtFik3du0S49Fd5ouPRnpLvbhz8u75/wzGzoY0Mp9TmVsizaTT
 jBjw==
X-Gm-Message-State: AOJu0YxvpWkLQ3oz1yQueezQusC/N86DBMolaFCQfnPQP43PQGN8R8UY
 4mgpSHTx2Uk2c0DriL7QAACPUF0MSunfWAPJDA2QfFEadbsS+IDNTwlB0tK+cf0BW6nH0X4Mc5y
 kXYB3jxIUFKREOV8dbqlQVUXG7OUJu4pd3QO7XMkGq/66W5+ISvAJgDPLp/Bx7ZOL1Q==
X-Gm-Gg: ATEYQzxRnunbjiVhN3clD0Y7gES7A9yr78hK7MV88e5euHPu7ZXTm7Rblsn5rkN7ysH
 8XduNW4ylcJFM/rpw200/sJIs25kwYUOJumKIwhBvPYCWrxqQyeesVpR479UPTs/I/3HKqTQoBY
 eJMYMA+97NNFoiCzWlejmABXRDhUHybvLkht/jj7R+DnpJa4MddBt7nPb7Drg3rs6WOrFR/Oo+3
 NlEImvb3UtzG6sUaQWj+6CrFvY0nZdvLZv8Wnv6dFI9c/3TR3wO52DACtwXC1TUEbz6Of//nAkG
 +OGJ8Z/PubOTAXRIrwwF2snCX5rA007z8b3uGuKInlpHajrELQ11g8op+GntuzEHsrxOkzDLhb/
 hF9k2NPesTIhJ+hSbLTQjqGHlTvXufhXy5skOf6/ARCntupKPvuc53XRuPhPNY9gaV3UJkw==
X-Received: by 2002:a05:7300:5b83:b0:2b7:fdb6:ccf6 with SMTP id
 5a478bee46e88-2c9313847eemr1962568eec.14.1775057289011; 
 Wed, 01 Apr 2026 08:28:09 -0700 (PDT)
X-Received: by 2002:a05:7300:5b83:b0:2b7:fdb6:ccf6 with SMTP id
 5a478bee46e88-2c9313847eemr1962539eec.14.1775057288483; 
 Wed, 01 Apr 2026 08:28:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 25/37] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Wed,  1 Apr 2026 08:26:45 -0700
Message-Id: <20260401152657.314902-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd398f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QUxWXsmna62PihYCv0QA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B63MO8l64JYWV_OmuLEztBY1p4k_VTLm
X-Proofpoint-GUID: B63MO8l64JYWV_OmuLEztBY1p4k_VTLm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfXw4kjvbcdEUjx
 TVtVxS5QH6c778AZbIGPmCnMsS0hoZSgqgVypm+Cf6IjGeCoSW08mcfuTxfV+DUeddB1+QP9LEL
 59FLxQvrxVzYaaDgXtR60s9n6J0siOEw4DXUaCL1QRVPN7vtVBIkk96xkiEd1B7Y2SS8ZOzqFRO
 duslJ05dzUnuR2zcl2OvCTWXUTUjWRNMrrFnGyFegk9Hei7OtnqlZMLq4n4YywleTVbQWhjwdyJ
 MxcPVrUHmt1I/lwNNdurlxfgJKRnjY6QZU6r87nLXhLwClgfHQbAHJzErMhVODagdVeBEpPzrkn
 BOm36JXLpZZies92B5SGNUFVQdsn8SjCDlfbuTiJeOsE9oCP3TvZG8a+w6LsLp575iFtniUoSmZ
 wVnz9bF93hqkVaaTVKranAdYo6/ikIlWEWsG97T6FdEuuR70Vyv1cxrShYDO2KPqyG6DB1XOBnO
 Bo3h6/04LyspstTjeiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

