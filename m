Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49053CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umDsg-00086R-DH; Wed, 13 Aug 2025 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1umDse-000855-4E
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 11:59:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1umDsU-0001NQ-LA
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 11:59:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so5158962f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755100733; x=1755705533; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
 b=HWiRPA1+3NF5zE51+U9ZIBHoOHIJSBS703O6TBdZlrS4gg+l2i/eGCRm7hmm0U9g8+
 vqw+arHy/mA64RVFeKYIeJzt94cboWYnb/2dCcjzEGhtp8BkPyTQ7/qwUk47rltECqol
 S4N5zzeWq39W6j3CRA6azDFBHyMsPjabMba/T9Ed40vZyEo/M2j3dSerXlhr5z2ps9tf
 IQ6NgXTp3vVQ6WIUaQO1gqYYkrLeWMSEd+fJCLgnBtU7wfRKSlSrBnzhFy+C7RySyooz
 wOmdcxhUjbrZts8fCX2PwTVJb478CA1pOc0Wus9T/ceoJtAa9W3Pt25ftOXDtm9TSyWr
 yIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755100733; x=1755705533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
 b=TyzudYseQSvp8tyZEnB7E0Zok2G/ei6MCETQHUnhZ04k2YlG6Gxhtzu0S5rnuRPfmg
 H7xWE4oZ7TkbwXJEMnoh2L0AfZ2u41rUrwv8bCI+Z/YakLyF3kENxKlM9/NkMRBqGdxg
 Oo5XNEHbKxZ72p1dyQKLGBCaBHdMFpRGzBYj74pEueNzdACliu4jsd8Q0siwhb3WZrqd
 FN3wuetCYSG4hqw14/29ew93WOI3Lpo5hU7+P/POe8f6Z1w8L2AuVh86zR6Xd02YvZZd
 dTD6E5PxF9GePswKgjCMaDkux8cizpl0amw0gWKoe+tj+DzPEXDio7iUyHxscEL/JBpX
 pY7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTRe5YrQ21aKiZ2IKPwyzveqgxOi5hNx/VQTQ5gOA9Dqt9G+cUvKR/1iMLyHtZgFmEqm8EA/O6LQcN@nongnu.org
X-Gm-Message-State: AOJu0YwG0bpb6KjWK+rEZge/mPaqJ4SL47BCjvYX+dB+OQHUZHvC+dcK
 3Z1pyVaGckAtPgtdLXVjp7/RwMAVdsAWBVTNb61og7WitkSbk7vv7/n7llHc87mLyEE=
X-Gm-Gg: ASbGnctRQ4Gf8Kixv8i38wP7BN4I9X9d/VnsXTApCIiPhvwKi+0RhSwPGJXLwX307z2
 NZJy4DNopvI+unNXXV4Bk/TJyofSdwdjFG4iqTO5lUy5HeNsQgDzslLO5a3rQc1c2yePO2LxbNL
 jn7IPmXLjwoz0zWIUhkfgQu+oHxiyiEBquLSmTDS6AmU6t4in0pkxQ2mhM4F8ulLxt2EQ0GRjoa
 mAwR7EtyzLgqf76jDHdUZBmdHLvciUoC0TdVLyr8q9EDDF+obhySFjwovWziWPBSjoNBrWxG5Ht
 mJ7/opX2X2aopOIqznfqA69YOgrprq92vyCpf1jjX/HaEcVWS+lvvWAm7x1EM31QDoln5M8rzRA
 jPw/kH0Z947DqxOjNoi9ZA31FirICTNcUt6FHmz+zkrI=
X-Google-Smtp-Source: AGHT+IFmDnHCSl5CKkyh/D1IvMDkhgbQzh6CQ86Hu6D5gyD/dtG5m2liXMYcw3pmw6tZ+PFrvCebxA==
X-Received: by 2002:a5d:5f95:0:b0:3b7:8dd7:55ad with SMTP id
 ffacd0b85a97d-3b917f14804mr2882432f8f.39.1755100733462; 
 Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3b91b05b28fsm1789186f8f.21.2025.08.13.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
 Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJy2OVhg4RUYbHHR@stanley.mountain>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=dan.carpenter@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 13, 2025 at 04:53:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> > Hi Greg,
> > 
> > > > 2)
> > > >
> > > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > > >
> > > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > > to disk space handling in the 64K page configuration on qemu-arm64.
> > > >
> > > > The issue is reproducible on multiple runs.
> > > >
> > > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > > >
> > > >   - fallocate04
> > > >   - fallocate05
> > > >   - fdatasync03
> > > >   - fsync01
> > > >   - fsync04
> > > >   - ioctl_fiemap01
> > > >   - swapoff01
> > > >   - swapoff02
> > > >   - swapon01
> > > >   - swapon02
> > > >   - swapon03
> > > >   - sync01
> > > >   - sync_file_range02
> > > >   - syncfs01
> > > >
> > > > Reproducibility:
> > > >  - 64K config above listed test fails
> > > >  - 4K config above listed test pass.
> > > >
> > > > Regression Analysis:
> > > > - New regression? yes
> > >
> > > Regression from 6.16?  Or just from 6.15.y?
> > 
> > Based on available data, the issue is not present in v6.16 or v6.15.
> > 
> > Anders, bisected this regression and found,
> > 
> >   ext4: correct the reserved credits for extent conversion
> >     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> > 
> > Report lore link,
> > 
> > https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)

Lol.

regards,
dan carpenter


