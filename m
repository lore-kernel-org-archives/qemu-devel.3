Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891CBCDD1D4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 19:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suGyS-0002NL-V3; Fri, 27 Sep 2024 15:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1suGyP-0002AC-Cl; Fri, 27 Sep 2024 15:49:53 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1suGy8-0004hZ-PO; Fri, 27 Sep 2024 15:49:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0C60560A96;
 Fri, 27 Sep 2024 22:49:28 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b735::1:26] (unknown
 [2a02:6b8:b081:b735::1:26])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QncdV00XmKo0-Q6w94BQi; Fri, 27 Sep 2024 22:49:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727466567;
 bh=5USaEMkv4jDR/BPQFvDb8f32jRrQ1EoPZpO806QPYaM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TgbdUO5Gep1m0UNglQj1zJueXYnc6/Iln++37F4Cfyda//QNRGuGzh0L+lga3dOpB
 at5cv243twWWoPAz78v4uknlK9fcimnRWp028vZVe08fX5wjv8YIYzPl609Co3cXcH
 onVsH+9agtc/11Pldn94QI+DINptrMAlV993ER6U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cbe6383f-711a-43b7-8d45-43447b1a945b@yandex-team.ru>
Date: Fri, 27 Sep 2024 22:49:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/co-shared-resource: Remove unused
 co_try_get_from_shres
To: dave@treblig.org, jsnow@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20240918124220.27871-1-dave@treblig.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240918124220.27871-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18.09.24 15:42, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert"<dave@treblig.org>
> 
> co_try_get_from_shres hasn't been used since it was added in
>    55fa54a789 ("co-shared-resource: protect with a mutex")
> 
> (Everyone uses the _locked version)
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert<dave@treblig.org>

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir


