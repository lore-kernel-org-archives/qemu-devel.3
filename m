Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E246CC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LJM-0006F6-L2; Sun, 06 Sep 2026 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJI-0006EY-Vi
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJH-0003Zh-3Q
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686L9QZu883859
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=T7ecvQJt+zebboBbqybOIH
 queZmC4hDtfPDV1UferR8=; b=N7+yU0AwdjcftQ2WvKdidOrlPneyq4+prOSsv4
 llXJTVRMbfAmiNzx3H1lcAg8c1thae9noRk4SKzJ05ZtnNVsnlhWjZpsE2xDykVO
 vKYrekJXNfocZCWkSHh1i2XxcAIC7+LUpq0BhSEkrEHkt4sWb2b79Y0tltZGpzXV
 VahMBVqabF7sNY7PE5dw0Q1BF0tqwGLLE+Syd7fSVTN+fHwmf77MqxckVMTnNEqI
 CrYmWxMrjqG7GHxUROoX+IZOnUdB2tug7LvREz593IIjUM/ImKAjiV0JdcsGhFcy
 OLwMTp9AW/wFstOgX+Z6FYPS3Afj3SfKZKPPzayE7L87qB9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8jc59b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:25:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db3734d06dso22685015ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733554; x=1789338354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T7ecvQJt+zebboBbqybOIHqueZmC4hDtfPDV1UferR8=;
 b=dVCLBU7wbl2X6F7jdYidHHwSQGj8Bt0NK+Sw62Qlp9NDqnwiHP8nUVIh+CvgRn0TtO
 EbLtx3zn/NdHHemmQ50nXINXVWwxGhQTOTDxPgiRux5k0LlnhzBR2qn2wZx+WD+RkSct
 ldFfn4B3VszEcDDsq9GF/TUtgMP1Yv7RKKWc1PfOSaBA2eXIM9u61SSU2pL1jD5aSUJ9
 GOe5NR+xBK4xzIHm3OAXlwD7kpdsbY3RPTAnSATijd+PX6uc8Vv4ZnfE9VPUaJ5Bxxvo
 Yan77VFuVHDkZ1b0otcexv3k7CmHW8VxyQa0neGO5LtYH+W/ZpTt1fuhgQbPFp3AHzK+
 mQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733554; x=1789338354;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T7ecvQJt+zebboBbqybOIHqueZmC4hDtfPDV1UferR8=;
 b=fbw+b9ydCJtCKG5RNmsybHZgVaS5pMyOAjO/2FNXFbMoDVZA7gxmAYvHOOnxkuottt
 5w2P7A9Gjv2p7JwNUrQMa6uCW6lZW7QfXcb3rBiN7N1nXAT2AmR5bbYV/wGdexLNoO2L
 mS+JJD6TWPqzrlHxtJEg7YkX10DIB5kZJggN1H6sI4JuvRiOHhJhda2Ai31VTyP9MKmg
 KoMBlgCCcPs0yYyKlTgNLjAltbLM90AnDMa1eh1PJ2kc59XrFChup+e+swsuw+B0cJb2
 wP4B3aZ5Xc4SMhqW5yLmi0fcMH0wvK5hWWkfbPI2H9cC7+Bkbr2n9VWxwI5MCAsHt5ky
 G+GA==
X-Gm-Message-State: AFuF++nOAOA6KXeIllFHLS3oeqOeaP3ono6QRmUckwAx5Hoia9120A+W
 nYBliV3uAlo7dwj2feu9Xp0f/YOt+Jwb775hiS5FG1GU1NvUq0POIR+RKzj1J8nSisrDa9zSun5
 ik6G4XSE41qr95y48gZyxhBMUt4GJ0g+1DU1RKjCdfh8vTmVWKILk6nFj2jraD+Ul5A==
X-Gm-Gg: AYBFou3INutJnx3gY04lKzJB02OmKDLLxWdbkoPB8NxNDv97rRyAO+bv9l851tA/SgL
 HxGKc3+hRNxIhKylJomImg5qsG7KwZ48sPDPPo7DBE1Roec1BUpsyGi7AQ08H9jqG9HcJ9GoGXF
 csKlaHU5UIPIy6e8gbNFzCWcYYJBd0d8Maow7gl2/76qLT0vQS1fKae02k6yYXUgjGOMGzRq/Jp
 Z8tHIdJXuxl16E42Sv5iGLqcSv6N49ao8wsGtnm5Xke0dyoY1e0ObO0PHhJkDqgWXraA2bu7RSp
 kWrUmuJRmsWhMSFpYh43QDRAN98IDtPmtJACbegWi44QiqBTF1hpwpxQn5Msls7DMxYZe9Y5v6d
 xuB6vyovthZBGZ4CNl0EEew5ze1ICY4dfvFLOsYy2BzXWRSGo
X-Received: by 2002:a17:902:bb84:b0:2d8:d4d0:7932 with SMTP id
 d9443c01a7336-2db128dbeabmr169835685ad.22.1788733554042; 
 Sun, 06 Sep 2026 15:25:54 -0700 (PDT)
X-Received: by 2002:a17:902:bb84:b0:2d8:d4d0:7932 with SMTP id
 d9443c01a7336-2db128dbeabmr169835495ad.22.1788733553585; 
 Sun, 06 Sep 2026 15:25:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm34936605eec.15.2026.09.06.15.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 15:25:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/3] hexagon semihosting: Address coverity finding
Date: Sun,  6 Sep 2026 15:25:48 -0700
Message-Id: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ktCjxewEZ2nAJ2_ZP3i6hJb0FrCZP4lG
X-Proofpoint-ORIG-GUID: ktCjxewEZ2nAJ2_ZP3i6hJb0FrCZP4lG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfXw61OopblovZI
 qs7DXkSuByGfQ3pllHbc2SxksZNJjjBB+lTZa7cKtliIIy6WS3dlm7NC3SdYI0kYEzc6x34zgyz
 o4H+E06U9VgXtR5O+w7A8ew2WXvYA4op9MndfidBuFvrVN6/WCwezdv7gSCrl6AklFguKB+lbFq
 5nNEiRfxOIlN7j1vDkowiqzgB5BCkioRBZFfGlAfwWR3NqWmQ4ZmFdHjbmaQakERq0ikSXbBgVK
 xE1QNt+k5hwR44gWuPWKZdf+ZDivsZu19cDpQz2ZL74UQRXDyECmeBbqXes3DMj3yh6xzo9wP4B
 THxLi1VoYbI+2ki2ofFFcEpHDoPqg2vrQg4w0rejJSB1xB9jDkPubij1b1gMJw5CPX/V0RqRA7x
 bV8S9vTmYzu7O9mIBter2jkZAr05MDsU555zc7vCx/GFrTpf2IVvdyQy2SkMzVlU1JPFWxk/O56
 d2m+0dcr8UzpoMSdelg==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9de872 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=wPxJgGvEfR6cvbQpxBEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX9gjBjaww7wvT
 CzC61psxj5+QQSbSDFygUzXvmvHSc4ZTj1ocS3XHkegCNq/MM0JzAiNCPatwVOipO+C06xPp94S
 gbz5bBUXX0S2WHukJOu4GT9kFRQPN+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060250
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

VGhlc2UgZml4ZXMgYXJlIHRvIG1pdGlnYXRlIHRoZSBpc3N1ZShzKSByZXBvcnRlZCBieSBDb3Zl
cml0eSBhbmQgUGV0ZXIKTWF5ZGVsbC4KCkJyaWFuIENhaW4gKDMpOgogIHRhcmdldC9oZXhhZ29u
OiBGaXggc2VtaWhvc3RpbmcgT1BFTiBmaWxlbmFtZSBoYW5kbGluZwogIHRhcmdldC9oZXhhZ29u
OiBGaXggc2VtaWhvc3RpbmcgU1RBVCBmaWxlbmFtZSBoYW5kbGluZwogIHRhcmdldC9oZXhhZ29u
OiBGaXggc2VtaWhvc3RpbmcgQUNDRVNTIGZpbGVuYW1lIGhhbmRsaW5nCgogdGFyZ2V0L2hleGFn
b24vaGV4c3dpLmMgfCA2MiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQoKLS0g
CjIuMzQuMQoK

