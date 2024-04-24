Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A05C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzggW-0005QK-4L; Wed, 24 Apr 2024 13:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzggN-0005Ib-Ak
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzggL-0005az-G6
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so167885b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713980720; x=1714585520; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UUisX1hzQQS8Kei+sBKavJsP0CqzohBLBY97e3PxcHo=;
 b=hh8Vvg4uZVyNHGmcAlxXAp7c+fvWyGWFmKdmmgHVUES4r0wHPXD1Zf8Tr/q5uvoZYY
 xa6fmuvtD2ELsULZusgmULZpj89cqmgl9LZyvRDPlmOZM287340aerdnsGH/FN7+1CzT
 tnT1o4i2wOLJDz6/7GRPhbcp1gN49RfhC66xhg5UvV1i8oBH+EZqY2qmttN4rz+PAvlg
 DTB423rTlrSCDAUXQxPDgZ9+SdWdJ0gos2JFkf2V2y8jUoVYVuVqTRceGNKzlZFa4sma
 IjKvMmnBeC3AXRtSPn68V/b5o+HHS2OG7xK0byzF4zyMR2UQoSE9qECCXCOmk/IWgCbs
 mgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980720; x=1714585520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUisX1hzQQS8Kei+sBKavJsP0CqzohBLBY97e3PxcHo=;
 b=OC/3cEpCca2mHvY5UARRAnYd6TptkPS7pUDULsPm1sKWvlUzjkW+Kam/lALQMrya8f
 F36r9panyYyafaBq/AWjCv3dVN0akCl3MKTklJZZ4kJmXwA6drTP6rBc/ZwrxQPVa5n5
 6wy8t+IamqkdehB0TAR03Hi8KWAqbSAjFDiUY4R+D/i3JxKUwAxC+rGEW5Y7a1gSgECx
 NsK6rjS/0+QqsjmeDJgv+yEv55v5Yf5mEZLYbouDPusuLhoSDlTpN4zixkvMFCMCVJqS
 0XR9yOcj8XjZqKZydUf69NUb/Uq//fUHsKwj0CuqHp3UFm2KjTTJW62jPMzjf/9f3HTS
 oEEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ8IcY7oDxOfmGkqL7OUB887831tafORioEtWrwZpfKw2jpeM5tos7bk8EdcbHYtwXz99fzatcB786TVQ8NfcJR4tUQlo=
X-Gm-Message-State: AOJu0YzhCqWOhRLkl850v+3ElIYslt/ehNn2jtxUfzH3BYihHJs1jSh7
 PgGLmVUYOvKuFzE3PDJlUBnb+oVtj8niGMDiCk8IlOKg0BJLMbXHifZoXQ==
X-Google-Smtp-Source: AGHT+IH08iEcxdee91ZKCmcfD34eF58jPYiw7s63UPDDko2fgLX4+RBXbx9vbYx5kantH6TLzY6kMA==
X-Received: by 2002:a05:6a00:218f:b0:6eb:3c2d:76e0 with SMTP id
 h15-20020a056a00218f00b006eb3c2d76e0mr4250172pfi.11.1713980719871; 
 Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a056a000b1a00b006ecda086db2sm11734654pfu.110.2024.04.24.10.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:44:54 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZilFFhySKFE6FmYC@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org> <Zik88BUMsMEFb0Nr@debian>
 <87pluebrk0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pluebrk0.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Apr 24, 2024 at 07:26:23PM +0200, Markus Armbruster wrote:
> fan <nifan.cxl@gmail.com> writes:
> 
> > On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
> >> nifan.cxl@gmail.com writes:
> >> 
> >> > From: Fan Ni <fan.ni@samsung.com>
> >> >
> >> > Since fabric manager emulation is not supported yet, the change implements
> >> > the functions to add/release dynamic capacity extents as QMP interfaces.
> >> 
> >> Will fabric manager emulation obsolete these commands?
> >> 
> >
> > Hi Markus,
> > Thanks for reviewing the patchset. This is v5 and we have sent out v7
> > recently, there are a lot of changes from v5 to v7.
> >
> > FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t
> 
> Missed it because you neglected to cc: me for qapi/cxl.json :)
> 
> Thanks!

Sorry for that. This is the first time I made changes to qapi/cxl.json so
missed that.  I will cc you when I sent out the next version.
Btw, thanks for the review. I have replied to your comments in another reply.

Fan
> 

