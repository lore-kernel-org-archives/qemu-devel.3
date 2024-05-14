Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF749C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6scg-0006M5-84; Tue, 14 May 2024 09:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1s6scc-0006KE-PT
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:55:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1s6sca-0002rG-N9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:55:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AECB466A64;
 Tue, 14 May 2024 16:55:11 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8DF6CE7F1;
 Tue, 14 May 2024 16:55:00 +0300 (MSK)
Message-ID: <fadc022e-7cfd-4201-90e5-0193ce6220bc@tls.msk.ru>
Date: Tue, 14 May 2024 16:54:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Michael Galaxy <mgalaxy@akamai.com>,
 Steven Sistare <steven.sistare@oracle.com>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
 <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
 <d6176480-d87c-492b-8a0c-04bf81a4f59a@akamai.com>
 <59ad1f18-682b-46fc-a902-884ca6150c7d@akamai.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <59ad1f18-682b-46fc-a902-884ca6150c7d@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

On 5/14/24 16:39, Michael Galaxy wrote:
> Steve,
> 
> OK, so it does not look like this bugfix you wrote was included in 8.2.4 
> (which was released yesterday). Unfortunately, that means that anyone 
> using CPR in that release will still (eventually) encounter the bug like 
> I did.

8.2.4 is basically a "bugfix" release for 8.2.3 which I somewhat
screwed up (in a minor way), plus a few currently (at the time)
queued up changes.   8.2.3 was a big release though.

> I would recommend that y'all consider cherry-picking, perhaps, the 
> relevant commits for a possible 8.2.5 ?

Please Cc changes which are relevant for -stable to, well,
qemu-stable@nongnu.org :)

Which changes needs to be picked up?

Thanks,

/mjt

