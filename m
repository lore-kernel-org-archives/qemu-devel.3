Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A3C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiysF-0003zU-9w; Fri, 14 Feb 2025 11:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiysE-0003zD-6Q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiysC-0004wD-Ls
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739551742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vomPoaYFGhtXjNxuNc4pRAjPLS0bKTTHRuaypjGeGzg=;
 b=a7XWQjtNgyaWRjXFDVHvsiCX+50vGvnQ+IelpSVpU0FKyDYt3KO2J7GyqZL4wKOI+ZEJEv
 9tTpwefXLgpat8JP6oAIx37oGeIw5BfyUQ1X5HF6XsKBRzpC8H4Op+L7000AtPSRtACnj2
 6/2Xwf/fKQWjQHgNjH1mncKOwdXq4W8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-jkp3Hx7fPtOkUTotsdxBpQ-1; Fri, 14 Feb 2025 11:48:57 -0500
X-MC-Unique: jkp3Hx7fPtOkUTotsdxBpQ-1
X-Mimecast-MFC-AGG-ID: jkp3Hx7fPtOkUTotsdxBpQ_1739551737
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4395586f952so12311765e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551736; x=1740156536;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vomPoaYFGhtXjNxuNc4pRAjPLS0bKTTHRuaypjGeGzg=;
 b=OZIDz9pPYwP0vykPhJv9ijl5AXc//3AaHl9778R9QX6KUzz/IlKgm+gTNFtwQS7qCA
 wXNbxwYxiZ1KmdqUxbTvHdfaHHsVi2IrKcl/VL8lRFWNVwadEx/AiJ59oT1vQBN9GY3X
 K9FQtiuh1KaED2js/o86bbD28FE69kFzifM03XFk663tfGuAPLwX5yVinR2PlbtcDUvS
 gJuK6YK2bMlvHCDLKttzsKJTXMe0DB4/VoihdArc76SsVKjLTCKeRTu6xcfI0YostHQb
 5HU6Ljbn8BJ6S5y7WsKMBYFE1lX53onzYNP9QCzoxMJfQ3ZUwtmViPiQtvriT/a2Y7Ia
 8HvQ==
X-Gm-Message-State: AOJu0YznLlyNZN6CGZp1Aq35bY7+6UyS36pXjbImhuzGp1r/YdIhawj3
 PY9LqD6mZOPX9nkyNMuz3DjB1HlJwSggpYPWHhpFvdnMZoHKyx5bNfsnnZ5+Cz5Lh6RVfPBhz3K
 HIM/ZP7bnYc3mHx2+yG5rSPDtcPQbzumKDsvqtZ/qxtdgc3e0ofO/
X-Gm-Gg: ASbGnct+8k+9LnyJyv56T0p240QUfZsmXxx+VaYp76N+LiRMTH/FguJRL0WcgbnnQvf
 +6GNq8f/lYbkPCGCb5aW6nuJVFEcMK4WJnDbn8eMYyptghazGLDYGzvPpB7IeyIc0ERQasEfWeg
 /6JbJyM/O8hAZBuDH0bBQgMYcEiCi2REal4bj1qqervCYy8gM4MyBHMcq1GQ1DR8xMcIFPILX9+
 CjY9IX4dAFQgyUfdanh6fP6D/7IBhPEpCT7wP/52GLtnMXu654TMDZiS53FEdKI01qdP2bs3DU7
 pP3D1eogwu6WoiX5X5e3gRYWBtFAh/9pPbAgszmv2tE=
X-Received: by 2002:a5d:5f4b:0:b0:38d:d99d:d221 with SMTP id
 ffacd0b85a97d-38f244d54fdmr10506290f8f.1.1739551736545; 
 Fri, 14 Feb 2025 08:48:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrEqw4BZ5q/wDHG8pUnLLoprdtfAWaHzy5KJ1/ZpCYStlZ0Tto5PsKzUKn726TMcDQIu8yHQ==
X-Received: by 2002:a5d:5f4b:0:b0:38d:d99d:d221 with SMTP id
 ffacd0b85a97d-38f244d54fdmr10506243f8f.1.1739551736169; 
 Fri, 14 Feb 2025 08:48:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44a7sm5168769f8f.12.2025.02.14.08.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 08:48:55 -0800 (PST)
Message-ID: <725bba32-9d33-4f26-8891-8c44ec4e3b16@redhat.com>
Date: Fri, 14 Feb 2025 17:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/45] Live update: vfio and iommufd
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <45420461-ead5-4b72-8f84-cddf53e2b95b@oracle.com> <Z69qDWTaNCQobUiq@x1.local>
 <8b30c6b4-1c5f-4bb0-9a85-e364ad2840cd@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8b30c6b4-1c5f-4bb0-9a85-e364ad2840cd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

On 2/14/25 17:20, Steven Sistare wrote:
> On 2/14/2025 11:06 AM, Peter Xu wrote:
>> On Fri, Feb 14, 2025 at 10:56:02AM -0500, Steven Sistare wrote:
>>> Hi all, it would be nice to get this into qemu 10.0.  Without it, the
>>> basic support for cpr-transfer already in 10.0 is much less interesting.
>>
>> True..
>>
>>> Soft feature freeze is 2024-03-12.
>>
>> Said that, targeting 10.0 for such a huge series across multiple modules,>> and especially during the time VFIO review is on heavy load.. may not be>> easily achievable.  It might be more practical, IMHO, to target this 10.1.
>> Review can still happen during / after soft-freeze.

yes. It is *very* optimistic and it is also a question of stability and
maintenance. One "big" feature per release is more than enough. "multifd
support for VFIO migration" is the next candidate.

And I am sorry Steve, I still haven't looked at your answers on v1 ...
They are next on my TODO list.

> Understood.  Let me know if I can do anything to help.

Well, what bothers me today is that we have been adding a lot of new features
in the VFIO subsystem these last years (migration, IOMMUFD, etc) and we still
lack decent documentation in QEMU. That would be a great addition. For the
series "multifd support for VFIO  migration" too.

> BTW, the series is less huge than it looks.  I divided it into small patches
> as requested.

That's better. May be we can merge cleanup patches preparing ground for the
larger series.

Thanks,

C.


