Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90774C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc9e9-0002f5-DZ; Mon, 19 Feb 2024 14:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc9e7-0002dy-MS
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc9e6-00070M-8L
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708372184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zaFa7+HvrZsnxRVykSHOqeUnYr4kl68vQDrGZ6V4cpw=;
 b=Se/FiPE8/cboTEnR7EDBy+boRbujKSYUcd/tc54To5aiLhACsdZucf59L7YMr3DaE7O23g
 B1kUbeASD1KvIKJh8TUe1M4deCSWYusbtS+J8KxpmzLkpVLrcORVqc1u+qyvRUvS4MD2My
 n3xmS/M3lEn6RX6h5wau7IYn9sIcMB8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6no-SC5EMBK6VmDDd3D3tA-1; Mon, 19 Feb 2024 14:49:42 -0500
X-MC-Unique: 6no-SC5EMBK6VmDDd3D3tA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7816bea8d28so1094218185a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 11:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708372182; x=1708976982;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaFa7+HvrZsnxRVykSHOqeUnYr4kl68vQDrGZ6V4cpw=;
 b=wYQpaIE5ghRbFIY4a0dy9m81XpVHeHjqboQfXYfC6vTrCmazfC8sbufT6LWMSLZxYb
 t4TQzze5GYqeT44QMzf5+XrmLu7M5tx1cJO776iBphlG/t5NQ9FRzGJx6HceLO9fqYlB
 dfn8AnM1PiKqenJXf+8xDjxAKPUJIqUc/xnbCkV15gNHxxPwecsegklI3KjoTZ7Yf/G3
 ab8fRqQUvEwnfjzePX11jTOrUv/nDIIE+DZ6BGkV2rt2xF6c9LJF8YKCEZTenBQnCQaX
 76SJNDsc2+yfN31Ry49oU5MTD/4HwIh9zQ3lbNQWqui3OuyVQnisd17DYsWgfTdmnSSS
 Wl+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYvkgmWRi8lJwTCvwVfrq27/Con9+n/hHjGI/8M2jug0ybfgQRhbfd1BWqcPPTy5TZnwsq0SeN+0emNTDTKFMxJQ+ElE=
X-Gm-Message-State: AOJu0Yyc8viAZ3MTnL0+cXsOfAxtklUNmkFfmIhPyQycPD9phv7YvYju
 D/mXkgim0K7yiJblIeyjXHOMSTZSfs9O+pFFm21DaUr20y2RvKd95X1GN5wx6LgEfcIiC1Il+Mu
 HSaO82Kilczm3YPEQaN48WlNuAxhGYHD6/FsNk65sc70Rafdv1OdH
X-Received: by 2002:ae9:e603:0:b0:787:2250:c98c with SMTP id
 z3-20020ae9e603000000b007872250c98cmr26306657qkf.32.1708372181758; 
 Mon, 19 Feb 2024 11:49:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHxRo/jZL82Tep2xs9VLjN+JA8CS5Ld8IZKiXY6aNIkVnYRecC0oK5e80/2J+Pxzafym5QXQ==
X-Received: by 2002:ae9:e603:0:b0:787:2250:c98c with SMTP id
 z3-20020ae9e603000000b007872250c98cmr26306644qkf.32.1708372181480; 
 Mon, 19 Feb 2024 11:49:41 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 sq3-20020a05620a4ac300b007872d50caf5sm2761362qkn.19.2024.02.19.11.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 11:49:41 -0800 (PST)
Message-ID: <550bb146-57fb-43fe-8618-05af8a0c01b2@redhat.com>
Date: Mon, 19 Feb 2024 20:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/ide: Move IDE DMA related definitions to a
 separate header ide-dma.h
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-6-thuth@redhat.com>
 <7294464f-c11d-ea4f-df55-117ae46b9d0c@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7294464f-c11d-ea4f-df55-117ae46b9d0c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/02/2024 12.53, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Thomas Huth wrote:
>> These definitions are required outside of the hw/ide/ code, too,
>> so lets's move them from internal.h to a new header called ide-dma.h.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> include/hw/ide/ide-dma.h  | 30 ++++++++++++++++++++++++++++++
>> include/hw/ide/internal.h | 27 +--------------------------
>> 2 files changed, 31 insertions(+), 26 deletions(-)
>> create mode 100644 include/hw/ide/ide-dma.h
>>
>> diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
>> new file mode 100644
>> index 0000000000..fb82966bdd
>> --- /dev/null
>> +++ b/include/hw/ide/ide-dma.h
>> @@ -0,0 +1,30 @@
>> +#ifndef HW_IDE_DMA_H
>> +#define HW_IDE_DMA_H
>> +
>> +typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc 
>> *);
>> +typedef void DMAVoidFunc(const IDEDMA *);
>> +typedef int DMAIntFunc(const IDEDMA *, bool);
>> +typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
>> +typedef void DMAu32Func(const IDEDMA *, uint32_t);
>> +typedef void DMAStopFunc(const IDEDMA *, bool);
>> +
>> +struct IDEDMAOps {
>> +    DMAStartFunc *start_dma;
>> +    DMAVoidFunc *pio_transfer;
>> +    DMAInt32Func *prepare_buf;
>> +    DMAu32Func *commit_buf;
>> +    DMAIntFunc *rw_buf;
>> +    DMAVoidFunc *restart;
>> +    DMAVoidFunc *restart_dma;
>> +    DMAStopFunc *set_inactive;
>> +    DMAVoidFunc *cmd_done;
>> +    DMAVoidFunc *reset;
>> +};
>> +
>> +struct IDEDMA {
>> +    const struct IDEDMAOps *ops;
>> +    QEMUIOVector qiov;
>> +    BlockAIOCB *aiocb;
> 
> Doesn't this need to #include something to define QEMUIOVector and 
> BlockAIOCB and some of the DMA and IDE types not defined above?

Yes, it currently works by accident since the header is only included in 
spots where those things are already defined, but I'll better add some 
#include statements here so that this header can also be used stand-alone in 
other spots.

  Thomas


