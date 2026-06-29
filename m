Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A17C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEIZ-0007rM-IN; Mon, 29 Jun 2026 11:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEIX-0007nt-Lh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:53:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEIV-0000qw-4Y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:53:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATTu02592877
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ITNT7yo4DFCTc1ZU6zg4y9fwGqIeCMpk3aKkrfrQ1pc=; b=o54GDdGSvAmOFtB3
 9DAU2WiX0rbC2EstlaVTuZiCkYgDTXWcm3c4YhAItxt2uqm7NKRXU1ug84yLP4n9
 6hrUNfQQXJZzMupYow2gmLI2xTA2/traC5Wv38YyGos8cWGz58LM3qRaBPUCLu5w
 7ObT9ytUjUnujZ0cMUpQ69uT/07M/rfFl1Ls6gHc1pA5kSRgp2WPoobWndASp492
 HFCSmXmCenHwxrFG5L/V62c62W0yBn6epDEV91xF6frJAV6qGRKnY+hfWADsV1ll
 CKU733qIQTg2f2PlUPprjwUjF1yxXewwNkJKtfsQJRyWINdXmDW/EuO/DsgfphgE
 LRFAIQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vjhp1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:53:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso3115642eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782748400; x=1783353200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITNT7yo4DFCTc1ZU6zg4y9fwGqIeCMpk3aKkrfrQ1pc=;
 b=HwbmgAesh/VXjskQXbPjUbyOl89NkkAw4li547L1WFzMPI7h6NZPlRNpFPSdekPJzC
 iq/zxMBfDXu5gH2jx+getQtQq4nMRkDn+vzXM4idxVlzgmeSCSSlQMH18cwkJbL60kHU
 movg1C3HeaHitpyrDiSNAxHtpV15Agvmsjd0vb5wKDXrFmM89wjcW6CJgjVXzJHGuku3
 awzbOgXd2G6L+0uqEa9V7FjoSNGFcD/YXuYrmChfnAO2pXKdgrWqoT2ier+gbd3Y8pLh
 Tz7pKKoj6bHaO/v2Ef9nSeZD2bHHpSVpTkVkurChiKXkvP3VLh2GcrYm1GFMbUF3tqvZ
 CUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748400; x=1783353200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITNT7yo4DFCTc1ZU6zg4y9fwGqIeCMpk3aKkrfrQ1pc=;
 b=FWOEDrGUskEHGZ/WfnlTq0Wy7Yb99Gc08zyJT1BG3E4pu9O3+MYs/TmGgqXwUYCyfs
 nMXhdd5AcMfAXSaeqmyx1mcCn1Sg40LKqetYRVQkcDS/FxiRaMfHMmAaRAJaBBnj6oNG
 xqWkdj9fHwY7XiWPBif561wOaa6NEg+vHb6SQBF5IeAZG7F2ZcwL/wS40DnnzKhNWJ/V
 7Y2mMBTX5/Eexb25a12BnR5P5P+xDC9i19WW7wq2Fv/xbPWcxSc9e8n5X36p2+GZWsBd
 Fg6EeXVNtIiGdXJgEeJ86pQdeAbHuArrtsv0UsV64BoAo/RbQ0/Ia6+kW4Any+Ylw7aU
 EElA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R6cLmYEgS6zmknsUyD5ghgIW22hoSRwHSVGZP3P2DELyUETVW+gVpjxZsYShPuIUFxLW3feLy4KYc@nongnu.org
X-Gm-Message-State: AOJu0YzcStn0PovD6wzwXZli1PHJ+cxoYhaX3WzR26CM0CfwXy4UalqR
 geeyUB89U1KtyqRVVSKTolubBrkSbJ3rTVxxKlLVmxnGRdFQSS7+4esoI8E/ueCHCn7fUhJMd1E
 +snRCJ1TijSrqLaNWEuKpDSAGqbMCsmos1ZO13ZEy7ntmi42IQPD2/3/6uw==
X-Gm-Gg: AfdE7cmrfh+JrdbXGHm/t2KMWMvC4zuDGepOJQqdD3NBTbgIVuGqDtoJq5Xfui08bBh
 EzJIUUcD0nlGJA2nZ1LHhMtNcAs5HRw+fMYqNwJUYKgdS82Kp73J7BUoY0AFNxbMsH4h1RZGGK3
 sFzsfK6LISrMlO8YiYsSw3RN8Da1j3xEo1Xok284Hc3M61OHhhrdSmooKUKX8bUpiiFLQv2mqxG
 kHnr99ZC+sebMauXGMYPCuHkMKjOZShknYH05o+shOZEM+aiwlF1l1ClG458KGNP4X4UcixpqCf
 TjJzkBYAet8X9paGfjgFRNpJ4n4qZqpZi+C8i36wwGqfES2PJ0UeNphtnLTd+B4lluF8fpmY6yL
 HYGmnVqOHC4xa2LP2sohtZN5zHpr3m4wDNQ90lSu58sIKQq5hwcNjTUnJMrgLN07m+OyGHB20Fl
 8mpNw=
X-Received: by 2002:a05:7022:68a4:b0:137:f532:e345 with SMTP id
 a92af1059eb24-13b2a1c0ad2mr1876c88.26.1782748400493; 
 Mon, 29 Jun 2026 08:53:20 -0700 (PDT)
X-Received: by 2002:a05:7022:68a4:b0:137:f532:e345 with SMTP id
 a92af1059eb24-13b2a1c0ad2mr1863c88.26.1782748399992; 
 Mon, 29 Jun 2026 08:53:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d912197bsm80378831c88.15.2026.06.29.08.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:53:19 -0700 (PDT)
Message-ID: <29da0378-6d93-4e91-ab0f-ce624407f2eb@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 08:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>, stefanha@redhat.com
References: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2--vyxG7wxgGmvTS7ubI0UVYDrpDdLrC
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a4294f1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bVtI51k6CwBk_6Hy1dgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX1N7gL2YLVY+u
 Zh7gWW4kyjq3Yj9WSMNAhshogstF4CvYds0ozfvvUyvxbQgtiGN0vWImXyO0nAS5GIiET6h/0RV
 mDmcLVgvfzCCPFV7gKpWSjVD5R6xbdk=
X-Proofpoint-ORIG-GUID: 2--vyxG7wxgGmvTS7ubI0UVYDrpDdLrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX5lxSS06RSIKR
 HzwXIHT9B03HKqBfDHd1WPwugloQWCPz7FogzIY9bWQRs6XFJEbI8biqMYzcGCMtRLNoIBmax9v
 8B2VuP4rrQFnkNdmJ1ZH/U0TgC10+qZgEAJ1/RoCZ8f/u/DdZTmC4I7PIjuu3jd9NfSwEB8eOut
 zII/q418fwZXAtT8ajf1DEtAXLI0UK2ixHBOK33pWVM8hBeXSEaYS0gYqNfL2B9MtvKnPEX9n4d
 M8TnblMUMjKktfST8O7+8rkjMvdqb6Lv6VNIA6GtpOOp+bZcX3dnX5fdxBieGCe2AHvxTvP1CGL
 AMHtZC80au0V6r711b4hsF1+Nx8sQtLmSsG27y2s700WdgPFOFGdjAIvI9UXy8RONE7KmkcvwbK
 JIiQHt6lE4kMiUU8PRX3kU3/fxbMxq++9aXVBDkCzXG3E6s58bakFD3nxY644TcA6SPNurjRLTB
 O1n2ZRl4iPsuLILyEag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/28/2026 12:03 PM, Brian Cain wrote:
> The idef-parser is a native build tool that requires glib-2.0 on the
> build machine. In emscripten cross builds, emconfigure sets
> PKG_CONFIG_LIBDIR to emscripten's sysroot which prevents native
> pkg-config from finding system-installed packages. Disable idef-parser
> by default for emscripten since the wasm target does not need it.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/meson/emscripten.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Already included in PR v5, but just in case:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick


