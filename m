Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AE8109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3I7Z-0005Aw-Gc; Thu, 19 Mar 2026 14:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1w3I7O-0005AB-VG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:29:16 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1w3I7M-0007nG-Py
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:29:14 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso938143a34.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1773944950; x=1774549750; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+GFDDuNZP9lpoEAedTFSRU5OOtTJHGoHb67dh2Gu+4=;
 b=cYdsYAMlCUfELWkovPvD65iUc6Eu0yThGvHEUlt6iozanRdn3OqwGpypPR5erK0/71
 rLSSYLP2FZNRA/UlvfwpajclTko82d5LWuMW4Ei5uq6Nffd1iHP0qqqxbCvcbenoNrut
 wOxhweAA8kKg3CDr6PSk4qFe3dSSbY2PLme2Div+IN9LFCjveBpL6+ghCu3u0BSuk7WZ
 kVDl70M/2GywJZiUIwnyCIYjlImFVl+aQpZZ2rtwNvm0he9534jZcIkmwyHAN0jWFbiL
 j9KRMfVnSLD/bkFrqXq4SnN1CsXjbdqViRLbjSX/PZ4Lqq1LuLP+loAN3kpA6D+jXySG
 fVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773944950; x=1774549750;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1+GFDDuNZP9lpoEAedTFSRU5OOtTJHGoHb67dh2Gu+4=;
 b=b0GVAfkN7ppVGWPNk3GxUogEQmpmCMtJ5P9VCkbA3kVTJYdfUPIktWDL3e6bHDPKIf
 bWtZ7CijrijcTXd9KVoks5W3nE/PxuoYJNeWi8it2kjzviH2h7ksgkFZ38M2NjlDinPY
 EnOjJql0k/ohvbgca3dy892op/6awYwpGpgOJgV0X56WKAA/lrTlWXjL9q0VM8/BDltX
 yj19pJURKLfkoTLoVf9SnRS6wVcXpwgPXvFsOQsHm59qvO3bRRCh6+UXidyAGDqbjJEj
 uqNNGDtuFW2B1O2WM301pFhLPb5TVW4gOUtLJqCwxC+01Nm9BcJVwKDxjpDSqul01PzP
 db6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUwu4edrDb19UCyJNF9XzqUd00Y8huRRU0g6wKwk2SbSg0nZUwjcJXJ4VXsSD1uPTTWDIeuOHjkAJA@nongnu.org
X-Gm-Message-State: AOJu0YwhQp9PTZr06WaBzt5l7BcLjLOLM2s8IOmWBddmW6jIXDZFyGN7
 m5pVl3xoOEXpThd1fNoLSiXUmLd8xnbYJLTFaqbCridVYCRZMi8juCV0TxcVhrtF5Ek=
X-Gm-Gg: ATEYQzz/5IVoy0LN2uG0mycKwnZ49en2C5mewSDS4aHvMZX39cGz57jgebkRlTKrYJS
 +b2CrT0BjvfcNgqBC65iJbAPYXyzONAG+9Ks9j7EGoFVVO9evaDkhoWLBLABOO3oheVWV/Gs5eu
 VYABEN5VQZ+Cmt2BHhnT4EaOGd2Mlt+TkQORXOGAU3vNRHKAmIcVAnkO5e7YgR6ThXd0KAAmCYQ
 0HAItqJUn2qW8gbZiTUkbkhg/PVlpVtZh5Zn1RpY6N1dc+D/GvIZW1LzphfSgB8CeqZqJdu3EVS
 Ef0Th968LjTGP8odgq25SeD7J1HX0+gxk7zErVPOxv+EB5Ye4+tWyP8DCoWqG1SdUy3tP7XVQTh
 WBN4ke9lijF7jC5V1WiTxNoi+jmgf0+NMnbbL9TW53sgYCwMpzvZXAdTkY+wZhZsruj96VWGEDo
 6aSNkozDn6J3iEgt9s+fstBSN2koWYkZqxKqSm4LeoUsrxyONfuvLZJxwJrQ60opmX31XYwNrcV
 /Ner+kQ6Q/p2Js=
X-Received: by 2002:a05:6830:270f:b0:7d7:e565:a4f7 with SMTP id
 46e09a7af769-7d7eaf75cddmr144216a34.18.1773944950134; 
 Thu, 19 Mar 2026 11:29:10 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:c752:f4d5:810f:91b3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac2dffbsm169191a34.10.2026.03.19.11.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 11:29:09 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:29:05 -0500
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org,
 Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v3 2/4] hw/core/loader: fix error handling for
 get_image_size callers
Message-ID: <abxAcZs2hXzFPKor@mail.minyard.net>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
 <20260318141415.8538-3-vikingtc4@gmail.com>
 <CAFEAcA8pktQGG5Fd-F=0SRO9MTrC0GVcOf3p8BnneqG3F504xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8pktQGG5Fd-F=0SRO9MTrC0GVcOf3p8BnneqG3F504xw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=corey@minyard.net; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 19, 2026 at 06:04:33PM +0000, Peter Maydell wrote:
> On Wed, 18 Mar 2026 at 14:15, Trieu Huynh <vikingtc4@gmail.com> wrote:
> >
> > Check the return value of get_image_size() and report failures
> > for non-mandatory file such as FRU image.

Yes, this makes sense.  You want to do this through my tree, or do you
have another way you want to get it in?

-corey

> >
> > - Use ret < 0 to detect failures in getting image size.
> > - No functional changes.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  hw/ipmi/ipmi_bmc_sim.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > index 012e2ee4fe..fd875491f5 100644
> > --- a/hw/ipmi/ipmi_bmc_sim.c
> > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > @@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
> >              g_free(fru->data);
> >              fru->data = NULL;
> >          }
> > +    } else {
> > +        error_report("Could not get file size '%s'", fru->filename);
> >      }
> >
> >  out:
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM

