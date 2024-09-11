Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB3DEE57C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP9x-0007cl-D2; Wed, 11 Sep 2024 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soP8a-0001gB-Lh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soP8W-0001qq-M7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726068000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwKA9v+hQSM78i0ouAhxjLBGM+JLuV05MtoMbKJsJDU=;
 b=gdSI3K4paVe4+zKfraC9pbSSRVFwIS2LTxz+YlTK5C7Ou3T5AV8HeiA61+7gxJq+UHnFHT
 Uwj1QdsTYhamDwDMIYFsscH88rd/Shkih57e61qfDWFnp4LUzKtgVBESlaAK5JSZucW/4i
 WQGrNNQnu3M6zS6HnfTydHa0strhCOw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-7kd_4ch3OuWG0EY3_7M64g-1; Wed, 11 Sep 2024 11:19:59 -0400
X-MC-Unique: 7kd_4ch3OuWG0EY3_7M64g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c3639a649bso97277206d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067998; x=1726672798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwKA9v+hQSM78i0ouAhxjLBGM+JLuV05MtoMbKJsJDU=;
 b=Ndtng0oeYbZ0kyl+Kk0UqZ5Xc+p+P5SvpKO2t4x3468e9QqL3nyfLfY9aLWyH1lujs
 mOIrdk5SvbEHq2ktGhx1y9BvqZT28agP+J4J4XJfZ8cxKSY80U6ID5S4PZ3cCxbAOiFC
 NARn8vmwLqG23zO1KwvgHJrbgIoRTb56SScBZqJBA1iU6asqfZqcTCvV6dlavw2ATQjR
 1I3il8LV1WXeg1f2JEyhhW1kmSl7I/bJu+yIJ83zjoJmXS3FE5Sz4z1Uu6GmqFrxSjZ2
 WyiP/NrQCwc8egpehTdJ8ZSEjcD8HAqnJNtKWaAOR47KZUqi3ipUze4E/Y47m74YONKg
 obrg==
X-Gm-Message-State: AOJu0Ywy21oOGbyhnmViV67r72BDeSgLuonVOYy+FmiytNmcs0msvljl
 EjV4WhqSpPdo4wIM9CsCxUAq/+bF+hyNzeV6QNDZRV1psMrdd148K07UdkkTOU5FJvS4N9DYXSy
 hp0KeISL+Aym/K98sT53gwo1Ce/6rotqXOG3pp7Gr2kS/Q4KAR4Y4
X-Received: by 2002:a05:6214:540c:b0:6c3:64ec:fe4d with SMTP id
 6a1803df08f44-6c52850de38mr278677586d6.42.1726067998535; 
 Wed, 11 Sep 2024 08:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8wK/RjGwAiFI2cW/DSsMrAVCNXAfsLnv8+dV+4rS9GRjbYnhL6dgAtaiN83X0alCMCnyTQ==
X-Received: by 2002:a05:6214:540c:b0:6c3:64ec:fe4d with SMTP id
 6a1803df08f44-6c52850de38mr278677296d6.42.1726067998156; 
 Wed, 11 Sep 2024 08:19:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53432954fsm42877766d6.25.2024.09.11.08.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 08:19:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:19:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Hao Xiang <hao.xiang@linux.dev>, Yuan Liu <yuan1.liu@intel.com>
Subject: Re: [PATCH] migration/multifd: Fix build for qatzip
Message-ID: <ZuG1FWeek3TEpgAK@x1n>
References: <20240910210450.3835123-1-peterx@redhat.com>
 <87v7z3qjih.fsf@suse.de> <ZuDBUSC2hVaWv6dE@x1n>
 <87jzfjqgwc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzfjqgwc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 07:32:19PM -0300, Fabiano Rosas wrote:
> I'm trying to find a way of having more code compiled by default and
> only a minimal amount of code put under the CONFIG_FOO options. So if
> some multifd code depends on a library call, say deflateInit, we make
> that a multifd_deflate_init and add a stub for when !ZLIB (just an
> example). I'm not sure it's feasible though, I'm just bouncing the idea
> off of you.

Not sure how much it helps.  It adds more work, add slightly more code to
maintain (then we will then need to maintain the shim layer, and that's
per-compressor), while I am not sure it'll be good enough either..  For
example, even if it compiles it can still run into constant failure when
with the real library / hardware underneath.

This not so bad to me yet: do you still remember or aware of the "joke" on
how people remove a feature in Linux?  One can introduce a bug that can
directly crash when some feature enabled, then after two years the
developer can say "see, this feature is not used by anyone, let's remove
it".

I think it's a joke (which might come from reality..) but it's kind of a
way that how we should treat these compressors as a start, IMHO.  AFAIU
many of these compressors start with PoC-type projects where it's used to
justify the hardware features.  The next step is in production use but that
requires software vendors to involve, IIUC.  I think that's what we're
waiting for, on company use it in more serious way that sign these features
off.

I don't think all such compressors will reach that point.  Meanwhile I
don't think we (as qemu migration maintainers) can maintain that code well,
if we don't get sponsored by people with hardwares to test.

I think it means it's not our job to maintain it at 100%, yet so far.  We
will still try our best, but that's always limited.  As we discussed
before, we always need to rely on vendors so far for most of them.

If after a few releases we found it's broken so bad, it may mean it
finished its job as PoC or whatever purpose it services.  It means we could
choose to move on, with no joking.

That's why I think it's not so urgent, and maybe we don't need extra effort
to make it harder for us to notice nobody is using it - we keep everything
we know productions are actively using seriously (like multifd, postcopy,
etc.).  Either some compressors become part of the serious use case, or we
move on.  I recently do find more that the only way to make QEMU keep
living well is to sometimes throw things away..

-- 
Peter Xu


