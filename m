Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D570CCDB46D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBq-00022w-5N; Fri, 19 Jun 2026 18:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBo-00022a-MY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBn-0001bz-94
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYE6c4086103
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=iOQ7g2nK+B0Jpna4
 uR+F+cUMiA8dwifxKNf/dABV4Sld8OJF36qiPf3l/1LqiKD5oskwxBTv4oURA71u
 7kKV9wO6KsJnZRzUpPnyCmNrfj5UOyqUn9cCRX3XCyUTxXZEtK+rrcD/M7y4LEEE
 /8O4b6QW5tVy3lxSaKa3ln4kJZHZVbmAxNhBnNUVaHZpGgqrmFh/5u+E4mJQ+6XL
 Hke72nJzBLi8JqsSK2MZPUa3IJ52teaqo2rTvSjegwXv0RP9FCZN57pI1BbaIe69
 zehOC7ECRGUzIaryhPn78dIakGMoBe0/OCHYDuiGCz4BVyz5+kAdemGQR7Ud9cu/
 ISKr6A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrdj2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso445438eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909983; x=1782514783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=X9VALAJUufZmkP4ywBTAerXL3awIDnal27oh1ZdPpuu2LIIPxuZq2zLKBibM5sWGzI
 8HBQPnSwReX1U2JT1ACfXFgT26QTmi1NYQkegMJ4QdhBurIgpxxtngq4vZHohY3NBSAZ
 IdyFNpWko+e/IdMK5C4ca367cJ15ILuXtkoM1q/e52IDHDfynLE7cYrKpqlwn6I4ZJeT
 Nn8oCKS9L2H3tKl87v1QZm20igldu9bBQp87OXvJnMKcIyfOaFeBpVMVc6T70ztLmZVm
 u9FGLF/6Ft/L/kIM3JhXMKJ2/zFClbo8PdA2LXtbvgvrYyjhZhUghfDJPtV67+IFZB2m
 HLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909983; x=1782514783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=pqUmsPo+wWIg8+TKETpfO9/CJFc046BEcG8kXtrM9sexqcfiPruMb7lCGGP+yBHGyi
 KhNEfxGkn43zEUCgTD7hF6ywXZFxA1qEwjBdjqg3iINf8ZjCYigUKP+fxq3uRzCl8OHi
 huCdeij8kdR9IAP7ssduWvxllh7QAIyOQmLgnDO9sf/ekRI8h/mIKH5pJi7zBZHlB/lN
 fQwYHK0G5eethT0RrJtPQvXvaTyiE8jYms5/us4A2mgaHuL6AT2Hn8mG7WNCTBkgUYR6
 GKG5uM2ZZZVfi9XX98dGD5+yP9OpkhuPsYUC7I36ayVLODYxZMRynM3KlTCELyQj8biW
 hBhA==
X-Gm-Message-State: AOJu0YwyN5oh78ZGFwmhQjF7v7pHehUfyNqqzAXJNyke7j0o0w202vNX
 nfx+ZMC+jHx3v+i1dUnL1c4meqqXwz9u9tNpO5UwVRPw3EnOuUVLCDMqMMb39nQm2Y/fvsXu3Wh
 RN18+3PcqS4yXf1QnwHUDugQhACMa70yCxJAeP28WBxb1tnTaiYQxFDg7ZTatYBu8fw==
X-Gm-Gg: AfdE7cm9AEnigl/BpTGEAVIdbOyJ0Q14n5k4dKflDkopyXDAdTrjWfa088XZ9Pgkcn+
 B4o2C+57PuR81ykDVjCetBIQ0NWD9tC28tdRwCnJK1yDHQqMNEtpnrQPBxh+xYp4HRyiHhElI08
 +yLu0FbMjrOA3XfFSn2ngMvqD4FkeIVEKFOYd/6aWZcNeNYSXHiknObO+fVIVvYqi/vEQ/SDmiL
 5EqC9bn3C4kFtLHHn0urVhxi7Oxy+w6xoGLcYDG8QceJThfB3vSE9LWuhv5LuMPN+teId0d8C9C
 i+oIQUagLjkUtnMBV/21iDxJymGConT7/frxCk2ew4xSVmss1wFGf+dcvkEEMv8vxwsWfx/jrHJ
 m5M5OvZ5YcUsLL23BAyKP2XFJc3KtJP7e0/pT6qNx9U7Xz6xJeiHM8bx70wA=
X-Received: by 2002:a05:7301:38a4:b0:307:3a74:749a with SMTP id
 5a478bee46e88-30c079dcc04mr2470594eec.16.1781909983304; 
 Fri, 19 Jun 2026 15:59:43 -0700 (PDT)
X-Received: by 2002:a05:7301:38a4:b0:307:3a74:749a with SMTP id
 5a478bee46e88-30c079dcc04mr2470579eec.16.1781909982766; 
 Fri, 19 Jun 2026 15:59:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/74] target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
Date: Fri, 19 Jun 2026 15:58:16 -0700
Message-Id: <20260619225911.159473-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35c9df cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9K0u5efaHyJ6Vfoh20OaL2QKGlPt7uQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX6yKMmpoOZ2+o
 r36/RnLx43mSNmssLskIFfW5tMcpdRGeiYOOQVenP59KaRuVZKXsqt1m5s952bWYCJo7twDCoZb
 iz/Is9khvU28B0RERBF1dFBjK1GddsG/Keg6A66HUT0xnZiS0E4GXRWYGfgMvRgZoVU5JaW3aBN
 Ku4KEfiZTptsfWnxRmZAbqKYn4O4VFsnbkpUcNT0+UxShcKrK8eFX5BWBJJ5yevdheqj1cF+if0
 CUtWKtfiqwZmToJ/+9oxzvdo7t2uiZkV9eKm45vDwK4ycsAOmHwpEVdLTi4sJ4egGp/3FPzN4Pi
 am7CiJIR0fX2wNEa2BiE7hDR3kmAlaPQgqDj5WU1DifMa+YmDtm4nr8AsJzvj1sggIqit6blNKL
 N0CQnvuhNv6doHbpCm+0zmr1ir0pxIm/xaIlTCMmBxbU+6r/OvlyRBGM0SImy5uTv+Aho4NXqHH
 ubd8WSTABPor/6pI9Vg==
X-Proofpoint-GUID: 9K0u5efaHyJ6Vfoh20OaL2QKGlPt7uQh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX3aAY4CE+H0iL
 nlnoxIyaSlSPwyScDscnAERoczxUBse0RveIEEP2aZURKndSKbzCC/gc15oBdkJHkofmIDUy76Q
 xy0Sox3gAlx4FFOoFS+JxERSILcHP4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
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

