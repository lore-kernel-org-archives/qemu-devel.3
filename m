Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6923C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMuv-0003RN-UA; Tue, 04 Mar 2025 02:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpMuu-0003Qe-2L
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpMur-00065v-28
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741074127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6WscQPj4vUoKyHeAAGbZzSy4WlC2OFMlhMYKx+S6K9Y=;
 b=YVuORfQOmKerl77SiZGkGGL3qulYQAVGwpJb3Vr2JHh3FjIV1+VVv1PhUrU0PFjDHzFuT/
 Hyi8/yIn4+LWVWqkVYGLwAZWKmyEYgTTrV+jwFGoReglrJfDtaWUvkV1fDhAGUACL3oq9m
 GVl8NLN3S7qoUD6H5TcnwqOH0ZJpXuo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-gQgQaU2jNiuz2fBU5tYnJg-1; Tue, 04 Mar 2025 02:41:51 -0500
X-MC-Unique: gQgQaU2jNiuz2fBU5tYnJg-1
X-Mimecast-MFC-AGG-ID: gQgQaU2jNiuz2fBU5tYnJg_1741074110
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so29246925e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 23:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741074110; x=1741678910;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WscQPj4vUoKyHeAAGbZzSy4WlC2OFMlhMYKx+S6K9Y=;
 b=HeHPeq78QcZTg4t35qcdXbelp53JAM3GO5+5F2GE7aQU9Zk08btuHJUrVT7aQbVxw5
 3wi32n5hTj9D/vCh1JK7cD+IhD7lQ/951az8jePyMfy0z2DSwXbvz2BhAY2834cJXy5i
 EEq7rDIi6FEFS4uhdhQX+SGeUddbZLMjznce6U8pwb0gZAlHaSbpuewKfCVqGVymHSY6
 s9ibq0+DgdxeAjT0lsHm0ZqWZp5FHWs/95g7wg09eP4Njc3Lmg0Dj9Q+UGUQRYFqO0hO
 D1FQDdCJGw3TlEzVxeKlYYe+y3iXWSXzJ6zknT19Ot2txE+EioKG/3zTLNK07pdMmQzU
 +4mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+IVVC7XyXqG21/dEuM+M4v0fH7tGXCnqCiOJr6wATypfVrbPpSOP0ALqdXh/CkoN1npCjLfLTcU97@nongnu.org
X-Gm-Message-State: AOJu0Yy433BYeFFjsA5AQFKTaEdy33fR/kIh1+oqb92amce2uJRIJIhl
 4S0hoXD2vc+f3iufUIRtzKBSXHCnUEJg6f/6GRY4oNlR4PG1vv0JGf+Fhox9hIa/4OAy18m1Llf
 JUqsL7lQPW722TpEORMhl0ThOq0ZU2JlCSpEqF8CLw+Q1vISMZtsc
X-Gm-Gg: ASbGncuVgw70kg5TYhP/oFgnvwxvkKB1xpG7xP1IZXQvXx5kZd73VXtVFhKdsznuqGz
 e6sdBnlRQuF1mm/jdWQ4xQL1g2MVxVnRozxcl4r4qzIImNc+fKA/AdTVtYm3xqYRIOiKlMJJXH2
 bG9XfxQ7FWX7zn0mrnHTUeo065OLx/18b4Kr2FP00XAaC0I9q9vngRFJosD1DEocjCOwYmakl8a
 kJIlh6t75se25udsJBKdApUD0GluwXa+PRZ5R5fm0z0dsiajtlDgnVJlzl5N7nv8ronyMRvPHD6
 RBad4HUJ8DnBmtet5nz+1O3pfw84u952rFO5iQcFSMYdzbfHNNmyZQ==
X-Received: by 2002:a05:600c:1d22:b0:43b:c390:b78d with SMTP id
 5b1f17b1804b1-43bc390ba52mr38152465e9.24.1741074110145; 
 Mon, 03 Mar 2025 23:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssnhjpRaZRtz+XyySZBLC6bFosyYI12D9opNG4CsWRWW8d/JqrnUVklkuncez3QJoGe3zyA==
X-Received: by 2002:a05:600c:1d22:b0:43b:c390:b78d with SMTP id
 5b1f17b1804b1-43bc390ba52mr38152235e9.24.1741074109818; 
 Mon, 03 Mar 2025 23:41:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc032d049sm68084835e9.5.2025.03.03.23.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 23:41:49 -0800 (PST)
Message-ID: <6888be59-09f3-472c-b993-fad0630e416d@redhat.com>
Date: Tue, 4 Mar 2025 08:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/36] vfio/migration: Multifd device state transfer
 support - config loading support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <47be7bf2f46923e2a9d2b75b1d35c6b2915c20c8.1739994627.git.maciej.szmigiero@oracle.com>
 <b9284c9a-149a-4965-a4fa-ec092e3fb7d0@nvidia.com>
 <d1bb2200-1ccf-4e52-8d34-09d95f4863b4@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d1bb2200-1ccf-4e52-8d34-09d95f4863b4@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>>> @@ -728,6 +728,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>>           switch (data) {
>>>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>>>           {
>>> +            if (vfio_multifd_transfer_enabled(vbasedev)) {
>>> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
>>> +                             vbasedev->name);
>>
>> To make clearer, maybe change to:
>> "%s: got DEV_CONFIG_STATE in main migration channel but doing multifd transfer"
> 
> That normally would be good idea, however we are already at 83 characters in this
> line here and will not fit that many more words to this string.

The 80 characters "rule" is not strict. A clear error report is
always good to have !

Thanks,

C.



