Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ezk-0008J2-9J; Thu, 16 May 2024 13:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7ezi-0008Iq-Re
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7ezh-0003GB-FN
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715880856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1x8bgVgkbSAZJAalFt9vl6zT2/FV04BS27VkNEP+aTc=;
 b=Ph19Ieh86wAHW1yUUxxgqYhJQOg+pkB1KGGbmx9JLMrREEBvYiPRc8ykzfF9+bvKQhCCss
 MV6QgV2E8vaXKIe5EWwex2oGjX62hNw/UHJCqTjr1MshWpPmViLSMHXqNmZm1Xx1ImCS11
 zcJGJRWc7xnoeznAPUGmd4OTWgP5pxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-A2E8uKUeOSqKVMQUUXsNYQ-1; Thu, 16 May 2024 13:34:15 -0400
X-MC-Unique: A2E8uKUeOSqKVMQUUXsNYQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4200ef4fb81so28479835e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880854; x=1716485654;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1x8bgVgkbSAZJAalFt9vl6zT2/FV04BS27VkNEP+aTc=;
 b=IAwg9Jx/A71xfF0Zc7cDGifFHgzekGJ5E+3s8YXhzfudlKY3BenjUl7Z2glQoFcGuo
 QvzuSorPfepV9HGaeCLBYY9aoGZ45vW3iWCSgrNHIpDaqot7wutkCfUlB/Cyr3vCCf5m
 nORSHfbv2Ms51Z5IglctBMmwr98kLLra9IFEe2CY921IUV3VyjJZ/ytx4iEXlCTGPmaO
 PKvUWFKKnTcz5WijVyV4OEal0wXo8+eQj2Gl5VZ+0RYJ5gU6a8VSQXJRw8GjZOBz+aA/
 4PecurI8bJyRW9TuxZxLfUS0aG+385ZC6x6aXUvibjcMGpH1SM0GYQ959G2KF6OpdYpw
 ee4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6yOgXE2AZ8BGoHHmNPaIpC/eXlCBprnDz8cgqU+bdbcozE6R1HD0Y3jwPtW6SGVpRmCohGxSUfeRUaaecEdQAnoVUuvw=
X-Gm-Message-State: AOJu0Yzgjh9xYkQrqYbiPSBLPXzfQSK5mkJP8rdWMmQnh8KhwFKRl9Ki
 1ZWCgFwJARp6BQvDmWtaN/NGTUBqEJp9HG1ZHStXsMDEg+TwLm9tRFVJh3jlEpfgIOLiXwMdNEK
 pRNvXqhaoHK55bKBnGOLDKwj1uW8Wgn/i7T92/aFDD/T2oUEMt47f
X-Received: by 2002:a05:600c:511f:b0:418:5ef3:4a04 with SMTP id
 5b1f17b1804b1-41fead59f07mr181333345e9.18.1715880853640; 
 Thu, 16 May 2024 10:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoCA4hlDIvE2VVhAj5a+LdLcjHf5IgVb24DZ85WRvsBY03rLm6kE09iYTufuPXBN0dLHXReQ==
X-Received: by 2002:a05:600c:511f:b0:418:5ef3:4a04 with SMTP id
 5b1f17b1804b1-41fead59f07mr181333035e9.18.1715880853141; 
 Thu, 16 May 2024 10:34:13 -0700 (PDT)
Received: from redhat.com ([2.52.2.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013bf1a5dsm171320995e9.30.2024.05.16.10.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:34:12 -0700 (PDT)
Date: Thu, 16 May 2024 13:34:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
Message-ID: <20240516133334-mutt-send-email-mst@kernel.org>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
 <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 06:29:39PM +0100, Peter Maydell wrote:
> On Thu, 16 May 2024 at 17:22, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Currently we have a short paragraph saying that patches must include
> > a Signed-off-by line, and merely link to the kernel documentation.
> > The linked kernel docs have a lot of content beyond the part about
> > sign-off an thus are misleading/distracting to QEMU contributors.
> 
> Thanks for this -- I've felt for ages that it was a bit awkward
> that we didn't have a good place to link people to for the fuller
> explanation of this.
> 
> > This introduces a dedicated 'code-provenance' page in QEMU talking
> > about why we require sign-off, explaining the other tags we commonly
> > use, and what to do in some edge cases.
> 
> The version of the kernel SubmittingPatches we used to link to
> includes the text "sorry, no pseudonyms or anonymous contributions".
> This new documentation doesn't say anything either way about
> our approach to pseudonyms. I think we should probably say
> something, but I don't know if we have an in-practice consensus
> there, so maybe we should approach that as a separate change on
> top of this patch.


Well given we referred to kernel previously then I guess that's
the concensus, no?


> So for this patch:
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


