Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBF1C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNOT-0001gH-3p; Wed, 26 Mar 2025 05:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txNOH-0001eI-Po
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txNOD-00050P-PN
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+oM60Miuhu+NPKgM/x/pjRoUZKWRdGrJ7P+sBXyGR0=;
 b=EK3n+kGJDPcnOuB4DkdZpXP2ioRVbdIcYvJNmk+FFcUWmdVukQXWqVOJKxZnXeyGDwSvvN
 lWH2b8H+zY2YiKLNP0t91J8iav8j+jYnGjll9tFEXd2tNMqRWzHnN5DvsPcSqTklGU2Bez
 52XdWxyxaB6ffbYshyQzq2y+dIHuPas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-fuXOEwXAPuixsGiP-aX--A-1; Wed, 26 Mar 2025 05:49:34 -0400
X-MC-Unique: fuXOEwXAPuixsGiP-aX--A-1
X-Mimecast-MFC-AGG-ID: fuXOEwXAPuixsGiP-aX--A_1742982574
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so3380498f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742982571; x=1743587371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+oM60Miuhu+NPKgM/x/pjRoUZKWRdGrJ7P+sBXyGR0=;
 b=aYqJUDB5LPnnlb3uUc4j2padL/WNTL1EsLLEiJ94Lq12lLvOBMa/zfYwrnnjaoAqni
 7okVwIwIgIDduJPUP2eJ/8mzinwgitzSld/4YgV3QXzbLetDh9u37XfPikbbv01shjpl
 wUKHPBHND+8bOnR2yvAMrTbL5GeKstaIdhQKAJsziiVRvnoFYoD0mrrCCFOENO7wSG89
 erOlvKC0C5rPd7zOxDFDBSUl6OfWRgi4iHgDcEY/jcq4Ijy5XjPJltdFm07RyFjrRbzV
 qDPKJ0lpIpz0H2IyfFYjWrCRvD8HVgHaY8GiheT4rrV4xhV/JukAeGV+/FVWcIettYYh
 diyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5IJiQBBep/QmCO8mQf4WXYICKUeIb+YJHJ1acjZ0Kc4BXeNzzMTjZzI1q3IfUJGVCTd71RBw0q37B@nongnu.org
X-Gm-Message-State: AOJu0YxgS8v7r8hVtpGZnIMbV9m1z4TzDREoti1/UhZNwYXXSVonAbQ/
 cX9W2UD8GMuooERyGlEMyzmdubjQjj1I3a2ps50jpIumSCGm2I/VVdFcFDUNVWn4dgRElfSI+0r
 CqMpkABhqDayeU8Mw+s82tEVMZWX2PcqJwQ/MKQvtKlfzY9LxN9kxFkYykBEI
X-Gm-Gg: ASbGncs3GC1UQQm1C46QpA6+Mkac57LVMTDigb3HQKGhhBkiRoOo+SQquSEPIEDxh4v
 BuySWy24DoMTSvnKGV0yYQWwPt6bLJriRu2mtXZESQbaI/e4lnNmSLkLbtk9iU9mn3dFSlEImU4
 NCcK8cPM6AfGD+rIl/Q1voqruTtwnFV22dd8yeqnuCTFtgY5EFDyZ91VIolpPFiW5NV1QrPSejJ
 /31J0qLhXy2nwqmrdrci5vUIva418/GLJe3XBhlIS/P2r8WSPFCW3UftS9Lm4DxmxRwx9PR4sh2
 RZLqROs6FmwSHYdxwAwivC/B6A+/dJOXYTmwSzDi409VkpDivZ4z2FI2xmovAqvMsR5e8OZzlBZ
 4P6a4qZwWfphe29DNko0vZcI0vJxyWjxop7Ev6MFLXkD5
X-Received: by 2002:a5d:5f8b:0:b0:38f:231a:635e with SMTP id
 ffacd0b85a97d-3997f912722mr18063138f8f.25.1742982571409; 
 Wed, 26 Mar 2025 02:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkgvIqkA8bVGMf/MM3pKUkIiqdNf/hqImBeIEMMNTOEo/zkfaKamfgYVke4AeqY2sRFUgm8g==
X-Received: by 2002:a5d:5f8b:0:b0:38f:231a:635e with SMTP id
 ffacd0b85a97d-3997f912722mr18063107f8f.25.1742982570820; 
 Wed, 26 Mar 2025 02:49:30 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d8b:cdca:4048:2991:54ce?
 (p200300cfd74f9d8bcdca4048299154ce.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d8b:cdca:4048:2991:54ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eff9asm16631104f8f.92.2025.03.26.02.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 02:49:30 -0700 (PDT)
Message-ID: <2c97f380-a82e-44a3-a6ea-c4d6dfc4cf10@redhat.com>
Date: Wed, 26 Mar 2025 10:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] fuse: Ensure init clean-up even with error_fatal
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-1-hreitz@redhat.com> <87o6xofimz.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87o6xofimz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26.03.25 06:47, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> When exports are created on the command line (with the storage daemon),
>> errp is going to point to error_fatal.  Without ERRP_GUARD, we would
>> exit immediately when *errp is set, i.e. skip the clean-up code under
>> the `fail` label.  Use ERRP_GUARD so we always run that code.
>>
>> As far as I know, this has no actual impact right now[1], but it is
>> still better to make this right.
>>
>> [1] Not cleaning up the mount point is the only thing I can imagine
>>      would be problematic, but that is the last thing we attempt, so if
>>      it fails, it will clean itself up.
> Hmm.
>
> The pattern is "no cleanup with &error_fatal or &error_abort, but not
> cleaning up then is harmless".  How many instances do we have?  My gut
> feeling is in the hundreds.  Why is "fixing" just this one worth the
> bother?

Because:
1. This one is in FUSE code, which I’m reworking in this series.
2. I did encounter this issue while playing around with manual mounting 
last year.  I don’t think it has visible impact when mounting with 
libfuse, but why leave out a fix for something that can be triggered by 
making valid changes to the code?

Hanna

>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index a12f479492..7c035dd6ca 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>>                                 BlockExportOptions *blk_exp_args,
>>                                 Error **errp)
>>   {
>> +    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
>>       FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>       BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
>>       int ret;


