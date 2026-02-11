Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5897ECD6D6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJ5X-0003yr-80; Wed, 11 Feb 2026 17:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqJ5Q-0003y7-Tm
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:53:34 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqJ5O-0003kh-TH
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770850395; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DZ8q0m6Ap8BpDtIiS94U7kVED6Jg1R08cXZQhZAN65NhICLRi7sV7/yyOLaKscTDDLA7FDQc+EJf9Cd4sT8+jUihmkn6Q2MYWfKhfjHrLRPlORf7gT45xORA8EEPPyOe+YHhEz81SHS7Yq07OSOOYm3tnZDSRjSuCosYe9bk+ko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770850395;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a/wM1QFzoEAq9RRDgNO+yo/8sgy8zfaQPCYlRH6CPFE=; 
 b=IMov7nksQgWTXaq/dDY2+mPhQZSYIeQ6p/lDCbkUxbRli0k1NJFnO5I+G7bw6mIZMxe1lv0/Owxrd4A1wPUEP5YluSYUJFgQ64aLtp1rw3KlXsNSvqbafJYTxLnwKsnp/gDJnxZqTV1cfhUWLe5s3A82c9ew1AZmEao1slr00S4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770850395; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=a/wM1QFzoEAq9RRDgNO+yo/8sgy8zfaQPCYlRH6CPFE=;
 b=anja0ZPctwBxc+7j/wE/qb4wc30ZDfuGYz26qvGahTRx2VQDbMKQ25f9Usxygxic
 mtdpKS4d6re4yPJvLlqN70EFYUJs8QHvnKpipLLWOrBmQOA62CTnxLW3TvK+qHBifZk
 BP8RbpEYXF5rUHa2LMhXwbHwoC5heI4uCu8hCHE8=
Received: by mx.zohomail.com with SMTPS id 1770850393167660.1397072795886;
 Wed, 11 Feb 2026 14:53:13 -0800 (PST)
Message-ID: <68223045-effa-4319-817b-1a31f227c081@collabora.com>
Date: Thu, 12 Feb 2026 01:53:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Joelle van Dyne <j@getutm.app>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/12/26 00:32, Joelle van Dyne wrote:
> Yes, it does seem like v1 was picked up and not v2. v1 was broken for this
> reason.

Thanks for the confirmation. Most likely you will need to send a new
version of the patch fixing the applied one.

-- 
Best regards,
Dmitry

