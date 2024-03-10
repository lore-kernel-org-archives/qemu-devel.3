Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF6EC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHmg-0006dX-QN; Sun, 10 Mar 2024 07:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjHmY-0006Y0-UZ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjHmX-0004XI-5I
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710071754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1o4GtBOgV/b7S+ZfNrxZ1ut3KAwK6U0uVec1/5Hl0eY=;
 b=ZcwPvARWbfXwSHa0aNBSjOJg7kyEhnQiTLBtsxs7hOKZaaLk5P5WKQEZ4iiv1GEskkKe4U
 XuCtrWzEljOcwmPCL9x61zUMzr/XDOvgBHqEtlvmWBnbxKceZYdAAa0rLYyO2jRz3S7GeG
 AuO42vNKzPDgWjQJ8+f18yaLrS9Hbew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-1l3eiZgdNkym_AeRNLZ8JQ-1; Sun, 10 Mar 2024 07:55:51 -0400
X-MC-Unique: 1l3eiZgdNkym_AeRNLZ8JQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e9203e775so182142f8f.3
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071751; x=1710676551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1o4GtBOgV/b7S+ZfNrxZ1ut3KAwK6U0uVec1/5Hl0eY=;
 b=M9xjh4kH1SiLxLPSK8LvELR4ye3GHHjLktMIIdF7CNn0FW6kypsK+gmv5EuiA6LeFb
 gk7m/RLhE0WzxNE9roSzFKrPzxPIo4FyNHxXXGZxMJKSn//H+4pbVhPGe5jLNlAv/CyE
 JQxOwoluMjFwxisyCVkxhNG60NgCueW2XmG+oR9qkGoPS+L2H2K5WtEKs6AYgszQD0oD
 oi6Oq0UFxYTJL3bLNL4rmclv6zg8EE97uvhUFlPtzTILg2VSkAMtV66lTv1k243HThmr
 1Pe32LVllFQAalBE6p/sF6ab6sh3w3VeH08IHrJwvQ0gIIGB21mEZuD9Kvf5z7MTptbs
 Pagw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKG7WGYHo6wadh76TeN94OlA2gb8dgjnIW0Dp0WFmcmIDhn/bKBqfncdjRMw6mzRbRfyYWjEYUC4hSUhbTN9RjrIDApgQ=
X-Gm-Message-State: AOJu0Yyg3HHnFE86IJhWXYC9zdmql8ioK56BvhP4NrL2YvM6SkF/qq3g
 2qDEj6emE7AWT/FPB6sMQ3e43xcJBvI7e/Gc8mOvxEyLfEiaSeibLi3kgdsjoj7PfW5Q3W05rjx
 30XQUIsp6csG3aOXE4LZq207YIzC50H971GiCRyJZVGfgBTWSFa8jyLJ56O/9l8u7BC1oEupTjO
 r7edV1OgvaPar+kRmdNh93fKEP0Vw=
X-Received: by 2002:adf:efc5:0:b0:33e:6056:6b7d with SMTP id
 i5-20020adfefc5000000b0033e60566b7dmr3167951wrp.52.1710071750885; 
 Sun, 10 Mar 2024 04:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIBt7chZjAKMI+yt1xoBD2LE54vxVXuUVkrfkpwQvIzCxCMD0nPrxHZYSkpSVgbDX/vqUZEp9NemdJ9xHtOY=
X-Received: by 2002:adf:efc5:0:b0:33e:6056:6b7d with SMTP id
 i5-20020adfefc5000000b0033e60566b7dmr3167940wrp.52.1710071750576; Sun, 10 Mar
 2024 04:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
 <Zesv4W8DKteGeE/a@intel.com>
In-Reply-To: <Zesv4W8DKteGeE/a@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sun, 10 Mar 2024 17:25:34 +0530
Message-ID: <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
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

Hi,

On Fri, 8 Mar 2024 at 20:50, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> On Fri, Mar 08, 2024 at 02:20:45PM +0100, Thomas Huth wrote:
> > Can we always rely on that? ... or is this just by luck due to the current
> > implementation? In the latter case, I'd maybe rather drop this patch again.
>
> Thanks for the correction, I revisited and referenced more similar use
> cases, and indeed, only if the flag "has_*" is true, its corresponding
> field should be considered reliable.

* Is this because 'SMPConfiguration config'  fields are not always
initialized with default values? Is that a bug? Having
'SMPConfiguration' fields initialised to known default values could
help to unify/simplify code which uses those fields.

> Keeping explicit checking on has_* and explicit initialization of these
> topology variables makes the code more readable.
>
> This patch is over-optimized and I would drop it.

* Could we then simplify it in the following if <expression>
===
      if ((config->has_cpus && config->cpus == 0) ||
          ... ||
          (config->has_maxcpus && config->maxcpus == 0))

could be

      if (!cpus || !drawers || ... || !maxcpus) { ... }
===

Thank you.
---
  - Prasad


