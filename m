Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B384C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 10:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8yy-0004Zd-8K; Fri, 28 Jun 2024 06:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sN8yw-0004XZ-KR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sN8yi-0003U4-Nm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719571035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6a7p2lMcpr5hgfMMs9jrdVHm4yfMOb4mDY+LbmbEIhc=;
 b=CVVkNk+//IMXtHEckyL/oT1aFMmsi0XgRSGiYj1DggWtCkZ8ZW4MC8UhQhPaXKmBWqjgIQ
 Skmg19bM5Ae5xAEsGL3g4oSf3Z6I4agIZ5aMism6DZGgiVhuEVq5qDOn4ZETi1jHIJGiYH
 FlbcXLhjzcujk9OR1UvxZ0U9Qf0roys=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pYn0zgsrPKWsXsnVJfs8Xg-1; Fri, 28 Jun 2024 06:37:12 -0400
X-MC-Unique: pYn0zgsrPKWsXsnVJfs8Xg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec584f36bfso4318901fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 03:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719571030; x=1720175830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6a7p2lMcpr5hgfMMs9jrdVHm4yfMOb4mDY+LbmbEIhc=;
 b=pIOGcn6FqA2JEi8W+Tk05krBZNRASJIPZJcxfVNl8JWD9Yg6r22jNBzjXFsLfsw/wU
 BMRjNcBK1OjoE8wU+xYv3UUTa+3dvA+mQHQhywNfHeUyvrhPvM7YwGVdxNYbV16BwSA1
 XMXEb/5SNf30ebGQa80Ej+Pe5JfloZuN3cNvRHmNQEPpZD5WJmXCauui4vgl0PTYzv+0
 qujeGJEm3yyUJ8EYlyBfCVnkUKxknxXwLkOM6+ZVLQPpRv49Kva73vJMFVj9vunJQl+R
 mC61PfAC2j/n+3NMAGDj9dxtO93xcd7i1hSB3M0u7JkAbwyUwTk39wZGmPUVr9aQzkYK
 fO3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULKNw6xMwd7bw6sPqcqpQlbgRX7qK6sxEToZ161SH2tDteAlWJpiWgG98z/yq3M6W7QUrcPulfHyK5574w0eziYgRQJTg=
X-Gm-Message-State: AOJu0YyRxzT1v0hd5rqbraj/vdyB37kuz8rqI9LkgseGAB1UiAIdKJh2
 0jEN3sTq8CS912InmBZWb9lqG2NvIk7ak7XZn0UN4ihhDpuHFdPHzkJAK5ebI1dSg5Had9dISPI
 vNF4ofzEu/z6SOHyM2Y9VQdUk0XuwszwynQGK69zzoyR5i3fXt3sM
X-Received: by 2002:a2e:320d:0:b0:2ee:4da7:3937 with SMTP id
 38308e7fff4ca-2ee4da73a9fmr21350731fa.29.1719571030662; 
 Fri, 28 Jun 2024 03:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC/l50KLTq/2He3iGs930z5rhNbl2YuJvq1QG6K5fnMuF7ysyk5GsgjqRdI3FPlY5/NYT9xA==
X-Received: by 2002:a2e:320d:0:b0:2ee:4da7:3937 with SMTP id
 38308e7fff4ca-2ee4da73a9fmr21350521fa.29.1719571030086; 
 Fri, 28 Jun 2024 03:37:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1ab2sm28029915e9.47.2024.06.28.03.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 03:37:09 -0700 (PDT)
Message-ID: <8ba04617-f18d-4c84-8bed-d3ddfa87d5b7@redhat.com>
Date: Fri, 28 Jun 2024 12:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
 <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
 <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
 <7b553db9-4d29-4cfe-8874-3c87ad862c74@linux.ibm.com>
 <449a8a0a-6149-45af-bfa0-bf7fb29e27c6@redhat.com>
 <65126343-344e-47a0-bf63-7df43b0051ca@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <65126343-344e-47a0-bf63-7df43b0051ca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

...

> Could you clarify which tree you are referring to ? I see his tree
> 
> https://github.com/awilliam/tests is bit old and updated recently, however
> 
> I have been using those tests for my unit testing.

Yes, this tree.

...

> This went through cycles of breakage and fixes. It worked on 5.18(not sure
> 
> about older ones before that), and broke afterwards. Recently fixed
> 
> and working from 6.4, broken on 6.7. Fixed and working in 6.8
> 
> onwards now.

Good. It should be fixed in the next debian.


> Yes, TCG too works, missed to mention.

and a TCG guest under an intel host ? This used to work.

Thanks,

C.


