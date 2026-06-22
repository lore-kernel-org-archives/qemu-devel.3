Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9101CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndM-000366-KI; Mon, 22 Jun 2026 19:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndI-000328-4Q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndG-0002YI-5j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaGKC1542291
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=; b=YSauVfHXE4UOgF4t
 K3oWjjzFI+3TRzmtxX56HgCj2WQ6u76JKgTEc//Qq0uSuDG1T2GXJTGBxuoMYzj9
 s4Wr31rhn83r54a81+NvK74qjQKKUxd+2KX6BAy1Rl8SC59t8RlD0y4RuOheoLGa
 vrW2SSjQFR6xws7af3MSWL+vjkTReiAVugQH4xIfProqI++kRYigSkMjXwx+Z/WA
 3BWV0fvjij3hmRsbEsuH49bqCw3djBGhpIiSVMg5d6jUCM3uyOp+XaG7+8rMpfLw
 BgD8u8v/2Rr23YSfdU6w2CiN+jFFxMFaP7gGtEWtbAyY/pZcw6weOkydy+3BcmA/
 dpuAhA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0tjgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso21359274c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169244; x=1782774044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=OeWcXaR+Wns42B7Ce/LHNxi6ptqFX8DorgGv23oE/Lbh0gfcPJbOI8mNQqOerTE5Dz
 68rlvIaG+P1hDr25oJTq+xPRhhjafU01jdLddwuUNQOgmJWzAp7t00xkzB5cFJW331/O
 gNeYZWNZEXkEdgwyJNlgcEwbalkIZBBrJJIhf6tjxT0du5qkaky10esjIV4qpVoz+cTA
 zIJvWMXDqGNJP2EzBbkdvcVWgc0G+affqzd8WymCImnikaEHRSwP8cU07Kdmm7wfW2Lz
 ys186Ax+pUfKJJk4myQp3O1EsJYFwzPLZRgSBPvaHx5RDag21Rm/rK7N2GND/BpDI4Z0
 OG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169244; x=1782774044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=mXXkK2SB3bjTUbvh91eAwJU8ddDZ9wOfVz00nlA9UdWR8Yva7/OmvC2ULlMyeUXVxG
 hELZ0j+KEJ8rI3KHORzsk8ysZH4T++ziF/OVQlknnLvzPdsaYjxQt8stz9dQG0l/+PRc
 VYD74kShO77/OIdJdlcz3xE7KbPzXvP3+spC68rsDythavUReNPCBsNPDljAAohePRoz
 RJKM26dQ8F2GT6FkgKUThaXcBYLK0ChBR/aGZ96hK5EnhGWchAkS9vlaZh/1Ejp4VBVR
 Yk62OJc38NFGnEKOvovpEVU2p2Tp/QF4UG41CyXieaFAUv/6hZ+aZYGwUCKagUf2/ReY
 kPpA==
X-Gm-Message-State: AOJu0YyFLqG75qD2g0gFM6Xdm7GLR22T8eerkOELUmvaRybEY0gWaXZp
 xLkpvK8OwZPiCRSXyRUHitNRmuufNB2jjfIIWQ+GmGR1Y5O8wyygOIGVlUkHkmvqhua6y/qmj4P
 yGexx4wFye2spzKb11GOrmKafR0Jq0GWkKFQQljC91+D2X2pkK1rqjMzhO8JoxnN+KA==
X-Gm-Gg: AfdE7clEf0zbK/oRPdZlvYvWj5mD7B7fZEBIF8kYxPlmmvwXk8IKP5z2R5HEIhHI3K1
 WaxnB3XlwTNgZcQw9tgsF7vpovxbRK9qex1pOvKYWvU4x+N5XFMzifZb1zkcuZM/jY78viOVoyO
 1bNS6Jf5G+Y8tucGNylDYy3B5qizKobhw1dgnLJA7tEg2hJp8KkhmRip2Kcr0GoHjvY3t4SrBea
 N6wydTJuVW4r/kHTGws2mCm8pGZPNmb30z97StBjo8rzaDK5ptH0uZ4AWB3eOYxDo70ZoVks60i
 iSxYs7Nk73LjM15eDI9PfsM4JD83tOvrtx6YatgMV4H1bARdzeM8WKA4WVC/rzZ1CejtDVOPTz4
 vR5cWpPcm9hTnlvVTZbe030JvO4HJDIZhhikUKNmLFUba35oAGe1p8Ckr8lI=
X-Received: by 2002:a05:7022:98d:b0:138:35da:3cc3 with SMTP id
 a92af1059eb24-139a3686db5mr9921311c88.30.1782169243976; 
 Mon, 22 Jun 2026 16:00:43 -0700 (PDT)
X-Received: by 2002:a05:7022:98d:b0:138:35da:3cc3 with SMTP id
 a92af1059eb24-139a3686db5mr9921282c88.30.1782169243468; 
 Mon, 22 Jun 2026 16:00:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 64/75] target/hexagon: Add support for loadw_phys
Date: Mon, 22 Jun 2026 15:28:53 -0700
Message-Id: <20260622222904.607771-65-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/VqjAD1RsTuy
 hIBK7GydPwA0WDy+1O6i9ylu/7aL6kDAiL0iLRKM1Ht1egyrR76TVCflAPbJlwULPpRtOpNbF3G
 FgWJkEbXtls2oWsyJrFDjdArdybVGWg=
X-Proofpoint-GUID: 00DGpPPJRcBLLmZZ1Ndk2Bzw_zGD57qn
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39be9c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX1D6+NRBfs3zk
 WxTa89aarXzoGXoZIcj1mIbL6IVIVHFfAQ9dfBX+tZtdAuyVPIvR1uZgowyLSL2KTHPCKjrO9ae
 wUHE0Ee5VX0mpc/fy3eRAt2/GPj/a6HUmdZljE13t68Ax7a8dDibwifKH9V6ocopqyYI+5DsT5t
 bfqd3SzH4ioDbqY8oA4OVigGZzx9PBTk+4dEcWie0BYgpt49azCw4sJapJDo0npzjyKs625uLRn
 Ux/JiPTIkF5w9J3tYUJ3ufiXG+o3yeDIw+kPuTzIi4OrxjNYZyEFAHMS64u+B4rc+qZEFJyzoBQ
 J0xFVEOaUmIysunm5zWC9Ll8B7N5VhrbbvHHDcoXT8HSK1TSQMf032N55uC9tn08Z7vPcax7nl8
 zhM578TT8QIflvOvYJ3Y5nvt2ULxiqY2JBT/esDzOFH7gpvd84jd24nL6IQH3ylKG5TUCLI/whe
 80TBL0UMHZs5Iw9Uyjg==
X-Proofpoint-ORIG-GUID: 00DGpPPJRcBLLmZZ1Ndk2Bzw_zGD57qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IGFjYWFhM2M5NDRhLi5kOTFhNjUzYzNkNCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

