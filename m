Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC01C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3DR-00041r-4I; Wed, 15 Jan 2025 08:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY3DN-00041S-OD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY3DK-0002Gi-P5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736946819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQ+Bq79lXlwOY9/UHtkfJPhO/LFQPcrGRTNjIhsVoeM=;
 b=V7xV4Tx0B3+g52I1HXZLD8gjb2srcQCQpHCV1/3V3MPArHLbR3WpfbNuzvB8fejVRXaNef
 Anj3rM15LsJfXMF8f4tsYpEReiC++xDrGOZWzANSPU87HQ9o8uzzBk0ROSVlyNfubBHtR2
 u+8uErkF3OYglA5nQE0YEDk/JuSGKfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-5WyAIEBaP62aiTuXutT8dQ-1; Wed, 15 Jan 2025 08:13:36 -0500
X-MC-Unique: 5WyAIEBaP62aiTuXutT8dQ-1
X-Mimecast-MFC-AGG-ID: 5WyAIEBaP62aiTuXutT8dQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so53614085e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736946815; x=1737551615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQ+Bq79lXlwOY9/UHtkfJPhO/LFQPcrGRTNjIhsVoeM=;
 b=rNG7FuiAXaWatSxZfOqP2r0WBwIkQFFHKjzUyWLrsxBDINWwgH8w+0xxDzzMsS98+U
 OxeVa1AkC82yULQSb1M797bl+HnwYcNb1xnfLfxg01vE040tMbkJPFY+ty/bheV8JSBE
 zaHZQ3G7FMbYw6uTdikmu//cuJcrho+KB6pC2UtPeQiufpZne82ZOi+kQeVLq1Jd2cUz
 O8i7MsXdvwq16Ep9q97pedqJdY/9cLFpsd63zD6XrQqS/T0UcvS8J4enVDL7dVITGD5V
 0K5TazvhIVQelRYzZ8lr0GAZvHU/lAz+J3H4nvmDCXI9p1eQWoC7LHpFgLUIG81ihOTT
 /Otw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Q9wrsruXOgqv4sVtuDR+qvzjPyvF5mTdJhBcRgxHcslFl5J6ACGSTLrNKkmOCis5jSct5HQxdlqO@nongnu.org
X-Gm-Message-State: AOJu0YyRii/JMN7QZp7SHcrN9Io0JcLlPUkIvu2B6uEKPbdq4ic9StE9
 pyxFmjc2dUUoObLHj+zyr9rgdlw9TbjtTr7x/1ZeyT3WXrZ+OBYHCUTyy5KcULBXjvzydMIuqWh
 P8gncKrFvSu0gAsSxIJfm3z/e8b97gLbpuKQXJjkwzt/250TyMQjR
X-Gm-Gg: ASbGncuOy2p/UQ20AQthBnrFOyQG1w74RkIHAXenuap76Bb6W/4k8JBa0GFvKC17Cdu
 Dl+m+ljAj9Vj22Q2klqbaLS9tVMoJAWyw1Vs0n3L9kzDQY+6zeX8U/iSGR2WjCDSoGmRn3+0TCZ
 meepgz1YGS+hZyDYKqkzBFoPL42W6D5HBR1rrCANRRZZ5g3TqKZNGsvaenXcVt3zvRpdXM6l1Bl
 balV2zuN9/DON8h00F3g7qaSUutPGZerfETw+wjbQF9X0qKGawijjYMN/g4riwS939527T33+Wu
 0kh11mkEJBMfT1G2tNdz0N6OmAcB
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-436ed3316a4mr226140295e9.12.1736946815557; 
 Wed, 15 Jan 2025 05:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+mcKeHlhfgvDTQ7D6zen3YYvkNgP3ZBHU2dN9lZdPnguzeTxgaZek+YS5ORutpJpx9qd5kw==
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-436ed3316a4mr226140105e9.12.1736946815269; 
 Wed, 15 Jan 2025 05:13:35 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c0f026c0sm27220525e9.0.2025.01.15.05.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:13:34 -0800 (PST)
Date: Wed, 15 Jan 2025 14:13:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <20250115141333.005ab3eb@imammedo.users.ipa.redhat.com>
In-Reply-To: <Z4Z25p0YvBEtV2/Z@intel.com>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
 <Z4Z25p0YvBEtV2/Z@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 14 Jan 2025 22:38:30 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> > I this specific case, one basically replaces /machine/unattached
> > orphanage with explicit /machine one and many 'cpuN' children,
> > which ain't any better than device[N].
> > 
> > and in future I can imagine that at least in x86 case vcpus
> > might have another parent depending on configuration.
> > (i.e. being parented to cores instead)  
> 
> I remember that this was your idea all along, and I'm not sure if you're
> also referring to my previous patches about hybrid topology :-), which I'll

I'm sorry, I've should've reviewed it long time ago.
But it got lost in from my review queue, can you give me a pointer
to the latest you've posted, please? 

> continue to refresh afterward in future (after all, the hybrid architecture
> will continue in x86). And I think, since socket/core/thread are the three
> default QEMU topology hierarchies, I understand that it would be best for
> thread to always have core as parent.

I guess it's fine as /machine/cpu[N] for now,
what I've initially wished for is commit message that explains
how do we get there and why it's done, so that later, whoever has to
touch that code would have an idea why it's there.  


