Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160F4CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByuc-0002iR-AS; Wed, 30 Sep 2026 14:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xByuI-0002TV-Pc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:19:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xByuC-0004Q6-LK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:19:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfApJ643915
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YfrBbpW/CUXgr8U2tcXaupAFuNRPeOFN8duMsPtMDOg=; b=FPo055Z0fWtsU9sL
 wan8e6cxPjR6CaI1BbbunEMHqeSL17ancUydQFKOZYCn7pzEgpkhWJE9wMnHGz+c
 /kzEZqeYjou2JKEt0sGdar7Z2ipfIOB42//h0os1uzww1nWXPo9qP8TxusZu5ILU
 /SKTHM7tm2HGFQIHxa1Zi44FEFtkRqTXyfxleo8at7pNW1qovce/tcE1D7BiRuKA
 s5OdG7TucQXueDnTYlQx5fkPZS+Y17LGEdoaC/h0ObOAX/7C1nrTyNVGjjwcyTSH
 eumyES9rnZPt82ip0JEjMEKYwVRwoMCUl0f8u49VQi+3bxlfw9TIwMU52VhJ78Kw
 Ycs2jw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20yyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:19:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a470ead068so3224077a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790792384; x=1791397184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YfrBbpW/CUXgr8U2tcXaupAFuNRPeOFN8duMsPtMDOg=;
 b=bpXzp7gUQljxFWe022TVZf1EihyVVhsM+MF3QrCPquj3L179l/e7vEbrSBWYdsIsY6
 3cpKhK2kdNsxkmC1ND6rai7o7cxCHeffqxtysoOLupQ8dpKS8kULBnzDP2ACX/HgxaR0
 kJHzXDdPI+UpZFtF1SVJNH756lwHFvzZNpskPbxzbG0paBSl4OhZjiWDUQeN4pBWTddF
 NbCNqasBCMLcsuXT57zx9GpAXu2TjqDP+tWbedFcEuE0lOwklzeLwbZ7pwKF3rrEGoTc
 OCIc42KzeetqMTZTdRZkq0fkX5C57yL3wppHsj8cDur5kvzhbIIvjOlZRrZWKlceV8bu
 qkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790792384; x=1791397184;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfrBbpW/CUXgr8U2tcXaupAFuNRPeOFN8duMsPtMDOg=;
 b=YW1lzUcpoiKAE7ECvTBzOj2NPttcJgKvla/g3vHu0nJyy1yklYx/YPSD/fUjQ/Ymmx
 qkFeRxxOUr7T0qHvIa+8N5RK4/zMXHsRgZyvoUNjPwdC7Y8SF90N+0xReNHf9psSc2yJ
 XtFVM89+ze7/lwXTtOE3xesDl9V3W6NSiCDOxI46xZv3ynJTj6KQnPsshcor/+q4/dVc
 yWn+rCxsxg7cE/k6MgXTqgPqej1JxY3TlJCZoHwRHuHq7cgeT2gVgyhxJfHzFtrIn+rg
 QINKB76A8XgpQTQqdlALKD6cE5HHzhR0Dj68QlrtMFMBBK6GpE6MlFyAV25sLzr136xC
 sB+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeWWnd82+JvIjofHAPLIz9rRCk2M1tJqDq3XOm1SvsW1uUnGErIVmIYRERcmGh4uF8Q8eW6Vpz4xFK@nongnu.org
X-Gm-Message-State: AFq9FYLCWofk6qPjIJZ6xTHlF2H329/NydLVz1XNh12y6A+jNWSm0JAG
 07D8/dsImtOMBqydv+gj0omBFSnvCWWGHQSX6gt/rhrtXA010DwPMfPAlqhgaxlW9y7DyB2ovdv
 3Any66ZP45XIMk+HiULZNJYWzlQUF+SiivSmxMaTSiUA3AB+SXeYzm1/LDg==
X-Gm-Gg: AYBFou3xKmtXcbTSZbM1tjesrpYeUSNkVzZYa34vd10OphEXwIOS6qXdmzgBgFDisp8
 Ie0V2rHtebQXmnVRwIZuQhHYIhlXc+5Qh5huaAsG8fe2lJJZACQX3g7QwEIPqYjKX/1XBYNIw4B
 Yp8ZHEd5jsg0CNgI2xAN0yNt+Ma3JcYkZX9gonVCbW4lL+X9X0iL+kN7aDu8U3Y8n5VqhZqYwuH
 lt5wEIlFY/+qa7ZTn2x8Yp72ibChMtxlbD1R1+e2R1AvXFHE/pc8EDbmF8sIKaffq01IQdKdo27
 1LzFaQie13biLV2s8335IMsGZms+WZCW57QvxkYtIPu71PpqvK/pixOi4fYc69iGdnbh7krNf5k
 RCtBu7LurQKWPkAxcKHTVm0R0JUAXDmQpFpB9pEwer+MLai2funoJLiBgbeh2lLim1dI=
X-Received: by 2002:a17:90a:dfd0:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-3a4d0f02bd9mr1267698a91.5.1790792384006; 
 Wed, 30 Sep 2026 11:19:44 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-3a4d0f02bd9mr1267678a91.5.1790792383481; 
 Wed, 30 Sep 2026 11:19:43 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f43f832fsm463662a91.7.2026.09.30.11.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 11:19:43 -0700 (PDT)
Message-ID: <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260926081551.29-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd52c1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=JR3Z71xjIoJ_TNlYm3gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX0AkaUEe7cFZG
 19jtTNgWEY4drAZDXQaJ85LTlGIAxW728qfsnNOp8kbEZCO31xZ6LTB11i0FA8brShUIOMvNwj5
 kL9OK1TvW8J2ntVry40g2s1yx2X0LAM=
X-Proofpoint-GUID: qoH2_IIcYP-NWZzoIbu8UpZOLHe_VUP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX+Dabd3G/6rY9
 RMPqMaREjcOTNu0Z+pVIJcGGS1wIdhRL/Uno7uaIbJfhsN93zoixoOlDMea9X/0YJGj/r5AfhNM
 s7xddH3BT02iYTmFsgQzJbRUFIhp7cm5HtKnGNPB9Y0VqMbIBeUBWVorfXRIPOnHtWpLkvoqI90
 k2c0PbcE6/sYn4jedd8nm5H84e5qsQEn5B6l3Ry0osNLlQeUBFcJwvi4HL2x09fyHQU6qwqKg+p
 TjOQsIrb7NesCmD0QTtasCWHEofz/mYztis/tG2z+MQ9sAkONvf1WJkrGImKLXQ6N5jDr7zY03K
 LIPTHmCwXjjDlvIRB5o08rH7dG/LWDtk0yZCHk2VgVxnH5uqVme88Ytq9nk/2EC7f/d3Ts7diMz
 uaGLERffWILvwINaUMijrF6rzl7++Uh4MOnTEI5cvuma1ha6rCrOr9WmSICipUgBCVtbfFFi7o6
 X5D79rjSESu3bFf/0sQ==
X-Proofpoint-ORIG-GUID: qoH2_IIcYP-NWZzoIbu8UpZOLHe_VUP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/26/26 1:15 AM, Yonggang Luo wrote:
> - Add machine_class_set_name() so boards can keep a stable -M name
>    when the QOM type is uniquified. machine_class_base_init still
>    defaults the name to the QOM type without -machine.
> - Document that MachineClass::name is the -M name, not the QOM type.
> - Sort -M help by MachineClass::name so order matches the printed names
>    when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/core/machine.c        |  6 ++++++
>   include/hw/core/boards.h | 12 +++++++++++-
>   system/vl.c              |  8 +++-----
>   3 files changed, 20 insertions(+), 6 deletions(-)
>

First, I'm not opposed to this series, and if anyone wants to pull this, 
I'm ok with that decision. It's just unclear for me what will be 
direction after this step.

If I understand correctly, the goal here is to allow to register 
multiple "virt" machines, while still having distinct QOM types behind 
the hood, which does no affect behavior of current binaries who have 
only a single "virt" type at most.

That said, if we project in the future where we have a binary with 
multiple of those "virt" machines, how will the current series help? The 
situation we'll have is distinct QOM types, that all answer to the name 
"virt", so we have no way to select them individually.

Slightly worse, find_machine() will just pick the first machine name 
virt, which is a non-deterministic order at the moment.
https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846

A possible alternative could be to use ".is_available = target_X" on 
those virt types, which will ensure only one is effectively registered 
at runtime, thus, there is no ambiguity on name or who is the "virt" 
machine.

Again, I'm ok if anyone wants to pull this.

Regards,
Pierrick

