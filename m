Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FABCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBPz-0002Pn-F5; Thu, 01 Oct 2026 03:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xCBPx-0002PS-It; Thu, 01 Oct 2026 03:41:26 -0400
Received: from smtpout2.mo536.mail-out.ovh.net ([51.210.91.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xCBPv-0006lc-2u; Thu, 01 Oct 2026 03:41:25 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hwP3x5QmVz89l2;
 Thu,  1 Oct 2026 07:41:17 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  1 Oct 2026 07:41:17 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.21])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hwP3x4HLzz6MfD; Thu,  1 Oct 2026 07:41:17 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id DCC299417BB; 
 Thu,  1 Oct 2026 07:41:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00325a3a1c4-8f76-4608-a16e-e59d639d4e31,
 B87720B9A20974DAEE7745F8F0A851FD039C1C56) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <330f9a96-4508-4db1-a8a0-fa36c57ed093@kaod.org>
Date: Thu, 1 Oct 2026 09:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table
 for unimplemented devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
 <941d7bb6-3205-44cf-8d76-ffbb322a6f4e@oss.qualcomm.com>
 <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
 <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 1052997888192588860
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFiFQ/7g89ddLsW7eNeMKyl9txn8OTlxJ+ljJtiJG/8Q5V5I/bs95+UaUI3bMUDFTKIU0PtphCtIXpp52k8P7ruTZ73Xgq/ibnR4Mn+ZZE5eHdj3g7H09qxNIQipS7OkEeLr9vjN7On2RAI1vt0RzuwdmnFr6FRH7BzrNEXCZecquKx2q/th/dLFwDwRaTd5psvSyGSSE19hl+QgWVjugtlqPyoc9srbN1ZVmFxNywcRboueivOGLKoatPVl6N+ZnfCF7LqHOC1l+pWOUdZ04dS2SP5GhqTyWlqodlduZ3fsZ2hQ2liLaJC30YwFt6KnEMqeqq3UHdaWEDnNqF2a4jKQM7ZGt+xZArC1fqet7FwmFPaALpsTAnCQIJtzj+IKTwxR/OamLqh5PusSWiF8wtkPm+fQOgtiG27r7RQboHXKiCik2ZYTswiZorTPa5zS6tdV/ltBtAWG5NA4DIvitHLHnsFw/LWbAAvgSR26JKXjMer80MUIlJltM86Gp5tZtHDuEwTsqdmAIbkI63zQfqZY1p7B/8b47i7eNzKIEUhwuEIbawPcfPPaaXFtAKxaIq9gtPKJhS3dsuHxAnt3fAj1z5hTuWS05OLnAsexzO43aQCqDjtCOclY+Touy9cNGcQOlq9cGlAtbTVfWctOmIPsWxiokbY8sfM+zBlvRUiyg
DKIM-Signature: a=rsa-sha256; bh=uMfARK20eBcOEeEbvRRqwd9flngVD2Gsf4oq3y9DkbY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1790840479; v=1;
 b=DSGbTDRDicaR46puhb+8AigPWQ/F5nKSHQ0JhKTBIEmpLFNvcjyPNRCMSIX0/Lk5RGp26oty
 rH1a7vHyX7xJswq0GY6v1d2Bv5pDMUv2ZxxlZiQIEn2XNIOxkfIL7HuJEWWJSkf8Fx2ile9N6z5
 1YhvKGEBNnSutQSuGFh6eujV3vx5+SRnQXCuo9R3J5KbiUlnzpBxIi6WI1Nw19KQYNIx7f1ROh5
 ++C0XhcvKnEQKFcUR67kj6TBb0r3/nHTQKEsyyt6hPOL2MEO4q4y4zsnU788JS4MoYID11QzzE+
 qMFcb2Ab7wztVejmMZ4lvqYbDBH8owesq3C6YwkxoaGHw==
Received-SPF: pass client-ip=51.210.91.11; envelope-from=clg@kaod.org;
 helo=smtpout2.mo536.mail-out.ovh.net
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

On 9/30/26 14:16, Philippe Mathieu-Daudé wrote:
> On 30/9/26 13:50, CÃ©dric Le Goater wrote:
>>> Note to Peter: I really think keeping duplicating the
>>> UnimplementedDeviceConfig structure is a basic software
>>> development antipattern. Could you reconsider your objection?
>> What's the background ?
> 
> I think that was discussed on IRC, the only ref on the list is:
> https://lore.kernel.org/qemu-devel/CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com/
> 
> create_unimplemented_device() calls qdev_create() and allocate on the
> heap, my motivation was to have another helper for in-place init (when
> the UnimplementedDeviceState state is embedded in the parent). Now we
> ended with such helpers like aspeed_mmio_map_unimplemented() which
> realize in place, make_unimp_dev() and create_unimp() init and realize
> in place and Jamin adds yet another pattern. While all are valids,
> I'd rather unify.

Could an array such as  :

static const AspeedUnimpDevice aspeed_soc_ast2700_unimp_devs[] = {
     { "dpmcu",  "aspeed.dpmcu",  ASPEED_DEV_DPMCU,  0x00040000 },
     { "iomem",  "aspeed.io",     ASPEED_DEV_IOMEM,  0x00FE0000 },
     { "iomem0", "aspeed.iomem0", ASPEED_DEV_IOMEM0, 0x01000000 },
     { "iomem1", "aspeed.iomem1", ASPEED_DEV_IOMEM1, 0x01000000 },
};

be defined at the class level of the SoC and handled automatically ?

I guess would need some kind on common SoC model in that case.

C.


