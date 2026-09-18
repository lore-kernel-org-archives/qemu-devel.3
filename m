Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C953CC982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XFp-0006ib-Ny; Fri, 18 Sep 2026 07:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x7XFo-0006iJ-91
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x7XFm-0004AJ-3Z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789732774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0Ps4eA70uDzzlIDj+pw07O2f7Ke2we+Pb/QfNa0kLo=;
 b=QB6wdhHcbNhk2333YOZW7dY+xQsxKC+s0Xf8VYSZNLGqYYO1WUlU8WB2Vmd/IzArs9JXh7
 kQTgOeogOSn5epB07GTivvWoKv24DIDLcH4fuTQg7RcrGaNnwMQuLVNcSsooQt0X7oXE4N
 26RHLYLSI/MDJ8+ucEi0yfmyIGNDXRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-pdl59llUPLyDQ9gLhwyeLQ-1; Fri, 18 Sep 2026 07:59:33 -0400
X-MC-Unique: pdl59llUPLyDQ9gLhwyeLQ-1
X-Mimecast-MFC-AGG-ID: pdl59llUPLyDQ9gLhwyeLQ_1789732772
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4870142fd5cso390061f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789732772; x=1790337572; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p0Ps4eA70uDzzlIDj+pw07O2f7Ke2we+Pb/QfNa0kLo=;
 b=dfdcEF2MjcpLqpB2SHY59lLoMhtu00hnFRMoP0sDPL8g1AdWCWGAXYXthhzmshf6tz
 VpjWqwNlyUTD9V91+qnlwp0W5BHKquS30aRInLQtHSOZ7B2eM6IEM6UG0m3N8oCrNhtM
 rs4YCAe1vO90pZKzj602h+/MsLMbQiGSVz0vpZ3zBLmDUPJDrRiCbQgP4jPW7GZZm6ya
 tRRMKG+RGkmPeVB2tMLLXPwk9abXrtE+60/xbrPlVMimJ50fTnpNZcw0unor2pki5gd8
 /hJBPaEMSYhTCVqLUOqPRz3/pM22v1NqmAFxm6gxVaw/SjRfQK8tTFkmeHbFUz/+MDt9
 SzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789732772; x=1790337572;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p0Ps4eA70uDzzlIDj+pw07O2f7Ke2we+Pb/QfNa0kLo=;
 b=iDinz3Ubmr3VAQ4wTFDnOksjlsElyvBpdiQurE+3fJzkdyu1xVZ6EKxAKN+bO554zw
 uvuQhM1BdSXL4zbZxEHS5ukfoG5wb6csTC27FN7FOXhL2f33vgcX4r3JEI+x7qQgIDGL
 i8g4aD/e0mpWHUGYUcpgmD7zgcRiBs93EioSy8EpxY7Yx0Kl5xtsvBmJy9d/cIlCbTeL
 o0DXUPd2uvyy/BeuahhJg/HgEVs3WkABGjVooXE5BT3FT1TZ/LV5fa8ZwoFyjKpgX9W4
 SNRy6FhFZXwlr56M5qnrCvW4HvA7a2kvBuOcPJ4xBllQf788PWW0WgXjDXrCqOvOoigF
 p3pw==
X-Gm-Message-State: AFuF++lZ07o00C+6uChzSLpRl+iRK5s/kS6W0+kK2LNo2temJtrxoAmi
 PeA/hkhQa/+0G3u9cMY0RmPvLwc6r7FcwgBHhUPVxcUixFYuE6wOR1JmvL4t0Bdyl8N3jSHnpj1
 Sx+XBilnYsYt/Ew3MYS+UhkQGXFgJ0Pzc48UGZa2hwq7g6c2LNzHB73sQ
X-Gm-Gg: AYBFou0/B9C0dqzC1bbbCnTq5Sen7eX8LRtT2ZuggoFCtMomXQDOQF2DFtvknJW5Afs
 J8Zybi5hskznSxXTWXdFfVHGE2QoNNLqFLIT/bGfXHHfpd/SMyWC2bgn101uA4Y0m2mCt/gs28C
 kW+QZXcwltv7IXJYQs3b1E6RkltZSGVytHOVYoGVcOFiwKFu3iEUaUA9lQnvnN+kHDafbpAsig7
 IaZp51xTcYwPPP7mDhPNvOLnvwhX6gHjWdpa4KnBH0MD8lu488MnWDmW2CX8yZhCFCpAq1v+W10
 9SZw1AoKdcUjwtbWX6Si+3Hym30eHiQj53fZSn2Look2yqa88wKCanMKQ34Ay3PxFOaLyvi63Qc
 dX13BT3Mfe2itrxEadCAOJlDUm4t2f92tBvE=
X-Received: by 2002:a05:6000:98b:b0:487:8ec:1fc with SMTP id
 ffacd0b85a97d-4871e20b2bcmr3274108f8f.12.1789732771967; 
 Fri, 18 Sep 2026 04:59:31 -0700 (PDT)
X-Received: by 2002:a05:6000:98b:b0:487:8ec:1fc with SMTP id
 ffacd0b85a97d-4871e20b2bcmr3274088f8f.12.1789732771629; 
 Fri, 18 Sep 2026 04:59:31 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871feb5d9asm3761354f8f.2.2026.09.18.04.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:59:31 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:59:28 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v5 1/2] igvm: validate and honor byte_offset in parameter
 directives
Message-ID: <aq0mZgROFknEqkxY@leonardi-redhat>
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
 <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
 <7f5d6e7a-882f-4784-9944-6449eba14e0c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7f5d6e7a-882f-4784-9944-6449eba14e0c@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Michael!

On Fri, Sep 18, 2026 at 01:51:51PM +0300, Michael Tokarev wrote:
>On 9/16/26 18:10, Luigi Leonardi wrote:
>>Parameter directive handlers either ignore param->byte_offset,
>>overwriting each other when several parameters share one area, or use
>>it without validating it, letting a malformed IGVM file corrupt QEMU's
>>memory.
>>
>>Add qigvm_get_param_data(), which validates byte_offset against the
>>parameter area size and returns the offset-adjusted pointer together
>>with the space left after it. Convert all parameter directive handlers
>>to use it and to check their writes against that remaining space, so
>>that no parameter can be written past the end of its area.
>>
>>Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
>>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>>Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>  backends/igvm.c                | 89 +++++++++++++++++++++++++++++++-----------
>>  include/system/igvm-internal.h |  5 +++
>>  target/i386/igvm.c             | 12 +++---
>>  3 files changed, 77 insertions(+), 29 deletions(-)
>
>Hi!
>
>This patch (set) has been Cc'ed to qemu-stable.  I'm assuming it is valid
>for 11.0.x and 11.1.x series (since all commits mentioned in Fixes: tag
>are past v10.0.0).

correct :)

>For 11.0.x, there's one tiny issue: this branch does
>not have commit v11.0.0-2280-g4d3b9dc4d1f "igvm: Report error on missing
>parameter area in directive handlers".  Is there a prob for 11.0.x if I'll
>pick that commit too, in addition to this one?  It looks ok to me :)
>

Feel free to pick it up! Thanks for looking into that!

Luigi


