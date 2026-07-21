Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C73C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5nO-0003M1-Iz; Tue, 21 Jul 2026 04:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm5nM-0003LM-TJ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:25:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm5nK-0002sI-Hb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:25:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L82xOV093186
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZF1H2C3sWBUxUFeIPjxdM+X09KSU/DDuULUiVulHlSI=; b=GNBaIcbLoQV99QXL
 OhrtQ0Pj22BxtEAMk95gFHQeZ8f/ZXiZbZibdU03AJq/2+Cl00kUde9Hm61AKgvY
 5pgZ7q5CUVkhigqqQGr/rDaaZguJqiLwm/+wF0xZcqyoqI4ytErNBr68P3Q7JjYf
 THUpq4s6wLjto8PkbfaH8B0KGyfiHOP8kIOL/6edMe+9nwbZa5XB0JIDRJ/Nf927
 EbN6oW/4CbcqqEIqNGT091PB4ZzJoNeZhWAOd4CQungifm5Ecf1iKMk3DRhw28zS
 qc8CKk/ZIF0N7eL/JX9qD6D2ufe95eRN9l+A9xACL9NSgelE2MGYEbM8ZNS6sxcb
 oSh9Ow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a9bs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:25:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso217317831cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784622337; x=1785227137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZF1H2C3sWBUxUFeIPjxdM+X09KSU/DDuULUiVulHlSI=;
 b=VJF+DGfuoSp0oWckOOcyDkPzybmKsMuHgcSVKxaAHgiXpU30IATShWoFM+188ezu5U
 YbHh4grJvhxbmGiPyVQirbwQAHgRBsxSLlJaDm+fscNo7jRUdj0KFKM59rrBkrkEcWzE
 t0eih8G+k7CtHdBhUXSxNoO/JmPjbu4s0PME0uWwaHv/ubQ+lHCKkphiDH3ukiChOFeD
 ynjZdzOnRYUT2uj9NUsXu7lxYI6GYrAlJ5lO7lliUo4QRKuyjq9FXxisJHncyhmwsEkk
 RrdaBn7vww3L75dhKqqM4oJkMyaGVQWgCbc7lAlGPaILBfGx7RGlRJSfWWQZg6qqT0w2
 XB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622337; x=1785227137;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZF1H2C3sWBUxUFeIPjxdM+X09KSU/DDuULUiVulHlSI=;
 b=m63dGu1D5fvDsi5XPLFbgAYjVp3tWHms9CvyALR4xWk3RyQizToqhrCJ/WX/zqzZkR
 6WmdMTjOYk8x4rOCilTU4+kGqHIL6TxymrgJgOiX9KjB74puQH48m6EfiRy0O1ZF/XaQ
 E8n3HCdgYAskZjNwhxCOMvYT7JTZYgMdX1zogefifGBYAPhTbqSqdjTlOxovdZifRm3N
 oPJASVQO9gMTRAXPN2StEXRX056mA5ec7gISoQ+5W9U0x2DbJUu3e9vzkLPFFrQYIiE4
 ysHzU1uVpaMIhkd+O5f9Rfzu8OeqKP2elwG6dXuZwP+Nh9y+HuEWo7Nho62wKIMyfdtO
 eG5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr548eCVwTiYPuh9XnodhZOAXSVD7p5lxabYl6nb31Pynz6gdWjBbFmnZRyT+CU67qOAiBAJbgY4pR7@nongnu.org
X-Gm-Message-State: AOJu0YyUrGMop+6onwQFDH0Cm2/zTIeTHuluzbkY/y5g4j1lxstGG4Hx
 nYRpI4LDNTY4jw03tE1tJdMmXGlyVqgUU6uqRhx0B+xWEXVR1q0eA2dpQSwYIcGNlvD/1ZQZQBX
 epK62AIcwx2bAbSKey1hmNJQomwYbJCOzG4WuZ9p1MV/V4P2gUDpH7effpQ==
X-Gm-Gg: AfdE7cm3ibGZs1VM/f6QvNCcUQyZ+G2Iy15c3E9zmXIIMu+ciUvK/znX3RnUtk24HaR
 izXXXakl25Gm8LUdsppetRXLoIwHKi0yWYjii7BM3l6EID44l+0wNmTk2SvdfOP8wJOJbcqRmaA
 r29i6AuuMTVdU1M5GPvJnCmSQZ5SM+V6j4BLDrFc0hs3GrdHN4YUgswvzkAY/bH07+Lc2FpBkWn
 Qat6I2syXW9bvPit69StNGtc/SQN70/aXEHQ0ub+sDw3Sg+7SD3Z2ouOEZRxa/KvaGH7gf2FsAd
 nOMy32Gz49P9cJgtkDtk/x7XxYqFTKzIf6RMf33ciOK4TIyJrNXzxUqi3bdhVs7pr22L21lGvzO
 fKT2lW9a2YK39cs8H9eEvJqeSbmqeXPA7JxL34SshaAp72zjbgo0=
X-Received: by 2002:a05:622a:2517:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-5213c008207mr155290461cf.7.1784622337585; 
 Tue, 21 Jul 2026 01:25:37 -0700 (PDT)
X-Received: by 2002:a05:622a:2517:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-5213c008207mr155290121cf.7.1784622337125; 
 Tue, 21 Jul 2026 01:25:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547323bsm52072685e9.4.2026.07.21.01.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 01:25:36 -0700 (PDT)
Message-ID: <af19f823-234c-462d-8c52-4d8cf4b93c4c@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 10:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-7-fabb4db3c204@redhat.com> <7970030.EvYhyI6sBW@weasel>
 <7790107e-1256-4ed8-ba49-cab980197938@oss.qualcomm.com>
 <5af0aaf1-d372-4800-9f6f-8f5dacd8c69e@oss.qualcomm.com>
 <CAMxuvaxREAH4K45UYeC6PK5fnYXTZW9nitRApMdtaxOC6rPDow@mail.gmail.com>
 <CAMxuvaySONs4r=1Bmsao1f1cZdviGGwPVM8+1Q+1vdY0X-pYVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAMxuvaySONs4r=1Bmsao1f1cZdviGGwPVM8+1Q+1vdY0X-pYVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f2d02 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=i-HqGOpKeM9wF-ee4XAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX8eFfl7CGKTL2
 bzdO3RFVh9ky/bcuOiPAdYTdhWnerJPW0nxw1FLRhXhDyzDbdfhEiWqgl5oJXy38KbvkSBTG5vs
 /SKf6KnrxQTg+KbB1Kiamsd4gM1LQ+SiyMSWGyHnKays0XSj7VgCi+QR8Y1OaZ4yIfKAaa/ENa3
 fps2TJuk2pU5eXrR5gJR7X88UqsMB31v4ToKevH7EJ2Ucv+ktVNiWHwBieV7xKfLZwmNQ29EuCE
 luaP4RnODvKiOi3ZK6mX79d43Vo8ERBfYpERb0N+WWk4v3DdMZUlegw0bgOAyMaAgkd+T+/Ocv2
 ww0dZRfh70Z4UM4QsL2COk8VhQgCa/XZX9xHV6YnitxhsV5Y1/l3U8AAG7NuSO01lesaJsmmHNZ
 vBpejiSpSNm0Mey90htbeXBxk5nRCdYA3MYu3FZRrwQ1uElqCTN+lMsO0dNu9vgYpQUdgvSh7ki
 m1pAGJq2nWtSzt6EVLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX1kE3sfau/nXD
 eBmvCpBFzib0L2YqGto5NQVHPkotAGgAAgxMG6EdWWVhVifYBgVVxGVCEVN97hvSKp1HICuBSmr
 9IckSGebzI1uep7l+3fD4IQEXsqkbpI=
X-Proofpoint-ORIG-GUID: ifVhM3L89pVumDroUnLo1byNepPY6xod
X-Proofpoint-GUID: ifVhM3L89pVumDroUnLo1byNepPY6xod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210086
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

On 21/7/26 10:06, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Tue, Jul 21, 2026 at 11:58 AM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> Hi
>>
>> On Tue, Jul 21, 2026 at 12:54 AM Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> On 20/7/26 22:42, Philippe Mathieu-DaudÃ© wrote:
>>>> On 20/7/26 16:02, Christian Schoenebeck wrote:
>>>>> On Monday, 20 July 2026 09:55:36 CEST Marc-André Lureau wrote:
>>>>>> All V9fsTransport callbacks are invoked exclusively from coroutine
>>>>>> context (the v9fs_* PDU handlers). Annotate the function pointer
>>>>>> types in V9fsTransport and all implementations (virtio and xen
>>>>>> backends), as well as intermediate callers in 9p.c (pdu_marshal,
>>>>>> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
>>>>>>
>>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>> ---
>>>>>>    hw/9pfs/9p.h               | 26 +++++++++++++++-----------
>>>>>>    hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
>>>>>>    hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
>>>>>>    hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
>>>>>>    4 files changed, 64 insertions(+), 51 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
>>>>>> index 1a309664f6e..0e52ffbdf38 100644
>>>>>> --- a/hw/9pfs/9p.h
>>>>>> +++ b/hw/9pfs/9p.h
>>>>>> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
>>>>>>    void v9fs_reset(V9fsState *s);
>>>>>>
>>>>>>
>>>>>>    struct V9fsTransport {
>>>>>> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const
>>>>>> char *fmt,
>>>>>> -                                va_list ap);
>>>>>> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const
>>>>>> char *fmt,
>>>>>> -                                  va_list ap);
>>>>>> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec
>>>>>> **piov,
>>>>>> -                                        unsigned int *pniov, size_t
>>>>>> size);
>>>>>> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec
>>>>>> **piov,
>>>>>> -                                         unsigned int *pniov, size_t
>>>>>> size);
>>>>>> -    void        (*push_and_notify)(V9fsPDU *pdu);
>>>>>> -    size_t      (*msize_limit)(V9fsState *s);
>>>>>> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
>>>>>> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t
>>>>>> offset,
>>>>>> +                                             const char *fmt,
>>>>>> va_list ap);
>>>>>> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t
>>>>>> offset,
>>>>>> +                                               const char *fmt,
>>>>>> va_list ap);
>>>>>> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
>>>>>> +                                                     struct iovec
>>>>>> **piov,
>>>>>> +                                                     unsigned int
>>>>>> *pniov,
>>>>>> +                                                     size_t size);
>>>>>> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
>>>>>> +                                                      struct iovec
>>>>>> **piov,
>>>>>> +                                                      unsigned int
>>>>>> *pniov,
>>>>>> +                                                      size_t size);
>>>>>> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
>>>>>> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
>>>>>> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
>>>>>>    };
>>>>>
>>>>> I wonder whether that could be made more diff/blame-friendly.
>>>>> Especially as
>>>>> this currently only serves documentation purposes.
>>>>>
>>>>> They way you are positioning coroutine_fn it usually resolves to an
>>>>> attribute
>>>>> attached to the function's return type, not to the function itself, even
>>>>> though clang/gcc handling it flexible. For attaching an attribute to the
>>>>> function itself the attribute should either be attached before the
>>>>> function
>>>>> declaration or after the function declaration.
>>>>
>>>> I tend to aggree it would be clearer to have these attributes /before/
>>>> the function prototype declaration.
>>>
>>> $ git grep -E '^(static )?coroutine_(mixed_)?fn' | wc -l
>>>         90
>>
>> More like
>> $  git grep -rnE '\b(coroutine_fn|co_wrapper[a-z_]*)\b' | wc -l
>> 1343
>>
> 
> That matching is not accurate, it's actually hard enough to match all
> annotations instances.. but this should be a rough estimation.
> 
>> most of them are "return-type co_annotation fn(..)"
>> we even have scripts/block-coroutine-wrapper.py that relies and
>> produce this order..
>> a bit late to change the style imho...
>>
>> At least, let's not make this a requirement for this series, please

Not a requirement on my side, but if we had to pick a style,
I'd vote for "attribute before return type".

>>
>>>> block/block-copy.c:47:static coroutine_fn int
>>> block_copy_task_entry(AioTask *task);
>>> block/copy-before-write.c:106:static coroutine_fn int
>>> cbw_do_copy_before_write(BlockDriverState *bs,
>>> block/nvme.c:1351:static coroutine_fn int nvme_co_flush(BlockDriverState
>>> *bs)
>>> block/ssh.c:1223:static coroutine_fn int ssh_flush(BDRVSSHState *s,
>>> BlockDriverState *bs)
>>> nbd/server.c:3077:static coroutine_fn void nbd_trip(void *opaque)
>>> block/block-copy.c:581:static coroutine_fn int
>>> block_copy_task_entry(AioTask *task)
>>> ...
>>>
>>>>
>>>>> In both cases you could then
>>>>> add it to its own, separate line, avoiding a lot of noise.
>>>>>
>>>>> /Christian
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
> 
> 


