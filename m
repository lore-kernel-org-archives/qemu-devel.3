Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C47C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxPS-0002Uf-PD; Tue, 13 Feb 2024 13:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rZxPP-0002UQ-Le
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:21:31 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rZxPG-0000Tu-1V
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:21:31 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so3370908a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707848480; x=1708453280; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iID+5qHzUzwG5TgDFukz1qiwGtm2X/wRZ/SBXmMx4Kc=;
 b=Dn9/fJIRNiW/8661KECXdprPLHfqT7pKDGY9Sx794vxFR1KaqP37ccE8m87ZiD1Bn+
 rrXmvcL8PA4NFFxencRwbwfIlK1TPQgNegoyzsiQGgYtWo+D6FbgmjsbzZd0Yv7K60oz
 uC60na3JRJh2c91+g/4vsTw9g2uirQqGa8M5VGCzZmuWeciyLrF5r/3z26C1ghkWIcoh
 jV4E0NRbbwyZn+pT1WTDugfA5RGeZqUdKSgXApQS/EJAXP4NLs7OEvXSy/KEiR3NJj4R
 mF3HiWyMvu7EbJiWwlq4JnC6vxJG5TPs9p00KgPPeguMXwSs9cP+epywikeim42blw+C
 eKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707848480; x=1708453280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iID+5qHzUzwG5TgDFukz1qiwGtm2X/wRZ/SBXmMx4Kc=;
 b=ksejNzF88xhxuK4wM5uGjnWEPTFVKQEhM/wNbpUVvwHjsZVgS817bkFs1WVno0LDP/
 nE6G/Qv4tCE8xrzWImmHLxL2KouYcZmd/mB6NpptQhWVKz5iWHXpb/mrpMwM3TDLIiRK
 Atu8/uJPHVK3KJ4bKOOSI5+Uodh3JFtOqmEGjJiFfhGNzh7P0z37Ose+AkpGQbEbrgyi
 fzutBytfYkXhAgUqvRoYed+YzlgAAagA7tE4vwoGlYYQpkYom2xQLXcBDH3RATQBpH+j
 R8ibdcpfGZ5dNxw4C7aEuinT7iznam6/4bvAiqr/Q964vG1YYQnonxnjXOkKqom4MWXT
 SgSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNgAmmGhQZSi3EXaPDwiz/lwDl31KO8iYk695UjGuS3HT8Q9o462RT9z67LtGSIGElhpjJp9lZVXAO7cYCcB2Fv94Gdg=
X-Gm-Message-State: AOJu0YxwSKmj3PwhdQ88//Ae+U6dYg0HbymP+6gCBo8EGu9VZ0kbbnpI
 cUAlRjyi3MM2V922ZL3rzc6mLuiC2L89wZE2O423CtlNKavbMp7R
X-Google-Smtp-Source: AGHT+IFnj7pmp12EWMqSCszNnAa0wxQFW3r2mdwohHjz5I8hZ5mc/pN3FOgQz2lGSAxZBFpr9cbKfQ==
X-Received: by 2002:a17:90a:ce16:b0:297:154e:521d with SMTP id
 f22-20020a17090ace1600b00297154e521dmr268081pju.42.1707848480317; 
 Tue, 13 Feb 2024 10:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUiVawyW5hBG0m32tHzMP7NoNuMmGVlNoeP68+0f1Wti1lS9Wpq1zchR1HfneQ3r6YkAIy7yrq+q/ppKWT/6EJshysN4OetXYgQxzli8hals9C03FQzjAS1ziaJFr3aq+4UmwBO1xkxKSr1Vxs91OuAXNHE8FuuDq/1SjRAY9bpaBZZx5owdL0lgkIFwsu5xNgrqCIGac5Myl3LL5rYpqq466JR5UzpEWCMWl+XejZC94qGwmpbQJF2rzytFahax46lyLFFy5wYXEy2ADqPSwouT+BRUC0Et7hmHuIOCU8zNK/q7TwZx3xGrtFOd+8dbKFDnPvVViXsPZexvlxBh4F0x1OtHA1mf8Z+r/8h5Ca5Z5cCTKFl+g==
Received: from debian ([2601:641:300:14de:a8fd:e6e0:547f:c54a])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090ae38800b00298b4e896a5sm1563590pjz.46.2024.02.13.10.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 10:21:20 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 13 Feb 2024 10:21:17 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <ZcuzHcqn4VeZdSam@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-9-nifan.cxl@gmail.com>
 <20240213174405.00002568@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213174405.00002568@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Feb 13, 2024 at 05:44:05PM +0000, Jonathan Cameron wrote:
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..6b631f64f1 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -25,7 +25,8 @@
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> >   }
> Needs a docs update.
> 
> Upstream QEMU seems to have gained some stricter checks
> so this just broke my build after a rebase.
> 
> Jonathan

Thanks. Updated.

FYI. The new version is completed.
https://lore.kernel.org/linux-cxl/ZcuyZ0Nwq31z8YIr@debian/T/#m07b4b4586e2f421a617f08a002b196d932a88966

Thanks,
Fan

