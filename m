Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17233C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1webok-0004x7-1c; Tue, 30 Jun 2026 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1weboh-0004w5-0Y
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:00:12 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1weboW-000648-Ab
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:00:08 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1C0E620B716C;
 Tue, 30 Jun 2026 09:59:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C0E620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782838794;
 bh=w5MO5Nk8VvjVQtdljeKkZ9CQWuh0d7L6W4WYmmWd9ZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pOsE0cvw2ehpMixgBHsu3TgKTJZqJigenI3wmQQ8gkOAygYcARQqPmh33IhE39T4A
 DCxmkcLPbY7cVuATRPNWu1h9zRG0yoMKnFlJlqoo15b1sCiclq4YpuUvce4EIyoBQd
 2hWj5bebNHapVFgFgZurzv8tw7AVZXLd3yZ8agz0=
Date: Tue, 30 Jun 2026 18:59:52 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 23/45] accel/mshv: store partition proc features
Message-ID: <akP2CAiVH6XEMi0z@example.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
 <20260626101748.1728079-24-pbonzini@redhat.com>
 <CAFEAcA_TQHLNswnYhGKVf8bY+oy_fxWDoTTbunrwXGtAcV-gbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_TQHLNswnYhGKVf8bY+oy_fxWDoTTbunrwXGtAcV-gbw@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 29, 2026 at 03:27:40PM +0100, Peter Maydell wrote:
> On Fri, 26 Jun 2026 at 11:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> >
> > We retrieve and store processor features on the state, so we can query
> > them later when deciding which MSRs to migrate.
> >
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20260417105618.3621-19-magnuskulke@linux.microsoft.com
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Coverity points out what looks like an error in this commit
> (CID 1660876):
> 
> > ---
> >  include/hw/hyperv/hvhdk.h |  2 +-
> >  include/system/mshv_int.h |  3 +++
> >  accel/mshv/mshv-all.c     | 57 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> > index 9ad16c47da9..9e6dcb22f61 100644
> > --- a/include/hw/hyperv/hvhdk.h
> > +++ b/include/hw/hyperv/hvhdk.h
> > @@ -353,7 +353,7 @@ union hv_partition_processor_features {
> >          uint64_t lass_support:1;
> >          uint64_t idle_hlt_intercept_support:1;
> >          uint64_t msr_list_support:1;
> > -    };
> > +    } QEMU_PACKED;
> >  };
> 
> hv_partition_processor_features is a union of a 2-element
> uint64_t array and a pile of bitfields...
> 
> >
> >  enum hv_translate_gva_result_code {
> > diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> > index 5eef2e6e2cb..0cf68d2879e 100644
> > --- a/include/system/mshv_int.h
> > +++ b/include/system/mshv_int.h
> > @@ -14,6 +14,8 @@
> >  #ifndef QEMU_MSHV_INT_H
> >  #define QEMU_MSHV_INT_H
> >
> > +#include "hw/hyperv/hvhdk.h"
> > +
> >  #define MSHV_MSR_ENTRIES_COUNT 64
> >
> >  typedef struct hyperv_message hv_message;
> > @@ -53,6 +55,7 @@ struct MshvState {
> >      int nr_allocated_irq_routes;
> >      unsigned long *used_gsi_bitmap;
> >      unsigned int gsi_count;
> > +    union hv_partition_processor_features processor_features;
> 
> ...and processor_features is a field with one of those unions.
> 
> >  };
> >
> 
> > +static int get_proc_features(int vm_fd,
> > +                             union hv_partition_processor_features *features)
> 
> In this function we take a pointer to a union hv_partition_processor_features...
> 
> > +{
> > +    int ret;
> > +
> > +    ret = get_partition_property(vm_fd,
> > +                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
> > +                                 features[0].as_uint64);
> > +    if (ret < 0) {
> > +        error_report("Failed to get processor features bank 0");
> > +        return -1;
> > +    }
> > +
> > +    ret = get_partition_property(vm_fd,
> > +                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
> > +                                 features[1].as_uint64);
> 
> ...and treat that pointer as an array of at least 2 elements.
> 
> > +    if (ret < 0) {
> > +        error_report("Failed to get processor features bank 1");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int create_partition(int mshv_fd, int *vm_fd)
> >  {
> >      int ret;
> > @@ -520,6 +571,12 @@ static int mshv_init(AccelState *as, MachineState *ms)
> >hv_partition_processor_features
> >      s->vm = vm_fd;
> >      s->fd = mshv_fd;
> > +
> > +    ret = get_proc_features(vm_fd, &s->processor_features);
> 
> But here we pass in s->processor_features, which has only
> one hv_partition_processor_features, not 2. So the [1]
> element access will read beyond the size of the field.
> 
> My guess is that the intention here was "features.as_uint64[1]"
> rather than "features[1].as_uint64" (and similarly for 0,
> though there it doesn't actually walk off the end of the field).
> 

Hi Peter,

yes, indeed. this is a bug, it should be uint64_t[0] and uint64_t[1]
instead of features[0] and features[1]. Ironically I spend some time
debugging this very bug today, albeit _before_ reading this email.

it's causing some breakage for migrating guest with CET support (or any
feature that is part of the second bank of processor features, I guess).

thanks!

magnus

> thanks
> -- PMM

