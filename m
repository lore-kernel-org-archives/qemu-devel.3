Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A275CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CF-0005BB-KQ; Fri, 29 May 2026 17:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CD-0004yJ-46
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CB-0000TL-CC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIf02g117946
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=i9TknPk+lbt3O3l9
 afJ5zfss6taj5s7Sl5p/jJyyulP++ozkVP8RyCwy78NQtIxoPOpkpYXgqGyDRjmx
 NMJJtBrF2ddKqEPvS6wzHOEKk3cbPahdqyZf//HRiO5hbmIZ/52puQ/CLqZQ8Dpi
 w5drpgCuNvTx6hrZjeHrszxRtL3y0EToCfS1QWF1HyvgszHc3uRR8m7D2f+vNDZA
 y6P+TncgwBygt/0RrkSWvzmcgWRlhNOVWAWiQZHZpv0u3cxlqbbNg6unMpziCvbH
 bePuRVgJJuWV7qCjRjQpbyCvS22vYJ5pDV6xGQ/gAjRPkbOTjNkKeEM1L8hZo6+q
 ZeQ6pw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrqab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ec73b015so966180eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091794; x=1780696594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=ADBHpAiT8ZBgN2gTxbCZPvKCmL4f54oVGgjlt+f0KVCZuvqh+lTK+IK9AR3i+sPMJ8
 ptMRznrmAsKQ2GVPDzJDz1bWIPlEiKdmtesVjajVHuto5S8iicAw2HR8WYVt0W1wGCFl
 5Jmxprc9NdgkkyokFstfqTFNjhhkFAuAAHk6dGCF8cMd8dMINxKcM9Y2cRuTxMX07Osg
 mZnl6Bx7NA78CyxUDFxGuAgn6PDms0LmKDQMRA9PG2XiscORh0qOGg5JPzuTW7v0tXN3
 AiVfwPz3vBfke+lfUv7fq3MnmSgzw3ltHd08+0PXWfUtuBp7PP/EniWE8FU2uW1uLwO2
 vARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091794; x=1780696594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=pPNM3oYiJiaj/xezkeCggv/1m4RU8+haX5oTLcbiGJPpwta/vSSQk0WNJh5d4YlslI
 OdEj4AL3gLQ9wbk03iAt+xeAKamNapvmq6XCyEQ1/cGRWtCW5tSfN4i7vcXA01xhgbUq
 oYN/EOA5mepwMzGE35ajN5840hEH4X7mLRhk0/SOJ5Oca157dfdzmLW+3AtZO0tXtP0E
 3m36LMEoHHODveC03xwmmUeP98w3wK+xNzPVg0NUsPLHaPq+1AY8Z/4S3NFQGEoJYe3r
 NaE1m/jNsjGnOrxkV5LUl4kqm3omczS1s6PwSI+sK27qkn7G8PHP2mGpzfID0IS9IWrj
 G+FA==
X-Gm-Message-State: AOJu0Yz7mi91JnM3/kRQIGFLRTjbo5N9apbWCZjLQrNILN0ZWhWDnwj4
 b9E7RmRRJeuVMpi1fo36L6/tTaKp+nhgk+BOwY3EQXl6J0/BZkiJOfGYZmQr/qYEgsp51yySd10
 jWsuds6ynVQJOu0rWq88aPRGVxBk0VVwB0WSrq56p9DCSFrstNCZ80eyredy89f9rzg==
X-Gm-Gg: Acq92OGTGHAYIJUooI+ZHvkgZuHqtzJlVEetaHit/icDYuZ5u13zcksfgBkrsib47jF
 tOO8OK8me13Q58ow0dpkcxNH3z7Op0sS6ad2xqSrfWbG0MbrJkBRQOYvk1Gr2xeeRtE6VW3nHOB
 Sbg29YmVP+unmBvdeGc59Xilwuh8AH0gT6jDZl+Dns8xvS/h3Cwb9fblRqHUpR0MvaVkJuw2NwW
 RH5zgASb8syuppCTB4yL9fx8ihou7iTQO8HbaN99NvJg7mWsgHMjRfMyAKFG6EtWHqY7kVNGzlk
 e0gRY953n549Uit0CM9j+PE95oOR7WLa9Xw76KgWjTU3JbP2Lhar5guFL/E99OCYKPSvqkkXI5b
 r5ylsTz7NtstVQYFfrx7h4gptulPrrfLotfKO9MPard+UtXmdoaVWCNicA564d3FyXbWNwRffb8
 yhNN+X
X-Received: by 2002:a05:7300:2214:b0:304:c01e:1cfa with SMTP id
 5a478bee46e88-304fa5e857fmr970736eec.16.1780091793680; 
 Fri, 29 May 2026 14:56:33 -0700 (PDT)
X-Received: by 2002:a05:7300:2214:b0:304:c01e:1cfa with SMTP id
 5a478bee46e88-304fa5e857fmr970723eec.16.1780091793167; 
 Fri, 29 May 2026 14:56:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 20/38] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Fri, 29 May 2026 14:55:36 -0700
Message-Id: <20260529215554.606133-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXz5NjqG7UFmgW
 xPuJLbb/LGvCfNsUM79xj7YFCkXG3CmlVS7mLptcDAL7e8JKrvcheb+W3oNwrdyt0EzP8uTrXHE
 PksWb+gmor1og55PD6HyWeV4BJRGhQRuHvLKY22BPIkN4p8PlfgosaC2dU9urZLhne0pEx4OfOH
 CLgJu7PtKEMTX5kwO3aDC8wKrr9b8KGhCPyw9SWUO/8J6HlC2oSsAl/RDR06CoorfziBFMA3WWi
 nhouWg9BVHUdR+Qns3Ig8DXKJzR92sOHKnCHTAyOXs95uF1xEdv3Pra2NnKSuHL1y/kVvCM7gnw
 RBil/iUcHg+iMel1RtrMMeJhQUMAGnWRx9DX8I0O69nb+FrXHQkYs5OZwwaXLqjLOcKehv1t9LT
 Syr4mSrirANM0IiCkL+A6KnfrHoVbHQOL9eQF8qRq/wuZGyQ5yQWTpVoxXmB2LKuQz+RJ8LXgvQ
 H6O2+Tc5VlCgns0kbdg==
X-Proofpoint-GUID: cX4aULBBu2jk4YbDLarf5Y-a5VM4hAMN
X-Proofpoint-ORIG-GUID: cX4aULBBu2jk4YbDLarf5Y-a5VM4hAMN
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0b92 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBkZjhkM2JhNjU4Ni4uYjU1NWUyYjY2
M2IgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

