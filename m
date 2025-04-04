Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89045C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fAM-0008RG-Bo; Fri, 04 Apr 2025 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fAK-0008Qc-1b
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fAI-0006sN-4h
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743765888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jW3r5fY13bUC3BEnqSawfPFyyw3eqVDQtso11+xE7g=;
 b=hpQLXHund4CEquOkirBwSvMhonfG0ZhvgVmn3bgidnBELvdWHz0M6a144SMpAZ6P4QPAiR
 lDpMFyv/EK01xnEV4LeNbR1QjkpXZSfXxbiXE9csVNKjm6EPtDASbImTa2s5ZGFD+2mc7F
 GwnCxBHAgPbIkj4BKbEpQif66Avux4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-qSfoLZVoO56XuXl-Wd398g-1; Fri, 04 Apr 2025 07:24:47 -0400
X-MC-Unique: qSfoLZVoO56XuXl-Wd398g-1
X-Mimecast-MFC-AGG-ID: qSfoLZVoO56XuXl-Wd398g_1743765886
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3913b2d355fso927396f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743765886; x=1744370686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jW3r5fY13bUC3BEnqSawfPFyyw3eqVDQtso11+xE7g=;
 b=quP9F/vf+toZFkD8h/VjTNjRv00ji0Dj4IwtIqwQFKtK8l57F8lM0sJnfdcigvvKXn
 iBntBrG4EF0OSWXdjke1d4DP/uYZ3g2NXph5KTN0MFMguV4yQZx5dvGaD/pjxW0XmGVr
 I5HA0S3X0EbVeBfn/IBOp5FDEp4p4QaojTsXV6UHOdxR+RPooDnSpXbXwxcy98pVW9TL
 OwqnfHf+io1mmRxGxSwWY8E/JNnKJa6lOtGydWWqWisA5z5xrO4BScIpuELYzUBRzpAP
 sKH2erq4QWC2S16zX146Go1DltmGjJrAFCAZx1tUcUQHCcuFA4ILpVEtI8jo13SL7ZUt
 /qUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4sroBFR4tWqnbdu3r8ClzaDq4XwqD7MBv5JFE46YrsZyznrqTtWiyWnv25RX/4HuaM7swj6qdWGDz@nongnu.org
X-Gm-Message-State: AOJu0YwozMBbiysJtwUkVxlhz+ktS9jzm7pTjGGVloeMtGHGh0vQ83CY
 eHEXJM0mE4chBqRgBiPshWo4yw4VNUprWyGB2VCyhr9OlMfBhSEhdmrOnGChJNtA6bzZ+eDd/0q
 7UtsbJZzcXD+mYRypU7IZ/M8NptTmjCmaLxNHoK1L7sHgiTT6a3oe
X-Gm-Gg: ASbGncu+eo8NjpXsJ6Tublk76KjN8MK307U4DnBdKekWFT6mpz2zJfs/PHivIcGdmVb
 ed2kBByWAIBy8PeReFgp8bNJNnxzkedGmmy7vmx/CLMKeiOooarEdsxIprqTG9/x6FaQJJ70FTy
 +TBTDXKMgh1qAupQG9gXwD8WsOnbdTxcpFo88POXk5AVwdDJGi+PAx7fdOkLPfFnzW8I1RD9KCA
 Vq07b52LbTpMjuVtyyTzAL0NmOI6NLqMLqudz9XyMPFDbVbkVsr2wvfhNnSsiXdmT0Z/j1Jb4wE
 Xa7Ki5g37VnzoIePcNpxRN2yAflu8psqo86DJmMkf2AnEsHHX8ue2mY1xpSb80Yvisq29dT4lPx
 Z4PF9k1eD8h3y8LM85C5uni/mL+TQlJVnZoqgmZ178SIP
X-Received: by 2002:a5d:5f52:0:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-39cb3596c9dmr2190367f8f.14.1743765885771; 
 Fri, 04 Apr 2025 04:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaagjRjsMyv89228ZcokXjoGNqxCq4mj0GMu0HKVIThBl95326C5Y8U8H6MZSYmMAo90dd3g==
X-Received: by 2002:a5d:5f52:0:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-39cb3596c9dmr2190349f8f.14.1743765885392; 
 Fri, 04 Apr 2025 04:24:45 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a79bfsm4222836f8f.36.2025.04.04.04.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:24:44 -0700 (PDT)
Message-ID: <0cbc0080-cade-4018-b283-cdbb3b489da4@redhat.com>
Date: Fri, 4 Apr 2025 13:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] fuse: Introduce fuse_{at,de}tach_handlers()
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-7-hreitz@redhat.com>
 <4r7vggv7jwq376focbc2mhad2b3cfs7eowsgge2ppwtd47c33u@cw3vd3tqxy3x>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <4r7vggv7jwq376focbc2mhad2b3cfs7eowsgge2ppwtd47c33u@cw3vd3tqxy3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01.04.25 15:55, Eric Blake wrote:
> On Tue, Mar 25, 2025 at 05:06:48PM +0100, Hanna Czenczek wrote:
>> Pull setting up and tearing down the AIO context handlers into two
>> dedicated functions.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 2df6297d61..bd98809d71 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -78,27 +78,34 @@ static void read_from_fuse_export(void *opaque);
>>   static bool is_regular_file(const char *path, Error **errp);
>>   
>>   
>> -static void fuse_export_drained_begin(void *opaque)
>> +static void fuse_attach_handlers(FuseExport *exp)
>>   {
>> -    FuseExport *exp = opaque;
>> +    aio_set_fd_handler(exp->common.ctx,
>> +                       fuse_session_fd(exp->fuse_session),
>> +                       read_from_fuse_export, NULL, NULL, NULL, exp);
>> +    exp->fd_handler_set_up = true;
> I found this name mildly confusing (does "set_up=true" mean that I
> still need to set up, or that I am already set up);

Not my fault that English has irregular verbs.  FWIW, if I meant the 
former, I’d probably call it “set_up_fd_handler” instead.

> would it be better
> as s/fd_handler_set_up/fd_handler_armed/g ?

I prefer the less militaristic “installed”, but sure.

Hanna


