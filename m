Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7FEC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfisA-0005pw-Cc; Wed, 05 Feb 2025 12:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfiry-0005m8-O9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfirw-00053w-4I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738775237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+OLTbGqj/iIpCK8/1CkoJoVzjfpKlls86EfJDj73zs=;
 b=dk4PLvEq8BFyT0NOSqlo1edr+OQooIYMhfuX+FFDt5VKoxR5y37ZYqF2YUlR0CnZTnRtnU
 mOg+zTNBdaxhcChtWat1v8hM3JV8dJAo13GW98Z6bF8Ir6cd6AJt25CoXsicy9lp8iDOcM
 srm/AxtC/xcWjeOnmeU7KwQ2IdGXmJE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-2DH8HkmpNea1bhIWyUnETw-1; Wed, 05 Feb 2025 12:07:15 -0500
X-MC-Unique: 2DH8HkmpNea1bhIWyUnETw-1
X-Mimecast-MFC-AGG-ID: 2DH8HkmpNea1bhIWyUnETw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso594421cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738775234; x=1739380034;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p+OLTbGqj/iIpCK8/1CkoJoVzjfpKlls86EfJDj73zs=;
 b=UWrpOpHGYUHG5qfKvgYgb8Ci2LvHSyhWBMCpeac4UFaHc/cK9bsWhw9c1Zxqj6gQow
 wuG5P7dFgmpqYizLiuUtzOLRKpuKH/qzrh2N2wuxH6D3FPr79aoohlUNQNcqvJC3dETj
 4MFl6RBtoiye11ugyQFPxf7Lvbsqe5J4vDiaEsugp0Xl3oLoXDh+HZ24MRSHlSMyeZWb
 NuYvGAjpVOQJJbM6eDki4KjJ2sxliMIcvpZT+JABYu4Mxe/Enyk6/3eiAix7CbeLYz9I
 MJLdLG/PeCF8BnHk8skxNl3oeyitHiST0giydzKdJuPZu/T2n6QKn5LeEfOItKG0Hy8A
 IeIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHMNEOZQXEW6hhcR5zINC7voc205SiXiuloNO/RvbmfcB0Whr+5uMX8vbfVmF0o68z2wXp6NOBSjeM@nongnu.org
X-Gm-Message-State: AOJu0YzU/Wo4eG3GLCFdZge2QIv1vrEkthHGpLRwc3y55Zq4+7MSnusl
 563UCUnpAG2nrV647+t0gRcieVXabfQBVJdA2uAK8LbBAoiQAjnEB0Xp4upZy8q73FKoOD2LSit
 BC5bSneD5MHPd0W5FcqainEg9R4e/qq3BpU+CbigFnyHQFrEaebox
X-Gm-Gg: ASbGncsbmLTAU7mpmiXhMIf86jw8Pd4bm8nJEHLgdydUpIP9PT+En9xGR5S2ZJD6HJj
 s2w+Rm3YvuFy3/9PsE1SF5fqfBLoqqBbMvhmWoI9efxMIuf2H6Qdo/MKMza++t0wO/nZ2fhwuRu
 Kf++/w3dLbRUhtCmgRtthrck/u1HKwJVkfP/rvC+4Zk8Xx7z9rmmVBSyb/R67ByWZg4fRioKoMo
 1cl4ZhmtRTa+iUE/ngSvHTg2ga1f50AHE6+jd1YUa+dOEZlnNtE3K7+IoiyiiR7t64bz0Wt4o0L
 Pa9dHKMD3j7q5qF3RhCvhiYvf7YxVVqi5OgBVM0Mc5CxojKS
X-Received: by 2002:a05:622a:1209:b0:46c:791f:bf56 with SMTP id
 d75a77b69052e-47028165422mr48419621cf.1.1738775233118; 
 Wed, 05 Feb 2025 09:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNGLRnYZoS1UgT/2Mlhu7VtZTHtccZq6PiOeVKuWhKLh5AjDf5uPjAXZsK81s9NHRvVVzhpQ==
X-Received: by 2002:a05:622a:1209:b0:46c:791f:bf56 with SMTP id
 d75a77b69052e-47028165422mr48419311cf.1.1738775232822; 
 Wed, 05 Feb 2025 09:07:12 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a74c6sm72351171cf.6.2025.02.05.09.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:07:12 -0800 (PST)
Date: Wed, 5 Feb 2025 12:07:06 -0500
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 3/6] accel/kvm: Report the loss of a large memory page
Message-ID: <Z6Oaukumli1eIEDB@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-4-william.roche@oracle.com>
 <Z6JH_OyppIA7WFjk@x1.local>
 <3f3ebbe8-be97-4827-a8c5-6777dea08707@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f3ebbe8-be97-4827-a8c5-6777dea08707@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 05, 2025 at 05:27:13PM +0100, William Roche wrote:
> On 2/4/25 18:01, Peter Xu wrote:
> > On Sat, Feb 01, 2025 at 09:57:23AM +0000, “William Roche wrote:
> > > From: William Roche <william.roche@oracle.com>
> > > 
> > > In case of a large page impacted by a memory error, provide an
> > > information about the impacted large page before the memory
> > > error injection message.
> > > 
> > > This message would also appear on ras enabled ARM platforms, with
> > > the introduction of an x86 similar error injection message.
> > > 
> > > In the case of a large page impacted, we now report:
> > > Memory Error on large page from <backend>:<address>+<fd_offset> +<page_size>
> > > 
> > > The +<fd_offset> information is only provided with a file backend.
> > > 
> > > Signed-off-by: William Roche <william.roche@oracle.com>
> > 
> > This is still pretty kvm / arch relevant patch that needs some reviews.
> > 
> > I wonder do we really need this - we could fetch ramblock mapping
> > (e.g. hwaddr -> HVA) via HMP "info ramblock", and also dmesg shows process
> > ID + VA.  IIUC we have all below info already as long as we do some math
> > based on above.  Would that work too?
> 
> The HMP command "info ramblock" is implemented with the ram_block_format()
> function which returns a message buffer built with a string for each
> ramblock (protected by the RCU_READ_LOCK_GUARD). Our new function copies a
> struct with the necessary information.
> 
> Relaying on the buffer format to retrieve the information doesn't seem
> reasonable, and more importantly, this buffer doesn't provide all the needed
> data, like fd and fd_offset.
> 
> I would say that ram_block_format() and qemu_ram_block_info_from_addr()
> serve 2 different goals.
> 
> (a reimplementation of ram_block_format() with an adapted version of
> qemu_ram_block_info_from_addr() taking the extra information needed could be
> doable for example, but may not be worth doing for now)

IIUC admin should be aware of fd_offset because the admin should be fully
aware of the start offset of FDs to specify in qemu cmdlines, or in
Libvirt. But yes, we can always add fd_offset into ram_block_format() if
it's helpful.

Besides, the existing issues on this patch:

  - From outcome of this patch, it introduces one ramblock API (which is ok
    to me, so far), to do some error_report()s.  It looks pretty much for
    debugging rather than something serious (e.g. report via QMP queries,
    QMP events etc.).  From debug POV, I still don't see why this is
    needed.. per discussed above.

  - From merge POV, this patch isn't a pure memory change, so I'll need to
    get ack from other maintainers, at least that should be how it works..

I feel like when hwpoison becomes a serious topic, we need some more
serious reporting facility than error reports.  So that we could have this
as separate topic to be revisited.  It might speed up your prior patches
from not being blocked on this.

Thanks,

-- 
Peter Xu


