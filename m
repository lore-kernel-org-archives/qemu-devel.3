Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28937C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUGe-00005C-Cd; Mon, 24 Aug 2026 08:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyUGd-000051-Pp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyUGc-0006Z8-1U
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNNnVtY4ojSqzc0KaiZFDYIYPTvP4sr1gZpKMSes8E8=;
 b=YZfVewVK3ffUq+QBsR/uZR9/yIoXeaSDAoe7JtJIHQPvkVhHWDHjSUP0Oauzz7ZMCZ0bgx
 SoAl2bqjtdjNUvbGb7sovIy8iUX2/4SSUVQUUbg3FnZao7E7BQbf5cjQhFqCpay12ehJwY
 1ExuDHoxayOI53pkpyByLqJ9ajQuy78=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-huULaEg1NCuDA_p6PIqrKw-1; Mon, 24 Aug 2026 08:59:06 -0400
X-MC-Unique: huULaEg1NCuDA_p6PIqrKw-1
X-Mimecast-MFC-AGG-ID: huULaEg1NCuDA_p6PIqrKw_1787576346
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so18517006d6.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787576346; x=1788181146; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CNNnVtY4ojSqzc0KaiZFDYIYPTvP4sr1gZpKMSes8E8=;
 b=REffJ32Bxfs5+y3fPpWn2JZK8FJtwgRQFHVk0U1jN68b3kMHz9a2AjgQHPZGJg+keq
 9/vYil7Ala3jiJBQLRMCGRT5ZitP5se3sKfSZDN0Kmj+7eXJZl5FPGoftynp2HEjKX4l
 HjT85vEDlJeH1DEfJy6ruxXyVsu0pFbaKX4w1zxYQO3jmdZuufYXfh/neLRh2wpUQDrW
 /SefSh+S8QXaUhqQdXprWtqRunvgnRTeMDzlO/4+/6oXRqVxM8uG97K2/0QiaTbti6nN
 HqSLCMjWBPeCqbgmgOK9/66+Jv2FaAICtFKPIVSOURYmev0yefH0Z7Vbn7xlJ+yCXUAF
 NHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576346; x=1788181146;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CNNnVtY4ojSqzc0KaiZFDYIYPTvP4sr1gZpKMSes8E8=;
 b=CfuK3LsHLyBTaKrM18oHvGFEW9/eoOBSINFOgqPiAPOPF8HvznPSq25JVA/pUTEaV+
 qvkr0QqSkVtPvMeCuUilw89Bi6sWOsZewoQhbyPziaZlDIHDyoQDRRoyu9FexUwqgsNh
 1x+RHNwU5xCNxgZOdq5zdLsqbsDBU8npOjUmO78vCDFeNB38Eu10+gt9P8uQF7TZmBfC
 u4aU4DDrZMekMjQR5GBUPkF3pEJTj29Jk2M0K5nML+ZKEU+UIti3CsZ1nxyZ7Ey7nrw5
 f4YB+j/PVSVCQFXaBhmteHbZhIGB2Hiz3GcE10npDgnfWnzIKvglUZBQ9MYcXHtgK5b3
 nd2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5Yc2eejDCLECjJtRBKaiHmn5MPiOM6uIswI4EVYBFG9dL/UEWMVxgNg3lve2euC4k9SwHkf1ZvSKd@nongnu.org
X-Gm-Message-State: AFuF++m3qDEJKJvwngVevaTKmJs1IUKuxQT2I5y4SBuID2RaRu0vTFMG
 hYJeA02gWnB9yd2ASmo8FRoeMjKTcvDBUQCNanWNPMpvIsxGMUvWRIok+5G1SC/NXvI45ZKesiv
 QaHeLkUdSNk8KKWeKB1gyPGGUMmOmbYko+xhgkWAALObv4CwhSOwLAkE9
X-Gm-Gg: AR+sD11F0uH9YNYarJ+ML72VzrcYt672QQ0djpY5pEkg8ORDxE875VlqD41qrRWqr/h
 YB5sh6rB78um/TDSMDXz/y/VG/QMfWZt6ZHT2IFk9LJ0rMqKzu+2GcJ+zh5SHtFzgwyCLQIsfcM
 ZfVzcuRjixMVrxbOPMCwIyapKDCTE5NlfVJsaMw69bFq7TkTLqMaYOSQB4ogpmBRUzp9bFrhnLw
 7SoLvjuan/uEdmvF97n9oeGkHdSfr8RJD6qnZU1aGIRh0T19VoAUyHgDFgwtts8PaGOYb+3NK7B
 GAcHuE7Wtx1KO7MQi2+BFLeNMufv8o8y/bctZIumV+1GWpMAHWbpxeo156Xq2fs8AYUH
X-Received: by 2002:ad4:5aed:0:b0:90c:6936:b508 with SMTP id
 6a1803df08f44-90c807b2784mr250827016d6.0.1787576346204; 
 Mon, 24 Aug 2026 05:59:06 -0700 (PDT)
X-Received: by 2002:ad4:5aed:0:b0:90c:6936:b508 with SMTP id
 6a1803df08f44-90c807b2784mr250826346d6.0.1787576345566; 
 Mon, 24 Aug 2026 05:59:05 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c935fba13sm63704596d6.13.2026.08.24.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 05:59:04 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:58:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, jmarcin@redhat.com, david@kernel.org,
 pbonzini@redhat.com, chenyi.qiang@intel.com, farosas@suse.de,
 aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <aoxADcqox7eUPEXT@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com> <an3PWdPIdb6afDsS@x1.local>
 <an8yCp9qZ498aLu2@redhat.com> <aoMGNz9AdOnDQkKE@x1.local>
 <2k6hph3cnf4djvjd72g26sdgxluixhm2mpyf2emvgmkrfturvj@ctnctjaks7jq>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2k6hph3cnf4djvjd72g26sdgxluixhm2mpyf2emvgmkrfturvj@ctnctjaks7jq>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Sun, Aug 23, 2026 at 10:33:36AM -0500, Michael Roth wrote:
> It seemed like the guest_memfd support for directmap removal[1] might be
> a good test for how this all look like once new features start coming
> along for confidential vs. non-confidential so I've been trying to get
> that up and running to see.
> 
> If we keep everything in memory-backend-memfd, there's a little bit
> of awkwardness, but the following schema should cover discoverability of
> QEMU support at least, and then libvirt/management can branch into whatever
> routine is needed for probing actual kernel support:

Isn't that secretmem for generic memfd case? I'm not sure if it'll ever
need to be supported by QEMU at all, but it sounds like exactly that for
normal memfds..

> 
>   diff --git a/qapi/qom.json b/qapi/qom.json
>   index ee981fc44c..4777f09ad1 100644
>   --- a/qapi/qom.json
>   +++ b/qapi/qom.json
>   @@ -774,6 +774,19 @@
>    # @guest-memfd: if true, use guest-memfd to back the memory region.
>    #     (default: false, since: 11.2)
>    #
>   +# @no-directmap: if true, enable support for unmapping backend memory
>   +#                from the kernel directmap to better isolate it from
>   +#                host activity.  This option is only available if a
>   +#                corresponding Features value advertises support for
>   +#                the intended use-case.
>   +#                (default: false, since: 11.2)

Shall we name the property to avoid "no-" prefixes ("kernel-map=on/off",
default on)?  I used "kernel" instead of "direct" because any mmap() from
user can also be described, more or less.. to be direct.

>   +#
>   +# Features:
>   +#
>   +# @no-directmap-for-guest-memfd: If present (and if the hypervisor
>   +# supports the feature), the corresponding option is available if
>   +# @guest-memfd is true.  (since 11.2)
>   +#
>    # Since: 2.12
>    ##
>    { 'struct': 'MemoryBackendMemfdProperties',
>   @@ -781,8 +794,10 @@
>      'data': { '*hugetlb': 'bool',
>                '*hugetlbsize': 'size',
>                '*seal': 'bool',
>   -            '*guest-memfd': 'bool' },
>   -  'if': 'CONFIG_LINUX' }
>   +            '*guest-memfd': 'bool',
>   +           '*no-directmap': 'bool' },
>   +  'if': 'CONFIG_LINUX',

Nitpic: we could drop CONFIG_LINUX IMHO in QAPI if it'll fail properly on
non-linux in impl anyway.

>   +  'features': ['no-directmap-for-guest-memfd'] }
> 
> One notable thing there is the current code only enables it for
> non-confidential VM types, so that's where the KVM_CAP_* checks would
> need to come into play to distinguish between what's supported for
> specific VM types.
> 
> 
> On a side note:
> 
> Ideally we'd be able to do something like the below so we can have one
> 'supported-for-guest-memfd' features that could be associated with
> multiple options, e.g.:
> 
>   +# Features:
>   +#
>   +# @supported-for-guest-memfd: If present (and if the hypervisor
>   +# supports the feature), the corresponding option is available if
>   +# @guest-memfd is true.  (since 11.2)
>   +#
>    # Since: 2.12
>    ##
>    { 'struct': 'MemoryBackendMemfdProperties',
>   @@ -781,7 +794,9 @@
>      'data': { '*hugetlb': 'bool',
>                '*hugetlbsize': 'size',
>                '*seal': 'bool',
>   -            '*guest-memfd': 'bool' },
>   +            '*guest-memfd': 'bool',
>   +            { 'name': 'no-directmap',
>   +              'features': ['supported-for-guest-memfd'] } },
> 
> But it doesn't seem like QAPI is wired up for that. I guess we could add
> that as part of enabling directmap support if it seems useful enough but
> the above should work as well.

Maybe we can still just fail it for normal memfds for now, considering
secretmem or anything like that might still be supported someday.  In
general, for any memfd property (guest-memfd or memfd), if it conceptrally
apply to all (my bet is here..) then IMHO we can keep them around at least
from the interface level, and just fail them when we don't have support for
one of the two.

Thanks,

-- 
Peter Xu


