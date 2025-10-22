Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86428CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBY2h-0004ws-Fx; Wed, 22 Oct 2025 08:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBY2d-0004l7-Fh
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBY2a-0000Ey-Qx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BnMdoa9n+q6p9Kvuj0asoAMuPstvTZk8i0GRXg9/YJ8=;
 b=SKnE+r1EIcY4ZHaD69lPxPkHau57bGY+6ekmrBveQVsu/jAsaUyZTUdijrWBwwBRKBsZwp
 EbCClMm250iHTRUIlR3ycYT4Qt+jxl2obnGO4r0GNUpDhn+lyPCK4Ov0cPDfEkC9y3UM/H
 LBcwtpirvCYkfXuh1a7X0X3sG7Mpuvw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534--dRoJ4D3P8uJszCGGWcMsQ-1; Wed, 22 Oct 2025 08:34:05 -0400
X-MC-Unique: -dRoJ4D3P8uJszCGGWcMsQ-1
X-Mimecast-MFC-AGG-ID: -dRoJ4D3P8uJszCGGWcMsQ_1761136444
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47105bfcf15so37358105e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761136444; x=1761741244;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BnMdoa9n+q6p9Kvuj0asoAMuPstvTZk8i0GRXg9/YJ8=;
 b=dxbghWY62Vx+KE5AO+yG/WG3qQWv1/ewpSc01D1c9GY/rQQX9d4decC9KmJMS/hFo8
 5ZduP/jX2UA2QoDFDOgXFVe28fBk63xilUK2umVJrp38miezKndWSSJg1ZFw/8ZPQ1/V
 ZPh7CZxjvAqCoRBrR3AK174UcRgxVZak30/8bn1YRYg7DkmsWIMSvwpZAj5xNnxSMS1v
 o3sR7aVQzlMae5SMeN86pXAPLTOTu3OXpk9BnjHfvaVqFIARkZksDAlXRhtvNZ5JVCUb
 T1pSSjOVGv5Luz12C3jRK7uzJVEUCrtm2GKR+aY/eeeLkrn80x2+5H7J09uqWbB7NWkh
 b07A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV21DlfnseIID9++phTBHhHhCFxVeNE9G+gsFTv5NB+eRzsfuG2smXbWR2go/UMmRO2nNp1GyruZo5@nongnu.org
X-Gm-Message-State: AOJu0Ywd4WKFFNyJDU2pBTVad1NaPeyPZptAo3KYnyLupezYAiY6iZSB
 ECNdd+jfh7qL+s2WlGXUBQaRr80yEllYCtUaMJQ+m1TKQozcB5ahLbfmobbrdeSkqhT2efhqrUN
 sH7pBeqwcs5Df91j0EM5b98gaCwLGH6smRz6qW42UFGV/EzWJpvHVWhlR
X-Gm-Gg: ASbGncvqkrW0lrIyoWx7pKmyUGxzlYw7qa81AVqPkr4jWzrXPcfE1kdepfcagX+KgM4
 wWtUxss9vZGoiPm+7Qr5n9bEEUnYs4DpXAXVnKvuaeVtWF68gNmEhYHvv7O1VPTOgKqPD9WonpF
 zHWdNmt0QN81kebpy/Qxs8ly8tb0Qku5F2QizP+VPMjm1RopUNihy04SFZfrbH0Opmko3HIc4L/
 aM6yotjwvnQnG4eLrceIre9ip4SXqEBtlgy1CbyU7xGeBunNHGtE89+mAiPW4f61WhePYzk3cF6
 LyvIarC+2kdO+hS54/nofUO4lsvlDN+VdXp627eFgrl4I3bhz/cBcbTlaIbvkmuwe/P6Qr4exa8
 UZ8+GazS+kuAKodcO2syB+CNrf3cR43X4kDDXIQ==
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4711791f94dmr193960075e9.34.1761136444263; 
 Wed, 22 Oct 2025 05:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYlPhbh84R7es/W3oYjHzPzgKTCft6JlDCvR9RUx3DkYisdYU9w6aGGbdRsetue7zPqlqstQ==
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4711791f94dmr193959815e9.34.1761136443822; 
 Wed, 22 Oct 2025 05:34:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c41ca845sm43694865e9.0.2025.10.22.05.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 05:34:02 -0700 (PDT)
Message-ID: <f863c93d-9bff-4be9-bd1e-344bfaf12ce8@redhat.com>
Date: Wed, 22 Oct 2025 14:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/interop/vfio-user: update protocol specification
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251010102453.711072-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251010102453.711072-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John,

On 10/10/25 12:24, John Levon wrote:
> Refresh the protocol specification to the latest version implemented by
> libvfio-user. All changes are backward compatible.
> 
> Note that QEMU client itself does not yet implement these extensions,
> but as this is now the canonical specification, it needs to be kept up
> to date.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   docs/interop/vfio-user.rst | 554 +++++++++++++++++++++++++++++++++----
>   1 file changed, 506 insertions(+), 48 deletions(-)
> 


I missed this change in the last PR. Will do in the next.

Sorry about that.

C.


