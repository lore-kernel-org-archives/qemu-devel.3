Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF30C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZycQ-0002CO-Gl; Mon, 20 Jan 2025 15:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZycP-0002BJ-9m
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZycN-0003sb-7z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737405809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEJylaPC9UjGUo5+ufQ7hbk2ePW92RAHA8rV0SRsPDk=;
 b=a960CqV9fV7POgXpOFew1hvT4wJEmRQGMCEAGW5CWWW4WMPzsucCpVvud02Ai+fD6iWLy7
 bBCFQtoMKPdBRAVlDt82ZmzbUnKyaOKjOwDZMD2oV981Pxj2J72fJt+LCG8h8nqYYrAF42
 RFLoFUXKInB/BePzIgwhVINNP++CDvI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-maNhP4ZyN2K_LXhQ2puu3w-1; Mon, 20 Jan 2025 15:43:26 -0500
X-MC-Unique: maNhP4ZyN2K_LXhQ2puu3w-1
X-Mimecast-MFC-AGG-ID: maNhP4ZyN2K_LXhQ2puu3w
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4679aeb21e6so84648001cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405806; x=1738010606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEJylaPC9UjGUo5+ufQ7hbk2ePW92RAHA8rV0SRsPDk=;
 b=ZoGpuoICgSFiXOkG34N0htebU5lVLXxQxGQQmsXq+z0qyzyx8l6cJZUPuUnVAieELq
 rl2zvoDDL6djylNscqZd3/pyxt7rRevAFW+eJ0/4vnu792z14spxPEKmO0/U+axmUTls
 bpTemFwg7Kobat7h5rGC6iSxvLaOX1MKtW3OLWlJHz4KMMzW6yRCIrV/3oiKVn1mIjRS
 UkXHUgU+C1CdmE8MM87hWqS1rhQ9IyCO2obGu6LEIEeK9CSl5OzgjeraHFBon1+FSe8u
 OiiKKjvONSMpYUFppRCPGGeDHfXs4l+Ur663ufXWVTBHET0DMU62khHzYaS3bvVniIeN
 mFNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy4Aud9Nh6LSxlx/86qgWKQiqKB3wsRmW/QpEtINzhRYlhEcbixJ+pd5hYgPA9+5RASwSWsKmDbn/z@nongnu.org
X-Gm-Message-State: AOJu0Ywrp3g41g/u0QD75gJ8lRp7jyTAi6aB00Fqc8aPRuMBue92Tay6
 ZeMrQsDVFjpRVzvlDJrXrCmQodSUS8SPWjDXFDEteU/i2XhUNQN976bP6nYRBEgwP3yZpczpqNu
 C/YQ0w1lA4DDI7avp2pYtNXCOWpQTVmhz4RkAyaI2FQ14W+jEX4DJ
X-Gm-Gg: ASbGncvYZ8wUzoBTE8/rvA7xgl9O6pf0ePj/pGuuNqD4Mtc8x+w6VG2GLvBMNBKsIoq
 xChGJzj5OYBFt5olGrueKzD7kjfRGy9SW4sT8x/PPzz3S4lPakUYVIG/JRiE+EaKD+NjD5FNMiD
 Y3d5kyxi2hFMb1W8Q+1ZeELRJdYqWK2SiLBMc6jB5gwCAwiwgiwTi3b/jXG7ZbSm50ooJ4gSRKR
 FEZ0NczgXaoUBLTjU87Y7v8TC0ICAKyzsFecaM6CQ8BAxUR6DCkXhdma3ZWg6ZG42WokWOyzotM
 byS4l1GAZmV0MFeYsFWy/vGUbslpVFw=
X-Received: by 2002:ac8:5a55:0:b0:467:6692:c18b with SMTP id
 d75a77b69052e-46e12a25294mr200228151cf.5.1737405806434; 
 Mon, 20 Jan 2025 12:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+0kxEQTVD7cvUOES4l7LypBoFpfOst7eFJHArF7ULbk4HIdLxucWSrPdrV9Nh7ijCgKlxzA==
X-Received: by 2002:ac8:5a55:0:b0:467:6692:c18b with SMTP id
 d75a77b69052e-46e12a25294mr200227851cf.5.1737405806096; 
 Mon, 20 Jan 2025 12:43:26 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102ec4acsm46190671cf.13.2025.01.20.12.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:43:25 -0800 (PST)
Date: Mon, 20 Jan 2025 15:43:20 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z461aGgm_sOqISfE@x1n>
References: <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
 <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
 <Z46W7Ltk-CWjmCEj@x1n>
 <ba6ea305-fd04-4e88-8bdc-1d6c5dee95f8@redhat.com>
 <Z46vxmZF_aGyjkgp@x1n>
 <b812fd19-055b-4db1-bdff-9263c8b6b087@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b812fd19-055b-4db1-bdff-9263c8b6b087@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 20, 2025 at 09:25:51PM +0100, David Hildenbrand wrote:
> Yes, calling it "attributes" popped up during RFC discussion: in theory,
> disacard vs. populated and shared vs. private could co-exist (maybe in the
> future with virtio-mem or something similar).

Yes makes sense. The attribute then can be easily converted into something
like "user_accessible" / ...  Then that can equal to "populated (plugged)
&& shared" ultimately.

-- 
Peter Xu


