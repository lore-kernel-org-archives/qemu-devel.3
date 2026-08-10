Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AD6C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXnD-0006wa-9Q; Mon, 10 Aug 2026 17:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXnB-0006w6-GZ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:44:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXnA-0000NT-54
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:44:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXfRq3140859
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PNgyYuX16TuDJxwbZgNExIgT/ibjeNjMTul7XcKOQbY=; b=ol0UnYJFbvg3qiVp
 Uc/EBoVHhYx5quOzkuk9acMEEP+DF0I2ob8NXKRg1tIn5/8o/DNZVmwDqAjYUXWI
 /ttwaFK0ZkXZVas2zEO5/LmkeoGuiPDPoInz6YjjSRas9/1IgDp24SKHE4rFZctm
 lKNCke3XV1/mjTOmVG2BFn6VRR97LVMyrvNNoIqAlxVgHZn707wP4uaOcyc4fCkJ
 uA6RXkcRwHgAERu9kHPE7iQ0Y/RW7Qurktvsj/ME/YmnvJluo3dQf7gODbo9e+iM
 k7eF9xzytoFk0MRE7EXzElU/Z3TW9N2syjm65ntX1rftLvRZuvws0N54wkL0UCZh
 B+/r1Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfs1tq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:44:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9083b049f73so29230916d6.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786398257; x=1787003057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNgyYuX16TuDJxwbZgNExIgT/ibjeNjMTul7XcKOQbY=;
 b=iB/UJDHe3H8lpWfVAIMYqqp6abTFGOcCrnsze4aRkt50BP99A5NNBucks/nCsA9Q51
 yzQnNYaRO2maVdcE/Ycwl+jhjjhDDZUq7zP0fO8CfdlhuIY2skTcp8hzLoM4pOoIhQzy
 X53Bf8PWNx1WrEDR3H9EWFW+uyl5pBjtd0IgJmG/w6vP6KOAlsR1aWgOfB7JDR+dbn71
 7coPOvUEdyhi56+7GGhWk8EkQH8JwP6OdBnbwb4ot6KXDAzQXvuJerOPLioFPHVBD9Jh
 hXYgdqozYecuIRogJbPXjd59mWt8gfFRZiDdba8S06WSMukRA2HZUAHgve09FUgT2gMz
 2IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398257; x=1787003057;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNgyYuX16TuDJxwbZgNExIgT/ibjeNjMTul7XcKOQbY=;
 b=pOx7/b3e6AKWQu4ccmW9MbvFEwdXlyGnK/Q7sOviAxAcCb19X33SBvhnMGK5NqGtZ3
 voQ37RXxiGmOhGm6cSIq9oywk0ta1c3HdOBIbvguOySF+esYjTv/guv5K6epO6U9lZCU
 NEiofN5FSXWre1bf/t65Z5PzAolByMSpj3WP4E8yCAtnfD08/7rDDtirgeuHAY+jNWKG
 HcmafoYFO9SiOTCwfiErblCryZoaIQOZ9qnNerqURbSiQ5/p0iHM8fCzclD8gzIFSGbN
 ngg7uXu/SDoLYVqQXCi/v6p8+Mm3GlcGpHbHEyPZg1Jhba8zZlCbM1b2gxriX9/NdRZN
 ZJcw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpb7H2p7v5G/MReaUVr/V2F3NVZ1YpZlVAOKNxfbpEWF/0NcAnwDmNvBdvSolHGqEjTXjiQUfwmo2cx@nongnu.org
X-Gm-Message-State: AOJu0YxCT1xgd3gFPmPUr3zuEH8dl2ObmGhhmwvlzsEtYvLORkVdTAEc
 EFkvP3Trq0FSLEo/THiGVJk8VYCcMXhOgDV7JWBG2kZS79rP34lGN5a2w3fVLErJv9x69TcEO/2
 /ChBbUaDiPZ8GT71EvEj5rGaq2sorW0y5vfhdlbPlXAASizOlUWFxiWFr0Q==
X-Gm-Gg: AR+sD12ohlGF6EMMRtnRpP47Vonlx3LRpY8EAwreZwfPQ0g2IF6gkQ8AEPa53DPFwT+
 MSctc6ioPKfXnRAF4lzBPd+sL6oC448KSqe0fQ4z+2xpCMHPfb38B99Lait2ExUZiaKDdplAoxC
 JfPWWWkomHs8VK7w8vnLbjTQURR18QoD0QM+3quzgeTkxY3Dq+L0pcLoYsVZzRHDsJidKUhl4nC
 yBcpGxowLdchWx0zqgr3tvL2aAjWv6OS/XjaEWKNeXCRvh0QkO+udax1gwK01V8JlfLpmj9aJv8
 niFvi6O/zPce4Q72OC+RT2OsGEXroh16FdpeQ/WJhi61Xx9T2i2NfCPC9/ZtqQh3tiN4sZyNDo1
 0LXO8YWB1MTcYwEzL5tCBgoXM+G7e82G9sOXU2Rjk
X-Received: by 2002:ac8:5d45:0:b0:51a:896c:9aae with SMTP id
 d75a77b69052e-52d0b06ee31mr311345361cf.13.1786398257523; 
 Mon, 10 Aug 2026 14:44:17 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:51a:896c:9aae with SMTP id
 d75a77b69052e-52d0b06ee31mr311345021cf.13.1786398257114; 
 Mon, 10 Aug 2026 14:44:17 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8b9bsm44247368f8f.25.2026.08.10.14.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:44:16 -0700 (PDT)
Message-ID: <979714b6-c83a-4a42-a1f6-66d4db201501@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/39] target: guard MonitorDef tables with CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-35-8af31bc54c61@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-35-8af31bc54c61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZMf6wr6xhpf7FUMJ98Vj3PNnWxeiEavr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NCBTYWx0ZWRfX2jcBV2a87nvI
 l0uubr0CSRqJA2/ZFfVTb1NHtwEtM3+1B1XDJnRMNRGgx2nQ/J9rvFBnukI4mScln57DZQhoAZT
 WywjYQS6YPYN9JXKf/QFCdFD5iT3mQU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NCBTYWx0ZWRfX4Z7iWaqRXmK3
 KDlSGqGh8291ykU0U5jCxOUUI4zlLeCtTVTDzw8aCe0CmQwzynmVjJ3z8wAS0Ukow4avX3V6LyW
 tYhqmrnVR13chv6sZlvz6f4UeeK4KEbeZ6bDOEVUWrzHNjkn2WKuqnEukA6D4TSFzzUNTVWjXsu
 v8h8wxUkU7MdFy3JBAjhjedQHvK0l8Jjhhl39nQUVLm1sm7UccRfGtOG5/C8JJ/1TAZyuoKt1RV
 ZqMHHbyrXATh9PWNhatrxqsr0KyfOipf4WK3C0NhlQ93kW4PK9iwqZhkep+7POvPwtqijrviTJT
 B1YCcEm/AUs8vk6oGMt+npDsJz3Jca56Otvt2tMYhEluyN1j3s7xsnleZtadXkE94saNRJRUNMo
 GX8odC89lSk40AkmiSriPI60h6b+bTuRsyMTGpCwjCry9oEhV9lxhbzuYZvBiZkOmYOedoa/VZm
 7uDGeDcXz3lSQ8d96fg==
X-Proofpoint-GUID: ZMf6wr6xhpf7FUMJ98Vj3PNnWxeiEavr
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7a4632 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=mX4pIciRXg39azDaiXgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100184
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

On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
> Guard SysemuCPUOps::monitor_defs field and the per-target MonitorDef
> arrays with CONFIG_HMP. These tables are only used by HMP 'print' and
> 'info registers' commands.

Per the cover "info registers (medium) - plus $reg expression handling"
is still listed as undone.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 2 ++
>   monitor/hmp.c                    | 4 +++-
>   target/i386/cpu.c                | 4 ++++
>   target/m68k/cpu.c                | 4 ++++
>   target/sparc/cpu.c               | 5 +++--
>   5 files changed, 16 insertions(+), 3 deletions(-)

