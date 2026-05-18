Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA7CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0dC-0003hM-27; Mon, 18 May 2026 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP0dA-0003gc-B8
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:15:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP0d8-0004KV-77
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:15:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ICLGBU1890501
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QbP+YWc/HseRXNfVFwepcPdobyZaoPFZrpwpXqnOpwU=; b=M0KV9UuGy90UTk40
 ySIwG1DuPD9j85RVZcVE9YKTORy7PdV7V3hww0N8eY6m8Vb+OhP0zyJr6UFgJmQE
 YaLndJnLIVj2CRXn6FCqf7l0QaIaSEckQQtdEa91VB8Cs8U9Ai8qzErL6Xfx/DW2
 ehdI3cAxPsgwpLV5Mnm7mKbT8d9j2UU2y5w7+l2JqO8JsDlLKoMsGMi6VpL0bn9a
 iYGMNlmOStgnWJKrroXXPiC9r7Pya1OTTb8mNVSYXJ0ZTjEzfzNiqcCbwueP8rZe
 cAVh2NcS3EXc1vCWodiR4aA4SofPdgnAK3qyG46Q1+3x32j9P+ZMJgjdvHkyzR0V
 nlWq6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw0wt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:15:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e575a50bcso29374651cf.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779120943; x=1779725743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QbP+YWc/HseRXNfVFwepcPdobyZaoPFZrpwpXqnOpwU=;
 b=hInGZea7/jESCPzO6kwZk4uq8k8U35FABM+HqzcCqbebqKjcsy0GrC6qYF6MG+bq5/
 5lg/VztB6nCD182kak0viuy2f/IXMlTynuH5/QwX4REzmBt5ufvY7TkCBOAcWQOW9wh+
 zAuAOeIO3a65IB0ujEQeAT0gZN5HnIhfIkFLYVZcKuNWw/T24yapSmC3P8H58O7T/6eN
 AzJ4ZwB6fzq4D4BWkznQq3rY1RGk/0mgBYSa9Z0Z8GioDEh5lG73pVFN5Py/upAWYRgs
 wBFFc2SHQ8tiF8ElXU3PzJH/t2441jwvC+uxOoBeTXBjlMJImTVj/OgX/w+AWxGKrKEk
 A3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120943; x=1779725743;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbP+YWc/HseRXNfVFwepcPdobyZaoPFZrpwpXqnOpwU=;
 b=GBFWKKjtbBon/6GzPZ5OM5Wn5YEhT2imCf+3V32TfuSDfIHi+0vZzUXF7a94+QCf9t
 XO8VF+cXmA561ZgRFRKocCdMZ+KZ7eiB9PHURFYu5MED/23lSVwGscOtoDeOuFKB5oHb
 dfZn904mrGTfN9bySDPnZElOztLAoUTeFZTINoayC58dU7HiyQPc3tSw5q+wUuUAWpom
 GVzqZjQaShz/Yuu6u/ghZUAw6RorNA3NInNWRMselCnC5ZoR6UNCFC1BViZUCvNt5TUQ
 akUq3PXwT2ZG6cPg8vq8E3rfDlU0BuTbJbk+IbUQmxzpqUYjefRy9aR73k384BmQJccB
 xlUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BA2mDPeq4mxZRvi0hLk7tCn4Gpi2hECOFkJZ9u7ElXVx1sWhxQ9E7mtxGp3q/NnyOYb6RmpdwXylL@nongnu.org
X-Gm-Message-State: AOJu0Yxd1pIeCvHe5st+MWb5m/YEN0Q9wkCUDA34w2wt3gucgItR89h3
 BWzZW+dyjP2H+PZQ6Wh+yTpdESlhtIkos1jUsjUlRQiBz83QPQLfDS6cdQOec8Sh7Il2RUhSv2K
 b6jBhbD2Ydeo4FiV3OJjRN/8myIFdICUNEX+vDTQGSeVGwDtcd95bvKO+9Q==
X-Gm-Gg: Acq92OGlaJ/0LljUg2ie3RljOLnGA5oxHnHCIUU3ObY5wbCE98MvI+kSlNl4LjxoJBn
 f/zWfIGyNITuy/bZa2aHm+26ZJgyXD3UAq0mZM/eqxa4UGsHDDrSqqruSnJOzC+Sxfuyrom1oHY
 fYtp65aF7s33od1rMiTes8sie8+JEWl8t1u0BdsmPDUZ3gOlxOp5GXTInAw8GupGz0+ZOY0wyGX
 8itniYR+gluleh/EE2FXLInHVwsaf0J1id7RUMMNr27+XZ7aexSZtweI4R0+8eyLSBjTlifNvqs
 H9B59nO0ivpTWNQjqEjmbAIGYm3p86hw1tjYunsUXTfm7yPUe3L1tlv0eKuzK69WdUUVGRptatM
 dOHxwYWxbNCrLZWCzyIP4hiLh/upIzKFIw5UZ4BCKM+fned7xUSuF7F77TF4=
X-Received: by 2002:ac8:5c92:0:b0:514:6650:eea4 with SMTP id
 d75a77b69052e-5165a296e10mr219325081cf.57.1779120942948; 
 Mon, 18 May 2026 09:15:42 -0700 (PDT)
X-Received: by 2002:ac8:5c92:0:b0:514:6650:eea4 with SMTP id
 d75a77b69052e-5165a296e10mr219319241cf.57.1779120938780; 
 Mon, 18 May 2026 09:15:38 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645687d30sm143682791cf.4.2026.05.18.09.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:15:37 -0700 (PDT)
Message-ID: <77f67ded-8623-4122-9fb0-57854a0bd0db@oss.qualcomm.com>
Date: Mon, 18 May 2026 13:15:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Convert priv_spec property from string to
 enum
To: Markus Armbruster <armbru@redhat.com>
Cc: khaled saleh <khaled.saleh.req@gmail.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
References: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
 <4f53cc45-ba10-4a94-a2b5-45b5d0259727@oss.qualcomm.com>
 <87h5o4ud1l.fsf@pond.sub.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87h5o4ud1l.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0b3b30 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Jf8hMVOO1aYwE0vcKYkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1OSBTYWx0ZWRfXyArwBrJZ1Zgf
 JWD+myN6JoexDy4EviXUpErE6L9u/1+IyYMNAtwEORSdWIoLBFlaQ2Reb1Ku1dLGbrGuWIQ5eQ2
 0vezJ4LFQtVjiRkhWcHpVdP/nR8UqcDhjWeBcGGwJa67wR7Bn7W4AohJfYx+QHkC6QjhcrBoC/p
 IECnbNhhq+6iTq1bjkjxupeK2g51apeCd1tps5DnEQ9RYSBd+zIPjPIurjD+cv4R3+cHHAjRRcQ
 yHYsI3vbJmuA6ZvNW1W9F4Q98RgtlZKVLt3GzKgoLL2out6cE+FtFyFIfrSRqQbiAMUYL3it+o6
 l+AZa97p5XIFFyLkigrFBqR4FqPVfaRr1WW9FslvsWu8Cg77S2IN95TQk8VmXIuQbsr0sL9OBQR
 7xBtS6z+kVSnq5NqMhDYJST2PEZWRSMIMntdVHa7Ir5QqAdteurZokR4QIxPfSwxq1wPecuWmvF
 WhRjl3aksGHq6h06xxQ==
X-Proofpoint-GUID: 1q8gWtxTvb8ENUU--lPdgNPD-lMhq_fJ
X-Proofpoint-ORIG-GUID: 1q8gWtxTvb8ENUU--lPdgNPD-lMhq_fJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/18/2026 9:17 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> writes:
> 
>> Ccing Drew Jones
>>
>> On 5/17/2026 4:28 PM, khaled saleh wrote:
>>> The priv_spec property accepts a fixed set of values (v1.10.0, v1.11.0, v1.12.0, v1.13.0) but was implemented as a string type with manual string-to-enum conversion in custom getter/setter functions.
>>>
>>> Convert it to use QEnumLookup with visit_type_enum() for:
>>> - Automatic input validation by the visitor framework
>>> - QMP introspection support (valid values are discoverable)
>>> - Reduced boilerplate (priv_spec_from_str/to_str removed)
>>>
>>> This resolves the "FIXME enum?" comment in cpu.c.
>>>
>>> Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
>>> ---
>>
>> This would be an improvement from what we have but I'm not sure if 'enum'
>> is what we want either.  We tend to go towards on/off flags that are more
>> QMP friendly.  So instead of enum property called 'priv_spec' we would have
>> booleans like "priv_ver_1_11 = on/off" and etc.
>>
>> And I believe we can't just get rid of the existing string properties all of
>> a sudden too.  The string option would need to go through a deprecation
>> cycle first, and I'm not even sure if we can re-use the same property name
>> with 'enum' instead of string (my guess is we can't).  So it seems to me that
>> the 'priv_ver' property is basically doomed to be a string type until it goes
>> away.
> 
> Enums are strings on the wire.  Changing a QMP command argument or QOM
> property that accepts only a finite set of values from string to enum
> with the same set of values is compatible.
> 
> In the case of QMP, introspection with query-qmp-schema gets more
> precise, which could conveivably confuse management applications.
> Non-issue here, I believe.

Thanks for the QMP/QOM infos!

If QMP doesn't care that much, and in a closer look seems like users won't
be impacted (since it'll be the same strings used as input), I believe my
initial reservations are uncalled for and it is ok to go ahead with this
change.


Thanks,
Daniel


> 


