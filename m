Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E59CC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQCa-0004dX-Jy; Tue, 05 Mar 2024 03:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQBw-0004a5-QV
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQBs-0006u5-Te
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709627424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmMqm0PNy9md6EorKnZHsa9GgFIkrNCbqyC00aLo3dg=;
 b=cYo381OpoMmZRey+iqtU6YrMTAAxu7QPs7fX5w9hvSZWLF8VPF8RlVAjfb77fpvWlxHcVF
 mvGboiKhtDpg99SCsEovMD1tvMKEn/1QdElnOaVPpbfnJeWrTqwYZtOh3RqhvLnToecUjv
 M43fFvvBeYA0ePcR6BjZXqCI27Dt3aw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-rOEA_TjxMdO6OrxiMK4mNQ-1; Tue, 05 Mar 2024 03:30:23 -0500
X-MC-Unique: rOEA_TjxMdO6OrxiMK4mNQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68fa6c656dbso90367386d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709627403; x=1710232203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XmMqm0PNy9md6EorKnZHsa9GgFIkrNCbqyC00aLo3dg=;
 b=T11zOBv09h3TjpYvnqwvHQYnb+MgU41veVxMlZ9xjkd4shbEsLl6ja88KgkPqzpl7x
 qFwZUf7irWKBTKJOOMhSCzCg6I5jzycS07xfIoGPoskjQtvCl2XUlyghwT5jYX++qsLx
 +0g/mbQ7h1wY2U4xoqtDEi4Id3GyRQ05+YZRYq5X2hT3tef1/xO6LTvYK11oEnLGW2yI
 6nz566vxgbYdm3WJGjOmGnB9ySJavcrC9m7D77a/Xy4fU7dCD0jellEW5GDraEIG/RFg
 rxQU4EFE0dPaq/E0TSdJyKXgsPUGbTNtvnB8eeibjs6TTjkCZouCFNB9x3R70OQLfwR1
 EQ3Q==
X-Gm-Message-State: AOJu0Yyj3L+9J8f6o9IzaMMgYjXrWvIkDSo5nsFGCNDoghDE7HVJrbWi
 24A9n0G5Lb4HcTXw8NUOz8qPGtuG83IySNxHlQmdA3fcKeEvQtns704vHeZYNE9ULZkmukCNnwt
 52QaVF1ojT0VqYzRN5EACpVd+dPgf9rFgVBEKzGx9W0kFqwAPqKIt
X-Received: by 2002:a05:6214:486:b0:690:84d5:cfc3 with SMTP id
 pt6-20020a056214048600b0069084d5cfc3mr2121612qvb.1.1709627403327; 
 Tue, 05 Mar 2024 00:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/RyA3yZmYs1NjOW9LiCij5y4I3HtYeKYiAB3Y2Ybf+UgdyeluEasctSaCxzz7o48GSlQJmg==
X-Received: by 2002:a05:6214:486:b0:690:84d5:cfc3 with SMTP id
 pt6-20020a056214048600b0069084d5cfc3mr2121585qvb.1.1709627403076; 
 Tue, 05 Mar 2024 00:30:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 nz7-20020a0562143a8700b0068f71daf86bsm5977364qvb.43.2024.03.05.00.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:30:02 -0800 (PST)
Message-ID: <226fe952-aae5-49cf-8b09-82602b272e36@redhat.com>
Date: Tue, 5 Mar 2024 09:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] migration: Improve error reporting
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com> <ZebSnrfmy0_0GKwu@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZebSnrfmy0_0GKwu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/5/24 09:06, Peter Xu wrote:
> On Mon, Mar 04, 2024 at 01:28:18PM +0100, Cédric Le Goater wrote:
>>    migration: Report error when shutdown fails
>>    migration: Remove SaveStateHandler and LoadStateHandler typedefs
>>    migration: Add documentation for SaveVMHandlers
>>    migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
> 
> These four patches seem to be pretty standalone ones and got at least 1
> ACKs.  I queued them for 9.0, thanks.

OK.

I will try to have the first 5 ready before 9.0 :

   s390/stattrib: Add Error** argument to set_migrationmode() handler
   vfio: Always report an error in vfio_save_setup()
   migration: Always report an error in block_save_setup()
   migration: Always report an error in ram_save_setup()
   migration: Add Error** argument to vmstate_save()

So that we only have the core changes in log_global_start() and
ram_init_bitmaps() to address in the next cycle.

As for the VFIO part coming after, I will see which initial cleanups
we can merge before soft freeze.

Thanks,

C.


