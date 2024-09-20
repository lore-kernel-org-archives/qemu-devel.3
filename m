Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB8CF58FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sraAp-0001sB-Tg; Fri, 20 Sep 2024 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraAn-0001o8-DA; Fri, 20 Sep 2024 05:43:33 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraAk-0008Bt-Bt; Fri, 20 Sep 2024 05:43:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a3:0:640:33b5:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 817BA60A56;
 Fri, 20 Sep 2024 12:43:21 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b599::1:1f] (unknown
 [2a02:6b8:b081:b599::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JhLbI00Il4Y0-dJegXc5Y; Fri, 20 Sep 2024 12:43:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726825400;
 bh=/erXn1UaMbgZx2LImnxCK8/aOZ0UZ9bRAQYTlQKMZmo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=r9iAvgRc/kmqr2vNui7odPk3/JoyrIdrkhTAOAODGsE9AvcZQWC2dCNr30bbEU6wm
 Cvacm3zdu++cC4xSlNYWu9qU2oG8LLw1G4Vth6tdjcx/nY2CqMGTn+nQNoz9g58blw
 5vS4joa/OWXojlyUsi8y07ETbPOW7UEBiA3h4OBM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <617084dc-4706-483f-986f-75a9175148cc@yandex-team.ru>
Date: Fri, 20 Sep 2024 12:43:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, qemu-devel@nongnu.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <20240911055131-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240911055131-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

On 11.09.24 12:51, Michael S. Tsirkin wrote:
> On Tue, Jun 25, 2024 at 03:18:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> v5:
>> 03: drop extra check on is is runstate running
> 
> Causes build failures when generating qdoc.
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/7792086965
> 
> 

Sorry for a delay, I'll send a v6 soon with fix for that.

-- 
Best regards,
Vladimir


