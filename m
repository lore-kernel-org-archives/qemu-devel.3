Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26789C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuX59-0004Z5-74; Tue, 18 Mar 2025 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tuX4f-0004U0-Ct
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tuX4Z-0001kM-T5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742304810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XRMFaywHkUgZjgWxsIgNg/5NknuAD0zH1QiwA9YwmPU=;
 b=HSxtmjTtK5hUUXW/k7FmNnOSU3vCbhGuV0PKo+j8BdKVkgUmLH+R9Rb5U3yIPYZFNYuPQ9
 Eo3K9W4gY3DV6mLzgwFsVLWoCyphr3tpoDWWhjWBHfJkdkHWMLKxQF2D3Y+vFKuqXrH+xL
 2Oc1Ja/kDZBnfloh+Kx3s+wsfJjksuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-R8US7i6FPR2ZbbjeQvWSdw-1; Tue, 18 Mar 2025 09:33:29 -0400
X-MC-Unique: R8US7i6FPR2ZbbjeQvWSdw-1
X-Mimecast-MFC-AGG-ID: R8US7i6FPR2ZbbjeQvWSdw_1742304808
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso18930135e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 06:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742304808; x=1742909608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRMFaywHkUgZjgWxsIgNg/5NknuAD0zH1QiwA9YwmPU=;
 b=IPoxwtRhTYeTbAFe9maMsP+LM9YAfw20zRD+NcakW9Fr9Mb+QJL9btse/bq/FPsD+C
 rt2xLZ9TgfbJr31kz1H/zhsUP7IzU96InQ4QLWHMQTYrjj9lQ6nxtWyqTzl2rJXKhwT4
 9i+yWrrPz0QTiVCOKIIYEa+inDF63TjmNzVyuoWTVuMIQHmFgG6Nl5GNDPBm9Udt+sTL
 EsSRNu2YoYHVb7AuvdnFWwRUpHosPB7k5HkhNQGfnCY4mtIG7KelPNHGWWZXDxZ4X/jf
 44EUtb3GnkGbI5KP1zh3ojMvZ2onbBy2DC95B+KbYlvnET41COW1qQccQRlDgNRhZggp
 S0kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI0+6mpKbVjwMgMZIkLJEopzavZJcgeK27DqfjU8lM6lUXwV/RM5o7nNVjdu+wPzCBwKgia7VUbM3Y@nongnu.org
X-Gm-Message-State: AOJu0YzXDm/u0ot+uFJrCoCJi/2ad/BRl+PHdWaYTxirODKIJS+FPTmc
 eEoYV86JnYoxbMgvDRg7QFtviTzY5WcGP37qX7n1OGwmm56Od57ghQwm5Urmi1+PHmyYCkhq0/a
 K+/cBq5slqOJBJA7AkZvN6ecCJIp/z2kTqDHnT9kuzg0RHhE0AnPm
X-Gm-Gg: ASbGnct5yfnYHr0CZqdg06vUD/83N2wKekq9IGiH/viI+39U2HTUwTpMqhqzPO2OPY/
 VKIvyfrC+kPzWVCbXK5foZ7Wtq4oBuIehU69+yjDYM2LpoTlN6skHhF19DkDGq1/V3xFSMTnzhk
 4EWwYbRSFtDmt3ySpS0o5ztIJveOyun7qD+KEThPBe8LmPW82CdEpp+UEynNwFaIHx2nGb8lfab
 g9e59vnJL41LLq8//FkMf0DUPLv/Jg1Dxk+SL90s0JTrp7sECLSe7r9joVgvKg+DavXMHRSpuN6
 e3O7poPtQA==
X-Received: by 2002:a05:600c:3584:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43d3b99acd2mr27493185e9.15.1742304808442; 
 Tue, 18 Mar 2025 06:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT9PnpzlMOtLxrtRgTXtJdZqQw0MpqpU7AcJ75deeJcmE+pRmq7azC89nEGQhS1fJaCRlR7A==
X-Received: by 2002:a05:600c:3584:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43d3b99acd2mr27492865e9.15.1742304808035; 
 Tue, 18 Mar 2025 06:33:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fad4dsm135990145e9.29.2025.03.18.06.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:33:27 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:33:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
Message-ID: <20250318093227-mutt-send-email-mst@kernel.org>
References: <20250220065326.312596-1-anisinha@redhat.com>
 <004396c0-8370-4015-b746-3c800f45984f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004396c0-8370-4015-b746-3c800f45984f@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 18, 2025 at 12:01:44PM +0100, Paolo Bonzini wrote:
> On 2/20/25 07:53, Ani Sinha wrote:
> > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > introduced 'default_cpu_version' for PCMachineClass. This created three
> > categories of CPU models:
> >   - Most unversioned CPU models would use version 1 by default.
> >   - For machines 4.0.1 and older that do not support cpu model aliases, a
> >     special default_cpu_version value of CPU_VERSION_LEGACY is used.
> >   - It was thought that future machines would use the latest value of cpu
> >     versions corresponding to default_cpu_version value of
> >     CPU_VERSION_LATEST [1].
> > 
> > All pc machines still use the default cpu version of 1 for
> > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > changes with time.
> 
> Personally I believe this is a problem and I'd rather use CPU_VERSION_LATEST
> for the unversioned pc and q35 models, just like microvm does.

I don't object.

> Unversioned models change the hardware properties and there's no reason for
> CPU properties to be treated differently.  Unversioned models are exactly
> for when you are okay with a moving target.
> 
> And independent of this, microvm could start having versioned variants, so
> that pc and q35 work the same way.
> 
> Paolo
> 


