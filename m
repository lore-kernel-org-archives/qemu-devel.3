Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05228CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHajH-000445-OZ; Fri, 16 Oct 2026 01:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaj8-00043U-HM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:43:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaj7-0002KA-4C
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:43:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G2ZYYu406092
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sOSxIDlH/33chAHsx6rAdBVE8M94kp9++HFKnTVP7ug=; b=WkktH0b3fmJJ5TjT
 nUGsO8JCHmdYYqlB7vwlrGvAqQJrcD0q1I1NGsyPm+9NZpmX5xhY/nqZ45PJ0dGk
 raXSWIMNjYJiyJMbOtLV2334RvKeV7Q57PahZkScophY1xXB98II5pG9cj7O9k9j
 6ALE2LLY/j7CLI+t5eAhPx20yU4qNIN1R0LUzqhbN+vEpbCWn2TE0BHuegW+azsM
 iv1V2TgWFN9fB2fxlJIUV7P09AeZm9iadYETCYFgrvMls8lNOnuYO0Aclgm9jscj
 gND/BfVl6DUrR3CQqvsd/89kcHPXc24zrulnvtDLQrPC8dOnMlVjro836LkRhR4R
 21Q8Dw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa26r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:43:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ae8e7e546so1287738685a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792129411; x=1792734211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOSxIDlH/33chAHsx6rAdBVE8M94kp9++HFKnTVP7ug=;
 b=XjDroEGbnV6m9cy6S/6etv6YqPRFt6Cu22mTBDWWOymOYWaG16jS5A/gz2jYtK9RkX
 I54OQZDSZw+oVv6vtnqqVvzmnLYHQdrn0FgaqA4RrYcVgQtA2AtjoX3nW0hbjnGCd8MP
 74LrKD77CSwZRS9e1nM2RWeE5PVBRRju2C+bAL8voH+aywtUMv0wKWhqFqQNw+C+/Zqu
 mgQCnA1NRigntXDSErHXu9bYOQV4bsOb/n4Z+kyodcDBSOr2wocPb8ubAPHgqOUGdWbI
 r6D//U7MMfCh0KQVbKfZDtusM7hXVDUUVP4MTDq60R2wlQMHqJqF8EBh3x3GzUFVCZ+2
 Ae+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129411; x=1792734211;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOSxIDlH/33chAHsx6rAdBVE8M94kp9++HFKnTVP7ug=;
 b=tUmwQbSRE1LP0l4gP1l1gLkmqBqz8duQ/+OCv4GKKeSoaiTfeWAEVix5PkawW39RrO
 gqnXV0YaYWjRFUizG476XgGq6eXNEvTm3Q3BFwSMSr8AHyfbD3DuzDkg+OquxLP4pLUc
 DEExfU60ersrNtdJ0hhAtJNMPlmI3PDkL+vlxDYtYkdo/4JqdAtiJo+w68m9/pBERxw6
 3yr8E/cEnq50//OmqeC2WJKE76ANEZJwrwtGdvhbj+7zWa/NJIfAu2TZMnmtmKQwK5av
 tT97XC0hHib799qa+cOTJHqFOvkRg+UiuoXzSgAyoudd/58gF4uIOlIgzxQ0qrkNa3ok
 76vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGRGB0V54Rbswn5kS/td/N3defoZPJFlCra0nMNmm/lSupQmCYArpyxdJSomKg+abcDyow0GfJ3/CH@nongnu.org
X-Gm-Message-State: AFq9FYJb53vxfcTel/fPV9nYENippuFxxVG9bkKpZiKbRnRaPTbc5Rt3
 vwwbXH6lIoap2ETMxLmZ3C+CpmW2ctCqyshnFrEBt8MwvwHg87KfIbm01SwvUDLhon0zL68cefk
 YNx3aZG8JnKpQcm14vdp+fnp5rtMfJjs0IfgBAj9Ep3CbteeZHg/Nxv7TDDYpnOwN7jfn
X-Gm-Gg: AYBFou1N+RuzE+5W2ba2yhoV34pIP6FvHtc8krQ/V5dJaHaDKsCpGNIt9imFZgehVgL
 I8++1VTgILTIn1QOJitlqQzQtFTX3TvwsXx62QYEq0N/M0BtM7JTkDrzcJMC/lzIlfpfGZYeVGP
 Ad5uNu+yyoXGWmzNEvoeefgPsrzCXaz9odKqerx4ocxKWb4WaZ2ePc6AZx2TisKuN+ZineSxWUy
 rZ1DxycHwdegg+/9c3mXiupC5NR+WQ+Z13G4mAPYmzFFLt6YENhJjIWcBl9PCSe3ra36jmkzIK8
 f0uP7d4CYL7K1h7DRczSuQGtdFRNKA0hkSLf7yo4eVWQWZlWAuerv4Fxgr2da51AZMk2bft8lIL
 ca82INiqZWTUuiUJfKAr7LyKUfF43C8MuUg==
X-Received: by 2002:a05:620a:890a:b0:93f:d27:c89e with SMTP id
 af79cd13be357-93f0d27c925mr723052385a.75.1792129410945; 
 Thu, 15 Oct 2026 22:43:30 -0700 (PDT)
X-Received: by 2002:a05:620a:890a:b0:93f:d27:c89e with SMTP id
 af79cd13be357-93f0d27c925mr723050985a.75.1792129410443; 
 Thu, 15 Oct 2026 22:43:30 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf983b88sm12878815e9.7.2026.10.15.22.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:43:29 -0700 (PDT)
Message-ID: <f034eae9-0b6c-4b0a-a079-f8b22bbae9c9@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 07:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261015213236.157767-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfX4LrmWm6VGtIy
 bKEiiXYTm9Iye8XEHdnnQEq1tyv3sbg8LSQMB/D88HJEt9D6mZhdv8pjM4aVTecOfgOfd6f9hQK
 Z0FRCaLQdVJpM6tXxIV+mWoBZ9mcqqQ=
X-Proofpoint-ORIG-GUID: vS1gVTKsXdaZAocN-pbaUSqzSH_paoex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfX385yjVNWrnTc
 NuGO/5EtqN08L7prxgpASxpf3WhyoEPQ6704gpiddQ5ACIgGNY8OBX3DaI17773nvG30eqkOS3+
 DbOXjfcYZIKPmTpVIuuFL1v43wLnaXjIegNtx/QRKidtZJwMF2HKtr/CskEqxyBqok8GYX7CfNC
 l0S+EZf8naQDtQXKqOa/d0MJLY5vWVRQDQFmBSIRUb5rbE9RINtzaXYq8VtdKU9XRBu7hYO0/UI
 Gwiz+RE/YXCQCc4ECO687ozqRMVJcz0lkfNg6/Q/20899kQOMdop8VvA+5dcWpx7IZP1NvWc3zm
 N6vW89/pBepEQkdmmbFiXrqtmxpLEcJhIrk1sTvk/3VlIBxNyUUlX5FZHQyXq95HMcwiDIODmWR
 qKSNnhsnN6ybcQJuC7rMA5cSviT+xdw+F1R/WP6stRu6TENQP/KyLaFVZKPkZJ5Y7zGFIb94UXB
 N7/6hmXafgwWX8giCyg==
X-Proofpoint-GUID: vS1gVTKsXdaZAocN-pbaUSqzSH_paoex
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1b983 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Q2IgSUjkJhfUdKMcWxgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160022
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

On 15/10/26 23:32, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/ppc/cpu.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

