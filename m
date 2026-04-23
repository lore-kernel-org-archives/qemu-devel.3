Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D1FC0360
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwWy-0002MA-S6; Thu, 23 Apr 2026 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwWN-00026A-Sr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwWG-00074l-TX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776960190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+jjOKI3lM3aGymycKN4JAGzsgHGzIKbItTOkEQ6LxU=;
 b=hH0mnnddFB3nAuCz+NiyEzslka505keSQNBDKtu5KpokFfx/B1OKp5S++kLP6XEx9TM1/J
 1eMfKyuL/5KqPQXqlt6SlvfvNeYlJZM5Xu86eNiKCDZi8l+I9TjRboRwAuMboJliUpPSmf
 tyJRPvxRQqIuGfB0+zFtzzyuCJ32OzE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-71kO8YcePmyfMO-PoFMNxw-1; Thu, 23 Apr 2026 12:03:08 -0400
X-MC-Unique: 71kO8YcePmyfMO-PoFMNxw-1
X-Mimecast-MFC-AGG-ID: 71kO8YcePmyfMO-PoFMNxw_1776960188
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eb04352924so900303085a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776960188; x=1777564988; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+jjOKI3lM3aGymycKN4JAGzsgHGzIKbItTOkEQ6LxU=;
 b=MkvXnT3UDXPv5E0CTauMdaMwDQCGTSA22NpOIade55P0u4Aw0+BiBCk9/c7l5yKPYO
 Or28TGnHMT8eZQDwTkd7cwNsTVttBq2ZkpUqL1oxXSIsZmh4xuxzSJApNoGF+gk97qYF
 DQY8UvmizeaU9NqPnqXXjiAxATQxmlLTiLm+W8/ZtOYMTpVFDLUht87tb3UMD38y/gHc
 7+Zs3VzJNSEupn8VGhISmQEyEyFos9H6B4icmHk2ZNAZcNbr8U4wcN76LHOOjRSC6Qyd
 VjLYdQFBz9MWPFwaIZi6O+yoXLPvraQ88AkLfKzcz/QE1b7QsAUFb4cWl0YiLmdzTW3L
 tQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960188; x=1777564988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+jjOKI3lM3aGymycKN4JAGzsgHGzIKbItTOkEQ6LxU=;
 b=m76bPQLuhp3FzPB+FLQgmhwy8LBJgDQcBVfJ27c8q3wb+Evn22R1pCOFl1JMm/ztxo
 E2PUUdYSDpvuj6sEIKcoXP6Hga3x2Nvsd+WBv30bRte8np7Iu8Fj6zqhaIW386avGL29
 HG1DyVEaxrLN/Un90XfYZzNvTKwHx9uN7rS/Og/uLii74n82vVdz/xTfABDMfbqVz2ZR
 0wBNZst3iI+O9Jq5NB0lmQ7pm1AnxkRt4F2rGVBiHRK4sq+P6hUSldr7Q/D3hVvIUyn+
 3COEH6pUC6jgKh9GxB6Y+/HKiDJYAL61knToN91FqX7dlXrqW8cg6Di+OqBo6mlNCyS8
 reyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UlWnbaL5kBGujwZ2oNqtaAFTlr5G7/XBswDs60n3G++eI5XIsUFhdZm5KonMy62Ekcc8Kk1W+M72u@nongnu.org
X-Gm-Message-State: AOJu0YybphEWS2lu9wb7J+InisDQdS6xy6c9tOSp0j+F1fk5xw1a21sV
 WASHYk9Pi4umBVihNXJdf1oCEivJoPTl6Xkb2q/O2Vvx+sXeT3O56gOGxsDo3/PQx1uBLHGjpNH
 p0AOyiC+B70YfSIVFD/t6+KgW9zP/rnKsRCKCUG9XOJyqIajd9edmtYjI
X-Gm-Gg: AeBDies7n6D0U4gY4kcdyzerqS+dEHVaWo6kLkIlekAH96t8cte+mgqnYXaA22XnAn7
 vs1ymIDcHxqaGNrx/GPv6FJ/ryQskyWvlv+maomrSFiSIgvzUj1lP4MYemorIxAGQ3pG8BI24W7
 8EoeFHRWTQc+8v8Cst25wpnpa6dox/yes2WnT49OdHCD7OhVN37NrowXxUjIRNULUYpZ5OSgwmC
 z2qFlIKCN+ykmWrpp/wcJy87Ix1Z2FzeGz4ViPzv8Kc26fkYIpEDIAtd2MfyVLcZMHiuvNK9CFV
 H0c4cPjMIuoZCP5PvjHAvQ6BeRT/fy2ffV6/zI0WGdHQ93aiDfGuKBh22+SI8GaCLj3Cgto+A6t
 9o5zCNmO1VpmOP2W8y39a5ACBURsIJuzDaVU5DkRMU/xz50PIffq9rV23Lg==
X-Received: by 2002:a05:620a:4455:b0:8ea:addd:8954 with SMTP id
 af79cd13be357-8eaaddd8df1mr2638346785a.24.1776960188156; 
 Thu, 23 Apr 2026 09:03:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4455:b0:8ea:addd:8954 with SMTP id
 af79cd13be357-8eaaddd8df1mr2638338685a.24.1776960187476; 
 Thu, 23 Apr 2026 09:03:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ef47be2d91sm612562585a.12.2026.04.23.09.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 09:03:07 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:03:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Message-ID: <aepCuBHa8kl0qT96@x1.local>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org>
 <aeJNdLTRSZQiEiP_@x1.local>
 <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aeYrfQuAsEaOpH_O@x1.local>
 <TYPPR06MB82066A191FB2B0AD05F7C295FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aejdEO2CXg-QuGcL@x1.local>
 <TYPPR06MB820607B5BBAD8C8DC0A4D2DFFC2A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYPPR06MB820607B5BBAD8C8DC0A4D2DFFC2A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 23, 2026 at 01:48:36AM +0000, Jamin Lin wrote:
> It seems that we need to use the device type name here.

Heh, yeah, you should be right.

-- 
Peter Xu


