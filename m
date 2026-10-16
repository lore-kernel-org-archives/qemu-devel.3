Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3243CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHix0-0004ob-Fd; Fri, 16 Oct 2026 10:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwx-0004nc-Hd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwv-0007ej-Ak
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ajW1613245
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=; b=VG5z11j7MkCMNKzl
 CDJ+2HZCXGlcyn2paH3VSjc+7ZARlyTSsYD7/Ox54Nupiat3/9DQn6NMS+PyZyJq
 6hWw1l15yGeAPd4x92nbgQN4rzXxIgR/HX2Y8bN5L4REVYo2lC4UPr7O/G2TSCNU
 FTv2xhJ5JVaahAUaq3PzZOcAQhyHDypEZYavWq/WTwg9hv2OAWQU/axP14nrYshB
 rS52SCdaFjKAv2piM+FjAU4vpVFctX9F4mH0pjyml4Ni8lgufAO0Y/C58iNxad30
 RnDCPLm9zvXqxVOX0JNix/MKzHXkEPJ0yErwe3tyCpxed1bCTdqdeUhLWhn2fQYp
 wiwqww==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v0m5v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5de9d3d00acso2940191e0c.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792161019; x=1792765819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=;
 b=L4atZeIaYnAFvoXyjJIxieQEAdc8nwz5H1cHn4dblgMWMPBqOBscY9QY7u3mbG8gs3
 0mjr0vXkn4RYpEi+SkXsViWLUHJs6ueeWVsUEcu7EVXnO5kCvMrwvlBXtS6kRqxI+IDy
 9Rq4X5ZhZogxzXWmbMp0bnLb6TSO6W4/5rS07oC4M8XIigj4OgV00ZkBTJPbBeWziDPM
 hTA7U47JyS8Pk8tINspzJWV2staO8YSFC3ChQRmUewq5Fe50PzUDB3E8NLK6dNR0Q3cJ
 Yrxak3j0yS+7x27LumnDJ8BZEUf0vH4+Sw51EFp7zquDtG0FI3VwwRL+mdJ7rJLIzjPe
 Ve7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161019; x=1792765819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=;
 b=1yuo+kue2SRHqByP4llAhQjwZslvZ/5vrK+o5h4LVcN4zOk2kzd14pi2Bp1FFk7tby
 OAqvKX8m8WkWOefuT6K2dOKV1w+IncHKwld5Bet3/p45bQDFTvUISwUe+VwB9y1Pz2/4
 fsL7qeUE6R5RZGp2zG8smZaF6uRton3Hb6UzrEfwEuhRQCx75Ar1pSeTetnVfA3W4Fsi
 +Hl9CKvc0T14xEcUwpoLT3kW/iufi7/edTyMYZ63uKjT6Gdj21viQWCnrMRD69/xrdNn
 8noLNsmBKv8kCSqXf259r6fzCUpU5LEy7+H+B4isbLH4AiunrhKDf8/nX5sNTpUCvmFN
 MQ4Q==
X-Gm-Message-State: AFq9FYLwq5sEWeNzB1obRoxocp24K8tCG7Nb8MRRpXckO4JWDRm7Aovr
 MoW0b8if0mincRnIOdNo00J3cQnbrdLLip4q5VDOEDJMaFQHaEEl/tBtCDAN8t9yJxqlu0n59O6
 /BWt3k6z1DgI+sFyTkKd0VlFsFGRn9gDbKizzm0yEC2L27fmTmqT0dnuoADaiR1E+1g==
X-Gm-Gg: AYBFou3QFWyzaCDpzlOTlcuiwJHQ+GStdRV8MpIVsG2Ra/nLMrTaUhn1JValwUBO3/1
 68XVkXMfxMaYMZxdBCV+kVDrw139x/uQft7R+6k60/WJwd+HCiBk3yCXG41G9KD7lWbwAKFNtSC
 n2ete69/voVeJZbE66jESA2e9AZ1OCUfuUboUOe6aGmFm3UyMJjjf2fO0L/zX5hpo0WPoCIMTD0
 cQCToWdDrXyzMyNJtUuh4Rf/kG8ofBtb/R4m32KHSHrMfLeWPbED9KoIv+pgQjUwNYjfbYdeb2h
 lnfRCwolMP8SRdZInvhBA0E1TaYQ/hAXAjKF646cGOPpptHOf9JISfEupAyQwj0rb5hhrxg8nsW
 dRlVJ/TnXNNyXICS1PLW8SfYpPJFSZHX5exX6OioF6tQlgZA=
X-Received: by 2002:a05:6122:3a03:b0:5e9:fe71:58e4 with SMTP id
 71dfb90a1353d-5eaaadcc42bmr89157e0c.23.1792161018909; 
 Fri, 16 Oct 2026 07:30:18 -0700 (PDT)
X-Received: by 2002:a05:6122:3a03:b0:5e9:fe71:58e4 with SMTP id
 71dfb90a1353d-5eaaadcc42bmr89127e0c.23.1792161018421; 
 Fri, 16 Oct 2026 07:30:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b474b2asm1605214e0c.4.2026.10.16.07.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:30:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v4 4/4] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Fri, 16 Oct 2026 07:30:07 -0700
Message-Id: <20261016143007.3474704-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
References: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: kOEApouXSZXcWvb90XNzvA8hBQwOHUvk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX53KI/zCc8T4O
 TyRICSOFAEhWzZDSYD56Guji7av6yBKZdbuExFshcWFsNsc7Qc0UBfzo1zKdlxWRIfsiiTGUHXo
 hA1ixV3ltlaE1eneIU/Bzac9rsTmtXg=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad234fb cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX18I5vQEFjsBq
 MZKsYjyQSr6w8eEZ9xHrri/SZt3H49FyDzOARbuS4NVW+eHKl/n9c2gHefCc9pY8MznrJROIkGV
 djqS7duCngj1RJtHvRLaUkQjREqsYB/Pv7v1oh7HIcg+8IbKRaNWJ0Ql2XiLvZBOV8Tic3sdjs2
 RlEoC+NAgkMWK4n3oyz3zOFvfKc3UbzzPWcZvze7ZD/PLMrRObtn6fMPlexYHCyJqFyrllvk4Dt
 NwKZM/t4DO1azTRRBOq58oGkjtOOlF0Vz4qopyc3XjC9YZTBKqSTdaiEVyre9fKgHU6ao711YcR
 ++2nWoeiT5hczyiOC5Qw9Uvns3XFvoeX9dqByRB+drRgXRDL+mdqeH3o7/LPJ2mAhXcnyOhh+G/
 MjxvEpJdAzG0WB86TQzibEBzmC8ryJUJAI3uyCFTM2XR/3iu3X+kecGq3PqXA/wh72HoBF/2zUG
 zLHzWyjCOc6RiTUWUcw==
X-Proofpoint-ORIG-GUID: kOEApouXSZXcWvb90XNzvA8hBQwOHUvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160057
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggYTVjOGVlMjdjN2UuLjlmZjcyMjUz
Mzg1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjI2LDI2ICs2MjYsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
ZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19BQ0NFU1M6
CiAgICAgewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZp
bGVuYW1lOwogICAgICAgICB1aW50MzJfdCBGaWxlTmFtZUFkZHI7CiAgICAgICAgIHVpbnQzMl90
IEJ1ZmZlck1vZGU7Ci0gICAgICAgIGludCByYzsKLQotICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgIGludCByYywgZXJyOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIoRmlsZU5hbWVBZGRy
LCBzd2lfaW5mbykgfHwKICAgICAgICAgICAgIGdldF91c2VyX3UzMihCdWZmZXJNb2RlLCBzd2lf
aW5mbyArIDQpKSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9Ci0gICAg
ICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtpXSwgRmlsZU5h
bWVBZGRyICsgaSkpIHsKLSAgICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAg
ICAgfQotICAgICAgICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYg
KGZpbGVuYW1lW2kgLSAxXSkpOwotICAgICAgICBmaWxlbmFtZVtpXSA9IDA7CisgICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhGaWxlTmFtZUFkZHIpOworICAgICAgICBpZiAoIWZp
bGVuYW1lKSB7CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CiAgICAgICAgIHJjID0gYWNjZXNzKGZpbGVuYW1lLCBCdWZm
ZXJNb2RlKTsKLSAgICAgICAgc2VtaV9jYihjcywgcmMsICByYyA9PSAwID8gMCA6IGVycm5vKTsK
KyAgICAgICAgZXJyID0gZXJybm87CisgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBGaWxl
TmFtZUFkZHIsIDApOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJy
KTsKICAgICB9CiAgICAgYnJlYWs7CiAKLS0gCjIuMzQuMQoK

