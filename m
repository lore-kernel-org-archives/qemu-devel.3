Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92702CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5wS-0006lP-49; Wed, 14 Oct 2026 16:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xH5wQ-0006ks-HG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xH5wP-0007l0-7X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792011071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMUKVI0Lf7KCa8iu/hZReoG6yU4XshIK5MLCYU0S9ds=;
 b=dLARDzRojwpQlRJasLXBWN8yZ2oTzyiEGouA3v1KqO2jUygDpuzQd8dZ6/Z4mN7/eIxKIx
 a9qZvYiLhxmMZ6SOtOoCat2Z9VcUZmPevB5WRiiNMBq/x6SfirHmsncZj02BUC7qHUeHcK
 xH/cehIWwatoQ8vfBtM0cK1yTIt+md4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-E6eGSKCMMZisVkHkIRU_wg-1; Wed, 14 Oct 2026 20:51:09 +0000
X-MC-Unique: E6eGSKCMMZisVkHkIRU_wg-1
X-Mimecast-MFC-AGG-ID: E6eGSKCMMZisVkHkIRU_wg_1792011069
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5350ec54bf6so93614721cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792011069; x=1792615869; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nMUKVI0Lf7KCa8iu/hZReoG6yU4XshIK5MLCYU0S9ds=;
 b=CI5fofEVE61lKUL3KbBVciGTtEo5X+ZWw0J+fxe+cfwwoncsOP91mLBXkLFcdHUfdM
 o2RiJ4wL++vDFw+nEmKoQeJR12co743MJaf6rohWaIjodwL6LEKY3p4qAp2MTQJJTKXf
 O2liHOwemQ5jJ7YsJe+Gcpxu38mRZCCHfxeFN8EAWT70sdFBvbl49s4ZYsi3BqEPId1A
 s/2bp8lRpsWcUhyG3MebXPhhemp/Dyh5CgtHf3tJ62wMJBW6RXldbxVg70Y7hi7wTtgf
 KzlfAANNdCmVInM5j3LvVKiOH1FZNLKHh+goLVfUOrEhrAqNBR1+WFL/xAuioE395LPH
 bCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011069; x=1792615869;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMUKVI0Lf7KCa8iu/hZReoG6yU4XshIK5MLCYU0S9ds=;
 b=h7Fv/8Qzwu7vWS5X3aCfSRZMDtvoDEyF9g/JQLytuAc35RQP+ku8jZv0D8YCsD6Z8z
 6vLcywd4kXhqUK77XQDrRDuaPr4z5u9jnH3U3WgUnVcVRSRX6gSLVY7Ebl+BAeHaEoan
 mB+Yo7rTq/u8bBgu2AwIwb0DDxrodWeXlIf7IReNHb7lsr5mlciZAuof5fG12yPomjei
 wLPCcbSr+8D9+HlcebQNYVI0rGbx7meUkHIt76kRYfr0I8cJGeloNQOW8/sznGlJrCQr
 Pgn5jFGZ+UPXePr+XuQNRj5XkvyOai8lmQi5x9nwXSgGk+NdSAHt7BC4yljPk2YIx70q
 588g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8+Zr/fYzkuJ7RUwIpVPIEcoulnwhJXZM0EI1VH55ZP4+DJGUCU+okiGBi86PrmmDahNHBa3A65hoY@nongnu.org
X-Gm-Message-State: AFq9FYJNeYiKGc6TwgBvrv2WHGkGFDeSMJDmXI+E19fWlMz00zhYMUmO
 kydbgLzmtO2KxUxsPTg9qnFyOsITjvWSwBJx6A59F38w5KkLq5sdk+0H3wtd7UiB/Fgd4hHef3u
 SunE36zlwki1mxJnozDCSXqszgtzTp3ib4Vz3if6c8Oo9goLblVUIP4ut
X-Gm-Gg: AYBFou3z1n/JDH85+qhZERemtAR23TyynZ0w+pCL0OJsIuLhfuslhpFcutik4mnjNPa
 2/imB2jNQ6uoAigA0BtgplAznNIkWPDlXHZH6Ypc3/N4Ecp3qKqaE0PDErcp+Z9LBE3FxhIOM/B
 KjMf0Rv4+Jn6tTaPaqDpBVV6vmIiV8ood1ZPzKDc3NHTQf3JBsXt4akcwl3//IzLeYaL9270yiJ
 cHQD90k/87qiVg1bdJQPXj//8+4iHr3rtLvSArGAzsz00DGEtgtqNmZavEkH/E35GTv6Ou3TwpB
 hpQamAWUUt2YEiHwpbVNwgtJj4FBKOsnQI1G+L0esnm2uedr/CQZpTyVZEgXMaH2Ud740co=
X-Received: by 2002:a05:622a:1104:b0:535:a5fc:3b56 with SMTP id
 d75a77b69052e-535a5fc44edmr280349691cf.66.1792011068888; 
 Wed, 14 Oct 2026 13:51:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1104:b0:535:a5fc:3b56 with SMTP id
 d75a77b69052e-535a5fc44edmr280349271cf.66.1792011068204; 
 Wed, 14 Oct 2026 13:51:08 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5361269e0e3sm6772581cf.3.2026.10.14.13.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 13:51:07 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:51:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
Message-ID: <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 14, 2026 at 10:18:45AM +0200, Alexander Mikhalitsyn wrote:
> > - for this test, should we remove snapshot=on but instead create an
> >   explicit overlay that will be used on both src/dst qemu?
> 
> This should solve the issue too, at the same time if test is R/O I'm
> not sure if we really need this.

Then.. maybe no need to bother. :)

I think we should better remove snapshot=on no matter what, then whoever
sends a patch add migration blocker for it won't fail this test.  Seems the
/tmp mount is still needed then.

For speed control, IMHO it's not good setting bw either too high or too low
(similar to downtime); too high means converging too fast, too low means it
won't converge.  Maybe we can mimic what migration-test.c normally do in
qtest?  that is, we do:

- migrate_ensure_non_converge(),
- allow a few rounds of migration precopy to happen (e.g. query-migrate
  shows dirty-count >=2), then switch to,
- migrate_ensure_converge().

Then make it generic in migrate_vms().  I think it can be helpful too for
future migration functional tests when it's not always idle?

Thanks,

-- 
Peter Xu


