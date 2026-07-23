Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04FC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqsq-0003mO-A1; Thu, 23 Jul 2026 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmqsd-0003lJ-Ug
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:42:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmqsc-0000Ji-5Z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:42:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qWgr467153
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=; b=VIhOJVFcJplmZD8Y
 xzfmJxRfRWiilxy1Xqe2jmuHksd4oGh6qhq6hI6iiXEzPCGCmUMqDhSIgVe/lTma
 g1e+9xGoB3yhB3fo5tLvfRdVsq+RVOMBpu7CEUAf4DpMDAJjtR1Nm/1zY782veg5
 HcX2Vxo/ZBVXPiRUQ5mxSrmndGYJiQItxOuc8T/hqRTkNdBriZOdzlsWQFJC46NK
 RW5AMZeWdQpjkZlXdCLLeGLVQwCow0fi8hlK7gv8tOsEMpZjjDmZ6e6NFeSSbxdn
 JfLf/hNnNM5QyuGO4A8uPwNUfBBkBDzZSa0ohkIFycoMCPqrrjR0nidJBiUdVBgZ
 lnOLeA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xumby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:42:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso7387221cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784803333; x=1785408133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=;
 b=TpExR3ZjSKoaGLdlSLDr4dllVQ0nsVC1I5jfe5Qf5YPzo7ljnrEgCOjs5gYt9Af7at
 KacXQewza5E6jOhN4IiL8zpLzqmzC3r8uZmGiaQF/KILp9vhPQe88YpwyxGjlxcIfGJS
 tdGiCIS5GAzVwIDyKlj/ARniCaQ1qX7oDzuz/wE9oJkek2HylljUf1RkunAKoHFA0+jy
 TSjOHAxj89zSjy7UXiNdne3KTMVAwW5/3zckHtUq1IPXyLtVdpiCMna+f1+cL6Hd+wCL
 C9rW1SYdXXu0aDfh4sWI5b1JJOCvWFamnS6lrFJiifv9OrZez3e2WQKJSaDT2EPM7p9N
 oMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784803333; x=1785408133;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=;
 b=OiXugbDsyMoJc4mkoglBViMmsV9dJuzuxU1wIAMBZJ8bj24G91F8neizX3iq+aNbew
 3cwrP/h8SmHnbP23e7WMCucuv26EjAifrqRUqa0CgHbYoRAqRnYD4lIcKPDWSmG5cTJr
 kH+IbqEbTUQ6aBr8JYdqqPAuT0AujZBmZl+BM6C15saWFXKgmDKeDNhjBOWrohlXNi5a
 Aaw87avBlaS33Wjx0KCHZWx9F3wfre7BOC7JXueHO+J7rvZb1YMQE1Ob3PHJq4QaB2vv
 2fbRADlnowgPuCdDWVlx6fjUZ8eSbFvFK2dZGocIsXmnYmFCBqwsl74mWmzBNn0Yf1CU
 qpBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVja7TxHVp7d6rruZ7WtyzE2vscP0hXMVGJsAmb7tcgh40opoU+qPf43PxTKuymZbBLL4vCeqq5UqN@nongnu.org
X-Gm-Message-State: AOJu0YyobnVwiy8z6WBrxnvgj+I+VbC5yRRfT2aOzKz784nexXzVe73P
 93KBSPzz+nTQP24m9eByqskCwVSAjwM+cD+LxCeQIPR2QWTPRdfk7PKTuhj6+M5wRJX0kXfDy72
 V5hWl2F5NTRgHLY8oAUUXF95Zk9wKF6Ue+NMk4OtrLXaKzD3vQ77eHnfi7Q==
X-Gm-Gg: AR+sD13kIKMq92VS9azZBpUVoymeNHwrNwbsoJ0Pme2lvkMYxdfvxzwhrvKw2VRr5JY
 rHdc8U5Jua638wX16Xw/yYVfQWdNS3miPrWf/rD6libIDJccA7Fk6onAarWPvovakETPR1rf8Bh
 Epn0Ln1Z5P7Ij/RvyBkt1bxfYzbLx48aGDoUdWh1daEAMpSjXOWUyLTlmBf0j5iZMxxJWGydAR4
 qCol5diCG1vCE3eKIhsckidic6r5jiSKnfyoj/l3ws858/Prnw3A4vQvBIrBEtA0UWukXRbBLoA
 vD54qy8XkCk5B9j5ZLEDNKFqr4wMiVKMjKpwRo4barHF4jZKA6cOEGhiC57Cylom4U1V0BS4qZm
 DpRD4vQdPOA6Yna8B9yo2PMfrnVB+a+Apw4pzIQ5SDQxfEtft9Mo=
X-Received: by 2002:ac8:5cd0:0:b0:528:972:f597 with SMTP id
 d75a77b69052e-5283dfa12a0mr20960121cf.60.1784803333286; 
 Thu, 23 Jul 2026 03:42:13 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:528:972:f597 with SMTP id
 d75a77b69052e-5283dfa12a0mr20959911cf.60.1784803332892; 
 Thu, 23 Jul 2026 03:42:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bffefsm194425625e9.9.2026.07.23.03.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 03:42:12 -0700 (PDT)
Message-ID: <be427830-c5df-447d-9ef0-bf921ac1797d@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
 <87mrvightj.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87mrvightj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OCwCwnvXPxEa39HSC1j-vb0mvODG5Rbf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwNCBTYWx0ZWRfXw3rjSxTtYx2Z
 PdqTEd1lkFeWxzrGOoZ+t9OUN65Ou3g1kABz0fnycqSGZmS1Dn6y50qW3tkrDrxYa26DZHRKPGo
 tWEZz4HPxpCp59N0bAnbLimFh9ZQQns=
X-Proofpoint-GUID: OCwCwnvXPxEa39HSC1j-vb0mvODG5Rbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwNCBTYWx0ZWRfX4iHTL2TFBZ+k
 QRPJT278qxItRWoE1dK+3iEccR8mTc5QnrFRoT1r7u0rts4kCPf9nf+hdQ+rYfmxyk9EaOb1Zsa
 iZ9YP7YTVNbUI+UBhbvKhV7tS3acbei1mG3wfccDvG0nhucB8ZqWVQwwWJ8u+P0dWe4qd34Fo0I
 IzHg4wT8Y2zhgt5zVGwyfN/pY67RquvxTH+3hdLw7lYYNHNg332gbMWDo/NZHnMVZOd1AuELOmr
 ejYMAR9fIeCzl6ScrF5Ak3NCayD50LIeRcbScnukdU/2Lo4EeKEGaCrvkEidh6wqmdSAekqNnaL
 sGzHPzBFhpmqZo06JSQlvDu7oJW1XqphC64lFV3l0MEa5d8M5ysQCKeZg9WV5+Ht0NWw0foZnTX
 ev2kronjdct6s9xKmxnX4k/+jEILW7PX64b/KzIJo/Xgs1diI1XtENJVk+/dOp3ctlktgYi2FDI
 H4sskCjtUXKfxKc6UDg==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a61f006 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=8HBRM8kc7f_oyWAv4U8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 23/7/26 11:45, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> Hi,
>>
>> On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
>>> (inherited from memory_region_find()), but both SEV callers were failing
>>> to release it.
>>
>> Comment orthogonal to your fix; odd to have a non-monitor code
>> call an undocumented monitor method.
> 
> Which one?

$ git grep -w gpa2hva
hmp-commands.hx:538:        .name       = "gpa2hva",
hmp-commands.hx:546:``gpa2hva`` *addr*
include/monitor/monitor.h:57:void *gpa2hva(MemoryRegion **p_mr, hwaddr 
addr, uint64_t size, Error **errp);
monitor/hmp-cmds.c:715:void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, 
uint64_t size, Error **errp)
monitor/hmp-cmds.c:753:    ptr = gpa2hva(&mr, addr, 1, &local_err);
monitor/hmp-cmds.c:827:    ptr = gpa2hva(&mr, addr, 1, &local_err);
target/i386/sev.c:1579:        hva = gpa2hva(&mr, desc->base, desc->len, 
NULL);
target/i386/sev.c:2093:    hva = gpa2hva(&mr, gpa, data_sz, errp);
$

> 
>>                                       Should the method be moved
>> out of monitor/hmp-cmds.c somewhere into system/ and documented
>> (likely in system/physmem.c, also moving the declaration to
>> "system/memory.h")? Besides some day we should be able to build
>> without monitor.
>>
>>> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 


