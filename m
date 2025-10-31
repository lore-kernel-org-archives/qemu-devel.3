Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91902CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEo1y-00082F-QB; Fri, 31 Oct 2025 08:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEo1r-00080S-4u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEo1k-0001aB-BR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761912878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lK/kVPl9dv1lSTcrss464KhBoOlJOlZCJNfZYcDp6H4=;
 b=U+GAqdlSmc2KcI6j5VOaCCdLN++6IGyFhS+Ttuy7DDcd2CJXF/zBvm7H4THrUG9ahdYk87
 pZlB5lRKXM8Xrz6vume30ZYWVRBurVzkWkXdxsoFv8zPfSzTe7xYz1uSRAGK45IOGI9IMv
 RNFg2Z9+VVUukjpwJuq6LPxOpBj+Mn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-Pl6gWJiePkiJEkdPW2WM2A-1; Fri, 31 Oct 2025 08:14:35 -0400
X-MC-Unique: Pl6gWJiePkiJEkdPW2WM2A-1
X-Mimecast-MFC-AGG-ID: Pl6gWJiePkiJEkdPW2WM2A_1761912874
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475de1afec6so10214155e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 05:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761912874; x=1762517674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lK/kVPl9dv1lSTcrss464KhBoOlJOlZCJNfZYcDp6H4=;
 b=iS8sgbymt1TGuXyXMzChPUVzFtYhZvRmz3P7ai3jRGW5YRM14/QNsX3Uh2N2PWGyST
 teq5O38zxyKh+ZqPa6yJkg5cTM7S2ynmkubXlc7HpnkQIkjsSe5oFbRiBR0uPD1bO2m3
 R14maYruCqNuEmTWdWdTDI6SWmYNjVDAHNamecjcA2iRdqa+jfhD2rP+0iR1rQnCAlmw
 ndXIBH3jZRiR4n2M6DAqFLgJa4TyS2GFiPwZn8a4UIc/oUfIHykfz+kVmI2pBnW/EGkN
 lbhXRkWQq4K4iB1ncE8RdJ8tGw+6tuqRuBU5DkA7P7MK9BxzpcmkMZFmVmluz8wymRwT
 0ulQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE4SODAE5AGJKbJV1l2NcCdyL9/QUPUjPsrBOI0F7HylGVH46Ul0SkkKgG/ga6uTF1gYjkFi6+QC5q@nongnu.org
X-Gm-Message-State: AOJu0Yy8tQVu8+nP/TRGyNivvmn8k7OLJX6H/kQH6tbi8QgenLJugd6H
 UyhnhjThXB3okNFfOoACw9AmLEsolW+pwn3T9qZB9ExcRquyo9gqrRkJv5UWHgjbDM+KK0gzFLO
 0H+OSCgTZmhoSSMNuvYZxCigNZ8PIbJnRQ698mjeRIsUrMA9q0pbWDzdn
X-Gm-Gg: ASbGncuObOFTwy34YletH/X3s94E2Zd2cjO6jCmOYzYGq9fwoxqAvTz0craQwPg0uOx
 gw5oP1pmeaZZSFiuyeJZXRQ0E7c9mDrk+X2ZDIA+tHOXWXsghmPuRQBPsXT0C3DhU+DCyJgr3VE
 C1lkQRORyHvvfakS1bIBqaJfvBP99POBUMSoxrLEsqSScOvbJPwEoO45l5RYRWKxdnpIEmLrBdI
 jdf0Vmui+IXdmFJkPSlNFD367BBrze35N2U2HsGsHOleQv298e3mWIa+LEpsBVu8Do1dVmWfSrM
 KAtruoBZzL4V6X6utJCrvvbmL/Q1OZLVqQ7+0UHISfUAAZMqEnRGdEeCpl7O1GcqiQANQVTSJ6G
 TJj/xUl04x5E7Ha6mvqLvG0ayg2yV/QOJkBHHooukeevCWBSIpqwj+pH2SxuC/O9lLyv2zmO3Mq
 QFIaHQRbv9Rn9N006zg23TCNXXTp1p
X-Received: by 2002:a05:600d:830f:b0:477:ede:d2b4 with SMTP id
 5b1f17b1804b1-47726263362mr45246775e9.9.1761912873969; 
 Fri, 31 Oct 2025 05:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRKvx55f0r6ox3+kwZMp82v6joA2H9nLGIZEGIEn8CcImNMgAxNmxotLE1NOs+ZMAaB0OCw==
X-Received: by 2002:a05:600d:830f:b0:477:ede:d2b4 with SMTP id
 5b1f17b1804b1-47726263362mr45246555e9.9.1761912873589; 
 Fri, 31 Oct 2025 05:14:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47733023256sm31555645e9.17.2025.10.31.05.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 05:14:32 -0700 (PDT)
Message-ID: <f5910674-d651-4230-a453-03650da029d4@redhat.com>
Date: Fri, 31 Oct 2025 13:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/21] export/fuse: Use coroutines and multi-threading
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <aPpGlhSwW0tBYBZU@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPpGlhSwW0tBYBZU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23.10.25 17:15, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> Hi,
>>
>> This series:
>> - Fixes some bugs/minor inconveniences,
>> - Removes libfuse from the request processing path,
>> - Make the FUSE export use coroutines for request handling,
>> - Introduces multi-threading into the FUSE export.
>>
>> More detail on the v1 cover letter:
>> https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html
>>
>> v2 cover letter:
>> https://lists.nongnu.org/archive/html/qemu-block/2025-06/msg00040.html
> I have finished review and while I did have comments here and there how
> things could be nicer, I don't think I saw a real blocker. Please have a
> look at my comments and let me know if you intend to respin the series
> or if there are things I should fix up while applying the patches.

Thanks for your suggestions!  They all sound good, I’ll revise.

Hanna


