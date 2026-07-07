Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527A3C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eU-0004Qt-TC; Tue, 07 Jul 2026 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dp-0003Ad-AQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dn-0000e1-Oz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8tRK3676459
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uy1yK9JcNvaTHtIbF1Ximn50kLc7i5YB0NcNB0Jm0yw=; b=MHpMpeKJypCSSROx
 2aDZeF7qPgxbZ3GUIwqMhAh4BZardFwWmkysNHwLWuQWcpk5X4GP0IaoNIKPKl8l
 B/1bJ+GzZ2jlvTGhZohdFTlH2+sO8ufZR9k97rN76gFoS+mOk92peya+LQXrihBs
 hbCXIST0UUCju+gp8yg2/5QGxLjqGn2F0I9xh0z7KvwQyIQmharnKXAAUWZobRlE
 eSUpR6OgoBCo0i1EzV1Q4RbioofBSDH3bVuTIKcp09nw0sKVmVV25DTHBFKj64yU
 LXptT/ZX85wQ2BHbB9UYZ6YPYhviJvI/zsV+r4QIDC2WsazkDeejrmgJaieU1BMX
 onS/Gg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15a4nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ee40bceb55so57852106d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430110; x=1784034910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uy1yK9JcNvaTHtIbF1Ximn50kLc7i5YB0NcNB0Jm0yw=;
 b=Z1arOs4pXBMHJQ4Uv+BjXcGoTje3ENb1U4NHpDeRGqPhEiccWzGEnExJKu+NK4ho5x
 ITfZ6yxjo3D4urCCcwuRXDtYLDAmsePf8zsu7WqErsv5+TQGuW1eE4/9gY8N/RAR63uj
 zGW5yS2A9Cc8U+QTGkYUsFSWETBfCIQMALU5rpE0ELec5ZzsftVrSY9hd2ovKBO1IIbD
 8PPRC7zP2CpZJz1eV7bi9tZgxafuV60ZMA+1Iha3yrQKBhiVgshjSKk2vsdyS+ErCNz4
 JP/GXFFu21tue6/b0r1zOKXzR9KlHKAIPMvyet8EGQLcaI+efm/boJfFx+U//GqAfKL9
 hkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430110; x=1784034910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uy1yK9JcNvaTHtIbF1Ximn50kLc7i5YB0NcNB0Jm0yw=;
 b=arqTgb1KwQ3aEoy4NaO9Wyt5SN2nUpjj/ADKAp/Jx982zWtw/s6j6MVUXBYEYOSTZL
 rD2BMgDWni48+PWdWyFvM9cZrdEmtXZnVmmHiK5RvDLDuXqWBwJF2qr5okyaiZcGPxp7
 uWbMI7kPcP5Ps3lEhGLjbMAI2gWujeGVuifK5rtulMK21LdMDQLoVG957hbNcaaki7qM
 PSIMNWtnGlOxOfQiLsTrEdAACG/osostf0GkW7aoU0pDOsyLgzEVQHpNgiM4J3GKv/L0
 uzkO/afNUB+NyhOP6YKwxg6ZbWcQ8EWgNRDtIZ3ZkQyEPi+Ya7/CEtsZQYQSW4Uvwwt8
 1CPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RovytFKQqxKuhNAAcEIUsACCkbkEmH5nYtKl6Z40oXsSH15XfMXSOnAXclSXJiUk70InKPycnZBxfo6@nongnu.org
X-Gm-Message-State: AOJu0YyJ5BN/a6jv68TEMMvNDaijdET6g1uvN/67DZVpZkLkX6GH4cdy
 YBc/b80lb3dFPpQ2ObkDvnOMzUuD6OoE8aTV22kkkVpDjpWknU+Law99XCnzymcERymPfZs/xZQ
 T6QzfC1Xm1xTdXxKW66wWiTejzRwccA6LYKVy0khrSwhVHzPPAzoI8UfoHA==
X-Gm-Gg: AfdE7cmfRCx2R1Lo2MY+267xSAhJCf6FveKQGOUkg97R8Xi1VwRj6bM17cR26ebCC47
 vmU71k7GNfe4W/MLHvJCQi+cdx1jqaxlRnslVu04rVxsmD4TDo0NjBdRA/pMrUeN9VDVsQtJigP
 kfw4g2K6Aeya/uoQKwqKrcBPwpW+1eSc7PZOs/iwziG1XkMQY3mmkcJyIKm11HZmofGl36BQ+iL
 jVvNKbaV0W1Ac4FEdAwusXCxWu2UvxOCid0lu5HQQ7tDJX6K/0zUxH87uNOhZrAK03HfgvSnbcL
 MT513pZcdCdyZ2s6Vt0R8+uIFIdfCOdq2tusAHXEAYtUe67I8W9KOyeI1aRMrAm751ByHnCCMS6
 lQGTW1z8cjW3iiEJ6hdXPxuf3L/zKWYMcSfCbhjsVqKaChjIT/hmqOn68Kszsrg==
X-Received: by 2002:ac8:5989:0:b0:51c:164b:b240 with SMTP id
 d75a77b69052e-51c747a039fmr65186871cf.4.1783430109967; 
 Tue, 07 Jul 2026 06:15:09 -0700 (PDT)
X-Received: by 2002:ac8:5989:0:b0:51c:164b:b240 with SMTP id
 d75a77b69052e-51c747a039fmr65185471cf.4.1783430109091; 
 Tue, 07 Jul 2026 06:15:09 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a9c4a4027sm902222a12.29.2026.07.07.06.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 06:15:08 -0700 (PDT)
Message-ID: <1f9dddf1-7d83-4365-996a-6cfd4a15ec46@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 15:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/ide/ahci: cancel in-flight buffered reads on
 command engine restart
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
References: <20260619112158.304782-1-den@openvz.org>
 <20260619112158.304782-2-den@openvz.org>
 <ce8ebeb2-2509-48be-9ea1-afee614859a8@oss.qualcomm.com>
 <70fa6511-acbf-4b9b-95d3-1670fdca80b5@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <70fa6511-acbf-4b9b-95d3-1670fdca80b5@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d_1FoIhfDYYuqBjSic0iIV13U2Ynv6Pe
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cfbde cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6rqHouBjAAAA:8 a=KKqn9cdbFrReuDu9NyMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-ORIG-GUID: d_1FoIhfDYYuqBjSic0iIV13U2Ynv6Pe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0oolRPE6idVZ
 e9lRtOH3daNi+LJzkUX3O3OMD3WmYhkdgeS8VJXZcZNZk+CH2FidOeCf5mYNzmctwfTSB5X6dhS
 2STzyticfFCy7ty+e9rHWT+qidEHtwo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX7hgiFwYxBMXA
 qRkvyS9vXQ8jB8e//MDTBiI3uYqmGDluGkWgoIOuadq6ofmQguW+nyLiwbTErpaQFMufxMY/A3H
 aYtB4gayxrm52fCYkku082DUj6owlPxsIYtGdvK8IVGsDFaE0G1plhzLv8/w1s3RHz6JZ9t3sdc
 DYi13IiMMJYWrODTj0bmmjFoYr0q0B48PW9kIL2ikl2HJQnH8brEX1Pz2L48t0qGELwhT43494r
 3V0uAEGssC8OV3lEjC33gx4SD1Dk+YZslF5EvIwlArKYnaIj5AmaS2h7VMJpAbGGZRAgvVUcHDN
 I7WVthg5qY6/rwaL/K4HTX4m+9MUiJokpR5G27GHXLvdeZnI2DjZGlg1SyRMkZ+Jvnu96r6+gWB
 unCXGew5qj48x8sv3+SA7nSfapLjNJxiE/0RINuw7Xd4Q20nvRGOop2BteN2dV0PQrGIqXGNr2R
 UNxnwx/XyBUZpkuanOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Denis,

On 7/7/26 15:02, Denis V. Lunev wrote:
> On 7/6/26 09:21, Philippe Mathieu-Daudé wrote:
>> Hi Denis,
>>
>> On 19/6/26 13:21, Denis V. Lunev via qemu development wrote:
>>> ATAPI CD reads are issued through ide_buffered_readv()
>>> (cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
>>> The PIO path discards the returned aiocb; the DMA path stores it in
>>> s->bus->dma->aiocb.
>>>
>>> A guest can stop and restart a port's command engine
>>> (PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
>>> the engine unmaps the command list (ahci_unmap_clb_address()) and
>>> restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
>>> but nothing tears down the outstanding read. This path does not run
>>> ide_reset(), so the drive's transfer state is preserved and the read
>>> still completes. Its callbacks then dereference the stale or NULL
>>> cur_cmd in the AHCI transfer helpers:
>>>
>>>     PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
>>>          ide_transfer_start_norecurse() -> ahci_pio_transfer()
>>>
>>>     DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
>>>          ahci_populate_sglist()
>>>
>>> Both crash with a NULL cur_cmd; the PIO variant has been seen in the
>>> field.
>>>
>>> Cancel the outstanding I/O when the command list is unmapped, reusing
>>> ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
>>> the completion callback with -ECANCELED (which tears down
>>> s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
>>> so the eventual asynchronous completion is a no-op. Merely setting the
>>> orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
>>> at a freed aiocb that a later reset would cancel.
>>>
>>> Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> ---
>>>    hw/ide/ahci.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>> index c2b4432b94..8e3684cd3c 100644
>>> --- a/hw/ide/ahci.c
>>> +++ b/hw/ide/ahci.c
>>> @@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
>>>    
>>>    static void ahci_unmap_clb_address(AHCIDevice *ad)
>>>    {
>>> +    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
>>> +    ide_cancel_dma_sync(&ad->port.ifs[0]);
>> ide_bus_active_if(&ad->port.ifs) would be safer, otherwise the
>> patch looks reasonable.
> Anything else for the series?
> 
> Should I respin or this change could be cooked at merge?

I took this patch via my hw-misc tree (using ide_bus_active_if) because
it I could understand it and it looked trivial enough to me; however I
don't have enough knowledge (don't feel confident at all) to look at the
rest, I'm sorry :|

Regards,

Phil.

