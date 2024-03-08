Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D26CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUS1-0002xG-1q; Fri, 08 Mar 2024 02:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riURW-0002j1-Bj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riURT-0001kB-U9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709882094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEhIhK8v6UOuk51GgOpXl6SdXP6eRCzkhd3JGJUbsjQ=;
 b=IcT7JjONPkSi8n/w4vPPFo5YfjZDlqxp7iOjJG47MjdnAQ57M5of7w4/C1vd+PtIrxLCCB
 zXjiwRiEhps15jr3/mcanHAeA/ZVMB6PgD2UBhyVihzHJNzNpZSdYeZbY8MUoWUdK6UKEk
 f6h2yBNMrHTTVogtV2pUas1aah7JR2M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-oCGnXZrDOTmmDWlY1Q-sog-1; Fri, 08 Mar 2024 02:14:53 -0500
X-MC-Unique: oCGnXZrDOTmmDWlY1Q-sog-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a9eccec96so469186a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709882092; x=1710486892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEhIhK8v6UOuk51GgOpXl6SdXP6eRCzkhd3JGJUbsjQ=;
 b=Y2BYfm19mhuXtKmcVP42oe+AGdjxm+3bNv5/5WQb5e4DrBKX9G3pvq6ctR30YmeSC+
 P2bbRUH9T3yCDFpNR8ATwsd+HRejzTTLjea2WOoP+5Ls3+lxcuEYu3Xr6a9ioxSelYA8
 gndo2R1BAEiIIDNfqdbpIRv0Nf4DSDztkA+rHeMp7SsAOXJPRe/0eNf9hF2KTSYSQMqJ
 n2UKmmixBkmUb0f1xbolgVnR9pBKtTPrptEUeBgEmvU5zAXgEgo/LGrOjKmFGxlTKBg/
 cdJKXx98zGucHw0zZUbKRbe6FM7R2U/8HV9i2GPQlEfOyLLH3jyEhbMYdLEuReir7u9h
 PrLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGfbCVgC1MK30wt2e2vkp8vsMrV5J+VduwNsJ3ExdbqGwYmIb/0o5igJYdgeiGJ8W6KRJPcVL9T2VDLaGVVD+WE3BPnGs=
X-Gm-Message-State: AOJu0YwFdFmPs1qv0VewTSKuyCIV1ZwZ3/7LBQdGkF5pYCV6SZpp8B0E
 nTtMGe4r0mhVFlP+nmevTtTOI7qRrp7aqscHItz0eOCvUH6WD/g0xNccjMEO774jwzRQU2LzJ4B
 ggPf2z91RIcjFeJQJqJjm/mOxXanxNsQb45jqn5QSG3K5YffFv4Dm
X-Received: by 2002:a17:90b:918:b0:29b:a509:30b6 with SMTP id
 bo24-20020a17090b091800b0029ba50930b6mr1090193pjb.4.1709882092217; 
 Thu, 07 Mar 2024 23:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvXiRSd27WCx4YJUTuNa+EGBl0x6LVKwHeeIdW1XPRl4UToHfolq9WC1LURndNEOxYticc7g==
X-Received: by 2002:a17:90b:918:b0:29b:a509:30b6 with SMTP id
 bo24-20020a17090b091800b0029ba50930b6mr1090183pjb.4.1709882091920; 
 Thu, 07 Mar 2024 23:14:51 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fa13-20020a17090af0cd00b00298ca3a93f1sm2608045pjb.4.2024.03.07.23.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 23:14:51 -0800 (PST)
Date: Fri, 8 Mar 2024 15:14:43 +0800
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Het Gala <het.gala@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Message-ID: <Zeq648RJVhgoTCag@x1n>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <Zeq2WqDuBbKKNWPN@x1n>
 <d03200fc-3ad5-4872-be04-372e74da1134@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03200fc-3ad5-4872-be04-372e74da1134@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 08, 2024 at 07:03:56AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 08/03/2024 14:55, Peter Xu wrote:
> > On Fri, Mar 08, 2024 at 07:27:59AM +0100, Yu Zhang wrote:
> >> Hello Zhijian and Peter,
> >>
> >> Thank you so much for testing and confirming it.
> >> I created a patch in the email format, unfortunately got an issue for
> >> setting up the
> >> "Application-specific Password" in Gmail. It seems that in my gmail
> >> account there
> >> is no option at all for selecting "mail" before creating the
> >> application password.
> >>
> >> As it's tiny, I attached it in this email at this time (not elegant.),
> > 
> > I ququed it, thanks!
> > 
> 
> > -    isock->host = rdma->host;
> > +    isock->host = g_strdup_printf("%s", rdma->host);
> 
> 
> Peter,
> 
> g_strdup(rdma->host) is enough i guess.

Thanks Zhijian, I'll touch it up.

-- 
Peter Xu


