Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F31AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kGG-0006Lg-S8; Tue, 30 Apr 2024 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s1kGF-0006Kf-NY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s1kGC-0000RW-ME
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714471131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cBnzzzlDIOctZ9G2uIAPDYD23rGj/55LiEytbG1k+4=;
 b=Wy2FzFTWbeNmPN9aFRKzTKbyxQI0fZsPbYIZinj8Jsmu+Zdmzf08D899BcJzDUy/QbZZZc
 vPvc5c7zTm9bFXNI7pJRAu3q1SgSP21OJH2ZIUuGZZf5N4+cd1/eVnFXo/mqg4bHd9wJql
 MDiEU5VcUFCsNQnN0MQ6w3VmKLBsJzQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-25GZwaTfP42dDCWqY0Lvxg-1; Tue, 30 Apr 2024 05:58:49 -0400
X-MC-Unique: 25GZwaTfP42dDCWqY0Lvxg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57287ec26a8so760712a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714471127; x=1715075927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cBnzzzlDIOctZ9G2uIAPDYD23rGj/55LiEytbG1k+4=;
 b=Dy7jlwRBYKnQ7lYcIAFw7HHy5s/yo6cdDmMxMdc1n0HLG1auX7jqow0V7z8avD3lih
 hF/oj5256JjooPyVSC86jCnsWn3lrxxRJm1asaNOrnjugBeeAWesow8Pr/m8d4qmVQIO
 HeeVEw3JBa58ezYnHjP7FaVOdsG7tXHMdDJ0TKrIjD5979EGYoa325roohHrQtLvn3tj
 dI/1M+2KoIF5wdVYYN1gKGneMAvoVZ+6wjUvXSE+XiYSilmld6apVY1+69rSG/usszFu
 FoTG6vdeTiZaTEurMGxNXM7W6QPt2WDhp1+ggSLN6809Salbv6g6uPLe6oYTftWVVk7/
 +DEA==
X-Gm-Message-State: AOJu0YyR8ABn0liTHwABjfu6hFxbUg6yAz3afvOERTdgv9chacPjEI6m
 ASWnK6fj/t60PI9ylF2/0oJmHBxFJnhu5sgMdGEwne1V4X5N5LEvwaMbuFVsP2NkuM5s6koE2gk
 4Ur/bmnrXD44iw3o4ongAY6enbuwoRL34LEwDDk+6McROIaRqsZOt
X-Received: by 2002:a50:c314:0:b0:56e:232b:95cd with SMTP id
 a20-20020a50c314000000b0056e232b95cdmr7831944edb.41.1714471127659; 
 Tue, 30 Apr 2024 02:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6r8a/5Con6GDq/1aGvDG1YAqowO8Et0nZqKZakznCo9ggTvqzBrgWUsqmZ7mAkHxRtoHYRA==
X-Received: by 2002:a50:c314:0:b0:56e:232b:95cd with SMTP id
 a20-20020a50c314000000b0056e232b95cdmr7831927edb.41.1714471127361; 
 Tue, 30 Apr 2024 02:58:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i32-20020a0564020f2000b005723bcad44bsm6098909eda.41.2024.04.30.02.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:58:46 -0700 (PDT)
Message-ID: <53cf0994-4798-4b53-a706-77f47cb136bd@redhat.com>
Date: Tue, 30 Apr 2024 11:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240430064529.411699-1-thuth@redhat.com>
 <ZjC9w0A_VQlsY46p@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ZjC9w0A_VQlsY46p@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 4/30/24 11:45, Daniel P. Berrangé wrote:
> On Tue, Apr 30, 2024 at 08:45:29AM +0200, Thomas Huth wrote:
>> Old machine types often have bugs or work-arounds that affect our
>> possibilities to move forward with the QEMU code base (see for example
>> https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
>> cannot be fixed without breaking live migration with old machine types,
>> or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
>> commit ea985d235b86). So instead of going through the process of manually
>> deprecating old machine types again and again, let's rather add an entry
>> that can stay, which declares that machine types older than 6 years are
>> considered as deprecated automatically. Six years should be sufficient to
>> support the release cycles of most Linux distributions.
> 
> If anyone thinks 6 years is not very long, consider that this implies
> QEMU will be maintaining *18* versions for each versioned machine type.
> 
> So across aarch64 'virt', x86 'pc' & 'q35', ppc 'spapr', s390x 'ccw',
> and m68k 'virt', that's upto 108 machines we're keeping ABI preserved
> for in the worst case...

We will probably have RISC-V machines to support also. Anyhow, 6 years
looks good to me.

Thanks,

C.



