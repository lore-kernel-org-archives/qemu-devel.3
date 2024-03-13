Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870DFC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkILT-0002vw-6V; Wed, 13 Mar 2024 02:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkILJ-0002tv-OR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkILI-0007co-9S
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710312238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx4EM9JMYrPj7CF22F6uCP0VZeb2Af2fb7imMmp9nUA=;
 b=I4LDVJtfzl/hJf8ISw+afAkxxeG89DxL2Y9vFHkJwd5RNh/EDsfPTS8M4XxxMDyYJl0OJ0
 R/MHiqlHe9VWLdvNk17CKU98p6RqiJf0711AAoYV8I7JSbRRaEJDHAXQGjMVJPNonDLGMX
 v4VT7O69jDq6Xj/GSs6gOXhSCDVQekM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-NUgMG3w-OrmVUKTI0TZQLA-1; Wed, 13 Mar 2024 02:43:57 -0400
X-MC-Unique: NUgMG3w-OrmVUKTI0TZQLA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a1def46ac7so3436195eaf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312236; x=1710917036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yx4EM9JMYrPj7CF22F6uCP0VZeb2Af2fb7imMmp9nUA=;
 b=rY7MZAtSvv6vGlbW8Tou8pVMh8BLR2VHdbZXoEq/8QbPZe4/S0qq/oiQI0lruiNnT6
 2tJFPEUfC0bb0BWuoPKviL6otrc1LSFecu4eYCad6KvUiZhJMZ+Cls5wg8I8gawWo9IN
 CzkBAXRmQ+VqdglXR5E9HGU+36AAh9GyUeXmOivgRzXw/eRHeMnf9FBfSUL9Yxx1WvrX
 u1D68bvVCQtv/vp4B8tb7S+GNkNpwlDNZslMPBNoC8fUEIEvgtbBaIL903gEFcrpiZYu
 LMMwCjMPmWgIDYVYQKs4P+wl1C7+/QfWp94iuADBSo0dXAwRTYWnLvy8Uo/ey3Cd1+ok
 5H+g==
X-Gm-Message-State: AOJu0Yx5nQFGKFTO0nWNNHXdqcbERstKMeSHXgM/a4CIp3huCXR8e4vw
 QpYyH+O7oF2HGXt6jtldrJmNuvFMaPtu8Jzn9iVsSnZUOwd7pPK0VJoPcoGKscg/1SKCROmrdXz
 Yh1yHwEyvYNDQCgwGiBPHR27XfIQ5nQ9C15MDTks08r5auXtJdr9TcqBDOs+tTP4Yo2gn1cSDqh
 4J+k0j+l81Q2ep+w30bcXhBb25psY=
X-Received: by 2002:a05:6358:5482:b0:17e:6dd9:d7d1 with SMTP id
 v2-20020a056358548200b0017e6dd9d7d1mr3090342rwe.31.1710312236333; 
 Tue, 12 Mar 2024 23:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3SiCRdNvChk6iJSjRjUvgKwfz67VjGvX8X9DzqqJrFthDP6qTZssccfPyuzQ23UL7Uuw6q/3NGhjjGU7mcc=
X-Received: by 2002:a05:6358:5482:b0:17e:6dd9:d7d1 with SMTP id
 v2-20020a056358548200b0017e6dd9d7d1mr3090330rwe.31.1710312235994; Tue, 12 Mar
 2024 23:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240312113642.36862-1-jasowang@redhat.com>
 <c10c6ec3-faaa-4e1a-bfb6-41eea38fdcb2@tls.msk.ru>
In-Reply-To: <c10c6ec3-faaa-4e1a-bfb6-41eea38fdcb2@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Mar 2024 14:43:44 +0800
Message-ID: <CACGkMEtvUHmbKCvNPauTnUR7+fXctwOVYxo45P3TZR7yEPsVsA@mail.gmail.com>
Subject: Re: [PULL 0/8] Net patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Nick Briggs <nicholas.h.briggs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 13, 2024 at 1:56=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 12.03.2024 14:36, Jason Wang wrote:
> ...
> > ----------------------------------------------------------------
> > Andrew Melnychenko (5):
> >        ebpf: Added eBPF map update through mmap.
> >        ebpf: Added eBPF initialization by fds.
> >        virtio-net: Added property to load eBPF RSS with fds.
> >        qmp: Added new command to retrieve eBPF blob.
> >        ebpf: Updated eBPF program and skeleton.
> >
> > Laurent Vivier (2):
> >        igb: fix link state on resume
> >        e1000e: fix link state on resume
> >
> > Nick Briggs (1):
> >        Avoid unaligned fetch in ladr_match()
>
>  From the above, I'm picking up igb & e100e "fix link state on resume"
> and "Avoid unaligned fetch in ladr_match()" for stable.
>
> Please let me know if this is incorrect.
>

It's correct.

Thanks

> Thanks,
>
> /mjt
>


