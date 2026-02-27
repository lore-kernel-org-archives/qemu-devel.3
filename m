Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E4E1039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aW-0007pH-F3; Fri, 27 Feb 2026 15:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aJ-0007N5-HM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aH-0006rT-V4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:15 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIeop3373465
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sqRRg1wDPGhWBNP8ztWtT0khSUeHahQhAnQ3t76w0zA=; b=f2n66LcEc5KYtKtD
 fdX4cqk6YjaJUpgMBjOyM5xSTXVk3SO74/QBrJethHj6YUCAOV3hS92ZXfyBV7Dq
 WugU1IF7+ifsXsAqMMaTftxE5LsQaTmb4jbm/LyLkiyo2Mm7rJ7ymSPmWmUYBMg9
 WZ6t6lgFbI6HaZNUGFMhdC6N8bUqUhQog0yTGdDPrwE8ioWDCBkv3JlURvinQXea
 TKSwptEi8WtG0SfsND/dtbSxN4C6m6MITlQ3F76FUeSvEZ84PLsZHe9bEY3bR8FD
 Tw7Vw2KY5lFhQ/9twAoH1d7JEjkrrACPl+a4g+4gDwutNwO6/MK479/x8Cms+Ve6
 M/1LtA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtrauv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:02 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463905cb295so14493874b6e.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224621; x=1772829421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqRRg1wDPGhWBNP8ztWtT0khSUeHahQhAnQ3t76w0zA=;
 b=NnVBWEmYKgw8oXYWVPXEuDrwCLWxCZ24ikMn0f/oJsuirhE/CrwqKYx1Z9Ep6C/OaR
 fZWdcCoOjCYDHlMlKa7PSZuRfA+G9h5UDx29E+oepxTtynoqMoOUOKMOHA6g8SL8kbFH
 8tfJ3Y6pWZBcl8y84g8xX7+EbaoTsQwe/nl6G+6WTkE7+P1+xjmqql8dNva426BeUCgH
 N7YpA4nR6uDalMi4rGEfTucAinqx7+WnKPfMRWB8/NL8GZkw/EllWkioXY0m3RhMCVYB
 M+pLU6kclZs/Zx4rYedysMjNmqDZrU2LgM1zggVSR58J44W+mvJ4WRQCLfKhBDJCH1i3
 Z23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224621; x=1772829421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sqRRg1wDPGhWBNP8ztWtT0khSUeHahQhAnQ3t76w0zA=;
 b=uTIAakHEKIKXQ4W0DIUUdODdn2bLuq5dsGzqgSmkJvnobD7azm58RVq5Yg2aUZYJhI
 SwrRA5nygUtAyxjZ6FjG94+Uo4pfnFXJLWZKjJB+bi+i0/Sr8mVgm+Zo7vXKy60loaJV
 PAVRacv2dYyP7w9Yy8j1JCDH7YrilkD/piEUWaj83iofDd6IUlCbsyPwV9n1yLME0ovl
 ZScgMTPnsP6y/eFhnTElM83y3Q7H1ulblAqxLOcxUqZFOQMJMcwTOVrROnq5+DqNg6py
 uNT/GFdtXR9B/JvNyb9u441u/fbzRTmaAOxbosMjbquoCLS2AAjVCXW/Bu6rfZti5u5v
 QiBQ==
X-Gm-Message-State: AOJu0Yy1dlV4iOwt4gtzRnuy+f8O0Hz1KCk8cV9jgk46JN5Gg2OdXAlg
 urxEN1gfroNVRuAxDyZ620gfuobpg1VHi11EbDTxAr8qSj6VCyssOBbUvid4CmFPF7GR9to+/1Q
 QHNGPAiUt19BjT62wRr6aLGS7k/wKg7UcydS0B++ScrNwy/c2ZxTdhkjjGME3pUeeXQ==
X-Gm-Gg: ATEYQzxa/ij1Gs6xUtwxMDeCrrfbRYOxqUJ2aNyLSeVxbldRAF+z69a7F8HGcs5ViYL
 deICKkSSPgAzj/4RqV7ZGeib0uAEWo+Y8sGCAwzH9Six3aizdNxs/yPttB6/Vg8ZUC0Br5DRf68
 r09W8IMHG3wOFHH3YMJj4jOJPAO+AitqxcLwcFSobvW6iNCS0z1nz3uL6kuF5qOxdP1LrEsZ9AD
 wmhW2nbWj4pCVPtEMnmWFzqxBJ9KLrdFdT/ZjleXqrJQPSjz0RcjrNzxBVPF7fZQo5hJRK5iM4t
 1yrCIRQNtp/sdK8Jtx/Uk+oi0Y9I4D/nXJGvi4XA3TrxkxKl4Vf8RKtZgP9cLui7z+2nzuoOVKe
 7Tw5B7i8Wmobe1+WapjczqvcG5y0VipST+IW/SWmWMlVzqyBuklRvytsjrFwj4qlWOBul/A==
X-Received: by 2002:a05:6808:c1f7:b0:464:82b8:efff with SMTP id
 5614622812f47-464beb5e545mr2400819b6e.29.1772224621121; 
 Fri, 27 Feb 2026 12:37:01 -0800 (PST)
X-Received: by 2002:a05:6808:c1f7:b0:464:82b8:efff with SMTP id
 5614622812f47-464beb5e545mr2400800b6e.29.1772224620770; 
 Fri, 27 Feb 2026 12:37:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:00 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 21/37] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Fri, 27 Feb 2026 12:36:11 -0800
Message-Id: <20260227203627.932864-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a2006e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6bn1J2MCOTMSxonSgdkA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pBiVFFUPFzlTkLmx3oyEsyWHlciAkCT8
X-Proofpoint-ORIG-GUID: pBiVFFUPFzlTkLmx3oyEsyWHlciAkCT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX70if8BcTz7Lp
 F+CNn2GGTVQ8D/E85UDOvLDmOermXgew7c972O6/mJ5PLrd6XL2Wd/3t+O+xYrv4Jr6/bpc1V9I
 1yBfuqar0b6DjabSlZKcjprCY14qa1aUwMIn+Epgb5tdI8QxJKDBPTRr1jhcCmcCdSI3iGc/r45
 UhKQGTKYmkgn1OCiEukEIbgxb3xXlyPWYZjlY+qbG/Dz8vt87XQXnrDt42CaU214mfIdG1Qzhto
 qgQ0Y9m+VyeIjQQYHYzEG8Kn2YKKYkOX6g8+4H0ISDLs90bn7guLo9zN+9fzOgw8sgsKOWBwq46
 4gEu/MinPmIBPUh439znrthHGQMok7e7AOf4+emYBHhzlkBxhM6BGt3o7tBg9CQp76GclYlx3Z7
 E4xYGb1XZfhGLtjWt/KMy58sfYH0iH1U1pp6kH0F7m6DZ6xQwNco60884b7L4+ykElM4xQxXCSd
 Ah0RiSVlRVniLj5vhPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBiNWFiMmVmYTVhNS4uZWM1MDQzODlm
YWYgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUxLDcgKzI1MSw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

