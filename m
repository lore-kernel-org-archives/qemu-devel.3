Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC1C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWc3b-0002mL-3s; Tue, 01 Jul 2025 10:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWc3N-0002lo-Kt
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWc3L-00062F-8Z
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751380418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhO1MBXAhr44o4W/MMlh5q0toNCSesUpJTsA//9Fcis=;
 b=Z0/PV0dyoGoaLHO4hohmV3yDFmhnw7/lFLY/TkLS9p3UPDQTRw5UUPa7iF467U19Ea0/Q0
 iZRtjJjVKprZ3Q1yb4rmJwLB+TH+0WvaTuImxD58bCnHwOGT++U07xm4L2DKx/j1Cn1cU9
 /SE/5y3uGSAV2emVMPkCxFXGU+uq+u4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-V-hqMxYrPxm2VF9W1qyakw-1; Tue, 01 Jul 2025 10:33:37 -0400
X-MC-Unique: V-hqMxYrPxm2VF9W1qyakw-1
X-Mimecast-MFC-AGG-ID: V-hqMxYrPxm2VF9W1qyakw_1751380416
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so31282905e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380416; x=1751985216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhO1MBXAhr44o4W/MMlh5q0toNCSesUpJTsA//9Fcis=;
 b=U3uVgrEPknuhLhNv7Pzy5oFPd6dngLLix7GTravOePRwoPra55FfTA+kzoLjxYPLEd
 UjmY8xDLvbXlq/X/XnuN2bl0wtSGX5QOdkHsGlEvfv0Q3lzT0T4+CQSRh9VpUevNLH4C
 fxxeXIZsdhEYPa3CqWJ7chkfPGM95Tj0ac5vk3k6O2dSjlvo07uWh2rFjp1IOS9RitVT
 Tj1ODeKnDxXfI4pnPvhySODfqQjP39TK+YW1sW9DeUjK8T/04NwK2W5JW2QTWMV+SYW7
 zkM0oyuB5OL3Fkavn8K7EOoHmAhRlbNSdTYPyD2lXrI3Vt6IcH21A9rUdSJlWIP6/1/v
 kjdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8S+o0oaySBXQHBzadq2mASJkMU0ZKYjwNzh2zMITlO03CSaah9Riew0TPKncbBmNUnPkYdjmz5uVn@nongnu.org
X-Gm-Message-State: AOJu0Yza65Hhy53nbQfL3ggyociitXzmQWrAfyEH4rdW3d8HfDR8ar7H
 Z3PXWuZpbkmaFAMwK8gCXMLt4HPi/LcqqlXH/yrP8tyOllVLCxEwgxP5M8iTd+6yre5WAC9HUS0
 Iv3oUM6dwe5S5VOqpx60+wb1B5F4xvZiuVe+sZj7kA6xboY8kaFXqiXlR
X-Gm-Gg: ASbGnctIvSBhq5V/3Yk628TalQRfxdEE2/mCkWyUpSEshvXbqnE+G/FB5EffUFW9RUS
 0jUM3ZvJl5IAfUcAjQp4+OnjBNOW7mN50Fx+lSKtInHRjtyYuzOMyY8YhVLLFGHS7CK997bJNKm
 dCfOLf3UktWhFdxMxxsJHkZHcIEa8kCFSVhM/HGTSPx2GxTU9oN4NoAW9poVB/3zBRiki+lcFd6
 /HD2eEIqHFxaassQMwDTf8ga/iav4dTTi51S73rR4xguZ/9Er2LN5hJ6GxWv3YN/QtXpzi8XjOG
 lQ+fKi+jJUi9
X-Received: by 2002:a05:600c:3f14:b0:453:7713:539f with SMTP id
 5b1f17b1804b1-453a0694830mr74931145e9.26.1751380415777; 
 Tue, 01 Jul 2025 07:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKZ1E4aa/2GHEd0G/gGJUD2EaDsxN8GGlu8miTszmAbM3e3O+67rw2vGC6Xx5ChAV/5Qh4Rw==
X-Received: by 2002:a05:600c:3f14:b0:453:7713:539f with SMTP id
 5b1f17b1804b1-453a0694830mr74930565e9.26.1751380415177; 
 Tue, 01 Jul 2025 07:33:35 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a57c2sm167445835e9.12.2025.07.01.07.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 07:33:34 -0700 (PDT)
Date: Tue, 1 Jul 2025 16:33:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250701163333.32364b32@fedora>
In-Reply-To: <ehnkq6m3mdnrh2my5ui7agknq42js7y2rlu4ghtvj7egscryhg@4g4kapalbj62>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
 <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
 <20250624124527.656d567c@fedora> <20250627140259.3f88db17@fedora>
 <ehnkq6m3mdnrh2my5ui7agknq42js7y2rlu4ghtvj7egscryhg@4g4kapalbj62>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 30 Jun 2025 12:02:25 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > As you've said in comment
> > https://bugzilla.redhat.com/show_bug.cgi?id=1322713#c6
> > it's strange that patch causes issues at all, especially with
> > '-smp 1' as in reproducer.
> > 
> > Also repeated with -smp x>1, it still worked fine.
> > 
> > Perhaps issue was elsewhere after all.  
> 
> Yea, looks pretty much like this.  Guess we do not need the
> 'make only read access lockless' part then.

Yep, I'll ditch readonly and instead add proper fine-grained locking
to PM and HPET timers instead (HPET needs it anyways as Peter pointed out,
while PM will be just a collateral)


> 
> take care,
>   Gerd
> 


