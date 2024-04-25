Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC95C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzxYe-0004mY-87; Thu, 25 Apr 2024 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzxYS-0004k9-3X
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzxYP-000146-CH
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714045575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLU3wnXBRRnexax+zdlJubZFQzgUnqmGi6oUkZ+aOaE=;
 b=SSa3p60QQazvXFHSxoYIphnW5TJldVVJr+r2dXMjf0L4Qu3l+e6V+tbnEKsXblQhQ9mK5i
 chnxu1NHHiyqnLdHkb657MaOjcEj0AyI5xx5WDj7nIqArE58kdz9P1dfYsG7efPX0Gi1+X
 QbpTe3j6rGM0V7HqiJfs0tVtPYjbaWA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-loxAz4CIP0-4aRv28stmEw-1; Thu, 25 Apr 2024 07:46:13 -0400
X-MC-Unique: loxAz4CIP0-4aRv28stmEw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5aa3c655dacso1294114eaf.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714045573; x=1714650373;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uLU3wnXBRRnexax+zdlJubZFQzgUnqmGi6oUkZ+aOaE=;
 b=vweXQocAR/UQWzsEAWLxrqPThMRqLesOAV0zbpHaLMkKd9nBSTt8WkPZ/2VdRH3NdL
 v9/sLcQ7ybIXDwd1QvTedL5nYaLRJbc0UYzaNcisma2bJu2rJQbmkOv8KVuG8l9p4i12
 IP/5e8c//wtFhzHBTRfk8o62sQnwbaWs8REg58ErEZdCnSZ3W4RvMCH0S6nKSPK4YfOO
 cAoLZ1Zc+mEmwFBB7xKFlbk6ncFBUvUlLmsFlT3AzYkIePXwvoNkN1cpbkWjVsRC9p7y
 25fu0bMtcevlVDmAL7nCyuNohRf69HeuWCTcCL+qN8rEPhAYD8N3D4qQtNmWotd6kBpF
 q5bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxZ3/baRvYVYm1loAFpfa44BDNY5cjIYV6wSq5jxLD5Mexgz9afvYGXevQc9AUMR+wZ5Xpw7qIqNxQKzCsT9zjZISH1M8=
X-Gm-Message-State: AOJu0Yzhzxyx9DvAQ8VHBxlVUvZP85Zt0DUmR12vN0+B21IdO5EMaXZ3
 nAvXclTWlPOW6HBX6/OS04P6QvIPdOId/mFtmdFkmNJPYB3D8bywPe9sG/mMSyEELwo9Gcb0Cxt
 Ag9CB+W1BIcwmhBMeCWojpatQseNKunQrRC8sBEtHm1lPZ7KBoptS
X-Received: by 2002:a05:6358:722:b0:18d:9d25:725e with SMTP id
 e34-20020a056358072200b0018d9d25725emr5084662rwj.16.1714045572814; 
 Thu, 25 Apr 2024 04:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZqY8L/cgiTipwyW3uM25QvT9ODCfSW2ReoLgWWmTMLKGLeCu6Prgc/L7HbdcDZF5EHj+95w==
X-Received: by 2002:a05:6358:722:b0:18d:9d25:725e with SMTP id
 e34-20020a056358072200b0018d9d25725emr5084635rwj.16.1714045572170; 
 Thu, 25 Apr 2024 04:46:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
 by smtp.gmail.com with ESMTPSA id
 i15-20020ac8488f000000b00436a8ee913csm6904617qtq.41.2024.04.25.04.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 04:46:11 -0700 (PDT)
Date: Thu, 25 Apr 2024 07:46:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Message-ID: <20240425074521-mutt-send-email-mst@kernel.org>
References: <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
 <20240425062213-mutt-send-email-mst@kernel.org>
 <CAAjaMXYTGUUeABd+Ghaf374pOFjoF7RdncTTiciLhmo1yXXZVQ@mail.gmail.com>
 <f85ab427-9cb4-4034-8fd7-29acc4d0b8a9@ilande.co.uk>
 <fab578a2-42a2-4963-be4f-8cbb73e11404@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fab578a2-42a2-4963-be4f-8cbb73e11404@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

On Thu, Apr 25, 2024 at 01:15:43PM +0200, Philippe Mathieu-Daudé wrote:
> On 25/4/24 12:40, Mark Cave-Ayland wrote:
> > On 25/04/2024 11:26, Manos Pitsidianakis wrote:
> > 
> > > On Thu, 25 Apr 2024 at 13:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > 
> > > > On Thu, Apr 25, 2024 at 01:04:31PM +0300, Manos Pitsidianakis wrote:
> > > > > On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
> > > > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > > > > 
> > > > > > On 25/04/2024 07:30, Manos Pitsidianakis wrote:
> > > > > > 
> > > > > > > On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
> > > > > > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > > > > > > 
> > > > > > > > On 23/04/2024 12:05, Philippe Mathieu-Daudé wrote:
> > > > > > > > 
> > > > > > > > > On 23/4/24 11:18, Manos Pitsidianakis wrote:
> > > > > > > > > > On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> > > > > > > > > > <manos.pitsidianakis@linaro.org> wrote:
> > > > > > > > > > > 
> > > > > > > > > > > On Tue, 23 Apr 2024 at 00:11,
> > > > > > > > > > > Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > > > wrote:
> > > > > > > > > > > > 
> > > > > > > > > > > > On Mon, Apr 22, 2024 at
> > > > > > > > > > > > 11:07:21PM +0200, Philippe
> > > > > > > > > > > > Mathieu-Daudé wrote:
> > > > > > > > > > > > > On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > > > > > > > > > > > > > On Mon, Apr 22, 2024 at
> > > > > > > > > > > > > > 04:20:56PM +0200,
> > > > > > > > > > > > > > Philippe Mathieu-Daudé
> > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > Since VirtIO devices can change endianness at runtime,
> > > > > > > > > > > > > > > we need to use the device endianness, not the target
> > > > > > > > > > > > > > > one.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Cc: qemu-stable@nongnu.org
> > > > > > > > > > > > > > > Fixes: eb9ad377bb
> > > > > > > > > > > > > > > ("virtio-sound:
> > > > > > > > > > > > > > > handle control
> > > > > > > > > > > > > > > messages and
> > > > > > > > > > > > > > > streams")
> > > > > > > > > > > > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > This is all completely
> > > > > > > > > > > > > > bogus. Virtio SND is
> > > > > > > > > > > > > > from Virtio 1.0 only.
> > > > > > > > > > > > > > It is unconditionally little endian.
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > This part of the code is for PCM
> > > > > > > > > > > frames (raw bytes), not virtio spec
> > > > > > > > > > > fields (which indeed must be LE in modern VIRTIO).
> > > > > > > > > > 
> > > > > > > > > > Thought a little more about it. We
> > > > > > > > > > should keep the target's endianness
> > > > > > > > > > here, if it's mutable then we should
> > > > > > > > > > query the machine the device is
> > > > > > > > > > attached to somehow. the virtio device
> > > > > > > > > > should never change endianness
> > > > > > > > > > like Michael says since it's not legacy.
> > > > > > > > > 
> > > > > > > > > Grr. So as Richard suggested, this need to be pass as a device
> > > > > > > > > property then.
> > > > > > > > > (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)
> > > > > > > > 
> > > > > > > > It feels to me that the endianness is something
> > > > > > > > that should be negotiated as part of
> > > > > > > > the frame format, since the endianness of the
> > > > > > > > audio hardware can be different from
> > > > > > > > that of the CPU (think PReP machines where it
> > > > > > > > was common that a big endian CPU is
> > > > > > > > driving little endian hardware as found on x86).
> > > > > > > 
> > > > > > > But that is the job of the hardware drivers, isn't it? Here we are
> > > > > > > taking frames passed from the guest to its virtio
> > > > > > > driver in the format
> > > > > > > specified in the target cpu's endianness and QEMU as
> > > > > > > the device passes
> > > > > > > it to host ALSA/Pipewire/etc which in turn passes it to the actual
> > > > > > > audio hardware driver..
> > > > > > 
> > > > > > The problem is that the notion of target CPU endian is
> > > > > > not fixed. For example the
> > > > > > PowerPC CPU starts off in big-endian mode, but these
> > > > > > days most systems will switch
> > > > > > the CPU to little-endian mode on startup to run ppc64le.
> > > > > > There's also the ILE bit
> > > > > > which can be configured so that a big-endian PowerPC CPU
> > > > > > can dynamically switch to
> > > > > > little-endian mode when processing an interrupt, so you
> > > > > > could potentially end up with
> > > > > > either depending upon the current mode of the CPU.
> > > > > > 
> > > > > > These are the kinds of issues that led to the later
> > > > > > virtio specifications simply
> > > > > > using little-endian for everything, since then there is
> > > > > > zero ambiguity over what
> > > > > > endian is required for the virtio configuration space accesses.
> > > > > > 
> > > > > > It feels to me that assuming a target CPU endian is
> > > > > > fixed for the PCM frame formats
> > > > > > is simply repeating the mistakes of the past - and even
> > > > > > the fact that we are
> > > > > > discussing this within this thread suggests that at a
> > > > > > very minimum the virtio-snd
> > > > > > specification needs to be updated to clarify the byte
> > > > > > ordering of the PCM frame formats.
> > > > > > 
> > > > > > 
> > > > > > ATB,
> > > > > > 
> > > > > > Mark.
> > > > > > 
> > > > > 
> > > > > 
> > > > > Agreed, I think we are saying approximately the same thing here.
> > > > > 
> > > > >   We need a mechanism to retrieve the vCPUs endianness and a way to
> > > > > notify subscribed devices when it changes.
> > > > 
> > > > I don't think I agree, it's not the same thing.
> > > > Guest should just convert and send data in LE format.
> > > > Host should then convert from LE format.
> > > > Target endian-ness does not come into it.
> > > 
> > > That's not in the VIRTIO 1.2 spec. We are talking about supporting
> > > things as they currently stand, not as they could have been.
> > 
> > Can you also clarify the particular case that you're trying to fix - is
> > it big-endian on ARM, or something else?
> 
> I'm only aware of big-endian on ARM.
> 
> Regards,
> 
> Phil.

But of course this applies to any BE emulated on LE
or vice versa.

-- 
MST


