Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA2606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RBGxkoiw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H398PyyN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBap-0000eu-51; Tue, 20 Oct 2026 11:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBal-0000e6-3b
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBaj-0005OD-6b
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KD9stO882015
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JFGQJds3U3AvLs1ST0K1I0k/OBPaWSPrMt1rOtnqnpE=; b=RBGxkoiwkb7rnUeD
 FvKGnMTe6uNS+/8ufyC9ucNjy95ut3x7BsfDWL56F5J7twwjMZMEwUQoAD9yWNka
 eiWGHS+SLI/yGr/maxKIjeiylcUM7DDrBkXQZpw37CHnmeYTyAHyWgin03DJETjJ
 cZabh04P/ppDPxW/aBSsjcFrzdBuAcquVCxa1JVzpwzuOI5o67iAayvov1fG7ELw
 3Fl2+APMTwUTuL6uz3aZQXSLeCwJDAC6gXr6oXnWqevoFPgmbLBJ+R3d48ahmocr
 CTsfP5TEAMhtwICW0Hb1Y6qyD+tvF6LcEBsWIqZNX7jJ7utYvagQ/yplEz6ejmRk
 8M01ug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n32yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e954d87b48so49637845ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792509447; x=1793114247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JFGQJds3U3AvLs1ST0K1I0k/OBPaWSPrMt1rOtnqnpE=;
 b=H398PyyNjWVmBmBaWvcmLlTM1Mfl8W0Fw2+U3OSnDixtQlunZVTh+CApdqfCdGk5Qf
 TAGTbVjYgC+uqMwNlfulu9hceGI3VW29VkCffYngZXNKsgJJ1GEajY52VlNTWXr2jIQc
 mHMEaFcxH8at8xr5GCMp1JInPwF84TvdWp2Am6TH68p9AlP20VB6M0DnYvIdhAD38E25
 GWPuL9QF5PbIDlrxSWXio2i2YhxVuJloLkJbhprFH1qNaPFBP/FPiMo8uWF0OaxY6asc
 S9k1eIgJwaZN0kDrp9sWofpVMQhmbXulZI3x53DWy8Y8xBbyfQQx3Vi1MkqdgnO1tH2N
 UYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509447; x=1793114247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFGQJds3U3AvLs1ST0K1I0k/OBPaWSPrMt1rOtnqnpE=;
 b=02tR8L/5ilMCGjYlsulPYrYIf/1I5yWmnZ0ZY0btDc0ICWd1vTXOiaGli7NL5R6du5
 TETFK/bEl/vlj9hatI7z0haLaY+W0RS3X/8IjP9EsqfHkGRjzxeXlgeVa8NrgBpQfmYL
 dwufcD/Jat+gytvmxPlAmHY0sG+//6WDG8ecIp9Eyvx053zy7FdYcmw2nJgAGrSQtO0N
 QqQkqGrBu2BvDaYD1mb5wt1Dme05FHqzRbPv6YPBKjjhPwbBL5DKzSaTQvlLPJoo40jO
 pmb09ukpm4cMBxIWj/uWxIjvb9/a5igqhiaGZ3T+rtzR8GnNTU8vkGhiYzuwmSriSEev
 Ctow==
X-Gm-Message-State: AFq9FYJGY521TRcgiSLHf5Mhv66bsOSDEBGOtOg4l1fqr/wHmB8Ajn3o
 bWV7L2snCbyi4NLmum8kGXZCCzqogUbeoDrsbyUvgaOLesqKwKOGK3cfFYuc4P3fuCMjJwwRWRi
 xCGCi1BidvPehmGdyng35Usg4NL5qzto5npK3R+g6/8MrGl4HtBBf119/DFCdVTxAoQ==
X-Gm-Gg: AYBFou2o8/6hqbRonaUNYbeSkXk+fevKyVTFoz2MDAU06XnAm2qtaNN6GyEimdITmjJ
 oXh8Ci4xLKUFntWZqDeZeWy9UWCpi/3CqXrsw1dT7RYjvxywYxALCbr38zWjvffPLSqJooDS7q3
 8a3UkGY5ZlKFYUqho2nPqvCA5oOGykWwsubP2dsB5V70tR3SSJLNelTH4jXwrQ9VMaDmhJGZeSf
 Z9+Svc+8qX8YQrQ88/q1eonhuYqVyZFZYrP+2JuyLymClLFy+gti8GamipnT+CM7ShDX+SDU2YC
 QwaTYO2rXbt0T6zeDcg8hhfLSd4+nZ8XhPGoMXkll/yhherE1/YiUO2AZmECNPaqirbA3jVomGC
 +ZmsKX3i6TyYZPKWzRNkcmeuJwMCPS+ZGyY3PHLNTeAoILfU=
X-Received: by 2002:a17:903:acc:b0:2e9:5b20:1c22 with SMTP id
 d9443c01a7336-2e9a6833e2cmr93538625ad.8.1792509447146; 
 Tue, 20 Oct 2026 08:17:27 -0700 (PDT)
X-Received: by 2002:a17:903:acc:b0:2e9:5b20:1c22 with SMTP id
 d9443c01a7336-2e9a6833e2cmr93538415ad.8.1792509446685; 
 Tue, 20 Oct 2026 08:17:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b410626sm656815ad.20.2026.10.20.08.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:17:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/3] target/hexagon: avoid negative slot shift
Date: Tue, 20 Oct 2026 08:17:20 -0700
Message-Id: <20261020151720.728888-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
References: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad78607 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aHJGAyB56wG5k7sqf7sA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX2242mqlbTpM/
 HkF7KwGneCtdGCKej45QbeEJBdBEoTL4PrGOA0QY8hdHjAh0xuB/oUKWN9EQLLpbilFXabhllcQ
 im2kTCKHTccW+iZ0R/mZ8bzKYy4hQNw=
X-Proofpoint-GUID: lWp65SAZWFP9vkF1UkKCQvIiXzR_BBtf
X-Proofpoint-ORIG-GUID: lWp65SAZWFP9vkF1UkKCQvIiXzR_BBtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX6/zfm+mSKjfw
 bnfyxG64hRSujJW7Sv4fsfZAaW2BP0lt+TCxAH+cmyE6gBVB6Cr4THKihtUXcwAC6YTkzKNu6zD
 /eViNRzaQg2xoTQJmmV5cS4DfV5qr7Z1ApPhj6mV2QAwXQSm4TOgOJBPrtxQDrAvyVhQ23XQFeC
 ZpuDyICCuJ2CfOa0YSnJuvRp/aWiXdvq0GVNY+EjnW+JLl8pOgttnOCec0a3vqCrz7nYK9vd3e3
 lugMDjFHCLAxzMspN29phpZB0MQLfq8hqNDGrQJhsBIGB22L0qcRGwtbOqyZvuBWn0W69rJaybN
 8TP10X6fePmrTcywAitM8Zhj2CJQ3rncxlCJ0Tzx/paVNr97Yg2ymxa/jvDmvNTSDeafWTqqFWX
 1+Gs6+wYoApcAN84uD2Fc5XFPwC5a2zV5aOajAu4aNzPfT61rY2oOj2s2uDeR6AgsFeNK+MOXJN
 U3AMCIoWcLD1dbwJR0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200060
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW52YWxpZCBwYWNrZXRzIGNhbiBleGhhdXN0IHRoZSBhdmFpbGFibGUgaW5zdHJ1Y3Rpb24gc2xv
dHMgd2hpbGUKZGVjb2RlX3NldF9zbG90X251bWJlcigpIHNlYXJjaGVzIGZvciBhIHZhbGlkIG9u
ZS4gIFdlIHdvdWxkIHRoZW4gdHJ5IHRvCmV2YWx1YXRlIGEgbmVnYXRpdmUgc2hpZnQgYmVmb3Jl
IHJldHVybmluZyB0aGUgcGFja2V0IGFzIGludmFsaWQuCgpEZXRlY3RlZCBieSBjbGFuZydzIFVC
U2FuLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOENZ
YUo9akF5YzI5UlNkVU1EX1NXcXVKcXo0Zk5ReVc3b0NyV2l0aFpoWUFAbWFpbC5nbWFpbC5jb20v
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IDg5ZTk2MTMzMWZmLi44
MzkxYjUxZDYyOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTYwMCw5ICs2MDAsMTIgQEAgZGVjb2RlX3NldF9zbG90
X251bWJlcihQYWNrZXQgKnBrdCkKICAgICBmb3IgKGkgPSAwLCBzbG90ID0gMzsgaSA8IHBrdC0+
bnVtX2luc25zOyBpKyspIHsKICAgICAgICAgU2xvdE1hc2sgdmFsaWRfc2xvdHMgPSBnZXRfdmFs
aWRfc2xvdHMocGt0LCBpKTsKIAotICAgICAgICB3aGlsZSAoISh2YWxpZF9zbG90cyAmICgxIDw8
IHNsb3QpKSkgeworICAgICAgICB3aGlsZSAoc2xvdCA+PSAwICYmICEodmFsaWRfc2xvdHMgJiAo
MSA8PCBzbG90KSkpIHsKICAgICAgICAgICAgIHNsb3QtLTsKICAgICAgICAgfQorICAgICAgICBp
ZiAoc2xvdCA8IDApIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQogICAg
ICAgICBwa3QtPmluc25baV0uc2xvdCA9IHNsb3Q7CiAgICAgICAgIGlmIChzbG90KSB7CiAgICAg
ICAgICAgICAvKiBJJ3ZlIGFzc2lnbmVkIHRoZSBzbG90LCBub3cgZGVjcmVtZW50IGl0IGZvciB0
aGUgbmV4dCBpbnNuICovCi0tIAoyLjM0LjEKCg==

