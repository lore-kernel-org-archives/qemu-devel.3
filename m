Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2G1z-00083h-Ir; Wed, 01 May 2024 15:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2G1x-000839-NH
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2G1w-00016x-1G
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714593255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FaG1VobsnJ0PExx+AGWD75eFP0zzXfuCzCbLaDls6Y=;
 b=HH3lojwpxXkDKoAHzZerQuOcDoajdfQxtP67WhqCo7EDRh74DicC0uKfe584igSgySUTY7
 5TsO/4bEI1q8mCf73W57Xmn86PvkOzwWNTphdslLkll98MBURQpZ0K/4RooTtBkZ1MMuEH
 JTXBWr4OqLg698aK4eUMwvNxRG8jzlI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Tj31TH8tPJGPo-_khvxbvA-1; Wed, 01 May 2024 15:54:13 -0400
X-MC-Unique: Tj31TH8tPJGPo-_khvxbvA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-437618fbdbeso6733761cf.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 12:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714593253; x=1715198053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FaG1VobsnJ0PExx+AGWD75eFP0zzXfuCzCbLaDls6Y=;
 b=Fs6e8B+iDyFVtH9KmYZFp6UVQcMiHdkXt5fBFP3W016XsBxG/qDk0zSLO/tBUmNTIg
 AyW5mS5vQON8QMnMFe1rLmPDkSM6qwsAZYGfJBQwZil+V1rNz6HuPpDB4pQR3tvqPqIA
 atDOK9AROiAerfJi/1i6Co3509x8N6XjMIs6BUkxXl7wmSzNnr9SI8v6s514g/mnYI1L
 G37WP31dWaw1YhfjI/DJKH8ankxHlAdWpj9i2BtzzUxAz7rCVyVr/d+z13a7B2iBB11V
 mIR0tgAAlRAz0cGpUdNtjElI6jFGRtGUbl8EQ/zOrMBS1AKMfCv0yikmCvfQ+vnw050t
 welQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHKkZcfzB4OXgU4WXGu4goN9LgqrYtPyYx/h0+7TJLwykucntiXWP7pW4X0Y3kIFltuvHp8lZlmnfJyL1Jv4erxhhIG3I=
X-Gm-Message-State: AOJu0YxnLX3vzMLwj8/zVXWXBnSdJ1essQv/M2Qyks4Trvqnjf0s3I0f
 PYwzIfFnMQ87Ixxm8aiENj4HjbXdbggbZWut5H5/LPBjpk4CJHAZBmq3P9YQj0WSZX/CO/+Mtcz
 Nhs0e1PKZGEQeNtpEeX4WKXQ4FdJHd0MPQRNdbi757/eUw3Zk9A4V
X-Received: by 2002:a05:622a:148c:b0:43a:6cf7:fad4 with SMTP id
 t12-20020a05622a148c00b0043a6cf7fad4mr3468499qtx.0.1714593252664; 
 Wed, 01 May 2024 12:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+dsvss5XJ7NZ3E0p0B3ybpIx1ifL3gponmThYigTcbvNQ7MOkYLS+VkmNQnctRJE45XpKuQ==
X-Received: by 2002:a05:622a:148c:b0:43a:6cf7:fad4 with SMTP id
 t12-20020a05622a148c00b0043a6cf7fad4mr3468476qtx.0.1714593252084; 
 Wed, 01 May 2024 12:54:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ki16-20020a05622a771000b00439c3072d24sm8878599qtb.15.2024.05.01.12.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 12:54:11 -0700 (PDT)
Date: Wed, 1 May 2024 15:54:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, farosas@suse.de, armbru@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/14] Use Intel DSA accelerator to offload zero page
 checking in multifd live migration.
Message-ID: <ZjKd4EgmvTDYVMxP@x1n>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 25, 2024 at 02:21:03AM +0000, Hao Xiang wrote:
> 7. Added a new migration option multifd-normal-page-ratio to make
> multifd live migration easier to test. Setting a normal page ratio will
> make live migration recognize a zero page as a normal page and send
> the entire payload over the network. If we want to send a large network
> payload and analyze throughput, this option is useful.

I didn't see this when quickly going through the series.  It's even
mentioned in test results later.  Is it removed?

Thanks,

-- 
Peter Xu


