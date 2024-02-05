Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F46C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtSj-0001A1-RK; Mon, 05 Feb 2024 02:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWtSh-00019h-HJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWtSd-0002NN-2v
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707118330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SZttAUjkhFi20XBsfAB/nqN0sbWfdapjCST6nQkd0kw=;
 b=Kg0jvf8iYzHvk3MjLXT8Fk0MCwkTqVwLT8qLqhZCZy2prMAuRnTtLN6kxAMxYe1qPfhguK
 BEtmajGOtMUb0Jww6uHFwEq77xCjNdwCnLEc3ye67GPO6w+LpM0kXtDHupJDHY5MuL7b+g
 vOe2OX9bUaTEV0ZY0Ol4Q02dcSrMze4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-XaDh4GKIP4C6rH8idxiitw-1; Mon, 05 Feb 2024 02:32:06 -0500
X-MC-Unique: XaDh4GKIP4C6rH8idxiitw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51144722c56so1571196e87.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 23:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707118325; x=1707723125;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZttAUjkhFi20XBsfAB/nqN0sbWfdapjCST6nQkd0kw=;
 b=ORdE/xeLFpDGYrlMxEhKAt5VlSYongVnBSpd/iV/wZSxF47V4KwIo6UD7/dKD/a5rd
 oXc/VVIV8DD2Nce/7cCGpKpH8My5JBrkZm5AGUw0WzFTaZe0imyi9zOoAK9ZmvqhIU44
 ITJL4ElWat4PPARdCfvPetvZGXcXPFA/mCexyQN/yqT3iEhRQigIhRT4HjR57je2utJD
 6STqBEw0cC/p/9VhSiISFCiH4iHtcrrQ1+/Nw5OT4FkrSmbGk/Ut+by5O+Uv2EiXI5a+
 vmPsYVv2iBIpiKXEn2DN2FmGYIVctrtb8ZwYfoRcRUUQtKCw2HAoNKtB25RA0/AMbGwW
 iqrA==
X-Gm-Message-State: AOJu0YzpmELrrMDk2/RE6r7/gvcKYHkm2ZG6kSy56gpEzpnTPHSn0+Yk
 +FaKndqJaYFsm+cF3ddoABlTLluBMwm9TA+AxfzVqjqE6AhctxAgzKZkqjYEs4cRkec9VZIqJq9
 8EVUyIrziBxfHAtd5cn4l7Q+/iXAhFhW7dFx9dD7zkKoJZ/fdeJnY
X-Received: by 2002:a05:6512:3585:b0:511:519f:ce76 with SMTP id
 m5-20020a056512358500b00511519fce76mr694397lfr.57.1707118325395; 
 Sun, 04 Feb 2024 23:32:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjiWlLrvEuk2YYbur6XUePaLrF3LWq5X0KFc+xFK8mmQhg42igEEiw+8V+mfJZ57EhglKP3Q==
X-Received: by 2002:a05:6512:3585:b0:511:519f:ce76 with SMTP id
 m5-20020a056512358500b00511519fce76mr694388lfr.57.1707118324998; 
 Sun, 04 Feb 2024 23:32:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVKB6RScxCr3hFFWgJl+g+aHadfjzXrR+RkdsE+xJ77rdEmZuUQ+irL/8cssS9iAHroaXP7D002trkw2RZ7S6RRyCrAT5W356UAEoSm5P7n/dFvy0KMWuhJ5AGvmWoBNciL+b7dE+VGmE6WOEPcNDvTOujmDdbQ+Pt1eakLwx87uAN62VRstcXHTRNU8fShKipGV4zPz00EoBU2ZCGNRq+iuq/Eh8eWR3PeulibcRw=
Received: from [10.218.83.77] ([88.128.88.102])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c19c800b0040fb0c90da6sm7641977wmq.14.2024.02.04.23.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 23:32:04 -0800 (PST)
Message-ID: <70a3d6e3-1d62-4224-b36f-f29819f33bb2@redhat.com>
Date: Mon, 5 Feb 2024 08:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
Content-Language: en-US
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-2-david@redhat.com>
 <CAFubqFuiQ5vEzELv0_y2+9KwhLDs3mNJQXMfeR4_YFMumo-x_g@mail.gmail.com>
 <8c3ffb6e-0b77-41ef-8f8a-ea67b62ff410@redhat.com>
 <CAFubqFtqk6zDPGriu-sOwnhGo4QdZpJaaS7imRRL8ZCbWaSN4w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFubqFtqk6zDPGriu-sOwnhGo4QdZpJaaS7imRRL8ZCbWaSN4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 04.02.24 23:01, Raphael Norwitz wrote:
> On Sun, Feb 4, 2024 at 9:36 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.02.24 02:35, Raphael Norwitz wrote:
>>> As a heads up, I've left Nutanix and updated it in MAINTAINERS. Will
>>> be updating it again shortly so tagging these with my new work email.
>>>
>>
>> Thanks for the fast review! The mail server already complained to me :)
>>
>> Maybe consider adding yourself as reviewer for vhost as well? (which
>> covers libvhost-user), I took your mail address from git history, not
>> get_maintainers.pl.
> 
> I don't expect I'll have much time to review code outside of
> vhost-user-blk/vhost-user-scsi, but happy to add an entry if it helps
> folks tag me on relevant patches.

If it helps, it might make sense to split out libvhost-user into a 
separate MAINTAINERS section.

-- 
Cheers,

David / dhildenb


