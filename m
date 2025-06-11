Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9288C71131
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPMm7-0007yY-Bt; Wed, 11 Jun 2025 10:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPMm5-0007yH-Ua
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPMm4-0001Il-J3
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749653393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3uLB0Tg/ZGuwx22yBB4UlTrdq268Gjpo+IhBtlLmTY=;
 b=YD264iO7GxaJLg7Hk+QpZzbRyB0wLQ6DmG4JaJNlu4QEWN/P8ncM/0IM8v88ej5O/Ck8ty
 YaBd6jZKnB0kEDyLxkcotXGGUAbfYsNsKnOyWd6g/Lo0sxrOPWhZUR0YnbRzQL3sPg7uYE
 CwYcPI8dCpss66XY8KunwjqiUU+EyLw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-y9mpe3ovNY2Jtgq8he9J8g-1; Wed, 11 Jun 2025 10:49:52 -0400
X-MC-Unique: y9mpe3ovNY2Jtgq8he9J8g-1
X-Mimecast-MFC-AGG-ID: y9mpe3ovNY2Jtgq8he9J8g_1749653392
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5bb68b386so1100572885a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749653391; x=1750258191;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3uLB0Tg/ZGuwx22yBB4UlTrdq268Gjpo+IhBtlLmTY=;
 b=JvkSQepAkyhCs99GSBJ5Ocvqcjm9lstxNeX/vOs/YeIJkSbhNfVPbPXX+fpOAqm+Iy
 Itlzm3UGIMQcxumQ6FO9aaanPDmioVJWsCEaYijTlN1K1wt4mI9fH6o31zx7bmHPoA0N
 6FexIcXkPKiqlTeThvfs9KBO+k9Qs9vi04ogom1OtuW2Bi2EvYrnNPTc7gqTrac572GX
 3r3vozzZU/g7L24SNXyrRDorb6gAFN+lpf0L4Wa4JUxl4tH87DaHLNIFWeBVxJvWD4Jz
 h6VCoHxgS0MtYsa3rQWHDg4TvQPbDanO2aglQlGuNAA3Lfr+el+Ya9YkWK05GFDtK6yv
 Oa/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS79mICBKTJvuQC5YJRZBTYItstok161ZryFLoAbxqYpFCqmRAfPhiMsJjKlajDjqiok6sUG546Njd@nongnu.org
X-Gm-Message-State: AOJu0YxTmvmxqz94ytEzUPV2psyBFZEdmJsECHrG0K+9nB1c2vdIDAws
 c9jGp0vNdZeHvT0J7WuZguJ2kH9CLOQFw5yzcl0sr9mryubkGAcumSxaXIf1+c2zmoN2RSdic+C
 URzBpKy7tjFSDq5YUO0vf8+vp/NZn2lZgCNRDrgko92bGmcwZ+bFM7GzK
X-Gm-Gg: ASbGnct1pZ+rJ2LHMTIc5+Z/XG0OS/z7In94130J9+WZWL8pgjI3vNOyqhzeuO0jT21
 AdJFpIaZ0TiymlKwZwT/k+lTeL3EcecGshhYLUwjRwQ9QixdmTgpYudZkV1YGzsxKPNDXmb84zc
 9IsRKXOFZt/+3hDwkNjX8mZtXoBU5J3GwGy8axqKXE5KtmfciE4vfJkPRsI1lNjZpawJEBLsawU
 E1h90FC9ZrEdn+g3P8D2eQYchlYKtwjziAno3P7L8D1CEcrL55TbL/ocyzpoXf7adu5RPztgwPj
 QjeyAxFhzBF+dw==
X-Received: by 2002:a05:620a:1a19:b0:7c5:6140:734f with SMTP id
 af79cd13be357-7d3a95766f6mr437803685a.18.1749653391751; 
 Wed, 11 Jun 2025 07:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8OFgs/oofJX5sNV1iyWcxRGhV+KvbgxliBUeIBcp6tps5CuOvJn2E/cCX2Ps7dSU9V+EwzQ==
X-Received: by 2002:a05:620a:1a19:b0:7c5:6140:734f with SMTP id
 af79cd13be357-7d3a95766f6mr437801285a.18.1749653391452; 
 Wed, 11 Jun 2025 07:49:51 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250f64b80sm864271585a.23.2025.06.11.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:49:50 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:49:47 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V5 00/38] Live update: vfio and iommufd
Message-ID: <aEmXi-78ZErVeLQK@x1.local>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <0330df5e-8a9d-4fdf-bee8-a864eedac24d@redhat.com>
 <effe22b4-c6e4-41c2-b3e2-d03160560f86@redhat.com>
 <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 11, 2025 at 04:25:13PM +0200, Cédric Le Goater wrote:
> Peter, Fabiano,
> 
> The first 2 patches are migration patches. Do you agree if I take them
> through the VFIO queue ?

Yep, please go ahead.

-- 
Peter Xu


