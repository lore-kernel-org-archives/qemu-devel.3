Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=An61Wnql;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dpdKqs5K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4TH-0007pY-1s; Thu, 22 Oct 2026 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rm-0002M3-JZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rk-0006QD-BE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FSMS428565
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=; b=An61WnqltZ//LzIC
 D6ZO+PHJt9ST+LFPIc9GEV00KqyPSmoW9laUwMcie6I5iTlFtFiYDiAV+EUhAZmM
 5sZ2/3lDiy5cY2VEwb0KnJJoAVgNRBryy4iUtcBXe4VfdSCyv0mI+O1p82R8j0bh
 IYLl6uQljlVRsBnp2A0NZFiPboG10iJKdPI2KXxt7b7vhGZWXc1W3MalDkG69WUP
 L78nC970E3Yob2h/tdyQqOdLZgrbOvbyeQsb6DyDeQE3uwDAd1ffABKYDZmXv4vT
 ZfGDS7JBFnL9sRCSmntWR4I7xG7Sg2FLMr6ZThL/xtG2WAQCWS71vk1EIJ4QbEvP
 HJGlAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms1b8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso669986eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720300; x=1793325100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=dpdKqs5KsuG34TdLioWjoketuQGZWgf9QJT2T1arnlh/G+7zj0SHLtYmEHNOkNIRih
 UULoFu6We5GBz6S844sKGNst4P9oGfGH0PXTnOUfso1wGcl9vghfwla1vh2PAZw7iApT
 bAM+VKwINgKhPlzMvG01PK3Am/wAqB+TLLzbWu3RFtmmyyJVREIarRbO7pEqkuw0ZBC4
 H3IlseIDTolWCaHpE48URKzYuv8fnXxteHC7vlEY294grvIfSGJVy68hi5UT/WjP9tRA
 L3QwnpTZqUFlIv9wbnJiRExnwcbyWBjcqMfl8eJ8+MvlGK9TxUDEEOOTPx3b1dZbxNiy
 DHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720300; x=1793325100;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=Fiv6DaqfK+ZLAfVyelP2UmgbtIM3Oj062zED2Zo91iVvSBX6hbXDKfbPr6M/no3bgv
 InMiu2STqpiCand2k0e0Ol2MnXcIAf/HVx6iGIw2RhmUmXFzh22lnTJnx1s4K6MlHCPY
 35b5qr9I8SVtJpAJFcImg1PtFcp1S1E+vzeHIPkGyqxsiGetsVh/5Vl6NAiEFhL5jlhw
 bKZg/ruf7ne8JLWXB1YNUNKUV4prQ8L9rrRRxCFpgCKhzq3dFlqv8EcQZ1HKBXy3s9YU
 tU7g26rFLBkjfTgSY92PvzPuVDHHZ/y3B0xTiS/+3NA/p4XEUND3X8yRWZ/04XgD5Yuo
 vf3g==
X-Gm-Message-State: AFq9FYJfS1DVlw1XBVcWlZYZQdkRXA5xKwCQMZV13fP6OeNPl8uWdPd4
 Z1dUJb0jrxfLuqHutzSgIKC0flFLghT9MMKVJPX2fpc8SseJAOoogm0hYh8wMOj5G1Qbn0jV29x
 Od+/61kYvfwNt0BK42Y4y/fuKtKtUNCTpJ8PCUYFediCAKmb3hUuBOriHomOwtWb3fg==
X-Gm-Gg: AYBFou01jsFYWDyEezhUJh8D6FRKZAyhjqYteUOoF/grlcdE9XZXZuvcHHymDDvh4pB
 eJvMjXBE02vBs5K4bf+5ZKM1sLGpMg4Eu5Senuq3n3hc6AvLsaGL9CdDiQf2ierYUWKSBhpn8PC
 +pzwQpPaa8CIb0DdepsZEfjU2TL4l3QT9zm/6z1k9b6Le2xmtvQNycna49zI1FGORhAiOzM3xZI
 pORWAh+U6Y96IAb2e+f/6o+DQ6uxq5RkQZulm73o2/dMZn2Q90ZxQLo2nVOqmFFdeFtQHoCwGJI
 Z5lauB+kdqwMEuxq45HKchbHLjgwwVszL6YvT30SSn0uictywaBbFdH5WxfvxI5Vr9klY1YbggW
 LM6AfosUi9AHIhjmb88c8pB3rKD+ZTV3fnCzZfYyPXk2TaFSA
X-Received: by 2002:a05:7301:797:b0:34e:c001:1486 with SMTP id
 5a478bee46e88-369d973194cmr1101946eec.8.1792720300336; 
 Thu, 22 Oct 2026 18:51:40 -0700 (PDT)
X-Received: by 2002:a05:7301:797:b0:34e:c001:1486 with SMTP id
 5a478bee46e88-369d973194cmr1101921eec.8.1792720299744; 
 Thu, 22 Oct 2026 18:51:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 34/43] hw/intc: ciad should forward its mask to l2vic
Date: Thu, 22 Oct 2026 18:50:31 -0700
Message-Id: <20261023015040.2473105-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX+vLzxslxshHx
 YyG72btkOyYtaxJXcEiGpTaZePOmWx6tRkfLh6kLTlaUU0qNO7Z4DDETRTc97LQdafqmardlQcM
 eWBzz3u3WrPnKwFdHq0s+y0Eu1NnfK+XXL1vQ1K9V3OYiDMZLotD1vWcM0CyG6tLnbyvqMjIACK
 8LSvCpTWZJuYKDgf0o54INQAeQ/H/iEDiBs6vOa65F6r8ded6RZh6hvqRY6obcMbrK1Nu4EeDnx
 aS3adq1xXoVzfc0eM9NQog92E91vkMRzh+v043lKxVPGuAFjQMNxUDzYcp+EyWU/75Ba5sg3Hqg
 0+jtyVGcU9EPvTQErio9u0j6qZ3i9f7VaeAUr5ffSmLr+8Hu3HJaA0WChG4AMogYh+th2XHEpFC
 EgYs+5Ord1RgV/QlVCyLmE3EGxIWgeL/L/C9zSmzj8rEmKIm73B2MCk1rlI+BmDBXlFSgmt3Kvu
 c+l2VQ23kLC63n6eGtQ==
X-Proofpoint-GUID: _kEo4Hc9t3HhXGvm6O1-acR9SOCjjsqQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyRoTYU6GCh7j
 RWuwdvSgzQnwSGR1pqR3fQ1rKSGpn3eB5rbbFLWGHLFvMajRpMBiTEFutP5KVcIvANN7bN6I6ca
 sal+2dK/yVLHkFmxWNXm3fsp5pAucYk=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adabdad cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: _kEo4Hc9t3HhXGvm6O1-acR9SOCjjsqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
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

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9o
ZXgtbDJ2aWMuaCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysr
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRl
L2h3L2ludGMvaGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRj
L2hleC1sMnZpYy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2Ug
KmwydmljLCB1aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHZhbHVlKTsKIAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9u
ICovCi0gICAgdm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmlj
KTsKKyAgICAvKgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1
Y3Rpb24uCisgICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNr
bm93bGVkZ2VkLiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFz
ayBoYXMgdGhlIENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVs
aXZlcmVkIG9uLgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xh
c3M7CiAKIERFQ0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZp
Y191cGRhdGVfdmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAg
ICAgay0+dXBkYXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGlu
ZSB2b2lkIGwydmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitz
dGF0aWMgaW5saW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgbWFzaykKIHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lO
VEVSRkFDRV9HRVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7
CisgICAgay0+Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhX
X0lOVENfSEVYX0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9o
dy9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQK
LS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00
NDgsMTIgKzQ0OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9p
bXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwog
fQogCi1zdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4
TDJWaWNJbnRlcmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFy
X2ludGVycnVwdF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAg
IEhleEwyVklDU3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90
IHNpemUgPSBMMlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9p
cnEgPSBmaW5kX2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMt
PnZpZCA8IEwyVklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlk
LCBzLT5pbnRfc3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BV
IGludGVycnVwdCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sg
JiBCSVQoZ2V0X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQz
MihhY3RpdmVfaXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2Fs
bChzKTsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNzY5ZjU2ZTI0MjIuLjgyYzBjNmExNWYxIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTY4NiwyNiArMTY4NiwzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFj
a19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhF
TFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1
aW50MzJfdCBpYWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7
CiAKICAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAg
ICAgaWYgKGNwdS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAg
ICAgICAgIGlhZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhf
U1JFR19JQUQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJl
YWRJZCkgJiB+bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9i
YWxyZWdzLCBIRVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7Cisg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SUFELCBpYWQgJiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50
aHJlYWRJZCk7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAg
ICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CiAKLSAgICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAg
ICAgICAgICAgICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAg
ICAgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdh
c19zZXQgPSBpYWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURf
SUFELCBpYWQgJiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+
Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBlbmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2lu
dGVycnVwdChjcHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0
YWtlbiwgb3Igc2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVh
cl9pbnRlcnJ1cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRh
dGUoZW52KTsKIH0KIAotLSAKMi4zNC4xCgo=

