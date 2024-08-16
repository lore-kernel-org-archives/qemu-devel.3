Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF570C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serUR-000356-0b; Fri, 16 Aug 2024 03:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serUO-0002wo-PL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serUM-0005eu-PS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723793706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4u8nxgWC/gqO0RGPQQ9ymKXs7Pit6FP+5zYMtUSoOg=;
 b=jQ3908aLGLvDffCN5vygRNg+xrgY2XxXpHFTkG7w4BKQ5TTPPbyrpMCuXSfUZoKSv5qqMI
 xehviIG5tWFX8cAiO9w4OJTS94lInxBwifcIxrTGBdsZCKYx3OWtL/c2rm5l08bJsO338g
 tdxVIzqZqWVgvtzA/ZsbZY7o0jmFYO4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-6IJl0-otOUqOYIxM7vfnQQ-1; Fri, 16 Aug 2024 03:35:05 -0400
X-MC-Unique: 6IJl0-otOUqOYIxM7vfnQQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a8d5ad9bcso116679166b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793704; x=1724398504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4u8nxgWC/gqO0RGPQQ9ymKXs7Pit6FP+5zYMtUSoOg=;
 b=ujd2mqCQMxhrRtfFPxVPcXSH+uUMHjDde0AsLhLSkJqeTazjAzVup6q/h17Vdk5Q/E
 xOcXznXXpYP9F63j5p0neiPOSyQxowKm3rcQLpVHp/5V8jyAhsMZVAMrZR6hB+qGe37W
 aK5Qi021Z+LJMvZiaZkJKjZ3cWeZlpraogfv7r+JxxOzLjmYmteAS2xblkHad2HNmgcv
 BIEjVJ9Edg2YOPwG4pi65nhDbwtuu8+nzdWlvaTUMD6UPPhnVmQkKLRSZjdMcKta3t/G
 xFxkKor7aU46nzV+bMbCzjI2Y4H1Gx8dUO6D65yhKfHDBA2QfxOJIQqQN80qPePV8RvI
 8uvQ==
X-Gm-Message-State: AOJu0Ywr1hR0uEOZRaWSDZ/Bxl9cRUCxR9xzWsSbojZKiL8dphY0htqk
 u/6bjOsu0GZaR2+3IJNp9IYlfHV+n9vIqfrc0TgeL4ZfIsKb/hnE97UThZWOjGtMrOfDJXo5FEB
 EZjC5QXhRK1tbRoECkNINmwKZ4URPRab+zaGp8TsEkTrStmGqbJk6
X-Received: by 2002:a17:907:9489:b0:a77:dafb:2bf9 with SMTP id
 a640c23a62f3a-a8392a11535mr103945066b.49.1723793703807; 
 Fri, 16 Aug 2024 00:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGjCB1tg5Pgitu0PpRtOzE9/VS4NWwU/MnzaBykcxPEXDtWwGXU+5tu4kIMAhAFFZvedSEnA==
X-Received: by 2002:a17:907:9489:b0:a77:dafb:2bf9 with SMTP id
 a640c23a62f3a-a8392a11535mr103941666b.49.1723793703056; 
 Fri, 16 Aug 2024 00:35:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:3378:6322:e9ee:713:b9ed])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383745e66sm214218566b.0.2024.08.16.00.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:35:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 03:34:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [RFC PATCH 0/2] async: rework async event API for replay
Message-ID: <20240816033046-mutt-send-email-mst@kernel.org>
References: <20240815132838.615330-1-npiggin@gmail.com>
 <20240815113029-mutt-send-email-mst@kernel.org>
 <D3GZ90ORAGBC.EPV2C5TYYGKG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3GZ90ORAGBC.EPV2C5TYYGKG@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Fri, Aug 16, 2024 at 12:23:50PM +1000, Nicholas Piggin wrote:
> On Fri Aug 16, 2024 at 1:30 AM AEST, Michael S. Tsirkin wrote:
> > On Thu, Aug 15, 2024 at 11:28:35PM +1000, Nicholas Piggin wrote:
> > > Continuing the conversation from the thread about record/replay
> > > virtio fix. Here is a sketch of how we could improve the naming
> > > convention so users of bh don't have to know about record/replay.
> > > 
> > > Thanks,
> > > Nick
> >
> > The API looks ok to me.
> 
> Thanks for taking a look. In that case let's go with the fixes for
> now so we have rr regression tests in a bit better state, and I will
> resend for 9.2.
> 
> Thanks,
> Nick

No, this is big because you are structuring this wrong.
Work, then rework ... I do not really like this kind of thing.

Add sane APIs and use them keeping old ones around, reworking old code
can wait for 9.2.

-- 
MST


