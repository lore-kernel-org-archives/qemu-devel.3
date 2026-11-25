Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DB606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lTSpgcB9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MwddVDwv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9WW-0004wU-55; Wed, 25 Nov 2026 04:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9WR-0004vc-FD
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:42:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9WP-0005kV-4X
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:42:38 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP68T3P2629342
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 REL3xuDBFufBfqGNorM/M7wKX11UjF91htEmpOE0Q30=; b=lTSpgcB9OlM13cC0
 j7TqsE0x779fSpaszpvPJxBNoI5KB9xUX2TkqHNvj5L+3WpUuIpqbq3ujAruI/pD
 f4m1EY6a4hKC1xuVCQuXMmIOMbqj1lMU7hhK89t6fq7MBSbRbWyIWl0qcbPHycvM
 MhL+4KGFQBAM0ZBcBQf9muPBMH1PcyvrDHHo4Xid1hP+SH0+tU1PDR/nwSKs1TKN
 ACFxylekTfOyxVvulwhUHFo9OhJdH6s67R/aBY3YaoDUpEW+M1IY5MQZ6lCiHFXe
 RFM4bjJ2VP/4WnXcG+IoP2E0/AKZNyeg8dY9dPw9nDNo35d9QOB2oJlwFpHezLco
 2+qG4Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydbgdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:42:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9493e89d4f9so799428985a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599754; x=1796204554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=REL3xuDBFufBfqGNorM/M7wKX11UjF91htEmpOE0Q30=;
 b=MwddVDwviCFSnEXiKQHBdsYodt4pfdtFI0P8Ynap46ppZ3S0noqtDKcRwHnWWLGqcL
 w1cJYPbOM5KwFm2l/4h5FOs4Cwm0bJHgMZGQJcSe2tRDeTL4s7SclVQpJLLDMG1r0j7l
 Fz1F+u04lXNxxwHye3ueI7DEqazvPcqJ3uWKMzUJqF34TEdIFyGdF9A9az60MQMaG5Ut
 V70INOpdnAM9BivLFYEpnX5e1lgF0f+8OWRWEhma5EeZpCb6a7hiPPMHT3AQTbMHrYKa
 34vND2IC26EmT43QcOu3iRAb674DQra1NN3X8V5VuNrlBoeCkiC6wa0k7UwyF3YmWKhU
 DS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599754; x=1796204554;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REL3xuDBFufBfqGNorM/M7wKX11UjF91htEmpOE0Q30=;
 b=PZJ8t6fixUyCPGIbtF6dhCVZyxz3r4pjq0iNvs5nLT5oZ9dbBSExvpDeKXZBllGB25
 DaVQYvfC1gYEq9JXdanuubTvp1mHMdmnhHeeEwXStERcQ11E1+NCmPLBE7YoeYtVNovR
 8xXoNtPkZqv7GxblZyVlfcmbE/rAi0VYs+nY0GgD7G+EZofDETMrV/LUmDWmqbbFDAwu
 NG/n1M212Dk/8d+yWpUslxLe/vIR3O3AX8XQ05VXecOajr0o7+17PvWR/A5+dMB8P9u/
 qq7TYrpyiDk+uHhCbqBIWlRWyuG4Mrh+pvQ/HBo/NBN/pmroBRBZud3gU02/MhTIDlSg
 WH7w==
X-Forwarded-Encrypted: i=1;
 AL+hErGFzgM6HFxSJVSYmhX64b/Ca/qgxRxGcvQAHqpwhzV0kKG9Cu1EkwZozB3/BeDHIwgKwePNZSl0pgOG@nongnu.org
X-Gm-Message-State: APuU4Z+5h4W1KAreTjidjh6Yyxnu4F+3meco6jKIb3DqOrR9Yiygk1ow
 5RXiAcI7RpWhGckclCO94JbJuXUTTXMmOxueqvUR/VslKBPw5AcCCswqjFWLordhXafACmQDsjM
 exNNcYFyUERa4OnMZ5qalJP33tSIAq/VhnRKSJxRNrJZNfdp7w6bdhh8OFw==
X-Gm-Gg: AZFdTZf4uiLN5C+rBE0DSxANotKfVycw99Hix1wXbewLg2irKq7PjBFng/8hE+nTcOp
 B4uoBa/4FRyqo8k7FRmnOpHsENoDq37AsEPCz3EyEQVYYAKsFvg5NxZXC8QxzVPE+favTpd6uFy
 ZkjEC1pUNJoTegoqZi4J5HjLgr/Wqhlrdobn3Da+3a9VYxlGLsGNhQDBAXseFVQHXfckiWahpG7
 Zsav9TbbNKeIDADmaRMUzxqrso2C4OltPt025DYtoZjorXNvqKV5QmUa7aGKVPI0+2+gNa1MzUG
 IYB4Td10j9ddDOCS/Mf0yTKutufyEdQe0fYQ0sklF9+9BnpUw2WEqVbC5MhCIqy4oinctaHIYOn
 CeBMHyJ45MP1GIFma1SrrDjZJlfScUCf9qkrZGSvQZgw+9mJ49TZKfuJWVDjJ25Q99pbyqSqFdK
 wuVFt51m4=
X-Received: by 2002:a05:620a:6846:b0:93e:c12c:9b71 with SMTP id
 af79cd13be357-949bab6416bmr2777627585a.76.1795599754202; 
 Wed, 25 Nov 2026 01:42:34 -0800 (PST)
X-Received: by 2002:a05:620a:6846:b0:93e:c12c:9b71 with SMTP id
 af79cd13be357-949bab6416bmr2777624985a.76.1795599753714; 
 Wed, 25 Nov 2026 01:42:33 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm471875835e9.8.2026.11.25.01.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 01:42:33 -0800 (PST)
Message-ID: <54c83094-e441-49ba-ba89-d4ef7bc40e78@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 10:42:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261123231319.377104-1-connorkite@gmail.com>
 <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
 <awakcwEP6eYCeb-A@sgarzare-redhat>
 <CAJaqyWcUpP2c-B70OLeWyBpkZjVPsN3Vm5iyAUVeZG=DaR6+Hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJaqyWcUpP2c-B70OLeWyBpkZjVPsN3Vm5iyAUVeZG=DaR6+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX57Ip7RH2IUhH
 +U9K0HeHB6xdet9eU3CZPosIIMdIFfu1CFdrEm665JpSVSCHNjMfg961tylsrcNVDobwg+6NjZn
 510HJGmQeaYecSW85VjW5b/GMcGSdyw=
X-Proofpoint-ORIG-GUID: cIfV582MBISqu2FgxMZs-1LMaGASLjO4
X-Proofpoint-GUID: cIfV582MBISqu2FgxMZs-1LMaGASLjO4
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06ad8b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=wrf73dZrMbFPcPHM-vEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX5QRwYFP6eJiW
 MpWGpeVRmNieG7+TwQgfbmQsu6KXdtPSPKJ7jI8JIxedE0fwDCKGzSPuDg+Hattx087pNY1GTFq
 jjPdZiA/E5mAS4MoR/sJh57wUqLin55YVtD7uXPoof6tMs0Gfr62FlA/82yJx2+2S7iVAo+aFcL
 gQx8R4XfJcXQ8+aiyg4hyAcZzgUaVLrkJKGkLAqS8Mv0sV4nhfS1k69ytFEVI7NrfGki9UkRrQj
 G4p9rNiFVhQdNvzQZTb2s5x5KOf7MOdCnrRAdfcM/ffnToaVUNdeBmFy9Ro/ktj56rM+ThP6BbT
 cm2ou3I7zvJ7+ximZePIgNZ7I6if4A+xmps4SNYFRrExk3Gz3e65gAx/1oXYOSFuKYcrFL558hk
 mbyPHSZ7kEe7lcZWRraV3gnbugzq+BKPFRAYrdDuTBuEuQ9cdKNnkdL2q62f+7tLbz4DK5YFcyU
 NvTh6CTVrFu/WFmW5Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 10:16, Eugenio Perez Martin wrote:
> On Wed, Nov 25, 2026 at 10:05 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 08:41:04AM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Connor,
>>>
>>> On 24/11/26 00:13, Connor Kite wrote:
>>>> When a shadow virtqueue detaches the buffer associated with a used element,
>>>> it adds the descriptor chain to the head of the free-elements list. However,
>>>> this currently happens after svq->desc_state[last_used].ndescs is set to 0
>>>> in vhost_svq_get_buf, introducing a bug.  Only the first element in the used
>>>> descriptor chain is added back into the free-elements list, with subsequent
>>>> elements being potentially orphaned.
>>>
>>> Not really added to the 'head of the free-elements list', but the former
>>> chain tail to free_head, then makes id the new head. Suggested reword:
>>>
>>>    vhost_svq_detach_buf() uses the head descriptor's ndescs to find the
>>>    last descriptor of the chain and reinsert the whole chain into the
>>>    free list. vhost_svq_get_buf() currently clears ndescs before calling
>>>    it, so multi-descriptor buffers are recycled as single descriptors and
>>>    the remaining descriptors are orphaned.

What about that suggestion?

>>>
>>>>
>>>> Zero out ndescs only after the buffer is detached.
>>>>
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 86f5f2546f03 ("vhost: use SVQ element ndescs instead of opaque data
>>> for desc validation")
>>
>> yeah, I was going to suggest to cc stable and add a fixes tag too.
>>
>>>
>>> (Please check this is the correct commit introducing the
>>> zero-before-detach behavior).
>>
>> IMO we should use
>>
>> Fixes: 7291b1a5f8b0 ("vhost: factor out the detach buf logic in SVQ")
>>
>> @Eugenio can you check this?
>>
> 
> Right, that's the one that reordered the operations and introduced the
> issue, thanks for finding it!

Oh, I thought it was a mere refactor preserving behavior :/ OK.

> 
>> Thanks,
>> Stefano
>>
>>>
>>>> Signed-off-by: Connor Kite <connorkite@gmail.com>
>>>> ---
>>>>    hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>>>> index 462c86dc1e..1afd3edf87 100644
>>>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>>>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>>>> @@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>>>>                                               uint32_t *len)
>>>>    {
>>>>        uint16_t last_used;
>>>> +    VirtQueueElement *detached_buf;
>>>>        if (!vhost_svq_more_used(svq)) {
>>>>            return NULL;
>>>> @@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>>>>            return NULL;
>>>>        }
>>>> +    detached_buf = vhost_svq_detach_buf(svq, last_used);
>>>>        svq->num_free += svq->desc_state[last_used].ndescs;
>>>>        svq->desc_state[last_used].ndescs = 0;
>>>> -    return vhost_svq_detach_buf(svq, last_used);
>>>> +    return detached_buf;
>>>>    }
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>
>>
> 
> 


