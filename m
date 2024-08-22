Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CD2C531DF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 06:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh10D-00022L-PI; Thu, 22 Aug 2024 02:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sh10C-00021o-3V
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:08:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sh10A-0000JG-LV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:08:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-202146e93f6so4190015ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724306933; x=1724911733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c8iPMI1tkY3tcOeUctDuuwfMnlNMD4znxR6JX9DLeMY=;
 b=Di0e7t6PajNuHYwxbFrVL2GQV8EKyY3xdQQuW5udcjGqhCTe8MG7hWm5Dswh6jGNLb
 AGAuLFivyOxpFPVFiQ4E/wEz7uV2sIcVAEg51fL8Zr2s/nErX4W8XKXD9UdDj2sGg7yR
 qI1iusYCo5aqhifukmeDo4xD1084x/VGVY5Hvx6YuePJyZq2oc/LkuC4fdBafdp3EGco
 eZxbQ502+sxdWy7bM2+WFFzP3uXU7MuspRKzV9yQNjvDTsM2Y/7ehnh8lrbtbvu0S1G7
 tC71gx48P4PdrTPTlV+2UpkSk88q/Gzb50OE3szoBlpNaiNoI7Lbd4biC8EaRwakePHq
 gpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724306933; x=1724911733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8iPMI1tkY3tcOeUctDuuwfMnlNMD4znxR6JX9DLeMY=;
 b=Qx7/+TX7skQ3a7PB8pGmVD1/eGR1Vtf2cFsWg64FM8QJUpMy/o30KwvA1g7+rqUIcv
 K854Y20Aw/ZQrLqph4y2GO4wbSu102aaw/Lj35S9S5nBza6we3GquXfTf8tWHfIyHfC5
 DH0YjrpmvkRVRxDgsG7bXTSixpTtLYR3lBvjsN2PPBR1lBgY/TclWlVv/LPHBf1eD2v4
 pGQtffDNudPLKLwqeAW6p47qTIsC+yYtK9Ku5nhMXorj6/PgVDxHxlyp+5Gh2Iw0bKU8
 XtfRB1gaZ/2uPnr87m9eh+Dhun5kAAvOd3kDOwLgnaIdHcp8z7omSSWuPciza5GeONnh
 GDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXEMCFBQzK6Vl8h33qhUZfDgwvH/ez1ejpZnTE9/P8qL0X3ZeDdn9QkU6Pog0Z00xHt7mK5Lf9SHMl@nongnu.org
X-Gm-Message-State: AOJu0YwdD79f5zUGQsjXcvXc+xLJdKQIV7q9KBZ3BIvbq3w+ZrVuR6oN
 KkK8mBkG3F0JfEhjfotmmG3gFqR/klZ6E+FoiIYZmHzkkDik/Uyv
X-Google-Smtp-Source: AGHT+IEbzUgS+FDKTWKqUKeN7BWxWzqJey3UtJ86WOjjt2x2j0EJ8FLcZ2ArwxfcKIyYfwQe+XpfsA==
X-Received: by 2002:a17:902:c40e:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-203682026c0mr60607015ad.56.1724306932975; 
 Wed, 21 Aug 2024 23:08:52 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038558081bsm5356565ad.104.2024.08.21.23.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 23:08:51 -0700 (PDT)
Message-ID: <b4dc0999-3826-4b3c-8864-4904dafff2ec@gmail.com>
Date: Thu, 22 Aug 2024 15:08:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test
Content-Language: ko
To: yc01.jeong@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jeongyuchan0629@gmail.com" <jeongyuchan0629@gmail.com>
References: <c92844fd-8c4a-4ab6-b778-f8d8e86741eb@gmail.com>
 <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b@epcms1p3>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p6>
 <20240822060010epcms1p6b10addc94bc16411c3a32d1f404c5978@epcms1p6>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240822060010epcms1p6b10addc94bc16411c3a32d1f404c5978@epcms1p6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 8/22/2024 3:00 PM, Yoochan Jeong wrote:
> On 8/22/2024, Jeuk Kim wrote:
>> On 8/21/2024 11:32 AM, 정유찬 wrote:
>>>    static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
>>>                                uint8_t query_opcode, uint8_t idn, uint8_t index,
>>> +                          uint8_t selector, uint32_t attr_value,
>> We use ufs_send_query() not only for attributes, but also descriptors
>> and flags.
>>
>> Please rename `attr_value` to `value`.
>>
>>
>   
> I think this parameter name is okay, because this "value" in UPIU is
> only used when writing attributes. Writing flags do not require an
> actual value, and descriptor data will be stored in data segmentation
> area.

Okay. That's reasonable.


>   
>>>                            
>> We might need to check condition here that `query_opcode !=
>> UFS_UPIU_QUERY_OPCODE_WRITE_DESC`, since
>>
>> it is not implemented yet.
>>
> in ufs_exec_query_write function in ufs.c, it already checks
> if it is trying to write a descriptor. Is there any particular
> reason that we should check it here in advance?

You're right. We don't need to check it here.



