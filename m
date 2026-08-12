Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21249C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2VH-0008Tp-Bm; Wed, 12 Aug 2026 02:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Ud-00080q-Lr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Ua-0003us-RK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62cLT2190414
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=; b=cTxszbhW14xxv1Uc
 RE9JjSXnMmAAtxyAMQ7HXUJQryALfAT0kTu42u4eRCACvy+2goThcy4Cswo9Pyz4
 7DJIAm/HIK6ZNykL6iQ95VjKgdnoAtNEaWCi9cQ2ox5Fn/ZuwKszYbO6imi3nzV1
 3qmk2jgc37EMyvOB9ok5BQ6pb1dXufQQ40pbeI9vIaxvymwhYGqJcHh4ZKub0Nxj
 HrBZhBGxACyoW/8ab47XE9YQnguLE42aFanat4K2KLakOZBWsZW5j5xx2w3Xo9LX
 NhqDmXddD9khnZvu/TbRuNmZ9Iedl0FuO1smPvsyagxgpeTjSbzDuh+j/ljIH37I
 ABICRQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g3t5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:31:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so878158a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516260; x=1787121060; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=;
 b=eRe8DHWiI2O7GMWxx5Xq3NZexk8m4/updGz/FsS+rMLzYU6ajGvAmxuu+7uGUbQ9Fl
 78STy1QPagJ5MOg3djGUV2Eg2NGqINEddKCKHvCNoLxmTcXlP47tAZeJsx2Jxoh/uYTY
 rZr1UpreF2Cc8bGXp0Z4Fq3fMosIXBUB8HlTo9m8lp19/XqbAxFzjSufl5CkexGHyU04
 jbIZtMKko0cFTUgn5TH+Sy8+dT2ezJ8ZZDJRvxe0b6o4NjXMLjylkvb3R27JfqL0H6Pi
 yrV9ds+0MhyEwfHwwR9bPBR23Y3sgmyb/b2akv3ZJNKMHY/ADs01toMahH56pqXEWUDW
 3WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516260; x=1787121060;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=;
 b=ekhh6YJpp2QtPsTKMUWyx4T9JITo2GqHZxF2CgNKem/E6uuQ0cuhli1gi9Vtgv8SDq
 hnbaNjbZC4B1ORDYmssDa8xwqJiRTn54T7BDmM/7Y1zX3ZW2cmYDmBOfwgq+Vb57hdB9
 P1w2DZBmATi62RlRjsi6dSdU98+KojOSDcJQyPfcdLvrkVaZ+yaVt+zBv8DrLK2yv51I
 Maw8TFfbl0aUgao/EkO/HtveELFCfDFIXMmMGIrPzNtN6KaKUUSZaU3uiWC6jO7JqN18
 oUfQM48tfU8b3zNW+iNWMRslxW32EO3u0J6jRIXyUijyQ3ilpD9h8YR6S29sMr5N2bVu
 iYww==
X-Gm-Message-State: AOJu0YwD25H3NMIibLhXPkDV5qs+nLNy15a+zT96UTUDyUPaA76LbspF
 q2f4MOOVtDuFFO+WKEHPAwyHdl8Zt+HzDhxFuo6XYeMNK5MTIqMXeUG4cgGlBhIm7HKws4ghGq0
 n5nIUrToVVou0uuEkhWTYcSUjUeJozXwTT4IhxjeseWCQtYfTHg0NgH5QgoxmoqWZsA==
X-Gm-Gg: AR+sD109W1H5/1SDQREwqIcYJCwBxbEQVNXY8Z92Ary6llGCVyG93bcQNxUEwlgfKiE
 aPVEeN5Six4bQTu6y4qaKGY3XfqIpnFPJb8zuRFPiJbrVz4Gi6Z+QoCckNzY1dtqYOL4peo3kAt
 FrjvE4xBCoK8j0+TWHJLF7Jc9Qgl+sqh53YjWERnEO1LxtfGwQTKrwglFAL904B1Aq4lqV0j8dY
 BZcKYH+a7ZjKmqlNYmYCh7wWWqe1L6EF74vFarWeFIEur19b0yc/EuZkSNBkfu2fMSZ/7GP91V0
 MMJgEX3fuF014Aa5jF5i1C5CMnB5AhBfkNcUtWWVFwPFOCOtN/odxVCATQ7SmMEY5dk9YA0nkLx
 BJ4+ZBguAMhkLVK5z+8oAOsMviFi31g7aSmT75nsfA99f2u/H
X-Received: by 2002:a17:90b:520a:b0:38e:8021:2ea9 with SMTP id
 98e67ed59e1d1-393017b1e79mr3256180a91.19.1786516259683; 
 Tue, 11 Aug 2026 23:30:59 -0700 (PDT)
X-Received: by 2002:a17:90b:520a:b0:38e:8021:2ea9 with SMTP id
 98e67ed59e1d1-393017b1e79mr3256134a91.19.1786516259195; 
 Tue, 11 Aug 2026 23:30:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 33/41] target/hexagon: add v68 HVX IEEE float misc insns
Date: Tue, 11 Aug 2026 23:29:24 -0700
Message-Id: <20260812062932.543840-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: SM8FHIAYebnVisxdXiI9loX37jdWnRYB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXylKfeB7S7PWN
 MGII37rhZ1ZOTncfGxB3meip3Vzgt8V9AmaYAmtPUrL2daBTFHFS08y7T7yQ+4SsXcHiIc0lY06
 S3wmdEYLANuHZDes/rC28ZhJgV+xXAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX2XXROoSMdYYm
 CrEk1F3IZzPKqLctsPPjm7XYe0TIrRow3E12i/hfbS6+T/3lVEgDeLU9UjlFlkEmVkpokghAk6Z
 LbQ1ickChvNPO1TjsS8+lpeeAGtDq32bJzj/G71o3eoCjc2Ar1cA7VLK5nQP0Mc6LQOicBoZcuz
 q0I2de34bGGKKPDTZHfUm5bfGAD3pY9ZPdTzLHjxNwgEoPE/BR5P6Y1dFRwE1dX/ga63VKMAMiL
 B/XHVHccl0fCSwSzJR2PqY5KECAf9D4AlHGq2R5tOCb1CyHoX6luUlPhQJKhpSdkcR1TkfWu0PT
 cg6snA+8SEqgb4sexNuFAWI5QLU+6hsmysb4fWRiHjL6mEw3TzQg7s5SsJlyZxwCtkn7jvhCCqt
 L0s8k3oShq8r4sTMrlbdBWxBCgBM3Yt/AV4gDHT/6xoNZBkUtqWlmwMQyoFa+H15aW7+Qkg1q0O
 LZinwSz5DicBGQZZUcg==
X-Proofpoint-ORIG-GUID: SM8FHIAYebnVisxdXiI9loX37jdWnRYB
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7c1324 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=G0yDBwImisZ_IgVzhjkA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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
cXVhbGNvbW0uY29tPgoKQWRkIEhWWCBJRUVFIGZsb2F0aW5nLXBvaW50IG1pc2NlbGxhbmVvdXMg
aW5zdHJ1Y3Rpb25zOgotIHZhc3NpZ25fZnAgKHZmbXYpOiB2ZWN0b3IgbW92ZQotIHZmbmVnX2hm
LCB2Zm5lZ19zZjogdmVjdG9yIGZsb2F0aW5nLXBvaW50IG5lZ2F0ZQotIHZhYnNfaGYsIHZhYnNf
c2Y6IHZlY3RvciBhYnNvbHV0ZSB2YWx1ZQoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxs
dGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBC
ZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8wYmQzMjc5Y2EwYmJmN2MwMTU0OGUzYjRlN2E5
YzhmZGJkYmU0ZWUxLjE3NzYzMzk0NTEuZ2l0Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNv
bW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiB8
ICA3ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmICAgICAg
IHwgMTIgKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiBi
L3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmCmluZGV4IGQ3ZjUw
ZGI3Nzg1Li43MmRhZjg3MjRjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
bW12ZWMvZW5jb2RlX2V4dC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMv
ZW5jb2RlX2V4dC5kZWYKQEAgLTgzMyw0ICs4MzMsMTEgQEAgREVGX0VOQyhWNl92bWluX3NmLCIw
MDAxMTExMTExMHZ2dnZ2UFAxdXV1dXUwMTBkZGRkZCIpCiBERUZfRU5DKFY2X3ZtYXhfaGYsIjAw
MDExMTExMTEwdnZ2dnZQUDF1dXV1dTAxMWRkZGRkIikKIERFRl9FTkMoVjZfdm1pbl9oZiwiMDAw
MTExMTExMTB2dnZ2dlBQMXV1dXV1MTAwZGRkZGQiKQogCisvKiBJRUVFIEZQIG1vdmUsIG5lZ2F0
ZSwgYWJzIGluc3RydWN0aW9ucyAqLworREVGX0VOQyhWNl92YXNzaWduX2ZwLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMDFkZGRkZCIpCitERUZfRU5DKFY2X3ZmbmVnX2hmLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMTBkZGRkZCIpCitERUZfRU5DKFY2X3ZmbmVnX3NmLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMTFkZGRkZCIpCitERUZfRU5DKFY2X3ZhYnNfaGYsIjAwMDExMTEwLS0w
LTAxMTBQUDF1dXV1dTEwMGRkZGRkIikKK0RFRl9FTkMoVjZfdmFic19zZiwiMDAwMTExMTAtLTAt
MDExMFBQMXV1dXV1MTAxZGRkZGQiKQorCiAjZW5kaWYgLyogTk8gTU1WRUMgKi8KZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmIGIvdGFyZ2V0L2hleGFn
b24vaW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYKaW5kZXggMGU5Y2FjZTIwMzUuLjFiMTZlZDA2Mjhh
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9leHQuaWRlZgorKysg
Yi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9leHQuaWRlZgpAQCAtMzAzNCw2ICszMDM0
LDE4IEBAIElURVJBVE9SX0lOU05fQU5ZX1NMT1RfMlNSQygxNix2bWluX2hmLCJWZDMyLmhmPXZt
aW4oVnUzMi5oZixWdjMyLmhmKSIsIFwKICAgICAiVmVjdG9yIG1pbiBvZiBoZiBpbnB1dCIsIFZk
Vi5oZltpXSA9IHFmX21pbl9oZihWdVYuaGZbaV0sIFZ2Vi5oZltpXSwgXAogCSZlbnYtPmh2eF9m
cF9zdGF0dXMpKQogCisvKiBJRUVFIEZQIG1vdmUsIG5lZ2F0ZSwgYWJzIGluc3RydWN0aW9ucyAq
LworSVRFUkFUT1JfSU5TTl9JRUVFX0ZQXzE2XzMyX0xBVEUoMzIsIHZhc3NpZ25fZnAsICJWZDMy
Lnc9dmZtdihWdTMyLncpIiwgXAorICAgICJWZWN0b3IgSUVFRSBtb3ZlIiwgVmRWLndbaV0gID0g
VnVWLndbaV0pCitJVEVSQVRPUl9JTlNOX0lFRUVfRlBfMTZfMzJfTEFURSgxNiwgdmZuZWdfaGYs
ICJWZDMyLmhmPXZmbmVnKFZ1MzIuaGYpIiwgXAorICAgICJWZWN0b3IgSUVFRSBuZWc6IGhmIiwg
VmRWLmhmW2ldID0gZmxvYXQxNl9jaHMoVnVWLmhmW2ldKSkKK0lURVJBVE9SX0lOU05fSUVFRV9G
UF8xNl8zMl9MQVRFKDMyLCB2Zm5lZ19zZiwgIlZkMzIuc2Y9dmZuZWcoVnUzMi5zZikiLCBcCisg
ICAgIlZlY3RvciBJRUVFIG5lZzogc2YiLCBWZFYuc2ZbaV0gPSBmbG9hdDMyX2NocyhWdVYuc2Zb
aV0pKQorSVRFUkFUT1JfSU5TTl9JRUVFX0ZQXzE2XzMyX0xBVEUoMTYsIHZhYnNfaGYsICAiVmQz
Mi5oZj12YWJzKFZ1MzIuaGYpIiwgXAorICAgICJWZWN0b3IgSUVFRSBhYnM6IGhmIiwgVmRWLmhm
W2ldID0gZmxvYXQxNl9hYnMoVnVWLmhmW2ldKSkKK0lURVJBVE9SX0lOU05fSUVFRV9GUF8xNl8z
Ml9MQVRFKDMyLCB2YWJzX3NmLCAgIlZkMzIuc2Y9dmFicyhWdTMyLnNmKSIsIFwKKyAgICAiVmVj
dG9yIElFRUUgYWJzOiBzZiIsIFZkVi5zZltpXSA9IGZsb2F0MzJfYWJzKFZ1Vi5zZltpXSkpCisK
IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioKICBERUJVRyBWZWN0b3IvUmVnaXN0ZXIgUHJpbnRpbmcK
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovCi0tIAoyLjM0LjEKCg==

