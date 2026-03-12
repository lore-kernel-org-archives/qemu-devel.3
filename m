Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044AF106ACD8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kXD-0006j1-Au; Thu, 12 Mar 2026 14:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0kX9-0006iB-Dn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0kX5-00051q-PK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773339191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edNAiRfPbXPwD453S8uzDSvl80eW60e4QXb8HLWNFmk=;
 b=TFYTCYbH+9eV+av7nLt0rwvTvFwqSsLs0I28e0HpigT5HBLahmWpKhWuNacS3FaYOCAaz+
 ehPCrQLv/WhbIce1pY5zO+ysnW2uImcfBqiLENyIxreGz5fGrkn2Rsq/bgw3DwFfsx/tCI
 noLBYvFH+TrbmASkAAsZyZftFSTkqog=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-OTiDMCF0OD2H2YT83_sIdA-1; Thu, 12 Mar 2026 14:13:09 -0400
X-MC-Unique: OTiDMCF0OD2H2YT83_sIdA-1
X-Mimecast-MFC-AGG-ID: OTiDMCF0OD2H2YT83_sIdA_1773339189
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd80bea54dso732990385a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773339189; x=1773943989; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=edNAiRfPbXPwD453S8uzDSvl80eW60e4QXb8HLWNFmk=;
 b=erey98NmTrFJbRIaXmcwkkxCL0wr7i/0wt8z49Yz5rCke3SfdOcplkStq8vO9M4Ez4
 QHTPyj6wjKGnP+/SebxCM81SffdJEWRlv/GsAqA7uqK4RbwaODLUhwN0l8tJS2P7CcXl
 /94ySQSRuJblAkL8PvtFJ+43EKO/zd4B9RJceHOUbSiKYn559adDhciyLVRgYoUQzO+e
 UEkjsnJKsatgcBOWZOT4rr0mcFKgt5yxHd5Oor94d0F7dKTTqMpg06r1Yip3T8xvnhh+
 MPxc1KsIRXmXoUgOaqoO8HytGTe1LNHbwPd/lADCgUS+IGi1pzlmIl/VJGldoL/4xxJ2
 Y2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339189; x=1773943989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edNAiRfPbXPwD453S8uzDSvl80eW60e4QXb8HLWNFmk=;
 b=OW+EjKOv0jBSCR9YO425l1wOkw043dwnK0yLL9UjkUsJRFi3nJ7IxzHyahb+EzaAT3
 MRKsKM1VoJcH0gaNmQdHgy7iH9PdEy59RyL//1NO96TpswyZ34nP7SJXp7+/ooWpfi05
 WDACwdh7IczMZaF+ZaMCwFJdBNNS+noDOM6bYi090IwIh/Wf0NQ9VLEn65i/vSAgs4h+
 SsbrOes2m2GoNyyenxynZrIEahgMy94lgXQBzgpfycvbqghXLt5EUysQp/EoHmpbG5FE
 HYS5BloFDh/Yw2TPg+CupUT2/faJtPXkIpxvWac5NzNYCe3nyKiGx6GB7/BJ5TiGEt5c
 Hplg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyB0ZSMmeoQXNiIvdJCtnrsHCwzaGo8lK2w2ywGtbk4usAAW0IQH+UBpjcymt7tsEh59CJrcRiOjcK@nongnu.org
X-Gm-Message-State: AOJu0YyOq62NII/z3qxlQXfWnUjiTJjK+oerOzXrlN3qB9ZoQFoQuqnG
 5/6GYJtaEXduIgUXj+UIm8fphIaUsnSYRzb8WLU9V4yiu//LBRZaVHZeiwVoj73w1LXy122c51e
 0cpJCX+6N0NB6HaCaeHcuhCb/3jt3C0YHkFb/kuTrSgvfWwqDXT6Oc++f
X-Gm-Gg: ATEYQzwqCxewOK5RNXO/l8ZFrivjTrsPt0Faejm+xvx+KQWT6i+1JHI2DX4MDbHB0sX
 YUUCrYVEDh82T0nZcZe8bzD2wmzbxtFA7QcVkhT2j4WaOD5ViG/lqYEgfaK0vKfBvTRIoRMwCEa
 LcKcO/jYRz4+M/B+Rmnx3xU6JOF5BFOho+epGt2cddvWreGBdV2mPfTyOgI4GVHR6ioAGdCj91+
 D7efFswIUc3Y0on8jfiiOdSfzBumvhqArEz56w64vSFsffoE9d+YskhiuLiewPbNmxh/+NqChxP
 789CrPYz8Xjtr0TmxFSCVrgmRZcNXX1G3bAs/rc1xtzFuGi/eOmw0BB/mh3Zu//OJi1OOhHuGeZ
 M4fCTfF/iVvPJ3A==
X-Received: by 2002:a05:620a:1993:b0:8cd:94a5:2f32 with SMTP id
 af79cd13be357-8cdb5a6f0e4mr96566085a.27.1773339189076; 
 Thu, 12 Mar 2026 11:13:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1993:b0:8cd:94a5:2f32 with SMTP id
 af79cd13be357-8cdb5a6f0e4mr96562985a.27.1773339188595; 
 Thu, 12 Mar 2026 11:13:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21348e2sm386736785a.35.2026.03.12.11.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:13:08 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:13:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <abMCMrRxdAWCc_hv@x1.local>
References: <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
 <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
 <abLc_ppEEbKjNRUi@x1.local>
 <022c929e-ddda-4f74-8786-d01994107415@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <022c929e-ddda-4f74-8786-d01994107415@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 07:34:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hmm. Probably, that this is the subsection, that exist only in our downstream.
> I don't know, was it mentioned clearly before, sorry if not.

Ah.. Looks like it was not mentioned in the latest version posted:

https://lore.kernel.org/all/20260312102626.891359-1-dtalexundeer@yandex-team.ru/

Let's always mention this, because it's important piece of info, e.g. to
know upstream has yet no reproducer.

> This subsection just not exist in master, and we are not going to upstream it.
> So, for upstream it's a "theoretical" bug in a protocol, which may be triggered in
> some future moment. And that's why there is not specific case in commit message
> but only assumption "Let's say there is a vmstate ...".

In this case, for upstream we almost only lose but yet unknown gain with
this fix then, because we stop throwing useful info for unknown new
subsections, as PeterM pointed out:

https://lore.kernel.org/all/CAFEAcA_mzXDdz_xjPnZ9Kc4K01Aoss_OH_qEoL3G33KdsnHrLw@mail.gmail.com/

But I agree it is a potential issue, if we cannot justify QEMU can never
hit it.

Sending "how many subsections are there" is one viable option as you said,
but it only solves this small problem, and knowing that number requires src
QEMU looping over the subsections twice so a bit awkward (first time we
need to kickoff ".needed()" hooks to do the counting; not all will be sent).

The other way is to provide level information somehow in the stream.

Say, we could attach START/END markers for each VMSD to be dumped.  That
may be able to help in other cases too, e.g. when we accidentally grow some
VMSD fields breaking migration, then IIUC dest QEMU can provide a more
accurate error message when it knows the bound of current VMSD that is
being loaded.

But I'm also not sure if this is worth it yet to fix an imaginary problem.

-- 
Peter Xu


