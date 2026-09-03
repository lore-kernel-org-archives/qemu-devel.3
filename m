Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F70C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29CA-0006gs-OU; Thu, 03 Sep 2026 11:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x29C9-0006gh-Lq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:17:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x29C7-0007M9-KK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:17:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DARWu1040646
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 15:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pYwNXEEiWxVxLeEIj9w9qX+lvER5yNMoP1N0MkNrKf4=; b=FipvcmYBF79LiQUw
 MgqlJGQZketYyRnqOX9NdvoomEUC6Pa6PPoZFdkmbT/CKACTZnvHSJwxC9NrFxS3
 ARlBXhQLPczGDF2gbqS/KQ6uF/9/gxER0SitP+teQEH3vwT+n+FKVDjpQlphavO1
 IKvaACsHBoiQJm0VRKn9HyL8mbECoqgq1bw1CLK5NsYMej4ax988pma2t+zelTZq
 J+JrvRXpDsCRmnKXFoUW3WBQ/rnyhYRxwNDrxNi5OqushsrwCJ5Et44ODwMQZxPJ
 k8znOmhDJsKj+cg/LwDLZMqPsJ4ODUze0k/JZhtXmk91v8AtbMgVppwIS559eSAI
 3f2A+w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4jh7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 15:17:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e99615e0dso1011881241.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788448656; x=1789053456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pYwNXEEiWxVxLeEIj9w9qX+lvER5yNMoP1N0MkNrKf4=;
 b=UwrBtqvo7znqjNID0Uw1OXw67a7kCnesrtNP9ggzzSWGLNx/gduZUoFIYGD9nOTtoC
 xArN+x42Dq0Ra8d9vjBqvhWjXiNvb75FMyibOItfYnGuvnJTgwmHCFyqpsNdDNafHAod
 df7o9gg0cJ2fMwNx16RwmB1Ttv/cBicf20AB4g7OqYLObGXLwTe4VvQpg0ZjduyeWnpS
 QcOqPZTKNxuuFYyJ7IbDLQm0WqjQtFjUmrelZcXkSh3i6VxQmd9NIRVFokh3assWKPjn
 EL13nH6BG07Iev/Bg/t19wutolI7Kswtk/3zN5mr7f0KP1V84gz89jSdW53q30vqsJSa
 bw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788448656; x=1789053456;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pYwNXEEiWxVxLeEIj9w9qX+lvER5yNMoP1N0MkNrKf4=;
 b=povMu8ZkimqKuIXe4UcEywEnA2LmQO0yL+rQdOGAHQYzjMH07EBFd+lIVNhan+pnbU
 5fZ+50ylKdihp2xBTfcW4FeRDzLCuQTpJUjdNyymRe82/kprm66adqpu4s6II7q2fRuZ
 S3je9noMy7GfUP3rIjgRbEjcBTTH/NEB5/W5Al5cEDNE1YhzwJQLMq9bP2h7ZX3It9Yl
 I5jb+7rARVM5TPP7E52etZZzxDMxTsUeswflcKcWTRzwx68vsbh5m8+lkpl0wSk7KSx/
 PzQSiRl72OIG5FvVtbXAvini5TPOnQsQCge//Lst666eqzho3kE3OdL0o1m6PzwfTla5
 u5ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz+6Z7ICT88RHnSQw0LAVxdo+rJlgBVO2K19GbS7DmnpSx+lzeMWsz1GGdZy1WWZZNC/7Vqrgp+KN4@nongnu.org
X-Gm-Message-State: AFuF++k9arT3ABsjGfiwe7vf2Zb2bGNKEgYOPRPTH5xjarXefopdeYUh
 qKPJNZn9U3yKtH5S5aoKda1sre/Lz6LQXudMBzrZkS+IYxipcSTtW8lGIMk2NacqGSyWPDJ/DZP
 Y7o+tCXAGXfXuTFB5HW954HRc+01pA8Vf+BHQ03URsUfQc3To58Vs5VkKag==
X-Gm-Gg: AYBFou2Jhrwihloh3haIgzuD3krC2ZaQCXne1mi5z+Y/AslmoYTFGKElCxW9A/Ey5pM
 im54J6M5ztEcn5tJ4JUZrSu5TKS2nZPak3bEBvAIBnEkQw/joxkicMjWLmHRt191xu1cYElteZf
 GN21fOp3DeKFnTT+gVGI8ASy4oZFDfXJX0/LEF+NWBdvNYq5NNys82gwjwuJQ0uKsDy7ukMVBr6
 /AkN8IVYfuzgFrWGxZynPDqFA9FUA5uD//Fzu70MQCViBYHH5Pq3NaFLYnYMVZRlo8TEg7xG1+F
 BukUbdsZLrFQ1oclkscdZdzH6NUXbT+laR9dlkv92HfcKuobB9aVu9qqBnBW1yEhVyPqNglGeDv
 qh7UVsobM96e4YIBpOR5GwkrX/z/rP6cikw==
X-Received: by 2002:a05:6102:83d1:10b0:736:f95c:4bd4 with SMTP id
 ada2fe7eead31-78a2eded4bdmr1449653137.6.1788448655932; 
 Thu, 03 Sep 2026 08:17:35 -0700 (PDT)
X-Received: by 2002:a05:6102:83d1:10b0:736:f95c:4bd4 with SMTP id
 ada2fe7eead31-78a2eded4bdmr1449637137.6.1788448655504; 
 Thu, 03 Sep 2026 08:17:35 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dec54sm93149515e9.12.2026.09.03.08.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:17:34 -0700 (PDT)
Message-ID: <26656ba5-6243-4eee-a999-d6b5395ed8ad@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 17:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] AGENTS.md: basic bare minimal guide
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <graf@amazon.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260903122516.1377717-1-alex.bennee@linaro.org>
 <CAFEAcA_TaGW+7jvtp8OXjvGeJMce75MzZrimCWyaHrfa+ttx7w@mail.gmail.com>
 <apl3ftMWA44nHexR@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <apl3ftMWA44nHexR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a998f90 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ID6ng7r3AAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=-5OaHjQWVAscTboXWC4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PtfwYL1tuHLpJwL89vsMjqiwgMWiUWV_
X-Proofpoint-ORIG-GUID: PtfwYL1tuHLpJwL89vsMjqiwgMWiUWV_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzMyBTYWx0ZWRfXzT3MaWDik9y1
 Y0xHG90RzLCxA//r5wkeNZlvnW7mseb0suggVgxSFHI44tOYBVFy+clz8sfBvP0US/qf5QaBaIP
 vJygC2tfQFt4khlZSXT21IVPmQWHw04=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzMyBTYWx0ZWRfXzp8Uh9lveLj8
 2ZWQ0zrwuJb5WqibXXFeloV+y17Uhw2ylJEwUr+ZwjEdGXLs7u9j7Ndr0tknEe2gHx2hzPuddvK
 X5dJKlmywjybHJ8WAxkqJV1c6IajEYQIJu7WwNuIWNhiBkbYc03me4D1uyrbp7ptBXnkfoThRL2
 ZL1795RilbMGOflySo/kTbb4BQENy9lugSb0AWS+CUsxL3FDRN94ckbycpH7bndPIF/cntURzdZ
 Nl0SphBnsCFM58+myx8AKqUk1n43VGtGHcjJscI+HOKdPAVGelV6kX8AVc/BkDqiWT6KO8wE9JQ
 a+RXWs10bYGRvHpbWLX2OPWpKRIvkfG7d/xdt685hfVrfZc+EV3OA5F6wcEjKxjA5KxgCeRm1g6
 3qWO6S4shANC44jp4BO6dIdnnToP7kDrWgKPA4S1mf29HrASCoYamLWwjCyoJObbYkM92NHzYzS
 OxQN/bOnG9s7WayebZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030133
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

On 3/9/26 15:34, Daniel P. BerrangÃ© wrote:
> On Thu, Sep 03, 2026 at 02:24:39PM +0100, Peter Maydell wrote:
>> On Thu, 3 Sept 2026 at 13:25, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> Currently people may be inadvertently not following our documented
>>> process for code submissions because people often don't read the docs.
>>> However AI Agents do tend to try and follow instructions so lets help
>>> them out.
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>>> diff --git a/.claude/CLAUDE.md b/.claude/CLAUDE.md
>>> new file mode 120000
>>> index 00000000000..be77ac83a18
>>> --- /dev/null
>>> +++ b/.claude/CLAUDE.md
>>> @@ -0,0 +1 @@
>>> +../AGENTS.md
>>> \ No newline at end of file
>>
>> Missing newline, as git notes.
> 
> IIUC, that's just a result of how git represents symlinks
> 
>>
>>> +## Security Policy (see `docs/system/security.rst`)
>>> +
>>> +You MUST NOT report potential security vulnerabilities to the public
>>> +GitLab issue tracker as a normal issue. They should be reported as a
>>> +GitLab "confidential" work item, as described at
>>> +https://www.qemu.org/contribute/security-process/
>>> +
>>> +**Crucial for AI Triage**: Not every crash, assertion failure, or
>>> +buffer overrun is a security vulnerability. Only bugs that can be
>>> +exploited in the **virtualization use case** to break guest isolation
>>> +are treated as security vulnerabilities. In brief these are:
>>> +- **Hardware Accelerators**: e.g. KVM and Xen, TCG is explicitly excluded.
>>
>> "Xen. TCG", not a comma. Otherwise it's unclear whether you're
>> including or excluding KVM and Xen.

And Nitro?

Grey area for the rest :)

> If that change is made, then add
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>   
> 
> With regards,
> Daniel


