Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772CCC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAert-000529-KO; Sat, 26 Sep 2026 22:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerr-00051k-NT
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerp-0007UX-NF
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH02jO3731552
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Q6J/IEW808ycEbYPQQr2dR
 SCVxU25RGPRK8Eh+81rbw=; b=eZwR3Nm41mPOcaITFRTM5hg8tM4wF5o6s2yU2P
 37ydV9Qibr8i+5TanAjguQycbyoxf3nwKxy0h0kk+3rJXI7jI8Wntqim/4A0YLhe
 AG0REVuXcWAJRKIkxAAySajeGPQIq4P0Ksl1nyEaHKPtcy2cc3F/Sl42JRMAp28t
 MDyA+0j6t7+xrMRclcqOcOPXrPSBH8Q2hmd2v3eCJWQYoFEVZTxm/POocT+GUXlV
 O7u5hblQvJCHZuM/POUiOye9x/SnbUzX54p4uSJjafdImO3zgwDAUdDn20bMym9y
 QBmaagVCHbkkT0TJiVqE8VXMqtiS/jXfcy6P7iTEpOdfFCew==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6e8237f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438fef603cso3269316c88.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477030; x=1791081830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q6J/IEW808ycEbYPQQr2dRSCVxU25RGPRK8Eh+81rbw=;
 b=MUrQrRTxE1VqiF+M7ptCvnGmide11zF3EQWgkKKtCn3BbS9ZvGZRLJxIc7eh9qZZvv
 n7hmwmMWV8jwGdxhEcQeLzXAL3qjdrUodZq5/O1Kv6+vDY+6klLE/hueK8BYIh690MPJ
 IsnZ5BNcoNzf3Nvi3gfM0DUrqnyeFIyY7xfDixMCf1wB1R/y7KlZyBoChYLcfV2GkJgt
 bPdY37hn1lG7RogmN5T9Qx3dCLs74XrVLNAPDtUeSiMVsuNcwv6XTSV6zV4MC23PHqex
 aZ74hyBbh7GdQlr/Y3nBaKHRRHgud+7GxFQrQQlN8iEsai9PbLdwARWsZUQeQKDd66Hs
 iDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477030; x=1791081830;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q6J/IEW808ycEbYPQQr2dRSCVxU25RGPRK8Eh+81rbw=;
 b=Tqw9vReuL0yhYmQYPcNich6A7P8XrtgNfiPUKsDd0MeuAEquQVTMbwrJn8oMB95fjF
 jOlnrOv54SQ66YDCAcqkPMvSjq3VTznuHbsi+e621p4CZN9wD3hPg39pf6Grygl/cLd9
 QeOiIm2N6DhZ/Ci7zdQWvB6kB4cTvPEP+pJp4oFZYrCI/awoKfCA4OsbC/LKTFW+U0g0
 twdfxGMLeqcwdG9DKgNhPpgC5ndrL7y+g5EFO0ZA6HmAZwyKiA831uLdgjp1h7jn5J1q
 em6TqEeosl3I7NRI7fxOg2iSi0lo1y7k5YhOvy7xAkmwPLl4TpwLg1sJDw8sCrpj9Db/
 dlhQ==
X-Gm-Message-State: AFuF++nPKOfi2KWYmieSt1F2UC3mhBtuSUArBYpC4zhJIjK5q+Ms4ATc
 FBB6lU6Xn9ZsobdWyySR+yVGH3uf1kgFio9uc6LJx2HZtURL2RgT01SR5jlJW2ZACy8Z4r2Og8R
 2+SabthA7ApUiMzekb/sUhY8wSJoM73xp4UXEiBpjuNmwVcCwWoFtXueLxss6AnuzKQ==
X-Gm-Gg: AYBFou23leAN2P/Iwl6CHQknyHdsJLVCeEz1WL0k9UeUqP/OjyCZwxVYQV7uaK3Qhlc
 spg9uK9y0YMtRluyiO74Ak1tMhlLPnQQufl9z2jpo+FAC3yosxBqc4qBZSP+Yt68hhK1KN16B1P
 stHv9M4Wb04cFYPp5D+zZkU9M1g0HCa9/Sa296zpmB6IvVkwoiUw3p9kLHG2msggDn6ARQiFDQN
 js8IhGjZ2rGGNjKtAQ9gQO60p37FN0unomucWJU5g88jO3r/EtXCStFv2b3STU4rLXE9HVGOQIF
 c13Krfv5LMB/pGkEmPtt9Wgb2YY4piOyZ+bqIVYA/9eU+h7h1JzzX+1zm/ClOiOGvgoO1MMlQXi
 v9OPJcg24DNoNqeF9D4cZhkeUYSpuu4Snio+DtQKBg2BYXl8=
X-Received: by 2002:a05:7022:28a:b0:144:c12b:dfc7 with SMTP id
 a92af1059eb24-146d077b855mr5480264c88.45.1790477030310; 
 Sat, 26 Sep 2026 19:43:50 -0700 (PDT)
X-Received: by 2002:a05:7022:28a:b0:144:c12b:dfc7 with SMTP id
 a92af1059eb24-146d077b855mr5480198c88.45.1790477028821; 
 Sat, 26 Sep 2026 19:43:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/5] Hexagon: ll/sc fixes, emit TCG barriers, TLB locks
Date: Sat, 26 Sep 2026 19:43:42 -0700
Message-Id: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: u-KUHNzadc3sPshU5NBCilCesHYSD22v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX15hrLx0mW6N7
 HVP0UT9DmBAoeEz+y50tn4GZ5b6YdLkgDMJ8vIBwsUKzuARhyXBtA/pM5mQaQanSn79UOgVe/U3
 DpPQQtPc7Pbe7r76OuvjGntfKj9Jb9tjfqO99EfB2xgr355IkDCGuW+58T5wWxCrZQyfbm8JVgo
 uX5zFqC1uxrQDGTZSRgKsOgQ33ED0TS4vbpQpK9laAvLsBLWZ+YiXyAL7WOaga1l1zzhhLXLHi4
 qr2hn9FZhiIp3CLK1/4wcewhyY8f/qCxvNjHrMP7/RTFTmofq350KDE+8lQqh1wS0yfjZoZj0aH
 Kh9AfDrQpj5HDH8geAdWZPXG8pZqAukYDIunUHePF1XMMl6uFp62YD7pXZWmEnxM0TITmd2n6sF
 C3Tv46aPCLuXV3MxZPfO4eI5fmxMGHQ3Ls+Vl5+X2clFg2/Pw3E6r86Qu+rLctQa0h3NvSMD1PL
 fnUoNO+heYxGg8Pck8Q==
X-Proofpoint-ORIG-GUID: u-KUHNzadc3sPshU5NBCilCesHYSD22v
X-Authority-Analysis: v=2.4 cv=aIFlOr9m c=1 sm=1 tr=0 ts=6ab882e7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=DSe_qOq98nsoM2aKMAoA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX06JUphb2rYwu
 aammQwZkwVzDTpQbuHengVZmqqK30EJvYKNO/x4D+Rsb/mrC8cnwRBlEDSbtQKfL5Ie006HrW61
 5Lo60SGxi7ovoxK0NSGHPGmhTiwzGAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
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

V2hpbGUgcHJlcGFyaW5nIHRvIGVuYWJsZSBNVFRDRywgYXVkaXRzIGFuZCB0ZXN0aW5nIHJldmVh
bGVkIGdhcHMgYW5kCmJ1Z3MgaW4gb3VyIGltcGxlbWVudGF0aW9uLgoKTEwvU0MgcmVzZXJ2YXRp
b25zIHNob3VsZCBoYXZlIGJlZW4gY2xlYXJlZCBhdCB0cmFwcy9leGNlcHRpb25zLgoKVExCIGFj
Y2Vzc2VzIHNob3VsZCBob2xkIGEgbG9jayB0byBtYWtlIHRoZSBvcGVyYXRpb25zIGF0b21pYy4K
CkhleGFnb24gaW5zdHJ1Y3Rpb25zIHdpdGggYmFycmllciBvciBhY3F1aXJlL3JlbGVhc2Ugc2Vt
YW50aWNzIHNob3VsZCBlbWl0CmNvcnJlc3BvbmRpbmcgVENHIHNlbWFudGljcy4KCkJyaWFuIENh
aW4gKDUpOgogIHRhcmdldC9oZXhhZ29uOiBlbWl0IGV4cGxpY2l0IFRDRyBtZW1vcnkgYmFycmll
cnMKICB0YXJnZXQvaGV4YWdvbjogY2xlYXIgTEwvU0MgcmVzZXJ2YXRpb25zIGF0IGNvbnRleHQg
Ym91bmRhcmllcwogIGh3L2hleGFnb246IHByb3RlY3QgdGhlIHNoYXJlZCBhcmNoaXRlY3R1cmFs
IFRMQgogIHRhcmdldC9oZXhhZ29uOiBwdWJsaXNoIFRMQiB1cGRhdGVzIGJlZm9yZSBmbHVzaGlu
ZwogIHRlc3RzL3RjZy9oZXhhZ29uOiBjb3ZlciBMTC9TQyByZXNlcnZhdGlvbiBjbGVhcmluZwoK
IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIHwgIDUgKysrLQogaHcvaGV4YWdvbi9o
ZXhhZ29uX3RsYi5jICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKy0KIGxpbnV4LXVz
ZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMg
ICAgICAgICAgICAgfCAgMyArKysKIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICAgICAgIHwg
IDYgKystLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgIHwgMTUgKysrKysrKysr
KysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNzLmMgICAgICB8IDQwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiA3IGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

