Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10939C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZRx-0002JI-Do; Tue, 14 Jul 2026 05:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZRv-0002HW-Mg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:29:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZRu-0000ON-As
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:29:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SXms3954628
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DgJ6Qa2BXnkDA3M+GLV7f8ON8qpYMiNW437n3nRhdG8=; b=V/IGtFh39dtewigh
 f3YnpNLfyHUS64zDiilWmdD0HVLxiiH+KxJCD0VabREjkJQqthtKNdDeI1SrgpQA
 G+Bg1/4XMG3Vv6WGTWgHS+krfeLLvefKekzSVKiNLjAYClTq3jKFlyO17OWQy89b
 i6TSg2IqrdTHKQE4grcaShxy5YB8IEMHQe/SpEv7tvUq4ZXjx9WdRxfZLAJOyl/i
 xyQamr4N7wVLKjHl5eJtcXPzS+7bEQvFtvq9GJH/5qhqOlmLuscoLL+33jwg5Xi4
 4sf25H+oX5z1uI/tiahqJcG1e6Th0Suah77o4Hhes5QyGthe8qJNRCEbn6FZpyKd
 MnpIWA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ju3kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:29:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso68271941cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784021348; x=1784626148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DgJ6Qa2BXnkDA3M+GLV7f8ON8qpYMiNW437n3nRhdG8=;
 b=Ggdkb70J/Io8ntvO6+FOgfVev+mmaZfBcdc70ytV4OAU3xfSFkSRaM936oQSmEwRtu
 qZ/+xtx3SY2d3rg5hH/k+jBsZ821DjshLkSC+uanV6tP02awct7fN1aWbg+ymeQbzwTw
 x2An3aQGBhGRQ+3M61utVZkefkz2Kq0Q3+0h6EqFA5FFfmxXsUq4nnte4mkXP9vNGcVh
 KttWXt+0CbGOGaycW4EXvm4r7rWxdPw3JyW9gUByeGSm3IAgPg78V+R9mpqBiGv7GKFQ
 dcUzl4xv716wtwuW+NgvQruMlLZWv4aC1XOc+y7bnDo7PlSrC/15YmFQEeWw+L5QYH6b
 MU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021348; x=1784626148;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DgJ6Qa2BXnkDA3M+GLV7f8ON8qpYMiNW437n3nRhdG8=;
 b=ppLvq/uZyC0DvVR2Db04kkks029L8lvCHH0EJwC1TZ7yI4BnWHCa6KrvfNekNl0UPl
 xNYLLdnHgTGUWlM4MDles71/4S/lP+S7moa1z9TX/FQcUi268laEiz2NuuL5F9JnG9TS
 IwWJ+hxRyiyI20VRyMsL2L4KboOkzWNmj/NB93q+qb5vLYmsr9HFX8r+5oCLvvCqh73h
 prMdFLHvi8Drec6X+GrvMGqO9Cfuu3s7+r1bTnuo9Xz3fzRc1aQSsjqSrYwRb6e7EOk9
 HWSlWSrN4q+HvbGAN91yw1+ih6Dbz1UC4gvy9hCfXU4OnkhEyRNc7yYeoNbW2EqcfUBJ
 4cWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr32hb3nrCDSh6uEmh5j5qwmGtNYEhHubS4S/Zp0x7qeSV9n+sAjAqRZhPRUp906FRiQn6toT5qLpVd@nongnu.org
X-Gm-Message-State: AOJu0YxTm6hIvxo8Myf4XfTZT3l5USuxMpwUH9GHRHVLB8Gr6XclY2WT
 8Jopt8BDntf2Yqgyu+oCMa9UGCR0pSDMRM2GvTFyxlMf+EUoRUikGxaNKu3ZuvxHYCP9VHSpMml
 jy6whVVKr/0AvC9CdVU/MDqjGVRHVLrQXhRAePt6WeNvTsZhnxWvXZl4aerkduutxLA==
X-Gm-Gg: AfdE7cmvyvwjz/0JMjAQRtLJGNJ92iFi8zQ1KKs1FneAVuMq0cRMz1QXYDMC1k3h2Mn
 yy7MwxD6pjyO2+euUDCWE+KtYi3z+dIxtycuGlsZJ6EZ+mPV+MV5oueTra1YMQYaercwMXPsDJB
 X89ga1KMRcSZ7SJmhTg3DNe50mTPMAggVfQGFkhIv8TX2UmKUx25HqNAdRZHNYDFiwlKEjG2fKq
 JIzJu5O5P6Jurjn9CMoqrf5hpbS0zA8+BsyarYpQBVOsR2LHCIn0MCyY0igwV7HpdvuQYNgAz4I
 gzEPX3ANXL6CPuxyled0hq97gCsG71nlR9TgMLMNDaFLTDqojhqIkR/jjGluHIttyk9eMMy9uzH
 y/WNqt0SoUh5EDSw5bTomwqmm8sVkcA88fCHnehRilIx5rrRTat7G5mNxf4XhCw==
X-Received: by 2002:ac8:5d53:0:b0:519:f884:b587 with SMTP id
 d75a77b69052e-51cbf133625mr111490611cf.27.1784021348569; 
 Tue, 14 Jul 2026 02:29:08 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:519:f884:b587 with SMTP id
 d75a77b69052e-51cbf133625mr111490441cf.27.1784021348236; 
 Tue, 14 Jul 2026 02:29:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15fd50d411sm626492366b.37.2026.07.14.02.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:29:07 -0700 (PDT)
Message-ID: <6e686589-d418-465c-be20-9200081deb6a@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs/targets: assert NOT_USING_LEGACY_LDST for
 hexagon-linux-user
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260714013703.2280824-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714013703.2280824-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NGpe1q9jWE0_IAhFdN4k-QfpdhUVrgU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5OCBTYWx0ZWRfX3VUcPDYxUo0Z
 o30wroaqE9AenJ220XPvl7x1LuxoAeZxQvboL2KlWj/AQgOStdshUrpko3IeV2u+9ml0jbp/onU
 c/KqYmPy5GBHxy0E8Aj6EBjAVzJsGCKrxzyrqhYP1Y31zKNO2XIO7N1pC5xKcPsQOxDKd7+Fnyf
 cdu6ZIZAU/YkmMscCniyE0GDOnKO+Bm16kuY4WGSzH0Abjk4m3H1axkUm5SpR3adjClbVcvWuzW
 XvyK+UPxXwNsLCDLbOUXSh5bXMiE40GjcBE0XianPW7K3zmhjcIEhjTTy1Bf1KOcWwmUXYi9lZ8
 loPmXXsRUVsgzYbXj2qjQRR7NDiojyZ0PHf4w+E66M2SAJrenSHQ/lswdsCdQVHErHpBboocPQ0
 9oQj6DfNYRD3IfHXzPe0pU/T/4TwzTj6FiXyOBrQN6DDNfjhVl8DnQdXTcYcfuwFul2YBobJCF8
 QHkrqmc0BB/CgQww6vQ==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a560165 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: NGpe1q9jWE0_IAhFdN4k-QfpdhUVrgU7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5OCBTYWx0ZWRfX5KlNkWNmkQ0g
 2tQzZhNsqVvYByUtghiJHM239Gxc4SKQKjjeg4cO+odPgcZmRhLhNnYSPLmSqcG/Vt4HoirwKVK
 Oa8Ft8nYNKKQjD1hgdEJR1m3bgX69U4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140098
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 14/7/26 03:37, Brian Cain wrote:
> This is safe to assert because it's unused.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/targets/hexagon-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

