Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C937CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwpc-0006pn-1l; Tue, 23 Jun 2026 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwpa-0006oC-Cj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:50:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwpY-0006od-P3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:50:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6ckJx3564025
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WseoSluQOsSeE+SJVdDm+yRedVCdwhBjTLKufyh/LwY=; b=ACdk9z0dRV7J5rwI
 NPx/ow+HHjP2Y8GtufVkjCk7m/hkjkJJm1m/bsR8scUjRB0najr5mlGA5AmS4IlI
 RxZkMYyAfVn1I7gvAyCBFre/GKZ5uBa4/J6ZESQoli8U6UM31dBCA020x2WdsxVa
 C1CFSXBhPOd3jXznv3nN4ijzD4soQ3lZnLFwe7sSPdNzuNowdNGs8vpDFoCynEjZ
 tWXrm4IwhWOCuAKqmKGt2L3Gnq/f/jfIGaXQNXgw4TI4Til2x7HsJj/VAmeNK3LS
 KUblqtNCOIEmE3g5uZrrqrEn3/K0xgQgByAeLhHsnNfpyctUSAMcQx7thYlXwo3Z
 pFp4ow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n43u8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:50:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598ab3a1aso673566385a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782204603; x=1782809403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WseoSluQOsSeE+SJVdDm+yRedVCdwhBjTLKufyh/LwY=;
 b=cUylN6e7KtCQ6QzgEq2x2RXUTBKuJbuAmGGvN+VoXw5C5RxTVZAjrO7Cfv7fxVRxAe
 GwcTZUhvKAIDQDwS6iaVuH2mNge6CSAb0DuIJ2c8EcszcL0eMbYsIYKV0fYEYXdOkuLZ
 abAfQoNOLADHGxaOXcWOz/CovFwI4aw0gELs8KhIApbDPkvUO7OqeQYUHx4BaAvGSEBc
 9bmTbBxKuV1MwDJfPy0Ugvg2YFL8R6C0ir3FNejKc/IRlkBAHjNqv09rIuGwNM4lLzBF
 ISVcR+4BD99KiVGBG9T89jwQjEU6sBTLsDVTkoyS8nmrVpHneR8pjF3jHplbTkMmvc9Q
 yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204603; x=1782809403;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WseoSluQOsSeE+SJVdDm+yRedVCdwhBjTLKufyh/LwY=;
 b=XSkBHWaGjjohJ3KBRZJm1SLqvHGv8VyQ4VCx9Gflkr0SICtpGfBqK7SdZFFmNmhBC5
 P6OqETaZBEJeTFADCwp0zg4rqH14VQq9mXvbhMsa3CmIyfM23ku6kOPebYoW4s87J/U4
 51ZGH39k87RDQ6qhVhHzpMNaRVWrun7SYrBNHWtgYLrNogZANE15dJZX8gsgZ58MMpUI
 ktZrSpSV4vjHpT80RTzY2sdtpVTPhvwBkFuvRRVHBx7+tropydc/ZkiDUJzl4grZML2j
 +2a7c9Q5mOrASLv4do7UfhjmAep2MtXWyRvMKV0ZH7bZWSLLabj/yXF00lhsICB/y5Gz
 itCg==
X-Gm-Message-State: AOJu0YxC2NzixVP2r8l498xSyT1pqHTz5Ezes/Xec/K7o/NjvZFkj03Z
 kq4mr5GVc7uKv5CMkUsC/0lhTseRhNYQ/uqMX7sSfA7XbDeXVVrypOwLFXOP2mdXCxCuFCeloyX
 qVs1gwSIfJ9hZzUvH0Qt/A7KjyXaJDaCnaLCCA8oCeaqBdhxSkuYZiUTChA==
X-Gm-Gg: AfdE7ckj++paY8oA/JlP42VdxqX5z/4rjJhih0J0UBTI6Sf1OsGQrHULtakNCAJf1jA
 fCyl4ooPIHGnOdthLi+HAONXX2ynbYOJ4cbfXGU0whgy/+ChXb50lk7JjVjj7n/9FFkLQh0i0Hq
 arHh4dGuRx2krI8RG9kHh9VK4iyVTkCJbmtgAiVfGVDu7kY1eg6F72J2+4ziR4AaenLzAkyIRYw
 0gZBsFqapthACMVrliAu8sqjsklnKbgRRKAJq/a/ek+PxnayjrbT6j3HeBeEBhO9g/OzeZ0ajaa
 eznfKzshWjK0OHnATLIkHDwVt1jT/xfvrD+lja7prVHiWBBC+y482W6uqsWB7ldyZch+GTLgU3I
 WOttFAqobJN2ZKTpg+dgalMdL/tUiyyQyeKZtIFNIYz9nP/x/NhkfHNfQVZwaKA==
X-Received: by 2002:a05:620a:6483:b0:915:6437:bc41 with SMTP id
 af79cd13be357-92645da02ccmr372258785a.15.1782204602952; 
 Tue, 23 Jun 2026 01:50:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6483:b0:915:6437:bc41 with SMTP id
 af79cd13be357-92645da02ccmr372256985a.15.1782204602507; 
 Tue, 23 Jun 2026 01:50:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e498807sm461884066b.1.2026.06.23.01.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:50:01 -0700 (PDT)
Message-ID: <8709dabd-628e-4e94-b25d-6641f99ca140@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Matt Jacobson <mhjacobson@me.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
 <b11f77bf-68e7-47f8-9c39-612edcf45467@oss.qualcomm.com>
 <5B21F4CE-023A-40B9-B3AD-F7B2A03C4054@me.com>
 <3ee29a5b-4f6f-4ead-8f7e-1c060cff83aa@oss.qualcomm.com>
In-Reply-To: <3ee29a5b-4f6f-4ead-8f7e-1c060cff83aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX9rZX3/IDROS3
 Xku9L8yABJ7Rg99dxpz8SSX2W/1ChJCBPGebniRQsJ8XI4jvd9P5CdyrE+mer7UpEvOA3AVrxP1
 IRtQ8SYji2nbkuJxRfpicjZYsmzy7AA=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a48bb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=K64Z2q9WfC19PRBxltQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: v9FlLBaIRiYKQUHEs9TJaEW8KtNwAB9k
X-Proofpoint-GUID: v9FlLBaIRiYKQUHEs9TJaEW8KtNwAB9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX1BU0YXwkVQGY
 4PIevI3vTqiP/Ay3fk7NISon3YQjC2OI5tS/gO2/d45aRY9Rg038GRAYLCRjawf74r+ECAnRf+P
 fKnmkbbBenKqLKyfXkzgPuFcX1V5I+hUtdyiXCrKhJ71e19lVrLSc8CXfq/9rpw72gkaNAAbuq5
 N5pXJMj2ZdykFpENT7vOPjCvAIyukngXV9HOerny+sg7XwcJoAAitb8aD1lJezL2W8atTdy2Yhe
 FaHb7G4fNY+Q5ts8yyt7HWS1lJ3mRThZ7EJnwwjRscFa1VqJ/TJb6E60GpGu3wE8eN68Viiy4B+
 EO8HEteWz5PUskAIsbBQ+4O57YKoU+yTElY5nlwSTTIEtI7OeSI4uWHLsiMa40xbFRX4s2PNa2B
 TwnMwucNxQMV9dNnl208jGZIVBWTenUEdZ5lCRiLlhed29F0nNHMBuPH1tL16eRSaVPsVMqfwl/
 l3b9MfTBJOgrtLNH1sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230070
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

On 23/6/26 10:36, Philippe Mathieu-DaudÃ© wrote:
> On 22/6/26 18:12, Matt Jacobson wrote:
>> Hi Philippe,
>>
>> Thanks for reviewing.
>>
>>> On Jun 22, 2026, at 3:57 AM, Philippe Mathieu-Daudé 
>>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> On 18/6/26 01:50, Matt Jacobson wrote:
>>>
>>>> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
>>>> +{
>>>> +    uint8_t bytes[sizeof(uint32_t)];
>>>> +    uint32_t ret = 0;
>>>> +    int i;
>>>> +
>>>> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);
>>>
>>> Could this work?
>>>
>>>        fifo8_peek_buf(&fifo->fifo, (uint8_t *)&ret, sizeof(ret));
>>
>> I don't think it would, at least not without other matching changes.  
>> The existing fifo32_push() and fifo32_pop() routines explicitly store/ 
>> load the bytes in little-endian order, so a single fifo8_peek_buf 
>> would not work on big-endian hosts.
> 
> I briefly wondered about endianness then forgot. What about:
> 
>            return le32_to_cpu(ret);

Nevermind, I just noticed Peter review on this patch.

> 
>>
>> The rest of your comments are well-taken; I'll include them in v3.
>>
>> Thanks again,
>>
>> Matt
> 
> 


