Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A203BC54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQ1u-0007vw-Me; Sun, 25 Feb 2024 20:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQ1t-0007ve-C1
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQ1r-0001j4-TF
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708911818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgEb0Hjc+DOXjeJwt0dRoR/a3x6R/8oxH1IY9vTm/DU=;
 b=ToRN4wMp+0EsOUF6h3jv6Bt1NLMEL4q3JFlY4NZT0oLb0+fxPBlzd/pNAq8PrJIaM6tgkE
 KOTZoc5c0zaJwcjHXOmkRDUhT1+Khcc+Yu9HI1NO3fSdxcpFDn7JzCCfXuh8ysGyBzYjQG
 7tTROSFnXB6+KVqW60DIah/S3uHgLsM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-dzJg85SJOFCA1B4-ZRdQ2Q-1; Sun, 25 Feb 2024 20:43:37 -0500
X-MC-Unique: dzJg85SJOFCA1B4-ZRdQ2Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e52cd663ffso20829b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 17:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708911816; x=1709516616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgEb0Hjc+DOXjeJwt0dRoR/a3x6R/8oxH1IY9vTm/DU=;
 b=BT4evbDmjqhAOOtEB8HQ3eJVYHmqyMIdCZdwdhnAAW4UC6VmYam96FJ0rFAnVlGD5I
 ppCKobHdT15mssK4rE1W8Zwu8x7HGtZL4wnvfYOyn+5cLh/+gWWdxLIxiyt187fbc6Dr
 YQCy1oK/0qXfAADMqRTBS/hEPl/9Hf2AZc7Kxxi9PlzwN1VVhU4MoQcBiawaxWx7fhcm
 dyOQSDv2FghLCyqiMMSL++XZuzA8vkNrSgNskYDjaT4Bn1GdW+0puyO+xaS9hJnnEnFd
 oIybpqtS/SM6/jsQgq6U00KubWKqEq4MmFQmIdFVB7770RpDO4rzXzXd0HIM0FH1D8VL
 DCQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4RNWzskXUfAUwHSISosjSCRg+QIBqZ5PhnmVJx9cofPU1Oa0bG8ftEGe8ikPBcA0207ObCQvQEleEtWOk98SFpsV4f2s=
X-Gm-Message-State: AOJu0YyDhnb7aUFLkQtMojmYqvMevGhBEfAAtqqb5nzfAdpShqKKWFY3
 1QGJdTmIQJG/VFbavGr6HAeObvw1YU391lL3PWB60xuMt18MzJZ8lZBd9qF4p5oLs9GVFPwW9JS
 2jD7OJjxPyXVdEJAcAhZDf12vcEIRk9NwSPN9zM7/oB45ETVgsEq6
X-Received: by 2002:a05:6a00:2d14:b0:6e4:fe18:9528 with SMTP id
 fa20-20020a056a002d1400b006e4fe189528mr5744758pfb.3.1708911816176; 
 Sun, 25 Feb 2024 17:43:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwT7EeiltIoxNZEHFpGZtqXmucIHnImGFt7578hO1Hda6lWkJATDKCpGx/bwRZ8TbAPimyfg==
X-Received: by 2002:a05:6a00:2d14:b0:6e4:fe18:9528 with SMTP id
 fa20-20020a056a002d1400b006e4fe189528mr5744703pfb.3.1708911814499; 
 Sun, 25 Feb 2024 17:43:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c9-20020a056a00008900b006e08da9c29csm2860980pfj.54.2024.02.25.17.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 17:43:34 -0800 (PST)
Date: Mon, 26 Feb 2024 09:43:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org, jdenemar@redhat.com
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero
 page checking from multifd threads.
Message-ID: <Zdvst5RmG73_5aWo@x1n>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
 <875xyhbk8k.fsf@suse.de> <ZdgD-eqUYxbQMJQN@x1n>
 <CAAYibXjBX8CeCL3-9BcUoGxY6UY9-N8sriJ7N_GUzVPUX1y3YQ@mail.gmail.com>
 <CAAYibXgp-NGqE5ATby_Y6=s7WR5yToTxWQbdeVydv0Jez98iEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAYibXgp-NGqE5ATby_Y6=s7WR5yToTxWQbdeVydv0Jez98iEQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 24, 2024 at 03:03:15PM -0800, Hao Xiang wrote:
> So I just want to make sure I am coding the right solution. I added
> setting "zero-page-detection" to "legacy" in hw_compat_8_2 and tested
> it. The behavior is that if I set machine type to pc-q35-8.2,
> zero-page-detection will automatically be set to "legacy". But if I
> set the machine type to pc-q35-9.0, zero-page-detection will be the
> default value "multifd". However, this doesn't seem to be a hard
> requirement because I can still override zero-page-detection to
> multifd on machine type pc-q35-8.2. Is this OK?

What we want to guarantee is old 8.2 users can smoothly migrate to the new
qemus, and existing 8.2 (or prior) users definitely don't have any override
over the new parameter zero-page-detection simply because 8.2 (or prior)
binary doesn't support it yet.

Then, if someone is using new binary with 8.2 machine types, meanwhile
override this default value, it means it's the user's choice of doing this,
and the user should guarantee all the qemus he/she manages also keeps this
parameter override to make sure migration will work between these qemu
processes.

So in short, that's all fine.

Thanks,

-- 
Peter Xu


