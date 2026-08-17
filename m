Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C478C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoNr-0007bg-Ft; Sun, 16 Aug 2026 23:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoNo-0007bJ-IU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:51:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoNl-0007ef-TY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:51:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCweU4127640
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /CjvkaaB3UcwF3ooP2kGc80FWmp91Z8nNrA8Ve65zaY=; b=VEEuRrS7larDzqr/
 uYyXWbw4NXx7/EszyEzTtvq6X13u2HpdG4DgbygxqX/W9EsTuVc1IKMnbW85QpBs
 Tz2E4My3h3eek9MiUY+uB4Zkc2axj+gwWCqTHrBCjuxyLCZjBorHOgV46nscRv8u
 jJNGj9nZbZEZRfQbK5K1KaCbk9d4M3mrNRbgqcsxUgQNZr6TefOvbM3L3GzY1ODz
 E7mnilbtfKsBhfdd3aUXD956EVhRLwD/V0B7UHb3t027pzpxHO1VsY1lLoxZoDZi
 NNIlKK9ycClAvG+RDbrmhmQ3kvnXJYdnYDtAPQr99ItAtAyeIxl4Ai4QRZM4lxQf
 /McxTQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322qaqam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:51:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930edb4362dso277541785a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938679; x=1787543479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CjvkaaB3UcwF3ooP2kGc80FWmp91Z8nNrA8Ve65zaY=;
 b=TsoYnz0eq3ZB83yr9ezq+mgh2zdSqkajLhPwQ5/SYnb3POyqFlE0eYtzKY/cKCOqhs
 q3p6XUJQARPfyCNOnqnBZoz/c2rZlqNNnWJmC0i6NQQ4E0swj3k6vbvI98rxzxmvoyoO
 9lExioPJCRlbyBX/JljSxMpPQmI0utOjA1ZKnmrnpn1vlFYTsBkZ5C1jO+4aXZitVFSx
 s8+XZyGp5psQ69IQ/2zbQHPGQzWInaiOtzQd3Q+pofbQQz/bdJ0Wo7XypC3/Ck1ZKSF0
 pIkIpIMdCUfUBZAQa23XU9lWuC2FSemMt/9HWunVqmb2lIAyhnWRfSMBNvqDUb91zW1G
 q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938679; x=1787543479;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CjvkaaB3UcwF3ooP2kGc80FWmp91Z8nNrA8Ve65zaY=;
 b=Lx2Ixd4tVQ6o6V3GcHF6w7R5Ku3XSxXJ/v/321gScN+MwRy+i8ozEoQoNwZGMBBjjh
 LlRNP+5IRHgtDctFTu632JyAEPaSaWl8ThSVC6NBbYMOLKcDurYlqrIHOS2PNsf9f72N
 KcuZqaZABYhYBLOQNEc2mWVo1nHl3E2Dn+xDFfA9CqM2zPsu9+JiibS4mFxCwUU+ALfO
 mKGQ4hwYxK3lz1oJ2YZbcpvXP8zh+oC2/4KZvTVZsAdkY+rGXQhE+5ONF+kq/TX43NIo
 avjyCb1KqYjUssbVhYpd2ELOU04CToCYsdQXdC90QYO5BIh2xmer3f2OXDY2yoFiF1QW
 HRpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqU/j2M4xVwhtv15Y4O/bZNexpOsSEzLY2kBrxzvgIHmvXHpqbcUQIVmZOB+NAnu/Kw8D4APZQACEIW@nongnu.org
X-Gm-Message-State: AOJu0YwZ+nfXwdROyAsizWtnW97Kpa1wz4wdCUnZWPjFMOZKjaJXEw5C
 wdD4/Pp51WkdPo1cN0Bo6Pnrve7Qou7GNhqEbrnDaSNMHNlHamgY/lTAiG7fljIlvm13rpFbvGt
 LWm/yTYh6wQspvXIbVKHuanhPrSa4LtxjPA8pznZOe2mxUvi9bOr3yR2MXQ==
X-Gm-Gg: AR+sD12jPpQX3y6xY1kSGDwx2nV1OLAyWXyjx4BhNXz0A4+AiIqI8+M+qKuR+FPH3JC
 oIw6JhAa1RNxBk6Sl13dXw6e75H+74+3wvRRiBRjrPwXz/C7HKoBaPzXBabDipnpRQ57lcJXADp
 dSMK2s1xEXxapOrRX+OzHKWU29eOzYeOj04KpQrYgZYRHe16PLOBflyweuyHNCusY4ETmcfH+8h
 /xYLeND38IHCSI02ywFjkDGUqDDSb7YsNb9DmpFbar2c+NGddiuwFmq08UOn+Ul79eY94dbFAYn
 r7hPZw6folsIG/JNojJBNctAGOc6et/KKS/lkMOH34lmb8KHThdHq6CI863SDbqyKaQnyn86VRP
 tKlAPZMBINTMSopCl6BWXBkUFGoQA9AK+W0c=
X-Received: by 2002:a05:620a:1790:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-936dc4c3c6bmr1910513285a.28.1786938678980; 
 Sun, 16 Aug 2026 20:51:18 -0700 (PDT)
X-Received: by 2002:a05:620a:1790:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-936dc4c3c6bmr1910509385a.28.1786938678439; 
 Sun, 16 Aug 2026 20:51:18 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d10ba73sm3767275e9.13.2026.08.16.20.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:51:17 -0700 (PDT)
Message-ID: <d888fa4d-8ae4-4355-b46d-f4707f166b87@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/49] hmp: fix snapshot_blkdev argument type
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, qemu-block@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-3-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-3-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX/LzfZWQDiWNo
 zlzo5rm1YxY9h0yU7rIvAZ2M8B+b1jCK5OlUdQcJJLYD13Rs9QYqbp/e93itty3iXafk8jAz+rR
 VtlO2R6KfcYfRuI51zjYscmiM9/thq8=
X-Proofpoint-GUID: VWbRmsgsmMr3ykCJy_u78UVtXDFUkqOm
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a828537 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=9ZdWyPzQA4qOg4iVudwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfXyHTYd7KJD56H
 g42C13wlaav0jYUt3R6YpaFRjU/F2EbwYlHwVZ+5IANrRgOCHKDAn0sa//mJFxqfugtKUhaynBB
 l5sxcQlhwbiYIY/yO9DQyRQkY+G9yn50rV0uS2Rq8LkaAejZCacLvkszg4Mwg6WzHBwBD77ZvET
 bUk6kmEejBoccmlhiDIYNbiftMUBkIoK1z2GCE4bAph9qwPwsw/wLF7JYOiFTX8+RsdT3ZKfxrs
 mJlK0Sscuo9gwa3KDvz5B9VQyGhagj/dE8LKFDJhhzIsefSbu2AGOjsmOf3w+qCcgiUYjk4Vnob
 0rCbivPN16FOM8mUZmtruhTMacTJPgPTG+qkjT8MaoQ2Nm53C+0BjxrVTm2Zrf5++INxex2qGHw
 ar/zgWvxogVPQNJvNK8H8H7gSpDekgavjtCnNQMLMS9zEKhuMw8oGfj158kfZ+49YzsN27T9jqF
 Zlv/bQykUSW/7Z4K/nA==
X-Proofpoint-ORIG-GUID: VWbRmsgsmMr3ykCJy_u78UVtXDFUkqOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170026
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

On 16/8/26 21:12, Marc-AndrÃ© Lureau wrote:
> The `snapshot-file` argument for `snapshot_blkdev` is mandatory. Correct
> the `args_type` definition to reflect this.
> 
> Fixes: 6106e2492fe ("qapi: Convert blockdev_snapshot_sync")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/monitor/block-hmp-cmds.c | 12 +-----------
>   hmp-commands.hx                |  2 +-
>   2 files changed, 2 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

