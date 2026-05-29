Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3EBCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dr-0004j8-C5; Fri, 29 May 2026 17:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dp-0004Zz-Qz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Do-0000u7-1i
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2I8n589615
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DlKAtUgeKAnIofsVsDjszMdagkmHGeouDOhcnG+Rwqo=; b=BCdq1gEZ6dA3/bBB
 gFgZzQGhcjl5IUYB5D/Ks5jZ+tPq/ug6b4xzwX+GBAb9ZV9vc8KHrTgDxU8iUmOx
 oKSqHgaSPPOd700MogXVW+p8MNF7jzGcneJLJjOZ2lGJ6o9Hl/Gr47hcg2ycONUg
 iXNj5YV6aF3YBZ6q+ubiwUvG1PAY0reep4MgIeBWaK8HkpwiZ7jLPojJL5SGEgxh
 NA4GK/kEp6Hjbss3+IGiPuun3cjYvVNnhkXSu74M+svTjAnPuQtLIdsZh61XKptH
 nLu09avuDguU7dl4JsnfuZ2GB97/AxUP3kw4BqntsQddixcHkFSWqLErBaJT8xBT
 1H40yg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rckbw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304df51ff3eso2146252eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091906; x=1780696706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlKAtUgeKAnIofsVsDjszMdagkmHGeouDOhcnG+Rwqo=;
 b=Lig6HNlJvSmRY+3bMRP4HWms9kczNKP8HTFJg+Vtc8zZgGEgMgy/cMju8ALHm+/IG+
 b6NGPVs1xFG5lwXgYZLgZPWGlxptG0PrF+vywG3OrEyzs/UW5zx93CmOQKu0LO+CaUdJ
 rGfB3ij1A9e+jIaQM/+EIW6CbxeL+3uqHuF3ytaLCzLvKIrg5oYN/GRtYUnD8Kx3mxxI
 KOycmy0ewKhDi63BM5BR8NVqLwIB1KTBygBUUa8p6V3VVj8pZAEtJvP2Swh5r+clwvsu
 HDu0m9WciGBV/GM8OpvHv4TftrpzMRXsyy41VQOQoKKixHA8839carzNaBiofX9LOXFL
 aAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091906; x=1780696706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DlKAtUgeKAnIofsVsDjszMdagkmHGeouDOhcnG+Rwqo=;
 b=HuMLqUyzfj2MPzgMSThd4Z9J7xRdtaYa8FQYV4Lw2tkTkL4GL3r4wNmbWjNOp3onvX
 8JFAvGuDWp4xS2Kr3gtx0ueYTlqIR+wBWDF/oONqPNO1rni7lORAJ8hLa2QdqGgQpzdu
 3VP2GBO9HGfEzaN7b2AsNANiw33BZSZIMhsrBxg71qMZpjPFrhgEnV7MX84PC+Wn2nKj
 qBRmHbmICJQSPsTJDDWoIKUzlLAWXqc0x4Wg6WkszEj1UakZyH7fO3nO3hbBwtd+kEPe
 Ya/Je0yoEfB31YQ5Uv1ULonO+YP1zRo1h/3bkxqMSJuGATpzWRh4rdTc4dsMaRnvEQTA
 tDjw==
X-Gm-Message-State: AOJu0YwkFRwCkim1domBvzNK3hXEty89TWG4RwvClwKEXUWIRQ2X44lu
 Uea8LVbP4P58ykEfvgoqeLgYnb1PboHXQ9EyJ0bvDOmqLYv4o4EQWAET8djh22gdYq5AxIj4A4N
 aR4KhvPjkjIxYU12IWRq97QQyYxUyEqbkF8732T4wWYX922kSaZigvVrPpoRPtMstdg==
X-Gm-Gg: Acq92OFfSfd3fUYuUua1D3Bsl3gFexYIWnGIMDdpsxLKRNaULdQnr1aXIPV6lccXdFz
 X9lwsJzfGFWy9/T7UBJA4ntUdqUinbx6gJ2XBFm+tPkdkMyTA1Ywb1yS74NcXo9sPDNqV+Zwy55
 1j0naXJep0mdB7G48ndgAI4r3i+p8GHcOJQvu/G8+6qRinA3Ar+BbGevrsupxgbxSO6S7GxpdW3
 ECKwdjpDd3jIGVU5Sy8WmfElQRbKScIC1tTD9QF3sHA15LIXMwfR6TT02DWZCZUlDMOdv0+vJud
 G2+OnFaDJYD0OKjwFC83JE8UYj16mLsJUQ5VX5WDkHzWTWjaHg5aiV4QihgOhMhuKneIxVI0Ied
 o6o5YSyewkpTacQ/AjUSkjwuCgji0ySDHHOcCY978re4FPHi0AKSVpJ0glwI7Q5eAe0mGJ6OGKp
 Zl7x5S
X-Received: by 2002:a05:7301:580b:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-304fa510f4fmr850679eec.11.1780091905940; 
 Fri, 29 May 2026 14:58:25 -0700 (PDT)
X-Received: by 2002:a05:7301:580b:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-304fa510f4fmr850659eec.11.1780091905403; 
 Fri, 29 May 2026 14:58:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v5 11/28] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Fri, 29 May 2026 14:57:49 -0700
Message-Id: <20260529215806.608770-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KU8Q4uYIF1yLZTwwYTaS0nvxgx9B89ul
X-Proofpoint-ORIG-GUID: KU8Q4uYIF1yLZTwwYTaS0nvxgx9B89ul
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1a0c02 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX0I4iXVW+pZlI
 1jh/QmUH0bbiPrkjsvLosK3E9pzDSAvrv8PW7A+MB5R7T6c1A4531OPL3i456LUpKGhOFup3hEf
 ISD1sltmnD+lKPBmpbvCCe7sDenuPjUZOndD90yjGD0T4Xhy7a/A/1UfloR7PI6hwHP6G77grqD
 bIlq0AZ4FF82QjEL8ZaYKdpRVWL8L9QY87HQxNr0AZkUuhHv/unb2coJp17TnsW5dT/UwRY/Len
 GbGOTHO/mYZ82npvX5FXpJJU//BPKpfQXtu6VrJN3cZMopXoqeHwduawQ7QiotqUNuUqsJuwemX
 axIhzUVwcS0zmhrEdWML6LF1vzbeEKFKJKeI0womT9aOPCA6P2Ty4QfDs6RE8qkb4XEIzDk/YnE
 C4aK4xTRFyHW9rFjrm1+M5erbs/cS1SUeT8Z+rFQdi//0e52e3mxcTlGqMA5vkclzEPdk5phu7o
 LHrK+MYRyFeG+L4yUjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4
IGYwODY1MDIwMzZjLi5iNGNmNDdjZGY3ZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ5NSw2ICs0OTUsMTIgQEAgc3RhdGlj
IGJvb2wgaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJy
dXB0X3JlcXVlc3QpCiAgICAgcmV0dXJuIGZhbHNlOwogfQogCitzdGF0aWMgdmFkZHIgaGV4YWdv
bl9wb2ludGVyX3dyYXAoQ1BVU3RhdGUgKmNzLCBpbnQgbW11X2lkeCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2YWRkciByZXN1bHQsIHZhZGRyIGJhc2UpCit7CisgICAgcmV0
dXJuIHJlc3VsdDsKK30KKwogI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdv
bl90Y2dfb3BzID0gewpAQCAtNTA5LDYgKzUxNSw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMg
aGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5tbXVfaW5kZXggPSBoZXhhZ29uX2NwdV9tbXVfaW5k
ZXgsCiAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKICAgICAuY3B1X2V4ZWNfaW50ZXJy
dXB0ID0gaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQsCisgICAgLnBvaW50ZXJfd3JhcCA9IGhl
eGFnb25fcG9pbnRlcl93cmFwLAorICAgIC5jcHVfZXhlY19yZXNldCA9IGNwdV9yZXNldCwKICNl
bmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLwogfTsKIAotLSAKMi4zNC4xCgo=

