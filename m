Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33295C3ABA8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 20:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvZG-0008Nf-OK; Sun, 15 Sep 2024 16:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1spvZE-0008NB-VN
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 16:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1spvZD-000614-Eb
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 16:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726430993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfXBuDPS1pcGoME0ttROND1t6wjVLVHNlc2E7T0aUt8=;
 b=hasH4p7CMF1PJ/WRyis5i/wS8YPREgvXC1fpnf6Ms61yiApTxe2xzLH5PNqcfO1T+ZjAf1
 YxVSyoRJxBPJjwmpewTG7gOTHpgTqxg23o9V+4fMSi4zLTlM6GdjccBKZ1HgP2L5K51VKA
 ZABRmVc02MMgovWN+JTlq/UBBGs6Zpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-kvFj_4cxPCKw0-thuaJwEQ-1; Sun, 15 Sep 2024 16:09:52 -0400
X-MC-Unique: kvFj_4cxPCKw0-thuaJwEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cc4345561so24048605e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 13:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726430991; x=1727035791;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfXBuDPS1pcGoME0ttROND1t6wjVLVHNlc2E7T0aUt8=;
 b=ksKObr+9Anw/v6nryvimjLCNlBKtbGUmHrIsrkifF0+LxO7Oq/QxKnMlgScLqX9+Ea
 aCzgR0zUILnw7kAMPXoUdBHOfgSkoKKa2tQxwpadaYaEZnb6mzPRUmxPj7W8XlQ1OLsI
 VDz43l3EdZCTE0y7iP/EaMKf9Cm8m2nnYZFRy8zZMSPLYpFA73xSDEqZs/NbrZS8Dz+1
 vZ6x5kvcxHJj4PaKhyHt+d4bOpL13hTUotpraREiLt3dS7fDVW/+OQlEKXNhWNcR8/uJ
 Ea1FWNbrzC6xmRkHNd8Z6ojoC3Aopm37rcrUWCmR+MbYnLntxxCWosOwES04ZdTmQhcq
 LV1g==
X-Gm-Message-State: AOJu0Yxdg8ngrfEq7aEEgOLCG/xksK6kTe3QZUBq/dpNVQbImbGhKXm/
 tywBeufDsxWTgeI9x2yYNE/L2HIqBHW6c+96bfJmAq1Fcxw4d75hiSP9rYwhrttrEqYxOA1iL7l
 iMlfeMJEwxR/AOpkT+xVmSETd2a+y1g4uq+VfLGX790YZqo/oTHfa
X-Received: by 2002:a5d:4092:0:b0:374:c481:3f6 with SMTP id
 ffacd0b85a97d-378c2cd58c5mr6983251f8f.8.1726430990920; 
 Sun, 15 Sep 2024 13:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7RFqrFek8X4DOYyFmZeSsPpjjpQlMkVHsZ/wnZLWPe8HozUl/mO4VmZEsRYdhUNYxfJ8jg==
X-Received: by 2002:a5d:4092:0:b0:374:c481:3f6 with SMTP id
 ffacd0b85a97d-378c2cd58c5mr6983246f8f.8.1726430990292; 
 Sun, 15 Sep 2024 13:09:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:a6ac:b342:4c4b:5907:bbfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e85ccsm5314366f8f.42.2024.09.15.13.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 13:09:47 -0700 (PDT)
Date: Sun, 15 Sep 2024 16:09:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>,
 Alexander Graf <agraf@csgraf.de>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, slp@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 5/8] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <20240915160729-mutt-send-email-mst@kernel.org>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-6-dorjoychy111@gmail.com>
 <20240915152546-mutt-send-email-mst@kernel.org>
 <CAFfO_h4pcz=2n+r5FzpDU1+hvjLRkQXFzLtuEkTQnu5csnyi=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h4pcz=2n+r5FzpDU1+hvjLRkQXFzLtuEkTQnu5csnyi=Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Sep 16, 2024 at 01:46:52AM +0600, Dorjoy Chowdhury wrote:
>     > +    len = cbor_serialize(root, response->iov_base, response->iov_len);
> 
>     As far as I can tell, all these also need to be switched to use
>     iov_from_buf.
> 
> 
> Sorry I didn't understand this. The iovecs passed in these functions are not
> the iovecs from virtqueue. We make an iovec for the response and then pass it
> down. We do the "iov_from_buf" after calling "get_nsm_request_response" in
> "handle_input" function. Am I missing something?
> 
> Regards,
> Dorjoy


Oh, I misunderstood. Passing in a pointer and length might be clearer.
Not critical.

-- 
MST


