Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BAFC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQZ1-00012Y-7P; Tue, 05 Mar 2024 03:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQYY-0000sc-NI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQYX-0002n5-CT
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709628828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xipQPKlGoQGeK6BSdxFQTPJ22Qa2ae1l3xDpvFxnM2U=;
 b=T/lYreAqhrvCuJK3tBp0A9QJa9gprHXG/XIS0jUdlfkEsg1WFqDWY6Pbn/UWGEpOiEL9Mp
 lJ3eFq8vLCmRwGxRnAh8Ru6fdqZANr1F4WRPQnv0w+ZR/vqZrpL08afAXznYWk7SqW4xsZ
 oVYLZYLKNobg9lWfEZVNEzBJNP37Txc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-4BRW76oPP1240NOv-ppbVA-1; Tue, 05 Mar 2024 03:53:47 -0500
X-MC-Unique: 4BRW76oPP1240NOv-ppbVA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42ef6a1b6b6so17061081cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709628827; x=1710233627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xipQPKlGoQGeK6BSdxFQTPJ22Qa2ae1l3xDpvFxnM2U=;
 b=iJ5zU/gjsujCzK0+ty6dlhgeQ6bnluGBy2enfmfDhDAn+BbdDMuWpm+f5S8GsnOF6W
 IxLouW2KZj1x/ia/p+ID8E38+egRCzhMFaEA23/rbPeoTHgb3It43HQE1P+xbYA3kIAO
 YzttjE1OZDiFc6HRu4gfMMP8ilp+K7qarIuWPFEk2zaOQXP7STnA0L6cGj5FCWeZMyS8
 P4EmcQbfC8A53LqW6G2bhiqpm8eSGVhJWxYRLhMeSoRyC+1N9etMdoZ0RoKm0m0k2jgd
 XY2ymtRO3JhJukRkgw18/rHTLh+c7J/t0fLGaESmCpgvEb9axEaLfYSMEly7nojyywF2
 phcQ==
X-Gm-Message-State: AOJu0YwWABIY0Cf6cgY6maK02MIomdoOaDveI89c1KKvCFBOF4LnaFRa
 VjzuRq2Wb96uybnRZZwkpnmEN4Z8wpvUM0RRE8SoNZlYZqPCkPIkRongrAZ0HT9aDpKxsnSbri4
 3ro21irYCme6YMMgsTf0D5SD0MnkfCWS0PcH92Hp+riHLhfgGL7gV
X-Received: by 2002:ac8:5fca:0:b0:42e:7a6e:825e with SMTP id
 k10-20020ac85fca000000b0042e7a6e825emr1391119qta.61.1709628827074; 
 Tue, 05 Mar 2024 00:53:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW1EmKAziIKm5GyWDkhko8IpoJgEAfS0QFUeSzVk+jOJdbRndx3qEUVDGoGq4cRM0U7VKKqQ==
X-Received: by 2002:ac8:5fca:0:b0:42e:7a6e:825e with SMTP id
 k10-20020ac85fca000000b0042e7a6e825emr1391107qta.61.1709628826880; 
 Tue, 05 Mar 2024 00:53:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f13-20020ac86ecd000000b0042e2eb24b42sm5211564qtv.22.2024.03.05.00.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:53:46 -0800 (PST)
Message-ID: <2c2a0f4e-78d3-4780-bbdd-0fcead0c2c06@redhat.com>
Date: Tue, 5 Mar 2024 09:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/26] migration: Always report an error in
 ram_save_setup()
Content-Language: en-US, fr
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-5-clg@redhat.com>
 <CAE8KmOyxw2SYiW20V9MZZMJGL7ioHSALknZ=N4EZOS53S_i3TA@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAE8KmOyxw2SYiW20V9MZZMJGL7ioHSALknZ=N4EZOS53S_i3TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/5/24 06:29, Prasad Pandit wrote:
> On Mon, 4 Mar 2024 at 18:01, Cédric Le Goater <clg@redhat.com> wrote:
>> This will prepare ground for futur changes adding an Error** argument
> 
> * futur -> future

Fixed in all first 5 patches.

> 
>> +    ret = qemu_fflush(f);
>> +    if (ret) {
> 
> * if (ret) -> if (ret < 0)

yep. Thanks,

C.


