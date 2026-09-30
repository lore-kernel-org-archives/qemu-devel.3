Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE14CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByvP-0003e6-0Q; Wed, 30 Sep 2026 14:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xByvN-0003du-At
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:21:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xByvL-0004iG-M0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:21:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHedhN1198552
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7lyvC/G4EAzoqS/dC5OuajCY+Ld1LQca6036wgedMOk=; b=JppMr9BH1jtQcl+U
 n4KqfzIAelL1R7WVH1E8cmA6nrI+3cJDnE6UZlwG7Pfx8r8XzdlYDg5HlQis0R52
 XCDWO+UmKPnQJQ8A46+mgVbQbSnq2boZYOq7RR7W/2OkxurxYyKvdWtavs/aRvU8
 1JyMwzUyh+HducSqJqxdOEXv6Jq7+7kmXpZDwDSCVT85I/oxDgCiKlc3E3y/fvty
 UkTQgCkK8TgwS17QfvOCh/y/QWXdVIrEl/DtD9gSmVddnNvU18SDxyIEas9y7ih9
 xvEkGGI9IxAUC8UDwdHzs4mpGC5Ika4Wf6xnIsvmzqf5vsdTMGDAJPYS64azYVlm
 GtiVYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136thct8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:20:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so45342965ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790792457; x=1791397257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7lyvC/G4EAzoqS/dC5OuajCY+Ld1LQca6036wgedMOk=;
 b=J/ThBV8nDCLHVvEvS0hBNtqjcMg+4i0sJQiu9dNwYABZYxLfBRGvJNYFZhWLctTIZx
 1mui5554icWaD/EmOm+Op8AQUj1NxrBZE5LH0Cb4nVTcT1jUW6ZFNS5OVdWmpLeFQzXQ
 8JysQYwkuzmOLnoO3d5VEktWoOUgZlZiZohBK/MliQjfq9s5NzyhtiTn3XncYT2jmiDg
 x//rY5ax0FU0Eb/nFqXRHFA8bMzuDvEDq9CjG0BeTEabE8b+eqY149PCYDdM9N6/nDCW
 TzTbXsfaMdasMFmlOuXTG71XCfuLeLZ6gWtuLYCMDD1H8MrbWQU/tI5V/feZClMZW+gV
 BrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790792457; x=1791397257;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lyvC/G4EAzoqS/dC5OuajCY+Ld1LQca6036wgedMOk=;
 b=RXXA5jUBSJGCFCAA7EGX4NounNmfPI8B75pCubgn+/gl8n7wLU3wO3ETGclii9m3y9
 1T4WdYihb4sGfWyuo2Odpr65p/3toVuIwCrCdP8lpMnk+K0mleD6i7rQQbR7Fryr4wbG
 UeigUz9iYhhtWZqAuF0ARD95kWiqnPtZ3aKpfzuDLej7Cr95yzv0wxBE2YzwJmmrVuQY
 iEjNKJiq/dmmBy4ldaaYBh2EXzCQkq/cpe9vT+0jIO/qB3C0iwDbTY2dlrh5zNxmUaOI
 oiBV4Vq+7zQ+D3SC4ZQY3U3YnWHTjq5n2l6O8JD1+83JJKnVXjkfK3M0PNFV4ijX7okW
 3GOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbbY8q95irp8XcicUF1RrmP98CT5k4EUrMLpJUs4O8xu9LjnWjkEvqjjgx2rkd3TQEFYK0P+DX9ygL@nongnu.org
X-Gm-Message-State: AFq9FYLbWdCtfYoMvwSR4i7clGBPNrkWNCGYpcf5tCcbFmcPzEm5pGy2
 XxWH4ii+8QGAM7REzLdARpw2qqwFPmISJMACSptE4VNYWO/+JfDv1S5sULZUCZKfzcdmP6v26tv
 tqq9IMr0sAIq+Vpla4Sl1CdVl2Db2dvWYJs83ntPdbKnbXhvy+46M1N3gjg==
X-Gm-Gg: AYBFou3jbj6jON2mLSDV2yWwj6upW+C6NajpxV7RXZerI3wP+mm/m6gG8aUJ+m5KXvk
 TLWWbml6GvseEsFjAXbP4lUKvdr+k0Fu3KGYEiooAx3Cjc2riALUUg/KXNoKkxDJfscyq35Z/aj
 dkxwPydHKPQUwThNVGwpYyheOoyYDW2L3ll3pJU5XlsJjFKhNFhJOTN7Tp6WUyg7etklJYE1ypN
 wcGGs8QtfxqlsJtuuBiGgkD1ESLmUEkqypaDD64dtcvLpIbLWgp8m/csd1rHoe/pWFkMJXxChVI
 rfo6wmSeCeJUoyCNiFU+AKLRvYMSK07cdGIufI3Re26kbD8m1u3wzR9w3nLoWbT6k10TYABWm34
 b/Bbbn/r68/Wj1l/X9ZjnHdAtAWvLadgiwxv/ZXmak5AHz8L1KlbPjuPj
X-Received: by 2002:a17:902:f690:b0:2dd:ad73:c987 with SMTP id
 d9443c01a7336-2e2e4b49765mr17667045ad.31.1790792457099; 
 Wed, 30 Sep 2026 11:20:57 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:2dd:ad73:c987 with SMTP id
 d9443c01a7336-2e2e4b49765mr17666735ad.31.1790792456643; 
 Wed, 30 Sep 2026 11:20:56 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300af5f26sm1277535ad.45.2026.09.30.11.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 11:20:56 -0700 (PDT)
Message-ID: <7b49c032-2600-41ab-8e80-97fe7f698563@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] meson: move gdb detection into the top level build
 file
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Anders Roxell
 <anders.roxell@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Klaus Jensen <its@irrelevant.dk>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260930164649.433573-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX9DZZ7Io8F658
 qlHNTxTDdz/iqZRyURuhPZFNwuTUiGvJ4hdPXutfUjNFOUeMgVQU2HbvnTLJ02ZzI50rsSsDYn5
 6Ip1sRJNj5RhvPAu+CIu9qU8MEsMxHs=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd5309 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=A1s84III0mZbFTx4H-0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: v7Skw47QPaDqxgOfDj5Qfcuk_S_EnRjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX0ogWCVykMggu
 3j0QrhxH9DiqMb0QbcPn8BX0Zvc8WCBgaC7cR+/T2dT9GLnxquQkuvfgsriWZ2Lkg+hATGaqlEz
 OuJ95EIqIWNdMhCTYXmScPd6/rW2suf+nyZWlbhSXyRO7xUwQmI+BLw+Dsr/1W6keHFTIAIfJ+Y
 IyxUDr9Pn3brm0gr8eaNflYU0hxYAg+48FYg5FL1fxM2F/5cKn4FNMamGfoIL6AqdtYTt2R7SKt
 sgivKpD/pqIigcJvQzYtp605VOOAJj9eu+qY6lkheygvaFCxTQZ/npqGBrwHWIi1cNb7Zqyulwv
 YwgUbhEU1NRk+9ziQnMnkujkOusWCnTV0lsTwmE2qJCTbgOBTy36UEyBeE+gqahrAyH36IZDaqU
 VYyOpaQWzSehOOvDHbukWrKWJCb//BWJ5WpT4COyrHVl0oynmHCtVCk3pDuyPBgYb1/SGkj9V4U
 +HpIXVM8Ls4FAXDLv2g==
X-Proofpoint-GUID: v7Skw47QPaDqxgOfDj5Qfcuk_S_EnRjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/30/26 9:46 AM, Alex Bennée wrote:
> Currently gdb is only used by TCG based tests but hypervisors want to
> use gdbstub too. To be able to test this case we need to always probe
> and report the gdb we have.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   meson.build                  | 15 +++++++--------
>   tests/functional/meson.build |  5 ++---
>   tests/tcg/meson.build        |  5 -----
>   3 files changed, 9 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

