Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBEC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugs8t-0000Gx-Ft; Tue, 29 Jul 2025 17:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ugptn-0003om-6o
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 15:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ugptj-0001Eg-1c
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 15:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753816921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyWup6DrxfzG18auA5/90E7MZYzzPLmPRA9DWFiFzEg=;
 b=e1Yo5yH2cxNPO9Gtz9NjX58GPbzxQbI+maqW97Z/hSZ2cQ8KkaDxAwZW3lJ/8NN54YJCVd
 hqIHfKMxcYUwKalwWPiisFYVrRQyjQwmmcEoQ3tFtQoSdw3dBuxw1ZgiQjmAfhhqljnuz9
 NW9UYi7Q5yCas+kkFSrXCZI8soc6E5E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-gOAJCG5bN2ykl6YjRfoMNA-1; Tue, 29 Jul 2025 15:21:59 -0400
X-MC-Unique: gOAJCG5bN2ykl6YjRfoMNA-1
X-Mimecast-MFC-AGG-ID: gOAJCG5bN2ykl6YjRfoMNA_1753816919
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ab801d931cso4383221cf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 12:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753816919; x=1754421719;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LyWup6DrxfzG18auA5/90E7MZYzzPLmPRA9DWFiFzEg=;
 b=KBDZWWXBJK9rDv9AdoHSGmxPbq2PWDP4HzIzcrZgGRSBQvvrspK7nSssVes2cwEAFy
 CXMXinMqTt3I0N6oXK0/r88KRfxMIuw5vg948I1/bhpwBTbhkkfSWJMAtKXZm9soUVBN
 JPdJ7yKaTwTT3VuO1S3CMtUj9fW8cPAuglxApPCK49UxJ14DvIdG7JuNY52T9EVg1kDh
 B4hFozfO4d33bPpO3rDg7rBO7s3HgpQJ0dmehnESRw4XcpHqgXyvJVerrNrGTQwDtCuS
 P1PKgRZEMcZjdCeJkh/qToxA3sxVPc7ecMjiJxX4jbLX6i+kh5zKM7Jyp3FQuOUn7kj8
 D0dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0630K4aYiOhOrec4nVkbxAwN3l99ltvB3nbU+fqkw9FP6tVCKB/tZbwkBx9YCQqoFDluVlMvDRfQj@nongnu.org
X-Gm-Message-State: AOJu0Yzy1yULb6/0T3h0uUkrb9qnNCoPKHbhz7eLfEL0ixVJabwZ2+nZ
 JfFyQaSRx1kbIJEJKpxfmgUeKmpkS88vc9SmknVzerKUIwxI1tG90Bm61tQ3KFyxMeQcmAaGb6C
 fSKwY7wrniUXfts37dmx856Kt4CdRBBk7eXXR33UHZXv4js1M2eRSisVi
X-Gm-Gg: ASbGncviiaHv8xCs5YmV03hD/mAON1nzz6rlnH8NAC73+PTG3rB7O6AxeXw9GVYYuub
 X/NwaZI3EhfXPx5GfrQd5bKngQ+oAH5bWlXFBQOdBlPTWMHLiUPEU25hBD24rTAfMRQg0zYbvhJ
 OIEri/2+Z+uKWOrFRUyEQhp63s7UgjK/3cBkSnzkDWKesB63DO0F2iRJ3+bYIVsRAW8A4kF/ta5
 2MzZvfiyUu1de/Rx/jnnmBQbLkXXH6MoRCASczBAhNW2K800kZfDggMBua09HBLmq6oyHOotgen
 56qstBhowtkW5VaiMzU4/BRg3p7XKbDL
X-Received: by 2002:a05:622a:20a:b0:4ab:69ff:eefe with SMTP id
 d75a77b69052e-4aedb99b302mr15352941cf.1.1753816918832; 
 Tue, 29 Jul 2025 12:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCS5e04R4ykwDSMamIoaqAn4LdZ/kaQbMTiKqiIIko5BcQAGg7nmPqvW1vrkslgsMb3wgOg==
X-Received: by 2002:a05:622a:20a:b0:4ab:69ff:eefe with SMTP id
 d75a77b69052e-4aedb99b302mr15352401cf.1.1753816918373; 
 Tue, 29 Jul 2025 12:21:58 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4aeadea8b61sm39722591cf.24.2025.07.29.12.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 12:21:57 -0700 (PDT)
Date: Tue, 29 Jul 2025 15:21:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Patrick Venture <venture@google.com>, Peter Foley <pefoley@google.com>
Subject: Re: [PATCH] system/physmem: Silence warning from ubsan
Message-ID: <aIkfSris9vanaS41@x1.local>
References: <20250728172545.314178-1-thuth@redhat.com>
 <e19e5442-1479-43b3-a232-b8587c79caed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e19e5442-1479-43b3-a232-b8587c79caed@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jul 28, 2025 at 08:43:47PM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing Patrick & Peter for similar patch:
> https://lore.kernel.org/qemu-devel/aCUDxEQVACn5CY8f@x1.local/

This version seems to work.

> 
> On 28/7/25 19:25, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > When compiling QEMU with --enable-ubsan there is a undefined behavior
> > warning when running the bios-tables-test for example:
> > 
> >   .../system/physmem.c:3243:13: runtime error: applying non-zero offset 262144 to null pointer
> >      #0 0x55ac1df5fbc4 in address_space_write_rom_internal .../system/physmem.c:3243:13

I can trigger this by as simple as "./qemu-system-x86_64 -accel kvm".  I
queued it, thanks.

-- 
Peter Xu


