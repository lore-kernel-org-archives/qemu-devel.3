Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2F8CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7VC-0003aw-7d; Mon, 12 Oct 2026 00:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UW-0001zw-Ly
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UR-0001CT-8d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lDUJ052421
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 da+SLg4BpUhtDVD1Lt5hoYi6JCQHrI8L+CVTHzB6RrA=; b=dqEWl62UaXXBY3Yg
 LSU6hoz842yQsl/xg1OWfzqmZwmb/9ZXm5eLaKvaajBPaDKZ3z8npXhl6nAihVhc
 xb+xVHV06ybnIXaCWVdCx1zvryJ49I9kH+O0yd4C6Kx+oHtXW2PVv3QCK5MVrU70
 28gzv1ik7LLC+TCrg/shcHNFXEfzsa22H39XkcZA403pa+5dzgGqQFioYP1X7tkA
 QyOsd939G8PXIei1ISoEk7RIoRIUzk2UVmJPg0JSNxV3rpWOjNR04lU7wwr5JkaH
 MqnXWs7MmE96bUc1g2KyuYUXW3WesyN8P+ok8Xwc83+76sqk9YOYLa26fMjmiGGc
 HB9lrg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9vg42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2576968eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778687; x=1792383487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=da+SLg4BpUhtDVD1Lt5hoYi6JCQHrI8L+CVTHzB6RrA=;
 b=Rk0TUuwPird8d+UNwSZXjT91ARDrIqNTt6ZK0Gyam+u/w/w8gUM/xgr9V6tqNUjXZN
 VOonascygGo5qcupkHRSp+xr7ryRbBaXk5nOlwheedIBrD1HY09u2GVr7P/ar2ipqOjx
 L4KXKZLwPqB+9dr949i9403KCg1RZAxnd5xMFx8Y4ms4G4fUsJxGGzHSvM6ULTnW/Yo+
 b3BRGUa141pME/y5y/56JmWpm0g+bpMQFcuSPTcDICO7k4Wv61WmhYDJTnWOujWwElUJ
 2sDM+II5MScj5qiTxH+foAPtdZ4jgCoRQJPvPmQfAjzcZcIaW/r5f80iMG5lFixOTk3z
 B2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778687; x=1792383487;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=da+SLg4BpUhtDVD1Lt5hoYi6JCQHrI8L+CVTHzB6RrA=;
 b=zask+kA4GEk7rl0QgCOpZptPpqFb2IJgV3E8Ay2OhO32XPrqBUeCxeHbof0i1lykld
 k6KnSDu49v/rlVLcy/kS1LWIcWEOvxCqtmYV1pETqqDUqloYjxK0LQ8zxiJWkVyzvzVa
 2PYE6vOAmHBDTYQeKRxAoYdWhLb6QuELRKAtfJmi12LhIaKfOf0b3c9c84G7Z++Tfx2d
 ljYu26IyMYZPTShCS8JLzj8U/ogCS/vxiWI+TvJo/HVXODKc7og2nTHyZxhEEIC3PzgB
 H7foPbRZEMxbvek2GlJjdO19OkeHPGiwEfaIeZgyswDvhRfHcyOyCOOxNXHSq2Egwt5T
 AUOg==
X-Gm-Message-State: AFq9FYJo16lhY2S4fbEo4sd2LM9/kYR7GNfmMSPK0oSAoB7UP3RgdgVW
 v02fZ1IwOdd5NvtquhyyGnL+XPD5SahZIWVaZKZuojrSdUh7YiJBIAR3GPHLWSQr4mB791CTUIG
 efkDlM8jjG3xn+r2OS/9apFeUBUXMi6IdYeY7q3XcIi+l0dKkS7Gtmn28QRZSc2AvpQ==
X-Gm-Gg: AYBFou1Jv3dMNY0g5aIQ0deT9kn+TevwYUAEZpNujU41aOIC1SceQV4BWQxBCPFmTqN
 gWd2X/4x40nTmxTtHb2dKDcRqtlaBICRY+Zxz2QcooMniZyNkPHAdt56VWx65e3M+VmiajMSXop
 pmAZkcb1aY2aKO+ZrotKM3QVqQVkF9DsC8aLiNVVsJYXwWGIRCxBHajKSwqjgXlEeI+F4xR8P4Y
 R7LzNEnfNGkbsln1u5+smnL1uay3ZKTA67mk4hZbmnHd8OG5S5UQj3C4GH0FoAR5Ri4eGyxzKRz
 Sou2w2jur1+MaTRJxYhpdxuKGiesK/hLwPadm4oyu63NP0Y8IgZGNM1sjvDY5RjKGq7o7z31T9G
 LjIqJAN9kxdrZ7CjA351GJb/3YaWRVWLomPq3f9ae/gXCjgY=
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id
 5a478bee46e88-3537e03ce72mr11747995eec.11.1791778687233; 
 Sun, 11 Oct 2026 21:18:07 -0700 (PDT)
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id
 5a478bee46e88-3537e03ce72mr11747966eec.11.1791778686654; 
 Sun, 11 Oct 2026 21:18:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:18:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/25] target/hexagon: yield on system-mode pause
Date: Sun, 11 Oct 2026 21:17:21 -0700
Message-Id: <20261012041722.1159355-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acc5f7f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4R_URXl_t4Iho_Um_bIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: srkNdi34rpjjUUQ-es5jdaeWtzA_KOo-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX1BPqOirvfFaq
 Hcu/a0WPoCXRATf8d4CTDuZVt4HJvrKx0YNISYF/ijWZ4cdGMxe5S8ru6B+xU/B3IhlVqbD1pbj
 sNkBRcm1afD0f/+ySMPP0yI2uKzchGD8bxWBEi82IXnBhQlpUIv4LjMJ+UlkfHIkorI77qxLqnE
 GBU4gjetngIATEIUS6JhTXgwI8PCUuxRqoiMQeU585vUeoIpacgCsTexEZ9I5GlGx7dHhManCeU
 c74GTyB/QU3tDaCqSJJ8EqfzWyyd1gVwSss0jjP+T7hh+JXNGBCzNE+WKR3PpImzz34LvlJNXhe
 GxytD4BmcTktXpvt0rmvzfrjcMp++gEjLIWgY4tOKc0sT632+xqdog356oWr9AbytDptNEIQjVg
 MDw1SnzeIS0eIBQK1v2NbsAOx3SlpHBY/wEw5FVAuROT7WZ8N7Rs1mkKShKXHpuk/8bONQwsYVY
 oEMlhpx9dXAkObN9FPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX7qT6Bi3GlN96
 XQQ2T3NqTpKLZSBC4qY+iX/UZEQ2rVPIBmJkfbkbBXWGa88DDh6GRX4cplX3Kpe/DpJhAHCwIUH
 IJrjGcrAoXCeSk+lZxm6/biLFdUpJAY=
X-Proofpoint-ORIG-GUID: srkNdi34rpjjUUQ-es5jdaeWtzA_KOo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

U3lzdGVtLW1vZGUgcGF1c2UgY3VycmVudGx5IGFkdmFuY2VzIHRoZSBQQyBhbmQgY29udGludWVz
IGV4ZWN1dGlvbiBpbnN0ZWFkCm9mIHlpZWxkaW5nIHRoZSB2Q1BVLiBSYWlzZSBFWENQX1lJRUxE
IHdpdGggdGhlIG5leHQgcGFja2V0IFBDIHNvIGV4ZWN1dGlvbgpyZXR1cm5zIHRvIHRoZSBDUFUg
bG9vcCBhbmQgYW5vdGhlciBoYXJkd2FyZSB0aHJlYWQgY2FuIHJ1bi4gS2VlcCB0aGUKbGludXgt
dXNlciBiZWhhdmlvciB1bmNoYW5nZWQuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggYi90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnLmgKaW5kZXggNWY3ZGY2NmFlNjcuLjgwZDhhN2I2YmFjIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCkBAIC0x
MTI1LDExICsxMTI1LDIxIEBACiAjZGVmaW5lIGZHRU5fVENHX1kyX2JyZWFrKFNIT1JUQ09ERSkK
ICNkZWZpbmUgZkdFTl9UQ0dfSjJfdW5wYXVzZShTSE9SVENPREUpCiAKKyNpZmRlZiBDT05GSUdf
VVNFUl9PTkxZCiAjZGVmaW5lIGZHRU5fVENHX0oyX3BhdXNlKFNIT1JUQ09ERSkgXAogICAgIGRv
IHsgXAogICAgICAgICB1aVYgPSB1aVY7IFwKICAgICAgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9n
cHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7IFwKICAgICB9IHdoaWxlICgwKQorI2Vsc2UK
KyNkZWZpbmUgZkdFTl9UQ0dfSjJfcGF1c2UoU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAg
ICAgIHVpViA9IHVpVjsgXAorICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2df
ZW52LCBcCisgICAgICAgICAgICB0Y2dfY29uc3RhbnRfaTMyKEVYQ1BfWUlFTEQpLCBcCisgICAg
ICAgICAgICB0Y2dfY29uc3RhbnRfaTMyKGN0eC0+bmV4dF9QQykpOyBcCisgICAgfSB3aGlsZSAo
MCkKKyNlbmRpZgogCiAvKiByMCA9IGFzcihyMSwgcjIpOnNhdCAqLwogI2RlZmluZSBmR0VOX1RD
R19TMl9hc3Jfcl9yX3NhdChTSE9SVENPREUpIFwKLS0gCjIuMzQuMQoK

