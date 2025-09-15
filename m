Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05522CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFqx-0000sl-Sr; Mon, 15 Sep 2025 16:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFqs-0000s4-S7
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFqe-00011k-I4
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757968246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JE/4b6x6MwwvsB/R33aefbk4Yj2nR47ofv9+CGCdWM0=;
 b=iYyRxQU1FELYHY4fnPuNX4cUE3rWvA8ZiCLI0PWQ0F+k/i1BBRHxjPvKwNwDC+fjMJ5AAq
 iAtemp4uCNjTB/k5O8Pins7OgX/WXReMmLLbJA2iveckC9frT7WT4oxgHRds0+rKMJcj4u
 nHTwRLFWT8JSDDO1VY29/OuCdsi4FQU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-YnWHMmVtP7mK4xEmuCSLtA-1; Mon, 15 Sep 2025 16:30:45 -0400
X-MC-Unique: YnWHMmVtP7mK4xEmuCSLtA-1
X-Mimecast-MFC-AGG-ID: YnWHMmVtP7mK4xEmuCSLtA_1757968244
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-814370a9f58so992106885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 13:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757968244; x=1758573044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE/4b6x6MwwvsB/R33aefbk4Yj2nR47ofv9+CGCdWM0=;
 b=uLBGMLrFZ5DKLkzR949w87ObZDGLYyk7ZJ3je1YRZkeidMvX92vQn07YJSMxxcdD2L
 +RDBBjivs+ZKP/28j8Lk64uVDAkryO6chPIjZD6cyLsZOM0DM+PgbbPcUT5dtrk1fj9I
 yaXcnm4MnOeSzeYGZrRwymXvgc1OAyvquBQ7dgl3CPYix+F6zRgp3d4C6xQBD6+zwAPr
 5NCYlmimHH1yagJK3Cidf+fnyqTvhNPUDaI9McjsVY9m5NELH4zKjWIalaIqrE/3pz86
 Ug3boRmsGUk68LkB7yWoeM+BLvogTX/R1f50EE/xXS2QZZ7aMFx99kiTSU7SRMpnEx44
 KkXA==
X-Gm-Message-State: AOJu0YzwOqcYmUJIp7YZOdOc9b3hCCYFTOZai8MIeUqH6EvH2nFKWgGJ
 S73cdKVnq470CUb4xmays/i4MTrnPUuXFRwrJZFw6wh73ifN/+FhUklIc6bqrD2dkaqbAwEZ0Cm
 g+4HjZT5C5y1iq17xxz/vxbhs/cvnpsH+iI7Wn+t/0S5j/Xq8J2BK+1oZ
X-Gm-Gg: ASbGnctcj88uJoXH5ZrRXXiojytZoTTl/zX7KtQeeUX5CHc2NWyK6+eJoIWVtNmIKbG
 6BdJ5d7GPe49SfJ41lJxPsxtvfSM1WMs+DcWzZpJ32fbsHDxWIBXV4B7ENeQMMxHnaFYFqKqA8J
 pn8KRxrh4LL2KkKgmzwHxLz1nYTaI/v93bSIMRb2hiTxNj+ybBsRGs6KRyKYrJNjQrJczP6m4kF
 wqHoxeNHdgs5HNr9N903u5krRdQsEq7/Xo7q5vJ8Dp8C79eL2nJS2kuAZBNFQos04Vj0LopF83P
 WKa/MWfMsKGt+LSwByg+7fFclaPrtPVk
X-Received: by 2002:a05:620a:4045:b0:811:cf4:a1f3 with SMTP id
 af79cd13be357-823feb3c056mr1212008385a.38.1757968244399; 
 Mon, 15 Sep 2025 13:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Gm8E4e60ZH/gE/UTHgQ008U/fRk6+qf2A5VtKrX/sg0Y2uRvDYM/dcEzpf76YP+8BulqxQ==
X-Received: by 2002:a05:620a:4045:b0:811:cf4:a1f3 with SMTP id
 af79cd13be357-823feb3c056mr1212005285a.38.1757968243908; 
 Mon, 15 Sep 2025 13:30:43 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763b549866dsm82763426d6.19.2025.09.15.13.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 13:30:43 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:30:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
Message-ID: <aMh3ZfUQ3Ksjn56e@x1.local>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <aMHidDl1tdx-2G4e@x1.local>
 <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNBJF9E4BYrWEHO@x1.local>
 <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
 <aMSQDuVacnSG3MTV@x1.local>
 <04eac866-74ea-46ae-9170-aa3ad5fc1b11@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04eac866-74ea-46ae-9170-aa3ad5fc1b11@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, Sep 14, 2025 at 06:06:44PM +0900, Akihiko Odaki wrote:
> It makes sense to have a through review, but my argument here is the
> de-duplication of object_unparent() and the replacement of g_free() with
> object_new() are logically distinct and should be split into distinct
> patches. Each patch can independently have through review, be
> applied/backported, or be reverted in case of regression.

We're discussing a change in the memory.rst on suggested way to use dynamic
MRs, so I think we can do it in one shot rather than making it confusing.
It's not a huge change even in one go.

It's fine.  You're right we can remove the object_unparent() first when
it's always a no-op.  We'll update the doc twice, though I assume it's fine.

If you would, please consider sending this part as a separate series.

The subject should be something like "remove unnecessary object_unparent()
for dynamic MRs" or something like that.  It has nothing to do with
memleaks on this part.

Please cover tests as much as possible and if we touch the doc we need to
convert everything that uses dynamic MRs, including the missing ones in
VFIO, and also the rest occurances.

Thanks,

-- 
Peter Xu


