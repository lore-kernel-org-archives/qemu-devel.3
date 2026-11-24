Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1B606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cGwsosKo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RO6IcqcX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvmo-0006Kr-64; Tue, 24 Nov 2026 14:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvmg-0006I0-NI
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:02:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvmf-0006dl-27
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:02:30 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXR9H2752101
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gFUfDJQxmZXx+yYy1Tg8FEIgjiX0xJiT9ZW3bhUISUQ=; b=cGwsosKov8LHSQtp
 KQiSJ5wEqhSpPjsOFU2wNiIeUXt+dtSI3/q4yeS32EGVeVNMociYllF/daidGWzu
 4sSR9pmFz1fDhfrhnLi6tt1yajDGAM92FytM6praYbkJVtjmCd5pyekAo7iSy45v
 PvFUZJusJTgZtenfCqurvwne35QPRW1Kooj8+X4qyhUWg4c8tSNnhYNrKcTXRx/k
 ngEVBNbe9N9scI1FhpYUjAOugetyMvZcdb55lF3VItiye/QwUHXP1gHZM03JkIOH
 O11v78klqliNoE1X1nyTsJiMXNsz1p3vqjvJ610gsyY8uMEjb/e/V61diPjn7ZAN
 rycRSA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd4jrj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:02:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b40b011aa4so5784571a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546944; x=1796151744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gFUfDJQxmZXx+yYy1Tg8FEIgjiX0xJiT9ZW3bhUISUQ=;
 b=RO6IcqcXK0ahAC8Bk55EFMctZ4v1sfTwFRY7eTBgRjRVYZbQg0nc1oceekmSvvY7vT
 qOTGE8czfxLbLpymLzpE2+T8D6MlKnHDlPSY6Y/JX7xwfMcgM00RBiMo3IToCh06Uuha
 J6NgWUwbmPMLeKrcZUCWiwUkeBBSA0Q74S9sDFSitNfqa2+bp5vI4BDBjWlImCrMTJHV
 QEu3MCjguj7MGiaBv9zGwIcs17Ogvmi40T8LSpBGazNBd6/d8JcoQHH5WnMsgYISI2hS
 ZI564nk1rEikxJWFPWH4G6q+ZRYq0G6sB5AF2EVA3CjVdmmYitnKUf8KmjWkCZRytL32
 /h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546944; x=1796151744;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gFUfDJQxmZXx+yYy1Tg8FEIgjiX0xJiT9ZW3bhUISUQ=;
 b=ATmi2CwhmBFNYxm3Dt7y3pUaMKFUh3EikfGz5GURa7sOxwCeDVpx9YBzDZ3Y8Hcqcg
 rBqD2z42GxfL0w2uullGOtIXNjReZNvXWjcCCba6+oBmaXRvo4Pq9K+38oZQAtruKvnG
 Da52IIsruYb6mam8szpWMFVAFL6sKlXe41GcSFhEKSXPKq6WUkJP5IghY1OioLJghNcv
 /cSXciedGtyUp4P2dX6CLU96l1xu1CanV/q6B7u0BRjNRlfBnxoP5+Y1oG8ToBFtIXPF
 xOyge2nGwfpYvcy/IpmS/zi6X9VTpcn1jJWoRMRhmDvUbeDL+eGqD+zk1YvZQqByoWUQ
 m3rg==
X-Forwarded-Encrypted: i=1;
 AL+hErHNpXFdSomHhFABjEuZV6GZjbIMwzEMezREwBJPxPoLgy22YVbJ+fhTc/p5dDez3o7rhtaIrbvFiaaz@nongnu.org
X-Gm-Message-State: APuU4Z+VAmMibJxJdAR6NfI7/9l5FSPxhEBEeIRbfwr/jLLZEYldpaKf
 LUNnSZrPy20eR283Qo6yoZfs6TZoJSrmYzm4C4oVu0F+LqbdV1oWAcczzA6syljs0n4dLYAtPOe
 9INENjdudqsHYmrUhJMRLe6Yj/goxxNyoGquPMSjCe1A9KNq3Zc8CglGjFw==
X-Gm-Gg: AZFdTZczFZdalPVOn+shhNp0g5F4Ic6qEQ0ywfV1trK0V/KA7PbZihHBZfrDdR0fRf4
 dIkJekTOSZBp2O2Z7mY2CxJk/7cBeSXuasbxd3eITyaff7qAfSUP1Kr3yQIoEc9QlglRv1e5v3t
 Y1OvB6K+6UaOZfufQA4yUVkoHB2NIK7Uc4DkypKvIXDDuTsn5RDOPe6ZcPjg4FZDWEUk3nE23YK
 YRTemEGOosidrj2KnEJj4AlugERKpQ2tTsbSq+L5Kk6Rf6/ppc/TJ4ke7A9/YuIERFHgPEc8iYP
 PylAvWFdlFDj9QXcQ3npAfYIdWBVuqqI0VIriz5uivK0tRBQYZWV1IWn7UhRTu61UflzCSkrVAG
 JXHZx6n2p3ijrtkmdf1YT338w2h3CbDmRLSA5GH69/0KqX8TrcNV0mFntZL2IC0jN9e74w0/dpJ
 E/kTI0+qY=
X-Received: by 2002:a17:90b:442c:b0:3b4:12a9:2e9 with SMTP id
 98e67ed59e1d1-3b41c7d17e4mr15100991a91.6.1795546943814; 
 Tue, 24 Nov 2026 11:02:23 -0800 (PST)
X-Received: by 2002:a17:90b:442c:b0:3b4:12a9:2e9 with SMTP id
 98e67ed59e1d1-3b41c7d17e4mr15100951a91.6.1795546943319; 
 Tue, 24 Nov 2026 11:02:23 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm417905935e9.12.2026.11.24.11.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:02:22 -0800 (PST)
Message-ID: <fb51274a-b901-4237-a4bd-f3d970996e2a@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 20:02:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/dma/i8257: Read the mask from the RWAMB port
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
 <20261119220838.52034-2-philmd@oss.qualcomm.com>
 <a693909f-837d-49db-89a8-6c09439fa329@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a693909f-837d-49db-89a8-6c09439fa329@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05df40 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pcZqCyVeAAAA:8 a=rnC_JhOeTvv-UMi8QUgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfXwJmqUeNQEvxm
 PEhnt7abEMXtL4sPWx4NUNdpxumgmkT6VFk9Y8lLGgvY2vbXjrTEpjVOMccIzolXz++iXcUEEtl
 7Vss12zMuzZbuLHDHQdKfLVlu270pydirzDv46zFdEW6jLmfRQNzI5RTwjl4DbmbpTTpGoUCA42
 Sx66sFfAhzm+5Nh2Bq/mSHMW71UDISSVFft+3nQ8OJeq9JrQxlIAy+0qOhxrmEZODflWzOq1Zjj
 yxgWysU5Y4MMpE48x/NqcPrULUGi7kAMeSreKElEa3YD54vTpQ/ha+Jgm+QRP+k5sEaFAbgkShG
 PFvMRIaExXU2rOtYOxbHJF5+Z1Ce2s3IAcIdltIwUlSznGVeY669eUtHmUl/9CDiQhE8+Uffjd1
 HUlklhrAIocHF8bfV26rpJGrbc0C2dkatCp5bnUFNGShupAGroDOvoPCbHfKr6CKBM6WQrFWDZc
 KrLHTLg7wQwfFBcyYNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX2Ogj+bQV2HFf
 qZ/aKqlX4zrB+98AEjg7RyU9MCSry9OXoyZFR9sELnMAKdB7qaKEAqxpiIN3V5RVcXt8g++YNwG
 kPuh7VLQT58ElbXwO+mji8DdyN3X9Tg=
X-Proofpoint-ORIG-GUID: smhIfdakMNYpQEkfPYseZ1bBgsY01iKU
X-Proofpoint-GUID: smhIfdakMNYpQEkfPYseZ1bBgsY01iKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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

On 23/11/26 21:34, Mark Cave-Ayland wrote:
> On 19/11/2026 22:08, Philippe Mathieu-Daudé wrote:
> 
>> The 82C37-compatible register layout, as documented in the PIIX3
>> datasheet, has the write-only request register at I/O 0x09 and
>> the read/write-all-mask register at 0x0F.
>> Move the mask read to the latter.
>>
>> Fixes: 9eb153f18f6 ("dma clean up - added missing read accesses")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/dma/i8257.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
>> index 577154988952..f44632de3db0 100644
>> --- a/hw/dma/i8257.c
>> +++ b/hw/dma/i8257.c
>> @@ -281,7 +281,7 @@ static uint64_t i8257_read_cont(void *opaque, 
>> hwaddr nport, unsigned size)
>>           val = d->status;
>>           d->status &= 0xf0;
>>           break;
>> -    case 0x01:                  /* mask */
>> +    case 0x07:                  /* read all mask bits (RWAMB) */
>>           val = d->mask;
>>           break;
>>       default:
> 
> Indeed, looks like this has been wrong for a very long time: I presume 
> there is no regression on x86 here?

All CI tests pass.

> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!

