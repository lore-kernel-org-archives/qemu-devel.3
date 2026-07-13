Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7311EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjD73-0007zC-5r; Mon, 13 Jul 2026 05:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjD71-0007yc-1F; Mon, 13 Jul 2026 05:38:07 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjD6y-0002Q3-Bh; Mon, 13 Jul 2026 05:38:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 0B8BD80D23;
 Mon, 13 Jul 2026 12:37:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id sbKrT10a84Y0-nOS8gQZY; Mon, 13 Jul 2026 12:37:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783935477;
 bh=CTcAYbgj/3lc1gK9l4ZVRRXqBQQM2jCl6PzUptJwolI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EH+sRfASNV1d5CFYkTftwEXBhDoGEt6XsF0SygT6ZdOLSfYH1FyP1Fjbq1Vg4PSzk
 pSFh1wuhrml/eqZ5oFxLccEtjrLCnSXddTt/TeusIY/TkhltWaAybsFD1E5MbCNG5b
 BSz3uoFWpf3uXREd+fqVoM20dDFL14ppCRni+uN8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d1ea2c42-7990-4529-b9f8-d0d9e35ffd51@yandex-team.ru>
Date: Mon, 13 Jul 2026 12:37:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 03/14] net/tap: deprecate "no" as special value for
 script/downscript
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sergio Lopez <slp@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>,
 "open list:Incompatible changes" <devel@lists.libvirt.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:e500" <qemu-ppc@nongnu.org>,
 "open list:Microchip PolarFi..." <qemu-riscv@nongnu.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-4-vsementsov@yandex-team.ru>
 <87ech7uycy.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ech7uycy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13.07.26 10:45, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> The interface is ambiguous, as "no" is valid file name. So,
>> using "no" as a special value to disable script is deprecated.
>> Use an empty string ("script=" / "downscript=") instead.
>>
>> In a future version, "no" will be treated as a plain file name, just
>> like any other non-empty value.
>>
>> Document the deprecation in docs/about/deprecated.rst, qapi/net.json,
>> and qemu-options.hx. Update other docs to use empty string instead of
>> "no". Add a warning.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/net/tap.c b/net/tap.c
>> index fedd48c48d2..1ec9e5ebe6f 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -103,6 +103,8 @@ static bool tap_is_explicit_no_script(const char *script_arg)
>>       }
>>   
>>       if (strcmp(script_arg, "no") == 0) {
>> +        warn_report("script=no/downscript=no is deprecated; "
>> +                    "use script=/downscript= instead");
> 
> net_init_tap() could pass the parameter name for a simpler error
> message.  Probably not worth the bother.
> 
>>           return true;
>>       }
>>   
> 
> In net_init_tap_one():
> 
>             qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
>                               script ?: "no", downscript ?: "no");
> 
> This sets nc->info_str, which is shown by "info network".  Should we
> replace "no" by ""?
> 


Agree, will do.


-- 
Best regards,
Vladimir

