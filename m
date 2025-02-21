Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A0CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 03:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlJta-0005O7-Gy; Thu, 20 Feb 2025 22:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tlJtY-0005Ne-Nz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 22:40:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tlJtX-0008I8-0P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 22:40:08 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L20aZ4001444;
 Fri, 21 Feb 2025 03:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f71Fws
 8zkeNuP8k5DxmZyKhAwvzMMcLHC/XBMWLD9SI=; b=j+eydptXgKMROK51+olYYf
 wtZba6cXu82+KGk7HihQZoDorucbL90MPyQWUm149x8ggsgbVirUBpFWUQmLWQxu
 pgQQtESHIw5mVOteUNjo88pIAkFqaqreFfHh/YYdPlygZhyF6jBVFhcZ49qarrQj
 1bHZBu0iczQSci7QpUKhJPTp/oh9RwIGLUId4VY9eDrfjxkUd70Nw4ERDNeMZMvV
 08wTstpxdlEC1pE3t8+j2hUUBaYP9bVI47KsUtb7NFdebL2oVU8uU1ws2H+4/Se6
 nSTxGnlpMIzH1aVSsuEw81VEqk1X2jytUbHFA2l7hwkqlPXuzuHIoy52czrthsKw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb08ac4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 03:40:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L1U5Vk027113;
 Fri, 21 Feb 2025 03:40:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025dr8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 03:40:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51L3e2aC30540386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 03:40:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 853A558059;
 Fri, 21 Feb 2025 03:40:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310BA5805C;
 Fri, 21 Feb 2025 03:40:02 +0000 (GMT)
Received: from [9.61.242.113] (unknown [9.61.242.113])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2025 03:40:02 +0000 (GMT)
Message-ID: <c47e1834-c6b2-49e6-8e22-f1e1ebf02522@linux.ibm.com>
Date: Thu, 20 Feb 2025 21:40:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <20250220105323-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20250220105323-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HShCxkvKOA0i2LgE5_pthQDyBwdqTF3c
X-Proofpoint-ORIG-GUID: HShCxkvKOA0i2LgE5_pthQDyBwdqTF3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/20/2025 09:57, Michael S. Tsirkin wrote:
> On Tue, Feb 11, 2025 at 10:19:23AM -0600, Konstantin Shkolnyy wrote:
>> Add .set_vnet_le() function that always returns success, assuming that
>> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
>> outputs the message:
>> "backend does not support LE vnet headers; falling back on userspace virtio"
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> 
> Thanks for the patch! Yet something to improve:
> 
> 
>> ---
>>   net/vhost-vdpa.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 231b45246c..7219aa2eee 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>>   
>>   }
>>   
>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
>> +{
>> +    return 0;
> 
> How about checking is_le is true then?

As I understand, the control comes here from 
virtio_net_set_vnet_endian(...., bool enable). That "enable" is copied 
into the "is_le" here. Thus, it doesn't look like "is_le = false" means 
BE. Rather, it looks like it means "default endianness of the 
NetClient". If so, the function should probably just return 0 in both cases.

I think, that is also why we have .set_vnet_le() and .set_vnet_be() 
instead of just one function.

If the above is correct, maybe I should rename "is_le" into "enable"? (I 
simply copied the name from another function...)

> And add a code comment with an explanation, please.

Sure.


