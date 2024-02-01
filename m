Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D41C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVTvF-00059L-1g; Thu, 01 Feb 2024 05:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVTuQ-0004Qk-Kn
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVTuP-0007Ar-7B
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706781780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZew4YVwq0m+V5pewsZsSDxudIYM6j0emY5beWaKMrs=;
 b=ZVH5ryUFOvdAmBBPDzr8bbcAv3x9N+C3H4KcF5D9U19hkAvmj+PR+AuennfLn/foO8HOVn
 fwA+/52mmIEJVRTTsJjFBTVu8QODrA7DqObpzoeAF1s8AlypO9RWKwjD82ldevivg2lSFn
 2uQleZtCp4nXSmwJEKHNbEIJZAZxUNo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-L5cB6PBVN1GA3fWQOo5z3Q-1; Thu, 01 Feb 2024 05:02:57 -0500
X-MC-Unique: L5cB6PBVN1GA3fWQOo5z3Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so207474a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706781776; x=1707386576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZew4YVwq0m+V5pewsZsSDxudIYM6j0emY5beWaKMrs=;
 b=VTq7fTwT/3rzNIlOm/xx7mwqM4GcCxXLGDfLHXtKrRZWuWKvKc/Nfed3NnebGhUA8P
 9rMo+3UWG7BDXHX8Xeh4P6JZAjWK3aS2+IcaPx3ng4t+zXEhzGgt+omHtuUh4EcdzAQh
 ev09EmIkhw10zIXCsIndw9bwJPbXfyHinM1WT+pt5A7q3t7kn1YXcInhxNBsx5ORRDkO
 aFNlqVFOuWkQXgxz4KzreWAvfuYUw5+WYQeamRK2Sv1dHE01eg7sgETfkoUGqrlyxCQt
 raVaBSHKR7SMGuGRbLlUE5ghzOJdWTYxNwUvTbvakJN+OCNrHGbo8kOwn5suiLt3xBZO
 N98A==
X-Gm-Message-State: AOJu0YzjCC5J1AiSAjpA9GaM3UMI0efrjFYL3sbj3mBblCew9Z07u14a
 zUY8dSG65upcyjl6g0wEt885JthbMHIJ+/MZC9O+J1Cg9x4qe0qju4st8whEjKouHhW35HPXA4e
 7FoSO/fQM38QvUxR5CP8bOKPSdp5CUrDiks9RfJmBJsZ/HsVhFbhE
X-Received: by 2002:a05:6a21:789c:b0:19e:3a9f:7e37 with SMTP id
 bf28-20020a056a21789c00b0019e3a9f7e37mr2327936pzc.0.1706781776227; 
 Thu, 01 Feb 2024 02:02:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1c6l8LNXs8uAc5c7yXcE96+jgWjoFlSqM24X6M3oZfsbl9hxrz9knBvTMbX1njU6o79Gkyg==
X-Received: by 2002:a05:6a21:789c:b0:19e:3a9f:7e37 with SMTP id
 bf28-20020a056a21789c00b0019e3a9f7e37mr2327906pzc.0.1706781775534; 
 Thu, 01 Feb 2024 02:02:55 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXV2jbl2WDBuZh61QeCLWLls86epgYeAlpaFIioCyhp465Zuwe51wfIenTy9Ny8LvfnZ47uwNj3uqgbJ/EjifuqLNKvQ3s5moeMKnS7oFmqGW80xsoyanv98w6TWVOZ0jbgXcoEp6BkyMpGD7nzKCFlv9cTI/lFpLzSIhQ9A3CRtOy/0Sr7NepDDYgmg1Vyl4IGYjlKRdxCRFSiLyslAPg=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 hq4-20020a056a00680400b006ddc71607a7sm11500241pfb.191.2024.02.01.02.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:02:55 -0800 (PST)
Date: Thu, 1 Feb 2024 18:02:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 12/14] migration/multifd: multifd_send_prepare_header()
Message-ID: <ZbtsSElMkRWoAMgZ@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-13-peterx@redhat.com>
 <87a5oljiih.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5oljiih.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Wed, Jan 31, 2024 at 06:32:54PM -0300, Fabiano Rosas wrote:
> > +            if (!use_zero_copy_send) {
> > +                /*
> > +                 * Only !zero_copy needs the header in IOV; zerocopy will
> > +                 * send it separately.
> 
> Could use the same spelling for both mentions to zero copy.

Will do.

-- 
Peter Xu


