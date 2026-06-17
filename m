Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72542CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZulu-0001tq-LB; Wed, 17 Jun 2026 14:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZulM-0001rg-HA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:13:25 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZulG-0005q5-MN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719991; x=1782324791; i=deller@gmx.de;
 bh=GFnfr3b2v+B7Vz7YEeQLoMkCktB2aL861Ix5bo291qM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YBp5I8nZKikdPhk4z0yxm31XdLLgoW+yVn8SOTaeWOZ9PIqy1x9TfYUI9eA6YE65
 q/At0Gv29iyXv/pj/EbjITbWKHbDp1tIo0zcv9VvoRrjyl0X9OPzymq4bybgxc8/Q
 rDtN8HQKPP9zTXjteqSwXB0Jjwgy5TfU3wEGBOeM3ERNk54K0Sz+aRJHsWs11nhZ5
 491FS6xrFgplfexfkrfMWtLHznVEPcObhMBJdsyAfViGdwcXBi32Fz4rmoT6y2Xl0
 oUiBjEZNT664A6VtDvA2O2L6e23pEqEbvzQ0p9JLR87jWNWD6yYKns+qYEvGApleX
 0PRylt/QSl9+xqluVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1xKhmS32zv-00uOpG; Wed, 17
 Jun 2026 20:13:11 +0200
Message-ID: <2d931e6a-394a-43ab-b533-634b48556aa6@gmx.de>
Date: Wed, 17 Jun 2026 20:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] common-user: Move guest_base, have_guest_base to
 probe-guest-base.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-14-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616212055.334466-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aq+bGLI2xX9dji0qRtf4uD8C0dM4sx1XhDOqySozQmKo6MKpbO7
 6B7fiUweRCVlZcqwtNNoekZwN8wFco1Ds/UEvkmL47HrIehyiB1/M1+rtBo7ZM7edtbqfAX
 EnFUYTIxBy4CSRFDiPBXeujkDgQp4ik7fr8ert4DEOkzX9UlFc05G5Wd7NlVS/cYTI+z0DJ
 Ei6a6NyvR5L0VCf0+HR0w==
UI-OutboundReport: notjunk:1;M01:P0:CjsvDX1oZ9E=;gmZxPyJs4I4UqT1Rqz+n+qe0DMz
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/16/26 23:20, Richard Henderson wrote:
> Unify the definitions of guest_base and have_guest_base.
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de


