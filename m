Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C50C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUPp-0005dM-97; Thu, 01 Feb 2024 05:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVUPa-0005ak-46
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVUPY-0005BB-JZ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706783711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILcoyOeJIXZOe78pKOxwfQNxkBCEYBMfLevxP+8jWmw=;
 b=VYCJBDnwCkLiznirsW9Jmuln9RbMoJ+kPGxZJ4eLUw1anpGTo6MzYSNg5KrWbtbNvJMtLE
 IuX8pzibGkXZOS8WCF5CGpqot0aORl+b6KYV5QbyBaofxrXq3eppt9SdBBdV2PLeNIN1b+
 U3jjftptWprObUvVrEm4K9E27CDiMoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-R08wQN4wNA2JYkiIdki9mQ-1; Thu, 01 Feb 2024 05:35:10 -0500
X-MC-Unique: R08wQN4wNA2JYkiIdki9mQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b0c264abbso403788f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783708; x=1707388508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILcoyOeJIXZOe78pKOxwfQNxkBCEYBMfLevxP+8jWmw=;
 b=ksRAVTIsMT9BfOId1le0/T8HTSUaulXDlRAaCQCbHFyTyIRA1jhNeuSmb0B+cnWp3o
 pGAyj/S/XOKb3Q0puKXDUfB1CHXL1MI97GsnN+/CjKYSc8pnxa/xsAPhb/iEIXnuwuoM
 vAzAePXF30cxDMd6YWhdI7kBatzzKIai7VT70J4mYKUsurceYkKr9UrH65srRto7nYgv
 VsnharCZaDrgKnGJqa45yODAFpUv3rVUjQXGuZWTKEAoOR+6K+o9l3Swa/KvJvZg8i/3
 YTkTa8s55E5CQeW/Ej2Sgt+nKG6ZSVIB40F4gOQEOq6Gh5Y5RwRpPf3XzKcr1zd0QpW5
 1DLA==
X-Gm-Message-State: AOJu0Yxy18upZf+XT48KbFHoOZ+h0WjKWYk6O/GbZDE4UuRPBybUPd4P
 thFZhgpXsaorRBrzxvmQiC73WtoJ7QfwJzLPa96kOtLnNaq6HsfBMgMqM54t7lg20qaUbKoCKh/
 7D0WophFxT2JbnNuUrT+vwJ2hgIU6UK7v3Q9oMcgdM0VSp2ur4mwi
X-Received: by 2002:adf:cd03:0:b0:33a:e6f2:4a48 with SMTP id
 w3-20020adfcd03000000b0033ae6f24a48mr2989305wrm.64.1706783708788; 
 Thu, 01 Feb 2024 02:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyTp/wj6+egi65CtM3fOJRKzZEkywasgY+3Q8B/Y5ExEdeIUoc0WdCpOrSayhDbmhML7XTbA==
X-Received: by 2002:adf:cd03:0:b0:33a:e6f2:4a48 with SMTP id
 w3-20020adfcd03000000b0033ae6f24a48mr2989290wrm.64.1706783708484; 
 Thu, 01 Feb 2024 02:35:08 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXBfCqA7f2TJD3/uaaCCE599DHgaesqCjkjs8ErLDc+hY4q8U+blP+uBzkH/Evi1xDeUoaaV8hEJnc0gx9ohBNfKTyOH4H/WEl5yspXk4QJKQYPeMF2IUCzlL8=
Received: from ?IPV6:2003:cf:d73b:4144:8f0d:1c55:f035:1a2b?
 (p200300cfd73b41448f0d1c55f0351a2b.dip0.t-ipconnect.de.
 [2003:cf:d73b:4144:8f0d:1c55:f035:1a2b])
 by smtp.gmail.com with ESMTPSA id
 ch15-20020a5d5d0f000000b0033905a60689sm16025367wrb.45.2024.02.01.02.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 02:35:07 -0800 (PST)
Message-ID: <6c4f687d-a981-49a7-addb-d490fe060c41@redhat.com>
Date: Thu, 1 Feb 2024 11:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
 <ZboeJIXKDP7OP9YD@redhat.com>
 <ed004630-5b85-4ad2-a22f-475571d0df33@redhat.com>
 <ZbtwvQISnyDjVl7t@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <ZbtwvQISnyDjVl7t@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.02.24 11:21, Kevin Wolf wrote:
> Am 01.02.2024 um 10:43 hat Hanna Czenczek geschrieben:
>> On 31.01.24 11:17, Kevin Wolf wrote:
>>> Am 29.01.2024 um 17:30 hat Hanna Czenczek geschrieben:
>>>> I don’t like using drain as a form of lock specifically against AioContext
>>>> changes, but maybe Stefan is right, and we should use it in this specific
>>>> case to get just the single problem fixed.  (Though it’s not quite trivial
>>>> either.  We’d probably still want to remove the assertion from
>>>> blk_get_aio_context(), so we don’t have to require all of its callers to
>>>> hold a count in the in-flight counter.)
>>> Okay, fair, maybe fixing the specific problem is more important that
>>> solving the more generic blk_get_aio_context() race.
>>>
>>> In this case, wouldn't it be enough to increase the in-flight counter so
>>> that the drain before switching AioContexts would run the BH before
>>> anything bad can happen? Does the following work?
>> Yes, that’s what I had in mind (Stefan, too, I think), and in testing,
>> it looks good.
> Oh, sorry, I completely misunderstood then. I thought you were talking
> about adding a new drained section somewhere and that sounded a bit more
> complicated. :-)
>
> If it works, let's do this. Would you like to pick this up and send it
> as a formal patch (possibly in a more polished form), or should I do
> that?

Sure, I can do it.

Hanna


