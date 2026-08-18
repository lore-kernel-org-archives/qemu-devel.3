Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B081DC5DF7F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwBxG-0002qb-3J; Tue, 18 Aug 2026 01:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwBxC-0002qE-Um
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:01:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwBxB-0000JG-4F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:01:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I4TOJ73464504
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hzv4KXtHD3ATvNia7RkrXNiVUaeJwLo3PSegH9igsXY=; b=jD+lFSeY4gX9esHH
 uUeLGajvOfyuAvC2TO7lcSWqPPgK+iZ0slTOxeElOm/j86xdLlZ3jYVmUe8CC1p0
 Oqixd5nayifIUq8CRkNDdSRjS43/pFM9pJ6uSIGym6bguFR49wBtkC0wLF+tUtco
 KMwRjAt887gbn0ZEJ2wFsgo7fDukCurUOuLtWnBDo7grcXYmGOzvNWY5C1KImx8i
 cICnepDG334wYNWSq8+xHLs01dkNoNWI5TgzjEcBzcUhk0dLHNpu49G0BMSifJiI
 CzkkScPAi/26wUt/osi25C2APrsU7kEzLfzHxFQ+WQb01gTkBgbiEM+9rCVR1uDE
 jJMAdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4611arh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:01:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936cadb0e8bso359659685a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787029294; x=1787634094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hzv4KXtHD3ATvNia7RkrXNiVUaeJwLo3PSegH9igsXY=;
 b=TIrkKzt8MoLQc29MK+SN7PRDDS5HUYOO0jlz/+WnKZL+Ig9u909D1J9mSVQ8hiTcH0
 BrYOR4UIlIZsDp0aSmdptH7dGrd+ubmtKU2gKTFRa2lZ6ZPH8oQpmFR9sFXpd+KcsxTM
 xullD9Da1m694Fix4f81qvFJ4D9VCEkAFo3mi6eBL+bEIazVKpv9SYNVoYRbsAcYevqB
 A4qQOzbMcOxlDPU9HOm1mGrm0e/gkIAWsBwoufIPhVvQ+qbnBpkL4EDFFm/e/QKXb5bh
 ZnAIc7Aeq6ttVOCu7CA7O6IqHbGUAeF1iOnBLR1BbVKgXprOwx/y1+tzJRj7nQf+EiBa
 cVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029294; x=1787634094;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hzv4KXtHD3ATvNia7RkrXNiVUaeJwLo3PSegH9igsXY=;
 b=ds6IhlbtFLxiJJdQblsbRe5FSuuNY/bWqmVSBV5WwW43AXInJNt+GW6cBOMG5TMEYq
 unjQKJnH1ynZtlXTPgq6uHTOmY/jeljpYf9sY8ZI7CzK5X2BBZ776i1Rk5Gl405kziRK
 FFtAQDuTMvmUCwk7KDLeahTiTP+s9VHbpXlk+dlaTtjoHhPpRFIxQao3x2bahm/Jbmqa
 fNFBzKDu/KfMu0XDmN5XzH+3oGG1D3+bR0mLgMPkfRoKkSjMjFqdQjkvCxJzSW+yc9jS
 mzL38UZ8MEkUUoEnqLu/Zb0JxVVrR+TdajcaQ2dbg2giD3mPXncsHPRuyqyYZnzuH+ss
 TO9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrkf5MLGs8CBRIhWanO5/3xCWgyiGcKij/kWuDIPa0HrHqFL2Gc9cKMJ6W9bWalmZN/0AVs16jaFTWu@nongnu.org
X-Gm-Message-State: AOJu0YzCkWCXvFCndkptj6eFHeZjvLDkBRnYcIhT8ymICTTi3eba2MmD
 jSApyIeV5gc3L1JYwGfN2jyUVjTxzFgT+CDx5TcWCkne3jPmDsxpRZ0uowoU0MT4Va7M36R922f
 wB5DTX93KJOOKvFpYPlHUJTY0f0z5CMkVte2Ir7iuWXkfDRM5QYeCbm/w9SWRfoVK5aaS
X-Gm-Gg: AR+sD12cxWTm2s0OOQcNg3ZsYgvr7zboKJv5o/duXIMMsLk1QPI1JyWqos3W0Xzr/4K
 +JCI+LW6bj7Y/FKbJjSRd0ggsBcC+Lwq+9rz4e6RNFt1ewsaGJmgboq80VWZw/DxaIdiFsN3WGg
 tttHtkC36rmuBSVO3TS9MsB/gAGKPEVI9cUzGxDpiu1BzUbrG1Eb2oxBwZPZ+GIvkrzOub5eton
 D8dbtgW7mqJ4Vt2extpcc/qWWdaLefg4LsA1WR6JhwDn4vEIYIguOgaFGW5cuGq24CVckc4Ekfe
 QRfixlqOQT++82lpinANeOPH+GwFdn0kDgvLELvRDfyMuCKUKSLWVJi5kEXP42Uaq7gKwlr3aXm
 3slUeoCw/RPR3iXwCE12s+U7ZqvLKiI19O6w=
X-Received: by 2002:a05:620a:5e42:b0:936:cf9c:a9ab with SMTP id
 af79cd13be357-936d22403d4mr2561641585a.21.1787029294600; 
 Mon, 17 Aug 2026 22:01:34 -0700 (PDT)
X-Received: by 2002:a05:620a:5e42:b0:936:cf9c:a9ab with SMTP id
 af79cd13be357-936d22403d4mr2561636185a.21.1787029294010; 
 Mon, 17 Aug 2026 22:01:34 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm100895435e9.3.2026.08.17.22.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:01:33 -0700 (PDT)
Message-ID: <dda3396f-0f4c-4d50-aa98-dc7f555018d3@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 07:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] hw/ide: keep the IDENTIFY DEVICE current geometry
 in sync
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260817205242.1199851-1-den@openvz.org>
 <20260817205242.1199851-7-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817205242.1199851-7-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JNwk3sq7dkGd7DbakL94iXK1opsFjAxo
X-Proofpoint-ORIG-GUID: JNwk3sq7dkGd7DbakL94iXK1opsFjAxo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfX412+GCZEAfod
 NPcJWk7PcODWW5x1m/WmvJe+uqOw4VyW8Ah6OkrpxntnY4oobLOOrRYnn0NmRGmPFqXbDKfVawd
 tefJRK6ZGs6OcR6kYJT4AsPH+zu5SZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfXxOF9ksRCLFTN
 EtNfBZov0vDHYNXBhGMeLyG1aYLlIFNKlkUlo8RNB+RFm8vfuovDB4ipubzsfHRRCxS4ndDXkrG
 ooEtatHFQZD8n6nZZHzo5VkFVWtexqg9kgi7aYUqxXsAI/Oj8zMYdwAMu8MGgu4du47qoZRiTP6
 nsSqRBMzPfYMK/Q7z9IK5Ek9vYkvKbhqV8Z8F4x0qXY83hLepbAi2pah3FZN0+Ntf4/U0FSoJ2d
 MGdGo5X3gaNCM2iywiIEmyRdVp3C3weeS/wRAfLsHJxBPym0dlR4qMP0aVfRC8mpVsIKqWweuSU
 sC8arhz2Vno9VbLpg/NJ4FMuG9VLluhNJXbW+nu44LxTuSjVzIzEXXgUN8wgcXKy9kCxZypBGnp
 FiU/KbYBbUX4sJlqz/Q+OqE1KBgyBS+8t3xX9L7Oh7nb/o+bFTjAiAaen+bNVp+Tosous91Kzz1
 v3stmhzJFUI4x88XYsA==
X-Authority-Analysis: v=2.4 cv=UslT8ewB c=1 sm=1 tr=0 ts=6a83e72f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=ZgAyYPzqecz-wjI13LQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Hx1yvPaMooE3kwe23bt7:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 17/8/26 22:52, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Bit 0 of IDENTIFY DEVICE word 53 says that words 54 to 58 describe the CHS
> translation in effect, and ATA-5 8.16.8 has INITIALIZE DEVICE PARAMETERS
> set words 55 and 56 to the heads and sectors per track it was given. The
> data is built once and then cached, so those words kept describing
> whatever was in effect when a guest first asked for IDENTIFY DEVICE: the
> device reported one geometry while addressing the medium with another, and
> nothing reported an error. The revert SET FEATURES 0xCC asks for on the
> next reset left the same disagreement.
> 
> Do not drop the cached data on a change, as parts of it are guest state
> rather than a description of the drive: SET FEATURES records the write
> cache setting in word 85, which ide_drive_post_load() reads back after
> migration. Update the affected words in place instead, the way
> ide_identify_size() does for the capacity words, and share the code with
> the two places that build the data.
> 
> An ATAPI device has no translation but does take SET FEATURES 0xCC, so
> leave its IDENTIFY PACKET DEVICE data alone, where those words differ.
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/core.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index befbab9486..9959437a63 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -110,6 +110,18 @@ static void put_le16(uint16_t *p, unsigned int v)
>       *p = cpu_to_le16(v);
>   }
>   
> +static void ide_identify_chs(IDEState *s)
> +{
> +    uint16_t *p = (uint16_t *)s->identify_data;
> +    unsigned int cur_sec = s->cylinders * s->heads * s->sectors;
> +
> +    put_le16(p + 54, s->cylinders);
> +    put_le16(p + 55, s->heads);
> +    put_le16(p + 56, s->sectors);
> +    put_le16(p + 57, cur_sec);
> +    put_le16(p + 58, cur_sec >> 16);
> +}
> +
>   static void ide_identify_size(IDEState *s)
>   {
>       uint16_t *p = (uint16_t *)s->identify_data;
> @@ -128,7 +140,6 @@ static void ide_identify_size(IDEState *s)
>   static void ide_identify(IDEState *s)
>   {
>       uint16_t *p;
> -    unsigned int oldsize;
>       IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
>   
>       p = (uint16_t *)s->identify_data;
> @@ -158,12 +169,7 @@ static void ide_identify(IDEState *s)
>       put_le16(p + 51, 0x200); /* PIO transfer cycle */
>       put_le16(p + 52, 0x200); /* DMA transfer cycle */
>       put_le16(p + 53, 1 | (1 << 1) | (1 << 2)); /* words 54-58,64-70,88 are valid */
> -    put_le16(p + 54, s->cylinders);
> -    put_le16(p + 55, s->heads);
> -    put_le16(p + 56, s->sectors);
> -    oldsize = s->cylinders * s->heads * s->sectors;
> -    put_le16(p + 57, oldsize);
> -    put_le16(p + 58, oldsize >> 16);
> +    ide_identify_chs(s);
>       if (s->mult_sectors)
>           put_le16(p + 59, 0x100 | s->mult_sectors);
>       /* *(p + 60) := nb_sectors       -- see ide_identify_size */
> @@ -321,7 +327,6 @@ static void ide_cfata_identify_size(IDEState *s)
>   static void ide_cfata_identify(IDEState *s)
>   {
>       uint16_t *p;
> -    uint32_t cur_sec;
>   
>       p = (uint16_t *)s->identify_data;
>       if (s->identify_set) {
> @@ -329,8 +334,6 @@ static void ide_cfata_identify(IDEState *s)
>       }
>       memset(p, 0, sizeof(s->identify_data));
>   
> -    cur_sec = s->cylinders * s->heads * s->sectors;
> -
>       put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
>       put_le16(p + 1, s->cylinders);              /* Default cylinders */
>       put_le16(p + 3, s->drive_heads);            /* Default heads */
> @@ -350,11 +353,7 @@ static void ide_cfata_identify(IDEState *s)
>       put_le16(p + 51, 0x0002);                   /* PIO cycle timing mode */
>       put_le16(p + 52, 0x0001);                   /* DMA cycle timing mode */
>       put_le16(p + 53, 0x0003);                   /* Translation params valid */
> -    put_le16(p + 54, s->cylinders);             /* Current cylinders */
> -    put_le16(p + 55, s->heads);                 /* Current heads */
> -    put_le16(p + 56, s->sectors);               /* Current sectors */
> -    put_le16(p + 57, cur_sec);                  /* Current capacity */
> -    put_le16(p + 58, cur_sec >> 16);            /* Current capacity */
> +    ide_identify_chs(s);                        /* Current C/H/S and capacity */
>       if (s->mult_sectors)                        /* Multiple sector setting */
>           put_le16(p + 59, 0x100 | s->mult_sectors);
>       /* *(p + 60) := nb_sectors       -- see ide_cfata_identify_size */

Better split this patch in 2 atomic changes, extracting
ide_identify_chs() up to here and using it where appropriate
below here.

> @@ -1361,6 +1360,10 @@ static void ide_reset(IDEState *s)
>           s->reset_reverts = false;
>           s->heads         = s->drive_heads;
>           s->sectors       = s->drive_sectors;
> +        /* An ATAPI device takes SET FEATURES 0xCC but has no translation */
> +        if (s->identify_set && s->drive_kind != IDE_CD) {
> +            ide_identify_chs(s);
> +        }
>       }
>       if (s->drive_kind == IDE_CFATA)
>           s->mult_sectors = 0;
> @@ -1669,6 +1672,9 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
>   
>       s->heads = (s->select & (ATA_DEV_HS)) + 1;
>       s->sectors = s->nsector;
> +    if (s->identify_set) {
> +        ide_identify_chs(s);
> +    }
>       ide_bus_set_irq(s->bus);
>   
>       return true;


