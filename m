Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96615C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNXg-0001NR-1Q; Mon, 27 Jul 2026 11:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woNXa-0001Mn-KA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:46:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woNXX-0004zr-7W
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:46:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlWEL3663476
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F9sKh5gOkCTARMAyyH7RSKBonzqdfbyB5LJOpMEcJv8=; b=LQ6snYqWKf7EnJcr
 bdftCxDCox3ClEpijKvmUilf2gxq8iSE0tJGahHvG8TzpR3QWWphPl1LW1QpEYH9
 HINOBuD2W8bGyyJrdQMesO9iijlY7TzZNjghuG1LHAnP0pShqkkL4CRUxXiHrjAO
 lx6k22HEJj/ZiQNpo/qb6ZQKnZ+wwUzLkJ858wJIS5WI+ILBsRA2/FQxbMJVyqqE
 nYpuv2kDG9qZ4dIQHd/i5zQX+RylRNkjJiePCaJ3dk6bK8IiFLLcCAhx2EagH2GM
 8jDrwTj8PcrKIA2oRBx0jkHs29obx3bYcLh0L21WUCs3M5VVifSusnQozdL/nnPu
 6eakPA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asja62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 15:46:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso3152156a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167207; x=1785772007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F9sKh5gOkCTARMAyyH7RSKBonzqdfbyB5LJOpMEcJv8=;
 b=Dwi7j3JE6OzcdBBfgAFsOv4MHYufi24tfZQgy2JxCnrwrUC8eH2H8rC4LT71DHXHYX
 wF3kGNInvocKqAdIkeeQZwejebku80WdSA9/PWJcJiwcwnjkXRpGmqtPjEGVwmuu+A8m
 jytjxLQFaVXNeY5GSN8ngAl35L23lydqPCGooQV3ODt0eFDtEwha/wht6ATG00hCZwKd
 rO2O0Lfh61ithpX5RPklzwk8jidkxyOjk/E+kEYKzeGWemedtytQ5ig2LHwZZpdyyMIl
 iIJfHk5Prk8TdkIaVO3ZIAakXCaGqXMILfIVL4zdeXEJnLVVy7RCqpKf5zj57xjhyFkU
 l9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167207; x=1785772007;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F9sKh5gOkCTARMAyyH7RSKBonzqdfbyB5LJOpMEcJv8=;
 b=FRzDUakoeRp/iXzGt1ZbhMVZL+zdFnBuvXncyXFKoUi9FniPWpKZJdAnSdFx6JR1er
 U4cNxRr9Cl5O+CyboPg1I/UcfMUpizTSgqMzelx4labtCXSPdxvED8V64+xMGKMVxdQw
 adfebBQTgEPZ7ESlXdqZ+dgf2KqaWmjJyELIga8YYT0baw/yxdt8MROgxYC2BV15foTE
 EOyBy44WpDylu3WJc/E48ayXCQYFO/Z92/6WiLuoNzbYaVg2zPBbkduxvlaiSWAKk5b7
 iQJA45WiqfquoxmoOfSVpGMQzD8pCHVwEUOLCF1qzONM1v9z5xmi2LyInGwNwtIaHly8
 ro0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3Nv3Mh4iZAzUe2hxiSH4K8MorNddrYyK+pm5leFxskGvCAMaXlxIP7lJGtZM8XTkFEOlKlVjah3uo@nongnu.org
X-Gm-Message-State: AOJu0YzpkonJMwaZil7MeWOy6/gLmxKa8F/1LJmiFTxe2ybYJsHAFrNI
 M85xIXTzXU7Nkpu+9ogPrUGAkXvx/7KUlFp7sINCTdscMVRbkrViEWczUCfpwhQrefJB1llRgMd
 43w3Tx3K3ZyRx+mesBgQ7Gs8Ax9ZgWVhPwNZnmX4AHF00fsju4ayIjCWjFQ==
X-Gm-Gg: AR+sD11B3Xt0awuXjZPB15fc7u8mDIgr0k7mWF3zYPe4SzVXqF+dky8tRttDEVGuKCl
 fm6ScurClVR3VtdAOBZkb7ShEDu5eeej1g10xFrZjyPuwb/1frQSYxOZ2VsqkrT5qntKC7Yweo/
 q7hQhy2e3KyQ2TNEpR87hqFWppS9VmUZRwxIYLX+iapbFUHYoQcbPe7O/DHR+8ITWunOdD3eNI6
 LQ2Z79vkfSnBSY24R2ZCbbG58woOvSIP2vIbCwLshSo58N5CA7evHxhqHSEu4XFAzp9w1qWPHib
 vcm66j2rSKyWljA6rzzmxkz0blIXOZp2+AjiUizxUKlM+lumCUrrT4o2tmYvxTl/f1DYNCFINz4
 Z5ZHSzZfvF7uY+rdpH9O4LHj5HLRV8Qmep2vTqu4pDugBI3vjmvxFNCmoB5qglcYSFi1E
X-Received: by 2002:a05:6a21:1505:b0:3c3:80bf:a861 with SMTP id
 adf61e73a8af0-3c67e073a1fmr8177684637.75.1785167206490; 
 Mon, 27 Jul 2026 08:46:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:1505:b0:3c3:80bf:a861 with SMTP id
 adf61e73a8af0-3c67e073a1fmr8177648637.75.1785167205946; 
 Mon, 27 Jul 2026 08:46:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e585ae882sm22690495c88.6.2026.07.27.08.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 08:46:45 -0700 (PDT)
Message-ID: <aef3ae1c-4ef5-4dab-8c8b-4fc22aa3e801@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:46:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
 <a9766fa1-7c20-44a2-b12a-9d3455cb9198@oss.qualcomm.com>
 <720b6dee-23cf-427d-872a-a9ff2b61bc7a@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <720b6dee-23cf-427d-872a-a9ff2b61bc7a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXx2txx36PxaUg
 kIR8c3NmXHM4NLh3DzYDt5ayopR9cxwz322oKlVj88bCWXdftX2iLdA51ETAHk631jqzJajPXF7
 YLe0YPR+Kpa4rjaKkSXZfMJ7mXkh8SR3WqgXiic9Fqd/QvSC0LuIHhGDVwaU3SrEeg2Efa9IEVl
 ROTsUnpGCfbrfkxEOsCLQZy7uIGVaUqsYg7JRJgTUPWPd1qVVN8S890GDH/HRvmd+ab8YsMocnA
 6/SXU9ndo78bmckOCjsvAX5P6OQZ78eP5OLUWs1aq01s3b9crlrXHY1jvXRrl+bYEbdmdf+Z+Pv
 U47wNm6ro0xJH8f96KJ4IcMN3pys2UcaCtjdymK2+ekTmq459sR1xBNkj8sbwQnmi7LQ+4+fsJw
 CB2z4O/cdsy3csuRAJltjvmUDOiEvzEEOfDVXw9LggINnVy0IeSDZW4a565TV7iLIZbnRxQl8On
 8+D/78c/nNpFr2xD0Ag==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a677d67 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-s5C6LQxMhJ7sG5PlN0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3sB9JiTV316K
 88huYYKXuzx1ehnbiawbSSUI04rHRJT+QJSVv8gPujuBl213O4xS/Q4xhKgi8S6NBgdDMdVr5LV
 zHPwX1VN2hz2MlocaJV0yx0OK2o8pUs=
X-Proofpoint-ORIG-GUID: 3ywFLKu9fiVPHQdwC6DZBYEeZZRIl6rw
X-Proofpoint-GUID: 3ywFLKu9fiVPHQdwC6DZBYEeZZRIl6rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148
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

Hi Chinmay,

On 7/27/2026 6:32 AM, Chinmay Rath wrote:
> 
> On 7/22/26 21:42, Pierrick Bouvier wrote:
>> On 7/20/2026 12:24 PM, Pierrick Bouvier wrote:
>>> The existing compare function only make sure that we list cpus with PVR
>>> order. However, we never compare cpu names.
>>> As a result, while cpus are grouped per PVR, the order within a group is
>>> non deterministic. Depending on QOM type initialization order, we get
>>> different results for -cpu help.
>>>
>>> For instance, previous output could be:
>>> Available CPUs:
>>>    755_v1.0         PVR 00083100
>>>    745_v1.0         PVR 00083100
>>>    755_v1.1         PVR 00083101
>>>    745_v1.1         PVR 00083101
>>>
>>> While a sorted output should be:
>>> Available CPUs:
>>>    745_v1.0         PVR 00083100
>>>    755_v1.0         PVR 00083100
>>>    745_v1.1         PVR 00083101
>>>    755_v1.1         PVR 00083101
>>>
>>> Fix it by comparing cpu names to have a stable result.
>>> This allows us to record and compare various command line results across
>>> versions to make sure we didn't break anything while working on
>>> single-binary.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   target/ppc/cpu_init.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>> index f404c7e549d..3443dbeeb01 100644
>>> --- a/target/ppc/cpu_init.c
>>> +++ b/target/ppc/cpu_init.c
>>> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer
>>> a, gconstpointer b, gpointer d)
>>>           } else if (pcc_a->pvr > pcc_b->pvr) {
>>>               return 1;
>>>           } else {
>>> -            return 0;
>>> +            return strcmp(name_a, name_b);
>>>           }
>>>       }
>>>   }
>> Any chance one of ppc maintainer could send this for the upcoming
>> release?
>> This would help us to compare command lines across QEMU versions to make
>> ]sure there is no regression.
> Hi Pierrick,
> 
> Thanks for the patch. Looks good to me.
> Since this a minor user visible change and also not a regression fix,
> IMO this would be a better candidate for 11.2 ?
>

It's not critical indeed, even though someone could still argue if it's
a fix or not. The biggest advantage we would have from it is that we it
would allow us to compare command lines between 11.1 and 11.2 easily by
having stable cpu listing for ppc targets.

> Regards,
> Chinmay
> 
> 
>>
>> Regards,
>> Pierrick

Regards,
Pierrick

