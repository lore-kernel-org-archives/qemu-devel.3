Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5ECCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgPi-00077i-F9; Thu, 28 May 2026 15:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgPf-00076x-Ko
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:29:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgPc-0002Bx-1n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:29:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SH1uuf3203254
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bX3xaCQ1FcUI4a+8824QvDWXP9oemzHM0B1otFR6mEY=; b=aJOTsEOZG1htB5Df
 vBhVzhZznN60nvyJp+CWzSZctYpYUoHK7kfh66cqml6yQee4nkLBMK6Ulv+nqnB8
 uw0/NNSoNjF0k/rSlZcSJ356eynyr0G+cXlCf1SQ4F9jrEUSOIXfLv9c7mfpkWsb
 shyyYvYaLzRXrMWQB56j/FzW1ZNy36yhpnbgtTWkTPFYVRZm+LkxqjgYX60qFOiK
 XFeEd8z0t+fDsjy9jtIZiGxCuhxsDyR0KU88MvLzg8lKAkTF+QGwqNEz4/xEzIXm
 IApjmd8nrlB5dcC8/Nc+VOn5zwb3aKea7JkRV9UmFiBr+f5jbLXct6sHMFAw5/92
 HaNjrw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynmg81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:28:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so215083eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996537; x=1780601337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bX3xaCQ1FcUI4a+8824QvDWXP9oemzHM0B1otFR6mEY=;
 b=Aj2JU/OdYgUfXxOGlMxw4gllIXx2paxF2Jrld5xlW3onOsNT3UjTthiRIy1cWRG9Rh
 G+IDUYFSgpgNjR2wYDIlTYw/Y8zS7p4Fza7Rv4Sxbj9vONP+1kr0hFW5ZdNlZ+NlTDm/
 OxfcC+O8SGJLH3bWfoEz5cpAGznWPVGA8jM8EXExphQBgKOPw2hq7rlp93JYaLND43nm
 6bNPw+UtKotGH5H8H3zb2ULswj4A5SJIC3QPVHvNHLfmb22uxwTGNc1jKphTRBA8lCMw
 odm1zeo2p6tgfPnWN9eODS+ODeCwsWuY7zW7JFaM2tXxXgFtNhetSeBXN5DZlLID0Iv0
 3oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996537; x=1780601337;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bX3xaCQ1FcUI4a+8824QvDWXP9oemzHM0B1otFR6mEY=;
 b=jkqQcfnSXkPvAN8HbObxiqaoP2d0LfFkACPt7LO/q30qOXslpl5B3icdDXGbEJo3h2
 NztuDlMDAoyuh3EHlz1lHbZKtptmRymIRSJJuKQJg1RqT1Y3vzTNiy/Wxl2EAlGRcfMa
 qXT9vyb208ANlhHPnTXUExzKuq8yidbh82wKi+jgr7qVTiQqXQOQquNJMD2MsnDAZDGp
 aAa6TMPvnO6LM138moqu0dkEUlp5FPdn56jgecr51Z0bhzIiKtt9cgUyEC701d9GiBwt
 5kplv3apAFAdTwatP69/TExQx1PbeIDW3BE6UAXv8Efy5GZKL39R0M3JmtizHVqht8Ze
 eSuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ELKtz/vttTX0TRpD/MkI+1Ajw8JQWFgOwu7RCiCyTYCOLXdv2AMCX+4kzWZZMSId3PZuQ0mz6CQfZ@nongnu.org
X-Gm-Message-State: AOJu0Yxdn1//8JLJFSJoC0VXPm5ks6EEpgP91TmA8xA6ad1VaG9CXyHE
 cOoe9NNsNUOGlBJGlCtSflc91kBf4s1JSf7ibJyBnSq8+8GzNVL19opItAlVHKEEAKUNoqfbVUR
 zDVF6vOCB3v6vwfUNZvMq8DTuxxoJscYYRBVh445zriJCImr3JSbKlLH5Mg==
X-Gm-Gg: Acq92OH/goA96MBMuZcXQnJC02mTI4FhjDRJyAEu1VvfLsDeAc3WnwfDM/vJAzKhuiP
 K4GBRdeE3+NlfOMmTywo9EnPG/+vpKm6f2PSHbQLZcs5RwvISeavwdOwdbysC4vXvkUl39LgSi9
 7hMciHGY9ZodF0GvL4hxWNW/jl7kC2ahdO5yAChsWR5ovL4XFmxk6U65TfZJtjy1Kh4fHHph1Q/
 JWEvpot08+KidX7QVQ9IJ4LHz5OgvTNbX4eNQV22O7ic6VY8oBZPj0DaOcAQXZjltLN5oNnme7N
 AYHn8hM2SeROIh9kDswgtfsAEKohRchQwMAcw+vLwm6j7R8+YAlF7mbNtc4YBxYR/4f7/Cr9ryz
 CkIQYzddc5KydmOi7SxAAwuCC4OuHEkHNC945njiqT7t7Kj2yQKn4Ah/zTFDHh5Y+ViJAcBRS8E
 pVGc9Z/9sZNqg6zphNHOYPi1jt
X-Received: by 2002:a05:693c:3618:b0:2f2:6dde:df54 with SMTP id
 5a478bee46e88-304e924c0c1mr148283eec.33.1779996536714; 
 Thu, 28 May 2026 12:28:56 -0700 (PDT)
X-Received: by 2002:a05:693c:3618:b0:2f2:6dde:df54 with SMTP id
 5a478bee46e88-304e924c0c1mr148266eec.33.1779996536136; 
 Thu, 28 May 2026 12:28:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e99a52d6sm92956eec.30.2026.05.28.12.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:28:55 -0700 (PDT)
Message-ID: <69d04d9d-419a-460e-9a0c-9fc8a9155387@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/12] target/riscv: Fix page table walk endianness
 for big-endian harts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NiBTYWx0ZWRfX2x2qgXLueVsv
 fPWKRc7mL9eSnlq3zopeNAZrHB+c2dakJrT16Co7oKGhUG/Tl/XR2jhJmEh+d3D7kL9ThowYqVE
 N6YZdXsMJkjnzBPWQewYYJVcvzdj3EkzIFFBx7WZekfp5MjNYtKr3dGnAqD5sf+N0TjD/mnvW7I
 sEIS6BmRHS03y4YJhGRpNCHDx8t92EwuanfVhRpdX27qFCBOkrm7ZG/mzSsVHeDSbathCN9Ff0w
 7VFMEf0ecCY24x9lK2b6gbEqeAjMRS46XTEAnTZs6f+cAieuko7k4eR4IdEqGiUSlfV7i5LO+LD
 nTS4LpBINYSeNztF2D2Oms3/TvAIvVCe/eH7rlHaZmxNP0JY2Jalcz2DhpzV4y4ypHL9IOzIiz+
 BgZh0NbpAle4CzmRjAB/S+zjF5Y12GpFkxg6k5cx9F5wmQD53zeXl5ZrX68o4aEJMvLTQhl3Xb6
 +We/rBE/wzzfhm+FFVg==
X-Proofpoint-ORIG-GUID: Rg6-LDk9uN74y7lOaGAZj5j5tM4F7fyt
X-Proofpoint-GUID: Rg6-LDk9uN74y7lOaGAZj5j5tM4F7fyt
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a189779 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ALku5c8DAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pyPUQofOz3_KeMbN-CAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280196
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> The page table walker reads PTEs using address_space_ldl/ldq which use
> compile-time native endianness (always LE for RISC-V). However, when a
> big-endian kernel writes PTEs via normal store instructions, they are
> stored in big-endian byte order. The walker then misinterprets the PTE
> values, causing page faults and a hang when the kernel enables the MMU.
> 
> The RISC-V privileged specification states that implicit data memory
> accesses to supervisor-level memory management data structures follow
> the hart's endianness setting (MSTATUS SBE/MBE bits).
> 
> Fix both PTE reads and atomic A/D bit updates to use the explicit _le
> or _be memory access variants based on the hart's runtime endianness.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

