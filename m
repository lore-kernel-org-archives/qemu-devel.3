Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F68EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 19:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdxTH-0005ou-3q; Tue, 13 Aug 2024 15:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdxTG-0005oP-0C
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdxTE-00015K-I2
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723578374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hOQW1bo3800LACsO6zbK6WIEbmkoNuyCxGIAh7tVsKU=;
 b=aGqPNGJGdUYviuRcQuoTDHxFE3WFSaAqLeaHotmNK7KufJnBqsmEtMkZmdwyJPyP4uYo+E
 3AjVcK1DYTDcnSGVgdzAyHhgrDX0zSWCZP1/s5SY6cL50E5JSAI9PdrgzDMotTazFMrTc6
 AfEfmdA/c83k16drXgzDZk/bvbNWGsQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-njqxElm_PYaOGz9ElA2Tfw-1; Tue, 13 Aug 2024 15:46:13 -0400
X-MC-Unique: njqxElm_PYaOGz9ElA2Tfw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7093752a9f5so1063083a34.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 12:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723578372; x=1724183172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOQW1bo3800LACsO6zbK6WIEbmkoNuyCxGIAh7tVsKU=;
 b=cSIDx40UPtkJsRWPTmW5kze3rqZO1Z302w+FtXZu5tgQoeTyJdZDkzUCVe8NG9Fxhq
 u4nW+/fh66Vrd8ythbsCAWnV8fdJtiXC1pfa2DtqgaahZgnojVPsO/AOutmWk9XthDPM
 NMbKCvdj2Etz7s0EgMApONWZaISJWdnwEX/GLVkpf0mbs+xkd7F8Z+L350TEWAvt0uFW
 41glkycwp6gTpQ/nIO4vuTY/x2koIY+43ryEYkLFsZLr7OPreLVq35KcI7L/ffEdVGmB
 MY8292oWbiL3iqKMa2zOpqUV/oc8Vp6ab52cs/pHhX7WFnhj+O5E6y1Ei1HY/y5H7Unu
 GO7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc0f0dGM9W2+GBrQSdaqoM1oL5+UyTZBLXjqxiHFCe8xWhjowse9JiLBYqfsruFGcWWzzL8XcSfavz@nongnu.org
X-Gm-Message-State: AOJu0YwC7544dJOJRahy/2sQRX35N+r7GbjIxHr+COYe1mcYMuqVIzQv
 ssc+YVoG7qkduwXxVaUGolmNKA/BOFKTDiioU0bmquxa3lAVGheI7oGmaCbybyUW5LirCjYw9c/
 ylsuBqh22bTFStSNizT4CJyN72VMOR4kQ2ex9abk/pEA4IMLcZtpt
X-Received: by 2002:a05:6808:3713:b0:3db:427d:7da0 with SMTP id
 5614622812f47-3dd297de0eemr229509b6e.2.1723578372279; 
 Tue, 13 Aug 2024 12:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWSHjY12Avlz9OxZQBUTx+UbdvuVihwRint/Tz/tkok8U0qQ5i46z999mYKpaE//Qhsh4C/A==
X-Received: by 2002:a05:6808:3713:b0:3db:427d:7da0 with SMTP id
 5614622812f47-3dd297de0eemr229494b6e.2.1723578371884; 
 Tue, 13 Aug 2024 12:46:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4531c1c532asm35029581cf.30.2024.08.13.12.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 12:46:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:46:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zru4AaTmBIAGnyDr@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > The flipside, however, is that localhost migration via 2 separate QEMU
> > processes has issues where both QEMUs want to be opening the very same
> > file, and only 1 of them can ever have them open.

I thought we used to have similar issue with block devices, but I assume
it's solved for years (and whoever owns it will take proper file lock,
IIRC, and QEMU migration should properly serialize the time window on who's
going to take the file lock).

Maybe this is about something else?

> 
> Indeed, and "files" includes unix domain sockets.  Network ports also conflict.
> cpr-exec avoids such problems, and is one of the advantages of the method that
> I forgot to promote.

I was thinking that's fine, as the host ports should be the backend of the
VM ports only anyway so they don't need to be identical on both sides?

IOW, my understanding is it's the guest IP/ports/... which should still be
stable across migrations, where the host ports can be different as long as
the host ports can forward guest port messages correctly?

Thanks,

-- 
Peter Xu


