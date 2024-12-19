Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C5EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCHc-0002cK-Us; Thu, 19 Dec 2024 03:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCHb-0002a3-C0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCHZ-0001G8-LZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734598400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ud2fd6bZ+/4A9IQhZpmu0Ce2UMNh4/XN9qsftscVbjo=;
 b=GMs4Da0e5vA400MLZNbjYYNZIyx4KS6ojeDjsO9uvsyHoewIz0TCSOE1/1FsdlgZBDNxFz
 DMz0l+m6Ng+KsKkfZU0thtRdZH1y4a6rNf6WW3/MsBNrJ/Cg3z1dYfTbMdT6De+89qo84t
 xFqFjq5ChmxW8qv9yBXDSibl0BNtNu0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-bfQ3HFxZNB-IAs5XUbxPjA-1; Thu, 19 Dec 2024 03:53:18 -0500
X-MC-Unique: bfQ3HFxZNB-IAs5XUbxPjA-1
X-Mimecast-MFC-AGG-ID: bfQ3HFxZNB-IAs5XUbxPjA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87efed6c4so9596946d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734598398; x=1735203198;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ud2fd6bZ+/4A9IQhZpmu0Ce2UMNh4/XN9qsftscVbjo=;
 b=JYWwhmRCX10Wvh+edgROZUU5NoHw4plml4BMlZncmVFeygePsD5Q62Qwt1wMEDGeG4
 fCsJgCuh2rIH0vC30DEHX6iM9KQq3LSUIFxdz0rVBtcjF+oxIoWqYg9abwKH1dSnGMbu
 E48sZwtr7OSpt9o2UawbqUkOA3zoIIUilQNDnRxTgzgfkybDyc/PjWzImSGIOtnxIlm0
 3tb0SUo2MuVeUybtWEqogDWIPJme6B16Ua3eFlC+ja6tNvODIWiz+Jz6LrwTuk/BExYZ
 qtuL9AniZdD+/uw6+hkRKyi4Tfaa6Anr11EwS4hbY8ijlNrM6Azig2u1/LhWLz+adUeN
 oIoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXV//D8yUhb0XCn1E5QAUH8DLoYf0go/yoIjW+yQc92oqaH4JFUNeFJlEuyHjbjeNX1EoaYTzrcCEl@nongnu.org
X-Gm-Message-State: AOJu0YzBGBt1VvrHYs6sYBDWLep/5eXWArbRshRto4/zE/7Tmg7Jb/LU
 RzAmWr55vKirfiNQ3kU+mLyIbmfsVpYQATz/rOROKdUpN8gffF0ggXxsz082jEwXds57KK7Tslf
 87MEzahuYVGo1a8PBE+yJKwET2cl8mVlm95SrMHBdSaIGcYBa/o0o
X-Gm-Gg: ASbGncuZalDI1lxIiw3WYeGRTtZMVKW67or7r4lLeYlc+MiK3dgeO09h+u29CWsggSW
 T0XWl66L3t47o3vw7cQifQaU6G3ky14HUCwsUkMHjtFUXNxTdnwU7z8WGhkinYfD0xQ01Vhhvlj
 fe/da5Csqiwde+v8DCVhQvkAmJMSFUnnyMqsKXNnzjnoLjMlAM62hSLyh19y97Oqw5flpn+9bKF
 x7EVai1OXwjumwJyeJEJV+lDqREp8feN8Iyh/GxwDNdWmzH/uDieSP8KjPvmajdSq9lVsmdsijA
 cXQ0fQXTTJTIpWe2LiA=
X-Received: by 2002:ad4:5be9:0:b0:6d8:a1b4:b591 with SMTP id
 6a1803df08f44-6dd091d999emr111617126d6.23.1734598398026; 
 Thu, 19 Dec 2024 00:53:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECv+UcDPTetkQAxTAgbQ1EU4mR/nPLrH8C/BoQq05N0HjG9erdydzId4mnoNzfjUf8NF0iIg==
X-Received: by 2002:ad4:5be9:0:b0:6d8:a1b4:b591 with SMTP id
 6a1803df08f44-6dd091d999emr111616896d6.23.1734598397742; 
 Thu, 19 Dec 2024 00:53:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d528csm4294596d6.112.2024.12.19.00.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 00:53:17 -0800 (PST)
Message-ID: <44e311d9-3af1-4a84-a2cd-da3a64cb8a94@redhat.com>
Date: Thu, 19 Dec 2024 09:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00/24=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: Yanghang Liu <yanghliu@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Chao Yang <chayang@redhat.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1CpIA7_o7s-NzJ_@x1n>
 <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
 <Z1N4qYOsEcfsC-H5@x1n>
 <5c6a0bc3-ab9a-4514-8feb-f3c17978d3af@maciej.szmigiero.name>
 <Z1se0X6eq1DRYLa0@x1n>
 <CAGYh1E89i-AeHMOt5ddmB_-oGVYqBHr1Oj55OUDyhpzor9bDuQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAGYh1E89i-AeHMOt5ddmB_-oGVYqBHr1Oj55OUDyhpzor9bDuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Hello Yanghang

On 12/19/24 08:55, Yanghang Liu wrote:
> FYI.  The following data comes from the first ping-pong mlx VF
> migration after rebooting the host.
> 
> 
> 1. Test for multifd=0:
> 
> 1.1 Outgoing migration:
> VF number:                     1 VF                           4 VF
> Time elapsed:             10194 ms                   10650 ms
> Memory processed:    903.911 MiB             783.698 MiB
> Memory bandwidth:    108.722 MiB/s          101.978 MiB/s
> Iteration:                               4                              6
> Normal data:                881.297 MiB             747.613 MiB
> Total downtime                358ms                       518ms
> Setup time                        52ms                        450ms
> 
> 1.2 In coming migration:
> VF number:                       1 VF                            4 VF
> Time elapsed:                10161 ms                    10569 ms
> Memory processed:     903.881 MiB                785.400 MiB
> Memory bandwidth:     107.952 MiB/s             100.512 MiB/s
> Iteration:                               4                                7
> Normal data:                 881.262 MiB               749.297 MiB
> Total downtime                315ms                        513ms
> Setup time                        47ms                         414ms
> 
> 
> 2. Test for multifd=1:
> 
> 2.1 Outgoing migration:
> VF number                     1 VF                           1 VF
> Channel number               4                                  5
> Time elapsed:              10962 ms                  10071 ms
> Memory processed:     908.968 MiB             908.424 MiB
> Memory bandwidth:     108.378 MiB/s         110.109 MiB/s
> Iteration:                               4
>    4
> Normal data:               882.852 MiB              882.566 MiB
> Total downtime                318ms                       255ms
> Setup time                         54ms                        43ms
> 
> 
> VF number                    4 VFs                        4 VFs
> Channel number             8                               16
> Time elapsed:            10805 ms                  10943 ms
> Setup time                   445 ms                       463ms
> Memory processed:  786.334 MiB            784.926 MiB
> Memory bandwidth   109.062 MiB/s         108.610 MiB/s
> Iteration:                              5                           7
> Normal data:            746.758 MiB             744.938 MiB
> Total downtime            344 ms                     335ms
> 
> 
> 2.2 Incoming migration:
> VF number                       1 VF                      1 VF
> Channel number                4                            5
> Time elapsed:                10064ms               10072 ms
> Memory processed:     909.786 MiB           923.746 MiB
> Memory bandwidth:      109.997 MiB/s       111.308 MiB/s
> Iteration:                               4                          4
> Normal data:               883.664 MiB            897.848 MiB
> Total downtime                 313ms                   328ms
> Setup time                        46ms                      47ms
> 
> VF number                   4 VFs                        4 VFs
> Channel number             8                              16
> Time elapsed:             10126 ms                 9941 ms
> Memory processed:   791.308 MiB           779.560 MiB
> Memory bandwidth:  108.876 MiB/s         110.170 MiB/s
> Iteration:                          7                               5
>   Normal data:             751.672 MiB           739.680 MiB
> Total downtime             304 ms                    309ms
> Setup time                    442 ms                    446ms
> 

This is difficult to read. Could you please resend with a fixed
indentation ?

We would need more information on the host and vm config too.

Thanks,

C.


