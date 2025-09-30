Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC3ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cts-0002ow-3L; Tue, 30 Sep 2025 12:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3ctl-0002o6-St
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3cth-0007SH-2m
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759248489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxI4v0S54bGaDlWElyQOvn9DJw//p8KK1Vc6ksGL5l8=;
 b=VRnaWLJiwd1yLTdIEBrPXHyW0k7ln/4dSY3rAql5tK44MRCw+oH1cQIxR4cAKj/Z24Y/aD
 8H02Tlxei1CjFnkcWuTUgu3Ak/Rj773k/lF2V0sH2EN5R6dxfJhC12YAKfGPurGG7ES3ff
 nAr2lESoFuK5pv4fU8bNL215V3errTs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-J6hBuhvINyW7tTosz_7E2g-1; Tue, 30 Sep 2025 12:08:07 -0400
X-MC-Unique: J6hBuhvINyW7tTosz_7E2g-1
X-Mimecast-MFC-AGG-ID: J6hBuhvINyW7tTosz_7E2g_1759248486
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e1015c48c8so505021cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759248486; x=1759853286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxI4v0S54bGaDlWElyQOvn9DJw//p8KK1Vc6ksGL5l8=;
 b=s2aXvoS1UBoWa9HAOzr4ravK1+eKxbfxpceUs2p51z61muUhtW/3CrFFtyk/rGwfGg
 StNeAzbYS6hMnBVNbG3u10/cDNbLo0fTsv+dn+l7AYlEBwShkaIqm/ABHIlpZsUd2GMh
 y20a/uWW4XX5E7KAMnl/mVH7+6y8FrT1hgZtDxNL6PTKIGNJP+EsyzMkXxakQJOBLY1x
 3d7ZpB0v07SLh0p0UKuaox/PaCdUUjyeRh3TJy9zsRdoDvqeaSNPNL6440PPYNappKrs
 Q6B8NNF6Mp1WMuVPuOPpmxEtMc68sqfvEWEnaKA8p30peCTsNx6qqTtthEk/vC7yO4sC
 mTUg==
X-Gm-Message-State: AOJu0YyuWd8rws1rxAdYZAOpQM3Xo6KD7zN5CuHHs5jhqy2kuQ2RZ2Op
 rz7WR8B0ibYUSEYhDUhhyTbVPXIW2sUSJGX+BBJsVsQedztMJXOouBesPP+ty7f+1SmzxkagU47
 kIuTuCUwKYRKyq2TrRSmLLKMwZrZnaKHDyEQArQG4SAopKyxdYwVZUTLO
X-Gm-Gg: ASbGncteLf2qAHQCUCswyXDIESPWbMrGs1buhApQYhORg7KxPbSI0hVzU3DHW32XQ12
 pzSlQurO/3lYW7OKUDDrO1KTo4FkAuPimfXXuMwLpVuN80CwAO0MELUeozPcQGLZFJ4RWms78SQ
 y+kd2DdSvrrP9L0gUQNc44t/FfWefGYDdI76tT10JDNABLRa+gB9PMbuGNzmmE76q6+rPdVzRqZ
 BnGozXN5LBcGVzzVK70gMgMYaZXj6ipgXOmklPOorfIU8/vkRn8uXN5w4OUix8lnIjNvpGv66oH
 r+LC4fLfDrX9njVUEVI8WRarDeQcmY9NEFVAKQ==
X-Received: by 2002:ac8:5a54:0:b0:4d1:c31e:1cc8 with SMTP id
 d75a77b69052e-4e4062fc56emr6141151cf.22.1759248485760; 
 Tue, 30 Sep 2025 09:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8P3iFCd8fq4YjdI8dNQ3QDSGh35v348iten2iebzSOxID+4CduLfDNANsP+qBfQsovSz2vg==
X-Received: by 2002:ac8:5a54:0:b0:4d1:c31e:1cc8 with SMTP id
 d75a77b69052e-4e4062fc56emr6140461cf.22.1759248484997; 
 Tue, 30 Sep 2025 09:08:04 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11ae8d47sm99072571cf.44.2025.09.30.09.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:08:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:08:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v14 25/27] migration: Rename post_save() to
 cleanup_save() and make it void
Message-ID: <aNwAYqCPfDaYOqv8@x1.local>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
 <20250918-propagate_tpm_error-v14-25-36f11a6fb9d3@redhat.com>
 <aNrVBYf4FP82ZTha@x1.local>
 <aNtcxyvGLYVRhbuk@armenon-kvm.bengluru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNtcxyvGLYVRhbuk@armenon-kvm.bengluru.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 30, 2025 at 09:59:59AM +0530, Arun Menon wrote:
> Thank you for the review. I see it now.
> I used the --enable-rust flag to change my configuration.
> I have removed the patch and resent the series (v15)

Next time feel free to avoid the repost. I've managed the rebase which is
trivial.  I'll explicitly ask for a repost if help needed.

Thanks,

-- 
Peter Xu


