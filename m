Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118BECEE34D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sydkb-0001iw-Jg; Wed, 09 Oct 2024 16:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sydka-0001iW-24
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sydkY-0004nQ-BA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728507456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0L9d+n3GLYRTO7tExztLLM6maTmO7/tpl1hNLOFBWTI=;
 b=OlUdXYHzTPeh36kg7aqgd1JqdW+kv5CvWmgFYC4tZPIQjvLHvp7BGk99KhQgy8hUVvZRkT
 mH/l+gkSGj4vk84tChgIHjNf1FLwA0ywgvlGCOnbtoGAwWwaeutzVYjq5xRu5Ikm65jxk+
 /Mgcmgomq9KoTO+vTZqKVxv2NKIp8Ew=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-lxhbm7bPPEiU_ClK9-LE_A-1; Wed, 09 Oct 2024 16:57:35 -0400
X-MC-Unique: lxhbm7bPPEiU_ClK9-LE_A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7acbed1c88dso29013085a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 13:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728507455; x=1729112255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L9d+n3GLYRTO7tExztLLM6maTmO7/tpl1hNLOFBWTI=;
 b=suI6x96LxGpxPfCeJ1vE9/dSwmobdmfmtclDc1i11+vWYVEFnxIEz4hvbgDnWSpSDT
 enb/9nRofhNUI+sX73rh/HsRzCPVrjT7SJWhBLmntijE3mz21/nHaNUpxN4ugJEy810Q
 E4u2fECxCENYqQ/s3pvg3a6czFHCZ+JhEsI8OrTsDLxxY/zWVC/JVmlD6UUCoJpHif0e
 Z+3dHLS+pvDh/2F0dYdwdmSQOsuxMb4YVKEHCi+ojOuyspvucmboQ5iUc++G/hV/EC9P
 pfMNehns1CjWivDj3eENj1pFwW0OoU/13emepseMxg35qBdai6DTWulrEuqTxfLxky9r
 41lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW196eHUILMwJCbQyewJ30FsaeUS8KgMOfRPg3diOKKczzsu8+8WTYHtw3Qf60EtMFZBGtzBGaUhrPH@nongnu.org
X-Gm-Message-State: AOJu0YwdqK5PbRtybR68WGzxmadHPLojIxbqgfWDf/OGsCVzFhgjb3WP
 MG/DuoLqmpVmHlApPf+0A8L/dfUHAk1J3xeiFtx6E+zP2Sr64+/2axGcWl95hicXEUVk7hPm1FO
 69+GW2LRloLppmv8l2cRohJMUDpuyVTl0NJJZkYzxsDx5z34f8nSs
X-Received: by 2002:a05:620a:1a1b:b0:7af:c5ca:182b with SMTP id
 af79cd13be357-7b079540ce9mr555311685a.14.1728507454936; 
 Wed, 09 Oct 2024 13:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvHR8Z1pPxm0WytztXX733W/kC5mqM7sGNcFuGX+46cbjjRB3lHQW1LTfXqg60H6q3dRHZAw==
X-Received: by 2002:a05:620a:1a1b:b0:7af:c5ca:182b with SMTP id
 af79cd13be357-7b079540ce9mr555308585a.14.1728507454627; 
 Wed, 09 Oct 2024 13:57:34 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562d7f7sm485353785a.46.2024.10.09.13.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 13:57:34 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:57:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwbuNnFCgN_vjniX@x1n>
References: <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n> <Zwbgur3d0cImLV99@x1n>
 <97268719-56f3-4d7f-aa21-c04cd0262601@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97268719-56f3-4d7f-aa21-c04cd0262601@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Wed, Oct 09, 2024 at 04:18:31PM -0400, Steven Sistare wrote:
> Yes, I am also brainstorming along these lines, looking for more gotcha's,
> but its a big design change. I don't love it so far.
> 
> These issues all creep in because of transfer mode.  Exec mode did not have this
> problem, as cpr-state is written to an in-memory file.

I understand.  Hopefully we're getting there very soon..

I still have concern on having -global used in productions, and meanwhile
it might still be challenging for handshake to work as early as cpr stage
even for later, because at least in my mind the handshake still happens in
the main migration channel (where it includes channel establishments etc,
which is not proper during cpr stage).

I don't really know whether that'll work at last..

So in my mind the previous two-steps proposal is so far the only one that
all seem to work, with no unpredictable side effects.

Said that, maybe we can still think about simpler solutions in the
following days or see others opinions, we don't need to make a decision
today, so maybe there's still better way to go.

-- 
Peter Xu


