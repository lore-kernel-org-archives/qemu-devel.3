Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD01039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zv-0006on-Mu; Fri, 27 Feb 2026 15:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zu-0006oP-QE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zr-0006oy-U3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:50 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIlrg21712871
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SGXkHyQer2bycGWbJ3CzK4wUhxTssj22khADz27YlKg=; b=dDx/ArY7G/i4VJ8W
 3wv5PGH1uPu9hdSFMqjwMY+gRNyTbFXFC9nlkUsESLjR48BM3tampNsGFy9fSaUY
 fLFIDCxw01+nk9joK6FOgfYfPMNPnY3pLkP/oFOx9j4Rxhf303AuHAzGtxR4Z3pZ
 rhtBkpyBw6/SeyOvVpGrzQdTRoosBPwMFsbWGIOzUtPSg0UTtST02QnI9cKrBlLH
 AkCnh70f/U3Rq2q/riZM74FK0eNoGs3r6Led2PLq2RsXwAgktmAXwFeRlCuoATQs
 vHUZENb9Wtzw9BW17854JfOmUdZR9fLPGdzKKMWsH8vUmT9BWNT1FghkjuaC+EjH
 F14tng==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgv5gad0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:46 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-463a075e079so13196001b6e.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224605; x=1772829405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGXkHyQer2bycGWbJ3CzK4wUhxTssj22khADz27YlKg=;
 b=Hoa2PDnSvSBwouXaG3vjSLPmUrMIeu217tfSIxOX+NipY/D97fK+hPaC7acUhKnBa+
 iFGTVVWzArre8CaeFg+wEkOIJ1UIfX4zkLPLKMdZYGMST1pB0o+b839xQ7QhcghgUngB
 6+jJYMEDW0JzcKedpSir/bamoG0T59uGmmH7IRpehJ/cw/LzbCzJPwg9jD+ZXFvp8lZu
 lN1Eq9L72z7SlHk3lthLALehuHEL1PAx8KIlPOXZpSD/K4ATXv4tXnR3wn6m3r1L6vXf
 GvXaPu+NUUHtOzrL7iUziTQPcY+xdYMVSDJOMmkt7ydQ7beaFMx8N4Ab/zibVm3eHYnU
 yDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224605; x=1772829405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SGXkHyQer2bycGWbJ3CzK4wUhxTssj22khADz27YlKg=;
 b=eOgqCkNA5eeusO6+27QcDOP9j8WbAwXKELdZD5n7Mdo+wSe/OIH7c1F6P46eu5g76Z
 mrjd0sabBzb9LbvrAYlN/0uBqJfw1YM5OZhvZZXYWPBclI4TYZ0Gs501WXQ7vkLpmRJM
 4P3HvoXyYaTq90ttsqTbr7T6XnZEYoAvdEOHNx9A0MXe4h5TrAMlZup0R/sAr1mZO5rr
 ILr2QBXm4augtGt7sN/lA4Lt0l3ImZmIaMKyjXIE0n2VYO70txCTYGSTciZyhXFeAltx
 0BbwPf/VvLl4GfPKZydSYZuzBgxA8U8gRAuedNt0IuftpMGVlEWcQZh1N4VDNmWRLc+1
 CR0A==
X-Gm-Message-State: AOJu0Yx6wit3GDtFDwb3HGfQjzRA3OtknFgLUeC7oaD0c7OtL5BywUdN
 +JN89FDXjT9vjAnAIKZX8bCqg3w+AjKZ5mKJz/X8Q1k5Ji2ZrmHyUaxhaSFTZvNOyXLlNMN+tzi
 bAo6gKojqDk20DE5D/llpdwJEEyFbsaOVXZ6erouZb2Zq2OaMYOsMl8yfeL8p+1KO4Q==
X-Gm-Gg: ATEYQzyNYpoNNrC4TF6r+QRswSbblzY/p7HT3WqC+EccAXTHa5rVEtlqQQGtkditt+l
 T7uz9X2hAtpTbL8wLTdn2QFIUwAzDfj5adJmHZR2PWct2B7VyQZc9jRsQodSE+EYeJoydD56PDB
 gRwx7rnuQYd/dhaZxvXOWH0+edQ36PMvJUlScIUdJ3nRsfyVnxNLxhjjx1FgNka1+TMRrhoMwpW
 q0ampyrqE8xPkpwrAXEXz4cNQgdLhR2n1rpToeByRg3m/vrL3XevF8Pt9+/AEGlmDHBRIecyo+T
 lNZkFt8ySQXm3sADsre6OoNsNRH4Yss5p9CMDWPIYCUkgrPAJYnsz+kmf0cRXw5x/VR5U53xJCk
 kPAZmZfqIcKbMB7wCU9rqNr8yR7Y49v+4Cb3KNQLeWUrArBkBg9H4RCfrDgQq46bf3cY6Gw==
X-Received: by 2002:a05:6808:518e:b0:45e:6697:b7cd with SMTP id
 5614622812f47-464bea288a5mr2266924b6e.20.1772224605547; 
 Fri, 27 Feb 2026 12:36:45 -0800 (PST)
X-Received: by 2002:a05:6808:518e:b0:45e:6697:b7cd with SMTP id
 5614622812f47-464bea288a5mr2266902b6e.20.1772224605053; 
 Fri, 27 Feb 2026 12:36:45 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:44 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 08/37] target/hexagon: Add system event, cause codes
Date: Fri, 27 Feb 2026 12:35:58 -0800
Message-Id: <20260227203627.932864-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RPq+3oi+ c=1 sm=1 tr=0 ts=69a2005e cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XVQBMALLqD4WjdKg770A:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 00jNnpxmOfNB-C4PnPuPzMhTc0TRBjwL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX62FJfZvtTink
 TN3gd/nE7Lfp8PyaPj+YkRYlW4rPCOIrQYFUlmXM5DRcdMdFVu32ZNaCOd1cKbbb6QJmpxn6lov
 PgruSWR7pAMHh1lprgqkUYLvkCs3HLdEyq4nepma9sqSDAohYP9zbKZa1f8euMTbaKzN3gqy2jH
 33k7/+08zit7psmaLE8N2/RU3v1DyKbQ9k57oBE0N0UIJL3OVPB4DQkbBQNuybzoFqJRGq4ARQ5
 fb4p91YCLvtm/hcV4ks8U7MlpaFZp/t1PbPQ/Rprd1R/BNW8cCo6u8jGP//nFUC+ef4pwcoiiwt
 d5klzImFN/8kR7JI6ztuQG/GkxjiLP0Uz0tX/+E7bGEk1vL0odSuM99KDBE6l2gwVdHU0SsyU3E
 x5zX76wCS7QiHAX68UXCfoiiFMEc2SDdz+Cm+5lHTW7m/ntq1gsLLQbvnWtWZKwI2xFtpzPYg4P
 5yVhO7F8vUTDYPHUAEg==
X-Proofpoint-GUID: 00jNnpxmOfNB-C4PnPuPzMhTc0TRBjwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgOSArKysrKwogdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaCB8IDc1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3NSBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggODVhZmQ1OTI3NzguLjA0OTg1NmU3
Y2JhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaApAQCAtNDQsNiArNDQsMTUgQEAKIAogI2RlZmluZSBNTVVfVVNFUl9JRFggMAogCisj
ZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8wIDAKKyNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzEgMQor
I2RlZmluZSBIRVhBR09OX0NQVV9JUlFfMiAyCisjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8zIDMK
KyNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzQgNAorI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfNSA1
CisjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV82IDYKKyNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzcg
NworCiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgdGFyZ2V0X3Vsb25nIHZhOwogICAgIHVpbnQzMl90
IHdpZHRoOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9iaXRzLmgKaW5kZXggMTliZWNhODFjMGMuLjkxZTlkYTA5ZTAzIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9i
aXRzLmgKQEAgLTI0LDIwICsyNCw3NyBAQAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBDQUxJR04g
LSAxKQogCiBlbnVtIGhleF9ldmVudCB7Ci0gICAgSEVYX0VWRU5UX05PTkUgICAgICAgICAgID0g
LTEsCi0gICAgSEVYX0VWRU5UX1RSQVAwICAgICAgICAgID0gIDB4MDA4LAorICAgIEhFWF9FVkVO
VF9OT05FID0gLTEsCisgICAgSEVYX0VWRU5UX1JFU0VUID0gMHgwLAorICAgIEhFWF9FVkVOVF9J
TVBSRUNJU0UgPSAweDEsCisgICAgSEVYX0VWRU5UX1BSRUNJU0UgPSAweDIsCisgICAgSEVYX0VW
RU5UX1RMQl9NSVNTX1ggPSAweDQsCisgICAgSEVYX0VWRU5UX1RMQl9NSVNTX1JXID0gMHg2LAor
ICAgIEhFWF9FVkVOVF9UUkFQMCA9IDB4OCwKKyAgICBIRVhfRVZFTlRfVFJBUDEgPSAweDksCisg
ICAgSEVYX0VWRU5UX0ZQVFJBUCA9IDB4YiwKKyAgICBIRVhfRVZFTlRfREVCVUcgPSAweGMsCisg
ICAgSEVYX0VWRU5UX0lOVDAgPSAweDEwLAorICAgIEhFWF9FVkVOVF9JTlQxID0gMHgxMSwKKyAg
ICBIRVhfRVZFTlRfSU5UMiA9IDB4MTIsCisgICAgSEVYX0VWRU5UX0lOVDMgPSAweDEzLAorICAg
IEhFWF9FVkVOVF9JTlQ0ID0gMHgxNCwKKyAgICBIRVhfRVZFTlRfSU5UNSA9IDB4MTUsCisgICAg
SEVYX0VWRU5UX0lOVDYgPSAweDE2LAorICAgIEhFWF9FVkVOVF9JTlQ3ID0gMHgxNywKKyAgICBI
RVhfRVZFTlRfSU5UOCA9IDB4MTgsCisgICAgSEVYX0VWRU5UX0lOVDkgPSAweDE5LAorICAgIEhF
WF9FVkVOVF9JTlRBID0gMHgxYSwKKyAgICBIRVhfRVZFTlRfSU5UQiA9IDB4MWIsCisgICAgSEVY
X0VWRU5UX0lOVEMgPSAweDFjLAorICAgIEhFWF9FVkVOVF9JTlREID0gMHgxZCwKKyAgICBIRVhf
RVZFTlRfSU5URSA9IDB4MWUsCisgICAgSEVYX0VWRU5UX0lOVEYgPSAweDFmLAogfTsKIAogZW51
bSBoZXhfY2F1c2UgewogICAgIEhFWF9DQVVTRV9OT05FID0gLTEsCi0gICAgSEVYX0NBVVNFX1RS
QVAwID0gMHgxNzIsCi0gICAgSEVYX0NBVVNFX0ZFVENIX05PX1VQQUdFID0gIDB4MDEyLAotICAg
IEhFWF9DQVVTRV9JTlZBTElEX1BBQ0tFVCA9ICAweDAxNSwKLSAgICBIRVhfQ0FVU0VfSU5WQUxJ
RF9PUENPREUgPSAgMHgwMTUsCisgICAgSEVYX0NBVVNFX1JFU0VUID0gMHgwMDAsCisgICAgSEVY
X0NBVVNFX0JJVV9QUkVDSVNFID0gMHgwMDEsCisgICAgSEVYX0NBVVNFX1VOU1VQUE9SVEVEX0hW
WF82NEIgPSAweDAwMiwgLyogUUVNVS1zcGVjaWZpYyAqLworICAgIEhFWF9DQVVTRV9ET1VCTEVf
RVhDRVBUID0gMHgwMDMsCisgICAgSEVYX0NBVVNFX1RSQVAwID0gMHgwMDgsCisgICAgSEVYX0NB
VVNFX1RSQVAxID0gMHgwMDksCisgICAgSEVYX0NBVVNFX0ZFVENIX05PX1hQQUdFID0gMHgwMTEs
CisgICAgSEVYX0NBVVNFX0ZFVENIX05PX1VQQUdFID0gMHgwMTIsCisgICAgSEVYX0NBVVNFX0lO
VkFMSURfUEFDS0VUID0gMHgwMTUsCisgICAgSEVYX0NBVVNFX0lOVkFMSURfT1BDT0RFID0gMHgw
MTUsIC8qIGFsaWFzOiBzYW1lIGNhdXNlIGFzIElOVkFMSURfUEFDS0VUICovCisgICAgSEVYX0NB
VVNFX05PX0NPUFJPQ19FTkFCTEUgPSAweDAxNiwKKyAgICBIRVhfQ0FVU0VfTk9fQ09QUk9DMl9F
TkFCTEUgPSAweDAxOCwKKyAgICBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJTlNOID0gMHgwMWEs
CisgICAgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19TSU5TTiA9IDB4MDFiLAogICAgIEhFWF9DQVVT
RV9SRUdfV1JJVEVfQ09ORkxJQ1QgPSAweDAxZCwKLSAgICBIRVhfQ0FVU0VfUENfTk9UX0FMSUdO
RUQgPSAgMHgwMWUsCi0gICAgSEVYX0NBVVNFX1BSSVZfTk9fVVJFQUQgID0gIDB4MDI0LAotICAg
IEhFWF9DQVVTRV9QUklWX05PX1VXUklURSA9ICAweDAyNSwKKyAgICBIRVhfQ0FVU0VfUENfTk9U
X0FMSUdORUQgPSAweDAxZSwKKyAgICBIRVhfQ0FVU0VfTUlTQUxJR05FRF9MT0FEID0gMHgwMjAs
CisgICAgSEVYX0NBVVNFX01JU0FMSUdORURfU1RPUkUgPSAweDAyMSwKKyAgICBIRVhfQ0FVU0Vf
UFJJVl9OT19SRUFEID0gMHgwMjIsCisgICAgSEVYX0NBVVNFX1BSSVZfTk9fV1JJVEUgPSAweDAy
MywKKyAgICBIRVhfQ0FVU0VfUFJJVl9OT19VUkVBRCA9IDB4MDI0LAorICAgIEhFWF9DQVVTRV9Q
UklWX05PX1VXUklURSA9IDB4MDI1LAorICAgIEhFWF9DQVVTRV9DT1BST0NfTERTVCA9IDB4MDI2
LAorICAgIEhFWF9DQVVTRV9TVEFDS19MSU1JVCA9IDB4MDI3LAorICAgIEhFWF9DQVVTRV9WV0NU
UkxfV0lORE9XX01JU1MgPSAweDAyOSwKKyAgICBIRVhfQ0FVU0VfSU1QUkVDSVNFX05NSSA9IDB4
MDQzLAorICAgIEhFWF9DQVVTRV9JTVBSRUNJU0VfTVVMVElfVExCX01BVENIID0gMHgwNDQsCisg
ICAgSEVYX0NBVVNFX1RMQk1JU1NYX0NBVVNFX05PUk1BTCA9IDB4MDYwLAorICAgIEhFWF9DQVVT
RV9UTEJNSVNTWF9DQVVTRV9ORVhUUEFHRSA9IDB4MDYxLAorICAgIEhFWF9DQVVTRV9UTEJNSVNT
UldfQ0FVU0VfUkVBRCA9IDB4MDcwLAorICAgIEhFWF9DQVVTRV9UTEJNSVNTUldfQ0FVU0VfV1JJ
VEUgPSAweDA3MSwKKyAgICBIRVhfQ0FVU0VfREVCVUdfU0lOR0xFU1RFUCA9IDB4ODAsCisgICAg
SEVYX0NBVVNFX0ZQVFJBUF9DQVVTRV9CQURGTE9BVCA9IDB4MGJmLAorICAgIEhFWF9DQVVTRV9J
TlQwID0gMHgwYzAsCisgICAgSEVYX0NBVVNFX0lOVDEgPSAweDBjMSwKKyAgICBIRVhfQ0FVU0Vf
SU5UMiA9IDB4MGMyLAorICAgIEhFWF9DQVVTRV9JTlQzID0gMHgwYzMsCisgICAgSEVYX0NBVVNF
X0lOVDQgPSAweDBjNCwKKyAgICBIRVhfQ0FVU0VfSU5UNSA9IDB4MGM1LAorICAgIEhFWF9DQVVT
RV9JTlQ2ID0gMHgwYzYsCisgICAgSEVYX0NBVVNFX0lOVDcgPSAweDBjNywKIH07CiAKICNkZWZp
bmUgUEFDS0VUX1dPUkRTX01BWCAgICAgICAgIDQKLS0gCjIuMzQuMQoK

