Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfA1-0004yr-5B; Mon, 11 Mar 2024 08:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rjf9w-0004xe-AA
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:53:41 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rjf9s-0006ci-VJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:53:39 -0400
Date: Mon, 11 Mar 2024 13:53:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710161612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kb1hVl98hDj4osHiQNQierdhr1VkBBKeYS86aEMTs6I=;
 b=4YOR/Wk2SIDf3GMgDjA4/Zr40CZPEypE/FDpVEWkckoL6ba9n4FfqtOK8H+QHv3JPWK4DY
 2No8YB30hUpdgu2cu+V6AAidtxW4ovjzydxi2Coj7CBh+MESVjB9lgeU/qBpQOgGzFdv6b
 DS6j7mhZCdFCDW7parQfnUrjSFDuirapgWf1khMmgNL+SIY7yyCYHAubyLl4XiMm6o/G6/
 AIxL6Ys4NniQV1pM4AQndrf0jRHFOu0ST5JvAjnIAwa9zFQl4OgBtg7ltQ5bELQIvPb4T6
 sl4cCOjMJr8QIqfkGAWSQbvR9BSTHzFlTI2TGPpX9VJNyOI35avBNgMzj4T7fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710161612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kb1hVl98hDj4osHiQNQierdhr1VkBBKeYS86aEMTs6I=;
 b=o/2PvzQ4NaJT4Nm0Ar1OdNQocrD92IHBp4o/Kh+4JtemFjcjyR5P9PLMF0mWpy3wo97oft
 kJdcOpMRkilydGCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/3] docs/interop/firmware.json: add new enum
 FirmwareFormat
Message-ID: <20240311135014-7cdc00c9-b3a4-413f-8813-7fba4516dac1@linutronix.de>
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
 <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
 <b04ef6ef-1e1b-49d6-9184-16474ad32dc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b04ef6ef-1e1b-49d6-9184-16474ad32dc5@linaro.org>
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 01:08:19PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/3/24 12:46, Thomas Weißschuh wrote:
> > Only a small subset of all blockdev drivers make sense for firmware
> > images. Introduce and use a new enum to represent this.
> > 
> > This also reduces the dependency of firmware.json on the global qapi
> > definitions.
> > 
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   docs/interop/firmware.json | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> 
> > +##
> > +# @FirmwareFormat:
> > +#
> > +# Formats that are supported for firmware images.
> > +#
> > +# Since: 8.3
> 
> That will be 9.0 :/

Thanks.

IMO it doesn't warrant a new revision, the maintainer can change it when
applying.

Locally I changed it, so if a new revision is necessary for other
reasons it will have the change.

> > +##
> > +{ 'enum': 'FirmwareFormat',
> > +  'data': [ 'raw', 'qcow2' ] }
> 

