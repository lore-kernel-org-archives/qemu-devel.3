Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00B610A88E3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nLD-0005Bf-Pw; Thu, 26 Mar 2026 12:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5nLB-0005Aj-Vj; Thu, 26 Mar 2026 12:13:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5nLA-0005y4-BF; Thu, 26 Mar 2026 12:13:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q22Eku510743; Thu, 26 Mar 2026 16:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a5m735
 RuCIPo4EvuWNvqaZGI1e/4UQGOome3hmaf7Cs=; b=e4MD9IuLIIH4Xw4vh4OAJm
 uXKheGdSuaRnSkrSxJ3CcMS59olYpSqvmmRV7Qrmo5piGlP6S5n1zLabDZ+x5gyP
 XdpYpE8Hd2IZGXh4M/srJqt9lAL03xyiQajY5dYW7be5qilh6ER51Ltu/om2IRsl
 a+TT190Ct0GM+BAxxdiTz+EubDMgfBWqBJChC6xDhqNxA9J4N/IGJfr/frGqGTnj
 HdZLqvkaVRwvYJ2/EGvWFmMnEohGDZC99xKWb0KV+Ynm7+4QUx3HTcAs4HEpEu4l
 OhMT8+Pq4vINKae0/g+VG7fk0FiTRZwcyeFSTs/IDPMcWduvwmxzLBcCp+8t6iDw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa63f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 16:13:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFUDBv005983;
 Thu, 26 Mar 2026 16:13:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yut01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 16:13:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QGDd4Q29032772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 16:13:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 283E55805D;
 Thu, 26 Mar 2026 16:13:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F6FC58054;
 Thu, 26 Mar 2026 16:13:38 +0000 (GMT)
Received: from [9.61.246.71] (unknown [9.61.246.71])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 16:13:38 +0000 (GMT)
Message-ID: <c4449a84-a1eb-4c43-a0ec-38b8b7270309@linux.ibm.com>
Date: Thu, 26 Mar 2026 11:13:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com>
 <20260325165611.GB701300@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260325165611.GB701300@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IwLW-Sr_b7v3vwHuQ7X-ZHOxFvTGIpCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExMiBTYWx0ZWRfX8xe8zBh0DE3u
 9MVn96NLT+79AQglQjvuCLqMgx388+Nm/ECvL29PpVqvb0DVriRc6gGR/V4/JwVn2zZbJ1Q2YQB
 r9seDfWm3o8if8N4+zJl3d20lM3OugHjDQMZcs2jEnjLlHzu/rJN1ao0f/LevkLNss0FXuiWnI/
 IoyMl6SNATW9Z1TfI0lTNpRyz2URRDOt2AqvQSu7SI/UyRnV2LXYC0PXv3Mqnj5XHXJNPnl7U6f
 ufXZ49XRTtke6MAN18wk2AxgwSWdqbt65MT+gOsO2cAbm735UaHVct4dY5lZ94WXu9SN49jbeJv
 ZuBSPleNAhnCLUs15FqblvPLC7MWfIcWen8iGMFOsb3ytfsEGh4/gWsa7v7uYXKWDyKcEYbICZY
 wMelzwNDq7pNsL2cNgx5WCz2BzCnDxlsZXZ744r9xjB5f8wQ8ofc1y1bpfojG6pmJw/Vt0S60kr
 Vog+nX26pC382VBACRw==
X-Proofpoint-GUID: IwLW-Sr_b7v3vwHuQ7X-ZHOxFvTGIpCk
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c55b35 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=goUCaTe3GkpOFsHYKQ8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/25/2026 11:56 AM, Stefan Hajnoczi wrote:
> On Mon, Mar 23, 2026 at 08:54:51AM -0500, Jaehoon Kim wrote:
>> @@ -831,7 +822,8 @@ void aio_context_destroy(AioContext *ctx)
>>   }
>>   
>>   void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>> -                                 int64_t grow, int64_t shrink, Error **errp)
>> +                                 int64_t grow, int64_t shrink,
>> +                                 int64_t weight, Error **errp)
>>   {
>>       AioHandler *node;
>>   
>> @@ -848,6 +840,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>>       ctx->poll_max_ns = max_ns;
>>       ctx->poll_grow = grow;
>>       ctx->poll_shrink = shrink;
>> +    ctx->poll_weight = weight;
>>       ctx->poll_ns = 0;
>>   
>>       aio_notify(ctx);
> On second thought, now that the divide-by-0 protection has been removed
> and these fields are assumed to hold a valid value when poll_max_ns > 0,
> aio_context_set_poll_params() needs the same 0-protection as
> iothread_set_param().

Thanks for pointing that out. I only considered the user settings and
overlooked the possibility of this being configured in test code or
other areas.

I will add divide-by-zero protection to aio_context_set_poll_params.
and update the versioning to 11.1 in the next version.

Regards,
Jaehoon


