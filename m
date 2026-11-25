Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8A606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JR+0r6/B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAzO-0002Zi-Jk; Wed, 25 Nov 2026 06:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAzC-0002ZE-AF
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:16:27 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAz9-0006L7-TT
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:16:25 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6ba1e22ff4dso6641017a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605381; x=1796210181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4iv8A6gqUfnNbo5/jmNa9lhvSF2xOy75Oyi24duA5IU=;
 b=JR+0r6/BxGFCVZXFTRP+xWwtLNUM1ogmFLZFzGwPLcewHhaZQ0hTBf+IMPrNEoDDLV
 GgER3NoudLs/AzQ+drXXhdBoP6OO/eQFdNc6K7+iqEnzh80qr46ESdHn3vJRCwo8ldi2
 rBXZZidpAbUrKVKDtWFKIkz5CKmxsPH2by7D4nASB72Clc9kqW1KfWtfvrBS9r8DLMar
 hLsjUx075olYE7B5tDN69B3wLipniByM1zQL8hfdenB9gjAEdmsVrlykzsztd3Pqk+y/
 Etmr0BooM70SuIv5Hq/ijieX3C5q+V1hxrTuVAkF3LorohKUzhi0fA9iJa2b0AXtVPic
 JGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605381; x=1796210181;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4iv8A6gqUfnNbo5/jmNa9lhvSF2xOy75Oyi24duA5IU=;
 b=PNTsqqtKJYGMUqUzxQb6U8R44X064QFjPohMv0GVGtlfde5m67359SZd/MxtY8gBcR
 taahVa5DDgOJ8yNwoN/xEtuS7lLm7f/sXAQu+c6MUxAn3CD8wmkDaNPsl/Rm1ykv18hU
 QcsU3iD4ZyE9vR/2VtPWA1OJ//EcPqQ1Kmgh08sL7ofIbPdAC0V+bNX7G3QXGudXRzot
 FxQIDTPCfdIlnXE81mG2sLlNr7CFkKPRoerjXwR6RXh0bo/rr8TqJEkhUPFDO86s19SV
 RuZ++0m3WPjJB6pa8DAlXKcgyd/IKK28JybQvNUJCZNY2cA/70O/exxvha18RsMjZXN8
 GG2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErG97qOMgx7ciFDkGp/jhpXhEwj8oKzN464DkrzhhH/PajIgtjGVe5dC37s4iTfIILsuKN2Nx6CmIWgk@nongnu.org
X-Gm-Message-State: APuU4Z87bwO5lW87d4K/X3LLRiGopfDvVvHijW4bHn+IvHhwZPTHxEBF
 k4yfkhIAlvcQRctPykHcF2b47nNdLVITHpW8tyWpjX/yKHqm4b+SRiil
X-Gm-Gg: AZFdTZeh108cBZV2oTkUT5qSV3q/c29YUaGsnVaWCIMo/734MLP+liGT0HbVdWxH7ZU
 7xufCkZzJsGEMMDOuBJjiERGWVpUzzwXEHC9tnGTYV+C6QOijT6R2aCW+KamqnQT8PbwZL5nGzR
 Vk9/PdBxVhwSUmqkkSeA8fr3gsjcBfG92Bt5kBD8SxrMwHSFnrEk4mvZTxzW75/0YfGNCs6cetb
 K2SBZvUTWGEkCuhjcZVVcqjBo0zBZXRdlsJeQ2yqsGAzozKGZ9H3jj9pAUwsmMjYHC1MS4Snu9W
 FaQziQSVcQF2w+RpWsnE3TqEZfjVecgGQXEhR4SH0AggekmafcUK5hhawxkhGUcOHSYHdl3t/NE
 aN2pXZo4rgK319yG3+0mOio3u9dcEdEQ1w1K5GzDU8L0fTCah/ia+SyluhAgdeeMc/ile5r0xvY
 VE+XRp8raY8Z/arRXnetpO2LttYBsaAumtoUNsfSAtQ5UsS3/NP61GGeQX2uV5JVRz0vAHA+S7B
 FlqNNq24x8qPPZydW8r9PYeSYbsxloYxz/9xXqAYxn5IacHpBMEjFWqt6TbpIU0Zzz5WQVlTS5X
 13d3Pdcv/YZT4lxVvQBehpTvDPv4w8thSQ==
X-Received: by 2002:aa7:d351:0:b0:6b4:86e1:cc67 with SMTP id
 4fb4d7f45d1cf-6ba37ea0b91mr9087571a12.27.1795605380976; 
 Wed, 25 Nov 2026 03:16:20 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba9b131d3bsm5256928a12.34.2026.11.25.03.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:16:20 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8e8fa5ae-f30a-4e38-8aa8-cd46e3b4ca31@xen.org>
Date: Wed, 25 Nov 2026 11:16:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/21] hw/i386/kvm/xen_evtchn: Fix off-by-one in
 do_remove_pci_vector()
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-9-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The empty-word optimisation advanced pirq by 64 on top of the loop
> increment, so the first PIRQ of the following word was never examined
> and could retain a stale device binding after the device was removed.
> 
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 3aff01b5d6c..d0807f5fece 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -1701,7 +1701,7 @@ static void do_remove_pci_vector(XenEvtchnState *s, PCIDevice *dev, int vector,
>            * and cache lines).
>            */
>           if (!(pirq & 63) && !(pirq_inuse_word(s, pirq))) {
> -            pirq += 64;
> +            pirq += 63;

I guess I'm missing a subtlety here, but the test only fires if pirq is 
a multiple of 64... so why is advancing to the next word by adding 64 
not correct?

>               continue;
>           }
>           if (except_pirq && pirq == except_pirq) {


