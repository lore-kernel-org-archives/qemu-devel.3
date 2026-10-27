Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2959606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kKYhFdri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WqEooqn7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtS-0003AT-1w; Mon, 26 Oct 2026 23:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtM-0002o1-7Q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtK-00006y-Cs
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F3171349057
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=; b=kKYhFdrihxhKsk/Q
 WeYrQrIv+nSCnR7DsM+UL4QXw+Xpt+ZUfQQrOwttlajDloTJWhzVkFbL7elwbxpc
 aYolIlXqKQ1BIOlRO4RgXexx5Dfd1LTFgh2FHh/8e18sJYHYdSP/6YGHA5VuqCzK
 ce8OAMb2cudMaHhIdK4AFMzdVrYSXl0WOuLVV+DM8hQt/2pcPjP3IRHFD6dVsE0H
 epI6WzmIHXbNWZjYoT+GGR5ZRUJcW+bHqY51sSFH/k0zzzl32ikoVk/BVtvh6v8x
 R1FpOw5UX9/UUdkN+wM6AfY/Yy5VEqxGbfDS1IHtp8OhIo6b6KyD3ouc+WBYBMSX
 WQ8SLA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbt8b22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so1722683c88.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071814; x=1793676614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=WqEooqn7DIuR8G2iopeyOYhsxzMwL1jThx5/Hf9Rcm4H+8sZEd4kLx/lvXXnuf8Mn8
 x9zmX6j6eI/8bPc5JoGwFLkhZngwC/RYcy5HGcnOgZVuDFMbpfJ1xpjDk4cWTvFATCsf
 3/9U6iw4K6fKolRjy8tqxmsZqvS7yBpBwXn9ytR0RLGsze83bvv03K9IPAtNtTeAII0p
 MSlfrZwv5djVKdVUOXKKPqpSN2SaA1yTSRIDO1RlNhgM0o9nfK+ONrXHIG8g5EfjDfC1
 Dhzl1+l9IXzDLpizYAdrsk418EgFtB0Rb1Er7fZewqUE+jjWWeMwE+8XCqiS5xm43Tu6
 HOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071814; x=1793676614;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=gGmnnNizHH+D7Kch8hRYWyCfimMRjQr70vHZ+der0JSBw7tdlyqlCVr0Mg0rRm3mIz
 Y5eaFLHKKAQAM9ontcuWFouVClKB3u/kUfPmBZy/vtRkhmOyVjOZ8EOni/A8RYr+CrqS
 73147Z27wEL/uEVT9nweXXYbvfFq1Nis6J6cqPbXRNrzrXh0KAPyBMEtQk6v45oIY2vQ
 ugdv/dphLDwwdG/L0+U6GYCM2vFrHwNjv399V2YhrhbubIF8YiVxEao0GZJx4ELw4g44
 RidbQzZC9zWCzg+xfTARGmRBW4oeN3nTQBDNyoSldKatHzTQzUW4mE4jo70Zz+g/4XEu
 8jJA==
X-Gm-Message-State: AFq9FYK5AXwtYFY+hlXCjXTKhUbjzjSe8aohgqlTWePLRGv2+VfO191Z
 GYcVyvPBbJRCKrbG0jx9gq2OYEVpBSJshvnIl8oPw/kF3zrMTrgmH+KcqLNeG3pqBmTn/8iOPcG
 P8gjGaEqqXPnYw1cZmRaoQ6eQRScm2a/uG06CjP0PzowjtXSd00wDlk3hK2D9HWJMsQ==
X-Gm-Gg: AYBFou0oO+5k40g0cZrX1SOhhlkN30UUzbYDCvcoflnyS0cJGxZY0Tk3WgDxgn9F6c1
 +np+9zncy/tYUsD2okwBqXlDbUoxIq/oDsYmtUvGCL+XCpaggSfH75jk5XaNjS8SxMN9IFoXSXu
 jgTGdtLKtlj9pavVYpZ3UEBjxwsAiMbqZQxTqcGvOCuaKTbFCZnRHlEDyp9oLPduEwj+LHvkWnJ
 68+TcixTfkX8z+2BEwwB+tx1LO5L6oLWu5Lj+96J891VpaKkBpXz5uAAF9HVaVakn3Jb3orF/ZR
 MgQ0sdCT0NIbjoPEImjaDHHKMnsLmcwBmnEcV/JJrCCT0VhpYuiK3HwQKO65jr1vwMjpfgk1+Z6
 N/HJb/9C2DqAQrOazScdlgW79OaCnd9Br1Bh/Z1CGZqYffzhV0oQ0N3CsFggSiPzeACU5BHItUT
 B6c/YbD4mMmongWGTCf8xA
X-Received: by 2002:a05:7022:ea8b:b0:19a:bbe8:41a8 with SMTP id
 a92af1059eb24-19abbe841d7mr10345849c88.20.1793071813893; 
 Mon, 26 Oct 2026 20:30:13 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8b:b0:19a:bbe8:41a8 with SMTP id
 a92af1059eb24-19abbe841d7mr10345819c88.20.1793071813348; 
 Mon, 26 Oct 2026 20:30:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 18/41] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Mon, 26 Oct 2026 20:29:04 -0700
Message-Id: <20261027032927.3055166-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX4TdmSNE8EK3q
 yrhO+TP+al81t+Tswmkiew9XY9zFMNralh+Eip2LPyMD0V3Ztmj47pAobH7dTUtcRbWx4yyJUjH
 QLczB/mZFlQWhTnWPt2HYqkXCCSKdNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX4kR49NkXlq1O
 vMblYOUzI0EmgZIESNbf9nRoq4Tq5KqSq8w4fqYjURIfYOZvMIxJA09OGiGa0xXb00QHVC/Twwp
 NsFqPJpIpzL4rdXQRGgaMU0IZOmR0IR4lQNUtuUoDbUjU6EArwPBgKH4/JzOORV0GPRG55dM2ba
 zhhERvXqNXuvJ5tSSvdy0Hh6Km0EiT7mscKsRvh9+E71R3qBAASU4FoT8fhX43Dbne+sDI1taON
 6OaTEvSQQPaWJ70MeVjkhkOBm/qgO/4gADQ8WRI28gY7gf1oWRVMObR2oy6n3UgLG38Ae4CJ7su
 4iedYHul5nXBAKdPJVBuZLbxDIiYtMvG4RzbVG2875570UUyfLECtMSXCNiU3VZsmvuU1e5Lg2h
 t3xh1Hh0U/ixcaLrlwD4vvViUmx37crVoL5nwgSgNRtlEhzNZ241Z7+lVzY8Zsyqkxx7g9sIwoh
 pfXUo2nErA2vYOgDc+Q==
X-Proofpoint-ORIG-GUID: DNp7Afwjwm9dCCtEnapvCwC4tlPvcM6d
X-Proofpoint-GUID: DNp7Afwjwm9dCCtEnapvCwC4tlPvcM6d
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae01ac6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggMmViYTYwMjFiNGMuLmZiNDZjMDUz
NjBjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjMwLDI2ICs2MzAsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
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

