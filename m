Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADEFE9128C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntrO-0002uP-3s; Thu, 05 Feb 2026 02:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vntrG-0002rx-Ni; Thu, 05 Feb 2026 02:32:58 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vntrF-0004cZ-45; Thu, 05 Feb 2026 02:32:58 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 87296C039D;
 Thu, 05 Feb 2026 10:32:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sWkJq00ACeA0-6SodouXg; Thu, 05 Feb 2026 10:32:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770276774;
 bh=Z/b70szdjCi6bywASzQB+sggSwatcHwKOsp3X72EzS0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=i41szIwjTLDzGP/g+D8zzqSylnlj/+hClngJ2BRmdprMCO+/YHaVnkukILx1x9Z+5
 PzMXWVIE8T2nsiTM9C8Qk+yvha/c3hPoHr7HYctNcWhmiG3YHFnOB+nnXFliNjvSOS
 tTGB9Mbr2LIMZ1Lnw7MI9B9oNwEipyiqt5XLLVoE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <74b1555d-1e4f-4be2-85e4-902f9670e435@yandex-team.ru>
Date: Thu, 5 Feb 2026 10:32:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260122160113.1147745-1-vsementsov@yandex-team.ru>
 <87qzr0y990.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87qzr0y990.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On 04.02.26 15:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Now we have blockdev-replace QMP command, which depend on a possibility
>> to select any block parent (block node, block export, or qdev) by one
>> unique name. The command fails, if name is ambiguous (i.e., match
>> several parents of different types). In future we want to rid of this
>> ambiguity.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> We have numerous kinds of IDs, i.e. names chosen by the user than need
> to be unique, but only among the same kind.  For instance, you can't
> name two block nodes "foo", but you can name a block node, a block
> export, a qdev, and a network backend "foo".  Using the same ID for
> multiple things is of course a bad idea.  Permitting it was also a bad
> idea.
> 
> Your patch rectifies this design mistake, but only partially.  Consider:
> 
> * IDs need to be unique with their kind.  This is what we have now.  I
>    don't like it.
> 
> * IDs need to be unique among their kind and possibly some set of
>    additional kinds.  This is where your patch takes us.  I like it even
>    less, to be honest.
> 
> * IDs need to be unique, period.  This is what I'd like to have.
> 

I like it. Is it enough to write it so simple in deprecation doc? Or should
we still list all such ids we have in QEMU?

It may be something like:

Any kind of IDs you use to reference objects in QEMU must be unique, any
used ID must reference exactly one object. This includes, but is not limited
to qdev full and relative to "/peripheral/" paths, block-node and block-export
names.


-- 
Best regards,
Vladimir

