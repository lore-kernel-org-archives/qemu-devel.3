Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3E6C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlupq-0000BH-MI; Mon, 20 Jul 2026 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlupH-00089i-Gi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:43:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlupD-0005P0-SL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:42:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTQve3752632
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 evPbccQePK9+xKuCm0xjXOtQA/aq6aTomkUzqkmA3sI=; b=SLa7x4EDAUB2qvWE
 DjgorCNFfsNHAB5w0MAZH/NMyfsLES5n4vEiJSBybOp0ROx4hTOadd2CwnGyWR9m
 FtuQgTTLjcogVixa7fbJc2A9sRcVNUC0PhD0Wka/k/aeC5tlxo4wJESwohAJNcVF
 Ffd6+DU50IF0gWuVpt1CNgwhGMtsT0PhATMo3gevv6g8Czv+5hixtuPvB/heM+7i
 6r+8Dv+5G7pF6OsLGPV7aVhksBX5AXXGXmR+Fyz0JGbN404hFgKPapSvXgkrimVx
 0EA6WfxOz0FrrfH8eYsAO0gH+8vTcfe/C4eqzH+u5tcXCO4Se8NOIFXnKsMGdxho
 pOQFkg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5ru1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:42:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c07f25de2so99396751cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784580172; x=1785184972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=evPbccQePK9+xKuCm0xjXOtQA/aq6aTomkUzqkmA3sI=;
 b=Kq73iLaKPFimKOX6GmaGlzsxQN6+Mox7qiMWsPy+TdM/m59YByrlAu5RXW/iAF+o8J
 t3wH+0XIjeRyKdAFb2ycVBrCD+IPpkfgvyJit0m6C5e9E2DNE4StuKk4aZ+H6GGzCAUA
 UPrxXGrbwAnICwhQlnVTy8QQI/ehdiPDvhldT1apsTCLBhX2K0p5uglFtd7WoDMNyM36
 mXeAN0NsL9M8ZxjF8mUjyxBWrnLfjtghph5CE8s0v2jf3So+dYqS2x4xTTAsh8gu5ksl
 YUd4/Fi0+0wKTu7fsgo7Yi6+tyLgxlwZeZme6+QDn3662HbS+CeAJH+30WvkrPBFA68q
 5XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784580172; x=1785184972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=evPbccQePK9+xKuCm0xjXOtQA/aq6aTomkUzqkmA3sI=;
 b=bZhTEPrI1Ge1TjIPrNj/KQZsdj4SfhVYqlMxjsYZuKerIFuDIlEtnWVCwu9Dn/RKbw
 td1iRPgo7Iv9efiEwj+PMgkN0mQm7fLHuhnxsi9k/L9p8KeoYBcq2RA3f6E3oVePhexN
 Dth43xoYfQ6RVRUyWq8iMUhufYUDSU7wm2izYAqTP4td74PYL20FwL1/m1WF1d6XdQ/a
 iUhmayTxCia/9VzxPis3nRkCFUEMiXyYbuPfZk8/sNMKZ8KNK3dA1JPVOAVWJrP+y97j
 bcxGqF/U/uSj6CPIP6N4Aw6y94q3TpCNeh/f9a5iVuyO+3Kx5piO++kgSj5/Ybmf0Ggh
 QJEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI78IW/IqlKCNz5zeYQhtwOgr2Xy2mxDW1J5vBEBxkj3A1k1qlT2Hh1Tp2TsTOKQ7LZUVYfIbzoRN2@nongnu.org
X-Gm-Message-State: AOJu0YxwiIhb69qQlecEZgvJDB4AHNMgT4Q3cDFcwHrQUyc/CjnYGJ3g
 4wRV5C8qvlB9gLJ44nfzr0/USG0g50n/8Zt/J1TPvPnFGrRf9mBk9njndg7G80NEKo7COEG6heK
 MVX65ZM/rWvbT0xnpzvA88UF+3oJzj77ZMhsqmifO6G7JdDWXzDBdeJ3t4w==
X-Gm-Gg: AfdE7cnCLXvc6jNn+y8MocNmtic1xHrTof1uUltlmIgrzZ+CHh/b5fwoIsa85hRyQ+S
 K2RWzeOKPcxl0DCo/KyTj2ExinT1X8X4j3SR9JFBY96QYffg+RsphkgD+tUEtZQA2L87ohYeY50
 eh3vZV09Xp5ldCcQvAzaTjJChDODnXZcvUzKZ3IJpm/1/CCnCMny0pwnOodixunHyaWKPaFW3Dv
 dgRnXioTB/vKnokdbcR/geJRPuvB9F7qKpxF6K8pMgbkXpU3sFKouVg+hUkL9s5eT+bAqYty/TG
 D/WjMhFaiZWz4mkwZqmr1q039/qfOQp11PAFgJduyqJ5FRLfV0aIWZfVMps2i3NwF+7ozO8IB1+
 VughyanrMAk3n45FDnyhOlAixff+X2Ip15zHgOZRE11VQMIvg2+4=
X-Received: by 2002:a05:622a:5e88:b0:51c:b98a:244a with SMTP id
 d75a77b69052e-5213d0c6e6emr149550551cf.62.1784580172385; 
 Mon, 20 Jul 2026 13:42:52 -0700 (PDT)
X-Received: by 2002:a05:622a:5e88:b0:51c:b98a:244a with SMTP id
 d75a77b69052e-5213d0c6e6emr149550271cf.62.1784580171948; 
 Mon, 20 Jul 2026 13:42:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955de8895dsm100865115e9.4.2026.07.20.13.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:42:50 -0700 (PDT)
Message-ID: <7790107e-1256-4ed8-ba49-cab980197938@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7970030.EvYhyI6sBW@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyNiBTYWx0ZWRfXx7IO9aXyWOSc
 et3AppoXyXmiDkJXQbtNVyzEWq2ugSfz57f3h7oWmJee7rVm0iJ/h07manErpamMUiKODVd2F91
 1RYCl1/h+urTW1iM0tqrNrZ/INUXVt5yqP2lgdFdTlh+H6N2Hlo1/Va4TZP6fHxcSuNvaY1A26J
 O6TXyxkzL/WfUas6IK3AW9e8v5p0vsxv5JQzPm2TtZhE6E/8bfx2aLnXkBv9y0yjgzkhoZoSyxe
 Qfa/ntJK2F+GHPwedstkf/viY49gSWMchY0EfuMzSG5bE4RHArMp4flvWLyQt+mHc9PED9TkYA7
 FPNUEAY8sZj6SE+cppn99V1q5ocxpgQ0rXhg78wBF34QPYv2J1uASPjM5nSbh2lYx48X5shI9eS
 YAnKRfglJj+IJC+kViC76P3t49uVWfDhENXXWTSwaW1k3zRVyrm+3KV9fNG/U2prsLOPicjMTyD
 L27+HGGbV4vz/FeSiMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyNiBTYWx0ZWRfXz04ySdHmEKMm
 YemgXfHU9DTwE4yNqES0UsjSEHioLyyvulpqwfQxqbRUGMBBowLRcHajTtSRipnmYNrB/stULmp
 7vC+OV2x+FvrBviKvWzhNc7FATMpGy8=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5e884d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=U4s93ykpB3yW7ajRV6YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ZbeE_jqM27aeLiMp0Gcolvw8aMUObunv
X-Proofpoint-ORIG-GUID: ZbeE_jqM27aeLiMp0Gcolvw8aMUObunv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200226
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

On 20/7/26 16:02, Christian Schoenebeck wrote:
> On Monday, 20 July 2026 09:55:36 CEST Marc-André Lureau wrote:
>> All V9fsTransport callbacks are invoked exclusively from coroutine
>> context (the v9fs_* PDU handlers). Annotate the function pointer
>> types in V9fsTransport and all implementations (virtio and xen
>> backends), as well as intermediate callers in 9p.c (pdu_marshal,
>> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/9pfs/9p.h               | 26 +++++++++++++++-----------
>>   hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
>>   hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
>>   hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
>>   4 files changed, 64 insertions(+), 51 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
>> index 1a309664f6e..0e52ffbdf38 100644
>> --- a/hw/9pfs/9p.h
>> +++ b/hw/9pfs/9p.h
>> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
>>   void v9fs_reset(V9fsState *s);
>>
>>
>>   struct V9fsTransport {
>> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
>> -                                va_list ap);
>> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
>> -                                  va_list ap);
>> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
>> -                                        unsigned int *pniov, size_t size);
>> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
>> -                                         unsigned int *pniov, size_t size);
>> -    void        (*push_and_notify)(V9fsPDU *pdu);
>> -    size_t      (*msize_limit)(V9fsState *s);
>> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
>> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset,
>> +                                             const char *fmt, va_list ap);
>> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset,
>> +                                               const char *fmt, va_list ap);
>> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
>> +                                                     struct iovec **piov,
>> +                                                     unsigned int *pniov,
>> +                                                     size_t size);
>> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
>> +                                                      struct iovec **piov,
>> +                                                      unsigned int *pniov,
>> +                                                      size_t size);
>> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
>> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
>> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
>>   };
> 
> I wonder whether that could be made more diff/blame-friendly. Especially as
> this currently only serves documentation purposes.
> 
> They way you are positioning coroutine_fn it usually resolves to an attribute
> attached to the function's return type, not to the function itself, even
> though clang/gcc handling it flexible. For attaching an attribute to the
> function itself the attribute should either be attached before the function
> declaration or after the function declaration.

I tend to aggree it would be clearer to have these attributes /before/
the function prototype declaration.

> In both cases you could then
> add it to its own, separate line, avoiding a lot of noise.
> 
> /Christian
> 
> 
> 
> 


