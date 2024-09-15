Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E8C3ABA8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 20:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvab-0002bt-85; Sun, 15 Sep 2024 16:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1spvaZ-0002XN-LM
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 16:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1spvaX-0006FH-Rc
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 16:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726431077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/Aal7oMdkFqJExyU2wmn0b4UCi6uTKAnibRDtGiHzQ=;
 b=DdfaEvyzfupva8Q09VJ085BuYb33HF35GetnAJHA7CjhNSGGY8NvYWXhJbDmZ6hVLgdC7S
 WrY3oQ9FtcbbTKG5ujk3aTTjJMjOdZtLoiGQtMW9NMuJLNSb1nfiwEDWa4Vh/eeD1fxa8/
 2kOkAAwtUVhWB2O/CTZPYp+OJpAF4n0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-ESBcE3ofMtyFFIcn0zjPkA-1; Sun, 15 Sep 2024 16:11:13 -0400
X-MC-Unique: ESBcE3ofMtyFFIcn0zjPkA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb5b01c20so17686235e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 13:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726431072; x=1727035872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/Aal7oMdkFqJExyU2wmn0b4UCi6uTKAnibRDtGiHzQ=;
 b=XaMwnfmNdaUSgVoelCZPXSBG0J9oOW3oRZXODJ9hi4mMgKV9joNQxfhR3i8jhYkx/v
 EhIv539CTCidJCI5O0jcB+jl7jh0Q0lQAaZIaMWM8wbB6X4LzA+IsLiA6cv0vqvMwfnP
 SGCERQgZmQoNJB9hqVUBupJKbzwIVNPM+B7zwUbrX5q6EkPPt/4VeEDo/0OtFy4A+SGf
 MERWMNdrHO1LFXvou/tkna/eo0Xq3jhwkqMQT3zhXY6y5PSg55V5IuqbAU0Wj91LJ2hu
 dLjkFPXNWaA+J1TIgumuJwpr5+v8suspy+6KGBUCKoN+/eBk26WeJQBL20mHwJkP/I5s
 3ApQ==
X-Gm-Message-State: AOJu0YybLfdukLmBxVZDXN4LLrFqbIEKuxT++YdV0nB1bjsvuhTF6qdw
 HMATy9hbfDtFJh8gEZ2DTZg0pEB/fhmY2uD7R80NBNCPbsbh93HZxP+cl5ZbQZWOv/62TRoH6Vf
 oZxVjJuou+tFEQQyNfAWrGAQ/Kws5uWYv7hTBigWTJRBcgvmQbm5l
X-Received: by 2002:a5d:4a52:0:b0:371:8f19:bff5 with SMTP id
 ffacd0b85a97d-378d61d630amr5632988f8f.3.1726431072653; 
 Sun, 15 Sep 2024 13:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3hNGnd1+MUbXS4RgNOPsp50XvmfL3yhx6eLkM4vxD6tqTNM8EFURAIWZ3tuZdiWrOvG/nng==
X-Received: by 2002:a5d:4a52:0:b0:371:8f19:bff5 with SMTP id
 ffacd0b85a97d-378d61d630amr5632967f8f.3.1726431072087; 
 Sun, 15 Sep 2024 13:11:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:a6ac:b342:4c4b:5907:bbfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f649dsm5318059f8f.53.2024.09.15.13.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 13:11:11 -0700 (PDT)
Date: Sun, 15 Sep 2024 16:11:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v6 5/8] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <20240915160953-mutt-send-email-mst@kernel.org>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-6-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905195735.16911-6-dorjoychy111@gmail.com>
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

On Fri, Sep 06, 2024 at 01:57:32AM +0600, Dorjoy Chowdhury wrote:
> +const struct nsm_cmd nsm_cmds[] = {
> +    { "GetRandom",   CBOR_ROOT_TYPE_STRING,  handle_GetRandom },
> +    { "DescribeNSM", CBOR_ROOT_TYPE_STRING,  handle_DescribeNSM },
> +    { "DescribePCR", CBOR_ROOT_TYPE_MAP,     handle_DescribePCR },
> +    { "ExtendPCR",   CBOR_ROOT_TYPE_MAP,     handle_ExtendPCR },
> +    { "LockPCR",     CBOR_ROOT_TYPE_MAP,     handle_LockPCR },
> +    { "LockPCRs",    CBOR_ROOT_TYPE_MAP,     handle_LockPCRs },
> +    { "Attestation", CBOR_ROOT_TYPE_MAP,     handle_Attestation },
> +};

I think we should stick to the coding style and avoid camel case
for functions. I know, it is tempting to stick to what
some spec says, but they are all inconsistent. Put the spec
name in a code comment before the function, should be
good enough.


