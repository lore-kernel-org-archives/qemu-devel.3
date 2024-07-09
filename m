Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA261C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5BG-0004Cy-BU; Tue, 09 Jul 2024 03:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR5B4-0003aZ-FL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:22:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR5B1-0002b7-Js
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:22:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42666b89057so56195e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509734; x=1721114534; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HiOIKrydel/3/HIIHK7QbyCDjwoGhDbVXvljvVWuRkA=;
 b=e7dcDK8k1HDXUa3Mll4gttS3hegjXzGpK52SbHSgJYKOzfuUbEsIb0PowUWOCaUZUs
 Sz+462FxO3Wg7mHN4axFPFHwX+qy6syPbWtiaOmkJ49cvhNzyOxx+l8vMWFggFjUSsRA
 WzRFEkrgQlxmSTeV/au3wgQT1o0gcojfFuE0Tluu+JGdeKcR49vgqogntXX+yDb7jecQ
 iZavAKi4lzI4O4VbBRpSlBfZkis1VrwSWaDoedGtzGfXZYixA1iUy9IyLTSzSWZVZ7dw
 yT7cRfDn7SXkIXc8OdZqlIKVKRA+TAZcJ+64n8wrGXRe2EQY+uze7kCaMcDdJkkcET2+
 lzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509734; x=1721114534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiOIKrydel/3/HIIHK7QbyCDjwoGhDbVXvljvVWuRkA=;
 b=S/N7r6R5rpRg0yfbf3MYCejIWubFWkcPZpUShkOFvlEcu5p+I/CuxxioH+DAWwmHRn
 NiiDZaUYi4Xu/u8pdTEDYcJBiCZLST5syuF6t8IvBVYRw9HWX1aFZ13holxHnrQ3Er3O
 DU0HqsFnhIUiffMPELmIIyF3qn0cMZ0veKBzkkJPP+RAp9vmmItsehAhk6u7C/wuQHU5
 d5lN/dno5T3zCTbKZkZ/v/DeXTj/AkC0hEve/viBDgNh3RBQeKQ9B/os0tNpWIe0sWFs
 1Zb4xa7jNsvS9CU/B0V5/i78aPFB96GP3gaB6sm1pTPpYt1x0t8171gUAbEYHiAtDC3H
 gSzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2/yDca/9cV0inCecqZjz4Lf9tFIpiR1o4NjpBkQlkM1x5MaBt2jAPLrlf0mor2/3f2+a3zAHITW44e7C3QbyBq52u1vs=
X-Gm-Message-State: AOJu0YyBJAddBrzPMr2m0g0n72NGGUAnyboiZEXUJIO0C5U+HRoxvtf6
 bhbQ13oHa2UN/f3QyZzyRKdpaWVlWujoVIu5YA1/zXRdvKgxcbTPWFJwJDj+Rsmgdva/spxjKMZ
 RjQ==
X-Google-Smtp-Source: AGHT+IFigFM4qLBDIL/jnti/JdOMcdBFg7vSicH1cKrWsJTkP2El7x4n7FDpiyQDqhBlW6r3Ey/Ibg==
X-Received: by 2002:a05:600c:1d1f:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-42671c0a692mr1305655e9.4.1720509733760; 
 Tue, 09 Jul 2024 00:22:13 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde891d9sm1688249f8f.65.2024.07.09.00.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:22:13 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:22:09 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com,
 julien@xen.org, richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 18/19] hw/arm/smmuv3: Advertise S2FWB
Message-ID: <ZozlISfFI48-rrYY@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-19-smostafa@google.com>
 <20240704183658.GO1693268@myrica>
 <f2a17216-1a03-4c84-85af-8c3145f305ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a17216-1a03-4c84-85af-8c3145f305ae@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On Mon, Jul 08, 2024 at 07:09:02PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 7/4/24 20:36, Jean-Philippe Brucker wrote:
> > On Mon, Jul 01, 2024 at 11:02:40AM +0000, Mostafa Saleh wrote:
> >> QEMU doesn's support memory attributes, so FWB is NOP, this
> >> might change in the future if memory attributre would be supported.
> attributes here and below as reported along with v3
> >>
> >> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> >> ---
> >>  hw/arm/smmuv3.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> >> index 807f26f2da..88378e83dd 100644
> >> --- a/hw/arm/smmuv3.c
> >> +++ b/hw/arm/smmuv3.c
> >> @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >>      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
> >>          /* XNX is a stage-2-specific feature */
> >>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> >> +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
> > Why is this check needed?
> >
> >> +            /*
> >> +             * QEMU doesn's support memory attributes, so FWB is NOP, this
> > doesn't
> I have just seen your reply on my v3 comments. I still do not understand
> why we expose this bit at this stage.

As I replied to Jean, I will drop this patch for now, we can always add it later,
as it doens't add much value.

Thanks,
Mostafa

> 
> Thanks
> 
> Eric
> >
> > Thanks,
> > Jean
> >
> >> +             * might change in the future if memory attributre would be
> >> +             * supported.
> >> +             */
> >> +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
> >> +        }
> >>      }
> >>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> >>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
> >> -- 
> >> 2.45.2.803.g4e1b14247a-goog
> >>
> 

