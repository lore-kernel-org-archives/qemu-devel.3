Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3288ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwmy-0001ZW-3U; Tue, 10 Sep 2024 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1snwmw-0001Yt-Cr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1snwmu-0003Zo-Cl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725959030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiXxv2WArJH4NiYTyPIMZuEZQwvmjobT9GJP/y5Wkck=;
 b=Jk4NhwKFcPgwgmlvXAcjV/0tVWggt4gyOUhb1tdkJK9L4m4YoiSVt5CMBFt/H/RR+Q1jlJ
 fxb+TtW7aSuQU1CHJ/H8YqBKVUzwW+d60eVoXrq9ny6NJo7dOpzLWFYFNLi6dqwpdGF9GZ
 gqxT9kKi/yLoqpxWWEu+1qbarAyXM6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-kQOiWNgrOIKPEvPkCOPUaw-1; Tue, 10 Sep 2024 05:03:48 -0400
X-MC-Unique: kQOiWNgrOIKPEvPkCOPUaw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb080ab53so19222645e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725959027; x=1726563827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiXxv2WArJH4NiYTyPIMZuEZQwvmjobT9GJP/y5Wkck=;
 b=P6RSZenVJ8mANnP00JkKvN/zCtor0YUIBUfrBUDnTfSBU8z+NeqYOnVPswvvVWunKu
 gVlXzCw4uFMb3v6JpQqWskqfxzwSqlCzr94Pqu6GyUPH2Bw0H2Zoy3YyEpUqiPE8o24S
 5V/HdKsEf3tYR4XMBQAa2flUUUgx4CX5JFOF4J4VY5r++SmeHUMARjmCGDgsgWTEnQKd
 NVLJ6L/Z+CgTDdihJ2B3Sv2AkH8Cs01nktbnuOAEJsQSAqkwCVvmuAjmpJQZPR6Dc0rV
 ZRWf2TuEiaUXtlarzUPeV/2ZvVpSYEe21m1MEaY6ljACyxeR256xTdllywrx79bO81gF
 6jYQ==
X-Gm-Message-State: AOJu0YwlFeTY+s0SIQ9Tz39JAjwhng44xyZAL17Db3dANA5f9Nf7jDtg
 SsjTTX7TD7xDrifcVFnkU18ndt5EXsKjYRtdJ68GVRwajFG3mSl+A8da0ME+fIc7y4oKjoIDySl
 YY+9JPS2rhpCpQXFH+e0/IJ/eO0aeCnMmI8fjlse1EjQaWA0l1/MH
X-Received: by 2002:a05:600c:b59:b0:42c:a574:636b with SMTP id
 5b1f17b1804b1-42ca57465b7mr76918135e9.35.1725959027403; 
 Tue, 10 Sep 2024 02:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNmg3Yr8lPVSUn+7tuH/2x1DtjFmEu8FuyfFD5CfVkler8fUEbK1cYqbfZJTZ8yjGzsMr9+Q==
X-Received: by 2002:a05:600c:b59:b0:42c:a574:636b with SMTP id
 5b1f17b1804b1-42ca57465b7mr76917685e9.35.1725959026231; 
 Tue, 10 Sep 2024 02:03:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeaba04csm104275405e9.0.2024.09.10.02.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:03:45 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:03:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
Message-ID: <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240819144303.37852-1-peter.maydell@linaro.org>
References: <20240819144303.37852-1-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 19 Aug 2024 15:43:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> At some point the way we allocate socket-id and core-id to CPUs
> by default changed; update the example of how to do CPU hotplug
> and unplug so the example commands work again. The differences
> in the sample input and output are:
>  * the second CPU is now socket-id=0 core-id=1,
>    not socket-id=1 core-id=0
>  * the order of fields from the qmp_shell is different (it seems
>    to now always be in alphabetical order)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I noticed this while I was playing around with vcpu hotplug trying to
> demonstrate a memory leak I want to fix...
> 
>  docs/system/cpu-hotplug.rst | 54 ++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
> index 015ce2b6ec3..443ff226b90 100644
> --- a/docs/system/cpu-hotplug.rst
> +++ b/docs/system/cpu-hotplug.rst
> @@ -33,23 +33,23 @@ vCPU hotplug
>        {
>            "return": [
>                {
> -                  "type": "IvyBridge-IBRS-x86_64-cpu",
> -                  "vcpus-count": 1,
>                    "props": {
> -                      "socket-id": 1,
> -                      "core-id": 0,
> +                      "core-id": 1,
> +                      "socket-id": 0,
>                        "thread-id": 0
> -                  }
> +                  },
> +                  "type": "IvyBridge-IBRS-x86_64-cpu",
> +                  "vcpus-count": 1
>                },
>                {
> +                  "props": {
> +                      "core-id": 0,
> +                      "socket-id": 0,
> +                      "thread-id": 0
> +                  },
>                    "qom-path": "/machine/unattached/device[0]",
>                    "type": "IvyBridge-IBRS-x86_64-cpu",
> -                  "vcpus-count": 1,
> -                  "props": {
> -                      "socket-id": 0,
> -                      "core-id": 0,
> -                      "thread-id": 0
> -                  }
> +                  "vcpus-count": 1
>                }
>            ]
>        }
> @@ -58,18 +58,18 @@ vCPU hotplug
>  (4) The ``query-hotpluggable-cpus`` command returns an object for CPUs
>      that are present (containing a "qom-path" member) or which may be
>      hot-plugged (no "qom-path" member).  From its output in step (3), we
> -    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
> -    while hot-plugging a CPU into socket 1 requires passing the listed
> +    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0 core 0,
> +    while hot-plugging a CPU into socket 0 core 1 requires passing the listed
>      properties to QMP ``device_add``::
>  

>        (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0

>        {
>            "execute": "device_add",
>            "arguments": {
> -              "socket-id": 1,
> +              "core-id": 1,
>                "driver": "IvyBridge-IBRS-x86_64-cpu",
>                "id": "cpu-2",
> -              "core-id": 0,
> +              "socket-id": 0,
>                "thread-id": 0

after above changes device_add doesn't match comment nor 'execute' output

>            }
>        }
> @@ -83,34 +83,32 @@ vCPU hotplug
>  
>        (QEMU) query-cpus-fast
>        {
> -          "execute": "query-cpus-fast",
>            "arguments": {}
> +          "execute": "query-cpus-fast",
>        }
>        {
>            "return": [
>                {
> -                  "qom-path": "/machine/unattached/device[0]",
> -                  "target": "x86_64",
> -                  "thread-id": 11534,
>                    "cpu-index": 0,
>                    "props": {
> -                      "socket-id": 0,
>                        "core-id": 0,
> +                      "socket-id": 0,
>                        "thread-id": 0
>                    },
> -                  "arch": "x86"
> +                  "qom-path": "/machine/unattached/device[0]",
> +                  "target": "x86_64",
> +                  "thread-id": 28957
>                },
>                {
> -                  "qom-path": "/machine/peripheral/cpu-2",
> -                  "target": "x86_64",
> -                  "thread-id": 12106,
>                    "cpu-index": 1,
>                    "props": {
> -                      "socket-id": 1,
> -                      "core-id": 0,
> +                      "core-id": 1,
> +                      "socket-id": 0,
>                        "thread-id": 0
>                    },
> -                  "arch": "x86"
> +                  "qom-path": "/machine/peripheral/cpu-2",
> +                  "target": "x86_64",
> +                  "thread-id": 29095
>                }

beside reordering, which seems fine, this hunk also introduces target change
perhaps a separate patch for that?

>            ]
>        }
> @@ -123,10 +121,10 @@ From the 'qmp-shell', invoke the QMP ``device_del`` command::
>  
>        (QEMU) device_del id=cpu-2
>        {
> -          "execute": "device_del",
>            "arguments": {
>                "id": "cpu-2"
>            }
> +          "execute": "device_del",
>        }
>        {
>            "return": {}


