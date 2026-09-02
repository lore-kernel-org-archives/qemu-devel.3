Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E67C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coC-0008Vn-Uk; Wed, 02 Sep 2026 00:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coA-0008Ur-07
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1co7-0000Iw-8c
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824NWJu2468868
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=sdHbNbuug6s
 a6ZbggQ9WzN7EQVe2KDPB56Yql5WqG1s=; b=Tqyf6D01e6xKd/3d1MZGyl85y14
 B7cm+gGR7fghK3awci0Nad5VuhregW+FymoEFcKN3iW+ksmXfuxjmgmlHjp9FWdd
 0mIVetvkX49e7orsHW74AQWUU8tL0SoilCWlDz1V4CWn1qXDTUoo1RTJjg4L31mx
 kzygLdGmM80SDR1+2AIUsQvCVuOaTHH1E3s3lVlFgFtzW+f1Zfcsf6s7I4qK6Nch
 BVxs56cdwc3ymWtphc22WFytdcfFlzVlbmRUrZuK81eMovxVESeTdiKaQmJ52lgu
 zCnf29NhdJttZoBKEsRTWRRJF/NJSuPoXRvv9wJtQstUZ1+wczua8s/qMzg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj36s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso9849585ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324160; x=1788928960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sdHbNbuug6sa6ZbggQ9WzN7EQVe2KDPB56Yql5WqG1s=;
 b=iz6xmwLmn0C1KT/n1aexXa9iUbFfTMSGuilgl5I0WUIulVk7c/gD/hQOVoKQMC52Bx
 waWAKw497CjSwy3E/WAYkGaQQTUATLxAUzeC1nNwfkZqy0UK9ygkLBX70NWYFVhpUaVx
 rtrNnpFI7GVAdYce/As4gCUiZykI3hfdELKMnHukAPkMvGKEfrUDVTmRkCzV7lN4Yjpx
 kd8RxnVInbF9psX7azz2vofwSsDs4WoYxhWgjaDgA38JoDwl/UnT1PPTrcqQTJjWK6Uk
 SGx+/uvIwPAduYqHrZ0VMBaJ1p6bETU1QnTPFVCu4080l6vQgnrvYQIRb8lJM7W5MkXD
 gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324160; x=1788928960;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sdHbNbuug6sa6ZbggQ9WzN7EQVe2KDPB56Yql5WqG1s=;
 b=ClbCDxRP1W0x/NfvquFcWfuagflHZTpbpox0FLiIrTg4HNZgeXfe7IEmO09b49ClL1
 lMjH6woAJiQEn8sw2Tk4C3KDT2lls/M+xsdrh2HtBYMuvKEpbXz3kUdy9G1w18gB4KSj
 H6f1egkywKyDN9aOg5Z4cw7t94b+AizbqdW3Cc0zwm6L6+/yxQO3ARQLdHetnHUJMfAj
 PE6FN4dinMz0oU5IUZZbblOu0VnaAiwHM8XIeQFJkm3sMJBDLywRAr4zxa2zl3Uyf261
 9baoS+ryaQ3mN7VDf4Lwvd8yKVLZEraP7vgxrtOWosUuGGWOdwsjF5/6dLKjgZePnWoG
 x5Qg==
X-Gm-Message-State: AFuF++k+gt9tpUlnmwcbF6bDCMjcG3s7WUUFkbpA5Lk9khX3X/Tpsrkb
 LyV2+d3rgvRTv7JPYVx44SRD/uu938HoW9Egr8sKXqVlRF0c6i5p6gKUcStX7lM6x0VknySGASZ
 HtJ+A6Y+W96JYexybUIpqgc+7QjqOMWS1WS+K+f9FYKN9QSoklTEzVl+4h3akBRkybA==
X-Gm-Gg: AR+sD13Haz5uxBQKpYkNH3k2/RgOdL8NTIDFHckDXePIhOu2fVg+LMlWs623MInxOaD
 TTZDkPcnTs7j4kUOr+ccYLfdBG0IhwsNP85kX+jJnn9dV5wi+xNTWvJQX3K16oXOZCuNcH+CyNa
 Dvj2WgZ5j1XpOwykYkJDwivbJe2A0xgB32APeFfe+5uunc9ECac+2oo38Jq75Rd+FT918aNwUVj
 q82jNmGPTXl95Z+m9FkLqXw7v2LpLdWVfvyA57Pa+fA/b+FkzprfQsJvu5KPyfr6LXspYW4kS/x
 Jho9cm52FFPK3u+ZKnfKZmxjSvj32QvG8WvRDHxMLP2Tl7D1fZYbu9VTv+JufhQ3mtQg9FNJgp0
 ZROhPeODMWPlFKH58ZoUcqwMunA4BZKP2sy6MAKdjjjm7iM6F
X-Received: by 2002:a05:6a20:d502:b0:3c4:1493:6822 with SMTP id
 adf61e73a8af0-3d9b1f5e8edmr3884049637.18.1788324160033; 
 Tue, 01 Sep 2026 21:42:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:d502:b0:3c4:1493:6822 with SMTP id
 adf61e73a8af0-3d9b1f5e8edmr3883981637.18.1788324159496; 
 Tue, 01 Sep 2026 21:42:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 00/28] hex queue
Date: Tue,  1 Sep 2026 21:42:03 -0700
Message-Id: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a940 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=OGCC_TGm5RFZRYyDcCYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: SKk3wwoD6mr4pMayzCuf4VTx--1P4Jja
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXwt7eUI62wGAF
 XzCJZXHuJ08X8rFo8MjC5ZdfYX5BT5d5Yf9/J/I0YKdnRpOuc2730HGtEKP7s+UbVjkTq+rS+Lc
 oRJ3mFhveGU62HllzuRVTFEMGe6Yg5M=
X-Proofpoint-GUID: SKk3wwoD6mr4pMayzCuf4VTx--1P4Jja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX5Yz3Et8Buv86
 k+GunjhPz5DXwGzkYbuweryQy9eoLsOUZ/buxbJtoUGA8XMNi99eeGC0ElDP6rTIYXD3pvx5Dfp
 jUI81gksh76V0Wlr2P0XOXrFFtbsTx4IjxNra5r7fbhTBMtZ2VCPKcPpWEd7fO6/BbAdN8J/ZOr
 Xyh9sy1VIazVgOxLJsVj1zfk7iRQT6IPAc8JKQt+BAuIbXJIDmnBou5tUOrEH/sZAZdWzWB5+cM
 BFTTVtSkZ5otDHF4CF90sPiW1IZ9I4ayICivWdyhhBQCxcpFVbYZDNot3vaL32u9K+DcHT7BAQJ
 m+gLczxUoLOGqEZuqJysh76KmfuCiJaJ55FunNOJjBIpM4qyoMaXvZqpnY9P9awGAkvDiqyR3/k
 FfvWDrT3Dx9YvmQA+PaiW2VHPHdnBfKsLuqZP3+WxDROu8d5VZhNg0wbUDC2jRs0YRUz9A9Jw/h
 DOmvVQsN4zp41awiQRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBlYjcxMGMyNTU2NDJjZDdkYzk0N2Yy
NWM5YTA2YzlmYzgxOTFlOThkOgoKICBNZXJnZSB0YWcgJ2Zpcm13YXJlLTIwMjYwOTAxLXB1bGwt
cmVxdWVzdCcgb2YgaHR0cHM6Ly9naXRsYWIuY29tL2tyYXhlbC9xZW11IGludG8gc3RhZ2luZyAo
MjAyNi0wOS0wMSAxMDozODo0NSArMDEwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBv
c2l0b3J5IGF0OgoKICBodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdSB0YWdzL3B1bGwt
aGV4LTIwMjYwOTAxCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNGE0YmExNWIyYjBk
ZTAwOWM2NjI2NzRkZDM2NWZmNTYwNDhlMmIyMjoKCiAgaHcvaGV4YWdvbjogZGVjb2RlIGFuIGVt
cHR5IFRMQiBzaXplIGZpZWxkIGFzIDRLQiAoMjAyNi0wOS0wMSAxODoyMzoyMyAtMDcwMCkKCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGhpcyBQUiBhZGRzIHNlbWlob3N0aW5nLCBhbmQgZml4ZXMgZm9yIGV4Y2VwdGlvbnMs
IGljaW52YSwgVExCLCBodGlkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkJyaWFuIENhaW4gKDE4KToKICAgICAgc2VtaWhv
c3Rpbmc6IGFkZCBBUElzIGZvciBjaGFyZGV2LWF3YXJlIGd1ZXN0IGZkIHJvdXRpbmcKICAgICAg
dGFyZ2V0L2hleGFnb246IEFkZCBhbiBlcnJubyBtYXBwaW5nCiAgICAgIHB5dGhvbi9tYWNoaW5l
OiBzdXBwb3J0IHJvdXRpbmcgc2VtaWhvc3Rpbmcgb3V0cHV0IHRvIHRoZSB0ZXN0IGNvbnNvbGUK
ICAgICAgdGVzdHMvZnVuY3Rpb25hbDogQWRkIGhleGFnb24gc2VtaWhvc3Rpbmcgc3lzdGVzdHMK
ICAgICAgdGFyZ2V0L2hleGFnb246IGFsaWduIGV4Y2VwdGlvbnMgZm9yIHVzZXIvc3lzZW11CiAg
ICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBjaGVjayBwcml2IGluc3RydWN0aW9ucyByYWlzZSBTSUdJ
TEwKICAgICAgdGFyZ2V0L2hleGFnb246IGd1YXJkIHdyaXRlcyB0byB1bmltcGxlbWVudGVkIGd1
ZXN0IHJlZ2lzdGVycwogICAgICB0YXJnZXQvaGV4YWdvbjogdGFrZSBCUUwgd2hlbiByZWFkaW5n
IHRoZSBzeXN0ZW0gcGN5Y2xlIGNvdW50CiAgICAgIHRhcmdldC9oZXhhZ29uOiBnYXRlIEdQQ1lD
TEUgZ3Vlc3QgcmVnaXN0ZXIgcmVhZHMgb24gU1NSOkNFCiAgICAgIHRhcmdldC9oZXhhZ29uOiBy
ZWFkIFVUSU1FUkxPL1VUSU1FUkhJIGZyb20gdGhlIGdsb2JhbCB0aW1lcgogICAgICB0YXJnZXQv
aGV4YWdvbjogcmFpc2UgaW1wcmVjaXNlIGV4Y2VwdGlvbiBvbiBtdWx0aS1UTEIgbWF0Y2gKICAg
ICAgdGFyZ2V0L2hleGFnb246IGltcGxlbWVudCBkaXJlY3QtdG8tZ3Vlc3QgaW50ZXJydXB0IGRl
bGl2ZXJ5CiAgICAgIHRhcmdldC9oZXhhZ29uOiBmaXggaWFzc2lnbntyLCB3fSB0byBjb3ZlciBh
bGwgdGhyZWFkcwogICAgICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IHVwZGF0ZSB0byB2MC4y
LjEyLCArdGVzdF97aW50ZXJydXB0cywgc3lzX3JlZ3N9CiAgICAgIHRhcmdldC9oZXhhZ29uOiBp
bnZhbGlkYXRlIHRyYW5zbGF0ZWQgY29kZSBmb3IgdXNlciBpY2ludmEKICAgICAgdGVzdHMvdGNn
L2hleGFnb246IGFkZCBpY2ludmEgdGVzdAogICAgICBody9oZXhhZ29uOiBhc3NpZ24gYSBkaXN0
aW5jdCBodGlkIHRvIGVhY2ggRFNQIG1hY2hpbmUgQ1BVCiAgICAgIGh3L2hleGFnb246IGRlY29k
ZSBhbiBlbXB0eSBUTEIgc2l6ZSBmaWVsZCBhcyA0S0IKCk1hdGhldXMgVGF2YXJlcyBCZXJuYXJk
aW5vICg5KToKICAgICAgZGlzYXMvaGV4YWdvbjogaG9ub3VyIHRhcmdldCBieXRlIG9yZGVyIHdo
ZW4gcHJpbnRpbmcgaW5zdHJ1Y3Rpb25zCiAgICAgIHRhcmdldC9oZXhhZ29uOiBmaXggc3RvcmUt
Y29uZGl0aW9uYWwgb24gYmlnLWVuZGlhbiBob3N0cwogICAgICB0YXJnZXQvaGV4YWdvbjogZml4
IFBDIGFkdmFuY2VtZW50IGZvciBub24tQ09GIFRCIHRlcm1pbmF0b3JzCiAgICAgIHRhcmdldC9o
ZXhhZ29uOiBhZGQgYXV4IGZ1bmN0aW9ucyBmb3IgZ3Vlc3QgbWVtIGxvYWQvc3RvcmUKICAgICAg
c2VtaWhvc3Rpbmc6IGFkZCBjYWxsYmFjayB0byBzZXQgZXJyb3IKICAgICAgdGFyZ2V0L2hleGFn
b246IGFkZCBzZW1paG9zdGluZyBzdXBwb3J0CiAgICAgIHNlbWlob3N0aW5nOiBhZGQgZnRydW5j
YXRlIGhlbHBlciAodG8gYmUgdXNlZCBmb3IgaGV4YWdvbikKICAgICAgdGFyZ2V0L2hleGFnb246
IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rpbmcgb3BlcmF0aW9ucwogICAgICB0YXJn
ZXQvaGV4YWdvbjogYWRkIENPUkVEVU1QIHNlbWlob3N0aW5nIG9wZXJhdGlvbgoKU2lkIE1hbm5p
bmcgKDEpOgogICAgICBody9pbnRjOiBjbGVhciBwZW5kaW5nIGJpdCBvbiBsMnZpYyBkZS1hc3Nl
cnRpb24KCiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgICAgICAgICAgICAgIHwgICA4
ICstCiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgICAyICsK
IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oICAgICAgICAgICAgfCAgIDMgKy0KIGlu
Y2x1ZGUvc2VtaWhvc3RpbmcvY29tbW9uLXNlbWkuaCAgICAgICAgICAgfCAgIDIgKwogaW5jbHVk
ZS9zZW1paG9zdGluZy9jb25zb2xlLmggICAgICAgICAgICAgICB8ICAgOSArCiBpbmNsdWRlL3Nl
bWlob3N0aW5nL2d1ZXN0ZmQuaCAgICAgICAgICAgICAgIHwgICA5ICsKIGluY2x1ZGUvc2VtaWhv
c3Rpbmcvc3lzY2FsbHMuaCAgICAgICAgICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vY3B1
LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmggICAgICAgICAgICAgICAgIHwgICA2ICsKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAg
ICAgICAgICAgICAgICAgICAgfCAgIDkgKwogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICAg
ICAgICAgICAgICAgICB8ICAgNSArCiB0YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oICAgICAgICAg
ICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAg
ICAgICAgfCAgIDYgKy0KIHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jICAgICAg
ICAgfCAgIDcgKwogZGlzYXMvaGV4YWdvbi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNiArLQogaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jICAgICAgICAgICAgICAgICAgICB8ICAg
NCArCiBody9oZXhhZ29uL2hleGFnb25fdGxiLmMgICAgICAgICAgICAgICAgICAgIHwgIDI5ICst
CiBody9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGxp
bnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgICAgICAgICAgICAgfCAgMzAgKy0KIHNlbWlo
b3N0aW5nL2FybS1jb21wYXQtc2VtaS5jICAgICAgICAgICAgICAgfCAgIDMgKy0KIHNlbWlob3N0
aW5nL2NvbnNvbGUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogc2VtaWhvc3Rpbmcv
Z3Vlc3RmZC5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArCiBzZW1paG9zdGluZy9zeXNj
YWxscy5jICAgICAgICAgICAgICAgICAgICAgIHwgIDI5ICsrCiB0YXJnZXQvYXJtL2NvbW1vbi1z
ZW1pLXRhcmdldC5jICAgICAgICAgICAgIHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL2NvbW1vbi1z
ZW1pLXRhcmdldC5jICAgICAgICAgfCAgNTEgKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMTcgKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAg
ICAgICAgICAgICAgICAgfCAxMTIgKysrKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAg
ICAgICAgICAgICAgICAgfCAgMzMgKy0KIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMg
ICAgICAgICAgICAgfCAgOTEgKysrLQogdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jICAgICAgICAg
ICAgICAgICAgICB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAg
ICAgICAgICB8IDczNCArKysrKysrKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICAgIHwgICA1ICstCiB0YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDg1ICsrLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgNzIgKystCiB0YXJnZXQvcmlzY3YvY29tbW9u
LXNlbWktdGFyZ2V0LmMgICAgICAgICAgIHwgICA0ICsKIHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52
YS5jICAgICAgICAgICAgICAgICAgfCAgNzAgKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9wcml2aWxl
Z2VkLWluc24uYyAgICAgICAgIHwgIDc5ICsrKwogdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5j
ICAgICAgICAgICAgICAgICB8ICAxMSArLQogaHcvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMSArCiBweXRob24vcWVtdS9tYWNoaW5lL21hY2hpbmUucHkgICAg
ICAgICAgICAgIHwgIDEwICstCiBxZW11LW9wdGlvbnMuaHggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAgICAg
ICAgIHwgIDE4ICstCiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAg
IHwgICAxICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgfCAg
IDUgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8ICAxMiAr
LQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgICB8ICA5NCArKysr
CiB0ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgICAgICAgICAgIHwgICAzICsKIDQ3
IGZpbGVzIGNoYW5nZWQsIDE1NzMgaW5zZXJ0aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2NvbW1vbi1zZW1pLXRhcmdldC5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vaWNpbnZhLmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9wcml2aWxlZ2VkLWluc24uYwogY3JlYXRlIG1vZGUgMTAw
NzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5Cg==

