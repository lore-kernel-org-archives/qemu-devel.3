Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F6CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 16:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruxWI-0000lo-Te; Thu, 11 Apr 2024 12:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruxWH-0000la-V0
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 12:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruxWG-0007cF-9y
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 12:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712853803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhQQr7IyTzlV1rrPa7Qul8/JxVFgKpzwRH4Uh3r/XbQ=;
 b=jLWwzNoYLfOqZlaFVdxcM1T+x1R274LQsAfG4J6XhfVUz1bwTscMTucREXkXielI27x6RH
 5iHa+wcZk4e/prlX7MfqjO/gcWB0CJjMoPdUDqoOu5mt5SInH2fL+kCdOG1ZQf7R+l47u2
 2289XI1pwNv8NvclvUVtfGFLZAfzRTk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-9GvrOztIPk23AaEifnO3iA-1; Thu, 11 Apr 2024 12:43:20 -0400
X-MC-Unique: 9GvrOztIPk23AaEifnO3iA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343f08542f8so4415791f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712853799; x=1713458599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhQQr7IyTzlV1rrPa7Qul8/JxVFgKpzwRH4Uh3r/XbQ=;
 b=HHMMsJq/a/M4TaQJJMXivQtPG/VT8MI+YIYUx7iFyYTt9jWg7folT6mpbMMt2dfsUU
 I23ZnFg6teUSFTcJZ8Li1SgazqG/o1JpYMuw3EK3XJEkWUrrpy5iAvU/4evnTjwZOcfh
 21bH6PB+WeCjbJYHCt4Gmm5zjMDFcnUBPswgDUoRfssDt0lmRSHnhAqyb09LyY2iLh/9
 6MYcm9N/yU+I+a5BRi4trg3awXX8MQf85u/XOZIdNYk16fGKJBJwcKq3/YX5otJaDVCA
 fwlP4URGwaW3bMRIp5ucMrj7fki+Vapt3N/3P7rpI9akvEnhpuhILX4J2NUYHkpJvm8X
 P0qw==
X-Gm-Message-State: AOJu0Yyxh4WGM69x4Fd5CLUG+QbvPz6ttPLG4zy/1QkmvutbOlPZOLOf
 6+ladSfoFJOAHWq5ZJRNqo6Yccc83Q2afrD1aAKRvWP3m0arXeRCyf/VZuGWi3Jj2K3M0CldrPd
 rbti7C63AaBoVyUApZ/fMHBaU5+g1oSzzLfOAPT4ub5RZus7MR5f9F9suAVXyMghzRdfldJne8b
 BHYLO0qzdiSb4wd0z0sdkdGOFBQYVe73unhY8=
X-Received: by 2002:a5d:47a2:0:b0:343:71c2:287e with SMTP id
 2-20020a5d47a2000000b0034371c2287emr67054wrb.59.1712853798790; 
 Thu, 11 Apr 2024 09:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZJPURLAk7Z95XmuRTvjeu02bHNx3wDBlYf+Lkp7i+Navw0Cvrj50VrG/G1T6bKMr0i7JHxUEhFr/oMOVAPaM=
X-Received: by 2002:a5d:47a2:0:b0:343:71c2:287e with SMTP id
 2-20020a5d47a2000000b0034371c2287emr67041wrb.59.1712853798449; Thu, 11 Apr
 2024 09:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
 <Zhf/czBP8LaaGORr@intel.com>
In-Reply-To: <Zhf/czBP8LaaGORr@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 18:43:00 +0200
Message-ID: <CABgObfYvN98O6ifLtrRyC10_+6e3nzeED2O7o+2jGXrg2dcBBw@mail.gmail.com>
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Thu, Apr 11, 2024 at 5:05=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> On Tue, Apr 09, 2024 at 06:43:13PM +0200, Paolo Bonzini wrote:
> > Date: Tue,  9 Apr 2024 18:43:13 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
> >  decoder
> > X-Mailer: git-send-email 2.44.0
> >
> > Compared to the old decoder, the main differences in translation
> > are for the little-used ARPL instruction.  IMUL is adjusted a bit
> > to share more code to produce flags, but is otherwise very similar.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  target/i386/tcg/decode-new.h     |   2 +
> >  target/i386/tcg/translate.c      |   9 +-
> >  target/i386/tcg/decode-new.c.inc | 171 +++++++++++++++++
> >  target/i386/tcg/emit.c.inc       | 317 +++++++++++++++++++++++++++++++
> >  4 files changed, 497 insertions(+), 2 deletions(-)
>
> HMM, I met Guest boot failure on this patch because of ata unrecognized.
> I haven't located the exact error yet, so let me post my log first.
> If there are other means I can use to dig further, I'd be happy to try
> that too.
>
> # Command (boot a ubuntu Guest via TCG)
>
> ./qemu/build/qemu-system-x86_64 \
> -smp 1 \
> -name ubuntu -m 4G \
> -cpu max -accel tcg \
> -hda ../img_qemu/test.qcow2 -nographic \
> -kernel ../img_qemu/kernel/vmlinuz-6.4.0-rc6+ \
> -initrd ../img_qemu/kernel/initrd.img-6.4.0-rc6+ \
> -append "root=3D/dev/sda ro console=3DttyS0" \
> -qmp unix:/tmp/qmp-sock,server=3Don,wait=3Doff

I did run a bunch of boot tests but I'll check this one too.

Thanks!

Paolo


