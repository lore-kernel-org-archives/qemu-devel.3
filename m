Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF98C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlv0l-0007pc-L9; Mon, 20 Jul 2026 16:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv0k-0007nw-AQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:54:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv0h-0007yk-Rm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:54:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTgfD3622334
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j1yaI9+UfRFExxJWNuN1Irm3lmYbG6CVl7bu6i2Vrzo=; b=X0vUQZthLGy8i433
 mR5mzBPnxNQhvq8pyqcdPPYxs0hKq6ojsfeLyBxhEQoJ2kX+7XzzlpWH1x1ZcSDs
 af4H7NlkefIYXCHgNr5aAjK0sPygak+dQyc4LR1u9+tO/dTCPIEKaE89ZlJNhapx
 Vn/sxHP9Vpg1ejGKmMYRWOQMIhZiA4HX7sDtlrUGUe/Ku1tsbG00184P9hbj3ZME
 PAJ9G3/PP+aV6IdigP4fqQ8+lA6qb66XYHSJkff2ywNcZwsiE9Pxw1+oAo/ekbOb
 cgb7nh2pNKgugnYFcgMlPvLb3mXgVxbnCH9jiKLCW956r2vbXIjVzvZqIm5yzTo8
 YN6OmA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxkb5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:54:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso78998731cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784580883; x=1785185683; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j1yaI9+UfRFExxJWNuN1Irm3lmYbG6CVl7bu6i2Vrzo=;
 b=DDCQn2gptSEXbw09Al6Ho8r1+SEh0HsJBAiL6rs4mF8nigGn6ZM0+y0MwzOWMLESVE
 JTP5Pn0xZfSbVD7o5zud8xSYnpxtTnQyZ2JmefNjLE8P6d2tlWIRKORdy14ySSY8ZOck
 0y4eD9gaqpD1tWsompaffw3Efo58MZVuyKK0DM+yPzac8ZeUE1j1OTmm9NIUBWk60QXW
 lo9tPWbk9xD8Au42X587i1xqrmzaOvz0lze9lGw/xMMOsi500drI/9X4lzful4QRRgxz
 5tj00XGEBFTgbMg96ivy+Q3wWs9c5aWiEoElf+SD2S0oL+MH9B3QqJZGuMvv1/IcfBqh
 is0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784580883; x=1785185683;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1yaI9+UfRFExxJWNuN1Irm3lmYbG6CVl7bu6i2Vrzo=;
 b=r8IqONz8zS60RQRd3Dg04dYd7j4oJ6OVYD37XYm2CX7Jf0Zn5wW6l8BsNg1VU4bqH/
 EKDKikvBIKqyg1eX0OxQAYIA2Xtx6wH0EsuCFN+5bw2mMffdYiJzFfPwzlDoR7WKdK/G
 2HVsoaFQJWlvW8f8bWISAIe1+pT//OHRSW8UWDTxpYMC7pcsbCn95VJShJ0J0bEbkBvQ
 lSXnSUpbC6+KdCKNcKf6/0LCu2Hpa7Yb6eiL0/XxpimV4Ej7zYwxHRFX29HU7ynEdRLQ
 VCAiN/JfmHs4wfhvtFZ39g+RA+2MAHrgv8I2+idNpNqK5XY3XhfPk9FEYBDCjG4sbMrB
 v5uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgFOLGl67EHBFK1UscAaXBAqlgUpT/saHtI+tdVfnMVcG5RxZTNOxgPFcy4/xyXbuxVUR5gGQ/OGJA@nongnu.org
X-Gm-Message-State: AOJu0YzT1xe99iXQQVEcLwLY9OVFHemwqW9d2stkV0M9ok2uvahm9FLd
 PS0sprwulS9MqF1JERKBtaX5zDGn+VBEBDFOW6YvH9+Szh7Q734awTxhM2n1sd/4v9KtAZjmDjN
 XdY9TjMw7EruAMUpk379W6SWELrTHJmR4ZDjgFxpkXRSU5dCcYGmveYXxIw==
X-Gm-Gg: AfdE7cknZPCXQQDZLmReqogh02lG5nKmvX6j6qjFLN2dfZjMH/QantC7LYYNCWaitsX
 YG7uMw9F0FCQG9yeVmUBTOhP58XyW9CyeCSgFfFin1XUNq3LIm3zOgvQ9A4RGg4xeiNt3iTLHVX
 SjWwb/tbRoWbBGZd6GTvLkWkbRUFb1r33se2ofvNnDYhOZeMHqc28QDMtaygnDcbmpR27x1Prc9
 LuRz2f7SGvHjFgNWqt9diPRlNbhMTyc5uh2wQOvkp3apbxh9WJS9ZVhzs2oeY4ihHu+nJWukUrE
 xqgi+tSsyuzDeJEsmQrLEHNSjgDNILXmnGRdRoKjapMwqRDQnrBPa7Wq3VaVR7RSGDpSWVIlFHd
 UIvu/UJ5BPfT1cnSqs5O4dYHy77hHasgKbtnM5laOmcp6cPj8lS4=
X-Received: by 2002:a05:622a:60c:b0:51c:98f:f288 with SMTP id
 d75a77b69052e-51fc1293160mr201720201cf.25.1784580883411; 
 Mon, 20 Jul 2026 13:54:43 -0700 (PDT)
X-Received: by 2002:a05:622a:60c:b0:51c:98f:f288 with SMTP id
 d75a77b69052e-51fc1293160mr201719971cf.25.1784580882969; 
 Mon, 20 Jul 2026 13:54:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547319dsm13811755e9.5.2026.07.20.13.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:54:41 -0700 (PDT)
Message-ID: <5af0aaf1-d372-4800-9f6f-8f5dacd8c69e@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
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
In-Reply-To: <7790107e-1256-4ed8-ba49-cab980197938@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e8b14 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=FKbDSFgr-VcrMEy9-l8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyOCBTYWx0ZWRfX0mU2l9oCzJnT
 27mr9tLnSzn2zznMC9rRzZ4rywNSh4Sri9apGL3kd+r07V6wTAr9BGl0x+bRFoiz0z5fBtSIrze
 b5oXepdYoOnQa/2lPg2PV8vPnqVewoI=
X-Proofpoint-GUID: WUm0sbBwuNgsDdrE-kBhDfD7RHLBzXW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyOCBTYWx0ZWRfX8/bsPTfIZ6TG
 V8IZfSXLu7AI9F/M5kteJcdXP07IJQ99JL0JFTgSyUxM60Zk2SSwNBosbxF+r3AhLfU7J4AfNuM
 UdwkdPjxFNiXpj9WPtQ7z72zLaHZ+LQNya48rq4mojn2uCDJJWpMFmGxnu/Obedu4SaFwoYI9Rv
 SkhMErY/6BEdLlVnfzAWQALThopIAJ814VnJQ/scFo3lVgh6IFGOUkI3Tq7oACaIngUbSBYYurB
 Itqz1RxL+y2v3l15vPm/Z4NgiaAQY8AsZ2xVz0oLEYD2pKfXAOy2h1FTlNEwHFojGu6Lsf507WX
 ZU2deVkp8DYr4954wZ4SMJHmgUZE8+SIRCkuKLjH024M/RVVMlr/078ljW7ctJt/W8gSGs/aOsj
 DqyxodR33+Zhzh5Mq8mVHseX2XjywXx/QgbAyCTaeTKS2l2rqwpYNy16pphZEhywb67Di2X+DZN
 kMU9dyoE2fyGrZeZ+wA==
X-Proofpoint-ORIG-GUID: WUm0sbBwuNgsDdrE-kBhDfD7RHLBzXW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200228
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

On 20/7/26 22:42, Philippe Mathieu-DaudÃ© wrote:
> On 20/7/26 16:02, Christian Schoenebeck wrote:
>> On Monday, 20 July 2026 09:55:36 CEST Marc-André Lureau wrote:
>>> All V9fsTransport callbacks are invoked exclusively from coroutine
>>> context (the v9fs_* PDU handlers). Annotate the function pointer
>>> types in V9fsTransport and all implementations (virtio and xen
>>> backends), as well as intermediate callers in 9p.c (pdu_marshal,
>>> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/9pfs/9p.h               | 26 +++++++++++++++-----------
>>>   hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
>>>   hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
>>>   hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
>>>   4 files changed, 64 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
>>> index 1a309664f6e..0e52ffbdf38 100644
>>> --- a/hw/9pfs/9p.h
>>> +++ b/hw/9pfs/9p.h
>>> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
>>>   void v9fs_reset(V9fsState *s);
>>>
>>>
>>>   struct V9fsTransport {
>>> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const 
>>> char *fmt,
>>> -                                va_list ap);
>>> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const 
>>> char *fmt,
>>> -                                  va_list ap);
>>> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec 
>>> **piov,
>>> -                                        unsigned int *pniov, size_t 
>>> size);
>>> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec 
>>> **piov,
>>> -                                         unsigned int *pniov, size_t 
>>> size);
>>> -    void        (*push_and_notify)(V9fsPDU *pdu);
>>> -    size_t      (*msize_limit)(V9fsState *s);
>>> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
>>> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t 
>>> offset,
>>> +                                             const char *fmt, 
>>> va_list ap);
>>> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t 
>>> offset,
>>> +                                               const char *fmt, 
>>> va_list ap);
>>> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
>>> +                                                     struct iovec 
>>> **piov,
>>> +                                                     unsigned int 
>>> *pniov,
>>> +                                                     size_t size);
>>> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
>>> +                                                      struct iovec 
>>> **piov,
>>> +                                                      unsigned int 
>>> *pniov,
>>> +                                                      size_t size);
>>> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
>>> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
>>> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
>>>   };
>>
>> I wonder whether that could be made more diff/blame-friendly. 
>> Especially as
>> this currently only serves documentation purposes.
>>
>> They way you are positioning coroutine_fn it usually resolves to an 
>> attribute
>> attached to the function's return type, not to the function itself, even
>> though clang/gcc handling it flexible. For attaching an attribute to the
>> function itself the attribute should either be attached before the 
>> function
>> declaration or after the function declaration.
> 
> I tend to aggree it would be clearer to have these attributes /before/
> the function prototype declaration.

$ git grep -E '^(static )?coroutine_(mixed_)?fn' | wc -l
       90

block/block-copy.c:47:static coroutine_fn int 
block_copy_task_entry(AioTask *task);
block/copy-before-write.c:106:static coroutine_fn int 
cbw_do_copy_before_write(BlockDriverState *bs,
block/nvme.c:1351:static coroutine_fn int nvme_co_flush(BlockDriverState 
*bs)
block/ssh.c:1223:static coroutine_fn int ssh_flush(BDRVSSHState *s, 
BlockDriverState *bs)
nbd/server.c:3077:static coroutine_fn void nbd_trip(void *opaque)
block/block-copy.c:581:static coroutine_fn int 
block_copy_task_entry(AioTask *task)
...

> 
>> In both cases you could then
>> add it to its own, separate line, avoiding a lot of noise.
>>
>> /Christian
>>
>>
>>
>>
> 
> 


