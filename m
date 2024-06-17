Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97561C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDun-0008U2-CO; Mon, 17 Jun 2024 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDum-0008Td-CG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:05:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDuk-0002th-RT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:05:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-422f7c7af49so114815e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636696; x=1719241496; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JEb/dM6YDzVA2Zymea3s7EQXxCPBswSiGHuTJJHFw+o=;
 b=Wb1VgVSPvq6cmulkCQzb3EMwqabx4V2cHngMnc0cxocjE2RGQkduK/5zb2cAC52n33
 pavkLZ9dOA+6urht3eKVyc+P3eHEFtNO8DvKC+/CDL2sjIOzFokKk+zk4madmlO1QmuB
 gnE0LuApZMfuV/P3S+GUndq4P9R/SqTKzaSTiVZsGiTakwJba3ttIdVsNa39PtpajsD8
 IYqwPE26gm3A/AKMhun0M+/4I0YRCpaxdhHu4TysVNArIf7GZsLf8uLgoZLQ2ELkoZM0
 lDSj2djrS07FR6ovULiVV8cygfUHwoSnjxFRLZAHaUGcUS/8AQAccOfug5andxvHT8Tf
 4cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636696; x=1719241496;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEb/dM6YDzVA2Zymea3s7EQXxCPBswSiGHuTJJHFw+o=;
 b=lPNOUY/OS8IxmlSIEBUVVXUYvJK5iPFKhhO50K2Nkxy7E8dpQjj/ppzvWxfJnwgViw
 zUBQz+iBff3jbfqhv6Wzu5QIvf5yr9mRlfE8lMQNvRElacHPEvi4rCcw+Qiol8MHodxd
 laibNfDb7flSQXfTIE8/Agj8JnD8F74KGuf1Gyp3dGF+ITW/NAeuMlt/d83+N5XEN9cX
 lDjOzBSOJd2Jk/LRtipP49msEeFqjOQfmZWhFmx6dXVkyLAdI/1pw29mn416FAu9eD05
 Py+Mz2jYoX8MO4FHMtwvCYw4IQ49q+gyw4EYHutScBmpTBievHh+0GEjanneudrkpwtn
 Zr0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoVpYavG3N2n4WtXtstgYdbpvkcwpXjaQ+XkWGOq4ipLfgIDwoL1azgTZ5KG1gVeSrHJyBSN33swFDBsCsUv2fdzVcCZs=
X-Gm-Message-State: AOJu0Yx97aCUWJdDAcESUHNB9O+xuCTW8ANtDhKQ3CcylkhTx1l542gX
 IXSzYS/gtczWhMLYg4+G+iklIsD7TVjjM3QeuAzunQe9VRfQaiaIC9emet95GQ==
X-Google-Smtp-Source: AGHT+IFcc8pAhmQFYM30VxZjzSVn4m/uUOG+18wjf7NT0dAe5wX6WXwuJeWRAA9xsUXbAMzQ7oJS7A==
X-Received: by 2002:a05:600c:1d97:b0:421:8486:7d2d with SMTP id
 5b1f17b1804b1-423b6687d82mr3468175e9.1.1718636695784; 
 Mon, 17 Jun 2024 08:04:55 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a5b4sm161197725e9.41.2024.06.17.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:04:55 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:04:51 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 15/18] hw/arm/smmuv3: Advertise S2FWB
Message-ID: <ZnBQkyn60KO8Zyt-@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-16-smostafa@google.com>
 <b3488980-2136-4620-b875-a11f75373462@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3488980-2136-4620-b875-a11f75373462@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, May 20, 2024 at 03:30:58PM +0200, Eric Auger wrote:
> 
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > QEMU doesn's support memory attributes, so FWB is NOP, this
> > might change in the future if memory attributre would be supported.
> if mem attributes get supported
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 88f6473d33..8a11e41144 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
> >          /* XNX is a stage-2-specific feature */
> >          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> > +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
> > +            /*
> > +             * QEMU doesn's support memory attributes, so FWB is NOP, this
> > +             * might change in the future if memory attributre would be
> if mem attributes get supported
> > +             * supported.
> > +             */
> > +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
> spec says:
> 0b0    Stage 2 control of memory types and attributes is
> not supported and the STE.S2FWB bit is RES 0.

My understanding it is still OK for the SMMU to advertise that although as
patch description indicates it is useless, but I thought it is similar to
XNX recently added, but I can drop it if it is not useful.

Thanks,
Mostafa
> 
> 
> Thanks
> 
> Eric
> > +        }
> >      }
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
> 

