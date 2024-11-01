Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6E2E6B278
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 14:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6sIq-00005R-Ds; Fri, 01 Nov 2024 10:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sIp-000058-2N
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sIn-0005TT-3A
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730470018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmT31RjLEtfPyzQ+IFqJZn7IfYfnoLdAn4YSCW/QZi4=;
 b=YjnLTXPV7rzVmYEDfMRMEd4IMKkLHVdL+ot/qrQYh0OR/J2auA+vvWYgI7osbTnHyQCL8T
 870+vLNdJsiazCwB7NbhwMIYdpdqD910G8kSLw8BagB98HPj4egQsY5YN0tEUM5oaKQNWr
 NF0H/kpnuDhw1qfxmfxuWZuI+lbclYA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-LRhmA91-MlCtUpc-lb6CmA-1; Fri, 01 Nov 2024 10:06:56 -0400
X-MC-Unique: LRhmA91-MlCtUpc-lb6CmA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbe77eeeadso27809296d6.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 07:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730470015; x=1731074815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmT31RjLEtfPyzQ+IFqJZn7IfYfnoLdAn4YSCW/QZi4=;
 b=iuO+Hoqer8c6YEXo+9Ll4jbfMs/rBsJSNj+eYngzEuubE+6QkKfKWFWHchIMwcG2FB
 mvdo5vfwnLnaositwkCSIPxSf6q5+Na3LKFgRLz4F1yW9SlEdB16AFHarok0ubbbnEwR
 excORo7xJ/XnsV/MsZ5VBOESF7JCHzzhdhU8YKyZ0xoiybfylp5XJHlX20rcyeIpmARk
 5alpFI+Ts/+XdYphwlWcfFLUlT0tMKN/poPD/X0tJRFfygGkDOYV5fQNUoAjGaJIC3HV
 mU0z58qi5IgWq9MnsMNjZR3iWP8G/rIdHOL3Uu0s28l4Img3CdB1GSk1pRyD7tSDfEps
 NECQ==
X-Gm-Message-State: AOJu0YwdpLjQz0nqFuo3k1MXNmAQ/NasodvzG08IAI4Ju792Om3DUykX
 zwXKP6smMO5k+jdt/G+NzNqG5GrpY99901EOrx9ImqFdnM/lN3XU1qGV3QjC7qOewYmc6HFVlMX
 zxL+ZNkwm9ex6VRcyEI7I8BjR+Yj1emRNbufx867fbYA4QpqAfp5G
X-Received: by 2002:a05:6214:54c1:b0:6cb:f039:85a0 with SMTP id
 6a1803df08f44-6d35c189fa5mr54027636d6.40.1730470014862; 
 Fri, 01 Nov 2024 07:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHex8FarMq9RP747/TNkpuVdpSB7DCHkVTt1H3WAxD1tjBdHdMieXJ0f8s/6uYKfQE+YpJrqg==
X-Received: by 2002:a05:6214:54c1:b0:6cb:f039:85a0 with SMTP id
 6a1803df08f44-6d35c189fa5mr54026986d6.40.1730470014402; 
 Fri, 01 Nov 2024 07:06:54 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35417a3afsm19618436d6.126.2024.11.01.07.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:06:53 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:06:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <ZyTgfGlHTUta2FOm@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 01, 2024 at 06:47:40AM -0700, Steve Sistare wrote:
> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                  qemu_mutex_unlock_ramlist();
>                  return;
>              }
> +
> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
> +                                        TYPE_MEMORY_BACKEND)) {

Steve,

I think I'll postpone a few days on reading the whole series for other
things.. as I think this will miss 9.2 anyway (but we can see whether we
can still get it in early 10.0).

Said that, I want to mention this early that there was concern raised on
using block->mr->parent_obj.parent here to detect mem backends, which can
be error prone.  Please have a look at the discussion in v2 for that.

https://lore.kernel.org/qemu-devel/Zv7C7MeVP2X8bEJU@x1n/

-- 
Peter Xu


