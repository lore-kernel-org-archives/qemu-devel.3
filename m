Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE8DC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjpE-0006MD-K5; Wed, 07 May 2025 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCjpA-00067D-Pr
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCjp4-0004xj-Lx
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746643727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gvCar0xROiw1iU5Yy0nYM9lHzXpN822daM0uYf6JOLg=;
 b=NljT3t958V9ee2bH3H/axOykZth1DTSPegvczlI+7JaklulXWgXfw1/Nmc6z2AJBrL9kQJ
 gK2tAfOop46ktDBiU3v7EwLjeGA9a7STWo/syNcbxdIYadf8e1FlxonkEtJh5/7alonST0
 UHll464Y49V+evyelCXOZs7VINq/Ywk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-NkkuktY1OpOyt_Ndx4nwdg-1; Wed, 07 May 2025 14:48:46 -0400
X-MC-Unique: NkkuktY1OpOyt_Ndx4nwdg-1
X-Mimecast-MFC-AGG-ID: NkkuktY1OpOyt_Ndx4nwdg_1746643726
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3d93e2ac7fbso2234765ab.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746643725; x=1747248525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvCar0xROiw1iU5Yy0nYM9lHzXpN822daM0uYf6JOLg=;
 b=sn9kG95yioCqL8N5v2+WG/7QGyJuO5N05VEo8XNq8BQPDciSPNknttJHm3mdRyIK8K
 nl6uGGLGzPPcbFleoHCM2+qEubBIRDKeQnDyMaTCoqhbmaYj+Whvd1aSXvK/feIN9CXv
 lttUZCjXg4+dTCVmjgnky4Ornic17Q6MqmjkFhpD7cZF/xKuE8/eUV2m+UWQuCHP3zJI
 oKtKhGi70qgzcp7TR5B1C89xIjTI6I6opuOL4u7dnKrJN87K3sw2x0Idn+fNOagd4lk2
 YI3xgvU9NivDKsolJ2tGgW3D60w5wTvwGXLZsL0zlvBnk05Y/ukTXk+V8hKb2JjoPMVt
 e6YQ==
X-Gm-Message-State: AOJu0YxQ9cOL74CnRg+eAUTYMldlGPlZ9R2rL2KSU6O0DoeWA7lU55xG
 ipata3bA8rdttMv52LQUgSOBxKv7YtxXupWcfWh/0VJzyqasWAtf9TuBgk523jFte8U9Wgjja2p
 B2XsQjx+U078gX53Erj1Rczs4goSxpb9Q+H7MoHI9Ntd4AksaMXUoOBL1w5xf
X-Gm-Gg: ASbGncvVCy0uur147PWCx5UXh/2hxCdVyuDzFGiVe6s7nWl6QniTJxJOonYaKBXt7ul
 XqCZdk/WnmzqqmIAEc/xttbxhzOLbyUmpn3LbTsWEhxVJMbHbsh+RBsoOKAQYjeoPxG8cDxuNpC
 FRxSZCMqKnbtQBn8hlWcN3Eo6H9Wx4iIdQpn9G1iH4oNvWHIofXQT9+jbprWfyiMoPpHGs68LWK
 6HHoLE0zgPm5iSEGgHPnEjrkxwAmdp11wXD85N5F2a0weZ50N/Szr2ZR/Y3nhyShH2QHNJ/5c2N
 xho=
X-Received: by 2002:a05:6e02:1d93:b0:3d4:3db1:77ae with SMTP id
 e9e14a558f8ab-3da7392d0a4mr56416725ab.18.1746643725067; 
 Wed, 07 May 2025 11:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRnAnmf2kVSII8hObbke+fRmUVXYCsiqbzcPebeNHljAP4HQsaAOCAtSrpM3g6SHV11CipeA==
X-Received: by 2002:ac8:7c50:0:b0:48d:c8fc:b21f with SMTP id
 d75a77b69052e-4922574deabmr56938571cf.11.1746643714095; 
 Wed, 07 May 2025 11:48:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-49221270288sm18206781cf.24.2025.05.07.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 11:48:33 -0700 (PDT)
Date: Wed, 7 May 2025 14:48:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] ci: Re-enable python subtests in qtest migration suite
Message-ID: <aBuq_zZb12cGdVmW@x1.local>
References: <20250507155835.31074-1-farosas@suse.de>
 <20250507155835.31074-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507155835.31074-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 07, 2025 at 12:58:33PM -0300, Fabiano Rosas wrote:
> The migration compatibility tests have been running with the PYTHON
> variable unset to avoid running a broken test. The faulty test has
> since been removed, so we can enable the python tests once again.
> 
> Aside from the broken test, only one other test uses python and I have
> been running it locally ever since, so this commit should not expose
> any new bug.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


