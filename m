Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDEEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBbV-000669-7D; Thu, 22 Aug 2024 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shBbS-0005wi-S2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shBbR-00008f-7w
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724347681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKMsvQlb2sdoHjy+6BlTZuw/E0Mw5O2jZeY8zIrzATc=;
 b=FLIDfXQ/bWS8FCWIMvbvO7OIIkXND0h2JKgGckMhlmFAmqBRKnSATlHrQWn1yHT5mR0JfU
 PrkAbRTULSsr7+aRG1TgvSSSo35cLp4+eRxm3KijUcpmt184KMSFRXwHu4rTzRp8UhNqaZ
 IEBXMTXb7gUVJxws4ASG/jEzxPQA96M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-InJD1qt7OJOI7aSAJWn7pw-1; Thu, 22 Aug 2024 13:27:59 -0400
X-MC-Unique: InJD1qt7OJOI7aSAJWn7pw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a20ce27a6fso137635085a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 10:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724347679; x=1724952479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKMsvQlb2sdoHjy+6BlTZuw/E0Mw5O2jZeY8zIrzATc=;
 b=uNpt+29ZOK8EMWTUlzn/HrlaQMDkMdzcPcKTlk8c6+C1ss7rEwl9x86t9vU3fvFhnQ
 vylzDiBqYrnz16yYpHxnYH/UMxyW137eedyRiaHwLfRpzntXXiNB39O5R3kntykxgroO
 NNxXRt/7RXBiTd1ohEv58TXlkZlwU+AslYtnDkzNWANrxz8jJextl3DkUGS8hqBvtLea
 7eGDRA9GhHHugfNfM/FgfE35LOn16/p4QgIQMKdvF/JL9CwpRaY2QxkwkHRNdzlnJGBp
 PPlmcoiYbF8yRE2gT3wQbfN0AU6RH5IFEwpagG2UZal5lX5aa+mOymrfx/rVmkJQ+ED8
 RnOA==
X-Gm-Message-State: AOJu0YyBq9jhtN8O7lXQBO2IaWrJOxpuj0t7Far+p4NO+IcbcwkbDM2W
 s5w/TwROWYgp79lC6/tY7AEXbjjqi77OReQdLxTXR6FmhgNkUYfOFKhYe7bhWJzu6Foq3kjRXR9
 roJvlTfjgmCLChyEUYAkP4pf1vc0mXFuLhk02pvQ2bhrQ+nmCk9ZK
X-Received: by 2002:a05:620a:2943:b0:79e:f9aa:870d with SMTP id
 af79cd13be357-7a680b2e2b0mr286339085a.69.1724347679178; 
 Thu, 22 Aug 2024 10:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/pCdBkKIF4TG4Qx+NLAWh3VcWD1wnV7TwAXRgXonCFa5Bxp4HPPAzeWJva6k0Z1l9NEjSAw==
X-Received: by 2002:a05:620a:2943:b0:79e:f9aa:870d with SMTP id
 af79cd13be357-7a680b2e2b0mr286337485a.69.1724347678921; 
 Thu, 22 Aug 2024 10:27:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f31998asm91747785a.21.2024.08.22.10.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 10:27:58 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:27:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 14/14] migration/multifd: Move ram code into
 multifd-ram.c
Message-ID: <Zsd1HCqIDXZsNfR2@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-15-farosas@suse.de> <ZsdmddpcYuhyCO0I@x1n>
 <87o75kxylt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o75kxylt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 22, 2024 at 02:21:18PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 01, 2024 at 09:35:16AM -0300, Fabiano Rosas wrote:
> >> In preparation for adding new payload types to multifd, move most of
> >> the ram-related code into multifd-ram.c. Let's try to keep a semblance
> >> of layering by not mixing general multifd control flow with the
> >> details of transmitting pages of ram.
> >> 
> >> There are still some pieces leftover, namely the p->normal, p->zero,
> >> etc variables that we use for zero page tracking and the packet
> >> allocation which is heavily dependent on the ram code.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > The movement makes sense to me in general, but let's discuss whether nocomp
> > may need a better name.  It could mean that we may want two new files:
> > multifd-ram.c to keep generic RAM stuff (which apply to nocomp/zlib/...)
> > then multifd-plain.c which contains no-comp case, perhaps.
> 
> I think 2 files would be too much. We'd just be jumping from one to
> another while reading code. The nocomp code is intimately related to the
> multifd-ram code. Should we just put it in a multifd-nocomp.c and that's
> it?

Sure, as long as nocomp helpers have a proper prefix (like "plain") then it
would be good.

-- 
Peter Xu


