Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F2AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2quX-0006d7-7F; Fri, 03 May 2024 07:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2quP-0006bv-3U
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2quM-00018b-7V
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714735012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbZSpLSoe+B//UWXjs8H4vpk5v/k9IKw6936FykQ1MY=;
 b=HjUMySjvZ9wURSMaAALBtpwSK5u14sbAMn/skf93h2mLq3I0XrdKbtoC2tMxv8BbXW5oaj
 Te1G2pbcQ4C8q+N8mkjU7Kh57Bfjz91HEDT0u0DSjKpL5V1Ex/kFuHz6tt2QAEVlI7VL/u
 gFMVNcUjxs24YzR6XBkgg9NihD936B8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-RLndnxKVPRSC-mjZRXJdSQ-1; Fri, 03 May 2024 07:16:51 -0400
X-MC-Unique: RLndnxKVPRSC-mjZRXJdSQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5192d01f465so8924521e87.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 04:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714735008; x=1715339808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbZSpLSoe+B//UWXjs8H4vpk5v/k9IKw6936FykQ1MY=;
 b=XJDgk1iIMs5oGKJ2cDQFTCsp/DGw3x8ixA1LuV5f8ooIUFWDs8c4d3blSeYcr6s92N
 qTCmBBsWp7NtymOm7CWWfGJP6isMAfGU3CukAxm657Rhn5DZDOlMQBzzBegvX+MgVn0Q
 zeEK/dTJ/KaiT2yThjkWsGvQg115LN6xAKv92lJZ9zgmjQvSCfjuGLlNQJq/1zbwitDX
 oZpzLEK0hhJdnNBsJtXH7SmLDmWyOSIDgP4b2AN/4xkOV7SnDeF7XuLzm6cUFO4VyC17
 w3MfjA2wkkhVz83Mmd3ccddbi3EmhtRjSmjkNwQq+wlT0bpyFYwgO+jA+xjn3B7D1RC/
 vd+w==
X-Gm-Message-State: AOJu0YwSGco/rQFRcPTEBvg4HPboI641LAKOmz4AP6NxFo1NPpamUWMx
 bTE9LxcvhABXiDsF+hSWkpQp61a8xVtzmyY0HU8DKg88jsv+p2XbOCfAcVrWbu8eB/2Kk6NjYre
 wjiY3pTwJjwVPsdJ+kxRdWAlKOLdcdHVJDqzANDpMDqakY/Y74xEk/n9caG/sVSyM60L6FKY4bg
 tpev5Mw8+7kTQTtUg0xUoH10lUPRs=
X-Received: by 2002:ac2:544e:0:b0:51d:9a0b:735a with SMTP id
 d14-20020ac2544e000000b0051d9a0b735amr1595615lfn.53.1714735007781; 
 Fri, 03 May 2024 04:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVBbhC1r7KpK6wXsU4Be1h1f+oPEqIg/GsR6oJC8u1hsgCeH4i8zy4HRIKlzMD2mmDJTmwF5HKv8tapl165sQ=
X-Received: by 2002:ac2:544e:0:b0:51d:9a0b:735a with SMTP id
 d14-20020ac2544e000000b0051d9a0b735amr1595599lfn.53.1714735007347; Fri, 03
 May 2024 04:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240503091657.26468-1-philmd@linaro.org>
 <20240503091657.26468-2-philmd@linaro.org>
In-Reply-To: <20240503091657.26468-2-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 May 2024 13:16:34 +0200
Message-ID: <CABgObfb7QQYdc5iqLME+eBhZG6nay0oacYFz+ANO2eenQOonqg@mail.gmail.com>
Subject: Re: [PATCH 1/5] accel/tcg: Simplify meson.build using subdir_done()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, 
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 3, 2024 at 11:17=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> If CONFIG_TCG is not defined, skip this directory calling
> subdir_done(). Then since we know CONFIG_TCG is defined,
> we don't need to check for it.

You can only remove the check if you assume that TCG (unlike e.g. KVM)
is enabled for all targets. Of course this assumption is true right
now, but in principle it does not have to be - a long time ago,
qemu-kvm had ia64 as a KVM-only target for example.

So I'm not sure this patch is a good idea. A lot of it is just
replacing tcg_specific_ss with specific_ss.

Paolo


