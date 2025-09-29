Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FCCAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EE0-0001Zo-0W; Mon, 29 Sep 2025 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3EDu-0001RC-7V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3EDm-0005sa-MY
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759153626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHiGRlxUobEpePdY/J4nh0RlNm3a5QbJfQGFAxVfwWM=;
 b=hhMUnHTejPstmtr+iux7+vgq4UG0kPIsJQ7MHm12eSqXqMhh+Ry8aI4HKf/m1bMvvVtU+f
 RXT1IQ0c0SPQKQD7/437zWpHO08Iz47IMcbfniPI0HIgw8W9pA+bYN7I5z3sFAh8gIQkbv
 DSR0tyem+xJpyHyR5BOwCWZ7/ZY96hQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-HDMr4pHDP0qtR6IoJ6pq7w-1; Mon, 29 Sep 2025 09:47:04 -0400
X-MC-Unique: HDMr4pHDP0qtR6IoJ6pq7w-1
X-Mimecast-MFC-AGG-ID: HDMr4pHDP0qtR6IoJ6pq7w_1759153623
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7f821f8716eso104152186d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 06:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759153623; x=1759758423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHiGRlxUobEpePdY/J4nh0RlNm3a5QbJfQGFAxVfwWM=;
 b=AoeWi2hRf6joZSwWMPM/tIN2DkaZk4MjnoC3jCuMPZD5gF4CLCzCTTjkbVeTaV69Pn
 WD1HZ0OdJiBqMisWCaIZA/gnlSTmmFqRb3WfcqRgb1JTfjGhDCxtC1mn3nlsepJ1/8Nw
 E2A69tWda7Lcm4xhNAlFFAJqhNNtwP1SK+Z5B/FK4XRU/Br+g2swgN6hca9gMzaKuccv
 emgvnCg3U5cFh3FwpoGRT23jPiO7I9myoWjpbj5zIP0spFcbryE1ccYQF7CIqWeqXzyn
 BlF2e0Up/EpN98m6j4sq8h35kkzKUZuMBwFftfinXW4yGJkN2/jzHhosOXX0w6jmIQwu
 gAAA==
X-Gm-Message-State: AOJu0YxS79DN9s0nCt1RFHAOrTfTWyqNkDnOA23qz04ikVSCROyFimz0
 n5rlbSEQJVm0FiVPA/DxoAHPzcZ2i+sbaVHvxq4ZXrIONKSvlyifegz5aHYxeinZNj1QW6V5AB0
 3M4J++ytqr2AMG9jcctlSw+CaX1AKt3X7o4WU8mUy02DYSDAwjvjtoPFW
X-Gm-Gg: ASbGnctZ8e7MmX/c2xlVgKCZWvwCXX+sQILys3fRYJpKvTrPMSDaLDSFoEgzbxjAyMp
 yQH/cqX1qSwWlHqUWsxzhJBJfY38K6FQr5ffVMkQ/UrBqRJ7mMux6By+x03u2kjVJN3VCkGluWx
 DLCAJ19zHC/OQWEE5qc0JvN/sV96aFCwKxSW/FwmBDnNyp/n4lor4UreF2keZe6Y1LY3yxUT04g
 E8umEPCpDyAv6NMi7Z4Y/Oh0IJjVC3zPBGHVPjJ/SZ0CnQD6GGNgUd6DPl9NgD/DBhh6TxIeTkV
 cZi4/0XG/XMSwisXp50INbaa642fL8HT
X-Received: by 2002:ad4:5c65:0:b0:70f:abbb:609a with SMTP id
 6a1803df08f44-869a8a9d1cemr9590446d6.19.1759153623120; 
 Mon, 29 Sep 2025 06:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUKonu9l62RbCLN7Em1aPGn94ORFtSDS6viksl+nSCOwrO2CxK9sVW79FG+yGiC7r3b9d9Ug==
X-Received: by 2002:ad4:5c65:0:b0:70f:abbb:609a with SMTP id
 6a1803df08f44-869a8a9d1cemr9589586d6.19.1759153622515; 
 Mon, 29 Sep 2025 06:47:02 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013cdf32a4sm75795376d6.21.2025.09.29.06.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 06:47:01 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:46:59 -0400
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v14 00/27] migration: propagate vTPM errors using Error
 objects
Message-ID: <aNqN05aj0CYttxd6@x1.local>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
 <aNpILAhr8LaMFbcL@armenon-kvm.bengluru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNpILAhr8LaMFbcL@armenon-kvm.bengluru.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 02:19:48PM +0530, Arun Menon wrote:
> Hi,
> Gentle ping for the series.
> Is there something more to be done to improve this before queueing it?
> TIA.

Arun, don't worry - I believe this is on Fabiano's radar.

Thanks,

-- 
Peter Xu


