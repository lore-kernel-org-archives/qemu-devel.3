Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD68C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiz0a-0007GW-TI; Fri, 14 Feb 2025 11:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiz0Z-0007G4-1x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiz0W-00068u-RH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739552259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n8Ey/Pns5MrNKQwyLOC/5wTragaY7f8w3iVyKXVQzhc=;
 b=B/UEXEHojx8Xz/TYGsPckG/3MG2jxCVSeQcSWg5SThWWBjQuuc9xRoHVLJeLRqjC7jsLpr
 y4Skexna66ZVlFqKt/5w7j8lBFZkGo+0zbIP2y3ymELPYUMIFHJGam11vJ5Pgxgb4GT3vs
 HxfQI0GHPrxY5NMziD6Gkpd4kr4xIJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-cVv55gBrMLSBDIwpvz7SQw-1; Fri, 14 Feb 2025 11:57:37 -0500
X-MC-Unique: cVv55gBrMLSBDIwpvz7SQw-1
X-Mimecast-MFC-AGG-ID: cVv55gBrMLSBDIwpvz7SQw_1739552256
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2cefb154so690255f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739552255; x=1740157055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8Ey/Pns5MrNKQwyLOC/5wTragaY7f8w3iVyKXVQzhc=;
 b=MGydEoZvKTez5g4f0r8A9bDC5atjxGQBrNDbu+7j2T4ZwgoqvPrs4E4f0RnRX7yfBR
 oLyeCLFjIVBVs6v9+hZvjO+78UIIsY6w6ixhQSTeY3138AZ/IcFxDyEf74hdH1jnEMt0
 C54JA24r9Lz+EjGZT1zJxPlGjFdBr8dJ3IL51YIOcg0teF2okjM1Dzo5rbhUtYHsCItS
 XpgkPXPiWx6fCO4yt9Wd6g/mS8V15JP6gdHNl4veJFnfpC8uadcB4EZYdBSn2CXiEJ3E
 oXW/4HoraKmfo34LeKpHVshqElKsEH+gjqTLaunVHoALDRZI94ULt6IT3HwsjyJdx0kd
 r4tg==
X-Gm-Message-State: AOJu0Yxid3xPVgeyDiwkUmRMU+F+7dXzEac9me5Mrxs7H7uPBZMmWews
 zBBpiS7gtZ3okSOLcRBDm1C2rzmH94mnlWT8OSM7EdEKO8prSSoQ78mPm79GWk0GZpyPrQQO2OG
 tgfbaB42O3IybSGyxSjm9HhlV4mP4wHAx3Z3+HReBmrO094kFFm0l
X-Gm-Gg: ASbGncuSY/ROR1Yl/D+crR8GZRH9cKd6+Ef0OTFZS7m8bcFT6bz6NO5sL6YFAt7+08y
 ad3iPvHMqLW6Lbi4hROHfdN6uWC7H/cOd+eqSA56czGvcC0hfmN6/UHVJKhLF0qR0qEywQ5DPDI
 BrDcWIN+ijsLirE+vbJ3HLWhCjXDBTkrn7AOOfxSz0iveweJhhDqKM+oXVigPVGr7uEccjM/rxq
 xesaL+T8YVq7GUAeDXiCfkGAzfToPTIrVZF55zFbOlmYPK1MAXe8tD/u0Tsp4RKFhIHsbKB
X-Received: by 2002:a5d:64e7:0:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f2ddda437mr3637161f8f.8.1739552255534; 
 Fri, 14 Feb 2025 08:57:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiky3iEXtqXSbjKh1qYccCPSxsjEdkxEixeHWQfHY66Oe+wy5wWYs1VWKHItzC9aactCIrMg==
X-Received: by 2002:a5d:64e7:0:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f2ddda437mr3637131f8f.8.1739552255169; 
 Fri, 14 Feb 2025 08:57:35 -0800 (PST)
Received: from fedora ([37.166.73.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5d8bsm5068561f8f.70.2025.02.14.08.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:57:34 -0800 (PST)
Date: Fri, 14 Feb 2025 17:56:43 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Message-ID: <Z691yyvLc0zadeFr@fedora>
References: <20250213132513.767709-1-mvaralar@redhat.com>
 <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
 <CAGxU2F4Jzi+16Z_JKjhQREJ2FBGPOHheLhSoCOJ=6O-XL+k1NA@mail.gmail.com>
 <CAGxU2F5FWUN8rU-cr9wZyEJBtGH7a8Wd1SQC-1_93G8zifM4aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5FWUN8rU-cr9wZyEJBtGH7a8Wd1SQC-1_93G8zifM4aA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 13, 2025 at 05:22:22PM +0100, Stefano Garzarella wrote:
> On Thu, 13 Feb 2025 at 16:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > Unrelated to this patch, but since we are talking about
> > VIRTIO_SND_F_CTLS, I think it would be good to send a patch to Linux to
> > make it clear that `controls` depends on VIRTIO_SND_F_CTLS.
> 
> Patch posted here:
> https://lore.kernel.org/virtualization/20250213161825.139952-1-sgarzare@redhat.com/T/#u
> 
> Stefano

Thanks!


