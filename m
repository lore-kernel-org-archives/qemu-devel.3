Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923A5CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYQH-00070x-QV; Tue, 16 Jun 2026 14:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYQB-0006zq-S6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:21:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYQ9-0002db-F8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:21:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH8tps3746552
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B/FkfZH8K8mQmfftvfn27lXE5SV4xn7RJ7SIMiwnYmI=; b=oexnOk2jFxYJYOCv
 V0UH5VEI6isw9nFPLCCvgBS902t25LB+qVNSn5lINRh0mzy8UixqSkX7wls5MZaz
 F1u3s3aNtOTAHm9rnbUSslvOrWUqVq0Ld7Ckwtv1WqyHK8D+rOZSN0YHiqeAMci7
 ouAV2GTZQXbL2DkFrNkqQZA0KKOwtuNb3catBNlj+IEpsRCU3KXX065pmLmrpinw
 XxxvIFeBNiw/5jIN7YncYDQfltXb6RM4rAK9nZPBnzZG+CVpO4L42NjyTcZDdi3s
 V31s/qG+Sc+aBMayesuuYx4womuFbvJaK92zfbBI7jopV61G/6N6JoeNYsPrHbG/
 I+gEbQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu0a7ugct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:21:55 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139871a52c2so1435196c88.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781634114; x=1782238914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/FkfZH8K8mQmfftvfn27lXE5SV4xn7RJ7SIMiwnYmI=;
 b=Dq1Xc/X+1JBGskzlq2Aheozr4qhMEYZMufF4mx5evzubAhHMLLLsczgf1p44T8Sx/3
 J9S+VYAchwGDL5Xvc2XC17H8pY/3BDexw89mJEL7QoWlJ2HAXJZ1WjGG5NrRWe8vOq96
 itPYI72BTkUaV1ZtL0krLrLi/iFRDppRfcBV+dPn+WuR6XKoAZOagFM9BoYdwW1hdiPw
 rPMhZz+1Pf2yfTtSx0B6H/o9ZYj53hz8VMTCTcaWudGbopyAol6mQ9o8lh+WOROQCDle
 gGeA+vhtMXrLuQE6NJFyv2yNlClzL1ETLbeh191kZW6fiIaEGJ8Bgic9XFiIhpOy/RSv
 7uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634114; x=1782238914;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/FkfZH8K8mQmfftvfn27lXE5SV4xn7RJ7SIMiwnYmI=;
 b=CYmL8om9EOC6ln4/6bpUQyvJUGP1A4PHcQsiZ8RahWpQtSLdZhN+JrZcufxEs4FTEJ
 GsuLNfFXMDdbis1fJggL59T3ng9u1WZO02MYYGz0Z8WYc5cXx10BlXrCTzTgQDH4oXyH
 OOdxDX16+AUES8qPIAMop/YHPV6nX+zt4OKsi8pdXpb5edYAegA5ZGTNrG7KgAS7e1Tb
 TemlZZcKbWM8etIqS4i7mHMq7G8wbSC0WvYhcorXrNl+Nku2yXLVNCANkHZJ+PCdfJKF
 Bk79B7Q1tlkCn1RwSQcPrvi2x8w5zr+SJJ9gfM8+QbkxkSKyqgkU4MWIDyM0CF4QtSmK
 425A==
X-Gm-Message-State: AOJu0YwG+CKwdJ4Kom3rF0yaF8HTnqBJilZSjfsG2brx/fTvNWRmkDjQ
 bzlu43+qYFSalgmqSy7u0qmq1LafQ3NQrgR1ehRSKq6zeqgeao+oJYOF+k4iO2t+vB4OiGhsPsQ
 CjOG2OIPbbEw382Ykc1VFKGzUWFrAckEkgtJt6fkcMYxzhllyhMyqEQh6yw==
X-Gm-Gg: Acq92OEHGADT4QRrVlgeJLKlYCPWemWZsZtqcLJub67j0WwpUukAHF5cL/4q8l1lOnV
 HHvPctLcKCS1XWyTK450GeQcr0d6wvgUpYdZuYYKodJQz4HmMvcEhOlVIuPE/WzGrxofwXuhmB9
 J6aqUIQiqqddHupWQTHWls6GQMqIrMHIHf8ATGECRGKE5HrVVtw/sTHsZd7KWV5b2+A/tmnSKx/
 MScTAYBHEfTeMHe6Y6INVROYe5Qz61jkP1UDWkhXnx3QYr36anufnxicYGA4TVvOjA6/Sai4Okj
 QUbzf6z2xq1Wpve36n9wdvB6kq0vWSrHhlLiJFVtEX7FiL+gJrNiOY/3KxRPrBYVBQCno7mRYzZ
 iD630f0BSgH8gD/G02m1rueyQs3o6V25pLf6n/woXYsMidwQw3f5OHTv5D2RbaOq2hckNPF6vsa
 6PplCEVE4+U2Dmlw==
X-Received: by 2002:a05:7022:e98a:b0:137:e6a9:b998 with SMTP id
 a92af1059eb24-1398f6de9e3mr30022c88.31.1781634114468; 
 Tue, 16 Jun 2026 11:21:54 -0700 (PDT)
X-Received: by 2002:a05:7022:e98a:b0:137:e6a9:b998 with SMTP id
 a92af1059eb24-1398f6de9e3mr29999c88.31.1781634113906; 
 Tue, 16 Jun 2026 11:21:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b8fbde7sm14150889c88.2.2026.06.16.11.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:21:53 -0700 (PDT)
Message-ID: <848e1ecb-cced-4c6c-a4c5-3daf3ed0edc2@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: use int64_t for the syscall filter return
 value
To: Ziyang Zhang <functioner@sjtu.edu.cn>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
 <20260612055642.589337-2-functioner@sjtu.edu.cn>
 <87se6sdonm.fsf@draig.linaro.org>
 <bd162496-6325-4f96-8ad7-72fbfb3e89f8@sjtu.edu.cn>
 <102068b3-f181-49f4-addc-4444afbc03a9@oss.qualcomm.com>
 <ec256e96-5519-40ac-a0cd-b16acb6e8e04@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ec256e96-5519-40ac-a0cd-b16acb6e8e04@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4NyBTYWx0ZWRfXwEfoWsn1N1H2
 oG9UaJ01lzFRdUTEtccioxK6Vckj0Jouaq3gCWqK5cUdlaLKVNUaOFp/oBk/P3S4IZeecw7YSnY
 3KS14kzj0sXUpT1/928JiHD3xa/+KOBU1w3LwlH4q86QD6rC9uw7wqDeFMAS8TBOe5YdG/2PBy7
 7AK/Wdcg2q+g1rL/1hkzuYq4h0P+T0v2WMQCQH6Iejx++AL8hZYgO9zeL8S+Hu19u9sXnxf2rzQ
 LyM5RO9ujPsweKVvLAFgO6cKNTGz88ISUB2upHRcfu/0jY60CEJV5dffQMG8VXyaMwd3qJz+zjv
 ORzzlccocvfbtPUsknwsdSChxv1DwBqheWfShjbH6yCu0egpvEhPoF7Zmhq0sRoA+APk+hPxmqT
 b4NmcJbEAr8ogPUmPhE5hjcedg4xpSq8EaLvSjhbh/2ZCRvFHrbtqsXklDpznsrNx1uXrAOAV46
 pQO04OeqQkHDJZAfQxQ==
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a319443 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7HyEAREXFvCRYPt9zDUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: -B05UdI7auq6lNRYkRqzcVkZ8Pv4TbnB
X-Proofpoint-GUID: -B05UdI7auq6lNRYkRqzcVkZ8Pv4TbnB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4NyBTYWx0ZWRfX1PuAifk83ZSj
 946PfX1tfsnBdOs5ZYHKUJR+3m2hzgP5A3wf6FhHnRkM1K2kVQlJ2rLmmOfy4v0GoPAiqmriTJT
 jNaWtJNwwhgzQVD8uDcstvdexRTpamk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160187
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

On 6/15/2026 9:10 PM, Ziyang Zhang wrote:
> Hi Pierrick,
> 
> On Mon, 15 Jun 2026 10:46:16 -0700, Pierrick Bouvier wrote:
>> We can't expose target dependent types, so having unsigned types for
>> args and ret was the correct thing to do. This way, a plugin can decide
>> to use any bit pattern, and upper part is discarded if needed.
>>
>> For args, we explicitly clamp values depending on target:
>> https://gitlab.com/qemu-project/qemu/-/blob/master/plugins/core.c?
>> ref_type=heads#L554
>>
>> For ret, the type conversion is handled by writing ret to a temporary
>> variable, before sending it back:
>> https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/
>> syscall.c?ref_type=heads#L14622
>>
>> Indeed, there is an inconsistency between syscall_ret and syscall_filter
>> on that. However, they do different things:
>> - syscall_ret will read the value, so having a signed is mandatory.
>> `if ret < 0` needs to work.
>> - syscall_filter will only set it, so having a signed in not mandatory.
>> `*ret = -1` still does what is expected.
>>
>>  From that, I'm not sure any change is needed, but feel free to point a
>> use case I missed where this matter for syscall filter.
>>
>> Regards,
>> Pierrick
> 
> You're right, and thanks for the detailed explanation. There is no
> correctness issue here: the filter only sets sysret, and *sysret = -1
> behaves the same whether the pointer is signed or unsigned, so nothing
> is functionally broken.
> 
> My concern is purely about consistency. The syscall return value appears
> in both callbacks: qemu_plugin_vcpu_syscall_filter_cb_t passes it as a
> writable sysret and qemu_plugin_vcpu_syscall_ret_cb_t passes it as a
> readable value, but in both it is the same kind of thing, a syscall
> return value, whose semantics are inherently signed (the negative range
> encodes errno). Having the write side use uint64_t while the read side
> uses int64_t looks surprising to a plugin user, since it is the same
> signed quantity in both places. Keeping the two consistent makes the
> intent clearer, and as a bonus lets a filter write *sysret = -EINVAL
> without an implicit signed to unsigned conversion.
> 
> As you say this is not mandatory, so I am happy to drop it if you would
> rather leave it as is. It just seemed like a small readability
> improvement given the two callbacks describe the same value.
>

That's convincing enough for me, and yes, consistency matters :).
I'll pull today this other series:
https://lore.kernel.org/qemu-devel/20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com/

Would that be ok for you to wait for it to come down (hopefully before
end of the week), and then publish a new version of yours rebased on
top? I can ping you once it's merged if you want.

> Regards,
> Ziyang Zhang
> 

Regards,
Pierrick

