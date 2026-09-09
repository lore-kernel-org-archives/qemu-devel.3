Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8BCC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49Ve-00073y-In; Wed, 09 Sep 2026 00:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VY-000719-Il
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:02:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VW-0003ub-46
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:02:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Mgb4a045678
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BrBdxT68N4Nms32imtrDfxNeGBV6eLc/P0sHicq1X6w=; b=GnqfuK0qZLqAEMUS
 ithVJsAzDRJ72S45ZNqqIZpr6ZUxRcZB8mnBt3jmz9yBib1Qcpw/XtVXsRWNRZIG
 IVckR1tb4z1Mm/oBh7BsKB53I+rgryIWq5b2n2Rx1ZNu5lGLRwLaYLEeKNVyKoOj
 otPjjPoUNAD8OS2rPAL2th3BmfUPzmbhLZ9asyhBoT57goQz1eeCAT3zsZszUlOP
 psIXD7i8aWSSFul7qDKjwdB5GeH2VjS5cLhuT5k8z/5JR33K92xRzVXPlj5cnRJ4
 K1NEw/90z28nlkpuzIudW0u0quTHMWjyGalXsNENuVOl4SVQz/HFHRW8vCuJneYZ
 EBHPHQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewhyvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:57 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7f66ceea676so7638414a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926516; x=1789531316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BrBdxT68N4Nms32imtrDfxNeGBV6eLc/P0sHicq1X6w=;
 b=Za76O/M8/+fEkupgw51Gf+ZzAJOiPd7tHp1brpYfUtdOtp/+3cbYpcybhsH+RAZKUD
 xT7INXClqxTcHF6x2wAIs4vPyuFvtNmpeNZ8qkYiwUYskjtRFOSlYVSxeYAYBs/JzA9E
 2pGlg/zGk4qAUL96ZM6y+TfHPBMWvC3q/xJlVTACWH28IyDModu/OhhzkI7NdFh6KDu1
 p/eNnJhwRXC3Wjoovsq8Wr2NRQL0ljoUGJfQZyq13NOiZD19TyiQMGknf/19Qe1RMm8V
 Y1fONx4h9ZYjbljWvdJuUWFsUEV2LK37dbv15BYKvjGkprJ7StJY57fBTQijf8OBAIIT
 lRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926516; x=1789531316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BrBdxT68N4Nms32imtrDfxNeGBV6eLc/P0sHicq1X6w=;
 b=KvVtX2QRbnBUkY1jLgOPjvG3te9kfmqslNg3oEnUIQ31MgvaYyUS46JzVWgebeqDoO
 k8BEOyMjwkxUz3bDZZ/gYIjXf8VdOWrAuAZYDifqTEKXcJoXGEPpZtiKJJnsVIt5tHNK
 qmy/8C3eWnZPuSC4vi06J2i/3g8CtGIwSk6vmFPI1S4+0JmelWFy9J8StNEPJJHe4yVr
 15SDnGNzOAJ1iBiQaJbtTT4vTT1dVVSnN5llb0mr6bu09fhO8/LRMr6/E3ri1Crwb6en
 b7LrH444ry2QYsPYSMP7zHTUi0GW8raBn17Eamovk9A9tBcXE74/pd2evE0GXb0dItLy
 x9bw==
X-Gm-Message-State: AFuF++nc2mNDfNYvJ3vsuQHITcgCa8oPd5e2C69Rqw4EbKe1z6/DLooc
 D0ESzhrk0304IaGYqrAyADYWAptELHMXzpsNmaXU7b28tzc6MrfLoojqY3Mp1nbjsG9ZZaDFqeg
 tiRmLTZ8pjWGFq0x4HWCCu2IJy2EfzETyuSjMebmGFuLt1xKNeLTUbKbbfG7IySpD/w==
X-Gm-Gg: AYBFou1EWAc8Lp0SFNCJwxHvWT3hFQWnSsHRZH0TTIMnwr03uxbb91VZoH3I3+a4uOA
 n7hkib4zCluU053gBWyBKVrw5oQcOnmdrwRdKS2mhj6PacRhqj4fT/NsO0MSCOQsphPuHDqwt50
 QnLZhZPEBg2WBNKLgAdSsZMfH7jgz5fsc1oh9kpxVnLNCwduG6lwsr54fhvsPwxkBIonaC3F877
 L2Ct4ahjFRZg1sYEmYU+BMEGn8BE3woADVOEvog0tUNbZw4XCSahklcPRNQ0Zk3gjPov8YSHv0X
 UWheKk9vTb9WYRKCYHnoCrw0Sf7gXLnhS8UMJNTZxHiFfgOGCyJbJ0raC7stfBDS8rFL61PQLYT
 yBLKGJIQRcKdaZO7Tyfs0xPSyF0p04KS2Hl5r3TN+l0th0upT
X-Received: by 2002:a05:6820:1508:b0:6b7:46fa:1692 with SMTP id
 006d021491bc7-6b746fa1a10mr17899291eaf.39.1788926516528; 
 Tue, 08 Sep 2026 21:01:56 -0700 (PDT)
X-Received: by 2002:a05:6820:1508:b0:6b7:46fa:1692 with SMTP id
 006d021491bc7-6b746fa1a10mr17899263eaf.39.1788926516118; 
 Tue, 08 Sep 2026 21:01:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 9/9] tests/functional: cover v81 system registers
Date: Tue,  8 Sep 2026 21:01:37 -0700
Message-Id: <20260909040137.3414132-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa0da35 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=woYTvO-ToS2AwZLC9vAA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: id0hKRo4l7nu2uiNImReE8ev_0EkQyOS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX5HCgEVzg+J4z
 w1srFxfeB+nTGoWd+7T+R5b4ZueSnf0wWeksQBwD7twGfkA7M5ozFHh6tWuPW16awi+WNyivNUq
 W11lYfzWUrsFY31gFvbx7MJHEjAKRCxJD8x9fe/G4VW2SlvwIEB/PAmkTK2f8vsxMH+gV3T252S
 DaCE8IHV984ynmq8Snn6aGCuXucJd+f+TroP8CM9FRXifvykIQp2MNI+NFciI56xJGSEmJTJD0l
 dT0n7TuUzyXrW/loJ7M19Xrg0lOTRK4ZlM3HNiU/A/HPwSqYdmnOR8NRAB1tmlm+Jcg4jHwwb0t
 hApC+YZiArn3WJjMx1AquXX3MFPdMrj3ySI/q+OA8/6Dl2d8jvyBmUJasUc+z+OY3OTzHTqAFkz
 990dcU4dwqPqh7TvGCNQxjzc7HoZwBJlZ+a6pVhlA7QaGzDt+VHRYs8ySw1pfzAnuXEf6MIEeqF
 d2kmKfpX4tsUq76crRQ==
X-Proofpoint-ORIG-GUID: id0hKRo4l7nu2uiNImReE8ev_0EkQyOS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX2tA4hSCbcw2O
 jpc046WMuhQUGKidwiZg5xG6kLC4NJUvLmlYHycjmqH/w6+Pl8jI1WsY1XwYV2XxYmfFVCSWhjP
 iN5iSpRiN15KBxl1fc76BFKFmNqOTlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAyMSArKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKaW5kZXggNWQ3Y2U0ODc0
MzYuLjQwZjc2ZTI1YWU2IDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVz
dF9hcmNoX3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hf
dGVzdHMucHkKQEAgLTI0LDYgKzI0LDExIEBAIGNsYXNzIEFyY2hUZXN0c1VhcnQoUWVtdVN5c3Rl
bVRlc3QpOgogICAgICAgICAiZG93bmxvYWQvdjAuMi4xNC9hcmNoX3Rlc3RzX3VhcnQudGFyLmd6
IiwKICAgICAgICAgImNlOTNjYjkwYjlkNzU3YzE5NDZkZmU4ZmU2YWJjZWM4MjkyYjA4YTY2NTQ2
YWM1MWIyZGQ0ODY1MGIwNWZhOTEiLAogICAgICkKKyAgICBBU1NFVF9TRU1JSE9TVElOR19UQVJC
QUxMID0gQXNzZXQoCisgICAgICAgICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1o
ZXhhZ29uLXRlc3RpbmcvcmVsZWFzZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMi45L2FyY2hf
dGVzdHNfc2VtaWhvc3RpbmcudGFyLmd6IiwKKyAgICAgICAgImYwY2U3MzFkYzhkYzJiODYxNzky
YjhiZDYwODA4Y2I3MTRmZDE5MjJjMGRjNzkzYWY2NTA5MGMwYmE1MjViYjAiLAorICAgICkKIAog
ICAgIGRlZiBydW5fdWFydF90ZXN0KHNlbGYsIHRlc3RfbmFtZTogc3RyLAogICAgICAgICAgICAg
ICAgICAgICAgIG1hY2hpbmU6IHN0ciA9ICJ2aXJ0IikgLT4gTm9uZToKQEAgLTQwLDYgKzQ1LDE4
IEBAIGRlZiBydW5fdWFydF90ZXN0KHNlbGYsIHRlc3RfbmFtZTogc3RyLAogICAgICAgICBzZWxm
LnZtLmxhdW5jaCgpCiAgICAgICAgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAiUEFT
UyIpCiAKKyAgICBkZWYgcnVuX3NlbWlob3N0aW5nX3Rlc3Qoc2VsZiwgdGVzdF9uYW1lOiBzdHIs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hY2hpbmU6IHN0ciA9ICJWODFRQV8xIikg
LT4gTm9uZToKKyAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQorICAgICAgICBzZWxm
LmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1NFTUlIT1NUSU5HX1RBUkJBTEwpCisgICAgICAg
IHRhcmdldF9iaW4gPSBzZWxmLnNjcmF0Y2hfZmlsZSgnYXJjaF90ZXN0c19zZW1paG9zdGluZ19w
YWNrYWdlJywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdiaW4nLCB0
ZXN0X25hbWUpCisgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoc2VtaWhvc3Rpbmc9VHJ1ZSkK
KyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCItZGlzcGxheSIsICJub25lIikKKyAgICAgICAgc2Vs
Zi5zZXRfdm1fYXJnKCIta2VybmVsIiwgdGFyZ2V0X2JpbikKKyAgICAgICAgc2VsZi52bS5sYXVu
Y2goKQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgIlBBU1MiKQorCiAg
ICAgZGVmIHRlc3RfZXhjZXB0aW9ucyhzZWxmKSAtPiBOb25lOgogICAgICAgICAiIiJUZXN0cyBl
eGNlcHRpb24gZGVsaXZlcnkgZm9yIHRyYXAgaW5zdHJ1Y3Rpb25zLCBwcml2aWxlZ2UKICAgICAg
ICAgdmlvbGF0aW9ucywgYW5kIHZlcmlmaWVzIFNTUiBjYXVzZSBjb2RlcyBhbmQgRUxSIHZhbHVl
cy4KQEAgLTc4LDYgKzk1LDEwIEBAIGRlZiB0ZXN0X3N5c19yZWdzKHNlbGYpIC0+IE5vbmU6CiAg
ICAgICAgICIiIlRlc3RzIHN5c3RlbSByZWdpc3RlcnMuIiIiCiAgICAgICAgIHNlbGYucnVuX3Vh
cnRfdGVzdCgidGVzdF9zeXNfcmVncyIpCiAKKyAgICBkZWYgdGVzdF9zeXNfcmVnc192ODEoc2Vs
ZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgVjgxLXNwZWNpZmljIHN5c3RlbSByZWdpc3Rl
ciBtYXNrcy4iIiIKKyAgICAgICAgc2VsZi5ydW5fc2VtaWhvc3RpbmdfdGVzdCgidGVzdF9zeXNf
cmVncyIpCisKICAgICBkZWYgdGVzdF90aHJlYWRzKHNlbGYpIC0+IE5vbmU6CiAgICAgICAgICIi
IlRlc3RzIGhhcmR3YXJlIHRocmVhZCBtYW5hZ2VtZW50OiBzdGFydC9zdG9wLCBNT0RFQ1RMIHN0
YXRlLAogICAgICAgICBwZXItdGhyZWFkIEhUSUQsIHNoYXJlZCBtZW1vcnksIHdhaXQvcmVzdW1l
LCBTVElEIHByaW9yaXR5LCBhbmQKLS0gCjIuMzQuMQoK

