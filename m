Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8295C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hsC-0004VD-9e; Mon, 07 Apr 2025 04:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hs9-0004S5-Iw
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hs6-0003Hs-KG
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744014620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dFvIAWevlf/DQJEL0mouHqhCA+bvZCV9I3h2fYmPc8Y=;
 b=bKg2uMk0Q9Q+4JnenhGKAXGuVUPxOe1ZNKFLjlaXcHgEIiPgSkvUrwg7pcxeaTJNq36z0e
 VLfzYSqNNtFEIOrww0y/cwej8ROF/PZ/KXz5wl0fadzxgHjnnZESxVExYQjJ4uF9+b+p2u
 YkfnkAgF+zxAWdh9haa9nzjePAHhgJM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Mf002mJHOoSdyHEJVjkevw-1; Mon, 07 Apr 2025 04:30:18 -0400
X-MC-Unique: Mf002mJHOoSdyHEJVjkevw-1
X-Mimecast-MFC-AGG-ID: Mf002mJHOoSdyHEJVjkevw_1744014617
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so1629089f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014617; x=1744619417;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFvIAWevlf/DQJEL0mouHqhCA+bvZCV9I3h2fYmPc8Y=;
 b=AcVGuoORzheQKmmd+tJqFNDGHBI3rE3Q+kiGKwSluOlNautqx5Msab6mmyT8NPqypp
 cvEHNz1IGjYmraXwoBFIKYN/7EYOrIMSs5shMk+AvKKQM4DJM4b92ICI2j2GWJt0R5VY
 6rnAU+JZ8NMh+Sq6aH9R+bBOQcILdaZtvkCAOpXCTcyl3L59A1NFDtDBxpI6cJYLAsNE
 Lwf8wVnAVBTcG7LwANF3LJqFLzyqnj3uJ/00hqcPhOC/Pgk3l63SpDYXSaJBMOVGTAD4
 3ZTv1QJmI+BqJA66UonI0cS8WnfACnaPC1iZt3ddBhE9FxzEtYtDEzRMJjC91DfsRkh8
 khcQ==
X-Gm-Message-State: AOJu0Yz5w6gMPaIxrnfTyDKtR1O8qcuchJBo/m08AChGBaNvagDjLpOI
 TqSqAIk8kn1xh3VSJb5lU/AoscEeaZX4guIdgkCrWy0kQKoGEginuZXv1qtIGSqREGnLddgeI9a
 p6HsGmDXG1e6Ql1anSdTfG5BlPklzPeWtmE9wR8W9GT3LCGxssBCG
X-Gm-Gg: ASbGncvi2Sq1Z8qGBXUxm1/ov1qKjvRPJCBZROsZ+cAiqtddzwSHBWPbuegeHSirRNu
 O+uyfeKo1OkWBhTubcarmOUiGdvkS3tINCKrlUBQnI642pxXyXmx8OZMhvssFmlFtFlSut+rwZN
 C8Hf5Fu1g8nPtZ9hwzWUofMYabHZGa7TfZ5nvUk1s1Ks2V4SDlxgd6l16bIi67JMHaSh6gSsM+9
 Hwo3PBCt9FDHdE2Ah2Cc6x00UI4P2d2nc3uhF2V6PglDorBhyRMifBq8GOuRPx1drV1n0wT8pYD
 +K1O/2tVqBHwWogh46oXK69OmBUBpI1iDWB/aggmCNMRC12nF0oT/A==
X-Received: by 2002:a05:6000:18ac:b0:391:4743:6dc2 with SMTP id
 ffacd0b85a97d-39d6fc4eecemr5695257f8f.25.1744014617351; 
 Mon, 07 Apr 2025 01:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYoC/wvr7MF677lX6tGBmM0/Nff8Lez3RrTZp/Ca1fa3DQhrmbHbdMPre7Ij4Q//a9uWjQUw==
X-Received: by 2002:a05:6000:18ac:b0:391:4743:6dc2 with SMTP id
 ffacd0b85a97d-39d6fc4eecemr5695230f8f.25.1744014616936; 
 Mon, 07 Apr 2025 01:30:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6321sm11159348f8f.44.2025.04.07.01.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:30:16 -0700 (PDT)
Message-ID: <35a74cd3-e745-4245-a07e-93a3173f87c2@redhat.com>
Date: Mon, 7 Apr 2025 10:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 31/37] vfio: Rename vfio_get_dirty_bitmap()
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-32-clg@redhat.com>
 <Z+Uc7avO3AR/K41q@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+Uc7avO3AR/K41q@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 3/27/25 10:39, John Levon wrote:
> On Wed, Mar 26, 2025 at 08:51:16AM +0100, Cédric Le Goater wrote:
> 
>> vfio_container_query_dirty_bitmap() is consistent the VFIO container
>> routine naming scheme and is now free to use.
> 
> "consistent with" ?

"consistent" was intended. I rephrased to :

"Rename to vfio_container_query_dirty_bitmap() to be consistent with
the VFIO container routine naming scheme."

Is that better ?


Thanks,

C.



> 
> Otherwise
> 
> Reviewed-by: John Levon <john.levon@nutanix.com>
> 
> regards
> john
> 


