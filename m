Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3S0f-00049C-5x; Tue, 30 Sep 2025 00:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3S0X-00048I-8r
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3S0M-00058T-T5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+LqonD0/HCiXJZZoK2MbnvXOiV77+i2qyKMAxOY8H1s=;
 b=WpY1l/ObY8uTUAxK8z+pwlnOtrmOYKfmWjM7n1Y/L0Ls1oqoA9i44gfS7gUZ4tOc4AGV3f
 jne64vk33kRlG2pRNcZ/MRiqRbTs3Hi036u62McSTUV+vQRdiIB/757fFptlNo5c/WrmkG
 iPuEsrWwx+q2iN3kkT6vTWBfMKUe/Hs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ypfHe23zN2i5N7MDbcAiqw-1; Tue, 30 Sep 2025 00:30:14 -0400
X-MC-Unique: ypfHe23zN2i5N7MDbcAiqw-1
X-Mimecast-MFC-AGG-ID: ypfHe23zN2i5N7MDbcAiqw_1759206613
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-28c58e009d1so24548015ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206613; x=1759811413;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LqonD0/HCiXJZZoK2MbnvXOiV77+i2qyKMAxOY8H1s=;
 b=uWL2obze8RyJ4iKNYa1R4dhp2N15HW5HdKfKE/vRftUiCUvV2j2p6XInvoMxiF0SmU
 z74PA1/LHoLG38cm4P+56R0jJjO2qhMpDlqn06LzQfiWMBX+6hwZN5kpogNSktKBg6ji
 t/qzVMIbfyL/eYMr4n68ioi8OzGupKED8kgCT+nsBAyb9wE6QYaNncVb0m6aFnYaAgOS
 AvZICxmlvApehwzIBtnKcy+vdUR09GYUg5/1b1w5tadQsEOreG6a9qv1bfpDCMn0bmFK
 Va3n4/IUsnXql4XEZnwLCcDxJcjrfHf/PqXPvgAq02bAIR7jpVSViw9Az4VgQaE4FD/3
 wJWw==
X-Gm-Message-State: AOJu0YyB/Fn+BchR4/vazysfz1nwE8RjsmZnIGc2huO10EWOYQIZfNdj
 KeS/6i/cWq5Qqrikv/9q9T+X6Ox0hi/b059zxz5FOqQQYlzu8m2RT1P5974anWVIxG20vQc0cDM
 GqmSM5mpRr+fDXWpQKBhXUjM7d0ApzLfSyUX6UDcQ7dfecnnrtH0quGLV
X-Gm-Gg: ASbGnctl7usEJOtOWNP+5M/m0isXOdaEm2ZR4p7VvfEBr9vVV96JtND6DrnVYs+LXMJ
 OvXSVQ+SdOVhA9a3fManklN0tj7rWiJWDQqwAcma3T1WVisPwf36WOwMYFqfNTmlOQi/8EPhiWs
 IuJJ/GjKrKkjxkas1jt5yclSq/43DkPxIjbNc08muMB+fJ7REkpMWLqLfQc6K3KjW4zBhF49/EM
 EUWt3I+8nz+lHxu0fcOjr9NLMLXjZt9bQfdol+T5O0gwC9Sh5hZGd6W5JWBlkCrtP3VrXauojUZ
 VZVlJLm3/4TAoq8I2MXaYdCvQPXZHJ2VWpIMPTHePiSFL/Akknm03xYjVQ==
X-Received: by 2002:a17:903:1987:b0:262:cd8c:bfa8 with SMTP id
 d9443c01a7336-27ed4a30d0amr201454985ad.34.1759206613478; 
 Mon, 29 Sep 2025 21:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETph3GxRYCkEA5q0TWxFeBpKgDD3bfp0ZO3Qs4HitCeSiE81rRNd9iKRLyxPJv/KD46yZfVQ==
X-Received: by 2002:a17:903:1987:b0:262:cd8c:bfa8 with SMTP id
 d9443c01a7336-27ed4a30d0amr201454595ad.34.1759206613053; 
 Mon, 29 Sep 2025 21:30:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ab74fasm143945025ad.132.2025.09.29.21.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:30:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:59:59 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v14 25/27] migration: Rename post_save() to
 cleanup_save() and make it void
Message-ID: <aNtcxyvGLYVRhbuk@armenon-kvm.bengluru.csb>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
 <20250918-propagate_tpm_error-v14-25-36f11a6fb9d3@redhat.com>
 <aNrVBYf4FP82ZTha@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNrVBYf4FP82ZTha@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On Mon, Sep 29, 2025 at 02:50:45PM -0400, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 08:53:42PM +0530, Arun Menon wrote:
> > The post_save() function call is responsible for cleaning up resources
> > after the device state has been saved.
> > Currently it is infallible, and does not return an error.
> > 
> > It is called regardless of whether there is a preceding error from
> > save or subsection save. That is, save and post_save() together are
> > considered to be an atomic logical operation.
> > 
> > It should not be confused as a counterpart of the post_load() function
> > because post_load() does some sanity checks and returns an error if it
> > fails. This commit, therefore, renames post_save() to cleanup_save()
> > and makes it a void function.
> > 
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> 
> I'll need to drop this one patch because it breaks Rust.  Please feel free
> to send it separately or just leave post_save() as-is for now.

Thank you for the review. I see it now.
I used the --enable-rust flag to change my configuration.
I have removed the patch and resent the series (v15)

> 
> PS: IMHO post_save() is still a good name to me, pairing well with
> pre_save() and all *_load*() functions too.  Dropping the retval should
> already imply it cannot fail with/without a name change (and also because
> modules can do more than "cleanups" in post_save()..).

Yes, for now I have kept things as is because we do not essentially need
to do something to the existing post_save() call; the dropping of return value can
be looked into in a future patch. Thank you.

> 
> -- 
> Peter Xu
> 

Regards,
Arun Menon


