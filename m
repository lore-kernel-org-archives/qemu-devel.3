Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C07CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hWP-0000s9-Ga; Mon, 22 Sep 2025 10:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0hWM-0000oz-J0; Mon, 22 Sep 2025 10:28:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0hWG-00087q-Oj; Mon, 22 Sep 2025 10:28:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 75A20C0164;
 Mon, 22 Sep 2025 17:27:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:128::1:39] (unknown
 [2a02:6bf:8080:128::1:39])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jRX5hk2Fr0U0-QOQDx54A; Mon, 22 Sep 2025 17:27:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758551268;
 bh=8VBpBMvl9xLeLViJDmpgCa7VXxRriH4j0ysKAGPTvZs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=btrg0YwiLiTx6L2bIgpPtonStlEHLGh7zr8LLga/Af+KjcdyCrQ+/rm+gQdYVEM8J
 dn2HdVVirPczBSLExUcY6e3aDPTHdJ9YhlKuUdahm5YQtb5zF4UktoNfok9UvTylhy
 WKIox6hXCIiqo/RK08lKK13ACkJGEs1kL++6L0P0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f5e98585-6ad2-4e54-97db-0c4019380ee7@yandex-team.ru>
Date: Mon, 22 Sep 2025 17:27:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-15-berrange@redhat.com>
 <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.09.25 16:45, Peter Maydell wrote:
> On Fri, 19 Sept 2025 at 12:55, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> Every caller already support errp, let's go further.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Coverity reports a bug in this change (CID 1630444):
> 
> 
>> diff --git a/chardev/char-file.c b/chardev/char-file.c
>> index a9e8c5e0d7..89e9cb849c 100644
>> --- a/chardev/char-file.c
>> +++ b/chardev/char-file.c
>> @@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
>>           }
>>       }
>>
>> -    qemu_chr_open_fd(chr, in, out);
>> +    if (!qemu_chr_open_fd(chr, in, out, errp)) {
>> +        qemu_close(out);
>> +        qemu_close(in);
> 
> Here 'in' can be -1 (if there is only an output file
> and no separate input file specified), so we can
> try to close(-1). Suggested fix:
> 
>           if (in >= 0) {
>               qemu_close(in);
>           }

Agree. I'll send a patch.

> 
>> +        return;
>> +    }
>>   #endif
>>   }
> 
> -- PMM


-- 
Best regards,
Vladimir

