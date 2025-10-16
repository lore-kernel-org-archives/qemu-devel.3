Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E02CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ucd-0007DE-C4; Thu, 16 Oct 2025 16:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9Ucb-0007Cr-I7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:30:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9UcY-0002CW-Lj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:30:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EE6588083C;
 Thu, 16 Oct 2025 23:30:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fUY53W3FaCg0-zN1QjXFe; Thu, 16 Oct 2025 23:30:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760646642;
 bh=h40lGdcNTNyvLU5mw33/knrPUWPFPsQfJd3GHYUd894=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=as4CHU4i6JPG0VfGPJ8qhor+cbID011FEq9mz2LfM3eEGxP+oxTxJPm4TRUHCCCT8
 wtxobFkZmA3uDn3s0nY49PWbcb0BI7znPy6oCBC6g8HCm1rHKQvKjuooq72Pc7fwXC
 SgGCOup/T3TdeKZQr8sLnFCVTr3PCLxzDD0UTYoQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0be14ddf-ffe8-4e43-a481-7912c224be47@yandex-team.ru>
Date: Thu, 16 Oct 2025 23:30:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 farosas@suse.de, sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <a36fdf7e-b7c7-4faa-8cb3-40e2433e9d8c@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <a36fdf7e-b7c7-4faa-8cb3-40e2433e9d8c@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 16.10.25 23:26, Vladimir Sementsov-Ogievskiy wrote:
> On 16.10.25 12:23, Vladimir Sementsov-Ogievskiy wrote:
>> On 16.10.25 11:32, Daniel P. Berrangé wrote:
>>> On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 15.10.25 23:07, Peter Xu wrote:

[..]

>>>> 3. Local migration, but we want to reconfigure some backend, or switch
>>>> to another backend. We disable "backend-transfer" for one device.
>>>
>>> This implies that you're changing 'backend-transfer' against the
>>> device at time of each migration.
>>>
>>> This takes us back to the situation we've had historically where the
>>> behaviour of migration depends on global properties the mgmt app has
>>> set prior to the 'migrate' command being run. We've just tried to get
>>> away from that model by passing everything as parameters to the
>>> migrate command, so I'm loathe to see us invent a new way to have
>>> global state properties changing migration behaviour.
>>>
>>> This 'backend-transfer' device property is not really a device property,
>>> it is an indirect parameter to the 'migrate' command.
>>>
>>> Ergo, if we need the ability to selectively migrate the backend state
>>> of individal devices, then instead of a property on the device, we
>>> should pass a list of device IDs as a parameter to the migrate
>>> command in QMP.
>>
>> Understand.
>>
>> So, it will look like
>>
>> # @backend-transfer: List of devices IDs or QOM paths, to enable
>> #     backend-transfer for. In general that means that backend
>> #     states and their file descriptors are passed to the destination
>> #     in the migration channel (which must be a UNIX socket), and
>> #     management tool doesn't have to configure new backends for
>> #     target QEMU (like vhost-user server, or TAP device in the kernel).
>> #     Default is no backend-transfer migration (Since 10.2)
>>
> 
> 
> RFC diff to these series, to switch the API to list of IDs:
> 

[..]

> @@ -1193,6 +1198,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>           return false;
>       }
> 
> +    if (params->has_backend_transfer &&
> +        !migrate_backend_transfer_check_list(params->backend_transfer, errp)) {
> +        return false;
> +    }

This made me to move capabilities setup after device add in the test. Not a problem.

> +
>       return true;
>   }
> 

[..]

> -        vm.cmd("migrate-set-parameters", {
> -            "backend-transfer": backend_transfer
> -        })
> +        ]
> +        vm.cmd("migrate-set-capabilities", {"capabilities": capabilities})
> +        if backend_transfer:
> +            vm.cmd(
> +                "migrate-set-parameters",
> +                {"backend-transfer": ["/machine/peripheral/vnet.1/virtio-backend"]},

If write just "vnet.1" it doesn't work, of course. Is there some way get pointer to
proxy device from virtio-net.c? But maybe, it's OK as is.

> +            )
> 
>       def setup_guest_network(self) -> None:
>           exec_command_and_wait_for_pattern(self, "ip addr", "# ")
> 
> 
> 


-- 
Best regards,
Vladimir

