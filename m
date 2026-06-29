Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A5BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39V-0001dx-W0; Sun, 28 Jun 2026 23:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39U-0001dC-Dl
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39S-0006HK-QX
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d56C1494931
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=d/0FEAxmMG1TzS5A
 +OmLJ74npS08dKMivvqsMEkf/FtnJ31uLM58uXBGUovoVfiZIXpPG+2zGuGCJRSF
 QGbhzMkUZwFYqE8rW2JyV51GQTlAUF3vAVXGDJxEbHZkr08bh5YX3bg7DB3v4rj7
 YeVJro+qGMleApFF8scYR9ZW63rwYblzMu1uomzF/OMZXo7zsFe4MvcznYOPnyGG
 orsjTRiLHPnO64xwg3ps37LwROxrQrlLisms+lnGwL7y19Ds7VsxPM0hT7BsR3CF
 yZ+i0WVeJ07fShtrLLNKtYPQ/slY+S0I/3a5dDY4lwi48eIfMevJ0bK87tn47UDD
 uXk0Yg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf47ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139af2bd2c8so4831306c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705557; x=1783310357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=PnkQWoLU1Jm9MWC8U+r3FnxQKCx2DOo1LMrSsar1Mjb3+2QdhEjWUvIqsXXpd6dlHu
 A5QPPm/dtPwoZjPXISasxqC+OOHSLwaAEm+EjsFjGhg5u8YfiWDL+O1yKpv77tbQP7kP
 HituSJ5vzYkfK/FjsRlOV1uQOAaXvDDofumz+Foj7fgROqlZahiuHsQ64kzbzdbb/Lpp
 7VlRnKfGADrMR/MllVW2KeXqGmx2DHh8+sYYZexJDgHj4j9Ws26M+JJ0rNn+wSnasTB3
 JetYfD8y0qGmudkeGespz+Eluyaiddm6wriAY5Cfh2dUcVADEBa7X9tVrcCi7k/vCRuu
 ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705557; x=1783310357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=nDmptYZeR99z/nayc6RbIUb/JDjHU4XDiXRlmMVdE3fj72QMqvOXMcECRgYJD9o7n8
 XOGqsloJGqXqMdreX+dff1WAztEIABU5qHUTtBXAxA025v4L2XswjWCO8BA41HemBMs1
 N8tQu+3pIH0MXukClVz4dEAxm3MwhewjdKx2dGoH/pnOzlDj4bkZMXsoQ55dFX539PFA
 MDPn5OcPNV1ywh6z4ueupzLY/SOQ8hD/8UIhh1VLATw8XNXxiJmb/6vPSn0HPwbf0WsL
 Zj73hWOdY1BOWClW//69dW7g0rFlD7jdDNI5IgEjaMyiYafMmadV2V5HhVa8tA7TUgzB
 /4TA==
X-Gm-Message-State: AOJu0YyzPfJEZSWRl/dwzRRm1NdF/+GAW6JRTtS9bVIluw1aygs9LyVr
 3mbL6QuX1bzl9KumJFPyUyDghPfBHAdlS3xaY01NBVwSF3kmNQbDt3syG8Ghr6U9zPVZuQKxSWe
 LV6H3LELdf/jUMFRBvtmeNhcaoA50juulG9jZ2JK0VJ8z3rerlTUZqSoHhph0swpDFA==
X-Gm-Gg: AfdE7ckce1oXD4SzO9JK9Jssop5Q2Tb5mrGN1x6EYLS8agkSzA7wgvk/5Y/GoBkN70H
 HlDgHMB5JMut2RC7619I2ejfyOAr62/uzUaGQ2+NFxyqrb/cDjRAqgXKySeyEkErim7DHQtjtkF
 OaQXHKd164pm42+kRMfsj0Qv26fTVA+DrCs8taWvu0AgV2GZrnimU0GSDVggP+GQkpm2FX9YgD2
 1X7BYPMFSJQe7TDeZ1lQBZqDmeSzHmpd6nH59FfOFLsVfrTDDNiFaT0I9SijZnplhz+rDX9m19r
 UgvORBVmmRtiy4nd99fmYnTJZKvJFEGohkvia9/S7lwL6+E5BfMnl2PHc3R3toCJJRPHsfQ7aar
 Xdq69Nk0ihC9h/R+5jnCxhW7hd0VDaHc/CGHgMa1FZlDhCxbqTuq2qgj5MGQ=
X-Received: by 2002:a05:7022:ff45:b0:138:48d0:b3c7 with SMTP id
 a92af1059eb24-139dbb13e28mr12368460c88.28.1782705556697; 
 Sun, 28 Jun 2026 20:59:16 -0700 (PDT)
X-Received: by 2002:a05:7022:ff45:b0:138:48d0:b3c7 with SMTP id
 a92af1059eb24-139dbb13e28mr12368446c88.28.1782705556204; 
 Sun, 28 Jun 2026 20:59:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 23/77] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Sun, 28 Jun 2026 20:57:36 -0700
Message-Id: <20260629035830.1520296-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX/nR4IFB6sxNE
 OyMHofCL2NhFQsU2GeK13ifV/cjCX3EAPvFf1YW5puYXOPpvD8fmCAuLk3MawVCXt+ujcxUFwEo
 yMDzxIkAycel0++JNx4Op037xdFH7xI=
X-Proofpoint-GUID: zzx_tPGndWULo9HGR7AblhRuLnuHV6ex
X-Proofpoint-ORIG-GUID: zzx_tPGndWULo9HGR7AblhRuLnuHV6ex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4nBsFdduR+Hd
 Q9qZIG3p1cSSIWDhM4rhnSr5tDeK5bwYuTV/TYdAvWsZ7vgBKkqC5TqTmq+g+XXN9gcPN4wPTfm
 GzZ+OupK9c2M3rjLdRvLQuux3f5w1BR6KJKUVX6zjByyk9z90DQ6iwbvgaQzH8e+fJUdqdWdBdD
 CM8S6xcmh21jCMDfninYIN5MtpHD1uSJQvqfSJcOwUwozYx6e9RBsz3By7CPvVZ6a4JzLwl/Mvx
 RYfubNRvRDLGjtH4Zep/Y1QUHa+hcT02B9MxEfhKlzNpnsInCKn+qQepMrHXzRakn7aTzerjfWn
 hA6mdZBeqzWghJcPzlj2KIOQIopmmGz6mX4dQnfx6G0IkIpjZct7FJrrjE+P4K5QEXfh92UO50e
 riaMcrEvSpE9YQHWpw9x10HUFUFv/3Y71xdmjefPJhKvSUN60pk27HpLJ98hzlujejmloZzQzsd
 EhXaqiN2UuWYSgC6N4w==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41ed95 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

