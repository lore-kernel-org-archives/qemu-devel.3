Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69B4D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9ry-0001iT-Fr; Mon, 02 Dec 2024 12:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tI9rv-0001gb-VU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tI9ru-0002mE-4I
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733159152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dQnpQ3sHtvRtbDyBwk4Kl0rj65z4J48wQlg7hgAuHHw=;
 b=b+6N5YCTYM/t1MmlabhIiFfUmb2jPvyayBmBwz0/Nh6lYs3QfwZue7xjJtKpM1jaewBOwQ
 5FOe5+wsDoSeI9820QQWrso7EyeXWaPFrnO/ft9TuHMrHWawR0tEF6pfHL37MzvGqu7FDZ
 hnFp2Q3oVaq/qtX5NBEBy8tE69M65Ec=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-JlOH-WHlPiaONoLXVO6s6Q-1; Mon, 02 Dec 2024 12:05:50 -0500
X-MC-Unique: JlOH-WHlPiaONoLXVO6s6Q-1
X-Mimecast-MFC-AGG-ID: JlOH-WHlPiaONoLXVO6s6Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a9dce888so28917155e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159150; x=1733763950;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQnpQ3sHtvRtbDyBwk4Kl0rj65z4J48wQlg7hgAuHHw=;
 b=MQvDdAkDadSH9n4qh4dP/F11ufpHiH+NCTahWJiG8uykkANz+HmQ+tdJ6wBE6ngJiB
 f9mChbX/UaQMxDSI0dJ/q32sponrIWKLEb36hGi3ThiPSvhkMOaDY7DQQL1Nhme4gvRV
 JAD3T3n4MGLTpQHPXNbgybHu/t7Hie3s3ot7i1mFQg1uoOZxqD5Vr8vHFbDPuS1GjM8P
 Tnqj23/ZPTSxqHSgwxjsVpRpkyockFyIcKaHIfqB8UtkRbLCtEkFVvdFuNYZ8FHnnX15
 VhUu0HIMauddGFEG0Peb97MTgkGnCH/wTCM4HV47LTPG9kJQz/nF+TDsLZiX4BkKNPg1
 8EnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO4kowzVfRMuSvh+tKBBwRFENeRIpcvpOTnyC051sJ1ivD9cX6Q3jPkNUgIMkTu22D38S0VxCeLQ+Z@nongnu.org
X-Gm-Message-State: AOJu0Yw6S/kYaj2RTHBRbsoQGi6E3ZhCs/Qgfvk22y+uZ/9UP0dDzl6P
 rqYj471ci+6GCr+10FFI31/uvnTK9qeZoqtrcI7q0ZEFEtiuZU9lJTZOpr7FT2u7qxwaQf9cidQ
 DYKZVa0gly41cp+aTJegIe3ObAesxR7MDoZQ8hQVv8fSW12CVmPHs
X-Gm-Gg: ASbGncuZktYMbk56ZItZ7btr0ico2YEoXJ5J3JNoL8c5a/xc9ELc7XpbCUagFoxQAVq
 OKDUEbXFWfrMcnbgJopZDbrqM+O/TiTpiPHBfZ6X70SWtZmIFYusQX2Kxhvv4+Rs8sD+mS6aIRY
 iaF6hw27zx9dTpOWiL0N8oqI5gA4cHmdpqQ/5qZKP53g1rF9p/6bXWHeshhdXhzSn1a9H0BkOOW
 WXzxdGM1waY8YsjTDEiOb82/vrnbQQxxhsWMPS8zlM6ZiAHqbY39lXMxF0N0YnAWpgqfSA/nfXq
 TuDYIh3X+78mNRv1rYTzZm9tlGVRTjuVI+7xQCNaZHUCsakcniHhKoT6+D8Ls9csi9KNKc9bx6q
 jLw==
X-Received: by 2002:a05:600c:4747:b0:434:a07d:b709 with SMTP id
 5b1f17b1804b1-434a9dfc3d4mr198368975e9.29.1733159149314; 
 Mon, 02 Dec 2024 09:05:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhshDXazRK9av1stXVZToYWxiVnwMu4Xmfdw5EE3wdN1UhyBxXQuunowcW0QCNwZqtGBpLmA==
X-Received: by 2002:a05:600c:4747:b0:434:a07d:b709 with SMTP id
 5b1f17b1804b1-434a9dfc3d4mr198367115e9.29.1733159147871; 
 Mon, 02 Dec 2024 09:05:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:ba00:bcff:e7c1:84bd:9486?
 (p200300cbc73bba00bcffe7c184bd9486.dip0.t-ipconnect.de.
 [2003:cb:c73b:ba00:bcff:e7c1:84bd:9486])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f327casm161309115e9.27.2024.12.02.09.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:05:46 -0800 (PST)
Message-ID: <24ae6e7a-1cba-4898-bfbb-5f5d3e5c3256@redhat.com>
Date: Mon, 2 Dec 2024 18:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3 for 9.2] hw/virtio: fix crash in virtio-balloon and
 test it
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Martin Pitt <mpitt@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241129135507.699030-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29.11.24 14:55, Daniel P. Berrangé wrote:
> See patch 1 for the background info on the problem
> 
> Changed in v2:
> 
>   * Add qtest coverage for the crash scenario
> 
> Daniel P. Berrangé (3):
>    hw/virtio: fix crash in processing balloon stats
>    tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
>    tests/qtest: add test for querying balloon guest stats
> 
>   hw/virtio/virtio-balloon.c             | 16 +++++++-
>   tests/qtest/fuzz-virtio-balloon-test.c | 37 -----------------
>   tests/qtest/meson.build                |  2 +-
>   tests/qtest/virtio-balloon-test.c      | 57 ++++++++++++++++++++++++++
>   4 files changed, 73 insertions(+), 39 deletions(-)
>   delete mode 100644 tests/qtest/fuzz-virtio-balloon-test.c
>   create mode 100644 tests/qtest/virtio-balloon-test.c
> 

@MST, do you want to queue this or should I do it? We should get this 
into 9.2.

-- 
Cheers,

David / dhildenb


