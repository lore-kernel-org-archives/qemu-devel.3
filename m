Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F475606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bLqe4ocb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBzK-0000cb-36; Tue, 20 Oct 2026 11:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xJBzF-0000c6-4H; Tue, 20 Oct 2026 11:42:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xJBzC-0007ja-RV; Tue, 20 Oct 2026 11:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792510962; bh=83ydbAwjL+omjB+1IVKaQlsD3ZjP2neSu73yMLyApFk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bLqe4ocb6qBMUqBbPC5aT+cRjBpTJyQlGgY4VZknEteNtZnFOB9e815T3NB0ZTvK4
 wlLvx4xXe/plyuESw83EpswRmM7gGLWJ6aHFn0tC1L00zCFqmVP5D/gPse/4LtGPPt
 VO7hcEq4qOYxEwxDv3HffJhEOQRuBgZyJaMsC7FQMZHdMpi4EgyFVqh2r/uj3q324P
 aD0Sw1VWq5zc5jetJwIIgH+NvzMQk0VCv+lyhj+0PvkqHwP9hDPF6JIy7At0DJkK6y
 Kw3ECLTkC+U9F1Ic6gRdD69z+ylB3xZK5qSTlpBgd4YYBreBRPZWixoxbJg2pUOffg
 OoBS9vu4H90oA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 106F21DF3BB;
 Tue, 20 Oct 2026 18:42:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BC3AC446580;
 Tue, 20 Oct 2026 18:42:41 +0300 (MSK)
Message-ID: <623429ea-d915-480c-bd76-3052d85bea7d@tls.msk.ru>
Date: Tue, 20 Oct 2026 18:42:41 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
To: Peter Maydell <peter.maydell@linaro.org>,
 Lucas Cardoso <luc.fast2004@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, qemu-trivial@nongnu.org,
 marcandre.lureau@redhat.com
References: <20260428162048.2995097-1-luc.fast2004@gmail.com>
 <CAFEAcA_77=_28DvN7R=ARg2ysW1UjSMnUSVYqZN8-Ge2ucY2vw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA_77=_28DvN7R=ARg2ysW1UjSMnUSVYqZN8-Ge2ucY2vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 13:41, Peter Maydell wrote:
[..]
> MJT: are you OK with picking it up for -trivial ?

I picked it up yesterday (now updated it with your R-b).
There are just 3 patches in the trivial-patches queue, so
it dunno when it'll reach the master branch ;)

Thanks,

/mjt

