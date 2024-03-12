Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD96C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6WO-0004kg-Md; Tue, 12 Mar 2024 14:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk6WF-0004kQ-JV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk6WD-0004Ch-0w
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710266786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tugagavFWYs8SO4lYU4iVSZex7rAoeAqw+QKMbayaEI=;
 b=LFtwhV10PIVhPt/eKP7fMBa43nn5bcaHEe2DzDsatabOvai1XDNE9wd7Qk9K+ri4Ztfzg/
 ozijV9B9m+Z3W/S/4gr+lmgHvWE6fweENNYTF7W00X14dmRCELtb2RbJ3NP8hrKaX1VM+a
 IWBSyrQ2SxpslS4kRXUMjpRtqCnr+SE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-3KvNX8zKPe6T8-D45-5Pzw-1; Tue, 12 Mar 2024 14:06:25 -0400
X-MC-Unique: 3KvNX8zKPe6T8-D45-5Pzw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51333e20813so4304803e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266784; x=1710871584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tugagavFWYs8SO4lYU4iVSZex7rAoeAqw+QKMbayaEI=;
 b=cyZN3GaXA26cAplcXWVN1hy2f2Lo4UlwhTrflKTcL0x5V8/+TdcZiQikPGNjs9GO0x
 1xx9xdgQbUdagu7k3ITyuCMU7bQo8k4+Lb3arA1ZqpKq1WGHcWJ67Xox5hQnlfr5bF2o
 Ov1Yudp8YC/5l2MTCWfjIStobwQZojlokmcSRHbYczh/B1uE7XompSqmRzMmYAsnLvj/
 yMsnmWCGXuKFczcgSK0fzdVeyWGbqmtC/2LizaO3WmY9VcLzzx1peryDZJlsvEMd/npz
 KEimI5lgPfOiyrJt89wrAO3qOAaFYmam8xF3vvBv8RZRYmJKtAEFDlupVINaAtzr1Zxr
 MO9g==
X-Gm-Message-State: AOJu0YzyOtB1wW5Yp7v0AdYfJkUHunFt4H15zgXbgxk0CEH7xQY0yQ17
 hymFR+xFKZ73Q3pY+2T/bjbUDiHxmx7H2dVXS4a8xbMv6YfX2HEZNNFWHCp8nSlsfgH35/zAo5p
 6hBdRfCOaSxn0gxjNYDPXBri8JTAhlDoz1rCym2B6FVVlrMO+pVdU
X-Received: by 2002:ac2:424a:0:b0:513:7e68:a460 with SMTP id
 m10-20020ac2424a000000b005137e68a460mr622481lfl.27.1710266784113; 
 Tue, 12 Mar 2024 11:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAOkcerUksKaxQRf/5bl/w8uLy8fC8oI/W6d8aOb972MlByvaPCVaPFxKHpx80J+QzvKBZmA==
X-Received: by 2002:ac2:424a:0:b0:513:7e68:a460 with SMTP id
 m10-20020ac2424a000000b005137e68a460mr622469lfl.27.1710266783800; 
 Tue, 12 Mar 2024 11:06:23 -0700 (PDT)
Received: from [192.168.1.33] (92-184-107-164.mobile.fr.orangecustomers.net.
 [92.184.107.164]) by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b00412f679bae1sm19669702wmq.26.2024.03.12.11.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 11:06:23 -0700 (PDT)
Message-ID: <476c7786-831d-4521-85c8-4fabd093f9dc@redhat.com>
Date: Tue, 12 Mar 2024 19:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfByYiL3Gl9d9u7h@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[ ...]

> Now VFIO allows a migration to happen without this trick.  I'm wondering
> whether all relevant NICs can also support VFIO migrations in the future,
> then we can drop this tricky feature for good.

Currently, VFIO migration requires a VFIO (PCI) variant driver implementing
the specific ops for migration. Only a few NICs are supported. It's growing
though and we should expect more in the future, specially entreprise grade
NICs.

Thanks,

C.




