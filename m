Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1868BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 20:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRXm-0005fT-5f; Thu, 02 Jan 2025 15:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRXk-0005dD-TR
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRXi-0000wE-M7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735848701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pl5TsMFLQrs7FwVBQw4tRlr+ep80xGOikLwpQqL1STg=;
 b=hGGDEOspuzhilQZTfdYI8+uK2Rbj+zp95GSpBoo0NG6Dqo8zpf9mUkYcEvrrqjz+k6/KCG
 kzkt90iK2/4YOOoE4D+aDDv1ylL3sL4wNAUh6INe4JiD+sE+zWtzNfm/Mo+0VIPJES5zCS
 rmMIEhdHGGM+ZBLSmPvnJwdwncHups0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-6PL95iTZNDyw1j3I4TuWNg-1; Thu, 02 Jan 2025 15:11:37 -0500
X-MC-Unique: 6PL95iTZNDyw1j3I4TuWNg-1
X-Mimecast-MFC-AGG-ID: 6PL95iTZNDyw1j3I4TuWNg
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88833dffcso157155606d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 12:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735848697; x=1736453497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl5TsMFLQrs7FwVBQw4tRlr+ep80xGOikLwpQqL1STg=;
 b=hy5tmgwT5ENd/zypgXCUjCwiETOtvPFPJ2OTZtIfYsuN0rATo4eKD8Fg6630j5I4Oj
 jOZIf8VfGIAt7VJkpT1yiXOMa4ne2OIgmhJcZ9dbkPvrxkX+B/e/GabVWwqTG4SqW0+f
 yVClNw5v7YOuoo7LzZpcVv1r0+ZK2zN1UcnRtY36Emjjj744PqS6c14jwIEuClcuJuR0
 IdumeONCXCf8CjhmreHtTNhWMDZ0Y72Vdl3WYyHWFpbjGUfDt9vJV1P0wB+GsPj8Zo6+
 dX/EyrVKAd2kRwchlSUvZlaDDCE64J5RLGIBl+Oi+Sp3vMBMIeUMJXVuuolIHYnktheu
 sYkA==
X-Gm-Message-State: AOJu0YzAjK7OUZ1RwvtZdLJszcEHB3WB+AyhCSpPTZiLCiMtxsruNdvq
 9rWItb+4UK6mgnpV0owocC4Ho6FZihTZjAxtu0N5hDwVq3NPXAXoQS7BAuZ85cXFZz5U+B1Jmae
 SkBFO2vTiyh960RDmyvWoO1AVtqdCJ2JXHz458A41nKGBgV+oiZTP
X-Gm-Gg: ASbGnctDbAsczAJiRLCkdMIag+968xQOGdTl5hVPqNhM59WiDdijZw835UdM6B4z5hy
 IWB220X6oV4VqDfYQhTjFZi5g2V0bwtSDbJf0CKUL3CST28mmEx+eu/LV3j8KqFtdT/gvmY7IGQ
 2qxdpITkes5hITaJ6MgpauB3G4OPo5+Cz9cWSNplDUygOXr4mrggWqDPMVNRKeOpTHlkaon3QFQ
 PIegE0Aluy+7+MbieabOaNWEL8R8dsYSZXRuEPnWHkCNs6LsTCTDt5qwbWxgmcRXUQogGz+9dwx
 /5WkFvKUPyA7+IH48w==
X-Received: by 2002:a05:6214:2522:b0:6d4:1813:1f20 with SMTP id
 6a1803df08f44-6dd2330b0b2mr695074426d6.8.1735848697076; 
 Thu, 02 Jan 2025 12:11:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeUqMfFVfo7BDlocMeVvP4XuSvD7GQ6iD3KloslOkThmNnIPJIk/IHuc3fzBqp9UEnWIT/ww==
X-Received: by 2002:a05:6214:2522:b0:6d4:1813:1f20 with SMTP id
 6a1803df08f44-6dd2330b0b2mr695074246d6.8.1735848696816; 
 Thu, 02 Jan 2025 12:11:36 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1820810dsm131877556d6.131.2025.01.02.12.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 12:11:36 -0800 (PST)
Date: Thu, 2 Jan 2025 15:11:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
Message-ID: <Z3by9g8Y-bvMv8xW@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
 <Z2sTHg-t0wB4g3Mh@x1n> <Z2sUO7OoX7UK-DPY@x1n>
 <b8651ab0-2181-4bbd-8166-7e47827ad927@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8651ab0-2181-4bbd-8166-7e47827ad927@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 02, 2025 at 01:35:22PM -0500, Steven Sistare wrote:
> > > > +    MigrateCommon args = {
> > > > +        .start.opts_source = opts,
> > > > +        .start.opts_target = opts_target,
> > > > +        .start.defer_target_connect = true,
> > 
> > One more comment: maybe we can even drop defer_target_connect.  I don't
> > expect any non-cpr test to use it.. so introducing the parameter may only
> > complicate MigrateCommon struct with almost zero benefit to be reused.
> > 
> > If to drop it, we could detect "cpr" channel in test_precopy_common() and
> > only defer the connection if "cpr" channel is present.
> 
> I hear you regarding lack of reuse, but I still think defining this single
> field is the cleanest solution. It is tested in multiple places, in different
> functions, so the search for cpr channel code would also be needed in multiple
> places.

OK, let's keep it.

-- 
Peter Xu


