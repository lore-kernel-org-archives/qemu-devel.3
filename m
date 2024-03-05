Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4886DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVjm-0000Wj-BL; Tue, 05 Mar 2024 09:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhVjk-0000WK-2k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhVji-0004pu-9P
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709648741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUHKWz896Esprjn5bEOSh0X+iP+QTfVdXVUIO0Xrxak=;
 b=dn2rNs237pghlDMF4HIxi0zZEzbmt2Wg5qstTjc25iewsXQj6YF9yl9jykQH7Gc7lOLg9/
 Oj5K+C64+CqAKtgzl8MvzDVXXFBA9R6qEcpuIPLHTMyBcGhDiLVD0Qg6Z8FLQPNINMfQ1z
 +IdEmOJDdnFEfEKXRh8CMY3MaFbMxpQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-OAXR6RDPNHSFqa9OIHDHyg-1; Tue, 05 Mar 2024 09:25:40 -0500
X-MC-Unique: OAXR6RDPNHSFqa9OIHDHyg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-783350c4584so115251185a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 06:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709648740; x=1710253540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUHKWz896Esprjn5bEOSh0X+iP+QTfVdXVUIO0Xrxak=;
 b=oS7Axy0i6n2POr6POsggru3cX0xRa+yVMzOmkV4jvey8WA9W8a9H9MtUCygCdzgTnW
 NiS0Xke5qWXvOh1HU2dhSLbIhacxqVPeM+sZc8biJStBh+3Qhg8cVT/TMPMqww6mY31Z
 pSZrY/XVE/A5tSXRvtOmw9FqT9gkZdLFDXQ9IrUg47CE80UDjDC51cBHgIfHOVBeAQos
 YBf0KqyJ9cnRuUNvfgSpmXyeWAmYTIqUjRuoMz7k9fEHeKbfBgzOjE+fUpAsc9h5O+9e
 NZSnPPEHLnS/OHG1v1vG0Jn4++T0C6LNyyol4Omv3dpwvPtZmcYXCiW58/+llxgXhwit
 8amg==
X-Gm-Message-State: AOJu0Yx53LUEJyB7NICieYA5YeFTvSwKnQhun+FKab64K5pKLTZUcoDm
 q5thjjVu//iRIvBXrvmBkujAesEpbV1u1SUdJsEzrC/gPeeh03gyTgc4eypdb1ilD2aLdyVu+PA
 faBNGqKNoU+3/qMxCRsfSO6zB00QalzSzRf75SGS7iYAm+tBmXh1l
X-Received: by 2002:a05:620a:1359:b0:788:322c:3c1a with SMTP id
 c25-20020a05620a135900b00788322c3c1amr1979866qkl.75.1709648739805; 
 Tue, 05 Mar 2024 06:25:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY5tFffHNwwtbpZoa1l5dOALO1K9EC5KRl0ZNhv0Eethu9WYjmJ1yBQhsUnsM2j5krj9Fv0w==
X-Received: by 2002:a05:620a:1359:b0:788:322c:3c1a with SMTP id
 c25-20020a05620a135900b00788322c3c1amr1979834qkl.75.1709648739514; 
 Tue, 05 Mar 2024 06:25:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c24-20020ae9e218000000b00788349c0098sm742539qkc.50.2024.03.05.06.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 06:25:39 -0800 (PST)
Message-ID: <4022ae23-7151-4fb0-abb5-82539feacad0@redhat.com>
Date: Tue, 5 Mar 2024 15:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/26] memory: Add Error** argument to .log_global*()
 handlers
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-15-clg@redhat.com> <ZebQgd3uRuBNACRI@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZebQgd3uRuBNACRI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/5/24 08:57, Peter Xu wrote:
> On Mon, Mar 04, 2024 at 01:28:32PM +0100, Cédric Le Goater wrote:
>> @@ -2936,15 +2975,22 @@ void memory_global_dirty_log_start(unsigned int flags)
>>       trace_global_dirty_changed(global_dirty_tracking);
>>   
>>       if (!old_flags) {
>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>> +        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward,
>> +                                        &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return;
> 
> Returns here means global_dirty_tracking will keep the new value even if
> it's not truly commited globally (in memory_region_transaction_commit()
> later below).  I think it'll cause inconsistency: global_dirty_tracking
> should reflect the global status of dirty tracking, and that should match
> with the MR status cached in FlatViews (which is used in memory core to
> reflect address space translations).

You are right. FlatRange::dirty_log_mask could be out sync with
global_dirty_tracking.

> For some details on how that flag applied to each MR, feel free to have a
> quick look in address_space_update_topology_pass() of the "else if (frold
> && frnew && flatrange_equal(frold, frnew))".>
> Here IIUC if to fully support a graceful failure (IIUC that is the goal for
> VFIO.. and this op should be easily triggerable by the user), then we need
> to do proper unwind on both:
> 
>    - Call proper log_global_stop() on those who has already been started
>      successfully before the current failed log_global_start(), then,

Yes. This needs more work to restore the initial state. The current
proposal is relying on save_cleanup() to restore the previous state.
This is not enough.

>    - Reset global_dirty_tracking to old_flags before return
> 
> We may want to make sure trace_global_dirty_changed() is only called when
> all things succeeded.

That should be done after the loop on listeners even today.

> I don't have a strong opinion on whether do we need similar error report
> interfaces for _stop() and _log_sync(). 

Yes. Let's focus on log_global_start(). The other changes are not necessary
for VFIO.

> I'd still suggest the same that we
> drop them to make the patch simpler, but only add such error reports for
> log_global_start().  If they never get triggered they're dead code anyway,
> so I don't think "having errp for all APIs" is a must-to-have at least to me.

I am fine with that.

Thanks,

C.


